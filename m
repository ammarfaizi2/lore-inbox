Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266824AbUFRUQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUFRUQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266816AbUFRUPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:15:40 -0400
Received: from ida.rowland.org ([192.131.102.52]:3076 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S266815AbUFRUMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:12:36 -0400
Date: Fri, 18 Jun 2004 16:12:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: BUG(?): class_device_driver_link()
Message-ID: <Pine.LNX.4.44L0.0406181502020.702-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

I'm not sure if this is a bug or not, but it is inconsistent behavior in 
sysfs.

When a class_device is added, if it has a regular device associated with
it and that device has a driver, a symlink is added from the class_device
to the driver.  However, if the class_device is added _first_ and the
driver later, this symlink is not created.  It's not clear that there's
any good way to create it, especially if the class_device is added by the
bus layer and the device driver itself is unaware of the class_device.

Is this a known problem?  It definitely affects the sd driver, and maybe 
others.

There is a related side-effect that is a bit unpleasant.  The symlink from
the class_device to the driver increments the driver's refcount.  Since
the driver is unaware of the class_device, it doesn't know to remove the
symlink when its release() method runs.  Consequently, if the driver is
modprobed before the device exists and rmmod'ed after the device is added,
the rmmod will hang until the device also goes away.  But if the driver is 
modprobed _after_ the device exists then the rmmod will complete 
immediately.

Perhaps the answer is that the bus layer must take these things into 
account.  Or perhaps a struct device should somehow know about all the 
class_devices that refer to it.

Alan Stern


