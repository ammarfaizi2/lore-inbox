Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266016AbRGKT2T>; Wed, 11 Jul 2001 15:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265891AbRGKT2J>; Wed, 11 Jul 2001 15:28:09 -0400
Received: from james.kalifornia.com ([208.179.59.2]:41008 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S265807AbRGKT17>; Wed, 11 Jul 2001 15:27:59 -0400
Message-ID: <3B4CA8A0.507@blue-labs.org>
Date: Wed, 11 Jul 2001 15:27:28 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010710
X-Accept-Language: en-us
MIME-Version: 1.0
To: Josh Logan <josh@wcug.wwu.edu>
CC: Andrea Arcangeli <andrea@suse.de>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Andrew Morton <andrewm@uow.edu.au>,
        Klaus Dittrich <kladit@t-online.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
In-Reply-To: <Pine.BSO.4.21.0107111129150.26715-100000@sloth.wcug.wwu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the hang for me.

Thank you,
David

Josh Logan wrote:

>I'm having a hang right after the floppy is initialised with pre5 and pre6
>(2.4.3 works fine)  I tried this patch, but it did not make any
>improvments.  The machine still has SysRq commands available.  Please let
>me know what other information you would like to debug this problem.
>
>BTW, I also tried to disable the floppy in the BIOS and got:
>...
>Floppy OK
>task queue still active
><HANG>
>
>							Later, JOSH
>
>
>On Wed, 11 Jul 2001, Andrea Arcangeli wrote:
>
>>On Wed, Jul 11, 2001 at 04:22:04PM +0200, Trond Myklebust wrote:
>>
>>>>>>>>" " == Andrew Morton <andrewm@uow.edu.au> writes:
>>>>>>>>
>>>     > Trond Myklebust wrote:
>>>    >>
>>>    >> ...  I have the same problem on my setup. To me, it looks like
>>>    >> the loop in spawn_ksoftirqd() is suffering from some sort of
>>>    >> atomicity problem.
>>>
>>>     > Does a `set_current_state(TASK_RUNNING);' in spawn_ksoftirqd()
>>>     > fix it?  If so we have a rogue initcall...
>>>
>>>Nope. The same thing happens as before.
>>>
>>>A couple of debugging statements show that ksoftirqd_CPU0 gets created
>>>fine, and that ksoftirqd_task(0) is indeed getting set correctly
>>>before we loop in spawn_ksoftirqd().
>>>After this the second call to kernel_thread() succeeds, but
>>>ksoftirqd() itself never gets called before the hang occurs.
>>>
>>ksoftirqd is quite scheduler intensive, and while its startup is
>>correct (no need of any change there), it tends to trigger scheduler
>>bugs (one of those bugs was just fixed in pre5). The reason I never seen
>>the deadlock I also fixed this other scheduler bug in my tree:
>>
>>	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.7pre5aa1/00_sched-yield-1
>>
>>this one I forgot to sumbit but here it is now for easy merging:
>>
>>--- 2.4.4aa3/kernel/sched.c.~1~	Sun Apr 29 17:37:05 2001
>>+++ 2.4.4aa3/kernel/sched.c	Tue May  1 16:39:42 2001
>>@@ -674,8 +674,10 @@
>> #endif
>> 	spin_unlock_irq(&runqueue_lock);
>> 
>>-	if (prev == next)
>>+	if (prev == next) {
>>+		current->policy &= ~SCHED_YIELD;
>> 		goto same_process;
>>+	}
>> 
>> #ifdef CONFIG_SMP
>>  	/*
>>


