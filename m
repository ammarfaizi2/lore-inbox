Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVAaUyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVAaUyG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVAaUyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:54:05 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:24074 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261359AbVAaUub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:50:31 -0500
Date: Mon, 31 Jan 2005 21:50:50 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: greg@kroah.com, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i2c-core.c: make some code static
Message-Id: <20050131215050.61c2924c.khali@linux-fr.org>
In-Reply-To: <20050131185955.GA18316@stusta.de>
References: <20050131185955.GA18316@stusta.de>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> This patch makes some needlessly global code static.
> (...)
> @@ -38,12 +38,43 @@
>  static DECLARE_MUTEX(core_lists);
>  static DEFINE_IDR(i2c_adapter_idr);
>  
> -int i2c_device_probe(struct device *dev)
> +/* match always succeeds, as we want the probe() to tell if we really
> accept this match */ +static int i2c_device_match(struct device *dev,
> struct device_driver *drv) +{
> +	return 1;
> +}
> +
> +static int i2c_bus_suspend(struct device * dev, pm_message_t state)
> +{
> +	int rc = 0;
> +
> +	if (dev->driver && dev->driver->suspend)
> +		rc = dev->driver->suspend(dev,state,0);
> +	return rc;
> +}
> +
> +static int i2c_bus_resume(struct device * dev)
> +{
> +	int rc = 0;
> +	
> +	if (dev->driver && dev->driver->resume)
> +		rc = dev->driver->resume(dev,0);
> +	return rc;
> +}
> +
> +static struct bus_type i2c_bus_type = {
> +	.name =		"i2c",
> +	.match =	i2c_device_match,
> +	.suspend =      i2c_bus_suspend,
> +	.resume =       i2c_bus_resume,
> +};
> +
> +static int i2c_device_probe(struct device *dev)
>  {
>  	return -ENODEV;
>  }
>  
> -int i2c_device_remove(struct device *dev)
> +static int i2c_device_remove(struct device *dev)
>  {
>  	return 0;
>  }
> @@ -523,38 +554,6 @@
>         up(&adap->clist_lock);
>  }
>  
> -
> -/* match always succeeds, as we want the probe() to tell if we really
> accept this match */ -static int i2c_device_match(struct device *dev,
> struct device_driver *drv) -{
> -	return 1;
> -}
> -
> -static int i2c_bus_suspend(struct device * dev, pm_message_t state)
> -{
> -	int rc = 0;
> -
> -	if (dev->driver && dev->driver->suspend)
> -		rc = dev->driver->suspend(dev,state,0);
> -	return rc;
> -}
> -
> -static int i2c_bus_resume(struct device * dev)
> -{
> -	int rc = 0;
> -	
> -	if (dev->driver && dev->driver->resume)
> -		rc = dev->driver->resume(dev,0);
> -	return rc;
> -}
> -
> -struct bus_type i2c_bus_type = {
> -	.name =		"i2c",
> -	.match =	i2c_device_match,
> -	.suspend =      i2c_bus_suspend,
> -	.resume =       i2c_bus_resume,
> -};
> -
>  static int __init i2c_init(void)
>  {
>  	int retval;

Is moving that code around really necessary? Looks to me like only the
i2c_bus_type structure needs to be moved.

Thanks,
-- 
Jean Delvare
