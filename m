Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbWBHDrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbWBHDrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWBHDrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:47:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:60839 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030493AbWBHDrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:47:10 -0500
Subject: Re: [PATCH] Complain if driver reenables interrupts during
	drivers_[suspend|resume] & re-disable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200602071906.55281.ncunningham@cyclades.com>
References: <200602071906.55281.ncunningham@cyclades.com>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 14:47:38 +1100
Message-Id: <1139370459.5252.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 19:06 +1000, Nigel Cunningham wrote:
> Hi all.
> 
> This patch is designed to help with diagnosing and fixing the cause of
> problems in suspending/resuming, due to drivers wrongly re-enabling
> interrupts in their .suspend or .resume methods. 
> 
> I nearly forgot about it in sending patches in suspend2 that might help
> where swsusp fails.

Ugh ? Interrupts aren't supposed to be off during resume()...

Ben.

> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> 
>  power/resume.c  |    5 +++++
>  power/suspend.c |    5 +++++
>  sys.c           |   37 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 45 insertions(+), 2 deletions(-)
> diff -ruNp 8010-driver-model-debug.patch-old/drivers/base/power/resume.c 
> 8010-driver-model-debug.patch-new/drivers/base/power/resume.c
> --- 8010-driver-model-debug.patch-old/drivers/base/power/resume.c	
> 2006-01-19 21:27:39.000000000 +1000
> +++ 8010-driver-model-debug.patch-new/drivers/base/power/resume.c	
> 2006-01-31 19:54:52.000000000 +1000
> @@ -35,6 +35,11 @@ int resume_device(struct device * dev)
>  	if (dev->bus && dev->bus->resume) {
>  		dev_dbg(dev,"resuming\n");
>  		error = dev->bus->resume(dev);
> +		if (!irqs_disabled()) {
> +			printk(KERN_EMERG "WARNING: Interrupts reenabled while resuming device 
> %s.\n",
> +				kobject_name(&dev->kobj));
> +			local_irq_disable();
> +		}
>  	}
>  	up(&dev->sem);
>  	return error;
> diff -ruNp 8010-driver-model-debug.patch-old/drivers/base/power/suspend.c 
> 8010-driver-model-debug.patch-new/drivers/base/power/suspend.c
> --- 8010-driver-model-debug.patch-old/drivers/base/power/suspend.c	
> 2006-01-19 21:27:39.000000000 +1000
> +++ 8010-driver-model-debug.patch-new/drivers/base/power/suspend.c	
> 2006-01-31 19:54:44.000000000 +1000
> @@ -58,6 +58,11 @@ int suspend_device(struct device * dev, 
>  	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
>  		dev_dbg(dev, "suspending\n");
>  		error = dev->bus->suspend(dev, state);
> +		if (!irqs_disabled()) {
> +			printk(KERN_EMERG "WARNING: Interrupts reenabled while suspending 
> device %s.\n",
> +				kobject_name(&dev->kobj));
> +			local_irq_disable();
> +		}
>  	}
>  	up(&dev->sem);
>  	return error;
> diff -ruNp 8010-driver-model-debug.patch-old/drivers/base/sys.c 
> 8010-driver-model-debug.patch-new/drivers/base/sys.c
> --- 8010-driver-model-debug.patch-old/drivers/base/sys.c	2006-01-19 
> 21:27:39.000000000 +1000
> +++ 8010-driver-model-debug.patch-new/drivers/base/sys.c	2006-01-31 
> 19:54:09.000000000 +1000
> @@ -298,16 +298,34 @@ static void __sysdev_resume(struct sys_d
>  	if (cls->resume)
>  		cls->resume(dev);
>  
> +	if (!irqs_disabled()) {
> +		printk(KERN_EMERG "WARNING: Interrupts reenabled while resuming sysdev 
> class specific driver %s.\n",
> +				kobject_name(&dev->kobj));
> +		local_irq_disable();
> +	}
> +
>  	/* Call auxillary drivers next. */
>  	list_for_each_entry(drv, &cls->drivers, entry) {
> -		if (drv->resume)
> +		if (drv->resume) {
>  			drv->resume(dev);
> +			if (!irqs_disabled()) {
> +				printk(KERN_EMERG "WARNING: Interrupts reenabled while resuming sysdev 
> class driver %s.\n",
> +				kobject_name(&dev->kobj));
> +				local_irq_disable();
> +			}
> +		}
>  	}
>  
>  	/* Call global drivers. */
>  	list_for_each_entry(drv, &sysdev_drivers, entry) {
> -		if (drv->resume)
> +		if (drv->resume) {
>  			drv->resume(dev);
> +			if (!irqs_disabled()) {
> +				printk(KERN_EMERG "WARNING: Interrupts reenabled while resuming sysdev 
> driver %s.\n",
> +				kobject_name(&dev->kobj));
> +				local_irq_disable();
> +			}
> +		}
>  	}
>  }
>  
> @@ -346,6 +364,11 @@ int sysdev_suspend(pm_message_t state)
>  			list_for_each_entry(drv, &sysdev_drivers, entry) {
>  				if (drv->suspend) {
>  					ret = drv->suspend(sysdev, state);
> +					if (!irqs_disabled()) {
> +						printk(KERN_EMERG "WARNING: Interrupts reenabled while suspending 
> sysdev driver %s.\n",
> +							kobject_name(&sysdev->kobj));
> +						local_irq_disable();
> +					}
>  					if (ret)
>  						goto gbl_driver;
>  				}
> @@ -355,6 +378,11 @@ int sysdev_suspend(pm_message_t state)
>  			list_for_each_entry(drv, &cls->drivers, entry) {
>  				if (drv->suspend) {
>  					ret = drv->suspend(sysdev, state);
> +					if (!irqs_disabled()) {
> +						printk(KERN_EMERG "WARNING: Interrupts reenabled while suspending 
> sysdev class driver %s.\n",
> +						kobject_name(&sysdev->kobj));
> +						local_irq_disable();
> +					}
>  					if (ret)
>  						goto aux_driver;
>  				}
> @@ -363,6 +391,11 @@ int sysdev_suspend(pm_message_t state)
>  			/* Now call the generic one */
>  			if (cls->suspend) {
>  				ret = cls->suspend(sysdev, state);
> +				if (!irqs_disabled()) {
> +					printk(KERN_EMERG "WARNING: Interrupts reenabled while suspending 
> class driver %s.\n",
> +					kobject_name(&sysdev->kobj));
> +					local_irq_disable();
> +				}
>  				if (ret)
>  					goto cls_driver;
>  			}

