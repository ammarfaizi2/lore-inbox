Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWJEEI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWJEEI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWJEEI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:08:26 -0400
Received: from mail0.lsil.com ([147.145.40.20]:58267 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750743AbWJEEIZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:08:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] SCSI megaraid_sas: handle thrown errors
Date: Wed, 4 Oct 2006 22:08:07 -0600
Message-ID: <0631C836DBF79F42B5A60C8C8D4E822971ABFF@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] SCSI megaraid_sas: handle thrown errors
Thread-Index: AcbnoKn7UaKZ2n5eSSWgM8BVWm0uogAkyzQg
From: "Patro, Sumant" <Sumant.Patro@lsil.com>
To: "Jeff Garzik" <jeff@garzik.org>, <linux-scsi@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Oct 2006 04:08:08.0214 (UTC) FILETIME=[DD672B60:01C6E833]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Jeff.

Regards,

Sumant

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Jeff Garzik
Sent: Wednesday, October 04, 2006 3:34 AM
To: linux-scsi@vger.kernel.org
Cc: Andrew Morton; LKML
Subject: [PATCH] SCSI megaraid_sas: handle thrown errors


- handle clear_user() error

- handle and properly unwind from sysfs errors thrown during mod init

- adjust order of calls in megasas_exit() to precisely match
  registration order in megasas_init()

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/scsi/megaraid/megaraid_sas.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.c
b/drivers/scsi/megaraid/megaraid_sas.c
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
 		printk(KERN_DEBUG "megasas: PCI hotplug regisration
failed \n");
-		unregister_chrdev(megasas_mgmt_majorno,
"megaraid_sas_ioctl");
+		goto err_pcidrv;
 	}
 
-	driver_create_file(&megasas_pci_driver.driver,
&driver_attr_version);
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
+	driver_remove_file(&megasas_pci_driver.driver,
&driver_attr_version);
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
-	driver_remove_file(&megasas_pci_driver.driver,
&driver_attr_version);
 	driver_remove_file(&megasas_pci_driver.driver,
 			   &driver_attr_release_date);
+	driver_remove_file(&megasas_pci_driver.driver,
&driver_attr_version);
 
 	pci_unregister_driver(&megasas_pci_driver);
 	unregister_chrdev(megasas_mgmt_majorno, "megaraid_sas_ioctl");
-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
