Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVCPXXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVCPXXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbVCPXW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:22:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:4794 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262857AbVCPXTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:19:38 -0500
Subject: Re: [PATCH 2/2] Thinkpad Suspend Powersave: Add D2 power saving
	code for Thinkpads with Radeon video chipsets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, "Brown, Len" <len.brown@intel.com>,
       Volker Braun <volker.braun@physik.hu-berlin.de>
In-Reply-To: <3.518178082@mit.edu>
References: <3.518178082@mit.edu>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 10:19:04 +1100
Message-Id: <1111015144.15510.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-16 at 10:16 -0500, Theodore Y. Ts'o wrote:
> Force the Radeon video chipset on IBM Thinkpads to use the D2 state when
> suspending in order to save a much greater amount of power.
> 
> This patch is based on an earlier version by Volker Braun, but instead
> of using an explicit whitelist that would have to contain hundreds of
> entries, instead we enable going to the D2 state for IBM Thinkpads if a
> CONFIG_EXPERIMENTAL option (CONFIG_FB_RADEON_THINKPAD_PM) is enabled and
> use a black-list if necessary.
> 
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

You probably want to remove the bit that does

	OUTREG(TV_DAC_CNTL, INREG(TV_DAC_CNTL) | 0x07000000);

Or you'll lose TV output :)

Ben.

> 
> Index: src/drivers/video/Kconfig
> ===================================================================
> --- src.orig/drivers/video/Kconfig	2005-03-14 12:40:48.000000000 -0500
> +++ src/drivers/video/Kconfig	2005-03-16 00:40:21.000000000 -0500
> @@ -711,6 +711,15 @@
>  	help
>  	  Say Y here if you want DDC/I2C support for your Radeon board. 
>  
> +config FB_RADEON_THINKPAD_PM
> +	bool "Video Power Management for Thinkpads (EXPERIMENTAL)"
> +	depends on PM && FB_RADEON && X86 && EXPERIMENTAL
> +	default n
> +	help
> +	  Say Y here if you want to force the Radeon video chipset on 
> +	  IBM Thinkpads to use the D2 state when suspending in order to
> +	  save a much greater amount of power.
> +
>  config FB_RADEON_DEBUG
>  	bool "Lots of debug output from Radeon driver"
>  	depends on FB_RADEON
> Index: src/drivers/video/aty/radeon_base.c
> ===================================================================
> --- src.orig/drivers/video/aty/radeon_base.c	2005-03-14 12:40:48.000000000 -0500
> +++ src/drivers/video/aty/radeon_base.c	2005-03-14 12:40:48.000000000 -0500
> @@ -273,6 +273,9 @@
>  #ifdef CONFIG_MTRR
>  static int nomtrr = 0;
>  #endif
> +#ifdef CONFIG_FB_RADEON_THINKPAD_PM
> +int radeon_force_sleep = 0;
> +#endif
>  
>  /*
>   * prototypes
> @@ -2535,6 +2538,10 @@
>  			force_measure_pll = 1;
>  		} else if (!strncmp(this_opt, "ignore_edid", 11)) {
>  			ignore_edid = 1;
> +#ifdef CONFIG_FB_RADEON_THINKPAD_PM
> +		} else if (!strncmp(this_opt, "force_sleep", 11)) {
> +			radeon_force_sleep = 1;
> +#endif
>  		} else
>  			mode_option = this_opt;
>  	}
> @@ -2574,3 +2581,7 @@
>  MODULE_PARM_DESC(panel_yres, "int: set panel yres");
>  module_param(mode_option, charp, 0);
>  MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
> +#ifdef CONFIG_FB_RADEON_THINKPAD_PM
> +module_param(radeon_force_sleep, int, 0);
> +MODULE_PARM_DESC(radeon_force_sleep, "bool: force ACPI sleep mode on untested machines");
> +#endif
> Index: src/drivers/video/aty/radeon_pm.c
> ===================================================================
> --- src.orig/drivers/video/aty/radeon_pm.c	2005-03-14 12:40:48.000000000 -0500
> +++ src/drivers/video/aty/radeon_pm.c	2005-03-14 12:40:48.000000000 -0500
> @@ -27,6 +27,27 @@
>  
>  #include "ati_ids.h"
>  
> +#ifdef CONFIG_FB_RADEON_THINKPAD_PM
> +#include <linux/dmi.h>
> +
> +static struct dmi_system_id __devinitdata radeonfb_dmi_table[] = {
> +	{
> +		.ident = "IBM ThinkPad",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
> +		},
> +	},
> +	{ },
> +};
> +
> +static struct dmi_system_id __devinitdata radeonfb_dmi_blacklist[] = {
> +	{ },
> +};
> +
> +extern int radeon_force_sleep;
> +#endif
> +
>  void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
>  {
>  	u32 tmp;
> @@ -2750,6 +2771,30 @@
>  #endif
>  	}
>  #endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_OF) */
> +
> +	/* The PM code also seems to work on many IBM ThinkPad models, 
> +	 * but of course Your Mileage May Vary.
> +	 */
> +#ifdef CONFIG_FB_RADEON_THINKPAD_PM
> +	if (radeon_force_sleep || 
> +	    (rinfo->is_mobility && rinfo->pm_reg &&
> +	     (rinfo->family <= CHIP_FAMILY_RV250) &&
> +	     dmi_check_system(radeonfb_dmi_table) && 
> +	     !dmi_check_system(radeonfb_dmi_blacklist))) {
> +		if (radeon_force_sleep)
> +			printk("radeonfb: forcefully enabling sleep mode\n");
> +		else
> +			printk("radeonfb: enabling sleep mode\n");
> +
> +		rinfo->pm_mode |= radeon_pm_d2;
> +
> +		/* Power down TV DAC, that saves a significant amount of power,
> +		 * we'll have something better once we actually have some TVOut
> +		 * support
> +		 */
> +		OUTREG(TV_DAC_CNTL, INREG(TV_DAC_CNTL) | 0x07000000);
> +	}
> +#endif /* CONFIG_FB_RADEON_THINKPAD_PM */
>  }
>  
>  void radeonfb_pm_exit(struct radeonfb_info *rinfo)
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

