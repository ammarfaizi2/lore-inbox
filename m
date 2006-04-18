Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWDRVAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWDRVAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 17:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWDRVAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 17:00:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:50602 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932254AbWDRVAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 17:00:12 -0400
Subject: [PATCH] tpm: add interrupt module parameter
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 15:56:15 -0500
Message-Id: <1145393776.4829.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a boolean module parameter that allows the user to turn
interrupt support on and off.  The default behavior is to attempt to use
interrupts.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm_tis.c |   78 +++++++++++++++++++----------------
 1 files changed, 43 insertions(+), 35 deletions(-)

--- linux-2.6.17-rc1/drivers/char/tpm/tpm_tis.c	2006-04-18 15:24:27.850777000 -0500
+++ linux-2.6.17-rc1-tpm/drivers/char/tpm/tpm_tis.c	2006-04-18 15:38:33.719640500 -0500
@@ -16,6 +16,9 @@
  * published by the Free Software Foundation, version 2 of the
  * License.
  */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/pnp.h>
 #include <linux/interrupt.h>
 #include <linux/wait.h>
@@ -424,6 +427,10 @@ static irqreturn_t tis_int_handler(int i
 	return IRQ_HANDLED;
 }
 
+static int interrupts = 1;
+module_param(interrupts, bool, 0444);
+MODULE_PARM_DESC(interrupts, "Enable interrupts");
+
 static int __devinit tpm_tis_pnp_init(struct pnp_dev *pnp_dev, const struct
 				      pnp_device_id *pnp_id)
 {
@@ -510,44 +517,44 @@ static int __devinit tpm_tis_pnp_init(st
 	iowrite32(intmask,
 		  chip->vendor.iobase +
 		  TPM_INT_ENABLE(chip->vendor.locality));
+	if (interrupts) {
+		chip->vendor.irq =
+		    ioread8(chip->vendor.iobase +
+			    TPM_INT_VECTOR(chip->vendor.locality));
+
+		for (i = 3; i < 16 && chip->vendor.irq == 0; i++) {
+			iowrite8(i, chip->vendor.iobase +
+				    TPM_INT_VECTOR(chip->vendor.locality));
+			if (request_irq
+			    (i, tis_int_probe, SA_SHIRQ,
+			     chip->vendor.miscdev.name, chip) != 0) {
+				dev_info(chip->dev,
+					 "Unable to request irq: %d for probe\n",
+					 i);
+				continue;
+			}
 
-	chip->vendor.irq =
-	    ioread8(chip->vendor.iobase +
-		    TPM_INT_VECTOR(chip->vendor.locality));
-
-	for (i = 3; i < 16 && chip->vendor.irq == 0; i++) {
-		iowrite8(i,
-			 chip->vendor.iobase +
-			 TPM_INT_VECTOR(chip->vendor.locality));
-		if (request_irq
-		    (i, tis_int_probe, SA_SHIRQ,
-		     chip->vendor.miscdev.name, chip) != 0) {
-			dev_info(chip->dev,
-				 "Unable to request irq: %d for probe\n",
-				 i);
-			continue;
-		}
-
-		/* Clear all existing */
-		iowrite32(ioread32
-			  (chip->vendor.iobase +
-			   TPM_INT_STATUS(chip->vendor.locality)),
-			  chip->vendor.iobase +
-			  TPM_INT_STATUS(chip->vendor.locality));
+			/* Clear all existing */
+			iowrite32(ioread32
+				  (chip->vendor.iobase +
+				   TPM_INT_STATUS(chip->vendor.locality)),
+				  chip->vendor.iobase +
+				  TPM_INT_STATUS(chip->vendor.locality));
 
-		/* Turn on */
-		iowrite32(intmask | TPM_GLOBAL_INT_ENABLE,
-			  chip->vendor.iobase +
-			  TPM_INT_ENABLE(chip->vendor.locality));
+			/* Turn on */
+			iowrite32(intmask | TPM_GLOBAL_INT_ENABLE,
+				  chip->vendor.iobase +
+				  TPM_INT_ENABLE(chip->vendor.locality));
 
-		/* Generate Interrupts */
-		tpm_gen_interrupt(chip);
+			/* Generate Interrupts */
+			tpm_gen_interrupt(chip);
 
-		/* Turn off */
-		iowrite32(intmask,
-			  chip->vendor.iobase +
-			  TPM_INT_ENABLE(chip->vendor.locality));
-		free_irq(i, chip);
+			/* Turn off */
+			iowrite32(intmask,
+				  chip->vendor.iobase +
+				  TPM_INT_ENABLE(chip->vendor.locality));
+			free_irq(i, chip);
+		}
 	}
 	if (chip->vendor.irq) {
 		iowrite8(chip->vendor.irq,
@@ -557,7 +564,8 @@ static int __devinit tpm_tis_pnp_init(st
 		    (chip->vendor.irq, tis_int_handler, SA_SHIRQ,
 		     chip->vendor.miscdev.name, chip) != 0) {
 			dev_info(chip->dev,
-				 "Unable to request irq: %d for use\n", i);
+				 "Unable to request irq: %d for use\n",
+				 chip->vendor.irq);
 			chip->vendor.irq = 0;
 		} else {
 			/* Clear all existing */


