Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752126AbWCCBtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbWCCBtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWCCBsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:52 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:24813 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1752126AbWCCBsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:10 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 4/15] EDAC: amd76x pci_dev_get/pci_dev_put fixes
Date: Thu, 2 Mar 2006 17:47:55 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021747.55112.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate unnecessary calls to pci_dev_get() and pci_dev_put() from
amd76x driver.

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/amd76x_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/amd76x_edac.c	2006-02-27 17:00:39.000000000 -0800
@@ -226,7 +226,7 @@ static int amd76x_probe1(struct pci_dev 
 
 	debugf0("%s(): mci = %p\n", __func__, mci);
 
-	mci->pdev = pci_dev_get(pdev);
+	mci->pdev = pdev;
 	mci->mtype_cap = MEM_FLAG_RDDR;
 
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_EC | EDAC_FLAG_SECDED;
@@ -284,11 +284,8 @@ static int amd76x_probe1(struct pci_dev 
 	return 0;
 
 fail:
-	if (mci) {
-		if(mci->pdev)
-			pci_dev_put(mci->pdev);
+	if (mci != NULL)
 		edac_mc_free(mci);
-	}
 	return rc;
 }
 
@@ -322,7 +319,6 @@ static void __devexit amd76x_remove_one(
 		return;
 	if (edac_mc_del_mc(mci))
 		return;
-	pci_dev_put(mci->pdev);
 	edac_mc_free(mci);
 }
 
