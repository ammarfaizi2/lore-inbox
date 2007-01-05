Return-Path: <linux-kernel-owner+w=401wt.eu-S1422649AbXAESDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbXAESDu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbXAESDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:03:49 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:30755 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161172AbXAESDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:03:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=wc/IosNFJ7GwHvnfnUExLpEhusnZPJHZ1pF/QkpCFdjIgbhYHdbnYEK20hsE/ur3bPcqKB8J+d4O6Y9dIqzu+ish6bDqEnA5kKFSff/SZtV3uMnbQCoJWqFCZtgHtWsAWBjVqBnvxjKfhoOS7WLEYiOLTlzQLJ/Vj5WfRbIotE4=  ;
X-YMail-OSG: pYDy.gAVM1nltwqQgYskG2tSkm0LWYp4lNUxjZFEWO4RnpynrxdMqhTm2qwY67_p4reqElIvZpk37fxV2qtsYaVJFgW_VH2BNcTnjcGFg63Cs_E1GIFVT3StRWpDD70R5_BJJ.8NDBvvz6M-
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
       rtc-linux@googlegroups.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.20-rc3 2/3] create rtc-cmos platform device on x86_pc
Date: Fri, 5 Jan 2007 10:02:47 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200701051002.48554.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update X86_PC platforms (i386, x86_64) to create an "rtc_cmos" platform device
when PNPACPI won't be creating a corresponding PNP node for us.  We know those
platforms always have such a "cmos RTC" device, it's in the hardware spec.

Note that this switches over to using the table based registration API that's
widely used on e.g. ARM.  There may be other platform devices that should get
added to these tables, to help get rid of some legacy ISA probing logic.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

===
 i386/kernel/setup.c   |   60 +++++++++++++++++++++++++++++++++++----------
 x86_64/kernel/setup.c |   66 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 98 insertions(+), 28 deletions(-)

Random note:  x86_64 only creates pcspkr if it's configured,
while x86_32 creates it always.  Not changed by this patch,
but it'd make more sense that it always be conditional.

Index: g26/arch/x86_64/kernel/setup.c
===================================================================
--- g26.orig/arch/x86_64/kernel/setup.c	2006-12-07 23:00:17.000000000 -0800
+++ g26/arch/x86_64/kernel/setup.c	2006-12-08 00:56:39.000000000 -0800
@@ -1220,22 +1220,58 @@ struct seq_operations cpuinfo_op = {
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
--- g26.orig/arch/i386/kernel/setup.c	2006-12-07 23:00:12.000000000 -0800
+++ g26/arch/i386/kernel/setup.c	2006-12-08 00:56:39.000000000 -0800
@@ -652,22 +652,56 @@ void __init setup_arch(char **cmdline_p)
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
