Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRCLB0o>; Sun, 11 Mar 2001 20:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129393AbRCLB0e>; Sun, 11 Mar 2001 20:26:34 -0500
Received: from linuxcare.com.au ([203.29.91.49]:36612 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129381AbRCLB0W>; Sun, 11 Mar 2001 20:26:22 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Mon, 12 Mar 2001 12:24:47 +1100
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: sys_sched_yield fast path
Message-ID: <20010312122447.A7350@linuxcare.com>
In-Reply-To: <20010312005448.A5439@linuxcare.com> <XFMail.20010312011030.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <XFMail.20010312011030.davidel@xmailserver.org>; from davidel@xmailserver.org on Mon, Mar 12, 2001 at 01:10:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> 2.4.x has changed the scheduler behaviour so that the task that call
> sched_yield() is not rescheduled by the incoming schedule().  A flag is
> set ( under certain conditions in SMP ) and the goodness() calculation
> assign the lower value to the exiting task ( this flag is cleared in
> schedule_tail() ).

The behaviour I am talking about is when there is a heavily contended
spinlock, and more than one task is trying to obtain it. Since SCHED_YIELD
only changes the goodness when we are trying to reschedule the task we
can bounce between two or more tasks doing sched_yield() for a while before
finally running the task that has the spinlock.

Of course with short lived spinlocks you should rarely get the case where
a task grabs a spinlock just before its timeslice is up, so maybe the answer
is just to spin a few times on sched_yield() then back off to nanosleep()
like pthreads does.

Anton
