Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVD1PLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVD1PLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbVD1PLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:11:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:61337 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262131AbVD1PK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:10:59 -0400
Date: Thu, 28 Apr 2005 10:10:35 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@dyn95395164
To: greg@kroah.com, rddunlap@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11 of 12] Fix Tpm driver -- add cancel function
Message-ID: <Pine.LNX.4.61.0504281006150.4199@dyn95395164>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Userspcace needs to be able to cancel functions which have been sent to
>>the TPM (part of the spec.).  Add a sysfs file that communicates this
>>desire to the driver and device.

Greg KH wrote:
>Huh?  I don't see any "add a sysfs file" code in this patch.  Am I
>missing something?

True, that wasn't a great description. The actual adding of the sysfs 
function was in the patch with the other sysfs changes (number 10 of 12).  
This function contains the logic to make the waiting loops in the command 
processing aware that a cancel has occured.  Sorry for the confusion.

Randy Dunlap wrote:
>| --- linux-2.6.12-rc2/drivers/char/tpm/tpm.c   2005-04-27
>11:13:29.000000000 -0500
>| +++ linux-2.6.12-rc2-tpmdd/drivers/chat/tpm/tpm.c     2005-04-27
>11:32:35.000000000 -0500
                                     chat ???  :)
>might cause patch(1) problems.

Sorry for the typo fixed below.


Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.h	2005-04-21 18:11:12.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.h	2005-04-21 18:28:09.000000000 -0500
@@ -52,6 +52,7 @@ struct tpm_chip;
 struct tpm_vendor_specific {
 	u8 req_complete_mask;
 	u8 req_complete_val;
+	u8 req_canceled;
 	u16 base;		/* TPM base address */
 
 	int (*recv) (struct tpm_chip *, u8 *, size_t);
diff -urpN --exclude='*.orig' linux-2.6.12-rc2/drivers/char/tpm/tpm_atmel.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm_atmel.c	2005-04-25 18:49:08.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_atmel.c	2005-04-26 15:31:57.000000000 -0500
@@ -132,6 +132,7 @@ static struct tpm_vendor_specific tpm_at
 	.cancel = tpm_atml_cancel,
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
+	.req_canceled = ATML_STATUS_READY,
 	.base = TPM_ATML_BASE,
 	.attr = TPM_DEVICE_ATTRS,
 	.miscdev.fops = &atmel_ops,
diff -urpN --exclude='*.orig' linux-2.6.12-rc2/drivers/char/tpm/tpm_nsc.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm_nsc.c	2005-04-25 18:49:08.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_nsc.c	2005-04-26 15:32:26.000000000 -0500
@@ -230,6 +230,7 @@ static struct tpm_vendor_specific tpm_ns
 	.cancel = tpm_nsc_cancel,
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
+	.req_canceled = NSC_STATUS_RDY,
 	.base = TPM_NSC_BASE,
 	.attr = TPM_DEVICE_ATTRS,
 	.miscdev.fops = &nsc_ops,
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-27 11:13:29.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-27 11:32:35.000000000 -0500
@@ -140,7 +140,7 @@ EXPORT_SYMBOL_GPL(tpm_lpc_bus_init);
 static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
 			    size_t bufsiz)
 {
-	ssize_t len;
+	ssize_t rc;
 	u32 count;
 	__be32 *native_size;
        unsigned long stop;
@@ -158,10 +158,10 @@ static ssize_t tpm_transmit(struct tpm_c
 
 	down(&chip->tpm_mutex);
 
-	if ((len = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
+	if ((rc = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
 		dev_err(&chip->pci_dev->dev,
-			"tpm_transmit: tpm_send: error %d\n", len);
-		return len;
+			"tpm_transmit: tpm_send: error %Zd\n", rc);
+		goto out;
 	}
 
        stop = jiffies + 2 * 60 * HZ;
@@ -171,23 +171,31 @@ static ssize_t tpm_transmit(struct tpm_c
 		    chip->vendor->req_complete_val) {
 			goto out_recv;
 		}
-               msleep(TPM_TIMEOUT); /* CHECK */
+
+		if ((status == chip->vendor->req_canceled)) {
+			dev_err(&chip->pci_dev->dev, "Operation Canceled\n");
+			rc = -ECANCELED;
+			goto out;
+		}
+
+		msleep(TPM_TIMEOUT);	/* CHECK */
 		rmb();
        } while (time_before(jiffies, stop));
 
 
 	chip->vendor->cancel(chip);
-	dev_err(&chip->pci_dev->dev, "Time expired\n");
-	up(&chip->tpm_mutex);
-	return -EIO;
+	dev_err(&chip->pci_dev->dev, "Operation Timed out\n");
+	rc = -ETIME;
+	goto out;
 
 out_recv:
-	len = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
-	if (len < 0)
+	rc = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
+	if (rc < 0)
 		dev_err(&chip->pci_dev->dev,
-			"tpm_transmit: tpm_recv: error %d\n", len);
+			"tpm_transmit: tpm_recv: error %Zd\n", rc);
+out:
 	up(&chip->tpm_mutex);
-	return len;
+	return rc;
 }
 
 #define TPM_DIGEST_SIZE 20
