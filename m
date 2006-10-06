Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422856AbWJFS6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422856AbWJFS6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422857AbWJFS6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:58:24 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:41763 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1422856AbWJFS6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:58:13 -0400
Message-Id: <20061006185457.308808000@mvista.com>
References: <20061006185439.667702000@mvista.com>
User-Agent: quilt/0.45-1
Date: Fri, 06 Oct 2006 11:54:47 -0700
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 08/10] -mm: clocksource: initialize list value
Content-Disposition: inline; filename=clocksouce_list_init.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A change to clocksource initialization. It's optional for new clocksources,
but prefered. If the list field is initialized it allows clocksource_register 
to complete faster since it doesn't have the scan the list of clocks doing 
strcmp on each.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 arch/i386/kernel/hpet.c          |    1 +
 arch/i386/kernel/i8253.c         |    1 +
 arch/i386/kernel/tsc.c           |    1 +
 drivers/clocksource/acpi_pm.c    |    1 +
 drivers/clocksource/cyclone.c    |    1 +
 drivers/clocksource/scx200_hrt.c |    1 +
 include/linux/clocksource.h      |    3 +++
 7 files changed, 9 insertions(+)

Index: linux-2.6.18/arch/i386/kernel/hpet.c
===================================================================
--- linux-2.6.18.orig/arch/i386/kernel/hpet.c
+++ linux-2.6.18/arch/i386/kernel/hpet.c
@@ -27,6 +27,7 @@ static struct clocksource clocksource_hp
 	.mult		= 0, /* set below */
 	.shift		= HPET_SHIFT,
 	.is_continuous	= 1,
+	.list		= CLOCKSOURCE_LIST_INIT(clocksource_hpet.list),
 };
 
 static int __init init_hpet_clocksource(void)
Index: linux-2.6.18/arch/i386/kernel/i8253.c
===================================================================
--- linux-2.6.18.orig/arch/i386/kernel/i8253.c
+++ linux-2.6.18/arch/i386/kernel/i8253.c
@@ -105,6 +105,7 @@ static struct clocksource clocksource_pi
 	.mask	= CLOCKSOURCE_MASK(32),
 	.mult	= 0,
 	.shift	= 20,
+	.list	= CLOCKSOURCE_LIST_INIT(clocksource_pit.list),
 };
 
 static int __init init_pit_clocksource(void)
Index: linux-2.6.18/arch/i386/kernel/tsc.c
===================================================================
--- linux-2.6.18.orig/arch/i386/kernel/tsc.c
+++ linux-2.6.18/arch/i386/kernel/tsc.c
@@ -350,6 +350,7 @@ static struct clocksource clocksource_ts
 	.mult			= 0, /* to be set */
 	.shift			= 22,
 	.is_continuous		= 1,
+	.list			= CLOCKSOURCE_LIST_INIT(clocksource_tsc.list),
 };
 
 
Index: linux-2.6.18/drivers/clocksource/acpi_pm.c
===================================================================
--- linux-2.6.18.orig/drivers/clocksource/acpi_pm.c
+++ linux-2.6.18/drivers/clocksource/acpi_pm.c
@@ -73,6 +73,7 @@ static struct clocksource clocksource_ac
 	.mult		= 0, /*to be caluclated*/
 	.shift		= 22,
 	.is_continuous	= 1,
+	.list		= CLOCKSOURCE_LIST_INIT(clocksource_acpi_pm.list),
 };
 
 
Index: linux-2.6.18/drivers/clocksource/cyclone.c
===================================================================
--- linux-2.6.18.orig/drivers/clocksource/cyclone.c
+++ linux-2.6.18/drivers/clocksource/cyclone.c
@@ -32,6 +32,7 @@ static struct clocksource clocksource_cy
 	.mult		= 10,
 	.shift		= 0,
 	.is_continuous	= 1,
+	.list		= CLOCKSOURCE_LIST_INIT(clocksource_cyclone.list),
 };
 
 static int __init init_cyclone_clocksource(void)
Index: linux-2.6.18/drivers/clocksource/scx200_hrt.c
===================================================================
--- linux-2.6.18.orig/drivers/clocksource/scx200_hrt.c
+++ linux-2.6.18/drivers/clocksource/scx200_hrt.c
@@ -58,6 +58,7 @@ static struct clocksource cs_hrt = {
 	.read		= read_hrt,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.is_continuous	= 1,
+	.list		= CLOCKSOURCE_LIST_INIT(cs_hrt.list),
 	/* mult, shift are set based on mhz27 flag */
 };
 
Index: linux-2.6.18/include/linux/clocksource.h
===================================================================
--- linux-2.6.18.orig/include/linux/clocksource.h
+++ linux-2.6.18/include/linux/clocksource.h
@@ -82,6 +82,9 @@ struct clocksource {
 /* simplify initialization of mask field */
 #define CLOCKSOURCE_MASK(bits) (cycle_t)(bits<64 ? ((1ULL<<bits)-1) : -1)
 
+/* Abstracted list initialization */
+#define CLOCKSOURCE_LIST_INIT(x)	LIST_HEAD_INIT(x)
+
 /**
  * clocksource_khz2mult - calculates mult from khz and shift
  * @khz:		Clocksource frequency in KHz

--

