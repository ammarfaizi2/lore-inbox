Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUGLRwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUGLRwg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUGLRvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:51:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22219 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266902AbUGLRts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:49:48 -0400
Date: Sat, 10 Jul 2004 20:45:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrey Panin <pazke@donpac.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] 2.6.7-mm6, port ACPI sleep workaround to new DMI probing
Message-ID: <20040710184529.GD607@openzaurus.ucw.cz>
References: <10892897061904@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10892897061904@donpac.ru>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch moves Toshiba ACPI sleep workaround out of dmi_scan.c
> 
> Please consider applying.

Looks good to me.

BTW it probably could be removed completely as we use driver model even for S1....
But this is step in right direction, anyway.
				Pavel

> Signed-off-by: Andrey Panin <pazke@donpac.ru>
> 
>  arch/i386/kernel/dmi_scan.c |   14 --------------
>  drivers/acpi/sleep/main.c   |   29 +++++++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff -urpNX /usr/share/dontdiff linux-2.6.7-mm6.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-mm6/arch/i386/kernel/dmi_scan.c
> --- linux-2.6.7-mm6.vanilla/arch/i386/kernel/dmi_scan.c	Wed Jul  7 20:06:49 2004
> +++ linux-2.6.7-mm6/arch/i386/kernel/dmi_scan.c	Wed Jul  7 21:27:22 2004
> @@ -195,16 +195,6 @@ static __init int broken_toshiba_keyboar
>  	return 0;
>  }
>  
> -/*
> - * Toshiba fails to preserve interrupts over S1
> - */
> -
> -static __init int init_ints_after_s1(struct dmi_blacklist *d)
> -{
> -	printk(KERN_WARNING "Toshiba with broken S1 detected.\n");
> -	dmi_broken |= BROKEN_INIT_AFTER_S1;
> -	return 0;
> -}
>  
>  #ifdef CONFIG_ACPI_SLEEP
>  static __init int reset_videomode_after_s3(struct dmi_blacklist *d)
> @@ -323,10 +313,6 @@ static __initdata struct dmi_blacklist d
>  			} },
>  
>  	{ broken_toshiba_keyboard, "Toshiba Satellite 4030cdt", { /* Keyboard generates spurious repeats */
> -			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
> -			NO_MATCH, NO_MATCH, NO_MATCH
> -			} },
> -	{ init_ints_after_s1, "Toshiba Satellite 4030cdt", { /* Reinitialization of 8259 is needed after S1 resume */
>  			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
>  			NO_MATCH, NO_MATCH, NO_MATCH
>  			} },
> diff -urpNX /usr/share/dontdiff linux-2.6.7-mm6.vanilla/drivers/acpi/sleep/main.c linux-2.6.7-mm6/drivers/acpi/sleep/main.c
> --- linux-2.6.7-mm6.vanilla/drivers/acpi/sleep/main.c	Wed Jul  7 20:07:14 2004
> +++ linux-2.6.7-mm6/drivers/acpi/sleep/main.c	Wed Jul  7 21:26:15 2004
> @@ -10,6 +10,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/irq.h>
> +#include <linux/dmi.h>
>  #include <linux/device.h>
>  #include <linux/suspend.h>
>  #include <acpi/acpi_bus.h>
> @@ -30,6 +31,8 @@ static u32 acpi_suspend_states[] = {
>  	[PM_SUSPEND_DISK]	= ACPI_STATE_S4,
>  };
>  
> +static int init_8259A_after_S1;
> +
>  /**
>   *	acpi_pm_prepare - Do preliminary suspend work.
>   *	@pm_state:		suspend state we're entering.
> @@ -140,7 +143,7 @@ static int acpi_pm_finish(u32 pm_state)
>  	/* reset firmware waking vector */
>  	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
>  
> -	if (dmi_broken & BROKEN_INIT_AFTER_S1) {
> +	if (init_8259A_after_S1) {
>  		printk("Broken toshiba laptop -> kicking interrupts\n");
>  		init_8259A(0);
>  	}
> @@ -161,16 +164,38 @@ int acpi_suspend(u32 acpi_state)
>  	return -EINVAL;
>  }
>  
> -
>  static struct pm_ops acpi_pm_ops = {
>  	.prepare	= acpi_pm_prepare,
>  	.enter		= acpi_pm_enter,
>  	.finish		= acpi_pm_finish,
>  };
>  
> +
> +/*
> + * Toshiba fails to preserve interrupts over S1, reinitialization 
> + * of 8259 is needed after S1 resume.
> + */
> +static int __init init_ints_after_s1(struct dmi_system_id *d)
> +{
> +	printk(KERN_WARNING "%s with broken S1 detected.\n", d->ident);
> +	init_8259A_after_S1 = 1;
> +	return 0;
> +}
> +
> +static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
> +	{	
> +		.callback = init_ints_after_s1,
> +		.ident = "Toshiba Satellite 4030cdt",
> +		.matches = { DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"), },
> +	},
> +	{ },
> +};
> +
>  static int __init acpi_sleep_init(void)
>  {
>  	int			i = 0;
> +
> +	dmi_check_system(acpisleep_dmi_table);
>  
>  	if (acpi_disabled)
>  		return 0;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

