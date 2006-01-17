Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWAQUNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWAQUNK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWAQUNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:13:09 -0500
Received: from fmr19.intel.com ([134.134.136.18]:21432 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S964798AbWAQUNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:13:07 -0500
Date: Tue, 17 Jan 2006 12:13:56 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: Mathieu =?ISO-8859-1?B?QulyYXJk?= <Mathieu.Berard@crans.org>
Cc: lkml <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>,
       jgarzik <jgarzik@pobox.com>, akpm <akpm@osdl.org>
Subject: [PATCH 2/3] libata-acpi: save & free the correct acpi object
Message-Id: <20060117121356.2a0b8420.randy_d_dunlap@linux.intel.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Save and free the correct acpi_object pointer.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-acpi.c |   14 +++++++++-----
 drivers/scsi/libata.h      |    6 ++++--
 2 files changed, 13 insertions(+), 7 deletions(-)

--- linux-2615-mm4.orig/drivers/scsi/libata-acpi.c
+++ linux-2615-mm4/drivers/scsi/libata-acpi.c
@@ -302,7 +302,8 @@ EXPORT_SYMBOL_GPL(ata_acpi_push_id);
  * function return value is 0.
  */
 int do_drive_get_GTF(struct ata_port *ap, struct ata_device *atadev,
-			unsigned int *gtf_length, unsigned long *gtf_address)
+			unsigned int *gtf_length, unsigned long *gtf_address,
+			unsigned long *obj_loc)
 {
 	acpi_status			status;
 	acpi_handle			handle;
@@ -321,6 +322,7 @@ int do_drive_get_GTF(struct ata_port *ap
 
 	*gtf_length = 0;
 	*gtf_address = 0UL;
+	*obj_loc = 0UL;
 
 	if (noacpi)
 		return 0;
@@ -414,10 +416,11 @@ int do_drive_get_GTF(struct ata_port *ap
 
 	*gtf_length = out_obj->buffer.length;
 	*gtf_address = (unsigned long)out_obj->buffer.pointer;
+	*obj_loc = (unsigned long)out_obj;
 	if (ata_msg_probe(ap))
 		printk(KERN_DEBUG "%s: returning "
-			"gtf_length=%d, gtf_address=0x%lx\n",
-			__FUNCTION__, *gtf_length, *gtf_address);
+			"gtf_length=%d, gtf_address=0x%lx, obj_loc=0x%lx\n",
+			__FUNCTION__, *gtf_length, *gtf_address, *obj_loc);
 	err = 0;
 out:
 	return err;
@@ -558,6 +561,7 @@ int ata_acpi_exec_tfs(struct ata_port *a
 	int ret;
 	unsigned int gtf_length;
 	unsigned long gtf_address;
+	unsigned long obj_loc;
 
 	if (ata_msg_probe(ap))
 		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
@@ -570,7 +574,7 @@ int ata_acpi_exec_tfs(struct ata_port *a
 			printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",
 				__FUNCTION__, ix);
 		ret = do_drive_get_GTF(ap, &ap->device[ix],
-				&gtf_length, &gtf_address);
+				&gtf_length, &gtf_address, &obj_loc);
 		if (ret < 0) {
 			if (ata_msg_probe(ap))
 				printk(KERN_DEBUG "%s: get_GTF error (%d)\n",
@@ -583,7 +587,7 @@ int ata_acpi_exec_tfs(struct ata_port *a
 				__FUNCTION__, ix);
 		ret = do_drive_set_taskfiles(ap, &ap->device[ix],
 				gtf_length, gtf_address);
-		acpi_os_free((void *)gtf_address);
+		acpi_os_free((void *)obj_loc);
 		if (ret < 0) {
 			if (ata_msg_probe(ap))
 				printk(KERN_DEBUG
--- linux-2615-mm4.orig/drivers/scsi/libata.h
+++ linux-2615-mm4/drivers/scsi/libata.h
@@ -64,7 +64,8 @@ extern unsigned int ata_exec_internal(st
 #ifdef CONFIG_SCSI_SATA_ACPI
 extern int ata_acpi_push_id(struct ata_port *ap, unsigned int ix);
 extern int do_drive_get_GTF(struct ata_port *ap, struct ata_device *atadev,
-			unsigned int *gtf_length, unsigned long *gtf_address);
+			unsigned int *gtf_length, unsigned long *gtf_address,
+			unsigned long *obj_loc);
 extern int do_drive_set_taskfiles(struct ata_port *ap, struct ata_device *atadev,
 			unsigned int gtf_length, unsigned long gtf_address);
 extern int ata_acpi_exec_tfs(struct ata_port *ap);
@@ -75,7 +76,8 @@ static inline int ata_acpi_push_id(struc
 }
 static inline int do_drive_get_GTF(struct ata_port *ap,
 			struct ata_device *atadev,
-			unsigned int *gtf_length, unsigned long *gtf_address)
+			unsigned int *gtf_length, unsigned long *gtf_address,
+			unsigned long *obj_loc)
 {
 	return 0;
 }


---
~Randy [MPG MPAD MSAE SSA]
