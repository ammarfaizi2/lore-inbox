Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTJAKSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 06:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbTJAKSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 06:18:15 -0400
Received: from zeus.kernel.org ([204.152.189.113]:25571 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261686AbTJAKSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 06:18:10 -0400
Date: Wed, 1 Oct 2003 12:14:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: len.brown@intel.com
Subject: ACPI blacklisting code in 2 places
Message-ID: <20031001101447.GA3425@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Currently, acpi blacklisting code has 3 (!) components:

drivers/acpi/blacklist.c
arch/i386/kernel/dmi_scan.c -- code based on bios date
arch/i386/kernel/dmi_scan.c -- code based bios name

. Thats messy. For example drivers/acpi/blacklist.c knows my toshiba
bios is okay (it knows it contains non-fatal errors), but BIOS date
code overrides it, and simulates user doing acpi=off. So system tells
me I have non-fatal errors and then behaves like I passed
acpi=off. Ouch.

Part 1: include acpi.h to dmi_scan.c; dmi_scan and acpi layer both
want to have function called acpi_disable, rename dmi_scan's one. (It
matches rest of file better, anyway).

Please apply,
								Pavel

--- /usr/src/tmp/linux/arch/i386/kernel/dmi_scan.c	2003-09-28 22:05:29.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/dmi_scan.c	2003-10-01 11:55:21.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/pm.h>
 #include <asm/system.h>
 #include <linux/bootmem.h>
+#include <linux/acpi.h>
 
 unsigned long dmi_broken;
 EXPORT_SYMBOL(dmi_broken);
@@ -506,7 +507,7 @@
 
 extern int acpi_disabled, acpi_force;
 
-static __init __attribute__((unused)) int acpi_disable(struct dmi_blacklist *d) 
+static __init __attribute__((unused)) int disable_acpi(struct dmi_blacklist *d) 
 { 
 	if (!acpi_force) { 
 		printk(KERN_NOTICE "%s detected: acpi off\n",d->ident); 
@@ -880,7 +881,7 @@
 	 *	Boxes that need ACPI disabled
 	 */
 
-	{ acpi_disable, "IBM Thinkpad", {
+	{ disable_acpi, "IBM Thinkpad", {
 			MATCH(DMI_BOARD_VENDOR, "IBM"),
 			MATCH(DMI_BOARD_NAME, "2629H1G"),
 			NO_MATCH, NO_MATCH }},

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
