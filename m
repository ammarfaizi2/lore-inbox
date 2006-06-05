Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751060AbWFEMnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWFEMnh (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWFEMnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:43:37 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54990 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751041AbWFEMng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:43:36 -0400
Message-ID: <4484263C.1030508@jp.fujitsu.com>
Date: Mon, 05 Jun 2006 21:40:28 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, Greg KH <greg@kroah.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Rajesh Shah <rajesh.shah@intel.com>,
        Grant Grundler <grundler@parisc-linux.org>,
        "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
        linux-pci@atrey.karlin.mff.cuni.cz
Subject: [BUG][PATCH 2.6.17-rc5-mm3] bugfix: PCI legacy I/O port free driver
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com>
In-Reply-To: <447FA920.9060509@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Greg,

Here is a patche to fix a bug that pci_request_regions() doesn't work
when it is called after pci_disable_device(), which was reported at:

    http://marc.theaimsgroup.com/?l=linux-kernel&m=114914585213991&w=2

This bug is introduced by the following "PCI legacy I/O port free
driver" patches currently in 2.6.17-rc5-mm3.

    o gregkh-pci-pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code.patch
    o gregkh-pci-pci-legacy-i-o-port-free-driver-make-emulex-lpfc-driver-legacy-i-o-port-free.patch
    o gregkh-pci-pci-legacy-i-o-port-free-driver-make-intel-e1000-driver-legacy-i-o-port-free.patch
    o gregkh-pci-pci-legacy-i-o-port-free-driver-update-documentation-pci_txt.patch

This patch is against 2.6.17-rc5-mm3. Please see the header of the
patch about details.

If reposting the fixed version of PCI legacy I/O port free driver
patches against the latest Linus tree are preferred rather than this
patch, please let me know.

Thanks,
Kenji Kaneshige


This patch fixes the bug that pci_release_regions() doesn't work when
it is called after pci_disable_device(), which is reported at:

    http://marc.theaimsgroup.com/?l=linux-kernel&m=114914585213991&w=2

The root cause of this bug is "PCI legacy I/O port free driver"
patches had been implemented with a wrong assumption that
pci_release_regions() is called before pci_disable_device(), while it
should be called _after_ pci_disable_device().

To fix the bug, this patch makes the follwoing changes:

    o Changed pci_request_regions()/pci_release_regions() not to refer
      bars_enabled bitmask.

    o Introduce new pci_request_selected_regions() and
      pci_release_selected_regions() for PCI legacy I/O port free
      drivers to request/release only the selected regions.

    o Added the description about pci_request_selected_regions() and
      pci_release_selected_regions().

    o Changed intel e1000 driver to use pci_request_selected_regions()
      and pci_release_selected_regions().

    o Changed Emulex lpfc driver to use pci_request_selected_regions()
      and pci_release_selected_regions().

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 Documentation/pci.txt          |    5 ++
 drivers/net/e1000/e1000_main.c |    7 ++-
 drivers/pci/pci.c              |   77 ++++++++++++++++++++++++-----------------
 drivers/scsi/lpfc/lpfc_init.c  |    7 ++-
 include/linux/pci.h            |    2 +
 5 files changed, 60 insertions(+), 38 deletions(-)

Index: linux-2.6.17-rc5-mm3/Documentation/pci.txt
===================================================================
--- linux-2.6.17-rc5-mm3.orig/Documentation/pci.txt	2006-06-05 11:26:27.000000000 +0900
+++ linux-2.6.17-rc5-mm3/Documentation/pci.txt	2006-06-05 18:31:41.000000000 +0900
@@ -311,7 +311,10 @@
 If your PCI device driver doesn't need I/O port resources assigned to
 I/O Port BARs, you should use pci_enable_device_bars() instead of
 pci_enable_device() in order not to enable I/O port regions for the
-corresponding devices.
+corresponding devices. In addition, you should use
+pci_request_selected_regions()/pci_release_selected_regions() instead
+of pci_request_regions()/pci_release_regions() in order not to
+request/release I/O port regions for the corresponding devices.
 
 [1] Some systems support 64KB I/O port space per PCI segment.
 [2] Some PCI-to-PCI bridges support optional 1KB aligned I/O base.
Index: linux-2.6.17-rc5-mm3/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/drivers/net/e1000/e1000_main.c	2006-06-05 11:26:28.000000000 +0900
+++ linux-2.6.17-rc5-mm3/drivers/net/e1000/e1000_main.c	2006-06-05 18:31:47.000000000 +0900
@@ -616,7 +616,8 @@
 		pci_using_dac = 0;
 	}
 
