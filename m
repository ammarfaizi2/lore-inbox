Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVHHVJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVHHVJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVHHVJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:09:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:14332 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932231AbVHHVJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:09:19 -0400
Message-ID: <42F7C9F9.7000505@mvista.com>
Date: Mon, 08 Aug 2005 14:09:13 -0700
From: Dave Jiang <djiang@mvista.com>
Organization: MontaVista Software, Inc.
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 frame pointer via thread context
References: <42F3EC97.2060906@mvista.com.suse.lists.linux.kernel> <p73slxn1dry.fsf@bragg.suse.de> <42F7A609.5030502@mvista.com> <42F7BB2C.6070004@vc.cvut.cz> <42F7BE4A.6030709@mvista.com> <42F7C01E.4020108@vc.cvut.cz>
In-Reply-To: <42F7C01E.4020108@vc.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
>>> Replace call to sleep() with busy loop.  Glibc's sleep() uses %ebp for
>>> its own data, so when you interrupt sleep(), you get rbp=(unsigned 
>>> int)-1,
>>> as rbp really contains 0x0000.0000.ffff.ffff when nanosleep() syscall
>>> is issued.
>>>                                 Petr
>>  From what I understand, when you signal a thread, the signal handler 
>> executes in the thread context and not the main process context. So 
>> therefore the rbp would be the thread's copy and not the one that 
>> sleep() just modified. So whatever sleep does to the main process 
>> context, there shouldn't be any effect on the thread context.... Also, 
>> what can I call to allow the threads to run? sleep() allows me to run 
>> the other threads. Busy wait does not.....
> 
> 
> I do not understand.  You call sleep() from both threads you spawn
> (as well from main), so both threads are always interrupted in the
> sleep(2).  Load your process to the debugger...
> 
> #0  tb_sig_handler (sig=33, info=0x407ff2f0, ucontext=0x407ff1c0) at 
> ttest1.c:26
> #1  <signal handler called>
> #2  0x00002aaaaad81335 in nanosleep () from /lib/libc.so.6
> #3  0x00002aaaaad811a5 in sleep () from /lib/libc.so.6
> #4  0x0000000000400871 in test_thread1 (arg=0x0) at ttest1.c:40
> #5  0x00002aaaaabc6b55 in start_thread () from /lib/libpthread.so.0
> #6  0x00002aaaaada87f0 in clone () from /lib/libc.so.6

Ooops, you are right. I forgot about those ones in the threads. Yes you 
are right. Once the sleep goes away rBP displays the correct values. Is 
this issue due to glibc or because of the toolchain? I do not have this 
issues on 32bit x86.... I would assume that the reason it works on 
Mandrake is due to the toolchain they use versus other distros? The 
toolchain determines which registers to use and the 
-fno-omit-frame-pointer did not prevent some of them from clobbering rbp?

-- 
Dave

------------------------------------------------------
Dave Jiang
Software Engineer          Phone: (480) 517-0372
MontaVista Software, Inc.    Fax: (480) 517-0262
2141 E Broadway Rd, St 108   Web: www.mvista.com
Tempe, AZ  85282          mailto:djiang@mvista.com
------------------------------------------------------

