Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTJKMGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 08:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTJKMGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 08:06:25 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:41396 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263301AbTJKMGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 08:06:19 -0400
Message-ID: <3F87F234.1060704@colorfullife.com>
Date: Sat, 11 Oct 2003 14:06:12 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7 DEBUG_PAGEALLOC oops
References: <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:

>>
>>> eax: 00000000   ebx: c7802f98   ecx: c0301390   edx: c030138c
>>> esi: c0349ffe   edi: 017e0008   ebp: c0349da6   esp: c0349d96
>>> ds: 007b   es: 007b   ss: 0068
>>> Process swapper (pid: 0, threadinfo=c0348000 task=c02fcbe0)
>>
>> The esp value is sane, the stack is at 0xc0348000, and the fault is 
>> at 'a000: just behind the end of the stack. 
>
I'm blind. The esp value is the culprit:
It's not 32-bit aligned. Someone misaligned the stack, and thus
    if(stack_ptr & (THREAD_SIZE-1))
didn't notice the end of the stack.
The generated assembly of store_slabinfo is correct:
     1d2:       f7 c6 ff 1f 00 00       test   $0x1fff,%esi
Check sptr against THREAD_SIZE -1
     1d8:       74 21                   je     1fb <store_stackinfo+0x6f>
     1da:       8b 3e                   mov    (%esi),%edi
And load *sptr.


>> It looks like store stackinfo accesses memory behind the end of the 
>> stack.
>
>
> Yeah, I'm trying to figure out why.  The below (if dang mailer 
> actually inlines it) kludge allows me to boot, so I suppose I need to 
> ponder addr wrt _stext and _etext.

Wrong direction:  Right now it crashes because it runs over the end of 
the stack.
With your patch applied, the allocated object is too small to hold all 
entries on the stack, and thus store_stackinfo aborts before it runs 
into the next page.

I'd increase kstack_depth_to_print to 140. Do not increase it too much, 
otherwise it will oops due to the misaligned stack.
Then check the EBP values: They are pushed after the return address. The 
return addresses are listed in the Call Trace section.
Example:
0xc01316aa8 pushes 0xc0349dd6 -> odd.
0xc0131b6c pushes 0xc0349de6 -> odd.

0xc0131b3e pushes c0349e02 -> odd.

Proper values for EBP are multiples of 4. One you find where the stack got misaligned, disassemble the offending function (or send me the .o file)


--
    Manfred

