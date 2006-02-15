Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945943AbWBONn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945943AbWBONn7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945944AbWBONn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:43:59 -0500
Received: from pip251.ish.de ([80.69.98.251]:39827 "EHLO mail01.ish.de")
	by vger.kernel.org with ESMTP id S1945943AbWBONn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:43:58 -0500
Message-ID: <43F33013.4020305@crypto.rub.de>
Date: Wed, 15 Feb 2006 14:43:47 +0100
From: Marcel Selhorst <selhorst@crypto.rub.de>
User-Agent: Mail/News 1.5 (X11/20060208)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org, castet.matthieu@free.fr,
       kjhall@us.ibm.com
Subject: [PATCH] Infineon TPM: IO-port leakage fix, WTX-bugfix
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-14; AVE: 6.33.0.31; VDF: 6.33.0.238; host: mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

this patch fixes IO-port leakage from request_region in case of error during TPM
initialization, adds more pnp-verification and fixes a WTX-bug.

Best regards,
Marcel Selhorst

Signed-off-by: Marcel Selhorst <selhorst@crypto.rub.de>
---

--- linux-2.6.16-rc2/drivers/char/tpm/tpm_infineon.c.old	2006-02-08
11:45:09.000000000 +0100
+++ linux-2.6.16-rc2/drivers/char/tpm/tpm_infineon.c	2006-02-15 13:32:00.000000000 +0100
@@ -33,6 +33,7 @@
 static int TPM_INF_DATA;
 static int TPM_INF_ADDR;
 static int TPM_INF_BASE;
+static int TPM_INF_ADDR_LEN;
 static int TPM_INF_PORT_LEN;

 /* TPM header definitions */
@@ -195,6 +196,7 @@ static int tpm_inf_recv(struct tpm_chip
 	int i;
 	int ret;
 	u32 size = 0;
+	number_of_wtx = 0;

 recv_begin:
 	/* start receiving header */
@@ -378,24 +380,35 @@ static int __devinit tpm_inf_pnp_probe(s
 	if (pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) &&
 	    !(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED)) {
 		TPM_INF_ADDR = pnp_port_start(dev, 0);
+		TPM_INF_ADDR_LEN = pnp_port_len(dev, 0);
 		TPM_INF_DATA = (TPM_INF_ADDR + 1);
 		TPM_INF_BASE = pnp_port_start(dev, 1);
 		TPM_INF_PORT_LEN = pnp_port_len(dev, 1);
-		if (!TPM_INF_PORT_LEN)
-			return -EINVAL;
+		if ((TPM_INF_PORT_LEN < 4) || (TPM_INF_ADDR_LEN < 2)) {
+			rc = -EINVAL;
+			goto err_last;
+		}
 		dev_info(&dev->dev, "Found %s with ID %s\n",
 			 dev->name, dev_id->id);
-		if (!((TPM_INF_BASE >> 8) & 0xff))
-			return -EINVAL;
+		if (!((TPM_INF_BASE >> 8) & 0xff)) {
+			rc = -EINVAL;
+			goto err_last;
+		}
 		/* publish my base address and request region */
 		tpm_inf.base = TPM_INF_BASE;
 		if (request_region
 		    (tpm_inf.base, TPM_INF_PORT_LEN, "tpm_infineon0") == NULL) {
-			release_region(tpm_inf.base, TPM_INF_PORT_LEN);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto err_last;
+		}
+		if (request_region
+		    (TPM_INF_ADDR, TPM_INF_ADDR_LEN, "tpm_infineon0") == NULL) {
+			rc = -EINVAL;
+			goto err_last;
 		}
 	} else {
-		return -EINVAL;
+		rc = -EINVAL;
+		goto err_last;
 	}

 	/* query chip for its vendor, its version number a.s.o. */
@@ -443,8 +456,8 @@ static int __devinit tpm_inf_pnp_probe(s
 			dev_err(&dev->dev,
 				"Could not set IO-ports to 0x%lx\n",
 				tpm_inf.base);
-			release_region(tpm_inf.base, TPM_INF_PORT_LEN);
-			return -EIO;
+			rc = -EIO;
+			goto err_release_region;
 		}

 		/* activate register */
@@ -471,14 +484,21 @@ static int __devinit tpm_inf_pnp_probe(s

 		rc = tpm_register_hardware(&dev->dev, &tpm_inf);
 		if (rc < 0) {
-			release_region(tpm_inf.base, TPM_INF_PORT_LEN);
-			return -ENODEV;
+			rc = -ENODEV;
+			goto err_release_region;
 		}
 		return 0;
 	} else {
-		dev_info(&dev->dev, "No Infineon TPM found!\n");
-		return -ENODEV;
+		rc = -ENODEV;
+		goto err_release_region;
 	}
+
+err_release_region:
+release_region(tpm_inf.base, TPM_INF_PORT_LEN);
+release_region(TPM_INF_ADDR, TPM_INF_ADDR_LEN);
+
+err_last:
+return rc;
 }

 static __devexit void tpm_inf_pnp_remove(struct pnp_dev *dev)
@@ -518,5 +538,5 @@ module_exit(cleanup_inf);

 MODULE_AUTHOR("Marcel Selhorst <selhorst@crypto.rub.de>");
 MODULE_DESCRIPTION("Driver for Infineon TPM SLD 9630 TT 1.1 / SLB 9635 TT 1.2");
-MODULE_VERSION("1.6");
+MODULE_VERSION("1.7");
 MODULE_LICENSE("GPL");

