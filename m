Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWIWVK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWIWVK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 17:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWIWVK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 17:10:57 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:29963 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750729AbWIWVK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 17:10:56 -0400
Date: Sat, 23 Sep 2006 22:10:32 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2/9] driver core fixes: device_register() retval check in platform.c
Message-ID: <20060923211032.GA4363@flint.arm.linux.org.uk>
Mail-Followup-To: Cornelia Huck <cornelia.huck@de.ibm.com>,
	Greg K-H <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20060922113655.4306a1b5@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922113655.4306a1b5@gondolin.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 11:36:55AM +0200, Cornelia Huck wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Check the return value of device_register() in platform_bus_init().
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> ---
>  drivers/base/platform.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> --- linux-2.6-CH.orig/drivers/base/platform.c
> +++ linux-2.6-CH/drivers/base/platform.c
> @@ -563,8 +563,15 @@ EXPORT_SYMBOL_GPL(platform_bus_type);
>  
>  int __init platform_bus_init(void)
>  {
> -	device_register(&platform_bus);
> -	return bus_register(&platform_bus_type);
> +	int error;
> +
> +	error = device_register(&platform_bus);
> +	if (error)
> +		return error;
> +	error =  bus_register(&platform_bus_type);
> +	if (error)
> +		device_unregister(&platform_bus);
> +	return error;

I don't think there's much value in patches such as this - if the
platform bus type didn't register, what happens when we then try
to register a platform device driver or a platform device?  ISTR
doing that before the bus type is registered leads to an OOPS.

So, presumably to do this properly, if the platform_bus_type failed
to register, you need to force all platform device/platform device
driver registrations to also fail.

At that point, is the added complexity really worth it?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
