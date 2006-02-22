Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWBVWPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWBVWPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWBVWLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:11:38 -0500
Received: from fmr17.intel.com ([134.134.136.16]:59029 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751508AbWBVWLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:11:14 -0500
Date: Wed, 22 Feb 2006 13:58:57 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [PATCH 8/13] ATA ACPI: PATA methods
Message-Id: <20060222135857.09929ffe.randy_d_dunlap@linux.intel.com>
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
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

Add PATA support to the previous SATA support.
Add _GTM and _STM methods and expose (export) them.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-acpi.c |  421 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/scsi/libata-core.c |   23 ++
 drivers/scsi/libata.h      |   13 +
 include/linux/libata.h     |   10 -
 4 files changed, 433 insertions(+), 34 deletions(-)

--- linux-2616-rc4-ata.orig/drivers/scsi/libata-acpi.c
+++ linux-2616-rc4-ata/drivers/scsi/libata-acpi.c
@@ -35,6 +35,23 @@ struct taskfile_array {
 	u8	tfa[REGS_PER_GTF];	/* regs. 0x1f1 - 0x1f7 */
 };
 
+struct GTM_buffer {
+	__u32	PIO_speed0;
+	__u32	DMA_speed0;
+	__u32	PIO_speed1;
+	__u32	DMA_speed1;
+	__u32	GTM_flags;
+};
+
+#define DEBUGGING	1
+/* note: adds function name and KERN_DEBUG */
+#ifdef DEBUGGING
+#define DEBPRINT(fmt, args...)	\
+		printk(KERN_DEBUG "%s: " fmt, __FUNCTION__, ## args)
+#else
+#define DEBPRINT(fmt, args...)	do {} while (0)
+#endif	/* DEBUGGING */
+
 /**
  * sata_get_dev_handle - finds acpi_handle and PCI device.function
  * @dev: device to locate
@@ -58,11 +75,84 @@ static int sata_get_dev_handle(struct de
 	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
 	*pcidevfn = addr;
 	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
+	printk(KERN_DEBUG "%s: SATA dev addr=0x%llx, handle=0x%p\n",
+		__FUNCTION__, (unsigned long long)addr, *handle);
 	if (!*handle)
 		return -ENODEV;
 	return 0;
 }
 
+/**
+ * pata_get_dev_handle - finds acpi_handle and PCI device.function
+ * @dev: device to locate
+ * @handle: returned acpi_handle for @dev
+ * @pcidevfn: return PCI device.func for @dev
+ *
+ * The PATA and SATA versions of this function are different.
+ *
+ * Returns 0 on success, <0 on error.
+ */
+static int pata_get_dev_handle(struct device *dev, acpi_handle *handle,
+					acpi_integer *pcidevfn)
+{
+	unsigned int domain, bus, devnum, func;
+	acpi_integer addr;
+	acpi_handle dev_handle, parent_handle;
+	int scanned;
+	struct acpi_buffer buffer = {.length = ACPI_ALLOCATE_BUFFER,
+					.pointer = NULL};
+	acpi_status status;
+	struct acpi_device_info	*dinfo = NULL;
+	int ret = -ENODEV;
+
+	printk(KERN_DEBUG "%s: ENTER: dev->bus_id='%s'\n",
+		__FUNCTION__, dev->bus_id);
+	if ((scanned = sscanf(dev->bus_id, "%x:%x:%x.%x",
+			&domain, &bus, &devnum, &func)) != 4) {
+		printk(KERN_DEBUG "%s: sscanf ret. %d\n",
+			__FUNCTION__, scanned);
+		goto err;
+	}
+
+	dev_handle = DEVICE_ACPI_HANDLE(dev);
+	parent_handle = DEVICE_ACPI_HANDLE(dev->parent);
+
+	status = acpi_get_object_info(parent_handle, &buffer);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_DEBUG "%s: get_object_info for parent failed\n",
+			__FUNCTION__);
+		goto err;
+	}
+	dinfo = buffer.pointer;
+	if (dinfo && (dinfo->valid & ACPI_VALID_ADR) &&
+	    dinfo->address == bus) {
+		/* ACPI spec for _ADR for PCI bus: */
+		addr = (acpi_integer)(devnum << 16 | func);
+		*pcidevfn = addr;
+		*handle = dev_handle;
+	} else {
+		printk(KERN_DEBUG "%s: get_object_info for parent has wrong "
+			" bus: %llu, should be %d\n",
+			__FUNCTION__,
+			dinfo ? (unsigned long long)dinfo->address : -1ULL,
+			bus);
+		goto err;
+	}
+
+	printk(KERN_DEBUG "%s: dev_handle: 0x%p, parent_handle: 0x%p\n",
+		__FUNCTION__, dev_handle, parent_handle);
+	printk(KERN_DEBUG
+		"%s: for dev=0x%x.%x, addr=0x%llx, parent=0x%p, *handle=0x%p\n",
+		__FUNCTION__, devnum, func, (unsigned long long)addr,
+		dev->parent, *handle);
+	if (!*handle)
+		goto err;
+	ret = 0;
+err:
+	acpi_os_free(dinfo);
+	return ret;
+}
+
 struct walk_info {		/* can be trimmed some */
 	struct device	*dev;
 	struct acpi_device *adev;
@@ -198,6 +288,7 @@ out:
  * @ap: the ata_port for the drive
  * @ix: drive index
  *
+ * _SDD ACPI object:  for SATA mode only.
  * Must be after Identify (Packet) Device -- uses its data.
  */
 int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
@@ -212,6 +303,11 @@ int ata_acpi_push_id(struct ata_port *ap
 	struct acpi_object_list		input;
 	union acpi_object 		in_params[1];
 
+	if (ap->legacy_mode) {
+		printk(KERN_DEBUG "%s: skipping for PATA mode\n",
+			__FUNCTION__);
+		return 0;
+	}
 	if (noacpi)
 		return 0;
 
@@ -286,7 +382,7 @@ EXPORT_SYMBOL_GPL(ata_acpi_push_id);
 /**
  * do_drive_get_GTF - get the drive bootup default taskfile settings
  * @ap: the ata_port for the drive
- * @atadev: target ata_device
+ * @ix: target ata_device (drive) index
  * @gtf_length: number of bytes of _GTF data returned at @gtf_address
  * @gtf_address: buffer containing _GTF taskfile arrays
  *
@@ -301,25 +397,21 @@ EXPORT_SYMBOL_GPL(ata_acpi_push_id);
  * The returned @gtf_length and @gtf_address are only valid if the
  * function return value is 0.
  */
-int do_drive_get_GTF(struct ata_port *ap, struct ata_device *atadev,
+int do_drive_get_GTF(struct ata_port *ap, int ix,
 			unsigned int *gtf_length, unsigned long *gtf_address,
 			unsigned long *obj_loc)
 {
 	acpi_status			status;
-	acpi_handle			handle;
+	acpi_handle			dev_handle;
+	acpi_handle			chan_handle, drive_handle;
 	acpi_integer			pcidevfn;
 	u32				dev_adr;
 	struct acpi_buffer		output;
 	union acpi_object 		*out_obj;
 	struct device			*dev = ap->host_set->dev;
+	struct ata_device		*atadev = &ap->device[ix];
 	int				err = -ENODEV;
 
-	if (ata_msg_probe(ap))
-		printk(KERN_DEBUG
-			"%s: ENTER: ap->id: %d, port#: %d, hard_port#: %d\n",
-			__FUNCTION__, ap->id,
-		ap->port_no, ap->hard_port_no);
-
 	*gtf_length = 0;
 	*gtf_address = 0UL;
 	*obj_loc = 0UL;
@@ -327,6 +419,12 @@ int do_drive_get_GTF(struct ata_port *ap
 	if (noacpi)
 		return 0;
 
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG
+			"%s: ENTER: ap->id: %d, port#: %d, hard_port#: %d\n",
+			__FUNCTION__, ap->id,
+		ap->port_no, ap->hard_port_no);
+
 	if (!ata_dev_present(atadev) ||
 	    (ap->flags & ATA_FLAG_PORT_DISABLED)) {
 		if (ata_msg_probe(ap))
@@ -339,24 +437,65 @@ int do_drive_get_GTF(struct ata_port *ap
 
 	/* Don't continue if device has no _ADR method.
 	 * _GTF is intended for known motherboard devices. */
-	err = sata_get_dev_handle(dev, &handle, &pcidevfn);
-	if (err < 0) {
-		if (ata_msg_probe(ap))
-			printk(KERN_DEBUG
-				"%s: sata_get_dev_handle failed (%d\n",
-				__FUNCTION__, err);
-		goto out;
+	if (ata_id_is_ata(atadev->id)) {
+		err = pata_get_dev_handle(dev, &dev_handle, &pcidevfn);
+		if (err < 0) {
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG
+					"%s: pata_get_dev_handle failed (%d)\n",
+					__FUNCTION__, err);
+			goto out;
+		}
+	} else {
+		err = sata_get_dev_handle(dev, &dev_handle, &pcidevfn);
+		if (err < 0) {
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG
+					"%s: sata_get_dev_handle failed (%d\n",
+					__FUNCTION__, err);
+			goto out;
+		}
 	}
 
 	/* Get this drive's _ADR info. if not already known. */
 	if (!atadev->obj_handle) {
-		dev_adr = SATA_ADR_RSVD;
-		err = get_sata_adr(dev, handle, pcidevfn, 0, ap, atadev,
-				&dev_adr);
+		if (ata_id_is_ata(atadev->id)) {
+			/* get child objects of dev_handle == channel objects,
+	 		 * + _their_ children == drive objects */
+			/* channel is ap->hard_port_no */
+			chan_handle = acpi_get_child(dev_handle,
+						ap->hard_port_no);
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG
+					"%s: chan adr=%d: chan_handle=0x%p\n",
+					__FUNCTION__, ap->hard_port_no,
+					chan_handle);
+			if (!chan_handle) {
+				err = -ENODEV;
+				goto out;
+			}
+			/* TBD: could also check ACPI object VALID bits */
+			drive_handle = acpi_get_child(chan_handle, ix);
+			printk(KERN_DEBUG "%s:   drive w/ adr=%d: %c: 0x%p\n",
+				__FUNCTION__, ix,
+				ap->device[0].class == ATA_DEV_NONE ? 'n' : 'v',
+				drive_handle);
+			if (!drive_handle) {
+				err = -ENODEV;
+				goto out;
+			}
+			dev_adr = ix;
+			atadev->obj_handle = drive_handle;
+		} else {	/* for SATA mode */
+			dev_adr = SATA_ADR_RSVD;
+			err = get_sata_adr(dev, dev_handle, pcidevfn, 0,
+					ap, atadev, &dev_adr);
+		}
 		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
 		    !atadev->obj_handle) {
 			if (ata_msg_probe(ap))
-				printk(KERN_DEBUG "%s: get_sata_adr failed: "
+				printk(KERN_DEBUG
+					"%s: get_sata/pata_adr failed: "
 					"err=%d, dev_adr=%u, obj_handle=0x%p\n",
 					__FUNCTION__, err, dev_adr,
 					atadev->obj_handle);
@@ -516,6 +655,11 @@ int do_drive_set_taskfiles(struct ata_po
 
 	if (noacpi)
 		return 0;
+	if (!ata_id_is_sata(atadev->id)) {
+		printk(KERN_DEBUG "%s: skipping non-SATA drive\n",
+			__FUNCTION__);
+		return 0;
+	}
 
 	if (!ata_dev_present(atadev) ||
 	    (ap->flags & ATA_FLAG_PORT_DISABLED))
@@ -557,11 +701,11 @@ EXPORT_SYMBOL_GPL(do_drive_set_taskfiles
  */
 int ata_acpi_exec_tfs(struct ata_port *ap)
 {
-	int ix;
-	int ret;
-	unsigned int gtf_length;
-	unsigned long gtf_address;
-	unsigned long obj_loc;
+	int		ix;
+	int		ret;
+	unsigned int	gtf_length;
+	unsigned long	gtf_address;
+	unsigned long	obj_loc;
 
 	if (ata_msg_probe(ap))
 		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
@@ -573,7 +717,7 @@ int ata_acpi_exec_tfs(struct ata_port *a
 		if (ata_msg_probe(ap))
 			printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",
 				__FUNCTION__, ix);
-		ret = do_drive_get_GTF(ap, &ap->device[ix],
+		ret = do_drive_get_GTF(ap, ix,
 				&gtf_length, &gtf_address, &obj_loc);
 		if (ret < 0) {
 			if (ata_msg_probe(ap))
@@ -603,3 +747,228 @@ int ata_acpi_exec_tfs(struct ata_port *a
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ata_acpi_exec_tfs);
+
+/**
+ * ata_acpi_get_timing - get the channel (controller) timings
+ * @ap: target ata_port (channel)
+ *
+ * For PATA ACPI, this function executes the _GTM ACPI method for the
+ * target channel.
+ *
+ * _GTM only applies to ATA controllers in PATA (legacy) mode, not to SATA.
+ * In legacy mode, ap->hard_port_no is channel (controller) number.
+ */
+void ata_acpi_get_timing(struct ata_port *ap)
+{
+	struct device		*dev = ap->dev;
+	int			err;
+	acpi_handle		dev_handle;
+	acpi_integer		pcidevfn;
+	acpi_handle		chan_handle;
+	acpi_status		status;
+	struct acpi_buffer	output;
+	union acpi_object 	*out_obj;
+	struct GTM_buffer	*gtm;
+
+	if (noacpi)
+		goto out;
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
+
+	if (!ap->legacy_mode) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG
+				"%s: channel/controller not in legacy mode (%s)\n",
+				__FUNCTION__, dev->bus_id);
+		goto out;
+	}
+
+	err = pata_get_dev_handle(dev, &dev_handle, &pcidevfn);
+	if (err < 0) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG
+				"%s: pata_get_dev_handle failed (%d)\n",
+				__FUNCTION__, err);
+		goto out;
+	}
+
+	/* get child objects of dev_handle == channel objects,
+	 * + _their_ children == drive objects */
+	/* channel is ap->hard_port_no */
+	chan_handle = acpi_get_child(dev_handle, ap->hard_port_no);
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: chan adr=%d: handle=0x%p\n",
+			__FUNCTION__, ap->hard_port_no, chan_handle);
+	if (!chan_handle)
+		goto out;
+
+	/* Setting up output buffer for _GTM */
+	output.length = ACPI_ALLOCATE_BUFFER;
+	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
+
+	/* _GTM has no input parameters */
+	status = acpi_evaluate_object(chan_handle, "_GTM",
+					NULL, &output);
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: _GTM status: %d, outptr: 0x%p, outlen: 0x%llx\n",
+			__FUNCTION__, status, output.pointer,
+			(unsigned long long)output.length);
+	if (ACPI_FAILURE(status)) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG
+				"%s: Run _GTM error: status = 0x%x\n",
+				__FUNCTION__, status);
+		goto out;
+	}
+
+	if (!output.length || !output.pointer) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: Run _GTM: "
+				"length or ptr is NULL (0x%llx, 0x%p)\n",
+				__FUNCTION__,
+				(unsigned long long)output.length,
+				output.pointer);
+		acpi_os_free(output.pointer);
+		goto out;
+	}
+
+	out_obj = output.pointer;
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
+		acpi_os_free(output.pointer);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: Run _GTM: error: "
+				"expected object type of ACPI_TYPE_BUFFER, "
+				"got 0x%x\n",
+				__FUNCTION__, out_obj->type);
+		goto out;
+	}
+
+	if (!out_obj->buffer.length || !out_obj->buffer.pointer ||
+	    out_obj->buffer.length != sizeof(struct GTM_buffer)) {
+		acpi_os_free(output.pointer);
+		if (ata_msg_drv(ap))
+			printk(KERN_ERR
+				"%s: unexpected _GTM length (0x%x)[should be 0x%x] or addr (0x%p)\n",
+				__FUNCTION__, out_obj->buffer.length,
+				sizeof(struct GTM_buffer), out_obj->buffer.pointer);
+		goto out;
+	}
+
+	gtm = (struct GTM_buffer *)out_obj->buffer.pointer;
+	if (ata_msg_probe(ap)) {
+		printk(KERN_DEBUG "%s: _GTM info: ptr: 0x%p, len: 0x%x, exp.len: 0x%Zx\n",
+			__FUNCTION__, out_obj->buffer.pointer,
+			out_obj->buffer.length, sizeof(struct GTM_buffer));
+		printk(KERN_DEBUG "%s: _GTM fields: 0x%x, 0x%x, 0x%x, 0x%x, 0x%x\n",
+			__FUNCTION__, gtm->PIO_speed0, gtm->DMA_speed0,
+			gtm->PIO_speed1, gtm->DMA_speed1, gtm->GTM_flags);
+	}
+
+	/* TBD: when to free gtm */
+	ap->gtm = gtm;
+	kfree(ap->gtm_object_area); /* free previous then store new one */
+	ap->gtm_object_area = out_obj;
+out:;
+}
+EXPORT_SYMBOL_GPL(ata_acpi_get_timing);
+
+/**
+ * ata_acpi_push_timing - set the channel (controller) timings
+ * @ap: target ata_port (channel)
+ *
+ * For PATA ACPI, this function executes the _STM ACPI method for the
+ * target channel.
+ *
+ * _STM only applies to ATA controllers in PATA (legacy) mode, not to SATA.
+ * In legacy mode, ap->hard_port_no is channel (controller) number.
+ *
+ * _STM requires Identify Drive data, which must already be present in
+ * ata_device->id[] (i.e., it's not fetched here).
+ */
+void ata_acpi_push_timing(struct ata_port *ap)
+{
+	struct device		*dev = ap->dev;
+	int			err;
+	acpi_handle		dev_handle;
+	acpi_integer		pcidevfn;
+	acpi_handle		chan_handle;
+	acpi_status		status;
+	struct acpi_object_list	input;
+	union acpi_object 	in_params[1];
+
+	if (noacpi)
+		goto out;
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
+
+	if (!ap->legacy_mode) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG
+				"%s: channel/controller not in legacy mode (%s)\n",
+				__FUNCTION__, dev->bus_id);
+		goto out;
+	}
+
+	if (ap->device[0].id[49] || ap->device[1].id[49]) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: drive(s) on channel %d: missing Identify data\n",
+				__FUNCTION__, ap->hard_port_no);
+		goto out;
+	}
+
+	err = pata_get_dev_handle(dev, &dev_handle, &pcidevfn);
+	if (err < 0) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG
+				"%s: pata_get_dev_handle failed (%d)\n",
+				__FUNCTION__, err);
+		goto out;
+	}
+
+	/* get child objects of dev_handle == channel objects,
+	 * + _their_ children == drive objects */
+	/* channel is ap->hard_port_no */
+	chan_handle = acpi_get_child(dev_handle, ap->hard_port_no);
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: chan adr=%d: handle=0x%p\n",
+			__FUNCTION__, ap->hard_port_no, chan_handle);
+	if (!chan_handle)
+		goto out;
+
+	/* Give the GTM buffer + drive Identify data to the channel via the
+	 * _STM method: */
+	/* setup input parameters buffer for _STM */
+	input.count = 3;
+	input.pointer = in_params;
+	in_params[0].type = ACPI_TYPE_BUFFER;
+	in_params[0].buffer.length = sizeof(struct GTM_buffer);
+	in_params[0].buffer.pointer = (u8 *)ap->gtm;
+	in_params[1].type = ACPI_TYPE_BUFFER;
+	in_params[1].buffer.length = sizeof(ap->device[0].id);
+	in_params[1].buffer.pointer = (u8 *)ap->device[0].id;
+	in_params[2].type = ACPI_TYPE_BUFFER;
+	in_params[2].buffer.length = sizeof(ap->device[1].id);
+	in_params[2].buffer.pointer = (u8 *)ap->device[1].id;
+	/* Output buffer: _STM has no output */
+
+	swap_buf_le16(ap->device[0].id, ATA_ID_WORDS);
+	swap_buf_le16(ap->device[1].id, ATA_ID_WORDS);
+	status = acpi_evaluate_object(chan_handle, "_STM", &input, NULL);
+	swap_buf_le16(ap->device[0].id, ATA_ID_WORDS);
+	swap_buf_le16(ap->device[1].id, ATA_ID_WORDS);
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: _STM status: %d\n",
+			__FUNCTION__, status);
+	if (ACPI_FAILURE(status)) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG
+				"%s: Run _STM error: status = 0x%x\n",
+				__FUNCTION__, status);
+		goto out;
+	}
+
+out:;
+}
+EXPORT_SYMBOL_GPL(ata_acpi_push_timing);
--- linux-2616-rc4-ata.orig/drivers/scsi/libata-core.c
+++ linux-2616-rc4-ata/drivers/scsi/libata-core.c
@@ -1309,11 +1309,11 @@ retry:
 
 	/* print device capabilities */
 	printk(KERN_DEBUG "ata%u: dev %u cfg "
-	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
-	       ap->id, device, dev->id[49],
+	       "00:%04x 49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x 93:%04x\n",
+	       ap->id, device, dev->id[0], dev->id[49],
 	       dev->id[82], dev->id[83], dev->id[84],
 	       dev->id[85], dev->id[86], dev->id[87],
-	       dev->id[88]);
+	       dev->id[88], dev->id[93]);
 
 	/*
 	 * common ATA, ATAPI feature tests
@@ -4433,6 +4433,7 @@ static void ata_host_init(struct ata_por
 	ap->port_no = port_no;
 	ap->hard_port_no =
 		ent->legacy_mode ? ent->hard_port_no : port_no;
+	ap->legacy_mode = ent->legacy_mode;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
@@ -4441,6 +4442,7 @@ static void ata_host_init(struct ata_por
 	ap->cbl = ATA_CBL_NONE;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
+	ap->dev = ent->dev;
 
 	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
 	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
@@ -4559,6 +4561,7 @@ int ata_device_add(const struct ata_prob
 		printk(KERN_INFO "ata%u: %cATA max %s cmd 0x%lX ctl 0x%lX "
 				 "bmdma 0x%lX irq %lu\n",
 			ap->id,
+			ap->flags & ATA_FLAG_PATA_MODE ? 'P' :
 			ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
 			ata_mode_string(xfer_mode_mask),
 	       		ap->ioaddr.cmd_addr,
@@ -4620,6 +4623,12 @@ int ata_device_add(const struct ata_prob
 		ata_scsi_scan_host(ap);
 	}
 
+	for (i = 0; i < ent->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		ata_acpi_get_timing(ap);
+	}
+
 	dev_set_drvdata(dev, host_set);
 
 	VPRINTK("EXIT, returning %u\n", ent->n_ports);
@@ -4839,6 +4848,7 @@ static struct ata_probe_ent *ata_pci_ini
 	probe_ent->n_ports = 1;
 	probe_ent->hard_port_no = port_num;
 	probe_ent->private_data = port->private_data;
+	probe_ent->host_flags = port->host_flags;
 
 	switch(port_num)
 	{
@@ -4899,14 +4909,21 @@ int ata_pci_init_one (struct pci_dev *pd
 	else
 		port[1] = port[0];
 
+	printk(KERN_DEBUG "%s: pci_dev class+intf: 0x%x\n",
+		__FUNCTION__, pdev->class);
 	if ((port[0]->host_flags & ATA_FLAG_NO_LEGACY) == 0
 	    && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
+		printk(KERN_DEBUG "%s: NO_LEGACY == 0\n", __FUNCTION__);
+		port[0]->host_flags |= ATA_FLAG_PATA_MODE;
+		port[0]->host_flags &= ATA_FLAG_SATA;
 		/* TODO: What if one channel is in native mode ... */
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
 		mask = (1 << 2) | (1 << 0);
 		if ((tmp8 & mask) != mask)
 			legacy_mode = (1 << 3);
 	}
