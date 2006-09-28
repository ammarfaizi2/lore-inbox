Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWI1S3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWI1S3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWI1S3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:29:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:57718 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1030354AbWI1S3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:29:15 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,231,1157353200"; 
   d="scan'208"; a="137782362:sNHT69977495"
Date: Thu, 28 Sep 2006 11:29:12 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: linux-ide@vger.intel.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, rdunlap@xenotime.net,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 2/2] libata: _SDD support
Message-Id: <20060928112912.d2ae0d8f.kristen.c.accardi@intel.com>
In-Reply-To: <20060928182211.076258000@localhost.localdomain>
References: <20060928182211.076258000@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

_SDD (Set Device Data) is an ACPI method that is used to tell the 
firmware what the identify data is of the device that is attached to
the port.  It is an optional method, and it's ok for it to be missing. 
Because of this, we always return success from the routine that calls
this method, even if the execution fails.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/ata/libata-acpi.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c |    8 +++
 drivers/ata/libata.h      |    5 ++
 3 files changed, 109 insertions(+)

--- 2.6-mm.orig/drivers/ata/libata-acpi.c
+++ 2.6-mm/drivers/ata/libata-acpi.c
@@ -600,3 +600,99 @@ int ata_acpi_exec_tfs(struct ata_port *a
 	return ret;
 }
 
+/**
+ * ata_acpi_push_id - send Identify data to drive
+ * @ap: the ata_port for the drive
+ * @ix: drive index
+ *
+ * _SDD ACPI object: for SATA mode only
+ * Must be after Identify (Packet) Device -- uses its data
+ * ATM this function never returns a failure.  It is an optional
+ * method and if it fails for whatever reason, we should still
+ * just keep going.
+ */
+int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
+{
+	acpi_handle                     handle;
+	acpi_integer                    pcidevfn;
+	int                             err;
+	struct device                   *dev = ap->host->dev;
+	struct ata_device               *atadev = &ap->device[ix];
+	u32                             dev_adr;
+	acpi_status                     status;
+	struct acpi_object_list         input;
+	union acpi_object               in_params[1];
+
+	if (noacpi)
+		return 0;
+
+	if (ata_msg_probe(ap))
+		ata_dev_printk(atadev, KERN_DEBUG,
+			"%s: ap->id: %d, ix = %d, port#: %d\n",
+			__FUNCTION__, ap->id, ix, ap->port_no);
+
+	/* Don't continue if not a SATA device. */
+	if (!(ap->cbl == ATA_CBL_SATA)) {
+		if (ata_msg_probe(ap))
+			ata_dev_printk(atadev, KERN_DEBUG,
+				"%s: Not a SATA device\n", __FUNCTION__);
+		goto out;
+	}
+
+	/* Don't continue if device has no _ADR method.
+	 * _SDD is intended for known motherboard devices. */
+	err = sata_get_dev_handle(dev, &handle, &pcidevfn);
+	if (err < 0) {
+		if (ata_msg_probe(ap))
+			ata_dev_printk(atadev, KERN_DEBUG,
+				"%s: sata_get_dev_handle failed (%d\n",
+				__FUNCTION__, err);
+		goto out;
+	}
+
+	/* Get this drive's _ADR info, if not already known */
+	if (!atadev->obj_handle) {
+		dev_adr = SATA_ADR_RSVD;
+		err = get_sata_adr(dev, handle, pcidevfn, ix, ap, atadev,
+					&dev_adr);
+		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
+			!atadev->obj_handle) {
+			if (ata_msg_probe(ap))
+				ata_dev_printk(atadev, KERN_DEBUG,
+					"%s: get_sata_adr failed: "
+					"err=%d, dev_adr=%u, obj_handle=0x%p\n",
+					__FUNCTION__, err, dev_adr,
+					atadev->obj_handle);
+			goto out;
+		}
+	}
+
+	/* Give the drive Identify data to the drive via the _SDD method */
+	/* _SDD: set up input parameters */
+	input.count = 1;
+	input.pointer = in_params;
+	in_params[0].type = ACPI_TYPE_BUFFER;
+	in_params[0].buffer.length = sizeof(atadev->id[0] * ATA_ID_WORDS);
+	in_params[0].buffer.pointer = (u8 *)atadev->id;
+	/* Output buffer: _SDD has no output */
+
+	/* It's OK for _SDD to be missing too. */
+	swap_buf_le16(atadev->id, ATA_ID_WORDS);
+	status = acpi_evaluate_object(atadev->obj_handle, "_SDD", &input, NULL);
+	swap_buf_le16(atadev->id, ATA_ID_WORDS);
+
+	err = ACPI_FAILURE(status) ? -EIO : 0;
+	if (err < 0) {
+		if (ata_msg_probe(ap))
+			ata_dev_printk(atadev, KERN_DEBUG,
+				"ata%u(%u): %s _SDD error: status = 0x%x\n",
+				ap->id, ap->device->devno,
+				__FUNCTION__, status);
+	}
+
+	/* always return success */
+out:
+	return 0;
+}
+
+
--- 2.6-mm.orig/drivers/ata/libata-core.c
+++ 2.6-mm/drivers/ata/libata-core.c
@@ -1556,6 +1556,14 @@ int ata_dev_configure(struct ata_device 
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(ap, dev);
 
+	/* set _SDD */
+	rc = ata_acpi_push_id(ap, dev->devno);
+	if (rc) {
+		ata_dev_printk(dev, KERN_WARNING, "failed to set _SDD(%d)\n",
+			rc);
+		goto err_out_nosup;
+	}
+
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: EXIT, drv_stat = 0x%x\n",
 			__FUNCTION__, ata_chk_status(ap));
--- 2.6-mm.orig/drivers/ata/libata.h
+++ 2.6-mm/drivers/ata/libata.h
@@ -78,11 +78,16 @@ extern struct ata_probe_ent *ata_probe_e
 /* libata-acpi.c */
 #ifdef CONFIG_SATA_ACPI
 extern int ata_acpi_exec_tfs(struct ata_port *ap);
+extern int ata_acpi_push_id(struct ata_port *ap, unsigned int ix);
 #else
 static inline int ata_acpi_exec_tfs(struct ata_port *ap)
 {
 	return 0;
 }
+static inline int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
+{
+	return 0;
+}
 #endif
 
 /* libata-scsi.c */

--
