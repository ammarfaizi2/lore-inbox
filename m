Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031577AbWLEV1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031577AbWLEV1G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031597AbWLEV1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:27:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33213 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031577AbWLEV1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:27:02 -0500
Date: Tue, 5 Dec 2006 13:26:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Fleming <afleming@freescale.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061205132643.d16db23b.akpm@osdl.org>
In-Reply-To: <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 14:59:31 -0600
Andy Fleming <afleming@freescale.com> wrote:

> Ok, I think this is the summary:
> 
> - phy_change() is the work queue callback function (scheduled when a  
> PHY interrupt occurs)
> 
> - dev_close() invokes the controller's stop/close/whatever function,  
> and it calls phy_disconnect()
> 
> - phy_disconnect() calls phy_stop_interrupts().  To prevent any  
> pending phy_change() calls from getting confused, phy_stop_interrupts 
> () needs to flush the queue.  Otherwise, subsequent memory freeings  
> will leave phy_change() hanging.
> 
> - If phy_stop_interrupts() calls flush_scheduled_work(), keventd will  
> execute its queues while rtnl_lock is held, providing opportunity for  
> other callbacks to deadlock.
> 
> - innocent puppies are slaughtered, and the world mourns.
> 

ah, OK.  So it's some other queued-up callback which takes rtnl_lock.

But I still don't see what's special about keventd.  If, say, /sbin/ip is
running flush_scheduled_work() under rtnl_lock then it too should deadlock
in this scenario.

> 
> Maciej's solution is to schedule phy_disconnect() to be called from a  
> work queue.  That solution should work, but it sounds like it doesn't  
> require the check for if keventd is running.
> 
> Of course, my objection to it is that it now requires the ethernet  
> controller to be excessively aware of the details of how the PHY Lib  
> is handling the PHY interrupts (by scheduling them on a work queue).

So what's a good fix?

a) Ban the calling of flush_scheduled_work() from under rtnl_lock(). 
   Sounds hard.

b) Ban the queueing of callback functions which take rtnl_lock().  This
   sounds like a plain bad idea - callbacks are low-level things which
   ought to be able to take locks.

c) Cancel the phy_change() callback within phy_stop_interrupts() so we
   don't need to run flush_scheduled_work() at all.

   This will almost work, as long as it's done in workqueue.c with
   appropriate locking.  The bug occurs when some other CPU is running
   phy_change() right now - we'll end up freeing data which that CPU is
   presently playing with.

   But perhaps we can take care of this within workqueue.c.  We need a
   cancel function which will cancel the work and, if its callback is
   presently executing it will block until that execution has completed.

   If we require of the calling subsystem a) that the work will not get
   rescheduled (that means phy_interrupt()) and b) that the callback does
   not rearm the work then things get simpler.

   But still not very simple.  It gets ugly with per-CPU qorkqueues.
