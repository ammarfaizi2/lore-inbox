Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760559AbWLFMbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760559AbWLFMbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760560AbWLFMbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:31:21 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2447 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760559AbWLFMbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:31:20 -0500
Date: Wed, 6 Dec 2006 12:31:15 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andy Fleming <afleming@freescale.com>
cc: Andrew Morton <akpm@osdl.org>, Ben Collins <ben.collins@ubuntu.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
In-Reply-To: <0ECFB207-7AC9-4D0D-AC9B-EEFF5A1A41EA@freescale.com>
Message-ID: <Pine.LNX.4.64N.0612061210530.29000@blysk.ds.pg.gda.pl>
References: <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <0ECFB207-7AC9-4D0D-AC9B-EEFF5A1A41EA@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006, Andy Fleming wrote:

> We need to make sure there are no more pending phy_change() invocations in the
> work queue, this is true, however I'm not convinced that this avoids the
> problem.  And now that I come back to this email after Linus's response, let
> me add that I agree with his suggestion.  I still don't think it solves the
> original problem, though.  Unless I'm missing something, Maciej's suggested
> fix (having the driver invoke phy_stop_interrupts() from a work queue) doesn't
> stop the race:
> 
> * Schedule stop_interrupts and freeing of memory.
> * interrupt occurs, and schedules phy_change
> * work_queue triggers, and stop_interrupts is invoked.  It doesn't call
> flush_scheduled_work, because it's being called from keventd.
> * The invoker of stop_interrupts (presumably some function in the driver)
> frees up memory, including the phy_device.
> * phy_change is invoked() from the work queue, and starts accessing freed
> memory

 This is not going to happen with my other changes to the file applied.  
The reason is at the time phy_stop_interrupts() is called phy_stop() has 
already run and switched the state of the PHY being handled to PHY_HALTED.  
As a result any subsequent calls to phy_interrupt() that might have 
happened after phy_stop() have not scheduled calls to phy_change() for 
this PHY as will not any that may happen up until free_irq() have 
unregistered the interrupt for the PHY.

> I suggested this, mostly so that drivers wouldn't have to be aware of this.
> But I'm not quite sure what happens when you unload a module.  Does some stuff
> stay behind if needed?  If you unload the ethernet driver, that will usually
> remove the bus controller for the PHY, which would prevent any scheduled code
> from accessing the PHY.

 Hmm, I am unsure if there is anything that would ensure flushing of the 
queue after its stop() call has finished and before a driver is removed 
(its module_exit() call is invoked), probably nothing, and that is why I 
put explicit flush_scheduled_work() in sb1250-mac.c:sbmac_remove() and the 
driver's open() call checks whether a possible previous instance of the 
structure used by phy_change() have not been freed yet.  There may be a 
cleaner way of doing it, but I will have to think about it.

  Maciej
