Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUHHRRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUHHRRV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 13:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUHHRRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 13:17:21 -0400
Received: from gprs214-135.eurotel.cz ([160.218.214.135]:11392 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265974AbUHHRRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 13:17:13 -0400
Date: Sun, 8 Aug 2004 19:16:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Solving suspend-level confusion
Message-ID: <20040808171648.GC3298@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <200408020940.14300.david-b@pacbell.net> <20040806211033.GE30518@elf.ucw.cz> <200408071623.16829.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408071623.16829.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I believe right solution is to pass system state into suspend(), and
> > provide system_to_pci_state(), so that drivers that only care about
> > PCI state can use.
> 
> So long as tools (gcc by preference, or sparse) warn about API changes,
> I can be happy.  See the attached "pmcore-0807.patch", a subset of
> yours, against a recent rc3.

It looks very good to me... Now.. who has working sparse?

But I think it should be merged ASAP, it should clean up some
confusion.

								Pavel

> Cleanup of some of the "new 2.6" suspend call path, using
> "enum system_state" rather than "u32".  This mostly just
> documents existing practice for non-PCI drivers.
> 
> 
> --- 1.16/include/linux/pm.h	Thu Jul  1 22:23:53 2004
> +++ edited/include/linux/pm.h	Sat Aug  7 14:32:44 2004
> @@ -193,11 +193,11 @@
>  extern void (*pm_idle)(void);
>  extern void (*pm_power_off)(void);
>  
> -enum {
> -	PM_SUSPEND_ON,
> -	PM_SUSPEND_STANDBY,
> -	PM_SUSPEND_MEM,
> -	PM_SUSPEND_DISK,
> +enum system_state {
> +	PM_SUSPEND_ON = 0,
> +	PM_SUSPEND_STANDBY = 1,
> +	PM_SUSPEND_MEM = 2,
> +	PM_SUSPEND_DISK = 3,
>  	PM_SUSPEND_MAX,
>  };
>  
> @@ -241,11 +241,13 @@
>  
>  extern void device_pm_set_parent(struct device * dev, struct device * parent);
>  
> -extern int device_suspend(u32 state);
> -extern int device_power_down(u32 state);
> +/*
> + * apply system suspend policy to all devices
> + */
> +extern int device_suspend(enum system_state reason);
> +extern int device_power_down(enum system_state reason);
>  extern void device_power_up(void);
>  extern void device_resume(void);
> -
>  
>  #endif /* __KERNEL__ */
>  
> --- 1.86/kernel/power/swsusp.c	Thu Jul  1 22:23:48 2004
> +++ edited/kernel/power/swsusp.c	Sat Aug  7 14:32:44 2004
> @@ -699,7 +699,7 @@
>  	else
>  #endif
>  	{
> -		device_suspend(3);
> +		device_suspend(PM_SUSPEND_DISK);
>  		device_shutdown();
>  		machine_power_off();
>  	}
> @@ -720,7 +720,7 @@
>  	mb();
>  	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
>  
> -	device_power_down(3);
> +	device_power_down(PM_SUSPEND_DISK);
>  	PRINTK( "Waiting for DMAs to settle down...\n");
>  	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
>  			   Do it with disabled interrupts for best effect. That way, if some
> @@ -789,7 +789,7 @@
>  {
>  	int is_problem;
>  	read_swapfiles();
> -	device_power_down(3);
> +	device_power_down(PM_SUSPEND_DISK);
>  	is_problem = suspend_prepare_image();
>  	device_power_up();
>  	spin_unlock_irq(&suspend_pagedir_lock);
> @@ -845,7 +845,7 @@
>  		disable_nonboot_cpus();
>  		/* Save state of all device drivers, and stop them. */
>  		printk("Suspending devices... ");
> -		if ((res = device_suspend(3))==0) {
> +		if ((res = device_suspend(PM_SUSPEND_DISK))==0) {
>  			/* If stopping device drivers worked, we proceed basically into
>  			 * suspend_save_image.
>  			 *
> @@ -1200,7 +1200,7 @@
>  		goto read_failure;
>  	/* FIXME: Should we stop processes here, just to be safer? */
>  	disable_nonboot_cpus();
> -	device_suspend(3);
> +	device_suspend(PM_SUSPEND_DISK);
>  	do_magic(1);
>  	panic("This never returns");
>  
> --- 1.7/drivers/base/power/power.h	Wed Jun  9 23:34:24 2004
> +++ edited/drivers/base/power/power.h	Sat Aug  7 14:32:44 2004
> @@ -66,14 +66,14 @@
>  /*
>   * suspend.c
>   */
> -extern int suspend_device(struct device *, u32);
> +extern int suspend_device(struct device *, enum system_state);
>  
>  
>  /*
>   * runtime.c
>   */
>  
> -extern int dpm_runtime_suspend(struct device *, u32);
> +extern int dpm_runtime_suspend(struct device *, enum system_state);
>  extern void dpm_runtime_resume(struct device *);
>  
>  #else /* CONFIG_PM */
> @@ -88,7 +88,7 @@
>  
>  }
>  
> -static inline int dpm_runtime_suspend(struct device * dev, u32 state)
> +static inline int dpm_runtime_suspend(struct device * dev, enum system_state state)
>  {
>  	return 0;
>  }
> --- 1.32/drivers/base/power/shutdown.c	Wed Jun  9 23:34:24 2004
> +++ edited/drivers/base/power/shutdown.c	Sat Aug  7 14:32:44 2004
> @@ -29,7 +29,7 @@
>  			dev->driver->shutdown(dev);
>  		return 0;
>  	}
> -	return dpm_runtime_suspend(dev, dev->detach_state);
> +	return dpm_runtime_suspend(dev, (enum system_state) dev->detach_state);
>  }
>  
>  
> --- 1.16/drivers/base/power/suspend.c	Wed Jun  9 23:34:24 2004
> +++ edited/drivers/base/power/suspend.c	Sat Aug  7 14:32:44 2004
> @@ -35,7 +35,7 @@
>   *	@state:	Power state device is entering.
>   */
>  
> -int suspend_device(struct device * dev, u32 state)
> +int suspend_device(struct device * dev, enum system_state state)
>  {
>  	int error = 0;
>  
> @@ -70,7 +70,7 @@
>   *
>   */
>  
> -int device_suspend(u32 state)
> +int device_suspend(enum system_state state)
>  {
>  	int error = 0;
>  
> @@ -112,7 +112,7 @@
>   *	done, power down system devices.
>   */
>  
> -int device_power_down(u32 state)
> +int device_power_down(enum system_state state)
>  {
>  	int error = 0;
>  	struct device * dev;


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
