Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVJYPVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVJYPVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 11:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVJYPVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 11:21:21 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:14768 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932179AbVJYPVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 11:21:20 -0400
Subject: [PATCH 1 of 6] tpm: add status function to allow non-lpc bus chips
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Date: Tue, 25 Oct 2005 10:21:45 -0500
Message-Id: <1130253705.4839.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is in preparation of supporting chips that are not
necessarily on the lpc bus and thus are not accessed with inb's and
outb's.  The patch replaces the call to get the chip's status in the
tpm.c file with a vendor specific status function.  The patch also
defines the function for each of the current supported devices.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---

diff -uprN linux-2.6.13/drivers/char/tpm/tpm.c linux-2.6.13-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.13/drivers/char/tpm/tpm.c	2005-08-28 18:41:01.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm.c	2005-09-06 11:03:55.000000000 -0500
@@ -79,7 +79,7 @@ static ssize_t tpm_transmit(struct tpm_c
 
 	stop = jiffies + 2 * 60 * HZ;
 	do {
-		u8 status = inb(chip->vendor->base + 1);
+		u8 status = chip->vendor->status(chip);
 		if ((status & chip->vendor->req_complete_mask) ==
 		    chip->vendor->req_complete_val) {
 			goto out_recv;
diff -uprN linux-2.6.13/drivers/char/tpm/tpm.h linux-2.6.13-tpm/drivers/char/tpm/tpm.h
--- linux-2.6.13/drivers/char/tpm/tpm.h	2005-08-28 18:41:01.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm.h	2005-09-06 10:40:56.000000000 -0500
@@ -55,6 +55,7 @@ struct tpm_vendor_specific {
 	int (*recv) (struct tpm_chip *, u8 *, size_t);
 	int (*send) (struct tpm_chip *, u8 *, size_t);
 	void (*cancel) (struct tpm_chip *);
+	u8 (*status) (struct tpm_chip *);
 	struct miscdevice miscdev;
 	struct attribute_group *attr_group;
 };
--- linux-2.6.13/drivers/char/tpm/tpm_atmel.c	2005-08-28 18:41:01.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm_atmel.c	2005-09-09 09:32:51.000000000 -0500
@@ -118,6 +118,11 @@ static void tpm_atml_cancel(struct tpm_c
 	outb(ATML_STATUS_ABORT, chip->vendor->base + 1);
 }
 
+static u8 tpm_atml_status(struct tpm_chip *chip)
+{
+	return inb(chip->vendor->base + 1);
+}
+
 static struct file_operations atmel_ops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
@@ -146,6 +151,7 @@ static struct tpm_vendor_specific tpm_at
 	.recv = tpm_atml_recv,
 	.send = tpm_atml_send,
 	.cancel = tpm_atml_cancel,
+	.status = tpm_atml_status,
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
 	.req_canceled = ATML_STATUS_READY,
--- linux-2.6.13/drivers/char/tpm/tpm_nsc.c	2005-08-28 18:41:01.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm_nsc.c	2005-09-09 09:33:08.000000000 -0500
@@ -220,6 +220,11 @@ static void tpm_nsc_cancel(struct tpm_ch
 	outb(NSC_COMMAND_CANCEL, chip->vendor->base + NSC_COMMAND);
 }
 
+static u8 tpm_nsc_status(struct tpm_chip *chip)
+{
+	return inb(chip->vendor->base + NSC_STATUS);
+}
+
 static struct file_operations nsc_ops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
@@ -248,6 +253,7 @@ static struct tpm_vendor_specific tpm_ns
 	.recv = tpm_nsc_recv,
 	.send = tpm_nsc_send,
 	.cancel = tpm_nsc_cancel,
+	.status = tpm_nsc_status,
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
 	.req_canceled = NSC_STATUS_RDY,
--- linux-2.6.13/drivers/char/tpm/tpm_infineon.c	2005-08-28 18:41:01.000000000 -0500
+++ linux-2.6.13-tpm/drivers/char/tpm/tpm_infineon.c	2005-09-09 09:32:37.000000000 -0500
@@ -316,6 +316,11 @@ static void tpm_inf_cancel(struct tpm_ch
 	 */
 }
 
+static u8 tpm_inf_status(struct tpm_chip *chip)
+{
+	return inb(chip->vendor->base + 1);
+}
+
 static DEVICE_ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL);
 static DEVICE_ATTR(pcrs, S_IRUGO, tpm_show_pcrs, NULL);
 static DEVICE_ATTR(caps, S_IRUGO, tpm_show_caps, NULL);
@@ -344,6 +349,7 @@ static struct tpm_vendor_specific tpm_in
 	.recv = tpm_inf_recv,
 	.send = tpm_inf_send,
 	.cancel = tpm_inf_cancel,
+	.status = tpm_inf_status,
 	.req_complete_mask = 0,
 	.req_complete_val = 0,
 	.attr_group = &inf_attr_grp,


