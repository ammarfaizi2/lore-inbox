Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966811AbWKTWPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966811AbWKTWPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966837AbWKTWPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:15:42 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:29014 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966811AbWKTWPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:15:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=xRwbTZgT1WERJWVH8cWe9Fx87lxxC3VQwYgmqBRkZjQFOl6bGPVqJw6q6W+M5+Cs128pFNJPrATZ1CTolJqy3/vUlPklXkc1QNF74MiLl9+w+CrIxag4ZN0x5hLiMOIAQIpIhTkSpyNdLFsfzaB4VFNs/yojcOAj5PyTr39fXO8=  ;
X-YMail-OSG: h7AJQFIVM1m2MiT8CTFYx0PHy0eHEMtqTJhdHmrOiG.IW6nk2D38iebzM9HVUed3ZFSfq3CKNrD_iMoWDt68FNA1nRo_r95dq6HxshQMbIeE6EJbAeZk.g--
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [patch 2.6.19-rc6 3/6] X86_PC optionally creates rtc_cmos platform device
Date: Mon, 20 Nov 2006 10:22:09 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200611201014.41980.david-b@pacbell.net>
In-Reply-To: <200611201014.41980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201022.09709.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update X86_PC platforms (i386, x86_64) to create an "rtc_cmos" platform device
when PNPACPI won't be creating a corresponding PNP node for us.  There may be
other platform devices that should get corresponding treatment; it might help
get rid of more legacy ISA probing logic.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/arch/x86_64/kernel/setup.c
===================================================================
--- g26.orig/arch/x86_64/kernel/setup.c	2006-11-20 10:03:06.000000000 -0800
+++ g26/arch/x86_64/kernel/setup.c	2006-11-20 10:10:43.000000000 -0800
@@ -1212,22 +1212,58 @@ struct seq_operations cpuinfo_op = {
 	.show =	show_cpuinfo,
 };
 
-#if defined(CONFIG_INPUT_PCSPKR) || defined(CONFIG_INPUT_PCSPKR_MODULE)
+
+#ifdef CONFIG_X86_PC
+
 #include <linux/platform_device.h>
-static __init int add_pcspkr(void)
-{
-	struct platform_device *pd;
-	int ret;
+#include <asm/mc146818rtc.h>
+
+#if defined(CONFIG_INPUT_PCSPKR) || defined(CONFIG_INPUT_PCSPKR_MODULE)
+static struct platform_device pcspkr_dev = {
+	.name		= "pcspkr",
+	.id		= -1,
+};
+#endif	/* PCSPKR */
 
-	pd = platform_device_alloc("pcspkr", -1);
-	if (!pd)
-		return -ENOMEM;
-
-	ret = platform_device_add(pd);
-	if (ret)
-		platform_device_put(pd);
+#ifndef	CONFIG_PNPACPI
+struct resource rtc_platform_resources[] = { {
+	.flags		= IORESOURCE_IO,
+	.start		= RTC_PORT(0),
+	.end		= RTC_PORT(1),
+}, {
+	.flags		= IORESOURCE_IRQ,
+	.start		= RTC_IRQ
+} };
 
-	return ret;
-}
-device_initcall(add_pcspkr);
+struct platform_device rtc_dev = {
+	.name		= "rtc_cmos",
+	.id		= -1,
+	.resource	= rtc_platform_resources,
+	.num_resources	= ARRAY_SIZE(rtc_platform_resources),
+};
+#endif	/* !PNPACPI */
+
+static struct platform_device *x86_pc_devs[] __initdata = {
+#if defined(CONFIG_INPUT_PCSPKR) || defined(CONFIG_INPUT_PCSPKR_MODULE)
+	&pcspkr_dev,
+#endif
+#ifndef	CONFIG_PNPACPI
+	&rtc_dev,
+#endif
+};
+
+static __init int add_devices(void)
+{
+#ifndef	CONFIG_PNPACPI
+	/* On most motherboards starting with ATX (1995+),
+	 * RTC alarms can wake the system
+	 */
+	device_init_wakeup(&rtc_dev.dev, 1);
 #endif
+
+	return platform_add_devices(x86_pc_devs, ARRAY_SIZE(x86_pc_devs));
+}
+arch_initcall(add_devices);
+
+#endif	/* X86_PC */
+
Index: g26/arch/i386/kernel/setup.c
===================================================================
--- g26.orig/arch/i386/kernel/setup.c	2006-11-20 10:03:06.000000000 -0800
+++ g26/arch/i386/kernel/setup.c	2006-11-20 10:10:43.000000000 -0800
@@ -1481,22 +1481,56 @@ void __init setup_arch(char **cmdline_p)
 	tsc_init();
 }
 
-static __init int add_pcspkr(void)
-{
-	struct platform_device *pd;
-	int ret;
 
-	pd = platform_device_alloc("pcspkr", -1);
-	if (!pd)
-		return -ENOMEM;
-
-	ret = platform_device_add(pd);
-	if (ret)
-		platform_device_put(pd);
+#ifdef CONFIG_X86_PC
+
+#include <linux/platform_device.h>
+#include <asm/mc146818rtc.h>
+
+static struct platform_device pcspkr_dev = {
+	.name		= "pcspkr",
+	.id		= -1,
+};
+
+#ifndef	CONFIG_PNPACPI
+struct resource rtc_platform_resources[] = { {
+	.flags		= IORESOURCE_IO,
+	.start		= RTC_PORT(0),
+	.end		= RTC_PORT(1),
+}, {
+	.flags		= IORESOURCE_IRQ,
+	.start		= RTC_IRQ
+} };
+
+struct platform_device rtc_dev = {
+	.name		= "rtc_cmos",
+	.id		= -1,
+	.resource	= rtc_platform_resources,
+	.num_resources	= ARRAY_SIZE(rtc_platform_resources),
+};
+#endif	/* !PNPACPI */
 
-	return ret;
+static struct platform_device *x86_pc_devs[] __initdata = {
+	&pcspkr_dev,
+#ifndef	CONFIG_PNPACPI
+	&rtc_dev,
+#endif
+};
+
+static __init int add_devices(void)
+{
+#ifndef	CONFIG_PNPACPI
+	/* On most motherboards starting with ATX (1995+),
+	 * RTC alarms can wake the system
+	 */
+	device_init_wakeup(&rtc_dev.dev, 1);
+#endif
+
+	return platform_add_devices(x86_pc_devs, ARRAY_SIZE(x86_pc_devs));
 }
-device_initcall(add_pcspkr);
+arch_initcall(add_devices);
+
+#endif	/* X86_PC */
 
 /*
  * Local Variables:
