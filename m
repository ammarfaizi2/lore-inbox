Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVJMULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVJMULd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVJMULd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:11:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18113 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932461AbVJMULc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:11:32 -0400
Date: Thu, 13 Oct 2005 22:10:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Support pcmcia slot on sharp sl-5500
Message-ID: <20051013201053.GA12778@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds support for pcmcia slot on sharp zaurus
sl-5500. pxa2xx_sharpsl.c thus becomes quite miss-named, but I guess
that is not worth fixing?

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -57,6 +57,7 @@ sa1111_cs-$(CONFIG_SA1100_JORNADA720)		+
 sa1100_cs-y					+= sa1100_generic.o
 sa1100_cs-$(CONFIG_SA1100_ASSABET)		+= sa1100_assabet.o
 sa1100_cs-$(CONFIG_SA1100_CERF)			+= sa1100_cerf.o
+sa1100_cs-$(CONFIG_SA1100_COLLIE)              += pxa2xx_sharpsl.o
 sa1100_cs-$(CONFIG_SA1100_H3600)		+= sa1100_h3600.o
 sa1100_cs-$(CONFIG_SA1100_SHANNON)		+= sa1100_shannon.o
 sa1100_cs-$(CONFIG_SA1100_SIMPAD)		+= sa1100_simpad.o
diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
--- a/drivers/pcmcia/pxa2xx_sharpsl.c
+++ b/drivers/pcmcia/pxa2xx_sharpsl.c
@@ -18,10 +18,15 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 
+#include <asm/mach-types.h>
 #include <asm/hardware.h>
 #include <asm/irq.h>
 #include <asm/hardware/scoop.h>
-#include <asm/arch/pxa-regs.h>
+#ifdef CONFIG_SA1100_COLLIE
+#include <asm/arch-sa1100/collie.h>
+#else
+#include <asm/arch-pxa/pxa-regs.h>
+#endif
 
 #include "soc_common.h"
 
@@ -38,6 +43,7 @@ static int sharpsl_pcmcia_hw_init(struct
 {
 	int ret;
 
+#ifndef CONFIG_SA1100_COLLIE
 	/*
 	 * Setup default state of GPIO outputs
 	 * before we enable them as outputs.
@@ -60,6 +66,7 @@ static int sharpsl_pcmcia_hw_init(struct
 	pxa_gpio_mode(GPIO55_nPREG_MD);
 	pxa_gpio_mode(GPIO56_nPWAIT_MD);
 	pxa_gpio_mode(GPIO57_nIOIS16_MD);
+#endif
 
 	/* Register interrupts */
 	if (scoop_devs[skt->nr].cd_irq >= 0) {
@@ -213,12 +219,20 @@ static void sharpsl_pcmcia_socket_init(s
 	write_scoop_reg(scoop_devs[skt->nr].dev, SCOOP_IMR, 0x00C0);
 	write_scoop_reg(scoop_devs[skt->nr].dev, SCOOP_MCR, 0x0101);
 	scoop_devs[skt->nr].keep_vs = NO_KEEP_VS;
+
+	if (machine_is_collie())
+		/* We need to disable SS_OUTPUT_ENA here. */
+		write_scoop_reg(scoop_devs[skt->nr].dev, SCOOP_CPR, read_scoop_reg(scoop_devs[skt->nr].dev, SCOOP_CPR) & ~0x0080);
 }
 
 static void sharpsl_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 {
 	/* CF_BUS_OFF */
 	sharpsl_pcmcia_init_reset(&scoop_devs[skt->nr]);
+
+	if (machine_is_collie())
+		/* We need to disable SS_OUTPUT_ENA here. */
+		write_scoop_reg(scoop_devs[skt->nr].dev, SCOOP_CPR, read_scoop_reg(scoop_devs[skt->nr].dev, SCOOP_CPR) & ~0x0080);
 }
 
 static struct pcmcia_low_level sharpsl_pcmcia_ops = {
@@ -235,6 +249,19 @@ static struct pcmcia_low_level sharpsl_p
 
 static struct platform_device *sharpsl_pcmcia_device;
 
+#ifdef CONFIG_SA1100_COLLIE
+int __init pcmcia_collie_init(struct device *dev)
+{
+       int ret = -ENODEV;
+
+       if (machine_is_collie())
+               ret = sa11xx_drv_pcmcia_probe(dev, &sharpsl_pcmcia_ops, 0, 1);
+
+       return ret;
+}
+
+#else
+
 static int __init sharpsl_pcmcia_init(void)
 {
 	int ret;
@@ -269,6 +296,7 @@ static void __exit sharpsl_pcmcia_exit(v
 
 fs_initcall(sharpsl_pcmcia_init);
 module_exit(sharpsl_pcmcia_exit);
+#endif
 
 MODULE_DESCRIPTION("Sharp SL Series PCMCIA Support");
 MODULE_LICENSE("GPL");
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -38,8 +38,12 @@
 #include <pcmcia/cs.h>
 #include <pcmcia/ss.h>
 
+#include <asm/hardware/scoop.h>
+
 #include "sa1100_generic.h"
 
+int __init pcmcia_collie_init(struct device *dev);
+
 static int (*sa11x0_pcmcia_hw_init[])(struct device *dev) = {
 #ifdef CONFIG_SA1100_ASSABET
 	pcmcia_assabet_init,
@@ -56,6 +60,9 @@ static int (*sa11x0_pcmcia_hw_init[])(st
 #ifdef CONFIG_SA1100_SIMPAD
 	pcmcia_simpad_init,
 #endif
+#ifdef CONFIG_SA1100_COLLIE
+       pcmcia_collie_init,
+#endif
 };
 
 static int sa11x0_drv_pcmcia_probe(struct device *dev)

-- 
Thanks, Sharp!
