Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423249AbWANAcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423249AbWANAcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423256AbWANAcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:32:48 -0500
Received: from fmr19.intel.com ([134.134.136.18]:9377 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1423246AbWANAcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:32:46 -0500
Date: Fri, 13 Jan 2006 16:33:48 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>
Subject: [PATCH/RFT] SATA ACPI objects support
Message-Id: <20060113163348.4346ea51.randy_d_dunlap@linux.intel.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I'd appreciate more testing of this SATA ACPI patch.
It applies to 2.6.16-git9.

It's been posted on linux-ide several times (earlier versions),
but it needs more exposure/testing/feedback.

This is the quilt 'combined' patch.  The patch series is also
available at
  http://www.xenotime.net/linux/SATA/2.6.16-git9/

---
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add support for ACPI methods to SATA suspend/resume.
Add calls to ACPI methods for SATA drives.
Use ata_exec_internal().
libata new debugging macro definitions
Add and use 'noacpi' parameter for libata-acpi.
Add and use 'printk' parameter for libata (parts).
Update Documentation/kernel-parameters.txt, including atapi_enabled.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 Documentation/DocBook/libata.tmpl   |    6 
 Documentation/kernel-parameters.txt |   13 
 drivers/scsi/Kconfig                |    5 
 drivers/scsi/Makefile               |    3 
 drivers/scsi/libata-acpi.c          |  586 ++++++++++++++++++++++++++
 drivers/scsi/libata-core.c          |   17 
 drivers/scsi/libata.h               |   38 +
 include/linux/libata.h              |   58 ++
 8 files changed, 718 insertions(+), 8 deletions(-)

--- linux-2615-g9.orig/drivers/scsi/Makefile
+++ linux-2615-g9/drivers/scsi/Makefile
@@ -164,6 +164,9 @@ CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-
 zalon7xx-objs	:= zalon.o ncr53c8xx.o
 NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
 libata-objs	:= libata-core.o libata-scsi.o
+ifeq ($(CONFIG_SCSI_SATA_ACPI),y)
+  libata-objs	+= libata-acpi.o
+endif
 oktagon_esp_mod-objs	:= oktagon_esp.o oktagon_io.o
 
 # Files generated that shall be removed upon make clean
--- linux-2615-g9.orig/drivers/scsi/Kconfig
+++ linux-2615-g9/drivers/scsi/Kconfig
@@ -599,6 +599,11 @@ config SCSI_SATA_INTEL_COMBINED
 	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
 	default y
 
+config SCSI_SATA_ACPI
+	bool
+	depends on SCSI_SATA && ACPI
+	default y
+
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API
--- linux-2615-g9.orig/include/linux/libata.h
+++ linux-2615-g9/include/linux/libata.h
@@ -33,9 +33,11 @@
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
+#include <acpi/acpi.h>
 
 /*
- * compile-time options
+ * compile-time options: to be removed as soon as all the drivers are
+ * converted to the new debugging mechanism
  */
 #undef ATA_DEBUG		/* debugging output */
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
@@ -71,6 +73,38 @@
         }
 #endif
 
