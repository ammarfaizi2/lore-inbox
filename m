Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVCFJr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVCFJr2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 04:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVCFJr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 04:47:28 -0500
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:4285 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261339AbVCFJrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 04:47:20 -0500
From: "Panagiotis Issaris" <panagiotis.issaris@mech.kuleuven.ac.be>
Date: Sun, 6 Mar 2005 10:47:17 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11-mm1] efi: fix failure handling
Message-ID: <20050306094717.GA3843@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EFI driver allocates memory and writes into it without checking the
success of the allocation. Furthermore, on failure of the firmware_register() it
doesn't free the allocated memory and on failure of the subsys_create_file()
calls it returns zero instead of the errorcode.

Signed-off-by: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>

diff -pruN linux-2.6.11-orig/drivers/firmware/efivars.c linux-2.6.11-pi/drivers/firmware/efivars.c
--- linux-2.6.11-orig/drivers/firmware/efivars.c	2005-03-05 02:23:29.000000000 +0100
+++ linux-2.6.11-pi/drivers/firmware/efivars.c	2005-03-05 21:09:33.000000000 +0100
@@ -665,13 +665,19 @@ efivars_init(void)
 {
 	efi_status_t status = EFI_NOT_FOUND;
 	efi_guid_t vendor_guid;
-	efi_char16_t *variable_name = kmalloc(1024, GFP_KERNEL);
+	efi_char16_t *variable_name;
 	struct subsys_attribute *attr;
 	unsigned long variable_name_size = 1024;
 	int i, rc = 0, error = 0;
 
 	if (!efi_enabled)
 		return -ENODEV;
+	
+	variable_name = kmalloc(variable_name_size, GFP_KERNEL);
+	if (!variable_name)
+		return -ENOMEM;
+	
+	memset(variable_name, 0, variable_name_size);
 
 	printk(KERN_INFO "EFI Variables Facility v%s %s\n", EFIVARS_VERSION,
 	       EFIVARS_DATE);
@@ -682,8 +688,10 @@ efivars_init(void)
 
 	rc = firmware_register(&efi_subsys);
 
-	if (rc)
+	if (rc) {	
+		kfree(variable_name);
 		return rc;
+	}
 
 	kset_set_kset_s(&vars_subsys, efi_subsys);
 	subsystem_register(&vars_subsys);
@@ -693,8 +701,6 @@ efivars_init(void)
 	 * the variable name and variable data is 1024 bytes.
 	 */
 
-	memset(variable_name, 0, 1024);
-
 	do {
 		variable_name_size = 1024;
 
@@ -735,7 +741,7 @@ efivars_init(void)
 	}
 
 	kfree(variable_name);
-	return 0;
+	return error;
 }
 
 static void __exit
