Return-Path: <linux-kernel-owner+w=401wt.eu-S1030363AbWLTVTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWLTVTl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWLTVTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:19:18 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:41261 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965162AbWLTVTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:19:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=UEI6E7T82z6N15Yc4tYl1v/ftP/9sHotOWdpUEevMo+w1ScwTxEixWo6uJaQ0iazVzUyL9r87oZ+pFS8t1jtoX4n6YOQh6pkcF+3aOFZX04TC84gTOY0UmHH8fsPN3U5nN130RgIgKR4k6lViu4rkZifh8b+vz/i3ILmuxmJTfo=  ;
X-YMail-OSG: EYHwHCEVM1kHuaO1aoK_8eUAPvECHY0cKdpau3mcCaw2z__6HyU6VKJmkAoPLektilb2Zn75Jty999xIPKvE4Ry7LBzyLv4ul.NuFFTajBwuNepBsQqSiiL_AKP0lK2yUCkISfV5QiMoNiE-
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.20-rc1 2/6] OMAP GPIO wrappers
Date: Wed, 20 Dec 2006 13:09:44 -0800
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
Message-Id: <200612201309.45366.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This teaches OMAP how to implement the cross-platform GPIO interfaces.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: at91/include/asm-arm/arch-omap/gpio.h
===================================================================
--- at91.orig/include/asm-arm/arch-omap/gpio.h	2006-12-19 01:45:33.000000000 -0800
+++ at91/include/asm-arm/arch-omap/gpio.h	2006-12-19 02:06:11.000000000 -0800
@@ -76,4 +76,58 @@ extern void omap_set_gpio_direction(int 
 extern void omap_set_gpio_dataout(int gpio, int enable);
 extern int omap_get_gpio_datain(int gpio);
 
+/*-------------------------------------------------------------------------*/
+
+/* wrappers for "new style" GPIO calls. the old OMAP-specfic ones should
+ * eventually be removed (along with this errno.h inclusion), and maybe
+ * gpios should put MPUIOs last too.
+ */
+
+#include <asm/errno.h>
+
+static inline int gpio_request(unsigned gpio, const char *label)
+	{ return omap_request_gpio(gpio); }
+
+static inline void gpio_free(unsigned gpio)
+	{ omap_free_gpio(gpio); }
+
+
+static inline int __gpio_set_direction(unsigned gpio, int is_input)
+{
+	if (cpu_class_is_omap2()) {
+		if (gpio > OMAP_MAX_GPIO_LINES)
+			return -EINVAL;
+	} else {
+		if (gpio > (OMAP_MAX_GPIO_LINES + 16 /* MPUIO */))
+			return -EINVAL;
+	}
+	omap_set_gpio_direction(gpio, is_input);
+	return 0;
+}
+
+static inline int gpio_direction_input(unsigned gpio)
+	{ return __gpio_set_direction(gpio, 1); }
+
+static inline int gpio_direction_output(unsigned gpio)
+	{ return __gpio_set_direction(gpio, 0); }
+
+
+static inline int gpio_get_value(unsigned gpio)
+	{ return omap_get_gpio_datain(gpio); }
+
+static inline void gpio_set_value(unsigned gpio, int value)
+	{ omap_set_gpio_dataout(gpio, value); }
+
+#include <asm-generic/gpio.h>		/* cansleep wrappers */
+
+static inline int gpio_to_irq(unsigned gpio)
+	{ return OMAP_GPIO_IRQ(gpio); }
+
+static inline int irq_to_gpio(unsigned irq)
+{
+	if (cpu_class_is_omap1() && (irq < (IH_MPUIO_BASE + 16)))
+		return (irq - IH_MPUIO_BASE) + OMAP_MAX_GPIO_LINES;
+	return irq - IH_GPIO_BASE;
+}
+
 #endif