+/* NEW: debug levels */
+#define HAVE_LIBATA_MSG 1
+
+enum {
+	ATA_MSG_DRV	= 0x0001,
+	ATA_MSG_INFO	= 0x0002,
+	ATA_MSG_PROBE	= 0x0004,
+	ATA_MSG_WARN	= 0x0008,
+	ATA_MSG_MALLOC	= 0x0010,
+	ATA_MSG_CTL	= 0x0020,
+	ATA_MSG_INTR	= 0x0040,
+	ATA_MSG_ERR	= 0x0080,
+};
+
+#define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
+#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
+#define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
+#define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
+#define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
+#define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
+#define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
+#define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)
+
+static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
+{
+	if (dval < 0 || dval >= (sizeof(u32) * 8))
+		return default_msg_enable_bits; /* should be 0x1 - only driver info msgs */
+	if (!dval)
+		return 0;
+	return (1 << dval) - 1;
+}
+
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
@@ -315,6 +349,11 @@ struct ata_device {
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
 	u16			sectors;	/* Number of sectors per track */
+
+#ifdef CONFIG_SCSI_SATA_ACPI
+	/* ACPI objects info */
+	acpi_handle		obj_handle;
+#endif
 };
 
 struct ata_port {
@@ -356,6 +395,8 @@ struct ata_port {
 	unsigned int		hsm_task_state;
 	unsigned long		pio_task_timeout;
 
+	u32			msg_enable;
+
 	void			*private_data;
 };
 
@@ -640,9 +681,9 @@ static inline u8 ata_wait_idle(struct at
 
 	if (status & (ATA_BUSY | ATA_DRQ)) {
 		unsigned long l = ap->ioaddr.status_addr;
-		printk(KERN_WARNING
-		       "ATA: abnormal status 0x%X on port 0x%lX\n",
-		       status, l);
+		if (ata_msg_warn(ap))
+			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
+				status, l);
 	}
 
 	return status;
@@ -734,7 +775,8 @@ static inline u8 ata_irq_ack(struct ata_
 
 	status = ata_busy_wait(ap, bits, 1000);
 	if (status & bits)
-		DPRINTK("abnormal status 0x%X\n", status);
+		if (ata_msg_err(ap))
+			printk(KERN_ERR "abnormal status 0x%X\n", status);
 
 	/* get controller status; clear intr, err bits */
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -752,8 +794,10 @@ static inline u8 ata_irq_ack(struct ata_
 		post_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	}
 
-	VPRINTK("irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
-		host_stat, post_stat, status);
+	if (ata_msg_intr(ap))
+		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
+			__FUNCTION__,
+			host_stat, post_stat, status);
 
 	return status;
 }
--- linux-2615-g9.orig/Documentation/DocBook/libata.tmpl
+++ linux-2615-g9/Documentation/DocBook/libata.tmpl
@@ -787,6 +787,12 @@ and other resources, etc.
 !Idrivers/scsi/libata-scsi.c
   </chapter>
 
+  <chapter id="libataAcpi">
+     <title>libata ACPI interfaces/methods</title>
+!Edrivers/scsi/ata_acpi.c
+!Idrivers/scsi/ata_acpi.c
+  </chapter>
+
   <chapter id="ataExceptions">
      <title>ATA errors &amp; exceptions</title>
 
