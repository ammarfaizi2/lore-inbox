Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbUKDR51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbUKDR51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbUKDRzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:55:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:7577 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262279AbUKDRxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:53:44 -0500
Date: Thu, 4 Nov 2004 09:53:19 -0800
From: Greg KH <greg@kroah.com>
To: Tejun Heo <tj@home-tj.org>
Cc: rusty@rustcorp.com.au, mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 0/4] driver-model: manual device attach
Message-ID: <20041104175318.GH16389@kroah.com>
References: <20041104074330.GG25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104074330.GG25567@home-tj.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 04:43:30PM +0900, Tejun Heo wrote:
>  Hello, again. :-)
> 
>  These are the manual device attach patches I was talking about in the
> previous posting.  These patches need devparam patches to be applied
> first.  It's composed of two parts.
> 
>  1. sysctl node dev.autoattach
> 
>  dev.autoattach is read/write integer sysctl node which controls
> driver-model's behavior regarding device - driver association.

Ick, no new sysctls please.  Make this a per-bus attribute that gets
written to in sysfs.  Much nicer and much finer control then.

>  0: autoattach disabled.  devices are not associated with drivers
>     automatically.  i.e. insmod'ing e100.ko won't cause it to attach to the
>     actual e100 devices.
>  1: autoattach enabled.  The default value.  This is the same as the
>     current driver model behavior.  Driver model automatically associates
>     devices to drivers.
>  2: rescan command.  If this value is written, bus_rescan_devices() is
>     invoked for all the registered bus types; thus attaching all
>     devices to available drivers.  After rescan is complete, the
>      autoattach value is set to 1.

Make this a different sysfs file.  "rescan" would be good.

Look at how pci can handle adding new devices to their drivers from
sysfs.  If we can move that kind of functionality to the driver core, so
that all busses get it (it will require a new per-bus callback though,
se the other patches recently posted to lkml for an example of this),
that would be what I would like to see happen.

>  2. per-device attach and detach sysfs node.
> 
>  Two files named attach and detach are created under each device's
> sysfs directory.  Reading attach node shows the name of applicable
> drivers.

How does a device know what drivers could be bound to it?  It's the
other way around, drivers know what kind of devices they can bind to.
Let's add the ability to add more devices to a driver through sysfs,
again, like PCI does.

> Writing a driver name attaches the device to the driver.

No, do it the other way, attach a driver to a device.

thanks,

greg k-h
