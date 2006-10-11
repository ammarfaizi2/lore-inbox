Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161529AbWJKVik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161529AbWJKVik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161527AbWJKVii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:38:38 -0400
Received: from havoc.gtf.org ([69.61.125.42]:30167 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161525AbWJKVif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:38:35 -0400
Date: Wed, 11 Oct 2006 17:38:34 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Eric.Moore@lsil.com, linux-scsi@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] MPT fusion: handle PCI layer error on resume
Message-ID: <20061011213834.GA20253@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the unlikely event of pci_enable_device() failure during resume, we
do the minimalist solution and simply exit, rather than continuing to
enable the hardware.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/message/fusion/mptbase.c |   10 ++++++++--

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index e5c7271..f183b83 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1515,7 +1515,7 @@ mpt_resume(struct pci_dev *pdev)
 {
 	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
 	u32 device_state = pdev->current_state;
-	int recovery_state;
+	int recovery_state, rc;
 
 	printk(MYIOC_s_INFO_FMT
 	"pci-resume: pdev=0x%p, slot=%s, Previous operating state [D%d]\n",
@@ -1523,7 +1523,13 @@ mpt_resume(struct pci_dev *pdev)
 
 	pci_set_power_state(pdev, 0);
 	pci_restore_state(pdev);
-	pci_enable_device(pdev);
+
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		printk(MYIOC_s_INFO_FMT
+			"pci-resume: device enable failed\n", ioc->name);
+		return rc;
+	}
 
 	/* enable interrupts */
 	CHIPREG_WRITE32(&ioc->chip->IntMask, MPI_HIM_DIM);
