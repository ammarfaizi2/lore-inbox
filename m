Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVGNWUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVGNWUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVGNWUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:20:06 -0400
Received: from coderock.org ([193.77.147.115]:27297 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262527AbVGNWTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:19:36 -0400
Message-Id: <20050714221930.905863000@homer>
Date: Fri, 15 Jul 2005 00:19:31 +0200
From: domen@coderock.org
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: [patch 1/1] arm/kernel: Audit return code of create_proc_*
Content-Disposition: inline; filename=return_code-arch_arm_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>


---
 apm.c   |    5 ++++-
 ecard.c |   14 ++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

Index: quilt/arch/arm/kernel/apm.c
===================================================================
--- quilt.orig/arch/arm/kernel/apm.c
+++ quilt/arch/arm/kernel/apm.c
@@ -514,6 +514,7 @@ static int kapmd(void *arg)
 
 static int __init apm_init(void)
 {
+	struct proc_dir_entry *proc_entry;
 	int ret;
 
 	if (apm_disabled) {
@@ -535,7 +536,9 @@ static int __init apm_init(void)
 	}
 
 #ifdef CONFIG_PROC_FS
-	create_proc_info_entry("apm", 0, NULL, apm_get_info);
+	proc_entry = create_proc_info_entry("apm", 0, NULL, apm_get_info);
+	if (proc_entry == NULL)
+		printk(KERN_WARNING "apm: Unable to create apm proc entry.\n");
 #endif
 
 	ret = misc_register(&apm_device);
Index: quilt/arch/arm/kernel/ecard.c
===================================================================
--- quilt.orig/arch/arm/kernel/ecard.c
+++ quilt/arch/arm/kernel/ecard.c
@@ -776,9 +776,19 @@ static struct proc_dir_entry *proc_bus_e
 
 static void ecard_proc_init(void)
 {
+	struct proc_dir_entry *proc_entry;
+
 	proc_bus_ecard_dir = proc_mkdir("ecard", proc_bus);
-	create_proc_info_entry("devices", 0, proc_bus_ecard_dir,
-		get_ecard_dev_info);
+	if (proc_bus_ecard_dir == NULL)
+		printk(KERN_WARNING 
+			"ecard: Unable to create proc dir entry.\n");
+	else {
+		proc_entry = create_proc_info_entry("devices", 0, 
+			proc_bus_ecard_dir, get_ecard_dev_info);
+		if (proc_entry == NULL) 
+			printk(KERN_WARNING 
+				"ecard: Unable to create proc entry.\n");
+	}
 }
 
 #define ec_set_resource(ec,nr,st,sz)				\

--
