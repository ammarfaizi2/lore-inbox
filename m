Return-Path: <linux-kernel-owner+w=401wt.eu-S932815AbXAAUQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815AbXAAUQ5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 15:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbXAAUQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 15:16:57 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:45071 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932815AbXAAUQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 15:16:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=w8SVknwAyoPYSsWEnQsqXIs/7V/WtgRXmyKxaiSx5L9LJPmmO8iFf7beoryBfdD3aIxTmTJXwRoh/JdQCRChoahrs83kGFpha20tHPWrNVeObSvjCHm8gdJBdN06f2mB3bl0ddru/g5dUaNjKMmFelaBZOxpi2s96NIjLZKM3iw=  ;
X-YMail-OSG: 3JmR07AVM1ltqQ_zjoL.IxwtP.TmrW0VdaeJWfQvhYPQBp7Koml7MIdICvV9xCL1OzpqDeYx9QvmEGmUW6Sb0uKSHMHA.rPU3PMxd7jxGMqAJxfhM8LSwCGcu4oU2zFV0x96beadk6m31E4-
From: David Brownell <david-b@pacbell.net>
To: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Date: Mon, 1 Jan 2007 11:43:51 -0800
User-Agent: KMail/1.7.1
Cc: pHilipp Zabel <philipp.zabel@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Kevin Hilman <khilman@mvista.com>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200612281247.36869.david-b@pacbell.net> <Pine.LNX.4.64.0612292107580.18171@xanadu.home>
In-Reply-To: <Pine.LNX.4.64.0612292107580.18171@xanadu.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701011143.53254.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the list archives:  here's the latest version of this.
The signed-off-by discussion is offlist right now, so this
version has none; see what eventually merges.

From: Philipp Zabel <philipp.zabel@gmail.com>

Arch-neutral GPIO calls for PXA.


Index: pxa/include/asm-arm/arch-pxa/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ pxa/include/asm-arm/arch-pxa/gpio.h	2007-01-01 11:23:43.000000000 -0800
@@ -0,0 +1,97 @@
+/*
+ * linux/include/asm-arm/arch-pxa/gpio.h
+ *
+ * PXA GPIO wrappers for arch-neutral GPIO calls
+ *
+ * Written by Philipp Zabel <philipp.zabel@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#ifndef __ASM_ARCH_PXA_GPIO_H
+#define __ASM_ARCH_PXA_GPIO_H
+
+#include <asm/errno.h>
+#include <asm/hardware.h>
+#include <asm/irq.h>
+
+#include <asm/arch/pxa-regs.h>
+
+static inline int gpio_get_value(unsigned gpio);
+static inline void gpio_set_value(unsigned gpio, int value);
+
+#include <asm-generic/gpio.h>			/* cansleep wrappers */
+
+static inline int gpio_request(unsigned gpio, const char *label)
+{
+	return 0;
+}
+
+static inline void gpio_free(unsigned gpio)
+{
+	return;
+}
+
+static inline int gpio_direction_input(unsigned gpio)
+{
+	return pxa_gpio_mode(gpio | GPIO_IN);
+}
+
+static inline int gpio_direction_output(unsigned gpio)
+{
+	return pxa_gpio_mode(gpio | GPIO_OUT);
+}
+
+static inline int __gpio_get_value(unsigned gpio)
+{
+	return GPLR(gpio) & GPIO_bit(gpio);
+}
+
+static inline int gpio_get_value(unsigned gpio)
+{
+	if (__builtin_constant_p(gpio))
+		return __gpio_get_value(gpio);
+	else
+		pxa_gpio_get_value(gpio);
+}
+
+static inline void __gpio_set_value(unsigned gpio, int value)
+{
+	if (value)
+		GPSR(gpio) = GPIO_bit(gpio);
+	else
+		GPCR(gpio) = GPIO_bit(gpio);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	if (__builtin_constant_p(gpio))
+		__gpio_set_value(gpio, value);
+	else
+		pxa_gpio_set_value(gpio, value);
+}
+
+static inline int gpio_to_irq(unsigned gpio)
+{
+	if (gpio <= PXA_LAST_GPIO)
+		return IRQ_GPIO(gpio);
+	return -EINVAL;
+}
+
+#define irq_to_gpio(irq)	IRQ_TO_GPIO(irq)
+
+
+#endif
Index: pxa/arch/arm/mach-pxa/generic.c
===================================================================
--- pxa.orig/arch/arm/mach-pxa/generic.c	2006-12-31 17:03:59.000000000 -0800
+++ pxa/arch/arm/mach-pxa/generic.c	2006-12-31 17:08:37.000000000 -0800
@@ -36,6 +36,7 @@
 #include <asm/mach/map.h>
 
 #include <asm/arch/pxa-regs.h>
+#include <asm/arch/gpio.h>
 #include <asm/arch/udc.h>
 #include <asm/arch/pxafb.h>
 #include <asm/arch/mmc.h>
@@ -104,13 +105,16 @@ unsigned long long sched_clock(void)
  * Handy function to set GPIO alternate functions
  */
 
-void pxa_gpio_mode(int gpio_mode)
+int pxa_gpio_mode(int gpio_mode)
 {
 	unsigned long flags;
 	int gpio = gpio_mode & GPIO_MD_MASK_NR;
 	int fn = (gpio_mode & GPIO_MD_MASK_FN) >> 8;
 	int gafr;
 
+	if (gpio > PXA_LAST_GPIO)
+		return -EINVAL;
+
 	local_irq_save(flags);
 	if (gpio_mode & GPIO_DFLT_LOW)
 		GPCR(gpio) = GPIO_bit(gpio);
@@ -123,11 +127,33 @@ void pxa_gpio_mode(int gpio_mode)
 	gafr = GAFR(gpio) & ~(0x3 << (((gpio) & 0xf)*2));
 	GAFR(gpio) = gafr |  (fn  << (((gpio) & 0xf)*2));
 	local_irq_restore(flags);
+
+	return 0;
 }
 
 EXPORT_SYMBOL(pxa_gpio_mode);
 
 /*
+ * Return GPIO level
+ */
+int pxa_gpio_get_value(unsigned gpio)
+{
+	return __gpio_get_value(gpio);
+}
+
+EXPORT_SYMBOL(pxa_gpio_get_value);
+
+/*
+ * Set output GPIO level
+ */
+void pxa_gpio_set_value(unsigned gpio, int value)
+{
+	__gpio_set_value(gpio, value);
+}
+
+EXPORT_SYMBOL(pxa_gpio_set_value);
+
+/*
  * Routine to safely enable or disable a clock in the CKEN
  */
 void pxa_set_cken(int clock, int enable)
Index: pxa/include/asm-arm/arch-pxa/hardware.h
===================================================================
--- pxa.orig/include/asm-arm/arch-pxa/hardware.h	2006-12-31 17:03:59.000000000 -0800
+++ pxa/include/asm-arm/arch-pxa/hardware.h	2006-12-31 17:08:37.000000000 -0800
@@ -65,7 +65,17 @@
 /*
  * Handy routine to set GPIO alternate functions
  */
-extern void pxa_gpio_mode( int gpio_mode );
+extern int pxa_gpio_mode( int gpio_mode );
+
+/*
+ * Return GPIO level, nonzero means high, zero is low
+ */
+extern int pxa_gpio_get_value(unsigned gpio);
+
+/*
+ * Set output GPIO level
+ */
+extern void pxa_gpio_set_value(unsigned gpio, int value);
 
 /*
  * Routine to enable or disable CKEN
