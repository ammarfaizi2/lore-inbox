Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269706AbRHCXho>; Fri, 3 Aug 2001 19:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269705AbRHCXhY>; Fri, 3 Aug 2001 19:37:24 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:37386 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S269682AbRHCXhO>;
	Fri, 3 Aug 2001 19:37:14 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108032337.f73NbHO02352@oboe.it.uc3m.es>
Subject: Re: what's the semaphore in requests for?
In-Reply-To: From (env: ptb) at "Jul 31, 2001 08:45:53 pm"
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Sat, 4 Aug 2001 01:37:16 +0200 (MET DST)
CC: axboe@suse.de
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, It begins to look to me as though something takes the io_request
spinlock and then sleeps. I thought it was me, but now I'm not so sure.

New readers, set scene here:

"ptb wrote:"
> > > > 2 processors + 2 userspace helper daemon on device = bug  (lockup)
> > > > 1 processors + 1 userspace helper daemon on device = no bug 


And I now believe the explanation is as follows:

   cpu1                             cpu2

   ioctl takes private spinlock     something takes io_request spinlock
   IDE interrupt takes io spinlock  schedule
   deadlock                         dev req fn tries for private spinlock
				    deadlock

This deadlock relies on 

 1) me not protecting against interrupts in my spinlocks (reasonable,
 since my spinlock is not taken from an interrupt).
 2) something taking the io spinlock and sleeping while it's held.

I thought at first that (2) was me, but it may not be so.

I surmised that when I held the io_request spinlock that the
end_that_request_first function may have been sleeping occasionally ..
but I moved the spinlock to cover only end_that_request_last and I still
see deadlocks when (1) is true.  When (1) is not true, no deadlock,
wherever I put the spinlock in end_request. So the indication is that
it's not (only) me who's taking the io_request spinlock and then
sleeping.

Does anyone have any comment? I am running  2.4.6 with the latest
aic7xxx patches.

My grounds for believing in the scenario above are that when a
lockup occurs, in the kernel debugger I see both my helper daemon
threads scheduled, and a userspace function deadlocked in IDE_do_irq in
a spinlock, and one cpu not responding to NMI. Since I don't schedule
or sleep when holding my spinlock, my spinlock cannot be held at this
point, and the deadlock must be against another spinlock. That must be
the io_request spinlock (it's the only other spinlock in my code too).
And the deadlock only happens when I don't mask interrupts when taking
my spinlock, so it must happen in an interrupt manager .. and it's
clearly in the IDE manager, and I believe it's against the io_request
spinlock. Also the deadlock must be a cross-cpu deadlock, as it only
happened when I ran two helper client daemons, not one.

The lockup happens about 1 in every 250000 requests.

My SMP machine is already slightly unstable under 2.4 kernels, about
one spontaneous reboot per four to seven days.

Peter
