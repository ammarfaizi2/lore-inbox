Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290386AbSA3SaR>; Wed, 30 Jan 2002 13:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290376AbSA3S0F>; Wed, 30 Jan 2002 13:26:05 -0500
Received: from air-1.osdl.org ([65.201.151.5]:25245 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S290370AbSA3SZq>;
	Wed, 30 Jan 2002 13:25:46 -0500
Date: Wed, 30 Jan 2002 10:26:50 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Greg KH <greg@kroah.com>
cc: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driverfs support for USB - take 2
In-Reply-To: <20020130002418.GB21784@kroah.com>
Message-ID: <Pine.LNX.4.33.0201301018580.800-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Greg KH wrote:

> Hi,
> 
> Well after determining that the last version of this patch doesn't show
> the USB tree properly, here's another patch against 2.5.3-pre6 that
> fixes this issue.
> 
> With this patch (the driver core changes were from Pat Mochel, thanks
> Pat for putting up with my endless questions) my machine now shows the
> following tree:

This is great! Thanks to Greg for testing and providing feedback. 


One question:

>     |   |   |-- 01:0d.1
>     |   |   |   |-- power
>     |   |   |   |-- status
>     |   |   |   `-- usb_bus
>     |   |   |       |-- 003
>     |   |   |       |   |-- power
>     |   |   |       |   `-- status
>     |   |   |       |-- power
>     |   |   |       `-- status

You have a PCI device that is the USB controller. You create a child of 
that represents the USB bus. Then, devices are added as children of that.

Logically, couldn't you skip that extra layer of indirection and make USB 
devices children of the USB controller? Or, do you see benefit in the 
explicit distinction?



> diff -Nru a/include/linux/device.h b/include/linux/device.h
> --- a/include/linux/device.h	Tue Jan 29 16:02:26 2002
> +++ b/include/linux/device.h	Tue Jan 29 16:02:26 2002
> @@ -66,10 +66,8 @@
>  
>  struct device {
>  	struct list_head node;		/* node in sibling list */
> -	struct iobus	*parent;	/* parent bus */
> -
> -	struct iobus	*subordinate;	/* only valid if this device is a
> -					   bridge device */
> +	struct list_head children;
> +	struct device 	*parent;

(To everyone else)

Note this change: This patch removed struct iobus, so that everything 
becomes a device and only a device. A 'bus' is simply a device that has 
children. 

This concept is something that I have argued both for and against since I 
started on this. Initially, the goal was to separate the two because they 
followed such different semantics. 

But, I've found it, IMO, it creates more problems than it solves. There 
was/is a lot of code replication just because you want to do the same 
thing to each object, but have two different pointer types to deal with. 

And, it's quite easy to add extra semantics for devices that have 
children. 

	-pat