--- /dev/null
+++ linux-2615-g9/drivers/scsi/libata-acpi.c
@@ -0,0 +1,586 @@
+/*
+ * libata-acpi.c
+ * Provides ACPI support for PATA/SATA.
+ *
+ * Copyright (C) 2005 Intel Corp.
+ * Copyright (C) 2005 Randy Dunlap
+ */
+
+#include <linux/ata.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <acpi/acpi.h>
+#include "scsi.h"
+#include <linux/libata.h>
+#include <linux/pci.h>
+#include "libata.h"
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acnames.h>
+#include <acpi/acnamesp.h>
+#include <acpi/acparser.h>
+#include <acpi/acexcep.h>
+#include <acpi/acmacros.h>
+#include <acpi/actypes.h>
+
+#define SATA_ROOT_PORT(x)	(((x) >> 16) & 0xffff)
+#define SATA_PORT_NUMBER(x)	((x) & 0xffff)	/* or NO_PORT_MULT */
+#define NO_PORT_MULT		0xffff
+#define SATA_ADR_RSVD		0xffffffff
+
+#define REGS_PER_GTF		7
+struct taskfile_array {
+	u8	tfa[REGS_PER_GTF];	/* regs. 0x1f1 - 0x1f7 */
+};
+
+/**
+ * sata_get_dev_handle - finds acpi_handle and PCI device.function
+ * @dev: device to locate
+ * @handle: returned acpi_handle for @dev
+ * @pcidevfn: return PCI device.func for @dev
+ *
+ * This function is somewhat SATA-specific.  Or at least the
+ * IDE and SCSI versions of this function are different,
+ * so it's not entirely generic code.
+ *
+ * Returns 0 on success, <0 on error.
+ */
+static int sata_get_dev_handle(struct device *dev, acpi_handle *handle,
+					acpi_integer *pcidevfn)
+{
+	struct pci_dev	*pci_dev;
+	acpi_integer	addr;
+
+	pci_dev = to_pci_dev(dev);	/* NOTE: PCI-specific */
+	/* Please refer to the ACPI spec for the syntax of _ADR. */
+	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
+	*pcidevfn = addr;
+	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
+	if (!*handle)
+		return -ENODEV;
+	return 0;
+}
+
+struct walk_info {		/* can be trimmed some */
+	struct device	*dev;
+	struct acpi_device *adev;
+	acpi_handle	handle;
+	acpi_integer	pcidevfn;
+	unsigned int	drivenum;
+	acpi_handle	obj_handle;
+	struct ata_port *ataport;
+	struct ata_device *atadev;
+	u32		sata_adr;
+	int		status;
+	char		basepath[ACPI_PATHNAME_MAX];
+	int		basepath_len;
+};
+
+static acpi_status get_devices(acpi_handle handle,
+				u32 level, void *context, void **return_value)
+{
+	acpi_status		status;
+	struct walk_info	*winfo = context;
+	struct acpi_buffer	namebuf = {ACPI_ALLOCATE_BUFFER, NULL};
+	char			*pathname;
+	struct acpi_buffer	buffer;
+	struct acpi_device_info	*dinfo;
+
+	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &namebuf);
+	if (status)
+		goto ret;
+	pathname = namebuf.pointer;
+
+	buffer.length = ACPI_ALLOCATE_BUFFER;
+	buffer.pointer = NULL;
+	status = acpi_get_object_info(handle, &buffer);
+
+	if (ACPI_SUCCESS(status)) {
+		dinfo = buffer.pointer;
+
+		/* find full device path name for pcidevfn */
+		if (dinfo && (dinfo->valid & ACPI_VALID_ADR) &&
+		    dinfo->address == winfo->pcidevfn) {
+			if (ata_msg_probe(winfo->ataport))
+				printk(KERN_DEBUG
+					":%s: matches pcidevfn (0x%llx)\n",
+					pathname, winfo->pcidevfn);
+			strlcpy(winfo->basepath, pathname,
+				sizeof(winfo->basepath));
+			winfo->basepath_len = strlen(pathname);
+			goto out;
+		}
+
+		/* if basepath is not yet known, ignore this object */
+		if (!winfo->basepath_len)
+			goto out;
+
+		/* if this object is in scope of basepath, maybe use it */
+		if (strncmp(pathname, winfo->basepath,
+		    winfo->basepath_len) == 0) {
+			if (!(dinfo->valid & ACPI_VALID_ADR))
+				goto out;
+			if (ata_msg_probe(winfo->ataport))
+				printk(KERN_DEBUG "GOT ONE: (%s) "
+					"root_port = 0x%llx, port_num = 0x%llx\n",
+					pathname,
+					SATA_ROOT_PORT(dinfo->address),
+					SATA_PORT_NUMBER(dinfo->address));
+			/* heuristics: */
+			if (SATA_PORT_NUMBER(dinfo->address) != NO_PORT_MULT)
+				if (ata_msg_probe(winfo->ataport))
+					printk(KERN_DEBUG
+						"warning: don't know how to handle SATA port multiplier\n");
+			if (SATA_ROOT_PORT(dinfo->address) ==
+				winfo->ataport->port_no &&
+			    SATA_PORT_NUMBER(dinfo->address) == NO_PORT_MULT) {
+				if (ata_msg_probe(winfo->ataport))
+					printk(KERN_DEBUG
+						"THIS ^^^^^ is the requested SATA drive (handle = 0x%p)\n",
+						handle);
+				winfo->sata_adr = dinfo->address;
+				winfo->obj_handle = handle;
+			}
+		}
+out:
+		acpi_os_free(dinfo);
+	}
+	acpi_os_free(pathname);
+
+ret:
+	return status;
+}
+
+/* Get the SATA drive _ADR object. */
+static int get_sata_adr(struct device *dev, acpi_handle handle,
+			acpi_integer pcidevfn, unsigned int drive,
+			struct ata_port *ap,
+			struct ata_device *atadev, u32 *dev_adr)
+{
+	acpi_status	status;
+	struct walk_info *winfo;
+	int		err = -ENOMEM;
+
+	winfo = kzalloc(sizeof(struct walk_info), GFP_KERNEL);
+	if (!winfo)
+		goto out;
+
+	winfo->dev = dev;
+	winfo->atadev = atadev;
+	winfo->ataport = ap;
+	if (acpi_bus_get_device(handle, &winfo->adev) < 0)
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "acpi_bus_get_device failed\n");
+	winfo->handle = handle;
+	winfo->pcidevfn = pcidevfn;
+	winfo->drivenum = drive;
+
+	status = acpi_get_devices(NULL, get_devices, winfo, NULL);
+	if (ACPI_FAILURE(status)) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: acpi_get_devices failed\n",
+				__FUNCTION__);
+		err = -ENODEV;
+	} else {
+		*dev_adr = winfo->sata_adr;
+		atadev->obj_handle = winfo->obj_handle;
+		err = 0;
+	}
+	kfree(winfo);
+out:
+	return err;
+}
+
+/**
+ * ata_acpi_push_id - send Identify data to a drive
+ * @ap: the ata_port for the drive
+ * @ix: drive index
+ *
+ * Must be after Identify (Packet) Device -- uses its data.
+ */
+int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
+{
+	acpi_handle			handle;
+	acpi_integer			pcidevfn;
+	int				err = -ENODEV;
+	struct device			*dev = ap->host_set->dev;
+	struct ata_device		*atadev = &ap->device[ix];
+	u32				dev_adr;
+	acpi_status			status;
+	struct acpi_object_list		input;
+	union acpi_object 		in_params[1];
+
+	if (noacpi)
+		return 0;
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG
+			"%s: ap->id: %d, ix = %d, port#: %d, hard_port#: %d\n",
+			__FUNCTION__, ap->id, ix,
+			ap->port_no, ap->hard_port_no);
+
+	/* Don't continue if not a SATA device. */
+	if (!ata_id_is_sata(atadev->id)) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: ata_id_is_sata is False\n",
+				__FUNCTION__);
+		goto out;
+	}
+
+	/* Don't continue if device has no _ADR method.
+	 * _SDD is intended for known motherboard devices. */
+	err = sata_get_dev_handle(dev, &handle, &pcidevfn);
+	if (err < 0) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG
+				"%s: sata_get_dev_handle failed (%d\n",
+				__FUNCTION__, err);
+		goto out;
+	}
+
+	/* Get this drive's _ADR info. if not already known. */
+	if (!atadev->obj_handle) {
+		dev_adr = SATA_ADR_RSVD;
+		err = get_sata_adr(dev, handle, pcidevfn, ix, ap, atadev,
+				&dev_adr);
+		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
+		    !atadev->obj_handle) {
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG "%s: get_sata_adr failed: "
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
+	in_params[0].buffer.length = sizeof(atadev->id);
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
+			printk(KERN_DEBUG
+				"ata%u(%u): %s _SDD error: status = 0x%x\n",
+				ap->id, ap->device->devno,
+				__FUNCTION__, status);
+	}
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(ata_acpi_push_id);
+
+/**
+ * do_drive_get_GTF - get the drive bootup default taskfile settings
+ * @ap: the ata_port for the drive
+ * @atadev: target ata_device
+ * @gtf_length: number of bytes of _GTF data returned at @gtf_address
+ * @gtf_address: buffer containing _GTF taskfile arrays
+ *
+ * This applies to both PATA and SATA drives.
+ *
+ * The _GTF method has no input parameters.
+ * It returns a variable number of register set values (registers
+ * hex 1F1..1F7, taskfiles).
+ * The <variable number> is not known in advance, so have ACPI-CA
+ * allocate the buffer as needed and return it, then free it later.
+ *
+ * The returned @gtf_length and @gtf_address are only valid if the
+ * function return value is 0.
+ */
+int do_drive_get_GTF(struct ata_port *ap, struct ata_device *atadev,
+			unsigned int *gtf_length, unsigned long *gtf_address)
+{
+	acpi_status			status;
+	acpi_handle			handle;
+	acpi_integer			pcidevfn;
+	u32				dev_adr;
+	struct acpi_buffer		output;
+	union acpi_object 		*out_obj;
+	struct device			*dev = ap->host_set->dev;
+	int				err = -ENODEV;
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG
+			"%s: ENTER: ap->id: %d, port#: %d, hard_port#: %d\n",
+			__FUNCTION__, ap->id,
+		ap->port_no, ap->hard_port_no);
+
+	*gtf_length = 0;
+	*gtf_address = 0UL;
+
+	if (noacpi)
+		return 0;
+
+	if (!ata_dev_present(atadev) ||
+	    (ap->flags & ATA_FLAG_PORT_DISABLED)) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: ERR: "
+				"ata_dev_present: %d, PORT_DISABLED: %lu\n",
+				__FUNCTION__, ata_dev_present(atadev),
+				ap->flags & ATA_FLAG_PORT_DISABLED);
+		goto out;
+	}
+
+	/* Don't continue if device has no _ADR method.
+	 * _GTF is intended for known motherboard devices. */
+	err = sata_get_dev_handle(dev, &handle, &pcidevfn);
+	if (err < 0) {
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG
+				"%s: sata_get_dev_handle failed (%d\n",
+				__FUNCTION__, err);
+		goto out;
+	}
+
+	/* Get this drive's _ADR info. if not already known. */
+	if (!atadev->obj_handle) {
+		dev_adr = SATA_ADR_RSVD;
+		err = get_sata_adr(dev, handle, pcidevfn, 0, ap, atadev,
+				&dev_adr);
+		if (err < 0 || dev_adr == SATA_ADR_RSVD ||
+		    !atadev->obj_handle) {
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG "%s: get_sata_adr failed: "
+					"err=%d, dev_adr=%u, obj_handle=0x%p\n",
+					__FUNCTION__, err, dev_adr,
+					atadev->obj_handle);
+			goto out;
+		}
+	}
+
+	/* Setting up output buffer */
+	output.length = ACPI_ALLOCATE_BUFFER;
+	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
+
+	/* _GTF has no input parameters */
+	err = -EIO;
+	status = acpi_evaluate_object(atadev->obj_handle, "_GTF",
+					NULL, &output);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_DEBUG
+			"%s: Run _GTF error: status = 0x%x\n",
+			__FUNCTION__, status);
+		goto out;
+	}
+
+	if (!output.length || !output.pointer) {
+		printk(KERN_DEBUG
+			"%s: Run _GTF: length or ptr is NULL (0x%llx, 0x%p)\n",
+			__FUNCTION__,
+			(unsigned long long)output.length, output.pointer);
+		acpi_os_free(output.pointer);
+		goto out;
+	}
+
+	out_obj = output.pointer;
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
+		acpi_os_free(output.pointer);
+		printk(KERN_DEBUG "%s: Run _GTF: error: "
+			"expected object type of ACPI_TYPE_BUFFER, got 0x%x\n",
+			__FUNCTION__, out_obj->type);
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (out_obj->buffer.length % REGS_PER_GTF) {
+		if (ata_msg_drv(ap))
+			printk(KERN_ERR "%s: unexpected GTF length (%d)\n",
+				__FUNCTION__, out_obj->buffer.length);
+		err = -ENOENT;
+		goto out;
+	}
+
+	*gtf_length = out_obj->buffer.length;
+	*gtf_address = (unsigned long)out_obj->buffer.pointer;
+	err = 0;
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(do_drive_get_GTF);
+
+/**
+ * taskfile_load_raw - send taskfile registers to host controller
+ * @ap: Port to which output is sent
+ * @gtf: raw ATA taskfile register set (0x1f1 - 0x1f7)
+ *
+ * Outputs ATA taskfile to standard ATA host controller using MMIO
+ * or PIO as indicated by the ATA_FLAG_MMIO flag.
+ * Writes the control, feature, nsect, lbal, lbam, and lbah registers.
+ * Optionally (ATA_TFLAG_LBA48) writes hob_feature, hob_nsect,
+ * hob_lbal, hob_lbam, and hob_lbah.
+ *
+ * This function waits for idle (!BUSY and !DRQ) after writing
+ * registers.  If the control register has a new value, this
+ * function also waits for idle after writing control and before
+ * writing the remaining registers.
+ *
+ * LOCKING: TBD:
+ * Inherited from caller.
+ */
+static void taskfile_load_raw(struct ata_port *ap,
+				struct ata_device *atadev,
+				const struct taskfile_array *gtf)
+{
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: (0x1f1-1f7): hex: "
+			"%02x %02x %02x %02x %02x %02x %02x\n",
+			__FUNCTION__,
+			gtf->tfa[0], gtf->tfa[1], gtf->tfa[2],
+			gtf->tfa[3], gtf->tfa[4], gtf->tfa[5], gtf->tfa[6]);
+
+	if (ap->ops->qc_issue) {
+		struct ata_taskfile tf;
+		unsigned int err;
+
+		ata_tf_init(ap, &tf, atadev->devno);
+
+		/* convert gtf to tf */
+		tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE; /* TBD */
+		tf.protocol = atadev->class == ATA_DEV_ATAPI ?
+			ATA_PROT_ATAPI_NODATA : ATA_PROT_NODATA;
+		tf.feature = gtf->tfa[0];	/* 0x1f1 */
+		tf.nsect   = gtf->tfa[1];	/* 0x1f2 */
+		tf.lbal    = gtf->tfa[2];	/* 0x1f3 */
+		tf.lbam    = gtf->tfa[3];	/* 0x1f4 */
+		tf.lbah    = gtf->tfa[4];	/* 0x1f5 */
+		tf.device  = gtf->tfa[5];	/* 0x1f6 */
+		tf.command = gtf->tfa[6];	/* 0x1f7 */
+
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "call ata_exec_internal:\n");
+		err = ata_exec_internal(ap, atadev, &tf, DMA_NONE, NULL, 0);
+		if (err && ata_msg_probe(ap))
+			printk(KERN_ERR "%s: ata_exec_internal failed: %u\n",
+				__FUNCTION__, err);
+	} else
+		if (ata_msg_warn(ap))
+			printk(KERN_WARNING
+				"%s: SATA driver is missing qc_issue function entry points\n",
+				__FUNCTION__);
+}
+
+/**
+ * do_drive_set_taskfiles - write the drive taskfile settings from _GTF
+ * @ap: the ata_port for the drive
+ * @atadev: target ata_device
+ * @gtf_length: total number of bytes of _GTF taskfiles
+ * @gtf_address: location of _GTF taskfile arrays
+ *
+ * This applies to both PATA and SATA drives.
+ *
+ * Write {gtf_address, length gtf_length} in groups of
+ * REGS_PER_GTF bytes.
+ */
+int do_drive_set_taskfiles(struct ata_port *ap, struct ata_device *atadev,
+			unsigned int gtf_length, unsigned long gtf_address)
+{
+	int			err = -ENODEV;
+	int			gtf_count = gtf_length / REGS_PER_GTF;
+	int			ix;
+	struct taskfile_array	*gtf;
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG
+			"%s: ENTER: ap->id: %d, port#: %d, hard_port#: %d\n",
+			__FUNCTION__, ap->id,
+			ap->port_no, ap->hard_port_no);
+
+	if (noacpi)
+		return 0;
+
+	if (!ata_dev_present(atadev) ||
+	    (ap->flags & ATA_FLAG_PORT_DISABLED))
+		goto out;
+	if (!gtf_count)		/* shouldn't be here */
+		goto out;
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG
+			"%s: total GTF bytes = %u (0x%x), gtf_count = %d\n",
+			__FUNCTION__, gtf_length, gtf_length, gtf_count);
+	if (gtf_length % REGS_PER_GTF) {
+		if (ata_msg_drv(ap))
+			printk(KERN_ERR "%s: unexpected GTF length (%d)\n",
+				__FUNCTION__, gtf_length);
+		goto out;
+	}
+
+	for (ix = 0; ix < gtf_count; ix++) {
+		gtf = (struct taskfile_array *)
+			(gtf_address + ix * REGS_PER_GTF);
+
+		/* send all TaskFile registers (0x1f1-0x1f7) *in*that*order* */
+		taskfile_load_raw(ap, atadev, gtf);
+	}
+
+	err = 0;
+out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(do_drive_set_taskfiles);
+
+/**
+ * ata_acpi_exec_tfs - get then write drive taskfile settings
+ * @ap: the ata_port for the drive
+ *
+ * This applies to both PATA and SATA drives.
+ */
+int ata_acpi_exec_tfs(struct ata_port *ap)
+{
+	int ix;
+	int ret;
+	unsigned int gtf_length;
+	unsigned long gtf_address;
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
+
+	if (noacpi)
+		return 0;
+
+	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
+		printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",
+			__FUNCTION__, ix);
+		ret = do_drive_get_GTF(ap, &ap->device[ix],
+				&gtf_length, &gtf_address);
+		if (ret < 0) {
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG "%s: get_GTF error (%d)\n",
+					__FUNCTION__, ret);
+			break;
+		}
+
+		printk(KERN_DEBUG "%s: call set_taskfiles, ix=%d\n",
+			__FUNCTION__, ix);
+		ret = do_drive_set_taskfiles(ap, &ap->device[ix],
+				gtf_length, gtf_address);
+		acpi_os_free((void *)gtf_address);
+		if (ret < 0) {
+			if (ata_msg_probe(ap))
+				printk(KERN_DEBUG
+					"%s: set_taskfiles error (%d)\n",
+					__FUNCTION__, ret);
+			break;
+		}
+	}
+
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: ret=%d\n", __FUNCTION__, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ata_acpi_exec_tfs);
--- linux-2615-g9.orig/drivers/scsi/libata-core.c
+++ linux-2615-g9/drivers/scsi/libata-core.c
@@ -82,6 +82,14 @@ int atapi_enabled = 0;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
 
