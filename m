Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVCaQYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVCaQYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVCaQYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:24:20 -0500
Received: from ida.rowland.org ([192.131.102.52]:4612 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261541AbVCaQYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:24:17 -0500
Date: Thu, 31 Mar 2005 11:24:17 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.50.0503301814090.20992-100000@monsoon.he.net>
Message-ID: <Pine.LNX.4.44L0.0503311119010.1510-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Patrick Mochel wrote:

> > Having thought it through, I believe all we need for USB support is this:
> >
> > 	Whenever usb_register() in the USB core calls driver_register()
> > 	and the call filters down to driver_attach(), that routine
> > 	should lock dev->parent->sem before calling driver_probe_device()
> > 	(and unlock it afterward, of course).
> >
> > 	(For the corresponding remove pathway, where usb_deregister()
> > 	calls driver_unregister(), it would be nice if __remove_driver()
> > 	locked dev->parent->sem before calling device_release_driver().
> > 	This is not really needed, however, since USB drivers aren't
> > 	supposed to touch the device in their disconnect() method.)
> 
> 
> Why can't you just lock it in ->probe() and ->remove() yourself?

Aha!  There you go...  This explains why you need explicit locking rules.

When probe() and remove() are called, the driver-model core already owns
the device's lock.  If the driver then tried to lock the parent, it would
mean acquiring locks in the wrong order.  This could easily lead to
deadlock.

Furthermore, it will often happen during probe() and remove() that the
parent's lock is already owned by the USB core.  So the driver _mustn't_
try to lock it.

Alan Stern

