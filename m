Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTLaQNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 11:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbTLaQNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 11:13:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:229 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265176AbTLaQNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 11:13:02 -0500
Message-ID: <3FF2F57A.80801@pobox.com>
Date: Wed, 31 Dec 2003 11:12:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] pci_set_dac helper
Content-Type: multipart/mixed;
 boundary="------------050305000904070708020100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050305000904070708020100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


It seems to me like a lot of drivers wind up getting their 
pci_set_dma_mask stuff wrong, occasionally in subtle ways.  So, I 
created a "give me 64-bit PCI DMA" helper function.

The attached patch demonstrates its use in tg3, from which the logic 
originated.  It also fixes a tiny bug in tg3, whereby it might return 
zero on error (rather than -EFOO) if the pci_set_dma_mask succeeds but 
pci_set_consistent_dma_mask fails.



--------------050305000904070708020100
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/net/tg3.c 1.112 vs edited =====
--- 1.112/drivers/net/tg3.c	Thu Nov 20 12:46:05 2003
+++ edited/drivers/net/tg3.c	Wed Dec 31 11:06:43 2003
@@ -7493,7 +7493,8 @@
 	unsigned long tg3reg_base, tg3reg_len;
 	struct net_device *dev;
 	struct tg3 *tp;
-	int i, err, pci_using_dac, pm_cap;
+	int i, err, pm_cap;
+	u32 dac_flags;
 
 	if (tg3_version_printed++ == 0)
 		printk(KERN_INFO "%s", version);
@@ -7530,21 +7531,16 @@
 	}
 
 	/* Configure DMA attributes. */
-	if (!pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
-		pci_using_dac = 1;
-		if (pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL)) {
-			printk(KERN_ERR PFX "Unable to obtain 64 bit DMA "
-			       "for consistent allocations\n");
-			goto err_out_free_res;
-		}
-	} else {
-		err = pci_set_dma_mask(pdev, 0xffffffffULL);
-		if (err) {
-			printk(KERN_ERR PFX "No usable DMA configuration, "
-			       "aborting.\n");
-			goto err_out_free_res;
-		}
-		pci_using_dac = 0;
+	dac_flags = 0;
+	err = pci_set_dac(pdev, &dac_flags);
+	if (err)
+		goto err_out_free_res;
+
+	if ((dac_flags & (PCI_DAC_EN | PCI_DAC_CONS_EN)) == PCI_DAC_EN) {
+		printk(KERN_ERR PFX "Unable to obtain 64 bit DMA "
+		       "for consistent allocations\n");
+		err = -EIO;
+		goto err_out_free_res;
 	}
 
 	tg3reg_base = pci_resource_start(pdev, 0);
@@ -7560,7 +7556,7 @@
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-	if (pci_using_dac)
+	if (dac_flags)
 		dev->features |= NETIF_F_HIGHDMA;
 #if TG3_VLAN_TAG_USED
 	dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
===== drivers/pci/pci.c 1.60 vs edited =====
--- 1.60/drivers/pci/pci.c	Sun Oct  5 04:07:55 2003
+++ edited/drivers/pci/pci.c	Wed Dec 31 11:00:44 2003
@@ -713,7 +713,32 @@
 
 	return 0;
 }
-     
+
+int
+pci_set_dac(struct pci_dev *dev, u32 *flags_out)
+{
+	int err = 0;
+	u32 flags = 0;
+
+	if (!pci_set_dma_mask(dev, 0xffffffffffffffffULL)) {
+		flags |= PCI_DAC_EN;
+		if (pci_set_consistent_dma_mask(dev, 0xffffffffffffffffULL))
+			printk(KERN_WARNING
+			       "PCI(%s): Unable to obtain 64 bit DMA "
+			       "for consistent allocations\n", pci_name(dev));
+		else
+			flags |= PCI_DAC_CONS_EN;
+	} else {
+		err = pci_set_dma_mask(dev, 0xffffffffULL);
+		if (err)
+			printk(KERN_ERR "PCI(%s): No usable DMA configuration",
+			       pci_name(dev));
+	}
+
+	*flags_out = flags;
+	return err;
+}
+
 static int __devinit pci_init(void)
 {
 	struct pci_dev *dev = NULL;
@@ -765,6 +790,7 @@
 EXPORT_SYMBOL(pci_clear_mwi);
 EXPORT_SYMBOL(pci_set_dma_mask);
 EXPORT_SYMBOL(pci_dac_set_dma_mask);
+EXPORT_SYMBOL(pci_set_dac);
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
===== include/linux/pci.h 1.109 vs edited =====
--- 1.109/include/linux/pci.h	Mon Dec 29 16:37:23 2003
+++ edited/include/linux/pci.h	Wed Dec 31 10:54:16 2003
@@ -340,6 +340,10 @@
 #define PCIIOC_MMAP_IS_MEM	(PCIIOC_BASE | 0x02)	/* Set mmap state to MEM space. */
 #define PCIIOC_WRITE_COMBINE	(PCIIOC_BASE | 0x03)	/* Enable/disable write-combining. */
 
+/* pci_set_dac flags */
+#define PCI_DAC_EN		(1 << 0)
+#define PCI_DAC_CONS_EN		(1 << 1)
+
 #ifdef __KERNEL__
 
 #include <linux/types.h>
@@ -653,6 +657,8 @@
 void pci_clear_mwi(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
+int pci_set_dac(struct pci_dev *dev, u32 *flags);
+
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
 
@@ -759,6 +765,8 @@
 static inline int pci_module_init(struct pci_driver *drv) { return -ENODEV; }
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
 static inline int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
+static inline int pci_set_dac(struct pci_dev *dev, u32 *flags) { return -EIO; }
+
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }

--------------050305000904070708020100--