-	if ((err = pci_request_regions(pdev, e1000_driver_name)))
+	err = pci_request_selected_regions(pdev, bars, e1000_driver_name);
+	if (err)
 		return err;
 
 	pci_set_master(pdev);
@@ -866,7 +867,7 @@
 err_ioremap:
 	free_netdev(netdev);
 err_alloc_etherdev:
-	pci_release_regions(pdev);
+	pci_release_selected_regions(pdev, bars);
 	return err;
 }
 
@@ -921,7 +922,7 @@
 #endif
 
 	iounmap(adapter->hw.hw_addr);
-	pci_release_regions(pdev);
+	pci_release_selected_regions(pdev, adapter->bars);
 
 	free_netdev(netdev);
 
Index: linux-2.6.17-rc5-mm3/drivers/pci/pci.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/drivers/pci/pci.c	2006-06-05 11:26:28.000000000 +0900
+++ linux-2.6.17-rc5-mm3/drivers/pci/pci.c	2006-06-05 18:31:26.000000000 +0900
@@ -648,12 +648,6 @@
 {
 	if (pci_resource_len(pdev, bar) == 0)
 		return;
-	if (!(pdev->bars_enabled & (1 << bar))) {
-		dev_warn(&pdev->dev,
-			 "Trying to release region #%d that is not enabled\n",
-			 bar + 1);
-		return;
-	}
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
 		release_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
@@ -680,12 +674,7 @@
 {
 	if (pci_resource_len(pdev, bar) == 0)
 		return 0;
-	if (!(pdev->bars_enabled & (1 << bar))) {
-		dev_warn(&pdev->dev,
-			 "Trying to request region #%d that is not enabled\n",
-			 bar + 1);
-		goto err_out;
-	}
+
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
 		if (!request_region(pci_resource_start(pdev, bar),
 			    pci_resource_len(pdev, bar), res_name))
@@ -710,6 +699,47 @@
 	return -EBUSY;
 }
 
+/**
+ * pci_release_selected_regions - Release selected PCI I/O and memory resources
+ * @pdev: PCI device whose resources were previously reserved
+ * @bars: Bitmask of BARs to be released
+ *
+ * Release selected PCI I/O and memory resources previously reserved.
+ * Call this function only after all use of the PCI regions has ceased.
+ */
+void pci_release_selected_regions(struct pci_dev *pdev, int bars)
+{
+	int i;
+
+	for (i = 0; i < 6; i++)
+		if (bars & (1 << i))
+			pci_release_region(pdev, i);
+}
+
+/**
+ * pci_request_selected_regions - Reserve selected PCI I/O and memory resources
+ * @pdev: PCI device whose resources are to be reserved
+ * @bars: Bitmask of BARs to be requested
+ * @res_name: Name to be associated with resource
+ */
+int pci_request_selected_regions(struct pci_dev *pdev, int bars,
+				 const char *res_name)
+{
+	int i;
+
+	for (i = 0; i < 6; i++)
+		if (bars & (1 << i))
+			if(pci_request_region(pdev, i, res_name))
+				goto err_out;
+	return 0;
+
+err_out:
+	while(--i >= 0)
+		if (bars & (1 << i))
+			pci_release_region(pdev, i);
+
+	return -EBUSY;
+}
 
 /**
  *	pci_release_regions - Release reserved PCI I/O and memory resources
@@ -722,11 +752,7 @@
 
 void pci_release_regions(struct pci_dev *pdev)
 {
-	int i;
-	
-	for (i = 0; i < 6; i++)
-		if (pdev->bars_enabled & (1 << i))
-			pci_release_region(pdev, i);
+	pci_release_selected_regions(pdev, (1 << 6) - 1);
 }
 
 /**
@@ -744,20 +770,7 @@
  */
 int pci_request_regions(struct pci_dev *pdev, const char *res_name)
 {
-	int i;
-	
-	for (i = 0; i < 6; i++)
-		if (pdev->bars_enabled & (1 << i))
-			if(pci_request_region(pdev, i, res_name))
-				goto err_out;
-	return 0;
-
-err_out:
-	while(--i >= 0)
-		if (pdev->bars_enabled & (1 << i))
-			pci_release_region(pdev, i);
-		
-	return -EBUSY;
+	return pci_request_selected_regions(pdev, ((1 << 6) - 1), res_name);
 }
 
 /**
@@ -995,6 +1008,8 @@
 EXPORT_SYMBOL(pci_request_regions);
 EXPORT_SYMBOL(pci_release_region);
 EXPORT_SYMBOL(pci_request_region);
+EXPORT_SYMBOL(pci_release_selected_regions);
+EXPORT_SYMBOL(pci_request_selected_regions);
 EXPORT_SYMBOL(pci_set_master);
 EXPORT_SYMBOL(pci_set_mwi);
 EXPORT_SYMBOL(pci_clear_mwi);
Index: linux-2.6.17-rc5-mm3/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/drivers/scsi/lpfc/lpfc_init.c	2006-06-05 11:26:29.000000000 +0900
+++ linux-2.6.17-rc5-mm3/drivers/scsi/lpfc/lpfc_init.c	2006-06-05 18:31:50.000000000 +0900
@@ -1429,7 +1429,7 @@
 
 	if (pci_enable_device_bars(pdev, bars))
 		goto out;
-	if (pci_request_regions(pdev, LPFC_DRIVER_NAME))
+	if (pci_request_selected_regions(pdev, bars, LPFC_DRIVER_NAME))
 		goto out_disable_device;
 
 	host = scsi_host_alloc(&lpfc_template, sizeof (struct lpfc_hba));
@@ -1721,7 +1721,7 @@
 	phba->host = NULL;
 	scsi_host_put(host);
 out_release_regions:
-	pci_release_regions(pdev);
+	pci_release_selected_regions(pdev, bars);
 out_disable_device:
 	pci_disable_device(pdev);
 out:
@@ -1735,6 +1735,7 @@
 	struct Scsi_Host   *host = pci_get_drvdata(pdev);
 	struct lpfc_hba    *phba = (struct lpfc_hba *)host->hostdata;
 	unsigned long iflag;
+	int bars = pci_select_bars(pdev, IORESOURCE_MEM);
 
 	lpfc_free_sysfs_attr(phba);
 
@@ -1778,7 +1779,7 @@
 	iounmap(phba->ctrl_regs_memmap_p);
 	iounmap(phba->slim_memmap_p);
 
-	pci_release_regions(phba->pcidev);
+	pci_release_selected_regions(phba->pcidev, bars);
 	pci_disable_device(phba->pcidev);
 
 	idr_remove(&lpfc_hba_index, phba->brd_no);
Index: linux-2.6.17-rc5-mm3/include/linux/pci.h
===================================================================
--- linux-2.6.17-rc5-mm3.orig/include/linux/pci.h	2006-06-05 11:26:31.000000000 +0900
+++ linux-2.6.17-rc5-mm3/include/linux/pci.h	2006-06-05 18:31:26.000000000 +0900
@@ -531,6 +531,8 @@
 void pci_release_regions(struct pci_dev *);
 int pci_request_region(struct pci_dev *, int, const char *);
 void pci_release_region(struct pci_dev *, int);
+int pci_request_selected_regions(struct pci_dev *, int, const char *);
+void pci_release_selected_regions(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
 int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,