+	else
+		printk(KERN_DEBUG "%s: NO_LEGACY == 1\n", __FUNCTION__);
 
 	/* FIXME... */
 	if ((!legacy_mode) && (n_ports > 2)) {
--- linux-2616-rc4-ata.orig/include/linux/libata.h
+++ linux-2616-rc4-ata/include/linux/libata.h
@@ -157,11 +157,10 @@ enum {
 					     * proper HSM is in place. */
 	ATA_FLAG_DEBUGMSG	= (1 << 10),
 	ATA_FLAG_NO_ATAPI	= (1 << 11), /* No ATAPI support */
-
 	ATA_FLAG_SUSPENDED	= (1 << 12), /* port is suspended */
-
 	ATA_FLAG_PIO_LBA48	= (1 << 13), /* Host DMA engine is LBA28 only */
 	ATA_FLAG_IRQ_MASK	= (1 << 14), /* Mask IRQ in PIO xfers */
+	ATA_FLAG_PATA_MODE	= (1 << 15), /* port in PATA mode */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -234,6 +233,7 @@ struct scsi_device;
 struct ata_port_operations;
 struct ata_port;
 struct ata_queued_cmd;
+struct GTM_buffer;
 
 /* typedefs */
 typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
@@ -377,6 +377,7 @@ struct ata_port {
 
 	u8			ctl;	/* cache of ATA control register */
 	u8			last_ctl;	/* Cache last written value */
+	u8			legacy_mode;
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
@@ -397,8 +398,13 @@ struct ata_port {
 	struct work_struct	pio_task;
 	unsigned int		hsm_task_state;
 	unsigned long		pio_task_timeout;
+	struct device		*dev;
 
 	u32			msg_enable;
+#ifdef CONFIG_SCSI_SATA_ACPI
+	struct GTM_buffer	*gtm;
+	void			*gtm_object_area;
+#endif
 
 	void			*private_data;
 };
--- linux-2616-rc4-ata.orig/drivers/scsi/libata.h
+++ linux-2616-rc4-ata/drivers/scsi/libata.h
@@ -63,19 +63,20 @@ extern unsigned int ata_exec_internal(st
 /* libata-acpi.c */
 #ifdef CONFIG_SCSI_SATA_ACPI
 extern int ata_acpi_push_id(struct ata_port *ap, unsigned int ix);
-extern int do_drive_get_GTF(struct ata_port *ap, struct ata_device *atadev,
+extern int do_drive_get_GTF(struct ata_port *ap, int ix,
 			unsigned int *gtf_length, unsigned long *gtf_address,
 			unsigned long *obj_loc);
 extern int do_drive_set_taskfiles(struct ata_port *ap, struct ata_device *atadev,
 			unsigned int gtf_length, unsigned long gtf_address);
 extern int ata_acpi_exec_tfs(struct ata_port *ap);
+extern void ata_acpi_get_timing(struct ata_port *ap);
+extern void ata_acpi_push_timing(struct ata_port *ap);
 #else
 static inline int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
 {
 	return 0;
 }
-static inline int do_drive_get_GTF(struct ata_port *ap,
-			struct ata_device *atadev,
+static inline int do_drive_get_GTF(struct ata_port *ap, int ix,
 			unsigned int *gtf_length, unsigned long *gtf_address,
 			unsigned long *obj_loc)
 {
@@ -91,6 +92,12 @@ static inline int ata_acpi_exec_tfs(stru
 {
 	return 0;
 }
+static void ata_acpi_get_timing(struct ata_port *ap)
+{
+}
+static void ata_acpi_push_timing(struct ata_port *ap)
+{
+}
 #endif
 
 
