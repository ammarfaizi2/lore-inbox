Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbTBPL5C>; Sun, 16 Feb 2003 06:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbTBPL5C>; Sun, 16 Feb 2003 06:57:02 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11268 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266527AbTBPL47>;
	Sun, 16 Feb 2003 06:56:59 -0500
Date: Sun, 16 Feb 2003 13:05:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030216120515.GB589@elf.ucw.cz>
References: <200302091407.PAA14076@kim.it.uu.se> <20030210110108.GE2838@atrey.karlin.mff.cuni.cz> <20030210115034.GF22600@compsoc.man.ac.uk> <20030210200606.GE154@elf.ucw.cz> <20030211111231.GG53481@compsoc.man.ac.uk> <20030211120059.GB892@elf.ucw.cz> <15947.41003.250547.617866@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15947.41003.250547.617866@kim.it.uu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here is my modified version of Pavel's latest patch to convert
> apm/apic/nmi to the driver model. It's a minimalistic patch,
> intendended ONLY to convert the old-fashioned PM support code
> to the driver model. It seems to work for me, except that
> initiating a suspend (via apm --suspend) triggers a BUG_ON
> somewhere in ide-disk.c, which prevents the suspend and causes a
> hang at shutdown.



> --- linux-2.5.60/arch/i386/kernel/apm.c.~1~	2003-02-10 23:36:54.000000000 +0100
> +++ linux-2.5.60/arch/i386/kernel/apm.c	2003-02-12 21:01:51.000000000 +0100
> @@ -218,6 +218,7 @@
>  #include <linux/time.h>
>  #include <linux/sched.h>
>  #include <linux/pm.h>
> +#include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/smp.h>
>  #include <linux/smp_lock.h>
> @@ -1263,6 +1264,11 @@
>  		}
>  		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
>  	}
> +
> +	device_suspend(3, SUSPEND_NOTIFY);
> +	device_suspend(3, SUSPEND_SAVE_STATE);

Comment these two lines... and all RESTORE_STATEs. System needs to be
stopped in order for SAVE_STATE to work, and it is not in apm case.

> +static struct device_driver local_apic_nmi_driver = {
> +	.name		= "local_apic_nmi",
> +	.bus		= &system_bus_type,
> +	.resume		= nmi_resume,
> +	.suspend	= nmi_suspend,
> +};

Do you think it is neccessary to call it "*local_*apic_nmi_driver"? It
seems way too long.

> +extern struct sys_device device_local_apic;
> +
> +static struct sys_device device_local_apic_nmi = {
> +	.name		= "local_apic_nmi",
> +	.id		= 0,
> +	.dev		= {
> +		.name	= "local_apic_nmi",
> +		.driver	= &local_apic_nmi_driver,
> +		.parent = &device_local_apic.dev,
> +	},
> +};

Why did you convert device_apic_nmi to *sys_*device?

> @@ -402,3 +423,7 @@
>  		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
>  	}
>  }
> +
> +EXPORT_SYMBOL(nmi_watchdog);
> +EXPORT_SYMBOL(disable_local_apic_nmi_watchdog);
> +EXPORT_SYMBOL(enable_local_apic_nmi_watchdog);

This is good, if we have disable_, we should have enable_, not setup_;
but I killed _local_ part as it is way too long, then.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
