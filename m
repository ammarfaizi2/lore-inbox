Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVAXJru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVAXJru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 04:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVAXJru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 04:47:50 -0500
Received: from asplinux.ru ([195.133.213.194]:1805 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261324AbVAXJrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 04:47:13 -0500
Message-ID: <41F4C51F.2070908@sw.ru>
Date: Mon, 24 Jan 2005 12:51:27 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Seth, Rohit" <rohit.seth@intel.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andrey Savochkin <saw@sawoct.com>, linux-kernel@vger.kernel.org
Subject: Re: possible CPU bug and request for Intel contacts
References: <01EF044AAEE12F4BAAD955CB7506494302E283BF@scsmsx401.amr.corp.intel.com>
In-Reply-To: <01EF044AAEE12F4BAAD955CB7506494302E283BF@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rohit,

> Thanks for sending the detailed information. Based on our experiments
> and analysis, we believe at this point that this is a known E80 issue
> mentioned in the PIII spec update at this location
> (http://www.intel.com/design/pentiumiii/specupdt/24445351.pdf)

> Could you please try one of the suggested work arounds for this issue.  
Yes, double cr3 reload and cpuid helps us. But rdtsc doesn't.

BTW, can you explain why making pages non-global is the cure? Is it safe 
  workaround for this bug?
Double cr3 reload looks a bit unsafe to me, since interrupts or NMI can 
occur between the reloads and probably reuse stale iTLB mappings... But 
I'm not sure about this since it is much harder to catch and I have no 
access to CPU internals. What is your opinion about this?

Sorry for taking your time, I should have checked ERRATAs more 
attentively myself.

Thank you,
Kirill

>>Hello,
>>
>>Here are the details about CPU bug I mentioned in my previous post.
>>Though it turned out later that it happens on P-III systems only I
>>still 
>>hope it can be of interest.
>>
>>Brief description
>>~~~~~~~~~~~~~~~~~
>>
>>This issue was found by Vasily Averin (vvs@sw.ru) when playing
>>with uselib security exploit on kernels with my 4gb split patch.
>>
>>This bug results in strange effects such as calltraces below,
>>reboots, impossible call traces and so on.
>>
>>I started to resolve the bug, narrowed down uselib exploit and
>>got a simple testcase for the bug, which can be found in attach.
>>This testcase does a simple thing - it maps pages at low addresses
>>from 0x04000000 downto 0x00000000, page by page and touches them
>>for write. Sometimes when running this exploit I got oopses,
>>sometimes reboots and I found that this is sensitive to the page
>>addresses which exploit maps.
>>
>>Why it crashes? I think this is due to virtual addresses of
>>kernel code and mapped user space pages overlap. I was able even to
>>reboot machine if mapped user space pages were filled with some
>>appropriate asm code.
>>
>>I found that Ingo Molnar 4gb split is not vulnerable, and after
>>investigations I found that Ingo patch doesn't map kernel entry code
>>(trampline) as _PAGE_GLOBAL. This was the answer.
>>
>>I tested it on 4 different P-III machines - all of them were
>>vulnerable. 
>>But lately I tested it on Celeron 2.4Ghz and P4 systems - it doesn't
>>happen, so this bug can be of low interest to Intel people :(
>>
>>Below you can find the way how to reproduce the bug, call traces
>>and why I think it's a hardware bug.
>>
>>How to reproduce a bug
>>~~~~~~~~~~~~~~~~~~~~~~
>>
>>- take any FedoraCore kernel with Ingo Molnar 4gb split patch
>>   or mainstream kernel and apply 4GB split patch
>>- apply attached diff-arch-4gb-global patch to make
>>   trampline code to be GLOBAL
>>- compile kernel with turned on 4gb split, i.e. CONFIG_X86_4GB=y
>>- boot the kernel and run the attached testcase:
>>
>># while true; do ./4gbtest; done;
>>
>>or
>>
>># ./elflbl -l ./lib -a 0x4000000  (where elflbl is uselib exploit)
>>
>>During each 4-5 test runs I get the following oops:
>>
>>Jan 21 12:15:17 ts Unable to handle kernel NULL pointer dereference at
>>virtual address 000000c0
>>Jan 21 12:15:17 ts  printing eip:
>>Jan 21 12:15:17 ts 02114450
>>Jan 21 12:15:17 ts *pde = 00000000
>>Jan 21 12:15:17 ts Oops: 0002
>>Jan 21 12:15:17 ts SMP
>>Jan 21 12:15:17 ts Modules linked in:
>>Jan 21 12:15:17 ts CPU:    0
>>Jan 21 12:15:17 ts EIP:    0060:[<02114450>]    Not tainted
>>Jan 21 12:15:17 ts EFLAGS: 00010246   (2.6.8-dev)
>>Jan 21 12:15:17 ts EIP is at sys_mmap2+0x0/0xb0
>>Jan 21 12:15:17 ts eax: 000000c0   ebx: 31524fc4   ecx: 00001000  
>>edx: 004ec000
>>Jan 21 12:15:17 ts esi: 00000032   edi: 00000000   ebp: 31524000  
>>esp: 31524fc0
>>Jan 21 12:15:17 ts ds: 007b   es: 007b   ss: 0068
>>Jan 21 12:15:17 ts Process test (pid: 25, threadinfo=31524000
>>task=31f680c0) Jan 21 12:15:17 ts Stack: fffec200 01a2a000 00001000
>>00000003 00000032 00000000 00000000 000000c0
>>Jan 21 12:15:17 ts        0000007b 0000007b 000000c0 08048541 00000073
>>00000282 bffffdcc 0000007b
>>Jan 21 12:15:17 ts Call Trace:
>>Jan 21 12:15:17 ts Code: 55 bd f7 ff ff ff 57 31 ff 56 53 83 ec 18 8b
>>44 24 38 89 c6
>>
>>  Unable to handle kernel NULL pointer dereference at virtual address
>>000000c0
>>  02114450
>>  *pde = 00000000
>>  Oops: 0002
>>  CPU:    0
>>  EIP:    0060:[<02114450>]    Not tainted
>>  EFLAGS: 00010246   (2.6.8-dev)
>>  eax: 000000c0   ebx: 31524fc4   ecx: 00001000   edx: 004ec000
>>  esi: 00000032   edi: 00000000   ebp: 31524000   esp: 31524fc0
>>  ds: 007b   es: 007b   ss: 0068
>>  Stack: fffec200 01a2a000 00001000 00000003 00000032 00000000
>>00000000 000000c0
>>         0000007b 0000007b 000000c0 08048541 00000073 00000282
>>bffffdcc 0000007b
>>  Call Trace:
>>  Code: 55 bd f7 ff ff ff 57 31 ff 56 53 83 ec 18 8b 44 24 38 89 c6
>>
>>
>> >>EIP; 02114450 <sys_mmap2+0/b0>   <=====
>>
>> >>ebx; 31524fc4 <pg0+2eff8fc4/fdac0000>
>> >>ebp; 31524000 <pg0+2eff8000/fdac0000>
>> >>esp; 31524fc0 <pg0+2eff8fc0/fdac0000>
>>
>>Code;  02114450 <sys_mmap2+0/b0>
>>00000000 <_EIP>:
>>Code;  02114450 <sys_mmap2+0/b0>   <=====
>>    0:   55                        push   %ebp   <=====
>>Code;  02114451 <sys_mmap2+1/b0>
>>    1:   bd f7 ff ff ff            mov    $0xfffffff7,%ebp
>>Code;  02114456 <sys_mmap2+6/b0>
>>    6:   57                        push   %edi
>>Code;  02114457 <sys_mmap2+7/b0>
>>    7:   31 ff                     xor    %edi,%edi
>>Code;  02114459 <sys_mmap2+9/b0>
>>    9:   56                        push   %esi
>>Code;  0211445a <sys_mmap2+a/b0>
>>    a:   53                        push   %ebx
>>Code;  0211445b <sys_mmap2+b/b0>
>>    b:   83 ec 18                  sub    $0x18,%esp
>>Code;  0211445e <sys_mmap2+e/b0>
>>    e:   8b 44 24 38               mov    0x38(%esp,1),%eax
>>Code;  02114462 <sys_mmap2+12/b0>
>>   12:   89 c6                     mov    %eax,%esi
>>
>>Why CPU is unable to handle paging request at 0x000000c0? There is no
>>access to
>>this addr in executing code! What has "push %ebp" to do with 0xc0?
>>The answer is that %eax contains 0xc0 and the touched in user space
>>pages contain 4092 zero bytes. And 0x0000 is an opcode for "addl %al,
>>(%eax)". 
>>So we see the situation when CPU is executing code from user space
>>pages though we are in kernel space already and data peeks from these
>>addresses
>>shows us the correct code (code in call trace is correct!).
>>I checked it and if these pages are filled with some other values,
>>not zeroes, than it's possible to make CPU execute this code.
>>
>>And why this happens on sys_mmap2+0? Because entry code (system_call)
>>is mapped at high addresses (> 0xffc00000) and is the same both in
>>kernel 
>>and user spaces, so entry.S code works ok.
>>
>>So we found 2 ways of curing this bug:
>>- make trampline code to be non-GLOBAL
>>- another observation was that PAE turned ON helps as well.
>>
>>Hypothesis
>>~~~~~~~~~~
>>I think that the problem is in code prefetch queue or somewhere in
>>CPU. 
>>It looks like CPU doesn't flush code prefetch queue after %cr3 reload
>>(to kernel space) in entry.S and continues to execute prefetched code
>>from user space pages.
>>
>>Why making entry code non-global helps the problem?
>>I think that if the code at %eip is flushed on %cr3 reload than the
>>_whole_ prefetch queue is flushed and when entry code is global than
>>it is 
>>not flushed on %cr3 reload and prefetch queue (including call to
>>flushed sys_mmap2 code) is not flushed.
>>
>>Kirill
>>
>>
>>
>>>Hi Kirill,
>>>
>>>I appreciate you bringing this issue up.  Could you please send us
>>>the information on how you are able to reproduce this issue (System
>>>config, Linux kernel version and any test case).  We would like to
>>>root cause the failure here at Intel. 
>>>
>>>Appreciate your help,
>>>Thanks,
>>>-rohit
>>>
>>>Kirill Korotaev <> wrote on Wednesday, January 19, 2005 8:08 AM:
>>>
>>>
>>>
>>>>Hello Linus,
>>>>
>>>>Linus, Ingo, I've got one strange CPU bug leading to oopses, reboots
>>>>and so on. This bug can be reproduced with a little bit modified 4gb
>>>>split and is probably related to CPU speculative execution. I'll
>>>>post more information about this bug later, but I would like to ask
>>>>you for Intel guys contacts who maybe interested in this
>>>>information, so I could CC them as well. 
>>>>
>>>>Thank you,
>>>>Kirill
>>>>
>>>>-
>>>>To unsubscribe from this list: send the line "unsubscribe
>>>>linux-kernel" in the body of a message to majordomo@vger.kernel.org
>>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


