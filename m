Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWBCRJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWBCRJS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWBCRJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:09:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:33995 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750909AbWBCRJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:09:17 -0500
Date: Fri, 3 Feb 2006 09:08:46 -0800
From: Greg KH <greg@kroah.com>
To: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION/sysfs] strange refcounting
Message-ID: <20060203170846.GA17009@kroah.com>
References: <43E365B6.4060005@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E365B6.4060005@oktetlabs.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 05:16:22PM +0300, Artem B. Bityutskiy wrote:
> Hello folks,
> 
> I'm writing a simple device driver and want to expose some of its 
> attributes to userspace via sysfs.
> 
> As usually, I have main device description structure "struct 
> mydev_info". I've embedded a struct device object there. What I do is:
> 
> struct mydev_info mydev
> {
> 	struct device *dev;

First off, this should not be a pointer, but rather:
	struct device dev;

That properly embedds the struct device into your object.

> 	... bla bla bla ...
> } mydev;
> 
> 
> mydev->dev=kzalloc(sizeof(struct device), GFP_KERNEL);
> mydev->dev->bus_id = "mydev";
> mydev->dev->release = mydev_release;
> err = device_register(&mydev->dev);

What type of bus does this device live on?  You should not be calling
device_register() on your own directly.  Either use a bus, and be a
device of it, or use the platform_device() interface.

> Then, I see /sys/devices/mydev/ in sysfs. I open pre-defined 
> /sys/devices/mydev/power/state in userspace and don't close it.
> 
> Then I run lsmod, and see zero refcount to my module. Well, I run rmmod 
> mymod, module is unloaded.

Yup.

> Then I close /sys/devices/mydev/power/state, and enjoy segfault.

What is the backtrace?

> I thought sysfs subsystem have to increase module refcount when one 
> opens its sysfs files. Well, there is a release function, but it is also 
> unloaded with the module.

Again, register with a bus or use the platform_device() interface, and
this should work properly.

> May be there is a problem because of I have mydev->dev->parent == NULL, 
> mydev->dev->bus == NULL, mydev->dev->driver == NULL? But I really don't 
> have any bus, any parent and I don't want to introduce struct 
> device_driver ...

Yes, you kind of need all of that :)

Make the above changes and let us know if that helps things.

thanks,

greg k-h
