Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWDCQmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWDCQmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWDCQmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:42:17 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:60063 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751625AbWDCQmH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:42:07 -0400
Subject: [PATCH 7/7] tpm: Driver for next generation TPM chips
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Leendert Van Doorn <leendert@us.ibm.com>,
       Marcel Selhorst <selhorst@crypto.rub.de>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 11:42:46 -0500
Message-Id: <1144082566.29910.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the driver for the next generation of TPM chips
version 1.2 including support for interrupts.  The Trusted Computing
Group has written the TPM Interface Specification (TIS) which defines a
common interface for all manufacturer's 1.2 TPM's thus the name
tpm_tis.

Signed-off-by: Leendert van Doorn <leendert@watson.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
drivers/char/tpm/Kconfig   |   11
drivers/char/tpm/Makefile  |    1
drivers/char/tpm/tpm.c     |    3
drivers/char/tpm/tpm.h     |    9
drivers/char/tpm/tpm_tis.c |  628 +++++++++++++++++++++++++++++++++++
5 files changed, 651 insertions(+), 1 deletion(-)

--- linux-2.6.16/drivers/char/tpm/tpm.h	2006-03-30 17:08:49.315065750 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm.h	2006-03-29 14:16:30.119053500 -0600
@@ -57,6 +57,8 @@ struct tpm_vendor_specific {
 	void __iomem *iobase;		/* ioremapped address */
 	unsigned long base;		/* TPM base address */
 
+	int irq;
+
 	int region_size;
 	int have_region;
 
@@ -66,8 +68,13 @@ struct tpm_vendor_specific {
 	u8 (*status) (struct tpm_chip *);
 	struct miscdevice miscdev;
 	struct attribute_group *attr_group;
+	struct list_head list;
+	int locality;
 	u32 timeout_a, timeout_b, timeout_c, timeout_d;
 	u32 duration[3];
+
+	wait_queue_head_t read_queue;
+	wait_queue_head_t int_queue;
 };
 
 struct tpm_chip {
@@ -93,6 +100,8 @@ struct tpm_chip {
 	struct list_head list;
 };
 
+#define to_tpm_chip(n) container_of(n, struct tpm_chip, vendor)
+
 static inline int tpm_read_index(int base, int index)
 {
 	outb(index, base);
--- linux-2.6.16/drivers/char/tpm/tpm.c	2006-03-30 17:08:49.315065750 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm.c	2006-03-30 16:51:48.567273000 -0600
@@ -391,6 +391,9 @@ static ssize_t tpm_transmit(struct tpm_c
 		goto out;
 	}
 
+	if (chip->vendor.irq)
+		goto out_recv;
+
 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
 	do {
 		u8 status = chip->vendor.status(chip);
--- linux-2.6.16/drivers/char/tpm/tpm_tis.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_tis.c	2006-03-30 10:44:31.874065750 -0600
@@ -0,0 +1,628 @@
+/*
+ * Copyright (C) 2005, 2006 IBM Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org	 
+ *
+ * This device driver implements the TPM interface as defined in
+ * the TCG TPM Interface Spec version 1.2, revision 1.0.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ */
+#include <linux/pnp.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
+#include "tpm.h"
+
+#define TPM_HEADER_SIZE 10
+
+enum tis_access {
+	TPM_ACCESS_VALID = 0x80,
+	TPM_ACCESS_ACTIVE_LOCALITY = 0x20,
+	TPM_ACCESS_REQUEST_PENDING = 0x04,
+	TPM_ACCESS_REQUEST_USE = 0x02,
+};
+
+enum tis_status {
+	TPM_STS_VALID = 0x80,
+	TPM_STS_COMMAND_READY = 0x40,
+	TPM_STS_GO = 0x20,
+	TPM_STS_DATA_AVAIL = 0x10,
+	TPM_STS_DATA_EXPECT = 0x08,
+};
+
+enum tis_int_flags {
+	TPM_GLOBAL_INT_ENABLE = 0x80000000,
+	TPM_INTF_BURST_COUNT_STATIC = 0x100,
+	TPM_INTF_CMD_READY_INT = 0x080,
+	TPM_INTF_INT_EDGE_FALLING = 0x040,
+	TPM_INTF_INT_EDGE_RISING = 0x020,
+	TPM_INTF_INT_LEVEL_LOW = 0x010,
+	TPM_INTF_INT_LEVEL_HIGH = 0x008,
+	TPM_INTF_LOCALITY_CHANGE_INT = 0x004,
+	TPM_INTF_STS_VALID_INT = 0x002,
+	TPM_INTF_DATA_AVAIL_INT = 0x001,
+};
+
+#define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
+#define	TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
+#define	TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
+#define	TPM_INT_STATUS(l)		(0x0010 | ((l) << 12))
+#define	TPM_INTF_CAPS(l)		(0x0014 | ((l) << 12))
+#define	TPM_STS(l)			(0x0018 | ((l) << 12))
+#define	TPM_DATA_FIFO(l)		(0x0024 | ((l) << 12))
+
+#define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
+#define	TPM_RID(l)			(0x0F04 | ((l) << 12))
+
+static LIST_HEAD(tis_chips);
+static DEFINE_SPINLOCK(tis_lock);
+
+static int check_locality(struct tpm_chip *chip, int l)
+{
+	if ((ioread8(chip->vendor.iobase + TPM_ACCESS(l)) &
+	     (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) ==
+	    (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID))
+		return chip->vendor.locality = l;
+
+	return -1;
+}
+
+static void release_locality(struct tpm_chip *chip, int l)
+{
+	if ((ioread8(chip->vendor.iobase + TPM_ACCESS(l)) &
+	     (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID)) ==
+	    (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID))
+		iowrite8(TPM_ACCESS_ACTIVE_LOCALITY,
+			 chip->vendor.iobase + TPM_ACCESS(l));
+}
+
+static int request_locality(struct tpm_chip *chip, int l)
+{
+	unsigned long stop;
+
+	if (check_locality(chip, l) >= 0)
+		return l;
+
+	iowrite8(TPM_ACCESS_REQUEST_USE,
+		 chip->vendor.iobase + TPM_ACCESS(l));
+
+	if (chip->vendor.irq) {
+		interruptible_sleep_on_timeout(&chip->vendor.int_queue,
+					       HZ *
+					       chip->vendor.timeout_a /
+					       1000);
+		if (check_locality(chip, l) >= 0)
+			return l;
+
+	} else {
+		/* wait for burstcount */
+		stop = jiffies + (HZ * chip->vendor.timeout_a / 1000);
+		do {
+			if (check_locality(chip, l) >= 0)
+				return l;
+			msleep(TPM_TIMEOUT);
+		}
+		while (time_before(jiffies, stop));
+	}
+	release_locality(chip, l);
+	return -1;
+}
+
+static u8 tpm_tis_status(struct tpm_chip *chip)
+{
+	return ioread8(chip->vendor.iobase +
+		       TPM_STS(chip->vendor.locality));
+}
+
+static void tpm_tis_ready(struct tpm_chip *chip)
+{
+	/* this causes the current command to be aborted */
+	iowrite8(TPM_STS_COMMAND_READY,
+		 chip->vendor.iobase + TPM_STS(chip->vendor.locality));
+}
+
+static int get_burstcount(struct tpm_chip *chip)
+{
+	unsigned long stop;
+	int burstcnt;
+
+	/* wait for burstcount */
+	/* which timeout value, spec has 2 answers (c & d) */
+	stop = jiffies + (HZ * chip->vendor.timeout_d / 1000);
+	do {
+		burstcnt = ioread8(chip->vendor.iobase +
+				   TPM_STS(chip->vendor.locality) + 1);
+		burstcnt += ioread8(chip->vendor.iobase +
+				    TPM_STS(chip->vendor.locality) +
+				    2) << 8;
+		if (burstcnt)
+			return burstcnt;
+		msleep(TPM_TIMEOUT);
+	} while (time_before(jiffies, stop));
+	return -EBUSY;
+}
+
+static int wait_for_stat(struct tpm_chip *chip, u8 mask, u32 timeout,
+			 wait_queue_head_t * queue)
+{
+	unsigned long stop;
+	u8 status;
+
+	/* check current status */
+	status = tpm_tis_status(chip);
+	if ((status & mask) == mask)
+		return 0;
+
+	if (chip->vendor.irq) {
+		interruptible_sleep_on_timeout(queue, HZ * timeout / 1000);
+		status = tpm_tis_status(chip);
+		if ((status & mask) == mask)
+			return 0;
+	} else {
+		stop = jiffies + (HZ * timeout / 1000);
+		do {
+			msleep(TPM_TIMEOUT);
+			status = tpm_tis_status(chip);
+			if ((status & mask) == mask)
+				return 0;
+		} while (time_before(jiffies, stop));
+	}
+	return -ETIME;
+}
+
+static int recv_data(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	int size = 0, burstcnt;
+	while (size < count &&
+	       wait_for_stat(chip,
+			     TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+			     chip->vendor.timeout_c,
+			     &chip->vendor.read_queue)
+	       == 0) {
+		burstcnt = get_burstcount(chip);
+		for (; burstcnt > 0 && size < count; burstcnt--)
+			buf[size++] = ioread8(chip->vendor.iobase +
+					      TPM_DATA_FIFO(chip->vendor.
+							    locality));
+	}
+	return size;
+}
+
+static int tpm_tis_recv(struct tpm_chip *chip, u8 * buf, size_t count)
+{
+	int size = 0;
+	int expected, status;
+
+	if (count < TPM_HEADER_SIZE) {
+		size = -EIO;
+		goto out;
+	}
+
+	/* read first 10 bytes, including tag, paramsize, and result */
+	if ((size =
+	     recv_data(chip, buf, TPM_HEADER_SIZE)) < TPM_HEADER_SIZE) {
+		dev_err(chip->dev, "Unable to read header\n");
+		goto out;
+	}
+
+	expected = be32_to_cpu(*(__be32 *) (buf + 2));
+	if (expected > count) {
+		size = -EIO;
+		goto out;
+	}
+
+	if ((size +=
+	     recv_data(chip, &buf[TPM_HEADER_SIZE],
+		       expected - TPM_HEADER_SIZE)) < expected) {
+		dev_err(chip->dev, "Unable to read remainder of result\n");
+		size = -ETIME;
+		goto out;
+	}
+
+	wait_for_stat(chip, TPM_STS_VALID, chip->vendor.timeout_c,
+		      &chip->vendor.int_queue);
+	status = tpm_tis_status(chip);
+	if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
+		dev_err(chip->dev, "Error left over data\n");
+		size = -EIO;
+		goto out;
+	}
+
+out:
+	tpm_tis_ready(chip);
+	release_locality(chip, chip->vendor.locality);
+	return size;
+}
+
+/* 
+ * If interrupts are used (signaled by an irq set in the vendor structure)
+ * tpm.c can skip polling for the data to be available as the interrupt is
+ * waited for here 
+ */
+static int tpm_tis_send(struct tpm_chip *chip, u8 * buf, size_t len)
+{
+	int rc, status, burstcnt;
+	size_t count = 0;
+	u32 ordinal;
+
+	if (request_locality(chip, 0) < 0)
+		return -EBUSY;
+
+	status = tpm_tis_status(chip);
+	if ((status & TPM_STS_COMMAND_READY) == 0) {
+		tpm_tis_ready(chip);
+		if (wait_for_stat
+		    (chip, TPM_STS_COMMAND_READY, chip->vendor.timeout_b,
+		     &chip->vendor.int_queue) < 0) {
+			rc = -ETIME;
+			goto out_err;
+		}
+	}
+
+	while (count < len - 1) {
+		burstcnt = get_burstcount(chip);
+		for (; burstcnt > 0 && count < len - 1; burstcnt--) {
+			iowrite8(buf[count], chip->vendor.iobase +
+				 TPM_DATA_FIFO(chip->vendor.locality));
+			count++;
+		}
+
+		wait_for_stat(chip, TPM_STS_VALID, chip->vendor.timeout_c,
+			      &chip->vendor.int_queue);
+		status = tpm_tis_status(chip);
+		if ((status & TPM_STS_DATA_EXPECT) == 0) {
+			rc = -EIO;
+			goto out_err;
+		}
+	}
+
+	/* write last byte */
+	iowrite8(buf[count],
+		 chip->vendor.iobase +
+		 TPM_DATA_FIFO(chip->vendor.locality));
+	wait_for_stat(chip, TPM_STS_VALID, chip->vendor.timeout_c,
+		      &chip->vendor.int_queue);
+	status = tpm_tis_status(chip);
+	if ((status & TPM_STS_DATA_EXPECT) != 0) {
+		rc = -EIO;
+		goto out_err;
+	}
+
+	/* go and do it */
+	iowrite8(TPM_STS_GO,
+		 chip->vendor.iobase + TPM_STS(chip->vendor.locality));
+
+	if (chip->vendor.irq) {
+		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
+		if (wait_for_stat
+		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+		     tpm_calc_ordinal_duration(chip, ordinal),
+		     &chip->vendor.read_queue) < 0) {
+			rc = -ETIME;
+			goto out_err;
+		}
+	}
+	return len;
+out_err:
+	tpm_tis_ready(chip);
+	release_locality(chip, chip->vendor.locality);
+	return rc;
+}
+
+static struct file_operations tis_ops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.open = tpm_open,
+	.read = tpm_read,
+	.write = tpm_write,
+	.release = tpm_release,
+};
+
+static DEVICE_ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL);
+static DEVICE_ATTR(pcrs, S_IRUGO, tpm_show_pcrs, NULL);
+static DEVICE_ATTR(state, S_IRUGO, tpm_show_state, NULL);
+static DEVICE_ATTR(caps, S_IRUGO, tpm_show_caps_1_2, NULL);
+static DEVICE_ATTR(cancel, S_IWUSR | S_IWGRP, NULL, tpm_store_cancel);
+
+static struct attribute *tis_attrs[] = {
+	&dev_attr_pubek.attr, &dev_attr_pcrs.attr,
+	&dev_attr_state.attr, &dev_attr_caps.attr,
+	&dev_attr_cancel.attr, NULL,
+};
+
+static struct attribute_group tis_attr_grp = {
+	.attrs = tis_attrs
+};
+
+static struct tpm_vendor_specific tpm_tis = {
+	.status = tpm_tis_status,
+	.recv = tpm_tis_recv,
+	.send = tpm_tis_send,
+	.cancel = tpm_tis_ready,
+	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+	.req_canceled = TPM_STS_COMMAND_READY,
+	.attr_group = &tis_attr_grp,
+	.miscdev = {
+		    .fops = &tis_ops,},
+};
+
+static irqreturn_t tis_int_probe(int irq, void *dev_id, struct pt_regs
+				 *regs)
+{
+	struct tpm_chip *chip = (struct tpm_chip *) dev_id;
+	u32 interrupt;
+
+	interrupt = ioread32(chip->vendor.iobase +
+			     TPM_INT_STATUS(chip->vendor.locality));
+
+	if (interrupt == 0)
+		return IRQ_NONE;
+
+	chip->vendor.irq = irq;
+
+	/* Clear interrupts handled with TPM_EOI */
+	iowrite32(interrupt,
+		  chip->vendor.iobase +
+		  TPM_INT_STATUS(chip->vendor.locality));
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t tis_int_handler(int irq, void *dev_id, struct pt_regs
+				   *regs)
+{
+	struct tpm_chip *chip = (struct tpm_chip *) dev_id;
+	u32 interrupt;
+	int i;
+
+	interrupt = ioread32(chip->vendor.iobase +
+			     TPM_INT_STATUS(chip->vendor.locality));
+
+	if (interrupt == 0)
+		return IRQ_NONE;
+
+	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
+		wake_up_interruptible(&chip->vendor.read_queue);
+	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
+		for (i = 0; i < 5; i++)
+			if (check_locality(chip, i) >= 0)
+				break;
+	if (interrupt &
+	    (TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_STS_VALID_INT |
+	     TPM_INTF_CMD_READY_INT))
+		wake_up_interruptible(&chip->vendor.int_queue);
+
+	/* Clear interrupts handled with TPM_EOI */
+	iowrite32(interrupt,
+		  chip->vendor.iobase +
+		  TPM_INT_STATUS(chip->vendor.locality));
+	return IRQ_HANDLED;
+}
+
+static int __devinit tpm_tis_pnp_init(struct pnp_dev
+				      *pnp_dev, const struct
+				      pnp_device_id
+				      *pnp_id)
+{
+	u32 vendor, intfcaps, intmask;
+	int rc, i;
+	unsigned long start, len;
+	struct tpm_chip *chip;
+
+	start = pnp_mem_start(pnp_dev, 0);
+	len = pnp_mem_len(pnp_dev, 0);
+
+	if (!(chip = tpm_register_hardware(&pnp_dev->dev, &tpm_tis)))
+		return -ENODEV;
+
+	chip->vendor.iobase = ioremap(start, len);
+	if (!chip->vendor.iobase) {
+		rc = -EIO;
+		goto out_err;
+	}
+
+	vendor = ioread32(chip->vendor.iobase + TPM_DID_VID(0));
+	if ((vendor & 0xFFFF) == 0xFFFF) {
+		rc = -ENODEV;
+		goto out_err;
+	}
+
+	/* Default timeouts */
+	chip->vendor.timeout_a = 750;	/* ms */
+	chip->vendor.timeout_b = 2000;	/* 2 sec */
+	chip->vendor.timeout_c = 750;	/* ms */
+	chip->vendor.timeout_d = 750;	/* ms */
+
+	dev_info(&pnp_dev->dev,
+		 "1.2 TPM (device-id 0x%X, rev-id %d)\n",
+		 vendor >> 16, ioread8(chip->vendor.iobase + TPM_RID(0)));
+
+	/* Figure out the capabilities */
+	intfcaps =
+	    ioread32(chip->vendor.iobase +
+		     TPM_INTF_CAPS(chip->vendor.locality));
+	dev_dbg(&pnp_dev->dev, "TPM interface capabilities (0x%x):\n",
+		intfcaps);
+	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
+		dev_dbg(&pnp_dev->dev, "\tBurst Count Static\n");
+	if (intfcaps & TPM_INTF_CMD_READY_INT)
+		dev_dbg(&pnp_dev->dev, "\tCommand Ready Int Support\n");
+	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
+		dev_dbg(&pnp_dev->dev, "\tInterrupt Edge Falling\n");
+	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
+		dev_dbg(&pnp_dev->dev, "\tInterrupt Edge Rising\n");
+	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
+		dev_dbg(&pnp_dev->dev, "\tInterrupt Level Low\n");
+	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
+		dev_dbg(&pnp_dev->dev, "\tInterrupt Level High\n");
+	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
+		dev_dbg(&pnp_dev->dev, "\tLocality Change Int Support\n");
+	if (intfcaps & TPM_INTF_STS_VALID_INT)
+		dev_dbg(&pnp_dev->dev, "\tSts Valid Int Support\n");
+	if (intfcaps & TPM_INTF_DATA_AVAIL_INT)
+		dev_dbg(&pnp_dev->dev, "\tData Avail Int Support\n");
+
+	if (request_locality(chip, 0) != 0) {
+		rc = -ENODEV;
+		goto out_err;
+	}
+
+	/* INTERRUPT Setup */
+	init_waitqueue_head(&chip->vendor.read_queue);
+	init_waitqueue_head(&chip->vendor.int_queue);
+
+	intmask =
+	    ioread32(chip->vendor.iobase +
+		     TPM_INT_ENABLE(chip->vendor.locality));
+
+	intmask |= TPM_INTF_CMD_READY_INT
+	    | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_DATA_AVAIL_INT
+	    | TPM_INTF_STS_VALID_INT;
+
+	iowrite32(intmask,
+		  chip->vendor.iobase +
+		  TPM_INT_ENABLE(chip->vendor.locality));
+
+	chip->vendor.irq =
+	    ioread8(chip->vendor.iobase +
+		    TPM_INT_VECTOR(chip->vendor.locality));
+
+	for (i = 3; i < 16 && chip->vendor.irq == 0; i++) {
+		iowrite8(i,
+			 chip->vendor.iobase +
+			 TPM_INT_VECTOR(chip->vendor.locality));
+		if (request_irq
+		    (i, tis_int_probe, SA_SHIRQ,
+		     chip->vendor.miscdev.name, chip) != 0) {
+			dev_info(chip->dev,
+				 "Unable to request irq: %d for probe\n",
+				 i);
+			continue;
+		}
+
+		/* Clear all existing */
+		iowrite32(ioread32
+			  (chip->vendor.iobase +
+			   TPM_INT_STATUS(chip->vendor.locality)),
+			  chip->vendor.iobase +
+			  TPM_INT_STATUS(chip->vendor.locality));
+
+		/* Turn on */
+		iowrite32(intmask | TPM_GLOBAL_INT_ENABLE,
+			  chip->vendor.iobase +
+			  TPM_INT_ENABLE(chip->vendor.locality));
+
+		/* Generate Interrupts */
+		tpm_gen_interrupt(chip);
+
+		/* Turn off */
+		iowrite32(intmask,
+			  chip->vendor.iobase +
+			  TPM_INT_ENABLE(chip->vendor.locality));
+		free_irq(i, chip);
+	}
+	if (chip->vendor.irq) {
+		iowrite8(chip->vendor.irq,
+			 chip->vendor.iobase +
+			 TPM_INT_VECTOR(chip->vendor.locality));
+		if (request_irq
+		    (chip->vendor.irq, tis_int_handler, SA_SHIRQ,
+		     chip->vendor.miscdev.name, chip) != 0) {
+			dev_info(chip->dev,
+				 "Unable to request irq: %d for use\n", i);
+			chip->vendor.irq = 0;
+		} else {
+			/* Clear all existing */
+			iowrite32(ioread32
+				  (chip->vendor.iobase +
+				   TPM_INT_STATUS(chip->vendor.locality)),
+				  chip->vendor.iobase +
+				  TPM_INT_STATUS(chip->vendor.locality));
+
+			/* Turn on */
+			iowrite32(intmask | TPM_GLOBAL_INT_ENABLE,
+				  chip->vendor.iobase +
+				  TPM_INT_ENABLE(chip->vendor.locality));
+		}
+	}
+
+	INIT_LIST_HEAD(&chip->vendor.list);
+	spin_lock(&tis_lock);
+	list_add(&chip->vendor.list, &tis_chips);
+	spin_unlock(&tis_lock);
+
+	tpm_get_timeouts(chip);
+
+	return 0;
+out_err:
+	if (chip->vendor.iobase)
+		iounmap(chip->vendor.iobase);
+	tpm_remove_hardware(chip->dev);
+	return rc;
+}
+
+static int tpm_tis_pnp_suspend(struct pnp_dev *dev, pm_message_t msg)
+{
+	return tpm_pm_suspend(&dev->dev, msg);
+}
+
+static int tpm_tis_pnp_resume(struct pnp_dev *dev)
+{
+	return tpm_pm_resume(&dev->dev);
+}
+
+static struct pnp_device_id tpm_pnp_tbl[] __devinitdata = {
+	{"PNP0C31", 0},		/* TPM */
+	{"", 0}
+};
+
+static struct pnp_driver tis_pnp_driver = {
+	.name = "tpm_tis",
+	.id_table = tpm_pnp_tbl,
+	.probe = tpm_tis_pnp_init,
+	.suspend = tpm_tis_pnp_suspend,
+	.resume = tpm_tis_pnp_resume,
+};
+
+static int __init init_tis(void)
+{
+	return pnp_register_driver(&tis_pnp_driver);
+}
+
+static void __exit cleanup_tis(void)
+{
+	struct tpm_vendor_specific *i, *j;
+	struct tpm_chip *chip;
+	spin_lock(&tis_lock);
+	list_for_each_entry_safe(i, j, &tis_chips, list) {
+		chip = to_tpm_chip(i);
+		iowrite32(~TPM_GLOBAL_INT_ENABLE &
+			  ioread32(chip->vendor.iobase +
+				   TPM_INT_ENABLE(chip->vendor.
+						  locality)),
+			  chip->vendor.iobase +
+			  TPM_INT_ENABLE(chip->vendor.locality));
+		if (chip->vendor.irq)
+			free_irq(chip->vendor.irq, chip);
+		iounmap(i->iobase);
+		list_del(&i->list);
+		tpm_remove_hardware(chip->dev);
+	}
+	spin_unlock(&tis_lock);
+	pnp_unregister_driver(&tis_pnp_driver);
+}
+
+module_init(init_tis);
+module_exit(cleanup_tis);
+MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
+MODULE_DESCRIPTION("TPM Driver");
+MODULE_VERSION("2.0");
+MODULE_LICENSE("GPL");
--- linux-2.6.16/drivers/char/tpm/Makefile	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/Makefile	2006-03-02 16:20:06.002087500 -0600
@@ -5,6 +5,7 @@ obj-$(CONFIG_TCG_TPM) += tpm.o
 ifdef CONFIG_ACPI
 	obj-$(CONFIG_TCG_TPM) += tpm_bios.o
 endif
+obj-$(CONFIG_TCG_TIS) += tpm_tis.o
 obj-$(CONFIG_TCG_NSC) += tpm_nsc.o
 obj-$(CONFIG_TCG_ATMEL) += tpm_atmel.o
 obj-$(CONFIG_TCG_INFINEON) += tpm_infineon.o
--- linux-2.6.16/drivers/char/tpm/Kconfig	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/Kconfig	2006-03-02 16:19:05.730320750 -0600
@@ -20,9 +20,18 @@ config TCG_TPM
 	  Note: For more TPM drivers enable CONFIG_PNP, CONFIG_ACPI
 	  and CONFIG_PNPACPI.
 
+config TCG_TIS
+	tristate "TPM Interface Specification 1.2 Interface"
+	depends on TCG_TPM
+	---help---
+	  If you have a TPM security chip that is compliant with the
+	  TCG TIS 1.2 TPM specification say Yes and it will be accessible
+	  from within Linux.  To compile this driver as a module, choose
+	  M here; the module will be called tpm_tis.
+
 config TCG_NSC
 	tristate "National Semiconductor TPM Interface"
-	depends on TCG_TPM
+	depends on TCG_TPM && PNPACPI
 	---help---
 	  If you have a TPM security chip from National Semicondutor 
 	  say Yes and it will be accessible from within Linux.  To 


