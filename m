Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWDYAya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWDYAya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 20:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWDYAy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 20:54:29 -0400
Received: from mx21.sac.fedex.com ([199.81.218.126]:2508 "EHLO
	mx21.sac.fedex.com") by vger.kernel.org with ESMTP id S1751280AbWDYAy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 20:54:28 -0400
Date: Tue, 25 Apr 2006 08:54:21 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Mark Lord <lkml@rtr.ca>
cc: Jeff Chua <jeff.chua.linux@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       Chris Ball <cjb@mrao.cam.ac.uk>, Pavel Machek <pavel@suse.cz>,
       Arkadiusz Miskiewicz <arekm@maven.pl>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       randy_d_dunlap@linux.intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, ncunningham@linuxmail.org
Subject: Re: sata suspend resume ... (fwd)
In-Reply-To: <444C2821.5090409@rtr.ca>
Message-ID: <Pine.LNX.4.64.0604250810370.5533@boston.corp.fedex.com>
References: <Pine.LNX.4.64.0604232153230.2890@boston.corp.fedex.com>
 <444C2821.5090409@rtr.ca>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/25/2006
 08:54:17 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/25/2006
 08:54:21 AM,
	Serialize complete at 04/25/2006 08:54:21 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Apr 2006, Mark Lord wrote:

> Try Randy Dunlop's libata-acpi patches -- I've been using variants of them
> for a *very long time* here now, as they're the only thing that works for me.

This the one that makes does it!!! I've tried just about all patches 
including the famous "mdelay(2000);" but none worked. ... perhaps it's 
just something to do with IBM X60s which is dual-core.

Here's what I did to make it work...

Linux is vanilla linux-2.6.17-rc2.

Pavel suggested the right step as I was going no where with SMP suspend. 
Switching to UP and using "suspend2" (CONFIG_SUSPEND2) didn't work either 
with PIIX or AHCI. Patch is suspend2-2.2.5-for-2.6.17-rc2.tar.bz2

Then I tried "suspend" (CONFIG_SOFTWARE_SUSPEND) with both PIIX and 
AHIC in UP mode ... still didn't work.

Next, I applied libata-acpi.patch with a little modification. No sure 
what the implication is but the original patch seems to use "i" outside 
the loop. Here's what I added to libata-acpi.patch ... can someone verify 
this or do we need this at all?

+
+       for (i = 0; i < ATA_MAX_DEVICES; i++)
+               ata_acpi_push_id(ap, i);

Tried both PIIX and AHCI in UP mode. Failed with AHCI, but worked in 
"suspend to disk" in PIIX mode (configured in BIOS under SATA -> 
"COMPATIBILITY").

Here's the trick. Next I switched to SMP mode ... reconfigured with 
CONFIG_SMP. CONFIG_SOFTWARE_SUSPEND disappeared. Here's the credit ... I 
took a look at how suspend2 tried to suspend under SMP ... first switch to 
UP and then do the suspension. Taking a look at the dependency ...

 	SOFTWARE_SUSPEND depends on SUSPEND_SMP
 	CONFIG_SUSPEND_SMP depends on HOTPLUG_CPU
 	CONFIG_HOTPLUG_CPU depends on !X86_PC

It's not possible to suspend on SMP. First I tried to force SUSPEND_SMP, 
and it suspended ok, but when resumed, kernel oops under SMP.

So, here's the patch to enable HOTPLUG_CPU for X86. I'll send this patch 
in a separate email.


--- ./arch/i386/Kconfig.org	2006-04-25 00:57:23 +0800
+++ ./arch/i386/Kconfig	2006-04-25 00:58:31 +0800
@@ -756,7 +756,7 @@

  config HOTPLUG_CPU
  	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER && !X86_PC
+	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
  	---help---
  	  Say Y here to experiment with turning CPUs off and on.  CPUs
  	  can be controlled through /sys/devices/system/cpu.


With this patch and the modified libata-acpi.patch patch, first go into UP 
mode ...

 	echo 0 > /sys/devices/system/cpu/cpu1/online

Then try suspend ...

 	echo shutdown > /sys/power/disk; echo disk > /sys/power/state


This works!!!

Thank you all for the all the great ideas. I don't know how many hundred 
times I has to reboot my new X60s for the past few days. But it's worth 
it.


Thank you,
Jeff.




Here's the modified libata-acpi.patch ...

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add support for ACPI methods to SATA suspend/resume.
Add calls to ACPI methods for SATA drives.
Use ata_exec_internal().

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
  drivers/scsi/libata-acpi.c |  574 +++++++++++++++++++++++++++++++++++++++++++++
  drivers/scsi/libata-core.c |    7
  drivers/scsi/libata.h      |   36 ++
  3 files changed, 616 insertions(+), 1 deletion(-)

--- /dev/null
+++ linux-2616-rc3-ata/drivers/scsi/libata-acpi.c
@@ -0,0 +1,574 @@
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
--- linux-2616-rc3-ata.orig/drivers/scsi/libata-core.c
+++ linux-2616-rc3-ata/drivers/scsi/libata-core.c
@@ -1112,7 +1112,7 @@ int ata_qc_complete_internal(struct ata_
   *	None.  Should be called with kernel context, might sleep.
   */

-static unsigned
+unsigned int
  ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
  		  struct ata_taskfile *tf,
  		  int dma_dir, void *buf, unsigned int buflen)
@@ -1461,4 +1461,7 @@ void ata_dev_config(struct ata_port *ap,
  	if (ap->ops->dev_config)
  		ap->ops->dev_config(ap, dev);
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		ata_acpi_push_id(ap, i);
  	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
  	return 0;
@@ -1501,6 +1503,8 @@ static int ata_bus_probe(struct ata_port
  	if (ap->flags & ATA_FLAG_PORT_DISABLED)
  		goto err_out_disable;

+	ata_acpi_exec_tfs(ap);
+
  	return 0;

  err_out_disable:
@@ -4290,6 +4294,7 @@ int ata_device_resume(struct ata_port *a
  	}
  	if (!ata_dev_present(dev))
  		return 0;
+	ata_acpi_exec_tfs(ap);
  	if (dev->class == ATA_DEV_ATA)
  		ata_start_drive(ap, dev);

--- linux-2616-rc3-ata.orig/drivers/scsi/libata.h
+++ linux-2616-rc3-ata/drivers/scsi/libata.h
@@ -52,6 +52,42 @@ extern void ata_dev_select(struct ata_po
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
