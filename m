Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVBNBnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVBNBnw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 20:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVBNBnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 20:43:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40116 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261331AbVBNBnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 20:43:13 -0500
Message-ID: <4210021F.7060401@pobox.com>
Date: Sun, 13 Feb 2005 20:42:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: avoiding pci_disable_device()...
Content-Type: multipart/mixed;
 boundary="------------030809020703020302010906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030809020703020302010906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Currently, in almost every PCI driver, if pci_request_regions() fails -- 
indicating another driver is using the hardware -- then 
pci_disable_device() is called on the error path, disabling a device 
that another driver is using

To call this "rather rude" is an understatement :)

Fortunately, the ugliness is mitigated in large part by the PCI layer 
helping to make sure that no two drivers bind to the same PCI device. 
Thus, in the vast majority of cases, pci_request_regions() -should- be 
guaranteed to succeed.

However, there are oddball cases like mixed PCI/ISA devices (hello IDE) 
or cases where a driver refers a pci_dev other than the primary, where 
pci_request_regions() and request_regions() still matter.

As a result, I have committed the attached patch to libata-2.6.  In many 
cases, it is a "semantic fix", addressing the case

	* pci_request_regions() indicates hardware is in use
	* we rudely disable the in-use hardware

that would not occur in practice.

But better safe than sorry.  Code cuts cut-n-pasted all over the place.

I'm hoping one or two things will happen now:
* janitors fix up the other PCI drivers along these lines
* improve the PCI API so that pci_request_regions() is axiomatic



--------------030809020703020302010906
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

#
# ChangeSet
#   2005/02/13 19:58:07-05:00 jgarzik@pobox.com 
#   [libata] do not call pci_disable_device() for certain errors
#   
#   If PCI request regions fails, then someone else is using the
#   hardware we wish to use.  For that one case, calling pci_disable_device()
#   is rather rude.
# 
diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-02-13 19:58:50 -05:00
+++ b/drivers/scsi/ahci.c	2005-02-13 19:58:50 -05:00
@@ -940,6 +940,7 @@
 	unsigned long base;
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 	int rc;
 
 	VPRINTK("ENTER\n");
@@ -952,8 +953,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	pci_enable_intx(pdev);
 
@@ -1015,7 +1018,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2005-02-13 19:58:50 -05:00
+++ b/drivers/scsi/libata-core.c	2005-02-13 19:58:50 -05:00
@@ -3656,6 +3656,7 @@
 	struct ata_port_info *port[2];
 	u8 tmp8, mask;
 	unsigned int legacy_mode = 0;
+	int disable_dev_on_err = 1;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -3686,8 +3687,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		disable_dev_on_err = 0;
 		goto err_out;
+	}
 
 	if (legacy_mode) {
 		if (!request_region(0x1f0, 8, "libata")) {
@@ -3697,8 +3700,10 @@
 			conflict = ____request_resource(&ioport_resource, &res);
 			if (!strcmp(conflict->name, "libata"))
 				legacy_mode |= (1 << 0);
-			else
+			else {
+				disable_dev_on_err = 0;
 				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
+			}
 		} else
 			legacy_mode |= (1 << 0);
 
@@ -3709,8 +3714,10 @@
 			conflict = ____request_resource(&ioport_resource, &res);
 			if (!strcmp(conflict->name, "libata"))
 				legacy_mode |= (1 << 1);
-			else
+			else {
+				disable_dev_on_err = 0;
 				printk(KERN_WARNING "ata: 0x170 IDE port busy\n");
+			}
 		} else
 			legacy_mode |= (1 << 1);
 	}
@@ -3763,7 +3770,8 @@
 		release_region(0x170, 8);
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (disable_dev_on_err)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2005-02-13 19:58:50 -05:00
+++ b/drivers/scsi/sata_nv.c	2005-02-13 19:58:50 -05:00
@@ -332,6 +332,7 @@
 	struct nv_host *host;
 	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
