Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbULVQQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbULVQQi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 11:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbULVQQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 11:16:37 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:63881 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262011AbULVQQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 11:16:31 -0500
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] USB: fix Scheduling while atomic warning when resuming.
Date: Wed, 22 Dec 2004 08:16:42 -0800
User-Agent: KMail/1.7.1
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
References: <200412220103.iBM13wS0002158@hera.kernel.org> <41C905C0.9000705@pobox.com> <1103716768.28670.61.camel@gaston>
In-Reply-To: <1103716768.28670.61.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412220816.42350.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 December 2004 3:59 am, Benjamin Herrenschmidt wrote:
> 
> > Similarly, If the USB layer is calling into your driver while you are 
> > resuming, something is broken and it ain't your locking.
> 
> Actually, the later isn't broken, something may well call into the
> higher level USB drivers while resuming, but indeed, those shouldn't
> send any URB down the stack when the bus is suspended, and the EHCI
> driver should drop incoming URBs as well until fully resumed.

Well, not "drop" like the network layer might, but report an error;
if the bus is suspended, so are all its devices and drivers.  When
a USB device is suspended, all its endpoint queues should be empty.
(And devices can be suspended without the bus being suspended...)

Such checks should be part of usbcore, not just one HCD, but we're
still working towards better interfaces there.  It's excessively
painful to write HCDs.


> I think the lock here is only needed to protect the HCD state
> transitions David, no ?

State transitions and access to hardware.  There are a few other
code paths that can trigger state transitions then, like rmmod.
And Alan's pointed out that we'll be wanting autoresume mechanisms,
so that parent hubs implicitly wake up as needed.

One thing we don't have right now is a per-HCD spinlock that
usbcore has access to.  Periodically I wonder whether such a
lock might help sort some of these issues out.


> All we need is make sure that we don't let 
> things get queued (or call into EHCI code path that will end up
> touch the HW) while suspended.

That lock protects all HCD code paths that touch HW,
As well as the state transitions.  I don't recall that
any other state transitions require such a long delay,
except maybe initialization (which happens before the
upper levels of the USB stack see the controller).

- Dave
