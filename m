Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUDJU3H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUDJU3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:29:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32649 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261850AbUDJU3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:29:03 -0400
Date: Sat, 10 Apr 2004 21:28:59 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, tim@cyberelk.net
Subject: Re: [PATCH 2.6] Class support for ppdev.c
Message-ID: <20040410202858.GU31500@parcelfarce.linux.theplanet.co.uk>
References: <20040410135115.GA3612@penguin.localdomain> <20040410170148.GI1317@kroah.com> <20040410180636.GB3612@penguin.localdomain> <20040410194601.GC3612@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410194601.GC3612@penguin.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 09:46:01PM +0200, Marcel Sebek wrote:
> And new updated patch. partport_find_number() needs to decrement refcount
> by parport_put_port().

And it's still broken.  New parports can appear at any point - hell, we even
have USB->parport converters.  IOW, if you want to do something useful here -
use ->attach()/->detach() of parport_driver.

>  	for (i = 0; i < PARPORT_MAX; i++) {
> -		devfs_mk_cdev(MKDEV(PP_MAJOR, i),
> +		if ((port = parport_find_number(i))) {
> +			class_simple_device_add(ppdev_class, MKDEV(PP_MAJOR, i),
> +				NULL, "parport%d", i);
> +			parport_put_port(port);
> +		}
> +		err = devfs_mk_cdev(MKDEV(PP_MAJOR, i),
>  				S_IFCHR | S_IRUGO | S_IWUGO, "parports/%d", i);
> +		if (err)
> +			goto out_class;
>  	}
>  
>  	printk (KERN_INFO PP_VERSION "\n");
> -	return 0;
> +	goto out;
> +
> +out_class:
> +	for (i = 0; i < PARPORT_MAX; i++)
> +		class_simple_device_remove(MKDEV(PP_MAJOR, i));


*raised brows*

So you are freeing the stuff you've never allocated?  Cute...
