Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279618AbRJ2XcK>; Mon, 29 Oct 2001 18:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279627AbRJ2XcG>; Mon, 29 Oct 2001 18:32:06 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:38662 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279618AbRJ2Xbp>; Mon, 29 Oct 2001 18:31:45 -0500
Message-ID: <3BDDE5DF.71917D8F@zip.com.au>
Date: Mon, 29 Oct 2001 15:27:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Kuebel <kuebelr@email.uc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 8139too termination
In-Reply-To: <20011029181029.A320@cartman>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kuebel wrote:
> 
> hi,
> 
> i have been getting this message at shutdown ...
> 
> "eth1: unable to signal thread"
> 
> it turns out that 8139too's kernel thread gets killed at shutdown (or
> reboot) when SIGTERM is sent to all processes.  then the network
> shutdown script comes along and takes down the interface.  the driver
> complains ...
> 
> "eth1: unable to signal thread"
> 
> because the thread has already terminated.  the driver currently does
> not block any signals.
> 
> my question is, should 8139too really not block any signals (and allow
> itself to be killed by them)?  isn't it a bad thing to allow a kernel
> thread to be killed accidentally like this?
> 

Yes, I'd agree that the driver should ignore random signals.
The kernel thread should only allow itself to be terminated
via the driver's close() method.

An obvious approach is to change rtl8139_close() to do:

	tp->diediedie = 1;
	wmb();
	ret = kill_proc(...);

and test the flag in rtl8139_thread().

The tricky part is teaching the thread to ignore the
spurious signals - the signal_pending() state needs to be
cleared.  I think flush_signals() is the way to do this.
See context_thread() for an example.

           spin_lock_irq(&curtask->sigmask_lock);
           flush_signals(curtask);
           recalc_sigpending(curtask);
           spin_unlock_irq(&curtask->sigmask_lock);

The recalc_sigpending() here appears to be unnecessary...

The kernel thread in 8139too has certainly been an interesting
learning exercise :)  Using signals and task management in-kernel
is full of pitfalls.  In retrospect, probably it should have used
waitqueues directly.

-
