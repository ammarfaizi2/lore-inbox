Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVC2QSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVC2QSZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVC2QSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:18:24 -0500
Received: from ida.rowland.org ([192.131.102.52]:3844 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261181AbVC2QSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:18:17 -0500
Date: Tue, 29 Mar 2005 11:18:13 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.50.0503280856210.28120-100000@monsoon.he.net>
Message-ID: <Pine.LNX.4.44L0.0503291055560.1038-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005, Patrick Mochel wrote:

> How is this related to (8) above? Do you need some sort of protected,
> short path through the core to add the device, but not bind it or add it
> to the PM core?

Having thought it through, I believe all we need for USB support is this:

	Whenever usb_register() in the USB core calls driver_register() 
	and the call filters down to driver_attach(), that routine
	should lock dev->parent->sem before calling driver_probe_device()
	(and unlock it afterward, of course).

	(For the corresponding remove pathway, where usb_deregister()
	calls driver_unregister(), it would be nice if __remove_driver()
	locked dev->parent->sem before calling device_release_driver().
	This is not really needed, however, since USB drivers aren't
	supposed to touch the device in their disconnect() method.)

With that change in place we can guarantee that every time a USB driver's 
probe() is called, both the interface and the parent device are locked.

I don't know how cleanly this can be implemented.  You probably don't want 
to lock dev->parent->sem every time, only when needed.  Maybe the simplest 
approach would be to add a flag in struct bus_type, which could be set for 
the USB bus_type and clear for everything else.

Alan Stern

