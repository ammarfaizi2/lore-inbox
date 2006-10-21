Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993146AbWJUQv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993146AbWJUQv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993145AbWJUQv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:51:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:1208 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2993144AbWJUQvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:35 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [14/19] i386: Disable nmi watchdog on all ThinkPads
Message-Id: <20061021165134.7ADBB13CB4@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:34 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Even newer Thinkpads have bugs in SMM code that causes hangs with
NMI watchdog.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/nmi.c      |   10 +++++-----
 drivers/firmware/dmi_scan.c |   20 ++++++++++++++++++++
 include/linux/dmi.h         |    2 ++
 3 files changed, 27 insertions(+), 5 deletions(-)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -219,11 +219,11 @@ static int __init check_nmi_watchdog(voi
 	int cpu;
 
 	/* Enable NMI watchdog for newer systems.
-           Actually it should be safe for most systems before 2004 too except
-	   for some IBM systems that corrupt registers when NMI happens
-	   during SMM. Unfortunately we don't have more exact information
- 	   on these and use this coarse check. */
-	if (nmi_watchdog == NMI_DEFAULT && dmi_get_year(DMI_BIOS_DATE) >= 2004)
+	   Probably safe on most older systems too, but let's be careful.
+	   IBM ThinkPads use INT10 inside SMM and that allows early NMI inside SMM
+	   which hangs the system. Disable watchdog for all thinkpads */
+	if (nmi_watchdog == NMI_DEFAULT && dmi_get_year(DMI_BIOS_DATE) >= 2004 &&
+		!dmi_name_in_vendors("ThinkPad"))
 		nmi_watchdog = NMI_LOCAL_APIC;
 
 	if ((nmi_watchdog == NMI_NONE) || (nmi_watchdog == NMI_DEFAULT))
Index: linux/drivers/firmware/dmi_scan.c
===================================================================
--- linux.orig/drivers/firmware/dmi_scan.c
+++ linux/drivers/firmware/dmi_scan.c
@@ -326,6 +326,26 @@ char *dmi_get_system_info(int field)
 }
 EXPORT_SYMBOL(dmi_get_system_info);
 
+
+/**
+ *	dmi_name_in_vendors - Check if string is anywhere in the DMI vendor information.
+ *	@str: 	Case sensitive Name
+ */
+int dmi_name_in_vendors(char *str)
+{
+	static int fields[] = { DMI_BIOS_VENDOR, DMI_BIOS_VERSION, DMI_SYS_VENDOR,
+				DMI_PRODUCT_NAME, DMI_PRODUCT_VERSION, DMI_BOARD_VENDOR,
+				DMI_BOARD_NAME, DMI_BOARD_VERSION, DMI_NONE };
+	int i;
+	for (i = 0; fields[i] != DMI_NONE; i++) {
+		int f = fields[i];
+		if (dmi_ident[f] && strstr(dmi_ident[f], str))
+			return 1;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(dmi_name_in_vendors);
+
 /**
  *	dmi_find_device - find onboard device by type/name
  *	@type: device type or %DMI_DEV_TYPE_ANY to match all device types
Index: linux/include/linux/dmi.h
===================================================================
--- linux.orig/include/linux/dmi.h
+++ linux/include/linux/dmi.h
@@ -69,6 +69,7 @@ extern struct dmi_device * dmi_find_devi
 	struct dmi_device *from);
 extern void dmi_scan_machine(void);
 extern int dmi_get_year(int field);
+extern int dmi_name_in_vendors(char *str);
 
 #else
 
@@ -77,6 +78,7 @@ static inline char * dmi_get_system_info
 static inline struct dmi_device * dmi_find_device(int type, const char *name,
 	struct dmi_device *from) { return NULL; }
 static inline int dmi_get_year(int year) { return 0; }
+static inline int dmi_name_in_vendors(char *s) { return 0; }
 
 #endif
 
