Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVALSyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVALSyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVALSyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:54:19 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:26035 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261236AbVALSp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:45:28 -0500
Date: Wed, 12 Jan 2005 12:45:23 -0600 (CST)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, sailer@watson.ibm.com, leendert@watson.ibm.com,
       emilyr@us.ibm.com, toml@us.ibm.com, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement --updated version
In-Reply-To: <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com>
 <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a device driver to enable new hardware.  The new hardware is
the TPM chip as described by specifications at 
<http://www.trustedcomputinggroup.org>.  The TPM chip will enable you to
use hardware to securely store and protect your keys and personal data.
To use the chip according to the specification, you will need the Trusted
Software Stack (TSS) of which an implementation for Linux is available at:
<http://sourceforge.net/projects/trousers>.
  
> > > > > Updates include: splitting out the vendor specific code into separated
> > > > > drivers from the base TPM functionality, fixed busy waiting loops,
> > > > > concerns about timer handling and rmmod, buffer name.
> > > 
> > > > Updates include a consolodated buffer mutex, numerous naming improvements,
> > > > better placement of pci_driver and file_operations structure
> > > > initializations, change to use of EXPORT_SYMBOL_GPL, improvement of
> > > > Kconfig help texts and creation of a tpm directory
> > > 
> > > Updates include moving the pci_ids table into the individual vendor
> > > specific .c files and including a tpm description file in the
> > > Documentation directory.
> 
> > All of these calls to schedule_timeout() are broken. You must set the
> > state appropriately before calling schedule_timeout() or it will
> > return immediately. For your reference here is the difference between
> > the two states with respects to calling schedule_timeout() directly:
> Fixed in the patch below.

Updates include fixing an uninitialized mutex and the addition of sysfs 
files for retrieving important device information.  Patch generated 
against 2.6.10. 

Thanks,
Kylene
 
Signed-off-by: Leendert van Doorn <leendert@watson.ibm.com>
Signed-off-by: Reiner Sailer <sailer@watson.ibm.com>
Signed-off-by: Dave Safford <safford@watson.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.10/drivers/char/Kconfig linux-2.6.10-tpm/drivers/char/Kconfig
--- linux-2.6.10/drivers/char/Kconfig	2004-12-24 15:33:49.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/Kconfig	2005-01-07 13:23:08.000000000 -0600
@@ -1007,5 +1007,7 @@ config MMTIMER
 	  The mmtimer device allows direct userspace access to the
 	  Altix system timer.
 
+source "drivers/char/tpm/Kconfig"
+
 endmenu
 
diff -uprN linux-2.6.10/drivers/char/Makefile linux-2.6.10-tpm/drivers/char/Makefile
--- linux-2.6.10/drivers/char/Makefile	2004-12-24 15:35:29.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/Makefile	2005-01-07 13:20:43.000000000 -0600
@@ -90,7 +90,7 @@ obj-$(CONFIG_PCMCIA) += pcmcia/
 obj-$(CONFIG_IPMI_HANDLER) += ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
-
+obj-$(CONFIG_TCG_TPM) += tpm/
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
 
