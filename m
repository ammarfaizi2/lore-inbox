Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVAaT2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVAaT2S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVAaT1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:27:37 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:14469 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261327AbVAaT1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:27:06 -0500
Date: Mon, 31 Jan 2005 13:27:00 -0600 (CST)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] tpm: insert missing up mutex in an error path, typo
 build fix -- updated version
In-Reply-To: <Pine.LNX.4.58.0501281539340.6360@jo.austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0501311322380.9872@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com>
 <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501281539340.6360@jo.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is also a typo in the driver version in the 2.6.11-rc2-mm2 tree that 
is not fixed by the previous patch.  Please apply this upated version to 
fix the previously acknowledged problems and this typo causing a build 
error.

Thanks,
Kylie

On Fri, 28 Jan 2005, Kylene Hall wrote:

> This patch puts in the missing up call on the tpm_mutex on an 
> error condition in the tpm_transmit function.  Bug reported by Stefan 
> Berger <stefanb@us.ibm.com>.  This patch also implements a new status 
> function to handle future chip configurations which may generate status 
> differntly. 
> 
> Thanks,
> Kylie
>   

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.10/drivers/char/tpm/tpm_atmel.c linux-2.6.10-tpm/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.10/drivers/char/tpm/tpm_atmel.c	2005-01-18 16:42:17.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm_atmel.c	2005-01-21 13:11:11.000000000 -0600
@@ -112,6 +112,11 @@ static void tpm_atml_cancel(struct tpm_c
 	outb(ATML_STATUS_ABORT, chip->vendor->base + 1);
 }
 
+static u8 tpm_atml_status(struct tpm_chip *chip)
+{
+	return inb( chip->vendor->base + 1);
+}
+
 static struct file_operations atmel_ops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
@@ -125,6 +130,7 @@ static struct tpm_vendor_specific tpm_at
 	.recv = tpm_atml_recv,
 	.send = tpm_atml_send,
 	.cancel = tpm_atml_cancel,
+	.status = tpm_atml_status,
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
 	.base = TPM_ATML_BASE,
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.c linux-2.6.10-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.10/drivers/char/tpm/tpm.c	2005-01-31 13:59:38.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.c	2005-01-28 16:28:45.000000000 -0600
@@ -152,6 +151,7 @@ static ssize_t tpm_transmit(struct tpm_c
 	if ((len = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
 		dev_err(&chip->pci_dev->dev,
 			"tpm_transmit: tpm_send: error %d\n", len);
+		up(&chip->tpm_mutex);
 		return len;
 	}
 
@@ -165,7 +165,7 @@ static ssize_t tpm_transmit(struct tpm_c
 	up(&chip->timer_manipulation_mutex);
 
 	do {
-		u8 status = inb(chip->vendor->base + 1);
+		u8 status = chip->vendor->status(chip);
 		if ((status & chip->vendor->req_complete_mask) ==
 		    chip->vendor->req_complete_val) {
 			down(&chip->timer_manipulation_mutex);
@@ -219,7 +219,7 @@ static ssize_t show_pcrs(struct device *
 	int i, j, index, num_pcrs;
 	char *str = buf;
 
-	struct tpm_chip *chp =
+	struct tpm_chip *chip =
 	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
 	if (chip == NULL)
 		return -ENODEV;
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.h linux-2.6.10-tpm/drivers/char/tpm/tpm.h
--- linux-2.6.10/drivers/char/tpm/tpm.h	2005-01-18 16:42:17.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.h	2005-01-21 13:10:20.000000000 -0600
@@ -40,6 +40,7 @@ struct tpm_vendor_specific {
 	int (*recv) (struct tpm_chip *, u8 *, size_t);
 	int (*send) (struct tpm_chip *, u8 *, size_t);
 	void (*cancel) (struct tpm_chip *);
+	u8 (*status) (struct tpm_chip *);
 	struct miscdevice miscdev;
 };
 
diff -uprN linux-2.6.10/drivers/char/tpm/tpm_nsc.c linux-2.6.10-tpm/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.10/drivers/char/tpm/tpm_nsc.c	2005-01-18 16:42:17.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm_nsc.c	2005-01-21 13:12:27.000000000 -0600
@@ -219,6 +219,12 @@ static void tpm_nsc_cancel(struct tpm_ch
 	outb(NSC_COMMAND_CANCEL, chip->vendor->base + NSC_COMMAND);
 }
 
+
+static u8 tpm_nsc_status(struct tpm_chip *chip)
+{
+	return inb(chip->vendor->base + NSC_STATUS);
+}
+
 static struct file_operations nsc_ops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
@@ -232,6 +238,7 @@ static struct tpm_vendor_specific tpm_ns
 	.recv = tpm_nsc_recv,
 	.send = tpm_nsc_send,
 	.cancel = tpm_nsc_cancel,
+	.status = tpm_nsc_status,
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
 	.base = TPM_NSC_BASE,
