Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422935AbWLBLZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422935AbWLBLZl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423351AbWLBLZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:25:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:575 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1162958AbWLBLZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:25:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=qvGsMmawLBi1zE9k/VOq2zxmKUplXiQ9jZv46z9Z74KqjC+C0f3O60Cbs3IgNz27F8z/+PCTmEIXdvnntDdA8WX/RRfmGHKzdRkJuiPOA9b/D9qEwyq8aLMxAYL8k7XUhek4AZWeK4X1pKgy/f3oO0uxRZBLGGEkO7CcolqL3xg=
Subject: [PATCH 2.6.19] powerpc: replace kmalloc+memset with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: paulus@samba.org, trivial@kernel.org
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:26:57 +0200
Message-Id: <1165058817.4523.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc6_orig/arch/powerpc/kernel/ibmebus.c linux-2.6.19-rc6/arch/powerpc/kernel/ibmebus.c
--- linux-2.6.19-rc6_orig/arch/powerpc/kernel/ibmebus.c	2006-11-22 20:30:04.000000000 +0200
+++ linux-2.6.19-rc6/arch/powerpc/kernel/ibmebus.c	2006-11-24 13:34:30.000000000 +0200
@@ -210,11 +210,10 @@ static struct ibmebus_dev* __devinit ibm
 		return NULL;
 	}
 
