Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267870AbUG3WmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267870AbUG3WmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267867AbUG3WmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:42:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:26501 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267477AbUG3Wkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:40:39 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       David Brownell <david-b@pacbell.net>, dbrownell@users.sourceforge.net
In-Reply-To: <20040730164413.GB4672@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1091227170.7389.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 08:39:30 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 02:44, Pavel Machek wrote:
> Hi!
> 
> There's quite big confusion what 'u32 state' in suspend callbacks
> mean. Half code interprets it as a system-wide suspend level, and
> second half thinks it is PCI Dx state. Bad.
> 
> What about this solution:
> 
> * system-wide suspend level is always passed down (it is more
> detailed, and for example IDE driver cares)
> 
> * if you want to derive Dx state, just use provided inline function to
> convert.
> 
> That should be acceptable to everyone. I plan on explicitly using
> enums to prevent further confusion. Patch is likely to be pretty big:
> ideally all prototypes of suspend function would be fixed so noone can
> be confused.
> 
> What do you think?

Your constants are ugly ;) But the whole idea makes sense, I've started
implementing something on my side, though I didn't change the u32 to an
enum to avoid having to "fix" bazillions of drivers. Proper
documentation may just be enough...
								Pavel
> PS: I'll be on holidays for a week, feel free to implement this or
> something similar.. it is going to be lot of search/replace in drivers
> :-(.

I'll have some patches soon along with the PPC stuff.


> --- tmp/linux/include/linux/pci.h	2004-06-22 12:36:45.000000000 +0200
> +++ linux/include/linux/pci.h	2004-07-30 18:24:02.000000000 +0200
> @@ -593,7 +593,7 @@
>  	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
>  	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
>  	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
> -	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
> +	int  (*suspend) (struct pci_dev *dev, enum suspend_state reason);	/* Device suspended */
>  	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
>  	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
>  
> --- tmp/linux/include/linux/pm.h	2004-06-22 12:36:45.000000000 +0200
> +++ linux/include/linux/pm.h	2004-07-30 18:23:11.000000000 +0200
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
> @@ -241,11 +240,47 @@
>  
>  extern void device_pm_set_parent(struct device * dev, struct device * parent);
>  
> -extern int device_suspend(u32 state);
> -extern int device_power_down(u32 state);
> +enum suspend_state {
> +	SNAPSHOT = 10,		/* For debugging, symbolic constants should be everywhere */
> +	POWERDOWN,
> +	RESTART,
> +	RUNTIME_D1,
> +	RUNTIME_D2,
> +	RUNTIME_D3hot,
> +	RUNTIME_D3cold
> +};
> +
> +extern int device_suspend(enum suspend_state reason);
> +extern int device_power_down(enum suspend_state reason);
>  extern void device_power_up(void);
>  extern void device_resume(void);
>  
> +enum pci_state {
> +	D0 = 20,		/* For debugging, symbolic constants should be everywhere */
> +	D1,
> +	D2,
> +	D3hot,
> +	D3cold
> +};
> +
> +static inline enum pci_state to_pci_state(enum suspend_state state)
> +{
> +	switch(state) {
> +	case RUNTIME_D1:
> +		return D1;
> +	case RUNTIME_D2:
> +		return D2;
> +	case RUNTIME_D3hot:
> +		return D3hot;
> +	case SNAPSHOT:
> +	case POWERDOWN:
> +	case RESTART:
> +	case RUNTIME_D3cold:
> +		return D3cold;
> +	default:
> +		BUG();
> +	}
> +}
>  
>  #endif /* __KERNEL__ */
>  
> --- tmp/linux/kernel/power/disk.c	2004-05-20 23:08:36.000000000 +0200
> +++ linux/kernel/power/disk.c	2004-07-30 18:18:04.000000000 +0200
> @@ -46,20 +46,25 @@
>  	int error = 0;
>  
>  	local_irq_save(flags);
> -	device_power_down(PM_SUSPEND_DISK);
>  	switch(mode) {
>  	case PM_DISK_PLATFORM:
> +		device_power_down(POWERDOWN);
>  		error = pm_ops->enter(PM_SUSPEND_DISK);
>  		break;
>  	case PM_DISK_SHUTDOWN:
> +		device_power_down(POWERDOWN);
>  		printk("Powering off system\n");
>  		machine_power_off();
>  		break;
>  	case PM_DISK_REBOOT:
> +		device_power_down(RESTART);
>  		machine_restart(NULL);
>  		break;
>  	}
>  	machine_halt();
> +	/* Valid image is on the disk, if we continue we risk serious data corruption
> +	   after resume. */
> +	while(1);
>  	device_power_up();
>  	local_irq_restore(flags);
>  	return 0;
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

