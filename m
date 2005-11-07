Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVKGXbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVKGXbZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965601AbVKGXbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:31:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63712 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964935AbVKGXbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:31:24 -0500
Date: Tue, 8 Nov 2005 00:30:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: Ben Dooks <ben@fluff.org.uk>, vojtech@suse.cz, rpurdie@rpsys.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051107233000.GC2034@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz> <20051102024755.GA14148@home.fluff.org> <20051102095139.GB30220@elf.ucw.cz> <43093.192.168.0.12.1130985101.squirrel@192.168.0.2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43093.192.168.0.12.1130985101.squirrel@192.168.0.2>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > I think even slow blinking was used somewhere. I have some code from
> >> > John Lenz (attached); it uses sysfs interface, exports led collor, and
> >> > allows setting different frequencies.
> >> >
> >> > Is that acceptable, or should some other interface be used?
> >>
> >> there is already an LED interface for linux-arm, which is
> >> used by a number of the extant machines in the sa11x0 and
> >> pxa range.
> >
> > Where is that interface? I think that making collie use it is obvious
> > first step...
> 
> I originally wrote the collie led code to use that interface, and you
> might look at some of the old versions of the patch on my web site.  The
> actual code is in arch/arm/kernel/time.c, but this code calls out to an
> individual machine function through say arch/arm/mach-sa1100/leds.c... 
> The problem for collie was that the device model for locomo did not allow
> an easy way to do it... as you can see, in my patch it implements a driver
> for those leds and the driver model takes care of it.
> 
> I just looked, and
> http://www.cs.wisc.edu/~lenz/zaurus/files/patch-2.6.7-jl2.diff.gz contins
> the implementation of the arm led interface for collie.... not sure if it
> will still work anymore, but...

It does, after kconfig fixups. Do you think we could get that merged?
Some led driver is better than none at all.

---

Simple collie LED driver, by John Lenz.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -408,7 +408,8 @@ config LEDS
 		   ARCH_EBSA285 || ARCH_IMX || ARCH_INTEGRATOR || \
 		   ARCH_LUBBOCK || MACH_MAINSTONE || ARCH_NETWINDER || \
 		   ARCH_OMAP || ARCH_P720T || ARCH_PXA_IDP || \
-		   ARCH_SA1100 || ARCH_SHARK || ARCH_VERSATILE
+		   ARCH_SA1100 || ARCH_SHARK || ARCH_VERSATILE || \
+		   SA1100_COLLIE
 	help
 	  If you say Y here, the LEDs on your machine will be used
 	  to provide useful information about your current system status.
@@ -422,7 +423,8 @@ config LEDS
 
 config LEDS_TIMER
 	bool "Timer LED" if (!ARCH_CDB89712 && !ARCH_OMAP) || \
-			    MACH_OMAP_H2 || MACH_OMAP_PERSEUS2
+			    MACH_OMAP_H2 || MACH_OMAP_PERSEUS2 || \\
+			    SA1100_COLLIE
 	depends on LEDS
 	default y if ARCH_EBSA110
 	help
@@ -438,7 +440,8 @@ config LEDS_TIMER
 
 config LEDS_CPU
 	bool "CPU usage LED" if (!ARCH_CDB89712 && !ARCH_EBSA110 && \
-			!ARCH_OMAP) || MACH_OMAP_H2 || MACH_OMAP_PERSEUS2
+			!ARCH_OMAP) || MACH_OMAP_H2 || MACH_OMAP_PERSEUS2 || \
+			SA1100_COLLIE
 	depends on LEDS
 	help
 	  If you say Y here, the red LED will be used to give a good real
diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
--- a/arch/arm/mach-sa1100/Makefile
+++ b/arch/arm/mach-sa1100/Makefile
@@ -26,6 +26,7 @@ led-$(CONFIG_SA1100_CERF)		+= leds-cerf.
 obj-$(CONFIG_SA1100_COLLIE)		+= collie.o
 #obj-$(CONFIG_SA1100_COLLIE)		+= battery-collie.o
 obj-$(CONFIG_SA1100_COLLIE)		+= collie_batswitch.o
+obj-$(CONFIG_SA1100_COLLIE)		+= leds-collie.o
 
 obj-$(CONFIG_SA1100_H3600)		+= h3600.o
 