+int noacpi = 0;
+module_param(noacpi, int, 0444);
+MODULE_PARM_DESC(noacpi, "Disables use of ACPI in suspend/resume when set");
+
+int libata_printk = ATA_MSG_DRV;
+module_param_named(printk, libata_printk, int, 0644);
+MODULE_PARM_DESC(printk, "Set libata printk flags"); /* in linux/libata.h */
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -1104,7 +1112,7 @@ int ata_qc_complete_internal(struct ata_
  *	None.  Should be called with kernel context, might sleep.
  */
 
-static unsigned
+unsigned int
 ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
 		  struct ata_taskfile *tf,
 		  int dma_dir, void *buf, unsigned int buflen)
@@ -1420,6 +1428,8 @@ void ata_dev_config(struct ata_port *ap,
 
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(ap, &ap->device[i]);
+
+	ata_acpi_push_id(ap, i);
 }
 
 /**
@@ -1460,6 +1470,8 @@ static int ata_bus_probe(struct ata_port
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		goto err_out_disable;
 
+	ata_acpi_exec_tfs(ap);
+
 	return 0;
 
 err_out_disable:
@@ -4238,6 +4250,7 @@ int ata_device_resume(struct ata_port *a
 	}
 	if (!ata_dev_present(dev))
 		return 0;
+	ata_acpi_exec_tfs(ap);
 	if (dev->class == ATA_DEV_ATA)
 		ata_start_drive(ap, dev);
 
@@ -4487,6 +4500,8 @@ int ata_device_add(const struct ata_prob
 				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
 				(ap->pio_mask << ATA_SHIFT_PIO);
 
+		ap->msg_enable = libata_printk;
+
 		/* print per-port info to dmesg */
 		printk(KERN_INFO "ata%u: %cATA max %s cmd 0x%lX ctl 0x%lX "
 				 "bmdma 0x%lX irq %lu\n",
--- linux-2615-g9.orig/drivers/scsi/libata.h
+++ linux-2615-g9/drivers/scsi/libata.h
@@ -41,6 +41,8 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
+extern int noacpi;
+extern int libata_printk;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
@@ -52,6 +54,42 @@ extern void ata_dev_select(struct ata_po
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
+extern unsigned int ata_exec_internal(struct ata_port *ap,
+				struct ata_device *dev,
+				struct ata_taskfile *tf,
+				int dma_dir, void *buf, unsigned int buflen);
+
+
+/* libata-acpi.c */
+#ifdef CONFIG_SCSI_SATA_ACPI
+extern int ata_acpi_push_id(struct ata_port *ap, unsigned int ix);
+extern int do_drive_get_GTF(struct ata_port *ap, struct ata_device *atadev,
+			unsigned int *gtf_length, unsigned long *gtf_address);
+extern int do_drive_set_taskfiles(struct ata_port *ap, struct ata_device *atadev,
+			unsigned int gtf_length, unsigned long gtf_address);
+extern int ata_acpi_exec_tfs(struct ata_port *ap);
+#else
+static inline int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
+{
+	return 0;
+}
+static inline int do_drive_get_GTF(struct ata_port *ap,
+			struct ata_device *atadev,
+			unsigned int *gtf_length, unsigned long *gtf_address)
+{
+	return 0;
+}
+static inline int do_drive_set_taskfiles(struct ata_port *ap,
+			struct ata_device *atadev,
+			unsigned int gtf_length, unsigned long gtf_address)
+{
+	return 0;
+}
+static inline int ata_acpi_exec_tfs(struct ata_port *ap)
+{
+	return 0;
+}
+#endif
 
 
 /* libata-scsi.c */
--- linux-2615-g9.orig/Documentation/kernel-parameters.txt
+++ linux-2615-g9/Documentation/kernel-parameters.txt
@@ -41,6 +41,7 @@ restrictions referred to are that the re
 	ISAPNP	ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
 	JOY	Appropriate joystick support is enabled.
+	LIBATA	libata driver is enabled.
 	LP	Printer support is enabled.
 	LOOP	Loopback device support is enabled.
 	M68k	M68k architecture is enabled.
@@ -242,6 +243,9 @@ running once the system is up.
 
 	ataflop=	[HW,M68k]
 
+	atapi_enabled=	[LIBATA] Enable discovery & support of ATAPI devices
+			Format: <value> (0=off, 1=on)
+
 	atarimouse=	[HW,MOUSE] Atari Mouse
 
 	atascsi=	[HW,SCSI] Atari SCSI
@@ -968,6 +972,10 @@ running once the system is up.
 			emulation library even if a 387 maths coprocessor
 			is present.
 
+	noacpi=		[LIBATA] Disables use of ACPI in libata suspend/resume
+			when set.
+			Format: <int>
+
 	noalign		[KNL,ARM]
 
 	noapic		[SMP,APIC] Tells the kernel to not make use of any
@@ -1212,6 +1220,11 @@ running once the system is up.
 			autoconfiguration.
 			Ranges are in pairs (memory base and size).
 
+	printk=		[LIBATA] Set libata printk level (mask).
+			The values are defined in include/linux/libata.h.
+			The default value is 1 (ATA_MSG_DRV).
+			Format: <int>
+
 	profile=	[KNL] Enable kernel profiling via /proc/profile
 			Format: [schedule,]<number>
 			Param: "schedule" - profile schedule points.
