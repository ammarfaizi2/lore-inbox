Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVGIL4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVGIL4q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 07:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVGIL4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 07:56:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59357 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261252AbVGILz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 07:55:58 -0400
Date: Sat, 9 Jul 2005 13:55:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [31/48] Suspend2 2.1.9.8 for 2.6.12: 608-compression.patch
Message-ID: <20050709115547.GD1878@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164423992@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164423992@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> diff -ruNp 609-driver-model.patch-old/kernel/power/suspend2_core/driver_model.c 609-driver-model.patch-new/kernel/power/suspend2_core/driver_model.c
> --- 609-driver-model.patch-old/kernel/power/suspend2_core/driver_model.c	1970-01-01 10:00:00.000000000 +1000
> +++ 609-driver-model.patch-new/kernel/power/suspend2_core/driver_model.c	2005-07-04 23:14:19.000000000 +1000
> @@ -0,0 +1,95 @@
> +/*
> + * kernel/power/suspend2_core/driver_model.c
> + *
> + * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
> + *
> + * This file is released under the GPLv2.
> + *
> + * Support for the driver model and ACPI sleep states.
> + */
> +
> +#include <linux/pm.h>
> +#include "driver_model.h"
> +#include "power_off.h"
> +
> +extern struct pm_ops * pm_ops;
> +static u32 pm_disk_mode_save;
> +
> +#ifdef CONFIG_ACPI
> +static int suspend_pm_state_used = 0;
> +extern u32 acpi_leave_sleep_state (u8 sleep_state);
> +#endif
> +
> +/* suspend_drivers_init
> + *
> + * Store the original pm ops settings.
> + */
> +int suspend_drivers_init(void)
> +{
> +	if (pm_ops) {
> +		pm_disk_mode_save = pm_ops->pm_disk_mode;
> +		pm_ops->pm_disk_mode = PM_DISK_PLATFORM;
> +	}
> +			
> +	return 0;
> +}

That seems like quite an ugly hack.

> +/* suspend_drivers_cleanup
> + *
> + * Restore the original pm disk mode.
> + */
> +void suspend_drivers_cleanup(void)
> +{
> +	if (pm_ops)
> +		pm_ops->pm_disk_mode = pm_disk_mode_save;
> +}
> +
> +/* suspend_drivers_suspend
> + *
> + * Suspend the drivers after an atomic copy.
> + */
> +int suspend_drivers_suspend(int stage)
> +{
> +	int result = 0;
> +	const pm_message_t state = PMSG_FREEZE;
> +
> +	switch (stage) {
> +		case SUSPEND_DRIVERS_IRQS_DISABLED:
> +			BUG_ON(!irqs_disabled());
> +			result = device_power_down(state);
> +			BUG_ON(!irqs_disabled());
> +			break;
> +
> +		case SUSPEND_DRIVERS_IRQS_ENABLED:
> +			BUG_ON(irqs_disabled());
> +			result = device_suspend(state);
> +			BUG_ON(irqs_disabled());
> +			break;
> +	}
> +	return result;
> +}

Can't you just inline these?

-- 
teflon -- maybe it is a trademark, but it should not be.
