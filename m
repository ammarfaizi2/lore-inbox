Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVCDEf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVCDEf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVCDEeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 23:34:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13020 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262642AbVCDEJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 23:09:41 -0500
Message-ID: <4227DF76.3030401@pobox.com>
Date: Thu, 03 Mar 2005 23:09:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Sommrey <jo@sommrey.de>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [SATA] libata-dev queue updated
References: <3Ds62-5AS-3@gated-at.bofh.it> <200503022034.j22KYppm010967@bear.sommrey.de> <422641AF.8070309@pobox.com> <20050303193229.GA10265@sommrey.de>
In-Reply-To: <20050303193229.GA10265@sommrey.de>
Content-Type: multipart/mixed;
 boundary="------------090102050202040804000101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090102050202040804000101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Joerg Sommrey wrote:
> On Wed, Mar 02, 2005 at 05:43:59PM -0500, Jeff Garzik wrote:
> 
>>Joerg Sommrey wrote:
>>
>>>Jeff Garzik wrote:
>>>
>>>>Patch:
>>>>http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-rc5-bk4-libata-dev1.patch.bz2
>>>
>>>
>>>Still not usable here.  The same errors as before when backing up:
>>
>>Please try 2.6.11 without any patches.
> 
> Plain 2.6.11 doesn't work either.  All of 2.6.10-ac11, 2.6.11-rc5,
> 2.6.11-rc5 + 2.6.11-rc5-bk4-libata-dev1.patch and 2.6.11 fail with the
> same symptoms. 
> 
> Reverting to stable 2.6.10-ac8 :-)

Does reverting the attached patch in 2.6.11 (apply with patch -R) fix 
things?

	Jeff



--------------090102050202040804000101
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2005-03-01 23:39:08 -08:00
+++ b/drivers/scsi/sata_promise.c	2005-03-01 23:39:08 -08:00
@@ -156,10 +156,18 @@
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3574, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d75, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
+
 	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
+
 	{ }	/* terminate list */
 };
 
@@ -406,9 +414,11 @@
 		return IRQ_NONE;
 	}
 
-        spin_lock(&host_set->lock);
+	spin_lock(&host_set->lock);
 
-        for (i = 0; i < host_set->n_ports; i++) {
+	writel(mask, mmio_base + PDC_INT_SEQMASK);
+
+	for (i = 0; i < host_set->n_ports; i++) {
 		VPRINTK("port %u\n", i);
 		ap = host_set->ports[i];
 		tmp = mask & (1 << (i + 1));
@@ -546,6 +556,7 @@
 	unsigned long base;
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
@@ -560,8 +571,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -640,7 +653,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 

--------------090102050202040804000101--
