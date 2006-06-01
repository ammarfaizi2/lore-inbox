Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWFAWzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWFAWzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWFAWzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:55:32 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:33664 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750849AbWFAWzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:55:32 -0400
Message-ID: <447F70AD.6000309@free.fr>
Date: Fri, 02 Jun 2006 00:56:45 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
References: <200606011741_MC3-1-C158-4568@compuserve.com> <20060601150250.3a66c489.akpm@osdl.org>
In-Reply-To: <20060601150250.3a66c489.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 02.06.2006 00:02, Andrew Morton a écrit :
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
>> In-Reply-To: <447DD4D3.3060205@free.fr>
>>
>> On Wed, 31 May 2006 19:39:31 +0200, Laurent Riffard wrote:
>>
>>> pktcdvd: writer pktcdvd0 mapped to hdc
>>> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000084
>>>  printing eip:
>>> c01118f1
>>> *pde = 00000000
>>> Oops: 0000 [#1]
>>> last sysfs file: /block/pktcdvd0/removable
>>> Modules linked in: pktcdvd lp parport_pc parport snd_pcm_oss snd_mixer_oss snd_ens1371 gameport snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd soundcore af_packet floppy ide_cd cdrom loop aes dm_crypt nl
>>> CPU:    0
>>> EIP:    0060:[<c01118f1>]    Not tainted VLI
>>> EFLAGS: 00010006   (2.6.17-rc5-mm1 #11) 
>>> EIP is at do_page_fault+0xb4/0x5bc
>>> eax: d6750084   ebx: d6750000   ecx: 0000007b   edx: 00000000
>>> esi: d6758000   edi: c011183d   ebp: d675007c   esp: d6750044
>>> ds: 007b   es: 007b   ss: 0068
>>> Process  (pid: 0, threadinfo=d674f000 task=d657c000)
>>> Stack: 00000000 d6750084 00000000 00000049 00000084 00000000 00001e2e 02001120 
>>>        00000027 00000022 00000055 d6750000 d6758000 c011183d d67500f0 c010340d 
>>>        d6750000 0000007b 00000000 d6758000 c011183d d67500f0 d67500f8 0000007b 
>>> Call Trace:
>>>  [<c010340d>] error_code+0x39/0x40
>>> Code: 00 00 c0 81 0f 84 12 02 00 00 e9 1c 05 00 00 8b 45 cc f7 40 30 00 02 02 00 74 06 e8 68 af 01 00 fb f7 43 14 ff ff ff ef 8b 55 d0 <8b> b2 84 00 00 00 0f 85 e5 01 00 00 85 f6 0f 84 dd 01 00 00 8d 
>>> EIP: [<c01118f1>] do_page_fault+0xb4/0x5bc SS:ESP 0068:d6750044
>> arch/i386/mm/fault.c::do_page_fault():
>>
>>   12:   f7 40 30 00 02 02 00      testl  $0x20200,0x30(%eax)
>>   19:   74 06                     je     21 <_EIP+0x21>
>>         if (regs->eflags & (X86_EFLAGS_IF|VM_MASK))
>>
>>   1b:   e8 68 af 01 00            call   1af88 <_EIP+0x1af88>
>>   20:   fb                        sti
>>                 local_irq_enable();
>>
>> local_irq_enable() should only be doing an sti; your code has an extra
>> function call. Do you have any extra patches applied?
> 
> This is all the lockdep stuff - it adds instrumentation to local_irq_foo().
> 
>>   21:   f7 43 14 ff ff ff ef      testl  $0xefffffff,0x14(%ebx)
>> if (in_atomic()...
>>
>>   28:   8b 55 d0                  mov    0xffffffd0(%ebp),%edx
>> Get tsk from local storage and put it in edx.
>>
>> 00000000 <_EIP>:
>>    0:   8b b2 84 00 00 00         mov    0x84(%edx),%esi   <=====
>>         mm = tsk->mm;
>>
>> tsk was zero here, implying that current was 0 when the page fault happened.
>>
>>
>>    6:   0f 85 e5 01 00 00         jne    1f1 <_EIP+0x1f1>
>>    c:   85 f6                     test   %esi,%esi
>>    e:   0f 84 dd 01 00 00         je     1f1 <_EIP+0x1f1>
>>
>>
>>
>> Andrew, should we add debug code to the fault handler to test for current == 0?
> 
> `current == 0' implies a scrogged thread_info.  I'm not sure what debugging
> we could usefully add to the pagefault handler to detect that.  Apart from
> getting a good backtrace.  Which the x86_64 guys have broken.
> 
> Laurent, please disable CONFIG_STACK_UNWIND and try again - that way we
> should be able to see whereabouts the thread-info got corrupted.

I tried 2.6.17-rc5-mm2 with CONFIG_STACK_UNWIND disabled today and the bug 
still happened.

But I can't get a full stack trace right now since I don't have my second 
box here. Will do tomorrow.

-- 
laurent
