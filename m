Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVHHU1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVHHU1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVHHU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:27:13 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:14053 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932216AbVHHU1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:27:11 -0400
Message-ID: <42F7C01E.4020108@vc.cvut.cz>
Date: Mon, 08 Aug 2005 22:27:10 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jiang <djiang@mvista.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 frame pointer via thread context
References: <42F3EC97.2060906@mvista.com.suse.lists.linux.kernel> <p73slxn1dry.fsf@bragg.suse.de> <42F7A609.5030502@mvista.com> <42F7BB2C.6070004@vc.cvut.cz> <42F7BE4A.6030709@mvista.com>
In-Reply-To: <42F7BE4A.6030709@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang wrote:
> Petr Vandrovec wrote:
> 
>> Dave Jiang wrote:
>>
>>> Andi Kleen wrote:
>>>
>>>> Dave Jiang <djiang@mvista.com> writes:
>>>>
>>>>> Am I doing something wrong, or is this intended to be this way on
>>>>> x86_64, or is something incorrect in the kernel? This method works
>>>>> fine on i386. Thanks for any help!
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> I just tested your program on SLES9 with updated kernel and RBP
>>>> looks correct to me. Probably something is wrong with your user space
>>>> includes or your compiler.
>>>>
>>>> -Andi
>>>
>>>
>>>
>>>
>>> I revised the app a little so that it would allow the threads to 
>>> start, thus should prevent rBP w/ all 0's showing up. Below are some 
>>> of results that I've gotten from various different distros and 
>>> platforms. As you can see, the f's shows up on most of them, 
>>> including Suse 9.2. The only one showed up looking ok is the 
>>> Mandrake/Mandriva distro. I'm not sure how different SLES9 is from 
>>> Suse9.2....
>>
>>
>>
>> Replace call to sleep() with busy loop.  Glibc's sleep() uses %ebp for
>> its own data, so when you interrupt sleep(), you get rbp=(unsigned 
>> int)-1,
>> as rbp really contains 0x0000.0000.ffff.ffff when nanosleep() syscall
>> is issued.
>>                                 Petr
>>
> 
>  From what I understand, when you signal a thread, the signal handler 
> executes in the thread context and not the main process context. So 
> therefore the rbp would be the thread's copy and not the one that 
> sleep() just modified. So whatever sleep does to the main process 
> context, there shouldn't be any effect on the thread context.... Also, 
> what can I call to allow the threads to run? sleep() allows me to run 
> the other threads. Busy wait does not.....

I do not understand.  You call sleep() from both threads you spawn
(as well from main), so both threads are always interrupted in the
sleep(2).  Load your process to the debugger...

#0  tb_sig_handler (sig=33, info=0x407ff2f0, ucontext=0x407ff1c0) at ttest1.c:26
#1  <signal handler called>
#2  0x00002aaaaad81335 in nanosleep () from /lib/libc.so.6
#3  0x00002aaaaad811a5 in sleep () from /lib/libc.so.6
#4  0x0000000000400871 in test_thread1 (arg=0x0) at ttest1.c:40
#5  0x00002aaaaabc6b55 in start_thread () from /lib/libpthread.so.0
#6  0x00002aaaaada87f0 in clone () from /lib/libc.so.6

							Petr

