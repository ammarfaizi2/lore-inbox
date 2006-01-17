Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWAQUNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWAQUNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWAQUNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:13:32 -0500
Received: from fmr17.intel.com ([134.134.136.16]:21457 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964804AbWAQUNb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:13:31 -0500
Date: Tue, 17 Jan 2006 12:13:48 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: Mathieu =?ISO-8859-1?B?QulyYXJk?= <Mathieu.Berard@crans.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org,
       akpm <akpm@osdl.org>
Subject: [PATCH 1/3] libata-acpi:more debugging
Message-Id: <20060117121348.2f40e672.randy_d_dunlap@linux.intel.com>
In-Reply-To: <43C948D1.9010007@crans.org>
References: <43C948D1.9010007@crans.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006 19:54:09 +0100
Mathieu Bérard <Mathieu.Berard@crans.org> wrote:

> Hi,
> 2.6.15-mm4 crash on boot when loading the ata_piix or the ahci module.
> Reverting the libata ACPI support patches workaround this bug.
> 
> (Please CC me)

Hi,
This series of 3 patches to 2.6.15-mm4 fixes it for me.
Thanks,
---

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add more libata-acpi debugging, plus controlled by libata.printk value.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-acpi.c |   53 ++++++++++++++++++++++++++++-----------------
 1 files changed, 34 insertions(+), 19 deletions(-)

--- linux-2615-mm4.orig/drivers/scsi/libata-acpi.c
+++ linux-2615-mm4/drivers/scsi/libata-acpi.c
@@ -371,17 +371,20 @@ int do_drive_get_GTF(struct ata_port *ap
 	status = acpi_evaluate_object(atadev->obj_handle, "_GTF",
 					NULL, &output);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_DEBUG
-			"%s: Run _GTF error: status = 0x%x\n",
-			__FUNCTION__, status);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG
+				"%s: Run _GTF error: status = 0x%x\n",
+				__FUNCTION__, status);
 		goto out;
 	}
 
 	if (!output.length || !output.pointer) {
-		printk(KERN_DEBUG
-			"%s: Run _GTF: length or ptr is NULL (0x%llx, 0x%p)\n",
-			__FUNCTION__,
-			(unsigned long long)output.length, output.pointer);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: Run _GTF: "
+				"length or ptr is NULL (0x%llx, 0x%p)\n",
+				__FUNCTION__,
+				(unsigned long long)output.length,
+				output.pointer);
 		acpi_os_free(output.pointer);
 		goto out;
 	}
@@ -389,23 +392,32 @@ int do_drive_get_GTF(struct ata_port *ap
 	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
 		acpi_os_free(output.pointer);
-		printk(KERN_DEBUG "%s: Run _GTF: error: "
-			"expected object type of ACPI_TYPE_BUFFER, got 0x%x\n",
-			__FUNCTION__, out_obj->type);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: Run _GTF: error: "
+				"expected object type of ACPI_TYPE_BUFFER, "
+				"got 0x%x\n",
+				__FUNCTION__, out_obj->type);
 		err = -ENOENT;
 		goto out;
 	}
 
-	if (out_obj->buffer.length % REGS_PER_GTF) {
+	if (!out_obj->buffer.length || !out_obj->buffer.pointer ||
+	    out_obj->buffer.length % REGS_PER_GTF) {
 		if (ata_msg_drv(ap))
-			printk(KERN_ERR "%s: unexpected GTF length (%d)\n",
-				__FUNCTION__, out_obj->buffer.length);
+			printk(KERN_ERR
+				"%s: unexpected GTF length (%d) or addr (0x%p)\n",
+				__FUNCTION__, out_obj->buffer.length,
+				out_obj->buffer.pointer);
 		err = -ENOENT;
 		goto out;
 	}
 
 	*gtf_length = out_obj->buffer.length;
 	*gtf_address = (unsigned long)out_obj->buffer.pointer;
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: returning "
+			"gtf_length=%d, gtf_address=0x%lx\n",
+			__FUNCTION__, *gtf_length, *gtf_address);
 	err = 0;
 out:
 	return err;
@@ -510,8 +522,9 @@ int do_drive_set_taskfiles(struct ata_po
 
 	if (ata_msg_probe(ap))
 		printk(KERN_DEBUG
-			"%s: total GTF bytes = %u (0x%x), gtf_count = %d\n",
-			__FUNCTION__, gtf_length, gtf_length, gtf_count);
+			"%s: total GTF bytes=%u (0x%x), gtf_count=%d, addr=0x%lx\n",
+			__FUNCTION__, gtf_length, gtf_length, gtf_count,
+			gtf_address);
 	if (gtf_length % REGS_PER_GTF) {
 		if (ata_msg_drv(ap))
 			printk(KERN_ERR "%s: unexpected GTF length (%d)\n",
@@ -553,8 +566,9 @@ int ata_acpi_exec_tfs(struct ata_port *a
 		return 0;
 
 	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
-		printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",
-			__FUNCTION__, ix);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",
+				__FUNCTION__, ix);
 		ret = do_drive_get_GTF(ap, &ap->device[ix],
 				&gtf_length, &gtf_address);
 		if (ret < 0) {
@@ -564,8 +578,9 @@ int ata_acpi_exec_tfs(struct ata_port *a
 			break;
 		}
 
-		printk(KERN_DEBUG "%s: call set_taskfiles, ix=%d\n",
-			__FUNCTION__, ix);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: call set_taskfiles, ix=%d\n",
+				__FUNCTION__, ix);
 		ret = do_drive_set_taskfiles(ap, &ap->device[ix],
 				gtf_length, gtf_address);
 		acpi_os_free((void *)gtf_address);
