Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTKJJhv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 04:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbTKJJhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 04:37:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:25825 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263088AbTKJJht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 04:37:49 -0500
Date: Mon, 10 Nov 2003 01:37:03 -0800
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>, rusty@rustcorp.com.au
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: file2alias - incorrect? aliases for USB
Message-ID: <20031110093703.GA5449@kroah.com>
References: <200311092155.19924.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311092155.19924.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 09:55:19PM +0300, Andrey Borzenkov wrote:
> file2aliases puts in alias device ID high and low numbers directly from match 
> specifications. E.g. for this match table entry:
> 
> usb-storage          0x000f      0x04e6   0x0006    0x0100       0x0205 ...
> 
> it generates alias
> 
> alias usb:v04E6p0006dl0100dh0205dc*dsc*dp*ic*isc*ip* usb_storage
> 
> unfortunately real device attribute does not include high and low - rather it 
> has single device ID (as part of PRODUCT) that should be contained in these 
> bounds:
> 
>         length += snprintf (scratch, buffer_size - length, "PRODUCT=%x/%x/%x",
>                             usb_dev->descriptor.idVendor,
>                             usb_dev->descriptor.idProduct,
>                             usb_dev->descriptor.bcdDevice);
> 
> or bcdDevice file in sysfs.
> 
> This makes those aliases rather useless for the purpose of matching reported 
> device. It may take the same route as PCI and reject all device ID table 
> entries that have High != Low but there are quite a few of them available.
> 
> I am rather confused because I do not see how this condition (low <= bcdDevice 
> <= high) can be expressed using simple glob pattern (unless we are going to 
> take glob library from Zsh :)

I would suggest just ignoring the bcdDevice value, and loading all
modules that match the idVendor and idProduct values, and let the kernel
sort it out :)

So for your example, you would just:
	modprobe usb:v04E6p0006dl*dh*dc*dsc*dp*ic*isc*ip* 

Hm, but that's no good either, because the visor driver trips over that
with its entry:
	MODULE_ALIAS("usb:v*p*dl*dh*dc*dsc*dp*ic*isc*ip*");
and the improper module is loaded.  That needs to be fixed up...

Rusty, any reason why the module alias code is turning an empty
MODULE_PARAM structure, as is declared in drivers/usb/serial/visor.c
with the line:
        { },                                    /* optional parameter entry */ 

Into the above MODULE_ALIAS?  I don't think that's correct.

thanks,

greg k-h
