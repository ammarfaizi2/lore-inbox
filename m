Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUHILj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUHILj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 07:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUHILj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 07:39:27 -0400
Received: from gprs214-243.eurotel.cz ([160.218.214.243]:22144 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266487AbUHILjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:39:22 -0400
Date: Mon, 9 Aug 2004 13:38:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       david-b@pacbell.net
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040809113829.GB9793@elf.ucw.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Ok, the patch below attempts to fix up the device power management
> handling, taking into account (hopefully) everything that has been said
> over the last week+, and lessons learned over the years. It's only been
> compile-tested, and is meant just to prove that the framework is possible.
> There are likely to be some missing pieces, mainly because it's late. :)
> 
> The highlights are that it adds:
> 
> - To struct class:
> 
> 	int     (*dev_start)(struct class_device * dev);
> 	int     (*dev_stop)(struct class_device * dev);
> 
> - ->dev_stop() and ->dev_start() to struct class
>   This provides the framework to shutdown a device from a functional
>   level, rather than at a hardware level, as well as the entry points
>   to stop/start ALL devices in the system.

Hmm, that will need lots of new code to call these, right? Like
device_suspend() will now get device_stop() equivalent, etc....

>   This is implemented by iterating through the list of struct classes,
>   then through each of their struct class_device's. The class_device is
>   the only argument to those functions.

Aha, so you are saying these do not need to be done in hardware order?

Semantics of dev_stop is "may not do DMA and interrupts when stopped",
right?

> - To struct bus_type:
> 
> 	int             (*pm_power)(struct device *, struct pm_state *);
> 
>   This method is used to do all power transitions, including both
>   shutdown/reset and device power management states.
> 
> 
> The 2nd argument to ->pm_save() and ->pm_power() is determined by mapping
> an enumerated system power state to a static array of 'struct
> pm_state'

I do not think we want to see "u32 state" any more. This really needs
to be specified as "enum something" otherwise everyone will get it
wrong... again.

> pointers, that is in dev->power.pm_system. The pointers in that array
> point to entries in dev->power.pm_supports, which is an array of all the
> device power states that device supports. Please see include/linux/pm.h in
> the patch below. These arrays should be initialized by the bus, though
> they can be fixed up by the individual drivers, should they have a
> different set of states they support, or given user policy.

I'd simply pass system state down to the driver, and let them map as
they see fit... This seems to be way too complex. OTOH you are solving
'runtime suspend', too...


> ===== include/linux/pm.h 1.16 vs edited =====
> --- 1.16/include/linux/pm.h	2004-07-01 22:23:53 -07:00
> +++ edited/include/linux/pm.h	2004-08-09 02:58:59 -07:00
> @@ -222,6 +222,28 @@
>  extern int pm_suspend(u32 state);
> 
> 
> +enum {
> +	pm_sys_ON = 1,
> +	pm_sys_SHUTDOWN,
> +	pm_sys_RESET,
> +	pm_sys_STANDBY,
> +	pm_sys_SUSPEND,
> +	pm_sys_HIBERNATE,
> +	pm_sys_NUM,
> +};

I believe different state is needed for "quiesce for atomic copy" and
for "we are really going down to S4 now".


> +struct pm_state {
> +	char	* name;
> +	u32	state;
> +};

Could we get something more specific than u32 here?
> +
>  extern void device_pm_set_parent(struct device * dev, struct device * parent);
> 
>  extern int device_suspend(u32 state);
> -extern int device_power_down(u32 state);
> -extern void device_power_up(void);

Hmm, how we do "tell devices to shut off with interrupts disable", now?

>  extern void device_resume(void);
> +
> +
> +extern int device_stop(void);
> +extern int device_start(void);
> +
> +extern int device_save(u32 sys_state);
> +extern int device_restore(u32 sys_state);
> +
> +extern int device_power_up(void);
> +extern int device_power_down(u32 sys_state);

Make these u32's enums, please...
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!




