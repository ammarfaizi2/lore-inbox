Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030547AbWJDKeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547AbWJDKeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 06:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030799AbWJDKeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 06:34:08 -0400
Received: from havoc.gtf.org ([69.61.125.42]:63367 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030547AbWJDKeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 06:34:05 -0400
Date: Wed, 4 Oct 2006 06:34:03 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-scsi@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI megaraid_sas: handle thrown errors
Message-ID: <20061004103403.GA18459@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- handle clear_user() error

- handle and properly unwind from sysfs errors thrown during mod init

- adjust order of calls in megasas_exit() to precisely match
  registration order in megasas_init()

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/scsi/megaraid/megaraid_sas.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.c b/drivers/scsi/megaraid/megaraid_sas.c
index 4cab5b5..8e0ab99 100644
--- a/drivers/scsi/megaraid/megaraid_sas.c
+++ b/drivers/scsi/megaraid/megaraid_sas.c
@@ -2716,7 +2716,8 @@ static int megasas_mgmt_compat_ioctl_fw(
 	int i;
 	int error = 0;
 
-	clear_user(ioc, sizeof(*ioc));
+	if (clear_user(ioc, sizeof(*ioc)))
+		return -EFAULT;
 
 	if (copy_in_user(&ioc->host_no, &cioc->host_no, sizeof(u16)) ||
 	    copy_in_user(&ioc->sgl_off, &cioc->sgl_off, sizeof(u32)) ||
@@ -2842,13 +2843,26 @@ static int __init megasas_init(void)
 
 	if (rval) {
 		printk(KERN_DEBUG "megasas: PCI hotplug regisration failed \n");
-		unregister_chrdev(megasas_mgmt_majorno, "megaraid_sas_ioctl");
+		goto err_pcidrv;
 	}
 
-	driver_create_file(&megasas_pci_driver.driver, &driver_attr_version);
-	driver_create_file(&megasas_pci_driver.driver,
-			   &driver_attr_release_date);
+	rval = driver_create_file(&megasas_pci_driver.driver,
+				  &driver_attr_version);
+	if (rval)
+		goto err_dcf_attr_ver;
+	rval = driver_create_file(&megasas_pci_driver.driver,
+				  &driver_attr_release_date);
+	if (rval)
+		goto err_dcf_rel_date;
 
+	return 0;
+
+err_dcf_rel_date:
+	driver_remove_file(&megasas_pci_driver.driver, &driver_attr_version);
+err_dcf_attr_ver:
+	pci_unregister_driver(&megasas_pci_driver);
+err_pcidrv:
+	unregister_chrdev(megasas_mgmt_majorno, "megaraid_sas_ioctl");
 	return rval;
 }
 
@@ -2857,9 +2871,9 @@ static int __init megasas_init(void)
  */
 static void __exit megasas_exit(void)
 {
-	driver_remove_file(&megasas_pci_driver.driver, &driver_attr_version);
 	driver_remove_file(&megasas_pci_driver.driver,
 			   &driver_attr_release_date);
+	driver_remove_file(&megasas_pci_driver.driver, &driver_attr_version);
 
 	pci_unregister_driver(&megasas_pci_driver);
 	unregister_chrdev(megasas_mgmt_majorno, "megaraid_sas_ioctl");
