Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWGBSjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWGBSjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWGBSjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:39:49 -0400
Received: from xenotime.net ([66.160.160.81]:9860 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932521AbWGBSjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:39:48 -0400
Date: Sun, 2 Jul 2006 11:42:33 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: akpm@osdl.org, rjw@sisk.pl, davej@redhat.com, linux-kernel@vger.kernel.org,
       sekharan@us.ibm.com, rusty@rustcorp.com.au, sam@ravnborg.org
Subject: Re: 2.6.17-mm2
Message-Id: <20060702114233.7880cf12.rdunlap@xenotime.net>
In-Reply-To: <20060702101146.GA26924@flint.arm.linux.org.uk>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	<20060624172014.GB26273@redhat.com>
	<20060624143440.0931b4f1.akpm@osdl.org>
	<200606251051.55355.rjw@sisk.pl>
	<20060625032243.fcce9e2e.akpm@osdl.org>
	<20060625081610.9b0a775a.akpm@osdl.org>
	<20060630003813.e1003a93.rdunlap@xenotime.net>
	<20060702101146.GA26924@flint.arm.linux.org.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2006 11:11:46 +0100 Russell King wrote:

> On Fri, Jun 30, 2006 at 12:38:13AM -0700, Randy.Dunlap wrote:
> > Until modpost (or whatever) can do this, here are a few that
> > a shell script has found for me by examing source code only --
> > may contain some false reports:
> > 
> > ./arch/arm/mach-at91rm9200/gpio.c:81:EXPORT_SYMBOL(at91_set_A_periph)
> > ./arch/arm/mach-at91rm9200/gpio.c:67:int __init_or_module at91_set_A_periph(unsigned pin, int use_pullup)
> > 
> > ./arch/arm/mach-at91rm9200/gpio.c:101:EXPORT_SYMBOL(at91_set_B_periph);
> > ./arch/arm/mach-at91rm9200/gpio.c:87:int __init_or_module at91_set_B_periph(unsigned pin, int use_pullup)
> > 
> > ./arch/arm/mach-at91rm9200/gpio.c:122:EXPORT_SYMBOL(at91_set_gpio_input);
> > ./arch/arm/mach-at91rm9200/gpio.c:108:int __init_or_module at91_set_gpio_input(unsigned pin, int use_pullup)
> > 
> > ./arch/arm/mach-at91rm9200/gpio.c:144:EXPORT_SYMBOL(at91_set_gpio_output);
> > ./arch/arm/mach-at91rm9200/gpio.c:129:int __init_or_module at91_set_gpio_output(unsigned pin, int value)
> > 
> > ./arch/arm/mach-at91rm9200/gpio.c:160:EXPORT_SYMBOL(at91_set_deglitch);
> > ./arch/arm/mach-at91rm9200/gpio.c:150:int __init_or_module at91_set_deglitch(unsigned pin, int is_on)
> > 
> > ./arch/arm/mach-at91rm9200/gpio.c:177:EXPORT_SYMBOL(at91_set_multi_drive);
> > ./arch/arm/mach-at91rm9200/gpio.c:166:int __init_or_module at91_set_multi_drive(unsigned pin, int is_on)
> >
> > ./arch/arm/plat-omap/mux.c:196:EXPORT_SYMBOL(omap_cfg_reg);
> > ./arch/arm/plat-omap/mux.c:58:int __init_or_module omap_cfg_reg(const unsigned long index)
> > 
> 
> These would appear to be false:
> 
> #ifdef CONFIG_MODULES
> #define __init_or_module
> #define __initdata_or_module
> #else
> #define __init_or_module __init
> #define __initdata_or_module __initdata
> #endif /*CONFIG_MODULES*/
> 
> and:
> 
> #else /* !CONFIG_MODULES... */
> #define EXPORT_SYMBOL(sym)
> #define EXPORT_SYMBOL_GPL(sym)
> #define EXPORT_SYMBOL_GPL_FUTURE(sym)
> #define EXPORT_UNUSED_SYMBOL(sym)
> #define EXPORT_UNUSED_SYMBOL_GPL(sym)
> 
> means that in the modules case, they aren't marked as __init and are
> exported, but in the non-modular case they are marked as __init but
> not exported.
> 
> Hence, export symbols marked as __init_or_module is safe.

Thanks for checking + feedback.

> > ./arch/arm/mach-imx/generic.c:196:EXPORT_SYMBOL(imx_set_mmc_info);
> > ./arch/arm/mach-imx/generic.c:192:void __init imx_set_mmc_info(struct imxmmc_platform_data *info)
> > 
> > ./arch/arm/mach-imx/generic.c:204:EXPORT_SYMBOL(set_imx_fb_info);
> > ./arch/arm/mach-imx/generic.c:200:void __init set_imx_fb_info(struct imxfb_mach_info *hard_imx_fb_info)
> >
> > ./sound/i2c/l3/uda1341.c:929:EXPORT_SYMBOL(snd_chip_uda1341_mixer_new);
> > ./sound/i2c/l3/uda1341.c:769:int __init snd_chip_uda1341_mixer_new(struct snd_card *card, struct l3_client **clntp)
> 
> These are definitely buggy.

Only if we have a policy of not exporting __init or __initdata or
__exit.  Are we there yet??

snd_chip_uda1341_mixer_new() is called from
sound/arm/sa11xx-uda1341.c::sa11xx_uda1341_probe(), which is
__init, so it looks safe to me, although I support a policy
that EXPORTs cannot be __init or __exit or __initdata.

---
~Randy
