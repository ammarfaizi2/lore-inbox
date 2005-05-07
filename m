Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVEGHMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVEGHMh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 03:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVEGHMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 03:12:37 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:44954 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262736AbVEGHMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 03:12:34 -0400
Message-ID: <427C6A5C.6090900@yahoo.com.au>
Date: Sat, 07 May 2005 17:12:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Yuly Finkelberg <liquidicecube@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Scheduler: Spinning until tasks are STOPPED
References: <92df3175050506233110a19a60@mail.gmail.com>
In-Reply-To: <92df3175050506233110a19a60@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yuly Finkelberg wrote:
>                                                                       
>                                                                       
>                                                                       
>                                           Hi,
> 
> I sent a message regarding this issue earlier, but after re-reading
> it, I realized that it wasn't very clear.  Hopefully, this will
> clarify things a little bit:
> 
> I have a strange scheduling issue: a bunch of worker tasks are all waiting 
> on a wait queue. Each task is woken up by the preceeding, does some work, 
> wakes up the next one, and then sends a SIGSTOP to itself. The last task however
> does not stop itself, but instead yield()s until all tasks have reached state
> TASK_STOPPED.
> 
> The code looks like this (irrelevant parts cut out):
> 	...
>         ret = wait_event_interruptible(waitq, next_in_line == myself);
> 	...
> 	(some work)
> 	...
> 	next_in_line = next;	
>         ret = wakeup_next_one();
> 	if (!last_one)
> 		send_sig(SIGSTOP, current, 1);
> 	else
> 		spin_until_all_stopped()
> 
> When run with 50 tasks, normally this works well. However sometimes one of the
> tasks (never the last one) gets stuck between calling wakeup_next_one() and 
> between sending the signal. It accumulates system time, and its stack looks
> like (no pending signals, ti_flags is clear):
> 
> c55e7ad0 00000086 c55e6000 c55e7a94 00000046 c55e6000 c55e7ad0 c0109c2d
>          00000000 c0497800 00000001 d38da344 0013bc9c c5632840 00071931 d3d93161
>          0013bc9c c55d546c c05d3960 0000270f c05d3960 c55e6000 c0106f25 c05d3960
> 
> Call Trace:
> [<c0106f25>] need_resched+0x27/0x32
> 
> (yes, this is not a mistake: this is ALL the stack reported by show_stack())
> 
> Normally the spinning task will magically get released after "a while", where 
> few seconds < "a while" < 10 minutes and sometimes even longer. 
> So the mystery is -
> 1. Why does the task spin for so long ?
> 2. Where does it spin ?  (the kernel stack doesn't hint on anything...)
> 3. How can I find out #2 ?
> 4. How to fix it ?
> 5. Is there a better way to make sure a specific task is STOPPED ?
> 
> Currently running 2.6.8.1 and 2.6.9 (UP, PREEMPT).  I'd appreciate any
> help here...

You're doing this in the *kernel*? It sounds like it should be done
in userspace or done a different way (ie. not with 50 tasks).

And using signals and spinning on yield for synchronisation and
process control in the kernel like this is fairly crazy.

Can't you use a semaphore or something?

