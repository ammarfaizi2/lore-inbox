Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVFVQEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVFVQEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFVQEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:04:08 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41363 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261601AbVFVQDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:03:11 -0400
Date: Wed, 22 Jun 2005 12:03:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Stelian Pop <stelian@popies.net>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] usb sysfs intf files no longer created when
 probe fails
In-Reply-To: <1119452190.4794.6.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0506221144360.6938-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, Stelian Pop wrote:

> Notice the '1-2:1.1' is missing. Upon booting I get:
> 
> Jun 22 13:34:04 localhost kernel: HID device not claimed by input or hiddev
> Jun 22 13:34:04 localhost kernel: usbhid: probe of 1-2:1.1 failed with error -5
> Jun 22 13:34:04 localhost kernel: usb 1-2: device_add(1-2:1.1) --> -5

> Ok, there are two separate problems here:
> 
> 1. The sysfs intf entry is not created, and this causes the oops later
> when trying to remove the entry, etc.
> 
>    I've tracked this problem back to this patch: 
> 	[PATCH] driver core: fix error handling in bus_add_device
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ca2b94ba12f3c36fd3d6ed9d38b3798d4dad0d8b
> 
>    Once the patch above is reverted, I have no more oops, my driver can
> be loaded/unloaded just fine, and the /sys/devices/.../ is present.
> 
>    However, I'm not really sure if the problem comes from the above
> patch or from my driver which should manually call
> usb_create_sysfs_intf_files() or something equivalent.

You shouldn't call usb_create_sysfs_intf_files in any case.

Your driver is returning -EIO from its probe routine according to the log,
so it's not getting bound to the device.  Hence there shouldn't be any
attempt to unbind the device when your driver is removed.  This is a bug
in usbcore; it tries to delete all the interfaces without checking whether 
they were successfully added.

Alan Stern

