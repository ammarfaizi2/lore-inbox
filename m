Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266060AbUFJKQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266060AbUFJKQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 06:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUFJKQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 06:16:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26630 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266052AbUFJKQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 06:16:26 -0400
Date: Thu, 10 Jun 2004 11:16:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Add platform_device_register_simple
Message-ID: <20040610111623.D20006@flint.arm.linux.org.uk>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200406090221.24739.dtor_core@ameritech.net> <200406100140.30621.dtor_core@ameritech.net> <200406100142.14861.dtor_core@ameritech.net> <200406100143.53381.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200406100143.53381.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Thu, Jun 10, 2004 at 01:43:51AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 01:43:51AM -0500, Dmitry Torokhov wrote:
> ChangeSet@1.1767, 2004-06-09 23:58:52-05:00, dtor_core@ameritech.net
>   sysfs: add platform_device_register_simple() that creates a simple
>          platform device that does not manage any resources. Modules
>          using such platform devices can be unloaded without waiting
>          for the device to me released (but any additional resources
>          allocated by module should be freed beforehand).

What about platform devices which have resources associated with them?

> +struct platform_device *platform_device_register_simple(char *name, unsigned int id)
> +{
> +	struct platform_device *pdev;
> +	int retval;
> +
> +	pdev = kmalloc(sizeof(*pdev), GFP_KERNEL);
> +	if (!pdev) {
> +		retval = -ENOMEM;
> +		goto error;
> +	}
> +
> +	memset(pdev, 0, sizeof(*pdev));
> +	pdev->name = name;
> +	pdev->id = id;
> +	pdev->dev.release = platform_device_release_simple;
> +
> +	retval = platform_device_register(pdev);
> +	if (retval)
> +		goto error;
> +
> +	return pdev;
> +
> +error:
> +	kfree(pdev);
> +	return ERR_PTR(retval);

As this currently stands, you have no chance to add resources to the
platform device before it's made available to the driver.  It's likely
that any attached resources will have the same lifetime as the
device itself, so it makes sense to allocate them together with the
platform device.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
