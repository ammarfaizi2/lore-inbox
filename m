Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVDBSGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVDBSGi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 13:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVDBSGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 13:06:37 -0500
Received: from ida.rowland.org ([192.131.102.52]:19460 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261718AbVDBSGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 13:06:17 -0500
Date: Sat, 2 Apr 2005 13:06:12 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.50.0503280856210.28120-100000@monsoon.he.net>
Message-ID: <Pine.LNX.4.44L0.0504021227440.1311-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat:

I looked through the new driver model code a bit more.  There appears to 
be a few problems (unless I'm using out-of-date code).

First, there's a race between adding a new device and registering a new 
driver.  The bus_add_device() routine contains these lines:

	pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
	device_attach(dev);
	klist_add_tail(&bus->klist_devices, &dev->knode_bus);

Suppose device_attach() doesn't find a suitable driver, but a new driver 
is registered before the klist_add_tail() executes.  Then the new driver 
won't see the device either, and the device won't be bound at all.  The 
last two lines above should be in the opposite order.

Second, there's no check in driver_probe_device() or higher up to prevent
probing a device that's already bound to another driver.  Such a check
needs to be synchronized with assignments to dev->driver, so it should be
made while holding dev->sem.

Third, why does device_release_driver() call klist_del() instead of 
klist_remove() for dev->knode_driver?  Is that just a simple mistake?
The klist_node doesn't seem to get unlinked anywhere.

Fourth, in device_release_driver() why isn't most of the work done under
the protection of dev->sem?  If a driver is unregistered at the same time
as a device is removed, two threads could end up executing that routine at
the same time.  Then the question would be which thread calls
klist_remove() -- not to mention the danger that both of them might.  I 
guess the answer is to call klist_remove() after releasing dev->sem.

Alan Stern

