Return-Path: <linux-kernel-owner+w=401wt.eu-S965162AbWLTVUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWLTVUQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbWLTVTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:19:50 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:41276 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965164AbWLTVTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:19:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=a4WvIIAr5pwKafvpmkFfTAZKyYhCAeQLkl5LU2UfmvlY6Gr3N/iIAQeWm4TEPD9/hgReNIcDupYudxpwvQe/nCrD9GJSPr7naA80QZkPe7iLz9AmpfTurr7yXEQLNBoHKFbhllWAMi6oomZ2L2/sEch70asqvGZlAYsdvDW7hD0=  ;
X-YMail-OSG: e5aMe8oVM1kEHQ4AjIwZV3cYYgU8uHLFqvHFT_D9mI2gYe4Abv9L7qLgLs9BrZHcqffOKLgCxqWpwh5TKbNWiEYKq__umypzc6MQjDq1X27yq_4livE8Fg--
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.20-rc1 3/6] AT91 GPIO wrappers
Date: Wed, 20 Dec 2006 13:11:19 -0800
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net> <200612201304.03912.david-b@pacbell.net>
In-Reply-To: <200612201304.03912.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612201311.20517.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a first cut at making the AT91 code use the generic GPIO calls.

Note that the original AT91 GPIO calls merged the "mux pin as GPIO"
and "set GPIO direction" functionality into one API call, contrary
to what's specified as a cross-platform portable model.  So this
involved a few non-inlinable functions.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: at91/include/asm-arm/arch-at91rm9200/gpio.h
===================================================================
--- at91.orig/include/asm-arm/arch-at91rm9200/gpio.h	2006-12-20 11:22:10.000000000 -0800
+++ at91/include/asm-arm/arch-at91rm9200/gpio.h	2006-12-20 11:22:33.000000000 -0800
@@ -179,6 +179,7 @@
 
 #ifndef __ASSEMBLY__
 /* setup setup routines, called from board init or driver probe() */
+extern int __init_or_module at91_set_GPIO_periph(unsigned pin, int use_pullup);
 extern int __init_or_module at91_set_A_periph(unsigned pin, int use_pullup);
 extern int __init_or_module at91_set_B_periph(unsigned pin, int use_pullup);
 extern int __init_or_module at91_set_gpio_input(unsigned pin, int use_pullup);
@@ -193,7 +194,41 @@ extern int at91_get_gpio_value(unsigned 
 /* callable only from core power-management code */
 extern void at91_gpio_suspend(void);
 extern void at91_gpio_resume(void);
-#endif
+
+/*-------------------------------------------------------------------------*/
+
+/* wrappers for "new style" GPIO calls. the old AT91-specfic ones should
+ * eventually be removed (along with this errno.h inclusion), and the
+ * gpio request/free calls should probably be implemented.
+ */
+
+#include <asm/errno.h>
+
+static inline int gpio_request(unsigned gpio, const char *label)
+	{ return 0; }
+
+static inline void gpio_free(unsigned gpio)
+	{ }
+
+
+extern int gpio_direction_input(unsigned gpio);
+extern int gpio_direction_output(unsigned gpio);
+
+static inline int gpio_get_value(unsigned gpio)
+	{ return at91_get_gpio_value(gpio); }
+
+static inline void gpio_set_value(unsigned gpio, int value)
+	{ (void) at91_set_gpio_value(gpio, value); }
+
+#include <asm-generic/gpio.h>		/* cansleep wrappers */
+
+static inline int gpio_to_irq(unsigned gpio)
+	{ return gpio; }
+
+static inline int irq_to_gpio(unsigned irq)
+	{ return irq; }
+
+#endif	/* __ASSEMBLY__ */
 
 #endif
 
Index: at91/arch/arm/mach-at91rm9200/gpio.c
===================================================================
--- at91.orig/arch/arm/mach-at91rm9200/gpio.c	2006-12-20 11:22:10.000000000 -0800
+++ at91/arch/arm/mach-at91rm9200/gpio.c	2006-12-20 11:31:28.000000000 -0800
@@ -66,6 +66,24 @@ static inline unsigned pin_to_mask(unsig
 
 
 /*
+ * mux the pin to the "GPIO" peripheral role.
+ */
+int __init_or_module at91_set_GPIO_periph(unsigned pin, int use_pullup)
+{
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
+
+	if (!pio)
+		return -EINVAL;
+	__raw_writel(mask, pio + PIO_IDR);
+	__raw_writel(mask, pio + (use_pullup ? PIO_PUER : PIO_PUDR));
+	__raw_writel(mask, pio + PIO_PER);
+	return 0;
+}
+EXPORT_SYMBOL(at91_set_GPIO_periph);
+
+
+/*
  * mux the pin to the "A" internal peripheral role.
  */
 int __init_or_module at91_set_A_periph(unsigned pin, int use_pullup)
@@ -182,6 +200,36 @@ EXPORT_SYMBOL(at91_set_multi_drive);
 
 /*--------------------------------------------------------------------------*/
 
+/* new-style GPIO calls; these expect at91_set_GPIO_periph to have been
+ * called, and maybe at91_set_multi_drive() for putout pins.
+ */
+
+int gpio_direction_input(unsigned pin)
+{
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
+
+	if (!pio || !(__raw_readl(pio + PIO_PSR) & mask))
+		return -EINVAL;
+	__raw_writel(mask, pio + PIO_OER);
+	return 0;
+}
+EXPORT_SYMBOL(gpio_direction_input);
+
+int gpio_direction_output(unsigned pin)
+{
+	void __iomem	*pio = pin_to_controller(pin);
+	unsigned	mask = pin_to_mask(pin);
+
+	if (!pio || !(__raw_readl(pio + PIO_PSR) & mask))
+		return -EINVAL;
+	__raw_writel(mask, pio + PIO_OER);
+	return 0;
+}
+EXPORT_SYMBOL(gpio_direction_output);
+
+/*--------------------------------------------------------------------------*/
+
 /*
  * assuming the pin is muxed as a gpio output, set its value.
  */
