Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161881AbWKVIGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161881AbWKVIGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161919AbWKVIGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:06:38 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:31386 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161881AbWKVIGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:06:17 -0500
Message-ID: <4564051C.3080908@jp.fujitsu.com>
Date: Wed, 22 Nov 2006 17:06:52 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Cc: Greg KH <greg@kroah.com>, Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 5/5] lpfc : Make Emulex lpfc driver legacy I/O port free
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes Emulex lpfc driver legacy I/O port free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---
 drivers/scsi/lpfc/lpfc_init.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6.19-rc6/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/scsi/lpfc/lpfc_init.c
+++ linux-2.6.19-rc6/drivers/scsi/lpfc/lpfc_init.c
@@ -1453,10 +1453,11 @@
 	int error = -ENODEV, retval;
 	int i;
 	uint16_t iotag;
+	int bars = pci_select_bars(pdev, IORESOURCE_MEM);

-	if (pci_enable_device(pdev))
+	if (pci_enable_device_bars(pdev, bars))
 		goto out;
-	if (pci_request_regions(pdev, LPFC_DRIVER_NAME))
+	if (pci_request_selected_regions(pdev, bars, LPFC_DRIVER_NAME))
 		goto out_disable_device;

 	host = scsi_host_alloc(&lpfc_template, sizeof (struct lpfc_hba));
@@ -1759,7 +1760,7 @@
 	phba->host = NULL;
 	scsi_host_put(host);
 out_release_regions:
-	pci_release_regions(pdev);
+	pci_release_selected_regions(pdev, bars);
 out_disable_device:
 	pci_disable_device(pdev);
 out:
@@ -1773,6 +1774,7 @@
 	struct Scsi_Host   *host = pci_get_drvdata(pdev);
 	struct lpfc_hba    *phba = (struct lpfc_hba *)host->hostdata;
 	unsigned long iflag;
+	int bars = pci_select_bars(pdev, IORESOURCE_MEM);

 	lpfc_free_sysfs_attr(phba);

@@ -1816,7 +1818,7 @@
 	iounmap(phba->ctrl_regs_memmap_p);
 	iounmap(phba->slim_memmap_p);

-	pci_release_regions(phba->pcidev);
+	pci_release_selected_regions(phba->pcidev, bars);
 	pci_disable_device(phba->pcidev);

 	idr_remove(&lpfc_hba_index, phba->brd_no);

