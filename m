Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315251AbSEURhU>; Tue, 21 May 2002 13:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSEURhT>; Tue, 21 May 2002 13:37:19 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:25361 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315251AbSEURhR>; Tue, 21 May 2002 13:37:17 -0400
Message-ID: <3CEA8742.2040308@yahoo.com>
Date: Tue, 21 May 2002 23:13:30 +0530
From: C Hanish Menon <hanishkvc@yahoo.com>
Reply-To: hanishkvc@yahoo.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020515 Debian/1.0rc2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Seems like a race or unhandled situation with ksoftirqd scheduling/management
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On a mips target to which I have added HAL for linux, I found that the 
system time wasn't going forward. On further look, I found that jiffies 
is getting updated properly (as expected), but ksoftirqd (and all its 
siblings tasklets, soft timers, bottom halves ...) aren't working.


This is the sequence of events that lead to the situation where 
ksoftirqd is left out in the cold.

   a) ksoftirqd gets scheduled

   b) ksoftirqd doesn't find any pending softirqs

   c) ksoftirqd gives back control to scheduler

   d) schedular REMOVES ksoftirqd from run_queue
	(TASK_INTERRUPTIBLE but no signal pending)

   e) timer interrupt occurs.

   f) timer interrupt handler sets mark_bh for TIMER_BH

   g) mark_bh inturn task_hi_schedules TIMER_BH related tasklet

   h) task_hi_schedule adds the tasklet to its list to process

   i) task_hi_schedule calls cpu_raise_softirq for this
	cpu and HI_SOFTIRQ

   j) cpu_raise_softirq sets the corresponding pending bit.

   k) cpu_raise_softirq DOESNOT wakeup_softirqd
      because currently its in INTERRUPT_CONTEXT. (local_irq_count)


   So if no other events occur with inturn could lead to the 
wakeup_softirqd being called, then ksoftirqd doesn't get into
run_queue and doesn't run. In my target currently only the
TIMER_BH uses the softirq based mechanism. And it won't trigger
ksoftirqd to be woken up.

   According to the comment in cpu_raise_softirq it doesn't 
wakeup_softirqd in irq context because on returning from a irq
softirqd will be run,  but it doesn't seem to be valid in any
architectures (have varified x86, mips). Because on returning
from irq context, just the scheduler gets called, but as
the ksoftirqd is not in the run queue, it won't get scheduled.

Only way ksoftirqd can get into the runqueue is if, wakeup_softirqd
gets called, which inturn occurs only from cpu_raise_softirqd. Which
can occur for my target only as part of mark_bh(TIMER_BH) (that to
only the 1st time it occurs), but which won't trigger wakeup_softirqd
because of interrupt context.

_Am I_ missing some other way ksoftirqd could endup in the run_queue. I
have looked around to some extent, but cann't see any other way how
ksoftirqd could get into the runqueue. Have to admit, haven't looked
fully into the linux scheduling logic, but logically I don't seem to
have left out any possibility.

My current Solution:

Currenlty I have just commented out the check for Interrupt and BH 
context in cpu_raise_softirqd before calling wakeup_softirqd. It works 
fine now. Also it doesn't seem to be a problem, because 
cpu_raise_softirqd seems to get called only if required and also there 
seems to be enough checks and bounds so that it doesn't get called 
repeatedly.


NOTE:

I am using 2.4.16 with linux-mips patchs (from sourceforge) for my linux 
port to the target. Regarding this problem, I have looked into linux 
2.4.18 and also linux-2.4.19pre4, the code leading to this situation
hasn't changed in them, so the problem should/will still be there.


Keep :-)
HanishKVC



