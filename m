Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVGIMUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVGIMUk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 08:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVGIMUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 08:20:39 -0400
Received: from [203.171.93.254] ([203.171.93.254]:53697 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261353AbVGIMUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 08:20:32 -0400
Subject: Re: [PATCH] [31/48] Suspend2 2.1.9.8 for 2.6.12:
	608-compression.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050709115547.GD1878@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164423992@foobar.com>
	 <20050709115547.GD1878@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120911317.7716.137.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 09 Jul 2005 22:15:17 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.

On Sat, 2005-07-09 at 21:55, Pavel Machek wrote:
> Hi!
> 
> > diff -ruNp 609-driver-model.patch-old/kernel/power/suspend2_core/driver_model.c 609-driver-model.patch-new/kernel/power/suspend2_core/driver_model.c
> > --- 609-driver-model.patch-old/kernel/power/suspend2_core/driver_model.c	1970-01-01 10:00:00.000000000 +1000
> > +++ 609-driver-model.patch-new/kernel/power/suspend2_core/driver_model.c	2005-07-04 23:14:19.000000000 +1000
> > @@ -0,0 +1,95 @@
> > +/*
> > + * kernel/power/suspend2_core/driver_model.c
> > + *
> > + * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
> > + *
> > + * This file is released under the GPLv2.
> > + *
> > + * Support for the driver model and ACPI sleep states.
> > + */
> > +
> > +#include <linux/pm.h>
> > +#include "driver_model.h"
> > +#include "power_off.h"
> > +
> > +extern struct pm_ops * pm_ops;
> > +static u32 pm_disk_mode_save;
> > +
> > +#ifdef CONFIG_ACPI
> > +static int suspend_pm_state_used = 0;
> > +extern u32 acpi_leave_sleep_state (u8 sleep_state);
> > +#endif
> > +
> > +/* suspend_drivers_init
> > + *
> > + * Store the original pm ops settings.
> > + */
> > +int suspend_drivers_init(void)
> > +{
> > +	if (pm_ops) {
> > +		pm_disk_mode_save = pm_ops->pm_disk_mode;
> > +		pm_ops->pm_disk_mode = PM_DISK_PLATFORM;
> > +	}
> > +			
> > +	return 0;
> > +}
> 
> That seems like quite an ugly hack.

Mmm. Adam and I have been discussing a more generic mechanism for
powering down, switching between states and so on. Hopefully that will
take care of these issues.

> > +/* suspend_drivers_cleanup
> > + *
> > + * Restore the original pm disk mode.
> > + */
> > +void suspend_drivers_cleanup(void)
> > +{
> > +	if (pm_ops)
> > +		pm_ops->pm_disk_mode = pm_disk_mode_save;
> > +}
> > +
> > +/* suspend_drivers_suspend
> > + *
> > + * Suspend the drivers after an atomic copy.
> > + */
> > +int suspend_drivers_suspend(int stage)
> > +{
> > +	int result = 0;
> > +	const pm_message_t state = PMSG_FREEZE;
> > +
> > +	switch (stage) {
> > +		case SUSPEND_DRIVERS_IRQS_DISABLED:
> > +			BUG_ON(!irqs_disabled());
> > +			result = device_power_down(state);
> > +			BUG_ON(!irqs_disabled());
> > +			break;
> > +
> > +		case SUSPEND_DRIVERS_IRQS_ENABLED:
> > +			BUG_ON(irqs_disabled());
> > +			result = device_suspend(state);
> > +			BUG_ON(irqs_disabled());
> > +			break;
> > +	}
> > +	return result;
> > +}
> 
> Can't you just inline these?

Yes, I could. Just trying to keep driver model stuff separate.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