diff -uprN linux-2.6.10/drivers/char/tpm/Kconfig linux-2.6.10-tpm/drivers/char/tpm/Kconfig
--- linux-2.6.10/drivers/char/tpm/Kconfig	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/Kconfig	2004-12-20 11:06:10.000000000 -0600
@@ -0,0 +1,39 @@
+#
+# TPM device configuration
+#
+
+menu "TPM devices"
+
+config TCG_TPM
+	tristate "TPM Hardware Support"
+	depends on EXPERIMENTAL
+	---help---
+	  If you have a TPM security chip in your system, which
+	  implements the Trusted Computing Group's specification,
+	  say Yes and it will be accessible from within Linux.  For
+	  more information see <http://www.trustedcomputinggroup.org>. 
+	  An implementation of the Trusted Software Stack (TSS), the 
+	  userspace enablement piece of the specification, can be 
+	  obtained at: <http://sourceforge.net/projects/trousers>.  To 
+	  compile this driver as a module, choose M here; the module 
+	  will be called tpm. If unsure, say N.
+
+config TCG_NSC
+	tristate "National Semiconductor TPM Interface"
+	depends on TCG_TPM
+	---help---
+	  If you have a TPM security chip from National Semicondutor 
+	  say Yes and it will be accessible from within Linux.  To 
+	  compile this driver as a module, choose M here; the module 
+	  will be called tpm_nsc.
+
+config TCG_ATMEL
+	tristate "Atmel TPM Interface"
+	depends on TCG_TPM
+	---help---
+	  If you have a TPM security chip from Atmel say Yes and it 
+	  will be accessible from within Linux.  To compile this driver 
+	  as a module, choose M here; the module will be called tpm_atmel.
+
+endmenu
+
diff -uprN linux-2.6.10/drivers/char/tpm/Makefile linux-2.6.10-tpm/drivers/char/tpm/Makefile
--- linux-2.6.10/drivers/char/tpm/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/Makefile	2004-12-20 11:06:10.000000000 -0600
@@ -0,0 +1,7 @@
+#
+# Makefile for the kernel tpm device drivers.
+#
+obj-$(CONFIG_TCG_TPM) += tpm.o
+obj-$(CONFIG_TCG_NSC) += tpm_nsc.o
+obj-$(CONFIG_TCG_ATMEL) += tpm_atmel.o
+
diff -uprN linux-2.6.10/drivers/char/tpm/tpm_atmel.c linux-2.6.10-tpm/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.10/drivers/char/tpm/tpm_atmel.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm_atmel.c	2004-12-21 12:33:08.000000000 -0600
@@ -0,0 +1,216 @@
+/*
+ * Copyright (C) 2004 IBM Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Dave Safford <safford@watson.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: <tpmdd_devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org	 
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ * 
+ */
+
+#include "tpm.h"
+
+/* Atmel definitions */
+#define	TPM_ATML_BASE			0x400
+
+/* write status bits */
+#define	ATML_STATUS_ABORT		0x01
+#define	ATML_STATUS_LASTBYTE		0x04
+
+/* read status bits */
+#define	ATML_STATUS_BUSY		0x01
+#define	ATML_STATUS_DATA_AVAIL		0x02
+#define	ATML_STATUS_REWRITE		0x04
+
+
+static int tpm_atml_recv(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	u8 status, *hdr = buf;
+	u32 size;
+	int i;
+	__be32 *native_size;
+
+	/* start reading header */
+	if (count < 6)
+		return -EIO;
+
+	for (i = 0; i < 6; i++) {
+		status = inb(chip->vendor->base + 1);
+		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
+			dev_err(&chip->pci_dev->dev,
+				"error reading header\n");
+			return -EIO;
+		}
+		*buf++ = inb(chip->vendor->base);
+	}
+
+	/* size of the data received */
+	native_size = (__force __be32 *) (hdr + 2);
+	size = be32_to_cpu(*native_size);
+
+	if (count < size) {
+		dev_err(&chip->pci_dev->dev,
+			"Recv size(%d) less than available space\n", size);
+		for (; i < size; i++) {	/* clear the waiting data anyway */
+			status = inb(chip->vendor->base + 1);
+			if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
+				dev_err(&chip->pci_dev->dev,
+					"error reading data\n");
+				return -EIO;
+			}
+		}
+		return -EIO;
+	}
+
+	/* read all the data available */
+	for (; i < size; i++) {
+		status = inb(chip->vendor->base + 1);
+		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
+			dev_err(&chip->pci_dev->dev,
+				"error reading data\n");
+			return -EIO;
+		}
+		*buf++ = inb(chip->vendor->base);
+	}
+
+	/* make sure data available is gone */
+	status = inb(chip->vendor->base + 1);
+	if (status & ATML_STATUS_DATA_AVAIL) {
+		dev_err(&chip->pci_dev->dev, "data available is stuck\n");
+		return -EIO;
+	}
+
+	return size;
+}
+
+static int tpm_atml_send(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	int i;
+
+	dev_dbg(&chip->pci_dev->dev, "tpm_atml_send: ");
+	for (i = 0; i < count; i++) {
+		dev_dbg(&chip->pci_dev->dev, "0x%x(%d) ", buf[i], buf[i]);
+		outb(buf[i], chip->vendor->base);
+	}
+
+	return count;
+}
+
+static void tpm_atml_cancel(struct tpm_chip *chip)
+{
+	outb(ATML_STATUS_ABORT, chip->vendor->base + 1);
+}
+
+static struct file_operations atmel_ops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.open = tpm_open,
+	.read = tpm_read,
+	.write = tpm_write,
+	.release = tpm_release,
+};
+
+static struct tpm_vendor_specific tpm_atmel = {
+	.recv = tpm_atml_recv,
+	.send = tpm_atml_send,
+	.cancel = tpm_atml_cancel,
+	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
+	.req_complete_val = ATML_STATUS_DATA_AVAIL,
+	.base = TPM_ATML_BASE,
+	.miscdev.fops = &atmel_ops,
+};
+
+static int __devinit tpm_atml_init(struct pci_dev *pci_dev,
+				   const struct pci_device_id *pci_id)
+{
+	u8 version[4];
+	int rc = 0;
+
+	if (pci_enable_device(pci_dev))
+		return -EIO;
+
+	if (tpm_lpc_bus_init(pci_dev, TPM_ATML_BASE)) {
+		rc = -ENODEV;
+		goto out_err;
+	}
+
+	/* verify that it is an Atmel part */
+	if (tpm_read_index(4) != 'A' || tpm_read_index(5) != 'T'
+	    || tpm_read_index(6) != 'M' || tpm_read_index(7) != 'L') {
+		rc = -ENODEV;
+		goto out_err;
+	}
+
+	/* query chip for its version number */
+	if ((version[0] = tpm_read_index(0x00)) != 0xFF) {
+		version[1] = tpm_read_index(0x01);
+		version[2] = tpm_read_index(0x02);
+		version[3] = tpm_read_index(0x03);
+	} else {
+		dev_info(&pci_dev->dev, "version query failed\n");
+		rc = -ENODEV;
+		goto out_err;
+	}
+
+	if ((rc = tpm_register_hardware(pci_dev, &tpm_atmel)) < 0)
+		goto out_err;
+
+	dev_info(&pci_dev->dev,
+		 "Atmel TPM version %d.%d.%d.%d\n", version[0], version[1],
+		 version[2], version[3]);
+
+	return 0;
+out_err:
+	pci_disable_device(pci_dev);
+	return rc;
+}
+
+static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);
+
+static struct pci_driver atmel_pci_driver = {
+	.name = "tpm_atmel",
+	.id_table = tpm_pci_tbl,
+	.probe = tpm_atml_init,
+	.remove = __devexit_p(tpm_remove),
+	.suspend = tpm_pm_suspend,
+	.resume = tpm_pm_resume,
+};
+
+static int __init init_atmel(void)
+{
+	return pci_register_driver(&atmel_pci_driver);
+}
+
+static void __exit cleanup_atmel(void)
+{
+	pci_unregister_driver(&atmel_pci_driver);
+}
+
+module_init(init_atmel);
+module_exit(cleanup_atmel);
+
+MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
+MODULE_DESCRIPTION("TPM Driver");
+MODULE_VERSION("2.0");
+MODULE_LICENSE("GPL");
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.c linux-2.6.10-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.10/drivers/char/tpm/tpm.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.c	2005-01-12 12:52:56.000000000 -0600
@@ -0,0 +1,697 @@
+/*
+ * Copyright (C) 2004 IBM Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Dave Safford <safford@watson.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: <tpmdd_devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org	 
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ * 
+ * Note, the TPM chip is not interrupt driven (only polling)
+ * and can have very long timeouts (minutes!). Hence the unusual
+ * calls to schedule_timeout.
+ *
+ */
+
+#include <linux/sched.h>
+#include <linux/poll.h>
+#include <linux/spinlock.h>
+#include "tpm.h"
+
+#define	TPM_MINOR			224	/* officially assigned */
+
+#define	TPM_BUFSIZE			2048
+
+/* PCI configuration addresses */
+#define	PCI_GEN_PMCON_1			0xA0
+#define	PCI_GEN1_DEC			0xE4
+#define	PCI_LPC_EN			0xE6
+#define	PCI_GEN2_DEC			0xEC
+
+static LIST_HEAD(tpm_chip_list);
+static spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
+static int dev_mask[32];
+
+static void user_reader_timeout(unsigned long ptr)
+{
+	struct tpm_chip *chip = (struct tpm_chip *) ptr;
+
+	down(&chip->buffer_mutex);
+	atomic_set(&chip->data_pending, 0);
+	memset(chip->data_buffer, 0, TPM_BUFSIZE);
+	up(&chip->buffer_mutex);
+}
+
+void tpm_time_expired(unsigned long ptr)
+{
+	int *exp = (int *) ptr;
+	*exp = 1;
+}
+
+EXPORT_SYMBOL_GPL(tpm_time_expired);
+
+/*
+ * Initialize the LPC bus and enable the TPM ports
+ */
+int tpm_lpc_bus_init(struct pci_dev *pci_dev, u16 base)
+{
+	u32 lpcenable, tmp;
+	int is_lpcm = 0;
+
+	switch (pci_dev->vendor) {
+	case PCI_VENDOR_ID_INTEL:
+		switch (pci_dev->device) {
+		case PCI_DEVICE_ID_INTEL_82801CA_12:
+		case PCI_DEVICE_ID_INTEL_82801DB_12:
+			is_lpcm = 1;
+			break;
+		}
+		/* init ICH (enable LPC) */
+		pci_read_config_dword(pci_dev, PCI_GEN1_DEC, &lpcenable);
+		lpcenable |= 0x20000000;
+		pci_write_config_dword(pci_dev, PCI_GEN1_DEC, lpcenable);
+
+		if (is_lpcm) {
+			pci_read_config_dword(pci_dev, PCI_GEN1_DEC,
+					      &lpcenable);
+			if ((lpcenable & 0x20000000) == 0) {
+				dev_err(&pci_dev->dev,
+					"cannot enable LPC\n");
+				return -ENODEV;
+			}
+		}
+
+		/* initialize TPM registers */
+		pci_read_config_dword(pci_dev, PCI_GEN2_DEC, &tmp);
+
+		if (!is_lpcm)
+			tmp = (tmp & 0xFFFF0000) | (base & 0xFFF0);
+		else
+			tmp =
+			    (tmp & 0xFFFF0000) | (base & 0xFFF0) |
+			    0x00000001;
+
+		pci_write_config_dword(pci_dev, PCI_GEN2_DEC, tmp);
+
+		if (is_lpcm) {
+			pci_read_config_dword(pci_dev, PCI_GEN_PMCON_1,
+					      &tmp);
+			tmp |= 0x00000004;	/* enable CLKRUN */
+			pci_write_config_dword(pci_dev, PCI_GEN_PMCON_1,
+					       tmp);
+		}
+		tpm_write_index(0x0D, 0x55);	/* unlock 4F */
+		tpm_write_index(0x0A, 0x00);	/* int disable */
+		tpm_write_index(0x08, base);	/* base addr lo */
+		tpm_write_index(0x09, (base & 0xFF00) >> 8);	/* base addr hi */
+		tpm_write_index(0x0D, 0xAA);	/* lock 4F */
+		break;
+	case PCI_VENDOR_ID_AMD:
+		/* nothing yet */
+		break;
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(tpm_lpc_bus_init);
+
+/*
+ * Internal kernel interface to transmit TPM commands
+ */
+static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
+			    size_t bufsiz)
+{
+	ssize_t len;
+	u32 count;
+	__be32 *native_size;
+
+	native_size = (__force __be32 *) (buf + 2);
+	count = be32_to_cpu(*native_size);
+
+	if (count == 0)
+		return -ENODATA;
+	if (count > bufsiz) {
+		dev_err(&chip->pci_dev->dev,
+			"invalid count value %x %x \n", count, bufsiz);
+		return -E2BIG;
+	}
+
+	down(&chip->tpm_mutex);
+
+	if ((len = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
+		dev_err(&chip->pci_dev->dev,
+			"tpm_transmit: tpm_send: error %d\n", len);
+		return len;
+	}
+
+	down(&chip->timer_manipulation_mutex);
+	chip->time_expired = 0;
+	init_timer(&chip->device_timer);
+	chip->device_timer.function = tpm_time_expired;
+	chip->device_timer.expires = jiffies + 2 * 60 * HZ;
+	chip->device_timer.data = (unsigned long) &chip->time_expired;
+	add_timer(&chip->device_timer);
+	up(&chip->timer_manipulation_mutex);
+
+	do {
+		u8 status = inb(chip->vendor->base + 1);
+		if ((status & chip->vendor->req_complete_mask) ==
+		    chip->vendor->req_complete_val) {
+			down(&chip->timer_manipulation_mutex);
+			del_singleshot_timer_sync(&chip->device_timer);
+			up(&chip->timer_manipulation_mutex);
+			goto out_recv;
+		}
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(TPM_TIMEOUT);
+		rmb();
+	} while (!chip->time_expired);
+
+
+	chip->vendor->cancel(chip);
+	dev_err(&chip->pci_dev->dev, "Time expired\n");
+	up(&chip->tpm_mutex);
+	return -EIO;
+
+out_recv:
+	len = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
+	if (len < 0)
+		dev_err(&chip->pci_dev->dev,
+			"tpm_transmit: tpm_recv: error %d\n", len);
+	up(&chip->tpm_mutex);
+	return len;
+}
+
+#define TPM_DIGEST_SIZE 20
+#define CAP_PCR_RESULT_SIZE 18
+static u8 cap_pcr[] = {
+	0, 193,			/* TPM_TAG_RQU_COMMAND */
+	0, 0, 0, 22,		/* length */
+	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
+	0, 0, 0, 5,
+	0, 0, 0, 4,
+	0, 0, 1, 1
+};
+
+#define READ_PCR_RESULT_SIZE 30
+static u8 pcrread[] = {
+	0, 193,			/* TPM_TAG_RQU_COMMAND */
+	0, 0, 0, 14,		/* length */
+	0, 0, 0, 21,		/* TPM_ORD_PcrRead */
+	0, 0, 0, 0		/* PCR index */
+};
+
+static ssize_t show_pcrs(struct device *dev, char *buf)
+{
+	u8 data[READ_PCR_RESULT_SIZE];
+	ssize_t len;
+	int i, j, index, num_pcrs;
+	char *str = buf;
+
+	struct tpm_chp *chip =
+	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	if (chip == NULL)
+		return -ENODEV;
+
+	memcpy(data, cap_pcr, sizeof(cap_pcr));
+	if ((len = tpm_transmit(chip, data, sizeof(data)))
+	    < CAP_PCR_RESULT_SIZE)
+		return len;
+
+	num_pcrs = be32_to_cpu(*((__force __be32 *) (data + 14)));
+
+	for (i = 0; i < num_pcrs; i++) {
+		memcpy(data, pcrread, sizeof(pcrread));
+		index = cpu_to_be32(i);
+		memcpy(data + 10, &index, 4);
+		if ((len = tpm_transmit(chip, data, sizeof(data)))
+		    < READ_PCR_RESULT_SIZE)
+			return len;
+		str += sprintf(str, "PCR-%02d: ", i);
+		for (j = 0; j < TPM_DIGEST_SIZE; j++)
+			str += sprintf(str, "%02X ", *(data + 10 + j));
+		str += sprintf(str, "\n");
+	}
+	return str - buf;
+}
+
+static DEVICE_ATTR(pcrs, S_IRUGO, show_pcrs, NULL);
+
+#define  READ_PUBEK_RESULT_SIZE 314
+static u8 readpubek[] = {
+	0, 193,			/* TPM_TAG_RQU_COMMAND */
+	0, 0, 0, 30,		/* length */
+	0, 0, 0, 124,		/* TPM_ORD_ReadPubek */
+};
+
+static ssize_t show_pubek(struct device *dev, char *buf)
+{
+	u8 data[READ_PUBEK_RESULT_SIZE];
+	ssize_t len;
+	__be32 *native_val;
+	int i;
+	char *str = buf;
+
+	struct tpm_chip *chip =
+	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	if (chip == NULL)
+		return -ENODEV;
+
+	memcpy(data, readpubek, sizeof(readpubek));
+	memset(data + sizeof(readpubek), 0, 20);	/* zero nonce */
+
+	if ((len = tpm_transmit(chip, data, sizeof(data))) <
+	    READ_PUBEK_RESULT_SIZE)
+		return len;
+
+	/* 
+	   ignore header 10 bytes
+	   algorithm 32 bits (1 == RSA )
+	   encscheme 16 bits
+	   sigscheme 16 bits
+	   parameters (RSA 12->bytes: keybit, #primes, expbit)  
+	   keylenbytes 32 bits
+	   256 byte modulus
+	   ignore checksum 20 bytes
+	 */
+
+	native_val = (__force __be32 *) (data + 34);
+
+	str +=
+	    sprintf(str,
+		    "Algorithm: %02X %02X %02X %02X\nEncscheme: %02X %02X\n"
+		    "Sigscheme: %02X %02X\nParameters: %02X %02X %02X %02X"
+		    " %02X %02X %02X %02X %02X %02X %02X %02X\n"
+		    "Modulus length: %d\nModulus: \n",
+		    data[10], data[11], data[12], data[13], data[14],
+		    data[15], data[16], data[17], data[22], data[23],
+		    data[24], data[25], data[26], data[27], data[28],
+		    data[29], data[30], data[31], data[32], data[33],
+		    be32_to_cpu(*native_val)
+	    );
+
+	for (i = 0; i < 256; i++) {
+		str += sprintf(str, "%02X ", data[i + 39]);
+		if ((i + 1) % 16 == 0)
+			str += sprintf(str, "\n");
+	}
+	return str - buf;
+}
+
+static DEVICE_ATTR(pubek, S_IRUGO, show_pubek, NULL);
+
+#define CAP_VER_RESULT_SIZE 18
+static u8 cap_version[] = {
+	0, 193,			/* TPM_TAG_RQU_COMMAND */
+	0, 0, 0, 18,		/* length */
+	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
+	0, 0, 0, 6,
+	0, 0, 0, 0
+};
+
+#define CAP_MANUFACTURER_RESULT_SIZE 18
+static u8 cap_manufacturer[] = {
+	0, 193,			/* TPM_TAG_RQU_COMMAND */
+	0, 0, 0, 22,		/* length */
+	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
+	0, 0, 0, 5,
+	0, 0, 0, 4,
+	0, 0, 1, 3
+};
+
+static ssize_t show_caps(struct device *dev, char *buf)
+{
+	u8 data[READ_PUBEK_RESULT_SIZE];
+	ssize_t len;
+	char *str = buf;
+
+	struct tpm_chip *chip =
+	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	if (chip == NULL)
+		return -ENODEV;
+
+	memcpy(data, cap_manufacturer, sizeof(cap_manufacturer));
+
+	if ((len = tpm_transmit(chip, data, sizeof(data))) <
+	    CAP_MANUFACTURER_RESULT_SIZE)
+		return len;
+
+	str += sprintf(str, "Manufacturer: 0x%x\n",
+		       be32_to_cpu(*(data + 14)));
+
+	memcpy(data, cap_version, sizeof(cap_version));
+
+	if ((len = tpm_transmit(chip, data, sizeof(data))) <
+	    CAP_VER_RESULT_SIZE)
+		return len;
+
+	str +=
+	    sprintf(str, "TCG version: %d.%d\nFirmware version: %d.%d\n",
+		    (int) data[14], (int) data[15], (int) data[16],
+		    (int) data[17]);
+
+	return str - buf;
+}
+
+static DEVICE_ATTR(caps, S_IRUGO, show_caps, NULL);
+
+/*
+ * Device file system interface to the TPM
+ */
+int tpm_open(struct inode *inode, struct file *file)
+{
+	int rc = 0, minor = iminor(inode);
+	struct tpm_chip *chip = NULL, *pos;
+
+	spin_lock(&driver_lock);
+
+	list_for_each_entry(pos, &tpm_chip_list, list) {
+		if (pos->vendor->miscdev.minor == minor) {
+			chip = pos;
+			break;
+		}
+	}
+
+	if (chip == NULL) {
+		rc = -ENODEV;
+		goto err_out;
+	}
+
+	if (chip->num_opens) {
+		dev_dbg(&chip->pci_dev->dev,
+			"Another process owns this TPM\n");
+		rc = -EBUSY;
+		goto err_out;
+	}
+
+	chip->num_opens++;
+	pci_dev_get(chip->pci_dev);
+
+	spin_unlock(&driver_lock);
+
+	chip->data_buffer = kmalloc(TPM_BUFSIZE * sizeof(u8), GFP_KERNEL);
+	if (chip->data_buffer == NULL) {
+		chip->num_opens--;
+		pci_dev_put(chip->pci_dev);
+		return -ENOMEM;
+	}
+
+	atomic_set(&chip->data_pending, 0);
+
+	file->private_data = chip;
+	return 0;
+
+err_out:
+	spin_unlock(&driver_lock);
+	return rc;
+}
+
+EXPORT_SYMBOL_GPL(tpm_open);
+
+int tpm_release(struct inode *inode, struct file *file)
+{
+	struct tpm_chip *chip = file->private_data;
+
+	spin_lock(&driver_lock);
+	chip->num_opens--;
+	down(&chip->timer_manipulation_mutex);
+	if (timer_pending(&chip->user_read_timer))
+		del_singleshot_timer_sync(&chip->user_read_timer);
+	else if (timer_pending(&chip->device_timer))
+		del_singleshot_timer_sync(&chip->device_timer);
+	up(&chip->timer_manipulation_mutex);
+	kfree(chip->data_buffer);
+	atomic_set(&chip->data_pending, 0);
+
+	pci_dev_put(chip->pci_dev);
+	file->private_data = NULL;
+	spin_unlock(&driver_lock);
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(tpm_release);
+
+ssize_t tpm_write(struct file * file, const char __user * buf,
+		  size_t size, loff_t * off)
+{
+	struct tpm_chip *chip = file->private_data;
+	int in_size = size, out_size;
+
+	/* cannot perform a write until the read has cleared
+	   either via tpm_read or a user_read_timer timeout */
+	while (atomic_read(&chip->data_pending) != 0) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(TPM_TIMEOUT);
+	}
+
+	down(&chip->buffer_mutex);
+
+	if (in_size > TPM_BUFSIZE)
+		in_size = TPM_BUFSIZE;
+
+	if (copy_from_user
+	    (chip->data_buffer, (void __user *) buf, in_size)) {
+		up(&chip->buffer_mutex);
+		return -EFAULT;
+	}
+
+	/* atomic tpm command send and result receive */
+	out_size = tpm_transmit(chip, chip->data_buffer, TPM_BUFSIZE);
+
+	atomic_set(&chip->data_pending, out_size);
+	up(&chip->buffer_mutex);
+
+	/* Set a timeout by which the reader must come claim the result */
+	down(&chip->timer_manipulation_mutex);
+	init_timer(&chip->user_read_timer);
+	chip->user_read_timer.function = user_reader_timeout;
+	chip->user_read_timer.data = (unsigned long) chip;
+	chip->user_read_timer.expires = jiffies + (60 * HZ);
+	add_timer(&chip->user_read_timer);
+	up(&chip->timer_manipulation_mutex);
+
+	return in_size;
+}
+
+EXPORT_SYMBOL_GPL(tpm_write);
+
+ssize_t tpm_read(struct file * file, char __user * buf,
+		 size_t size, loff_t * off)
+{
+	struct tpm_chip *chip = file->private_data;
+	int ret_size = -ENODATA;
+
+	if (atomic_read(&chip->data_pending) != 0) {	/* Result available */
+		down(&chip->timer_manipulation_mutex);
+		del_singleshot_timer_sync(&chip->user_read_timer);
+		up(&chip->timer_manipulation_mutex);
+
+		down(&chip->buffer_mutex);
+
+		ret_size = atomic_read(&chip->data_pending);
+		atomic_set(&chip->data_pending, 0);
+
+		if (ret_size == 0)	/* timeout just occurred */
+			ret_size = -ETIME;
+		else if (ret_size > 0) {	/* relay data */
+			if (size < ret_size)
+				ret_size = size;
+
+			if (copy_to_user((void __user *) buf,
+					 chip->data_buffer, ret_size)) {
+				ret_size = -EFAULT;
+			}
+		}
+		up(&chip->buffer_mutex);
+	}
+
+	return ret_size;
+}
+
+EXPORT_SYMBOL_GPL(tpm_read);
+
+void __devexit tpm_remove(struct pci_dev *pci_dev)
+{
+	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+
+	if (chip == NULL) {
+		dev_err(&pci_dev->dev, "No device data found\n");
+		return;
+	}
+
+	spin_lock(&driver_lock);
+
+	list_del(&chip->list);
+
+	pci_set_drvdata(pci_dev, NULL);
+	misc_deregister(&chip->vendor->miscdev);
+
+	device_remove_file(&pci_dev->dev, &dev_attr_pubek);
+	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
+	device_remove_file(&pci_dev->dev, &dev_attr_caps);
+
+	spin_unlock(&driver_lock);
+
+	pci_disable_device(pci_dev);
+
+	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
+
+	kfree(chip);
+
+	pci_dev_put(pci_dev);
+}
+
+EXPORT_SYMBOL_GPL(tpm_remove);
+
+static u8 savestate[] = {
+	0, 193,			/* TPM_TAG_RQU_COMMAND */
+	0, 0, 0, 10,		/* blob length (in bytes) */
+	0, 0, 0, 152		/* TPM_ORD_SaveState */
+};
+
+/*
+ * We are about to suspend. Save the TPM state
+ * so that it can be restored.
+ */
+int tpm_pm_suspend(struct pci_dev *pci_dev, u32 pm_state)
+{
+	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+	if (chip == NULL)
+		return -ENODEV;
+
+	tpm_transmit(chip, savestate, sizeof(savestate));
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(tpm_pm_suspend);
+
+/*
+ * Resume from a power safe. The BIOS already restored
+ * the TPM state.
+ */
+int tpm_pm_resume(struct pci_dev *pci_dev)
+{
+	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+	if (chip == NULL)
+		return -ENODEV;
+
+	spin_lock(&driver_lock);
+	tpm_lpc_bus_init(pci_dev, chip->vendor->base);
+	spin_unlock(&driver_lock);
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(tpm_pm_resume);
+
+/*
+ * Called from tpm_<specific>.c probe function only for devices 
+ * the driver has determined it should claim.  Prior to calling
+ * this function the specific probe function has called pci_enable_device
+ * upon errant exit from this function specific probe function should call
+ * pci_disable_device
+ */
+int tpm_register_hardware(struct pci_dev *pci_dev,
+			  struct tpm_vendor_specific *entry)
+{
+	char devname[7];
+	struct tpm_chip *chip;
+	int i, j;
+
+	/* Driver specific per-device data */
+	chip = kmalloc(sizeof(*chip), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+
+	memset(chip, 0, sizeof(struct tpm_chip));
+
+	init_MUTEX(&chip->buffer_mutex);
+	init_MUTEX(&chip->tpm_mutex);
+	init_MUTEX(&chip->timer_manipulation_mutex);
+	INIT_LIST_HEAD(&chip->list);
+
+	chip->vendor = entry;
+
+	chip->dev_num = -1;
+
+	for (i = 0; i < 32; i++)
+		for (j = 0; j < 8; j++)
+			if ((dev_mask[i] & (1 << j)) == 0) {
+				chip->dev_num = i * 32 + j;
+				dev_mask[i] |= 1 << j;
+				goto dev_num_search_complete;
+			}
+
+dev_num_search_complete:
+	if (chip->dev_num < 0) {
+		dev_err(&pci_dev->dev,
+			"No available tpm device numbers\n");
+		kfree(chip);
+		return -ENODEV;
+	} else if (chip->dev_num == 0)
+		chip->vendor->miscdev.minor = TPM_MINOR;
+	else
+		chip->vendor->miscdev.minor = MISC_DYNAMIC_MINOR;
+
+	snprintf(devname, sizeof(devname), "%s%d", "tpm", chip->dev_num);
+	chip->vendor->miscdev.name = devname;
+
+	chip->vendor->miscdev.dev = &(pci_dev->dev);
+	chip->pci_dev = pci_dev_get(pci_dev);
+
+	spin_lock(&driver_lock);
+
+	if (misc_register(&chip->vendor->miscdev)) {
+		dev_err(&chip->pci_dev->dev,
+			"unable to misc_register %s, minor %d\n",
+			chip->vendor->miscdev.name,
+			chip->vendor->miscdev.minor);
+		pci_dev_put(pci_dev);
+		spin_unlock(&driver_lock);
+		kfree(chip);
+		dev_mask[i] &= !(1 << j);
+		return -ENODEV;
+	}
+
+	pci_set_drvdata(pci_dev, chip);
+
+	list_add(&chip->list, &tpm_chip_list);
+
+	device_create_file(&pci_dev->dev, &dev_attr_pubek);
+	device_create_file(&pci_dev->dev, &dev_attr_pcrs);
+	device_create_file(&pci_dev->dev, &dev_attr_caps);
+
+	spin_unlock(&driver_lock);
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(tpm_register_hardware);
+
+static int __init init_tpm(void)
+{
+	return 0;
+}
+
+static void __exit cleanup_tpm(void)
+{
+
+}
+
+module_init(init_tpm);
+module_exit(cleanup_tpm);
+
+MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
+MODULE_DESCRIPTION("TPM Driver");
+MODULE_VERSION("2.0");
+MODULE_LICENSE("GPL");
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.h linux-2.6.10-tpm/drivers/char/tpm/tpm.h
--- linux-2.6.10/drivers/char/tpm/tpm.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.h	2004-12-21 13:35:36.000000000 -0600
@@ -0,0 +1,92 @@
+/*
+ * Copyright (C) 2004 IBM Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Dave Safford <safford@watson.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: <tpmdd_devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org	 
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ * 
+ */
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/miscdevice.h>
+
+#define TPM_TIMEOUT msecs_to_jiffies(5)
+
+/* TPM addresses */
+#define	TPM_ADDR			0x4E
+#define	TPM_DATA			0x4F
+
+struct tpm_chip;
+
+struct tpm_vendor_specific {
+	u8 req_complete_mask;
+	u8 req_complete_val;
+	u16 base;		/* TPM base address */
+
+	int (*recv) (struct tpm_chip *, u8 *, size_t);
+	int (*send) (struct tpm_chip *, u8 *, size_t);
+	void (*cancel) (struct tpm_chip *);
+	struct miscdevice miscdev;
+};
+
+struct tpm_chip {
+	struct pci_dev *pci_dev;	/* PCI device stuff */
+
+	int dev_num;		/* /dev/tpm# */
+	int num_opens;		/* only one allowed */
+	int time_expired;
+
+	/* Data passed to and from the tpm via the read/write calls */
+	u8 *data_buffer;
+	atomic_t data_pending;
+	struct semaphore buffer_mutex;
+
+	struct timer_list user_read_timer;	/* user needs to claim result */
+	struct semaphore tpm_mutex;	/* tpm is processing */
+	struct timer_list device_timer;	/* tpm is processing */
+	struct semaphore timer_manipulation_mutex;
+
+	struct tpm_vendor_specific *vendor;
+
+	struct list_head list;
+};
+
+static inline int tpm_read_index(int index)
+{
+	outb(index, TPM_ADDR);
+	return inb(TPM_DATA) & 0xFF;
+}
+
+static inline void tpm_write_index(int index, int value)
+{
+	outb(index, TPM_ADDR);
+	outb(value & 0xFF, TPM_DATA);
+}
+
+extern void tpm_time_expired(unsigned long);
+extern int tpm_lpc_bus_init(struct pci_dev *, u16);
+
+extern int tpm_register_hardware(struct pci_dev *,
+				 struct tpm_vendor_specific *);
+extern int tpm_open(struct inode *, struct file *);
+extern int tpm_release(struct inode *, struct file *);
+extern ssize_t tpm_write(struct file *, const char __user *, size_t,
+			 loff_t *);
+extern ssize_t tpm_read(struct file *, char __user *, size_t, loff_t *);
+extern void __devexit tpm_remove(struct pci_dev *);
+extern int tpm_pm_suspend(struct pci_dev *, u32);
+extern int tpm_pm_resume(struct pci_dev *);
diff -uprN linux-2.6.10/drivers/char/tpm/tpm_nsc.c linux-2.6.10-tpm/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.10/drivers/char/tpm/tpm_nsc.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm_nsc.c	2004-12-21 13:35:46.000000000 -0600
@@ -0,0 +1,372 @@
+/*
+ * Copyright (C) 2004 IBM Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Dave Safford <safford@watson.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: <tpmdd_devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org	 
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ * 
+ */
+
+#include "tpm.h"
+
+/* National definitions */
+#define	TPM_NSC_BASE			0x360
+#define	TPM_NSC_IRQ			0x07
+
+#define	NSC_LDN_INDEX			0x07
+#define	NSC_SID_INDEX			0x20
+#define	NSC_LDC_INDEX			0x30
+#define	NSC_DIO_INDEX			0x60
+#define	NSC_CIO_INDEX			0x62
+#define	NSC_IRQ_INDEX			0x70
+#define	NSC_ITS_INDEX			0x71
+
+#define	NSC_STATUS			0x01
+#define	NSC_COMMAND			0x01
+#define	NSC_DATA			0x00
+
+/* status bits */
+#define	NSC_STATUS_OBF			0x01	/* output buffer full */
+#define	NSC_STATUS_IBF			0x02	/* input buffer full */
+#define	NSC_STATUS_F0			0x04	/* F0 */
+#define	NSC_STATUS_A2			0x08	/* A2 */
+#define	NSC_STATUS_RDY			0x10	/* ready to receive command */
+#define	NSC_STATUS_IBR			0x20	/* ready to receive data */
+
+/* command bits */
+#define	NSC_COMMAND_NORMAL		0x01	/* normal mode */
+#define	NSC_COMMAND_EOC			0x03
+#define	NSC_COMMAND_CANCEL		0x22
+
+/*
+ * Wait for a certain status to appear
+ */
+static int wait_for_stat(struct tpm_chip *chip, u8 mask, u8 val, u8 * data)
+{
+	int expired = 0;
+	struct timer_list status_timer =
+	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 10 * HZ,
+			      (unsigned long) &expired);
+
+	/* status immediately available check */
+	*data = inb(chip->vendor->base + NSC_STATUS);
+	if ((*data & mask) == val)
+		return 0;
+
+	/* wait for status */
+	add_timer(&status_timer);
+	do {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(TPM_TIMEOUT);
+		*data = inb(chip->vendor->base + 1);
+		if ((*data & mask) == val) {
+			del_singleshot_timer_sync(&status_timer);
+			return 0;
+		}
+	}
+	while (!expired);
+
+	return -EBUSY;
+}
+
+static int nsc_wait_for_ready(struct tpm_chip *chip)
+{
+	int status;
+	int expired = 0;
+	struct timer_list status_timer =
+	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 100,
+			      (unsigned long) &expired);
+
+	/* status immediately available check */
+	status = inb(chip->vendor->base + NSC_STATUS);
+	if (status & NSC_STATUS_OBF)
+		status = inb(chip->vendor->base + NSC_DATA);
+	if (status & NSC_STATUS_RDY)
+		return 0;
+
+	/* wait for status */
+	add_timer(&status_timer);
+	do {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(TPM_TIMEOUT);
+		status = inb(chip->vendor->base + NSC_STATUS);
+		if (status & NSC_STATUS_OBF)
+			status = inb(chip->vendor->base + NSC_DATA);
+		if (status & NSC_STATUS_RDY) {
+			del_singleshot_timer_sync(&status_timer);
+			return 0;
+		}
+	}
+	while (!expired);
+
+	dev_info(&chip->pci_dev->dev, "wait for ready failed\n");
+	return -EBUSY;
+}
+
+
+static int tpm_nsc_recv(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	u8 *buffer = buf;
+	u8 data, *p;
+	u32 size;
+	__be32 *native_size;
+
+	if (count < 6)
+		return -EIO;
+
+	if (wait_for_stat(chip, NSC_STATUS_F0, NSC_STATUS_F0, &data) < 0) {
+		dev_err(&chip->pci_dev->dev, "F0 timeout\n");
+		return -EIO;
+	}
+	if ((data =
+	     inb(chip->vendor->base + NSC_DATA)) != NSC_COMMAND_NORMAL) {
+		dev_err(&chip->pci_dev->dev, "not in normal mode (0x%x)\n",
+			data);
+		return -EIO;
+	}
+
+	/* read the whole packet */
+	for (p = buffer; p < &buffer[count]; p++) {
+		if (wait_for_stat
+		    (chip, NSC_STATUS_OBF, NSC_STATUS_OBF, &data) < 0) {
+			dev_err(&chip->pci_dev->dev,
+				"OBF timeout (while reading data)\n");
+			return -EIO;
+		}
+		if (data & NSC_STATUS_F0)
+			break;
+		*p = inb(chip->vendor->base + NSC_DATA);
+	}
+
+	if ((data & NSC_STATUS_F0) == 0) {
+		dev_err(&chip->pci_dev->dev, "F0 not set\n");
+		return -EIO;
+	}
+	if ((data = inb(chip->vendor->base + NSC_DATA)) != NSC_COMMAND_EOC) {
+		dev_err(&chip->pci_dev->dev,
+			"expected end of command(0x%x)\n", data);
+		return -EIO;
+	}
+
+	native_size = (__force __be32 *) (buf + 2);
+	size = be32_to_cpu(*native_size);
+
+	if (count < size)
+		return -EIO;
+
+	return size;
+}
+
+static int tpm_nsc_send(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	u8 data;
+	int i;
+
+	/*
+	 * If we hit the chip with back to back commands it locks up
+	 * and never set IBF. Hitting it with this "hammer" seems to
+	 * fix it. Not sure why this is needed, we followed the flow
+	 * chart in the manual to the letter.
+	 */
+	outb(NSC_COMMAND_CANCEL, chip->vendor->base + NSC_COMMAND);
+
+	if (nsc_wait_for_ready(chip) != 0)
+		return -EIO;
+
+	if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
+		dev_err(&chip->pci_dev->dev, "IBF timeout\n");
+		return -EIO;
+	}
+
+	outb(NSC_COMMAND_NORMAL, chip->vendor->base + NSC_COMMAND);
+	if (wait_for_stat(chip, NSC_STATUS_IBR, NSC_STATUS_IBR, &data) < 0) {
+		dev_err(&chip->pci_dev->dev, "IBR timeout\n");
+		return -EIO;
+	}
+
+	for (i = 0; i < count; i++) {
+		if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
+			dev_err(&chip->pci_dev->dev,
+				"IBF timeout (while writing data)\n");
+			return -EIO;
+		}
+		outb(buf[i], chip->vendor->base + NSC_DATA);
+	}
+
+	if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
+		dev_err(&chip->pci_dev->dev, "IBF timeout\n");
+		return -EIO;
+	}
+	outb(NSC_COMMAND_EOC, chip->vendor->base + NSC_COMMAND);
+
+	return count;
+}
+
+static void tpm_nsc_cancel(struct tpm_chip *chip)
+{
+	outb(NSC_COMMAND_CANCEL, chip->vendor->base + NSC_COMMAND);
+}
+
+static struct file_operations nsc_ops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.open = tpm_open,
+	.read = tpm_read,
+	.write = tpm_write,
+	.release = tpm_release,
+};
+
+static struct tpm_vendor_specific tpm_nsc = {
+	.recv = tpm_nsc_recv,
+	.send = tpm_nsc_send,
+	.cancel = tpm_nsc_cancel,
+	.req_complete_mask = NSC_STATUS_OBF,
+	.req_complete_val = NSC_STATUS_OBF,
+	.base = TPM_NSC_BASE,
+	.miscdev.fops = &nsc_ops,
+};
+
+static int __devinit tpm_nsc_init(struct pci_dev *pci_dev,
+				  const struct pci_device_id *pci_id)
+{
+	int rc = 0;
+
+	if (pci_enable_device(pci_dev))
+		return -EIO;
+
+	if (tpm_lpc_bus_init(pci_dev, TPM_NSC_BASE)) {
+		rc = -ENODEV;
+		goto out_err;
+	}
+
+	/* verify that it is a National part (SID) */
+	if (tpm_read_index(NSC_SID_INDEX) != 0xEF) {
+		rc = -ENODEV;
+		goto out_err;
+	}
+
+	dev_dbg(&pci_dev->dev, "NSC TPM detected\n");
+	dev_dbg(&pci_dev->dev,
+		"NSC LDN 0x%x, SID 0x%x, SRID 0x%x\n",
+		tpm_read_index(0x07), tpm_read_index(0x20),
+		tpm_read_index(0x27));
+	dev_dbg(&pci_dev->dev,
+		"NSC SIOCF1 0x%x SIOCF5 0x%x SIOCF6 0x%x SIOCF8 0x%x\n",
+		tpm_read_index(0x21), tpm_read_index(0x25),
+		tpm_read_index(0x26), tpm_read_index(0x28));
+	dev_dbg(&pci_dev->dev, "NSC IO Base0 0x%x\n",
+		(tpm_read_index(0x60) << 8) | tpm_read_index(0x61));
+	dev_dbg(&pci_dev->dev, "NSC IO Base1 0x%x\n",
+		(tpm_read_index(0x62) << 8) | tpm_read_index(0x63));
+	dev_dbg(&pci_dev->dev, "NSC Interrupt number and wakeup 0x%x\n",
+		tpm_read_index(0x70));
+	dev_dbg(&pci_dev->dev, "NSC IRQ type select 0x%x\n",
+		tpm_read_index(0x71));
+	dev_dbg(&pci_dev->dev,
+		"NSC DMA channel select0 0x%x, select1 0x%x\n",
+		tpm_read_index(0x74), tpm_read_index(0x75));
+	dev_dbg(&pci_dev->dev,
+		"NSC Config "
+		"0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+		tpm_read_index(0xF0), tpm_read_index(0xF1),
+		tpm_read_index(0xF2), tpm_read_index(0xF3),
+		tpm_read_index(0xF4), tpm_read_index(0xF5),
+		tpm_read_index(0xF6), tpm_read_index(0xF7),
+		tpm_read_index(0xF8), tpm_read_index(0xF9));
+
+	dev_info(&pci_dev->dev,
+		 "NSC PC21100 TPM revision %d\n",
+		 tpm_read_index(0x27) & 0x1F);
+
+	if (tpm_read_index(NSC_LDC_INDEX) == 0)
+		dev_info(&pci_dev->dev, ": NSC TPM not active\n");
+
+	/* select PM channel 1 */
+	tpm_write_index(NSC_LDN_INDEX, 0x12);
+	tpm_read_index(NSC_LDN_INDEX);
+
+	/* disable the DPM module */
+	tpm_write_index(NSC_LDC_INDEX, 0);
+	tpm_read_index(NSC_LDC_INDEX);
+
+	/* set the data register base addresses */
+	tpm_write_index(NSC_DIO_INDEX, TPM_NSC_BASE >> 8);
+	tpm_write_index(NSC_DIO_INDEX + 1, TPM_NSC_BASE);
+	tpm_read_index(NSC_DIO_INDEX);
+	tpm_read_index(NSC_DIO_INDEX + 1);
+
+	/* set the command register base addresses */
+	tpm_write_index(NSC_CIO_INDEX, (TPM_NSC_BASE + 1) >> 8);
+	tpm_write_index(NSC_CIO_INDEX + 1, (TPM_NSC_BASE + 1));
+	tpm_read_index(NSC_DIO_INDEX);
+	tpm_read_index(NSC_DIO_INDEX + 1);
+
+	/* set the interrupt number to be used for the host interface */
+	tpm_write_index(NSC_IRQ_INDEX, TPM_NSC_IRQ);
+	tpm_write_index(NSC_ITS_INDEX, 0x00);
+	tpm_read_index(NSC_IRQ_INDEX);
+
+	/* enable the DPM module */
+	tpm_write_index(NSC_LDC_INDEX, 0x01);
+	tpm_read_index(NSC_LDC_INDEX);
+
+	if ((rc = tpm_register_hardware(pci_dev, &tpm_nsc)) < 0)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	pci_disable_device(pci_dev);
+	return rc;
+}
+
+static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);
+
+static struct pci_driver nsc_pci_driver = {
+	.name = "tpm_nsc",
+	.id_table = tpm_pci_tbl,
+	.probe = tpm_nsc_init,
+	.remove = __devexit_p(tpm_remove),
+	.suspend = tpm_pm_suspend,
+	.resume = tpm_pm_resume,
+};
+
+static int __init init_nsc(void)
+{
+	return pci_register_driver(&nsc_pci_driver);
+}
+
+static void __exit cleanup_nsc(void)
+{
+	pci_unregister_driver(&nsc_pci_driver);
+}
+
+module_init(init_nsc);
+module_exit(cleanup_nsc);
+
+MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
+MODULE_DESCRIPTION("TPM Driver");
+MODULE_VERSION("2.0");
+MODULE_LICENSE("GPL");
diff -uprN linux-2.6.10/include/linux/pci_ids.h linux-2.6.10-tpm/include/linux/pci_ids.h
--- linux-2.6.10/include/linux/pci_ids.h	2004-12-24 15:35:50.000000000 -0600
+++ linux-2.6.10-tpm/include/linux/pci_ids.h	2005-01-07 13:34:28.000000000 -0600
@@ -495,6 +495,7 @@
 #define PCI_DEVICE_ID_AMD_OPUS_7449	0x7449
 #	define PCI_DEVICE_ID_AMD_VIPER_7449	PCI_DEVICE_ID_AMD_OPUS_7449
 #define PCI_DEVICE_ID_AMD_8111_LAN	0x7462
+#define PCI_DEVICE_ID_AMD_8111_LPC	0x7468
 #define PCI_DEVICE_ID_AMD_8111_IDE	0x7469
 #define PCI_DEVICE_ID_AMD_8111_AUDIO	0x746d
 #define PCI_DEVICE_ID_AMD_8151_0	0x7454