+	int pci_dev_busy = 0;
 	int rc;
 	u32 bar;
 
@@ -350,8 +351,10 @@
 		goto err_out;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out_disable;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -427,7 +430,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out_disable:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 err_out:
 	return rc;
 }
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2005-02-13 19:58:50 -05:00
+++ b/drivers/scsi/sata_promise.c	2005-02-13 19:58:50 -05:00
@@ -556,6 +556,7 @@
 	unsigned long base;
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
@@ -570,8 +571,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -650,7 +653,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2005-02-13 19:58:50 -05:00
+++ b/drivers/scsi/sata_sil.c	2005-02-13 19:58:50 -05:00
@@ -336,6 +336,7 @@
 	void *mmio_base;
 	int rc;
 	unsigned int i;
+	int pci_dev_busy = 0;
 	u32 tmp, irq_mask;
 
 	if (!printed_version++)
@@ -350,8 +351,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -438,7 +441,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2005-02-13 19:58:50 -05:00
+++ b/drivers/scsi/sata_sis.c	2005-02-13 19:58:50 -05:00
@@ -200,14 +200,17 @@
 	int rc;
 	u32 genctl;
 	struct ata_port_info *ppi;
+	int pci_dev_busy = 0;
 
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -259,7 +262,8 @@
 	pci_release_regions(pdev);
 
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 
 }
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2005-02-13 19:58:50 -05:00
+++ b/drivers/scsi/sata_svw.c	2005-02-13 19:58:50 -05:00
@@ -338,6 +338,7 @@
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
 	void *mmio_base;
+	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
@@ -359,8 +360,10 @@
 
 	/* Request PCI regions */
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -433,7 +436,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2005-02-13 19:58:50 -05:00
+++ b/drivers/scsi/sata_sx4.c	2005-02-13 19:58:50 -05:00
@@ -1366,6 +1366,7 @@
 	void *mmio_base, *dimm_mmio = NULL;
 	struct pdc_host_priv *hpriv = NULL;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
@@ -1380,8 +1381,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -1471,7 +1474,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c	2005-02-13 19:58:50 -05:00
+++ b/drivers/scsi/sata_uli.c	2005-02-13 19:58:50 -05:00
@@ -185,14 +185,17 @@
 	struct ata_port_info *ppi;
 	int rc;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int pci_dev_busy = 0;
 
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -260,7 +263,8 @@
 	pci_release_regions(pdev);
 
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 
 }
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2005-02-13 19:58:50 -05:00
+++ b/drivers/scsi/sata_via.c	2005-02-13 19:58:50 -05:00
@@ -290,6 +290,7 @@
 	struct ata_probe_ent *probe_ent;
 	int board_id = (int) ent->driver_data;
 	const int *bar_sizes;
+	int pci_dev_busy = 0;
 	u8 tmp8;
 
 	if (!printed_version++)
@@ -300,8 +301,10 @@
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	if (board_id == vt6420) {
 		pci_read_config_byte(pdev, SATA_PATA_SHARING, &tmp8);
@@ -360,7 +363,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2005-02-13 19:58:50 -05:00
+++ b/drivers/scsi/sata_vsc.c	2005-02-13 19:58:50 -05:00
@@ -255,6 +255,7 @@
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
+	int pci_dev_busy = 0;
 	void *mmio_base;
 	int rc;
 
@@ -274,8 +275,10 @@
 	}
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
+	if (rc) {
+		pci_dev_busy = 1;
 		goto err_out;
+	}
 
 	/*
 	 * Use 32 bit DMA mask, because 64 bit address support is poor.
@@ -352,7 +355,8 @@
 err_out_regions:
 	pci_release_regions(pdev);
 err_out:
-	pci_disable_device(pdev);
+	if (!pci_dev_busy)
+		pci_disable_device(pdev);
 	return rc;
 }
 

--------------030809020703020302010906--
