Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSIOGJ1>; Sun, 15 Sep 2002 02:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317861AbSIOGJ1>; Sun, 15 Sep 2002 02:09:27 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:15630 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317859AbSIOGJ0>;
	Sun, 15 Sep 2002 02:09:26 -0400
Date: Sat, 14 Sep 2002 23:10:27 -0700
From: Greg KH <greg@kroah.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Brian Craft <bcboy@thecraftstudio.com>, linux-kernel@vger.kernel.org
Subject: Re: delay before open() works
Message-ID: <20020915061026.GA484@kroah.com>
References: <20020914094225.A1267@porky.localdomain> <200209151525.01920.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209151525.01920.bhards@bigpond.net.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 03:25:01PM +1000, Brad Hards wrote:
> 
> After discussions with Oliver Neukem at Linux Kongress, the idea of a second 
> hotplug event emerges. This is signalled by the driver that actually 
> registers the interface after the interface is properly established (so in 
> your example, USB core does one call_usermode_helper(), which probably does 
> something like "modprobe scanner"; and the scanner driver does a second 
> call_usermode_helper(), which loads xsane).

This "second" hotplug event will happen when the driver registers with
the "class".  So for the example of the USB scanner driver, it registers
itself with the USB "class" to set up the file_ops structure (this is
done in usb_register_dev().  At that point in time, /sbin/hotplug will
be called again.

Ok, the scanner driver isn't the best example, as it's both a USB
device, and uses the USB class interface.  A better example would be a
USB keyboard, which would get the USB device /sbin/hotplug call when it
is first seen, and then after the driver is loaded, and registered with
the input layer, a input layer class event would be called through
/sbin/hotplug.  And right now, there is the start of input class support
in the 2.5 kernel, if people want to play with it.

> BTW: I'm not sure who actually came up with the idea - it was in the hotplug 
> BoF, but I missed this part of it.

I'm pretty sure it's documented in Pat Mochel's OLS 2002 paper.  If not,
I know we talked about it at the OLS and Kernel Summit talks about
device naming and driverfs.

> Solves this race. Unfortunately requires some janitorial work. Patch away...

I have a patch around here somewhere for this, for the USB class only,
but I've been focusing on the struct device_driver work lately.  After
that's done, I'll be adding class support (and the /sbin/hotplug class
support).  But I'd gladly accept help if anyone's offering :)

thanks,

greg k-h
