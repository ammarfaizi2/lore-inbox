Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbULVQhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbULVQhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 11:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbULVQhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 11:37:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:61630 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262008AbULVQgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 11:36:47 -0500
Subject: Re: [PATCH] USB: fix Scheduling while atomic warning when resuming.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200412220816.42350.david-b@pacbell.net>
References: <200412220103.iBM13wS0002158@hera.kernel.org>
	 <41C905C0.9000705@pobox.com> <1103716768.28670.61.camel@gaston>
	 <200412220816.42350.david-b@pacbell.net>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 17:35:58 +0100
Message-Id: <1103733358.21771.86.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-22 at 08:16 -0800, David Brownell wrote:
> On Wednesday 22 December 2004 3:59 am, Benjamin Herrenschmidt wrote:
> > 
> > > Similarly, If the USB layer is calling into your driver while you are 
> > > resuming, something is broken and it ain't your locking.
> > 
> > Actually, the later isn't broken, something may well call into the
> > higher level USB drivers while resuming, but indeed, those shouldn't
> > send any URB down the stack when the bus is suspended, and the EHCI
> > driver should drop incoming URBs as well until fully resumed.
> 
> Well, not "drop" like the network layer might, but report an error;
> if the bus is suspended, so are all its devices and drivers.  When
> a USB device is suspended, all its endpoint queues should be empty.
> (And devices can be suspended without the bus being suspended...)

Oh sure, yes, "drop" wasn't the best choice of word, but error is what I
meant. Sorry.

> Such checks should be part of usbcore, not just one HCD, but we're
> still working towards better interfaces there.  It's excessively
> painful to write HCDs.

Yes :)
> 
> > I think the lock here is only needed to protect the HCD state
> > transitions David, no ?
> 
> State transitions and access to hardware.  There are a few other
> code paths that can trigger state transitions then, like rmmod.
> And Alan's pointed out that we'll be wanting autoresume mechanisms,
> so that parent hubs implicitly wake up as needed.
> 
> One thing we don't have right now is a per-HCD spinlock that
> usbcore has access to.  Periodically I wonder whether such a
> lock might help sort some of these issues out.
> 
> 
> > All we need is make sure that we don't let 
> > things get queued (or call into EHCI code path that will end up
> > touch the HW) while suspended.
> 
> That lock protects all HCD code paths that touch HW,
> As well as the state transitions.  I don't recall that
> any other state transitions require such a long delay,
> except maybe initialization (which happens before the
> upper levels of the USB stack see the controller).
> 
> - Dave
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

