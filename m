Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131430AbRCKN5R>; Sun, 11 Mar 2001 08:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131431AbRCKN5H>; Sun, 11 Mar 2001 08:57:07 -0500
Received: from linuxcare.com.au ([203.29.91.49]:14092 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131430AbRCKN4x>; Sun, 11 Mar 2001 08:56:53 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Mon, 12 Mar 2001 00:54:48 +1100
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: sys_sched_yield fast path
Message-ID: <20010312005448.A5439@linuxcare.com>
In-Reply-To: <oup4rx1tv9m.fsf@pigdrop.muc.suse.de> <XFMail.20010311151257.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <XFMail.20010311151257.davidel@xmailserver.org>; from davidel@xmailserver.org on Sun, Mar 11, 2001 at 03:12:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> This is the linux thread spinlock acquire :
> 
> 
> static void __pthread_acquire(int * spinlock)
> {
>   int cnt = 0;
>   struct timespec tm;
> 
>   while (testandset(spinlock)) {
>     if (cnt < MAX_SPIN_COUNT) {
>       sched_yield();
>       cnt++;
>     } else {
>       tm.tv_sec = 0;
>       tm.tv_nsec = SPIN_SLEEP_DURATION;
>       nanosleep(&tm, NULL);
>       cnt = 0;
>     }
>   }
> }
> 
> 
> Yes, it calls sched_yield() but this is not a std wait for mutex but for
> spinlocks that are hold a very short time.  Real wait are implemented using
> signals.  More, with the new implementation of sys_sched_yield() the task
> release all its time quantum so, even in a case where a task repeatedly calls
> sched_yield() the call rate is not so high if there is at least one process
> to spin.  And if there isn't one task with goodness() > 0, nobody cares about
> sched_yield() performance.

The problem I found with sched_yield is that things break down with high
levels of contention. If you have 3 processes and one has a lock then
the other two can ping pong doing sched_yield() until their priority drops
below the process with the lock. eg in a run I just did then where 2
has the lock:

1
0
1
0
1
0
1
0
1
0
1
0
1
0
1
0
1
0
2

Perhaps we need something like sched_yield that takes off some of 
tsk->counter so the task with the spinlock will run earlier.

Anton
