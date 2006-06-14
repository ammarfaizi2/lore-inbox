Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWFNWWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWFNWWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWFNWW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:22:29 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:43325 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932418AbWFNWW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:22:27 -0400
Message-ID: <44909A51.4050806@oracle.com>
Date: Wed, 14 Jun 2006 16:22:57 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: len.brown@intel.com, akpm <akpm@osdl.org>
Subject: [Ubuntu PATCH] poke the SCI_EN bit on Macbook resume
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Lortie <desrt@desrt.ca>

[UBUNTU:ich7-sci-en-quirk] poke the SCI_EN bit on Macbook resume
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=d1d9b907570c5c9178e3d66ff208bd483d1dfd61

The following patch deals with the problem that the SCI_EN bit is
disabled when the Macbook comes back from sleeping.

It does this by registering a quirk in the exact way that another one is
registered in the same file (for a Toshiba laptop with a similar
problem).

The quirk matches based on DMI product name of "MacBook1,1" so it should
really only affect the Macbook.

The actual bit-poking is done immediately on return from
do_suspend_lowlevel().  If I do it in the 'finish' function it is too
late (as at this point IRQs have been enabled again for some time).

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---

--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <asm/io.h>
 #include "sleep.h"
 
 int acpi_in_suspend;
@@ -37,6 +38,7 @@ static u32 acpi_suspend_states[] = {
 };
 
 static int init_8259A_after_S1;
+static int ich7_sci_en_quirk_enabled;
 
 /**
  *	acpi_pm_prepare - Do preliminary suspend work.
@@ -98,6 +100,14 @@ static int acpi_pm_enter(suspend_state_t
 
 	case PM_SUSPEND_MEM:
 		do_suspend_lowlevel();
+
+		if (ich7_sci_en_quirk_enabled)
+		{
+			int pm1c = inw(0x404);
+			pm1c |= 0x01; /* SCI_EN */
+			outw (pm1c, 0x404);
+		}
+
 		break;
 
 	case PM_SUSPEND_DISK:
@@ -190,12 +200,31 @@ static int __init init_ints_after_s1(str
 	return 0;
 }
 
+/*
+ * Apple Macbook comes back from sleep with the SCI_EN bit disabled
+ * causing a flood of unacknowledged IRQ9s.  We need to set SCI_EN
+ * as soon as we come back
+ */
+static int __init init_ich7_sci_en_quirk(struct dmi_system_id *d)
+{
+	printk(KERN_WARNING "%s detected (ICH7 SCI_EN quirk enabled)\n",
+               d->ident);
+	ich7_sci_en_quirk_enabled = 1;
+	return 0;
+}
+
+
 static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 	{
 	 .callback = init_ints_after_s1,
 	 .ident = "Toshiba Satellite 4030cdt",
 	 .matches = {DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),},
 	 },
+	{
+	 .callback = init_ich7_sci_en_quirk,
+	 .ident = "Apple MacBook",
+	 .matches = {DMI_MATCH(DMI_PRODUCT_NAME, "MacBook1,1"),},
+	 },
 	{},
 };

