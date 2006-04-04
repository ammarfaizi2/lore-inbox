Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWDDTOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWDDTOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWDDTOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:14:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:30889 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750817AbWDDTOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:14:30 -0400
Date: Tue, 4 Apr 2006 09:48:23 -0700
From: Greg KH <greg@kroah.com>
To: "Artem B. Bityutskiy" <dedekind@yandex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: device model and character devices
Message-ID: <20060404164823.GA31398@kroah.com>
References: <44322A6F.4000402@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44322A6F.4000402@yandex.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 12:12:31PM +0400, Artem B. Bityutskiy wrote:
> Hello Greg,
> 
> at the moment the device model and the character devices subsystem are 
> distinct and different things. I mean, if I have a device xdev, I do the 
> following:
> 
> struct xdev_device {
> 	struct cdev cdev;
> 	struct device dev;
> 	/* xdev-specific stuff */
> 	...
> } xdev;
> 
> I use xdev.cdev to register character device:
> 
> cdev_add(&xdev.cdev, ...);
> ...
> 
> I use xdev.dev functions to include my device to the device-model:
> 
> device_register(&xdev.dev, ...);
> ...
> 
> But why not to merge the character device stuff and the device model? 
> Roughly speaking, why not to embed 'struct cdev' to 'struct device'? Why 
> do driver writers have to distinguish between these things?

Because "struct device" generally is not related to a major:minor pair
at all.  That is what a struct class_device is for.  Lots of struct
device users have nothing to do with a char device, and some have
multiple char devices associated with a single struct device.

You need to create a struct class_device in order to export the proper
information to userspace so that udev and other tools can pick up the
fact that your device is present and it needs to create a device for it.

All that being said, yes, there is a disconnect between the driver model
parts and the char subsystem.  It's been something that I've wanted to
fix for a number of years, but never had the time to do so.  If you want
to work toward doing this, I'd be glad to review any patches.

thanks,

greg k-h