diff --git a/arch/arm/mach-sa1100/leds-collie.c b/arch/arm/mach-sa1100/leds-collie.c
new file mode 100644
--- /dev/null
+++ b/arch/arm/mach-sa1100/leds-collie.c
@@ -0,0 +1,126 @@
+/*
+ * linux/arch/arm/mach-sa1100/leds-collie.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * ChangeLog:
+ * 	- John Lenz <4/27/04> - added support for new locomo device model
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/device.h>
+
+#include <asm/hardware.h>
+#include <asm/hardware/locomo.h>
+#include <asm/leds.h>
+#include <asm/system.h>
+
+#include "leds.h"
+
+#define LED_STATE_ENABLED	1
+#define LED_STATE_CLAIMED	2
+
+static struct locomo_dev *locomo_dev;
+static unsigned int led_state;
+static unsigned int hw_led0_state;
+static unsigned int hw_led1_state;
+
+#define	LED_ONOFF_MASK	(LOCOMO_LPT_TOFL|LOCOMO_LPT_TOFH)
+#define	LED_OFF(REG)	((REG)|=LOCOMO_LPT_TOFL)
+#define	LED_ON(REG)	((REG)=((REG)&~LED_ONOFF_MASK)|LOCOMO_LPT_TOFH)
+#define	LED_FLIP(REG)	((REG)^=LED_ONOFF_MASK)
+
+void collie_leds_event(led_event_t evt)
+{
+        unsigned long flags;
+
+	local_irq_save(flags);
+
+        switch (evt) {
+        case led_start:
+                led_state = LED_STATE_ENABLED;
+		LED_ON(hw_led0_state);
+		LED_ON(hw_led1_state);
+                break;
+
+        case led_stop:
+                led_state &= ~LED_STATE_ENABLED;
+                break;
+
+        case led_claim:
+                led_state |= LED_STATE_CLAIMED;
+		LED_ON(hw_led0_state);
+		LED_ON(hw_led1_state);
+                break;
+
+        case led_release:
+                led_state &= ~LED_STATE_CLAIMED;
+		LED_ON(hw_led0_state);
+		LED_ON(hw_led1_state);
+                break;
+
+#ifdef CONFIG_LEDS_TIMER
+        case led_timer:
+                if (!(led_state & LED_STATE_CLAIMED)) {
+			LED_FLIP(hw_led0_state);
+		}
+                break;
+#endif
+
+#ifdef CONFIG_LEDS_CPU
+        case led_idle_start:
+		/* LED off when system is idle */
+                if (!(led_state & LED_STATE_CLAIMED))
+			LED_OFF(hw_led1_state);
+                break;
+
+        case led_idle_end:
+                if (!(led_state & LED_STATE_CLAIMED))
+			LED_ON(hw_led1_state);
+                break;
+#endif
+
+	default:
+		break;
+        }
+
+        if  (locomo_dev && led_state & LED_STATE_ENABLED) {
+		locomo_writel(hw_led0_state, locomo_dev->mapbase + LOCOMO_LPT0);
+		locomo_writel(hw_led1_state, locomo_dev->mapbase + LOCOMO_LPT1);
+        }
+
+	local_irq_restore(flags);
+}
+
+static int collieled_probe(struct locomo_dev *dev)
+{
+	locomo_dev = dev;
+	return 0;
+}
+
+static int collieled_remove(struct locomo_dev *dev) {
+	locomo_dev = NULL;
+	return 0;
+}
+
+static struct locomo_driver collieled_driver = {
+	.drv = {
+		.name = "locomoled"
+	},
+	.devid	= LOCOMO_DEVID_LED,
+	.probe	= collieled_probe,
+	.remove	= collieled_remove,
+};
+
+static int __init collieled_init(void) {
+	return locomo_driver_register(&collieled_driver);
+}
+
+device_initcall(collieled_init);
+
+MODULE_AUTHOR("John Lenz <jelenz@wisc.edu>, Chris Larson <kergoth@digitalnemesis.net>");
+MODULE_DESCRIPTION("LoCoMo Collie LED driver");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/mach-sa1100/leds.c b/arch/arm/mach-sa1100/leds.c
--- a/arch/arm/mach-sa1100/leds.c
+++ b/arch/arm/mach-sa1100/leds.c
@@ -26,6 +26,8 @@ sa1100_leds_init(void)
 		leds_event = brutus_leds_event;
 	if (machine_is_cerf())
 		leds_event = cerf_leds_event;
+	if (machine_is_collie())
+		leds_event = collie_leds_event;
 	if (machine_is_flexanet())
 		leds_event = flexanet_leds_event;
 	if (machine_is_graphicsclient())
diff --git a/arch/arm/mach-sa1100/leds.h b/arch/arm/mach-sa1100/leds.h
--- a/arch/arm/mach-sa1100/leds.h
+++ b/arch/arm/mach-sa1100/leds.h
@@ -3,6 +3,7 @@ extern void badge4_leds_event(led_event_
 extern void consus_leds_event(led_event_t evt);
 extern void brutus_leds_event(led_event_t evt);
 extern void cerf_leds_event(led_event_t evt);
+extern void collie_leds_event(led_event_t evt);
 extern void flexanet_leds_event(led_event_t evt);
 extern void graphicsclient_leds_event(led_event_t evt);
 extern void hackkit_leds_event(led_event_t evt);


-- 
Thanks, Sharp!
