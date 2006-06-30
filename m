Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWF3Hfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWF3Hfa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWF3Hfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:35:30 -0400
Received: from xenotime.net ([66.160.160.81]:15497 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751255AbWF3Hf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:35:29 -0400
Date: Fri, 30 Jun 2006 00:38:13 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, davej@redhat.com, linux-kernel@vger.kernel.org,
       sekharan@us.ibm.com, rusty@rustcorp.com.au, sam@ravnborg.org
Subject: Re: 2.6.17-mm2
Message-Id: <20060630003813.e1003a93.rdunlap@xenotime.net>
In-Reply-To: <20060625081610.9b0a775a.akpm@osdl.org>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	<20060624172014.GB26273@redhat.com>
	<20060624143440.0931b4f1.akpm@osdl.org>
	<200606251051.55355.rjw@sisk.pl>
	<20060625032243.fcce9e2e.akpm@osdl.org>
	<20060625081610.9b0a775a.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 08:16:10 -0700 Andrew Morton wrote:

> On Sun, 25 Jun 2006 03:22:43 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Anyway.  It's regrettable that the new section-checking code didn't
> > complain about the bug.  It looks like this is because the call to
> > cpufreq_register_driver() happened at modprobe-time, and we don't check for
> > that.  Which is rather bad.
> > 
> > Sam, would it be possible to check for references from modules into
> > statically-linked __init code?  It's always wrong...
> > 
> > Rusty/Randy/whoever looks after modules: it also seems wrong that it's
> > possible to load a module which refers to now-unloaded symbols.  In fact,
> > it's surprising - sorry if I'm misinterpreting this.  If I'm not, it should
> > be pretty easy to barf if a module is trying to get at symbols which lie
> > between __init_begin and __init_end?
> > 
> 
> Actually we should be able to address this pretty simply by disallowing
> exports of symbols which are in the __init section.  There's no sense in
> exporting something which ain't there.
> 
> IOW, any reference from __ksymtab, __ksymtab_gpl or __ksymtab_gpl_future
> into __init or __initdata should be a hard error.
> 
> It'd be lovely to do that at compile-time, but I cannot think of a way.
> 
> Sam, does that sound reasonable&&feasible?


Until modpost (or whatever) can do this, here are a few that
a shell script has found for me by examing source code only --
may contain some false reports:


./arch/arm/mach-at91rm9200/gpio.c:81:EXPORT_SYMBOL(at91_set_A_periph)
./arch/arm/mach-at91rm9200/gpio.c:67:int __init_or_module at91_set_A_periph(unsigned pin, int use_pullup)

./arch/arm/mach-at91rm9200/gpio.c:101:EXPORT_SYMBOL(at91_set_B_periph);
./arch/arm/mach-at91rm9200/gpio.c:87:int __init_or_module at91_set_B_periph(unsigned pin, int use_pullup)

./arch/arm/mach-at91rm9200/gpio.c:122:EXPORT_SYMBOL(at91_set_gpio_input);
./arch/arm/mach-at91rm9200/gpio.c:108:int __init_or_module at91_set_gpio_input(unsigned pin, int use_pullup)

./arch/arm/mach-at91rm9200/gpio.c:144:EXPORT_SYMBOL(at91_set_gpio_output);
./arch/arm/mach-at91rm9200/gpio.c:129:int __init_or_module at91_set_gpio_output(unsigned pin, int value)

./arch/arm/mach-at91rm9200/gpio.c:160:EXPORT_SYMBOL(at91_set_deglitch);
./arch/arm/mach-at91rm9200/gpio.c:150:int __init_or_module at91_set_deglitch(unsigned pin, int is_on)

./arch/arm/mach-at91rm9200/gpio.c:177:EXPORT_SYMBOL(at91_set_multi_drive);
./arch/arm/mach-at91rm9200/gpio.c:166:int __init_or_module at91_set_multi_drive(unsigned pin, int is_on)

./arch/arm/mach-imx/generic.c:196:EXPORT_SYMBOL(imx_set_mmc_info);
./arch/arm/mach-imx/generic.c:192:void __init imx_set_mmc_info(struct imxmmc_platform_data *info)

./arch/arm/mach-imx/generic.c:204:EXPORT_SYMBOL(set_imx_fb_info);
./arch/arm/mach-imx/generic.c:200:void __init set_imx_fb_info(struct imxfb_mach_info *hard_imx_fb_info)

./arch/arm/plat-omap/mux.c:196:EXPORT_SYMBOL(omap_cfg_reg);
./arch/arm/plat-omap/mux.c:58:int __init_or_module omap_cfg_reg(const unsigned long index)

./arch/mips/au1000/common/prom.c:155:EXPORT_SYMBOL(prom_getcmdline);
./arch/mips/philips/pnx8550/common/prom.c:136:EXPORT_SYMBOL(prom_getcmdline);
./arch/mips/arc/cmdline.c:19:char * __init prom_getcmdline(void)
./arch/mips/au1000/common/setup.c:47:extern char * __init prom_getcmdline(void);
./arch/mips/galileo-boards/ev96100/init.c:56:char * __init prom_getcmdline(void)
./arch/mips/galileo-boards/ev96100/setup.c:52:extern char *__init prom_getcmdline(void);
./arch/mips/ite-boards/generic/pmon_prom.c:55:char * __init prom_getcmdline(void)
./arch/mips/jmr3927/common/prom.c:54:char * __init prom_getcmdline(void)
./arch/mips/mips-boards/generic/cmdline.c:34:char * __init prom_getcmdline(void)
./arch/mips/mips-boards/sim/sim_cmdline.c:24:char * __init prom_getcmdline(void)
./arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c:93:char * __init prom_getcmdline(void)
./arch/mips/tx4938/toshiba_rbtx4938/prom.c:75:char * __init prom_getcmdline(void)

./arch/powerpc/platforms/powermac/setup.c:397:EXPORT_SYMBOL(note_scsi_host);
./arch/powerpc/platforms/powermac/setup.c:370:void __init note_scsi_host(struct device_node *node, void *host)

./sound/i2c/l3/uda1341.c:929:EXPORT_SYMBOL(snd_chip_uda1341_mixer_new);
./sound/i2c/l3/uda1341.c:769:int __init snd_chip_uda1341_mixer_new(struct snd_card *card, struct l3_client **clntp)


---
~Randy
