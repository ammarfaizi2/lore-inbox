Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWEJC7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWEJC7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWEJC7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:59:06 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:9278 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932454AbWEJC6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:58:53 -0400
Date: Tue, 9 May 2006 19:55:59 -0700
Message-Id: <200605100255.k4A2txfa031700@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: ipslinux@adaptec.com, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] scsi ips gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the ips_phase1_init fails someplace , and ips_hotplug is enabled, index
would get used to access and array. This looks like definite badness.

Fixes the following warning,

drivers/scsi/ips.c: In function 'ips_register_scsi':
drivers/scsi/ips.c:7043: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/ips.c: In function 'ips_insert_device':
drivers/scsi/ips.c:7124: warning: 'index' may be used uninitialized in this function

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/scsi/ips.c
===================================================================
--- linux-2.6.16.orig/drivers/scsi/ips.c
+++ linux-2.6.16/drivers/scsi/ips.c
@@ -7121,7 +7121,7 @@ module_exit(ips_module_exit);
 static int __devinit
 ips_insert_device(struct pci_dev *pci_dev, const struct pci_device_id *ent)
 {
-	int index;
+	int index = 0;
 	int rc;
 
 	METHOD_TRACE("ips_insert_device", 1);
@@ -7129,17 +7129,17 @@ ips_insert_device(struct pci_dev *pci_de
 		return -1;
 
 	rc = ips_init_phase1(pci_dev, &index);
-	if (rc == SUCCESS)
+	if (rc == SUCCESS) {
 		rc = ips_init_phase2(index);
 
-	if (ips_hotplug)
-		if (ips_register_scsi(index)) {
-			ips_free(ips_ha[index]);
-			rc = -1;
-		}
+		if (ips_hotplug)
+			if (ips_register_scsi(index)) {
+				ips_free(ips_ha[index]);
+				rc = -1;
+			}
 
-	if (rc == SUCCESS)
 		ips_num_controllers++;
+	}
 
 	ips_next_controller = ips_num_controllers;
 	return rc;
Index: linux-2.6.16/drivers/scsi/ips.h
===================================================================
--- linux-2.6.16.orig/drivers/scsi/ips.h
+++ linux-2.6.16/drivers/scsi/ips.h
@@ -109,7 +109,8 @@
    #else
       #define IPS_REGISTER_HOSTS(SHT)      (!ips_detect(SHT))
       #define IPS_UNREGISTER_HOSTS(SHT)
-      #define IPS_ADD_HOST(shost,device)   do { scsi_add_host(shost,device); scsi_scan_host(shost); } while (0)
+      #define IPS_ADD_HOST(shost,device)   do { if (scsi_add_host(shost,device)) return -ENODEV; \
+							scsi_scan_host(shost); } while (0)
       #define IPS_REMOVE_HOST(shost)       scsi_remove_host(shost)
       #define IPS_SCSI_SET_DEVICE(sh,ha)   do { } while (0)
       #define IPS_PRINTK(level, pcidev, format, arg...)                 \
