Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWBRBqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWBRBqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWBRBqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:46:00 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:1948 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750729AbWBRBp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:45:59 -0500
Date: Fri, 17 Feb 2006 17:45:41 -0800
From: Greg KH <greg@kroah.com>
To: linux-parport@lists.infradead.org, philb@gnu.org, tim@cyberelk.net,
       andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] register sysfs device for lp devices
Message-ID: <20060218014541.GA17364@kroah.com>
References: <20060217113836.GA26254@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217113836.GA26254@pcpool00.mathematik.uni-freiburg.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 12:38:36PM +0100, Bernhard R. Link wrote:
> Give class_device_create a device pointer parport drivers
> can set via a new parport_set_dev.
> Also patch parport_gsci and parport_pc as example.
> 
> Signed-of-by: Bernhard R Link <brlink@debian.org>
> 
> ---
> 
> Compile and run-tested with linux-2.6.16-rc3-git4.
> 
> Index: mlinux-2.6.15-git12/drivers/char/lp.c
> ===================================================================
> --- mlinux-2.6.15-git12.orig/drivers/char/lp.c	2006-02-10 08:22:48.000000000 +0100
> +++ mlinux-2.6.15-git12/drivers/char/lp.c	2006-02-13 14:46:29.000000000 +0100
> @@ -805,7 +805,7 @@
>  	if (reset)
>  		lp_reset(nr);
>  
> -	class_device_create(lp_class, NULL, MKDEV(LP_MAJOR, nr), NULL,
> +	class_device_create(lp_class, NULL, MKDEV(LP_MAJOR, nr), port->dev,
>  				"lp%d", nr);
>  	devfs_mk_cdev(MKDEV(LP_MAJOR, nr), S_IFCHR | S_IRUGO | S_IWUGO,
>  			"printers/%d", nr);
> Index: mlinux-2.6.15-git12/drivers/parport/parport_gsc.c
> ===================================================================
> --- mlinux-2.6.15-git12.orig/drivers/parport/parport_gsc.c	2006-02-13 14:27:53.000000000 +0100
> +++ mlinux-2.6.15-git12/drivers/parport/parport_gsc.c	2006-02-13 14:46:29.000000000 +0100
> @@ -340,6 +340,9 @@
>  	parport_gsc_write_data(p, 0);
>  	parport_gsc_data_forward (p);
>  
> +	/* Tell sysfs which device is behind this parport */
> +	parport_set_dev (p, &dev->dev);
> +
>  	/* Now that we've told the sharing engine about the port, and
>  	   found out its characteristics, let the high-level drivers
>  	   know about it. */
> Index: mlinux-2.6.15-git12/drivers/parport/parport_pc.c
> ===================================================================
> --- mlinux-2.6.15-git12.orig/drivers/parport/parport_pc.c	2006-02-13 14:30:26.000000000 +0100
> +++ mlinux-2.6.15-git12/drivers/parport/parport_pc.c	2006-02-13 14:46:29.000000000 +0100
> @@ -2340,6 +2340,7 @@
>  	spin_lock(&ports_lock);
>  	list_add(&priv->list, &ports_list);
>  	spin_unlock(&ports_lock);
> +	parport_set_dev (p, &dev->dev);
>  	parport_announce_port (p);
>  
>  	return p;
> Index: mlinux-2.6.15-git12/drivers/parport/share.c
> ===================================================================
> --- mlinux-2.6.15-git12.orig/drivers/parport/share.c	2006-02-13 14:30:26.000000000 +0100
> +++ mlinux-2.6.15-git12/drivers/parport/share.c	2006-02-13 14:46:29.000000000 +0100
> @@ -341,6 +341,11 @@
>  
>  	tmp->waithead = tmp->waittail = NULL;
>  
> +	/*
> +	 * no sysfs device known unless the announcer sets it before
> +	 */
> +	tmp->dev = NULL;
> +

This is not needed, as tmp is zeroed out earlier in the function.


>  	return tmp;
>  }
>  
> Index: mlinux-2.6.15-git12/include/linux/parport.h
> ===================================================================
> --- mlinux-2.6.15-git12.orig/include/linux/parport.h	2006-02-13 14:30:42.000000000 +0100
> +++ mlinux-2.6.15-git12/include/linux/parport.h	2006-02-13 14:46:29.000000000 +0100
> @@ -258,6 +258,7 @@
>  	struct semaphore irq;
>  };
>  
> +struct device;
>  /* A parallel port */
>  struct parport {
>  	unsigned long base;	/* base address */
> @@ -313,6 +314,8 @@
>  
>  	struct list_head full_list;
>  	struct parport *slaves[3];
> +
> +	struct device *dev; /* for the sysfs device symlink */
>  };
>  
>  #define DEFAULT_SPIN_TIME 500 /* us */
> @@ -331,6 +334,10 @@
>  struct parport *parport_register_port(unsigned long base, int irq, int dma,
>  				      struct parport_operations *ops);
>  
> +/* parport_set_dev set the generic device behind this port, so drivers
> + * can display it in their sysfs nodes */
> +#define parport_set_dev(port,devptr) ((port)->dev = (devptr))

If you are going to save off a pointer to a structure, you need to
increment it's reference count.  You aren't doing that here, and bad
things might happen if it gets removed from under you :(

thanks,

greg k-h
