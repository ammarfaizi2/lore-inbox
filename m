Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWFGDSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWFGDSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWFGDSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:18:48 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55013 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750781AbWFGDSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:18:47 -0400
Message-ID: <448644D6.9030907@jp.fujitsu.com>
Date: Wed, 07 Jun 2006 12:15:34 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, akpm@osdl.org,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 4/4] Make Emulex lpfc driver legacy I/O port free
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com>
In-Reply-To: <448643B9.2080805@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes Emulex lpfc driver legacy I/O port free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/scsi/lpfc/lpfc_init.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6.17-rc6/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- linux-2.6.17-rc6.orig/drivers/scsi/lpfc/lpfc_init.c	2006-06-06 21:39:11.000000000 +0900
+++ linux-2.6.17-rc6/drivers/scsi/lpfc/lpfc_init.c	2006-06-06 21:56:56.000000000 +0900
@@ -1425,10 +1425,11 @@
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
@@ -1720,7 +1721,7 @@
 	phba->host = NULL;
 	scsi_host_put(host);
 out_release_regions:
-	pci_release_regions(pdev);
+	pci_release_selected_regions(pdev, bars);
 out_disable_device:
 	pci_disable_device(pdev);
 out:
@@ -1734,6 +1735,7 @@
 	struct Scsi_Host   *host = pci_get_drvdata(pdev);
 	struct lpfc_hba    *phba = (struct lpfc_hba *)host->hostdata;
 	unsigned long iflag;
+	int bars = pci_select_bars(pdev, IORESOURCE_MEM);
 
 	lpfc_free_sysfs_attr(phba);
 
@@ -1777,7 +1779,7 @@
 	iounmap(phba->ctrl_regs_memmap_p);
 	iounmap(phba->slim_memmap_p);
 
-	pci_release_regions(phba->pcidev);
+	pci_release_selected_regions(phba->pcidev, bars);
 	pci_disable_device(phba->pcidev);
 
 	idr_remove(&lpfc_hba_index, phba->brd_no);

