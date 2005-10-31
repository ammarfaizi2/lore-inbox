Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVJaOhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVJaOhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVJaOhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:37:41 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:10667 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932282AbVJaOhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:37:39 -0500
Subject: [PATCH] tpm: Fix lack of driver_unregister in init failcases
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, castet.matthieu@free.fr
Content-Type: text/plain
Date: Mon, 31 Oct 2005 08:38:12 -0600
Message-Id: <1130769492.4882.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

driver_unregister is not being properly called when the init function
returns an error case.  Restructured the return logic such that this and
the other cleanups all happen in one place.  Preformed many of the
cleanups that Andrew Morton's patch on Thursday made in tpm_atmel.c.  
Fixed Matthieu's concern about writing before discovery.

Signed-off-by: Kylene Hall
---
--- linux-2.6.14-rc4/drivers/char/tpm/tpm_nsc.c	2005-10-28 15:04:47.000000000 +0200
+++ linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm_nsc.c	2005-10-28 14:59:10.000000000 +0200
@@ -286,8 +286,4 @@ static int __init init_nsc(void)
 	int lo, hi;
 	int nscAddrBase = TPM_ADDR;
 
-	driver_register(&nsc_drv);
-
- 	/* select PM channel 1 */
-	tpm_write_index(nscAddrBase,NSC_LDN_INDEX, 0x12);
 
@@ -299,6 +297,8 @@ static int __init init_nsc(void)
 			return -ENODEV;
 	}
 
+	driver_register(&nsc_drv);
+
 	hi = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_HI);
 	lo = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_LO);
 	tpm_nsc.base = (hi<<8) | lo;
@@ -306,38 +306,28 @@ static int __init init_nsc(void)
 	/* enable the DPM module */
 	tpm_write_index(nscAddrBase, NSC_LDC_INDEX, 0x01);
 
-	pdev = kmalloc(sizeof(struct platform_device), GFP_KERNEL);
-	if ( !pdev ) 
-		return -ENOMEM;
-
-	memset(pdev, 0, sizeof(struct platform_device));
+	pdev = kzalloc(sizeof(struct platform_device), GFP_KERNEL);
+	if ( !pdev ) { 
+		rc = -ENOMEM;
+		goto err_unreg_drv;
+	}
 
 	pdev->name = "tpm_nscl0";
 	pdev->id = -1;
 	pdev->num_resources = 0;
-	pdev->dev.release = tpm_nsc_remove;	
+	pdev->dev.release = tpm_nsc_remove;
 	pdev->dev.driver = &nsc_drv;
 
-	if ((rc=platform_device_register(pdev)) < 0) {
-		kfree(pdev);
-		pdev = NULL;
-		return rc;
-	}
+	if ((rc = platform_device_register(pdev)) < 0) 
+		goto err_free_dev;
 
 	if (request_region(tpm_nsc.base, 2, "tpm_nsc0") == NULL ) {
-		platform_device_unregister(pdev);
-		kfree(pdev);
-		pdev = NULL;
-		return -EBUSY;
+		rc = -EBUSY;
+		goto err_unreg_dev;
 	}
 
-	if ((rc = tpm_register_hardware(&pdev->dev, &tpm_nsc)) < 0) {
-		release_region(tpm_nsc.base, 2);
-		platform_device_unregister(pdev);
-		kfree(pdev);
-		pdev = NULL;
-		return rc;
-	}
+	if ((rc = tpm_register_hardware(&pdev->dev, &tpm_nsc)) < 0) 
+		goto err_rel_reg;
 
 	dev_dbg(&pdev->dev, "NSC TPM detected\n");
 	dev_dbg(&pdev->dev,
@@ -373,6 +363,17 @@ static int __init init_nsc(void)
 		 tpm_read_index(nscAddrBase, 0x27) & 0x1F);
 
 	return 0;
+
+err_rel_reg:
+	release_region(tpm_nsc.base, 2);
+err_unreg_dev:
+	platform_device_unregister(pdev);
+err_free_dev:
+	kfree(pdev);
+	pdev = NULL;
+err_unreg_drv:
+	driver_unregister(&nsc_drv);
+	return rc;
 }
 
 static void __exit cleanup_nsc(void)


