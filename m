Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVCFLeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVCFLeh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 06:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVCFLeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 06:34:37 -0500
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:29389 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261376AbVCFLeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 06:34:31 -0500
From: "Panagiotis Issaris" <panagiotis.issaris@mech.kuleuven.ac.be>
Date: Sun, 6 Mar 2005 12:34:29 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.11-mm1] efi: fix failure handling
Message-ID: <20050306113429.GA20135@mech.kuleuven.ac.be>
References: <20050306094717.GA3843@mech.kuleuven.ac.be> <20050306020627.2b9ca6d0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306020627.2b9ca6d0.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 06, 2005 at 02:06:27AM -0800 or thereabouts, Andrew Morton wrote:
> "Panagiotis Issaris" <panagiotis.issaris@mech.kuleuven.ac.be> wrote:
> >
> > The EFI driver allocates memory and writes into it without checking the
> > success of the allocation. Furthermore, on failure of the firmware_register() it
> > doesn't free the allocated memory and on failure of the subsys_create_file()
> > calls it returns zero instead of the errorcode.
> > 
> 
> Fair enough.  But there's potential for behavioural change here.
> 
> If subsys_create_file() returns an error then efivars_init() will now
> propagate that error.  I suspect we'll need a firmware_unregister() in that
> case.  

You're right. Additionally, possible failure of subsystem_register() wasn't
handled. I've "restyled" the failure handling a bit, to be more like the
generally used failure handling code. The last error check handling check feels
a bit strange to me. Should I try to get it a bit clearer?

Should I update the changelog, version and date which are embedded in the driver?

diff -pruN linux-2.6.11-orig/drivers/firmware/efivars.c linux-2.6.11-pi/drivers/firmware/efivars.c
--- linux-2.6.11-orig/drivers/firmware/efivars.c	2005-03-05 02:23:29.000000000 +0100
+++ linux-2.6.11-pi/drivers/firmware/efivars.c	2005-03-06 12:23:41.000000000 +0100
@@ -665,13 +665,21 @@ efivars_init(void)
 {
 	efi_status_t status = EFI_NOT_FOUND;
 	efi_guid_t vendor_guid;
-	efi_char16_t *variable_name = kmalloc(1024, GFP_KERNEL);
+	efi_char16_t *variable_name;
 	struct subsys_attribute *attr;
 	unsigned long variable_name_size = 1024;
-	int i, rc = 0, error = 0;
+	int i, error = 0;
 
 	if (!efi_enabled)
 		return -ENODEV;
+	
+	variable_name = kmalloc(variable_name_size, GFP_KERNEL);
+	if (!variable_name) {
+		printk(KERN_ERR "efivars: Memory allocation failed.\n");
+		return -ENOMEM;
+	}
+	
+	memset(variable_name, 0, variable_name_size);
 
 	printk(KERN_INFO "EFI Variables Facility v%s %s\n", EFIVARS_VERSION,
 	       EFIVARS_DATE);
@@ -680,21 +688,27 @@ efivars_init(void)
 	 * For now we'll register the efi subsys within this driver
 	 */
 
-	rc = firmware_register(&efi_subsys);
+	error = firmware_register(&efi_subsys);
 
-	if (rc)
-		return rc;
+	if (error) {
+		printk(KERN_ERR "efivars: Firmware registration failed with error %d.\n", error);
+		goto out_free;
+	}
 
 	kset_set_kset_s(&vars_subsys, efi_subsys);
-	subsystem_register(&vars_subsys);
+	
+	error = subsystem_register(&vars_subsys);
+	
+	if (error) {
+		printk(KERN_ERR "efivars: Subsystem registration failed with error %d.\n", error);
+		goto out_firmware_unregister;
+	}
 
 	/*
 	 * Per EFI spec, the maximum storage allocated for both
 	 * the variable name and variable data is 1024 bytes.
 	 */
 
-	memset(variable_name, 0, 1024);
-
 	do {
 		variable_name_size = 1024;
 
@@ -734,8 +748,20 @@ efivars_init(void)
 			error = subsys_create_file(&efi_subsys, attr);
 	}
 
+	if (error)
+		printk(KERN_ERR "efivars: Sysfs attribute export failed with error %d.\n", error);
+	else
+		goto out_free;
+
+	subsystem_unregister(&vars_subsys);
+	
+out_firmware_unregister:
+	firmware_unregister(&efi_subsys);
+	
+out_free:
 	kfree(variable_name);
-	return 0;
+
+	return error;
 }
 
 static void __exit
