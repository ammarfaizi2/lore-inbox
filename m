Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968630AbWLES6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968630AbWLES6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968631AbWLES6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:58:17 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:50493 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968630AbWLES6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:58:16 -0500
In-Reply-To: <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
References: <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org> <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0ECFB207-7AC9-4D0D-AC9B-EEFF5A1A41EA@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, Ben Collins <ben.collins@ubuntu.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Content-Transfer-Encoding: 7bit
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Date: Tue, 5 Dec 2006 12:57:47 -0600
To: "Maciej W. Rozycki" <macro@linux-mips.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 5, 2006, at 11:48, Maciej W. Rozycki wrote:

>
>  Essentially there is a race when disconnecting from a PHY, because
> interrupt delivery uses the event queue for processing.  The  
> function to
> handle interrupts that is called from the event queue is phy_change().
> It takes a pointer to a structure that is associated with the PHY.   
> At the
> time phy_stop_interrupts() is called there may be one or more calls to
> phy_change() still pending on the event queue.  They may not be  
> able to be
> processed until the structure passed to phy_change() have been  
> freed, at
> which point calling the function is wrong.
>
>  One way of avoiding it is calling flush_scheduled_work() from
> phy_stop_interrupts().  This is fine as long as a caller of
> phy_stop_interrupts() (not necessarily the immediate one calling into
> libphy) does not hold the netlink lock.
>
>  If a caller indeed holds the netlink lock, then a driver effectively
> calling phy_stop_interrupts() may arrange for the function to be  
> itself
> scheduled through the event queue.  This has the effect of avoiding  
> the
> race as well, as the queue is processed in order, except it causes  
> more
> hassle for the driver.  Hence the choice was left to the driver's  
> author
> -- if a driver "knows" the netlink lock is not going to be held at  
> that 
> point, it may call phy_stop_interrupts() directly, otherwise it  
> shall use
> the event queue.


We need to make sure there are no more pending phy_change()  
invocations in the work queue, this is true, however I'm not  
convinced that this avoids the problem.  And now that I come back to  
this email after Linus's response, let me add that I agree with his  
suggestion.  I still don't think it solves the original problem,  
though.  Unless I'm missing something, Maciej's suggested fix (having  
the driver invoke phy_stop_interrupts() from a work queue) doesn't  
stop the race:

* Schedule stop_interrupts and freeing of memory.
* interrupt occurs, and schedules phy_change
* work_queue triggers, and stop_interrupts is invoked.  It doesn't  
call flush_scheduled_work, because it's being called from keventd.
* The invoker of stop_interrupts (presumably some function in the  
driver) frees up memory, including the phy_device.
* phy_change is invoked() from the work queue, and starts accessing  
freed memory

Am I misunderstanding how work queues operate?

If I'm right, an ugly solution would have to disable the PHY  
interrupts before scheduling the cleanup.  But is there really no way  
to tell the kernel to squash all pending work that came from *this*  
work_queue?



>
>  With such an assumption in place the function has to check somehow
> whether it has been scheduled through the queue or not and act
> accordingly, which is why that "if" clause is there.
>
>  Now I gather the conclusion was the whole mess was going to be  
> included
> within libphy and not exposed to Ethernet MAC drivers.  This way the
> library would schedule both phy_stop_interrupts() and  
> mdiobus_unregister()
> (which is actually the function freeing the PHY device structure)  
> through
> the event queue as needed without a MAC driver having to know.


I suggested this, mostly so that drivers wouldn't have to be aware of  
this.  But I'm not quite sure what happens when you unload a module.   
Does some stuff stay behind if needed?  If you unload the ethernet  
driver, that will usually remove the bus controller for the PHY,  
which would prevent any scheduled code from accessing the PHY.


Andy