-	dev = kmalloc(sizeof(struct ibmebus_dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(struct ibmebus_dev), GFP_KERNEL);
 	if (!dev) {
 		return NULL;
 	}
-	memset(dev, 0, sizeof(struct ibmebus_dev));
 
 	dev->ofdev.node = of_node_get(dn);
        
diff -rubp linux-2.6.19-rc6_orig/arch/powerpc/kernel/of_device.c linux-2.6.19-rc6/arch/powerpc/kernel/of_device.c
--- linux-2.6.19-rc6_orig/arch/powerpc/kernel/of_device.c	2006-11-22 20:30:04.000000000 +0200
+++ linux-2.6.19-rc6/arch/powerpc/kernel/of_device.c	2006-11-24 13:34:30.000000000 +0200
@@ -214,10 +214,9 @@ struct of_device* of_platform_device_cre
 {
 	struct of_device *dev;
 
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
-	memset(dev, 0, sizeof(*dev));
 
 	dev->node = of_node_get(np);
 	dev->dma_mask = 0xffffffffUL;
diff -rubp linux-2.6.19-rc6_orig/arch/powerpc/kernel/pci_64.c linux-2.6.19-rc6/arch/powerpc/kernel/pci_64.c
--- linux-2.6.19-rc6_orig/arch/powerpc/kernel/pci_64.c	2006-11-22 20:30:04.000000000 +0200
+++ linux-2.6.19-rc6/arch/powerpc/kernel/pci_64.c	2006-11-24 13:34:30.000000000 +0200
@@ -329,7 +329,7 @@ struct pci_dev *of_create_pci_dev(struct
 	struct pci_dev *dev;
 	const char *type;
 
-	dev = kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(struct pci_dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
 	type = get_property(node, "device_type", NULL);
@@ -338,7 +338,6 @@ struct pci_dev *of_create_pci_dev(struct
 
 	DBG("    create device, devfn: %x, type: %s\n", devfn, type);
 
-	memset(dev, 0, sizeof(struct pci_dev));
 	dev->bus = bus;
 	dev->sysdata = node;
 	dev->dev.parent = bus->bridge;
diff -rubp linux-2.6.19-rc6_orig/arch/powerpc/kernel/rtas_flash.c linux-2.6.19-rc6/arch/powerpc/kernel/rtas_flash.c
--- linux-2.6.19-rc6_orig/arch/powerpc/kernel/rtas_flash.c	2006-11-22 20:30:04.000000000 +0200
+++ linux-2.6.19-rc6/arch/powerpc/kernel/rtas_flash.c	2006-11-24 13:34:30.000000000 +0200
@@ -681,14 +681,12 @@ static int initialize_flash_pde_data(con
 	int *status;
 	int token;
 
-	dp->data = kmalloc(buf_size, GFP_KERNEL);
+	dp->data = kzalloc(buf_size, GFP_KERNEL);
 	if (dp->data == NULL) {
 		remove_flash_pde(dp);
 		return -ENOMEM;
 	}
 
-	memset(dp->data, 0, buf_size);
-
 	/*
 	 * This code assumes that the status int is the first member of the
 	 * struct 
diff -rubp linux-2.6.19-rc6_orig/arch/powerpc/kernel/smp-tbsync.c linux-2.6.19-rc6/arch/powerpc/kernel/smp-tbsync.c
--- linux-2.6.19-rc6_orig/arch/powerpc/kernel/smp-tbsync.c	2006-11-22 20:30:04.000000000 +0200
+++ linux-2.6.19-rc6/arch/powerpc/kernel/smp-tbsync.c	2006-11-24 13:34:30.000000000 +0200
@@ -116,8 +116,7 @@ void __devinit smp_generic_give_timebase
 	printk("Synchronizing timebase\n");
 
 	/* if this fails then this kernel won't work anyway... */
-	tbsync = kmalloc( sizeof(*tbsync), GFP_KERNEL );
-	memset( tbsync, 0, sizeof(*tbsync) );
+	tbsync = kzalloc( sizeof(*tbsync), GFP_KERNEL );
 	mb();
 	running = 1;
 
diff -rubp linux-2.6.19-rc6_orig/arch/powerpc/platforms/iseries/iommu.c linux-2.6.19-rc6/arch/powerpc/platforms/iseries/iommu.c
--- linux-2.6.19-rc6_orig/arch/powerpc/platforms/iseries/iommu.c	2006-11-22 20:30:05.000000000 +0200
+++ linux-2.6.19-rc6/arch/powerpc/platforms/iseries/iommu.c	2006-11-24 13:34:30.000000000 +0200
@@ -114,12 +114,10 @@ void iommu_table_getparms_iSeries(unsign
 {
 	struct iommu_table_cb *parms;
 
-	parms = kmalloc(sizeof(*parms), GFP_KERNEL);
+	parms = kzalloc(sizeof(*parms), GFP_KERNEL);
 	if (parms == NULL)
 		panic("PCI_DMA: TCE Table Allocation failed.");
 
-	memset(parms, 0, sizeof(*parms));
-
 	parms->itc_busno = busno;
 	parms->itc_slotno = slotno;
 	parms->itc_virtbus = virtbus;
diff -rubp linux-2.6.19-rc6_orig/arch/powerpc/platforms/iseries/viopath.c linux-2.6.19-rc6/arch/powerpc/platforms/iseries/viopath.c
--- linux-2.6.19-rc6_orig/arch/powerpc/platforms/iseries/viopath.c	2006-11-22 20:30:05.000000000 +0200
+++ linux-2.6.19-rc6/arch/powerpc/platforms/iseries/viopath.c	2006-11-24 13:34:30.000000000 +0200
@@ -119,10 +119,9 @@ static int proc_viopath_show(struct seq_
 	struct device_node *node;
 	const char *sysid;
 
-	buf = kmalloc(HW_PAGE_SIZE, GFP_KERNEL);
+	buf = kzalloc(HW_PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
 		return 0;
-	memset(buf, 0, HW_PAGE_SIZE);
 
 	handle = dma_map_single(iSeries_vio_dev, buf, HW_PAGE_SIZE,
 				DMA_FROM_DEVICE);
diff -rubp linux-2.6.19-rc6_orig/arch/powerpc/platforms/pseries/reconfig.c linux-2.6.19-rc6/arch/powerpc/platforms/pseries/reconfig.c
--- linux-2.6.19-rc6_orig/arch/powerpc/platforms/pseries/reconfig.c	2006-11-22 20:30:05.000000000 +0200
+++ linux-2.6.19-rc6/arch/powerpc/platforms/pseries/reconfig.c	2006-11-24 13:34:30.000000000 +0200
@@ -268,11 +268,10 @@ static char * parse_next_property(char *
 static struct property *new_property(const char *name, const int length,
 				     const unsigned char *value, struct property *last)
 {
-	struct property *new = kmalloc(sizeof(*new), GFP_KERNEL);
+	struct property *new = kzalloc(sizeof(*new), GFP_KERNEL);
 
 	if (!new)
 		return NULL;
-	memset(new, 0, sizeof(*new));
 
 	if (!(new->name = kmalloc(strlen(name) + 1, GFP_KERNEL)))
 		goto cleanup;
diff -rubp linux-2.6.19-rc6_orig/arch/powerpc/sysdev/qe_lib/ucc_fast.c linux-2.6.19-rc6/arch/powerpc/sysdev/qe_lib/ucc_fast.c
--- linux-2.6.19-rc6_orig/arch/powerpc/sysdev/qe_lib/ucc_fast.c	2006-11-22 20:30:05.000000000 +0200
+++ linux-2.6.19-rc6/arch/powerpc/sysdev/qe_lib/ucc_fast.c	2006-11-24 13:34:30.000000000 +0200
@@ -216,14 +216,12 @@ int ucc_fast_init(struct ucc_fast_info *
 		return -EINVAL;
 	}
 
-	uccf = (struct ucc_fast_private *)
-		 kmalloc(sizeof(struct ucc_fast_private), GFP_KERNEL);
+	uccf = kzalloc(sizeof(struct ucc_fast_private), GFP_KERNEL);
 	if (!uccf) {
 		uccf_err
 		    ("ucc_fast_init: No memory for UCC slow data structure!");
 		return -ENOMEM;
 	}
-	memset(uccf, 0, sizeof(struct ucc_fast_private));
 
 	/* Fill fast UCC structure */
 	uccf->uf_info = uf_info;
diff -rubp linux-2.6.19-rc6_orig/arch/powerpc/sysdev/qe_lib/ucc_slow.c linux-2.6.19-rc6/arch/powerpc/sysdev/qe_lib/ucc_slow.c
--- linux-2.6.19-rc6_orig/arch/powerpc/sysdev/qe_lib/ucc_slow.c	2006-11-22 20:30:05.000000000 +0200
+++ linux-2.6.19-rc6/arch/powerpc/sysdev/qe_lib/ucc_slow.c	2006-11-24 13:34:30.000000000 +0200
@@ -168,14 +168,12 @@ int ucc_slow_init(struct ucc_slow_info *
 		return -EINVAL;
 	}
 
-	uccs = (struct ucc_slow_private *)
-		kmalloc(sizeof(struct ucc_slow_private), GFP_KERNEL);
+	uccs = kzalloc(sizeof(struct ucc_slow_private), GFP_KERNEL);
 	if (!uccs) {
 		uccs_err
 		    ("ucc_slow_init: No memory for UCC slow data structure!");
 		return -ENOMEM;
 	}
-	memset(uccs, 0, sizeof(struct ucc_slow_private));
 
 	/* Fill slow UCC structure */
 	uccs->us_info = us_info;



