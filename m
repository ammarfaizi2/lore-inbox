Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbUCDM2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 07:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbUCDM2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 07:28:32 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:2205 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261858AbUCDM20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 07:28:26 -0500
Date: Thu, 4 Mar 2004 23:28:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: [PATCH] PPC64 iSeries_vio_dev cleanup
Message-Id: <20040304232804.1adfb224.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__4_Mar_2004_23_28_04_+1100_9sUEwlCIdT2JU7ak"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__4_Mar_2004_23_28_04_+1100_9sUEwlCIdT2JU7ak
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Linus,

This patch declares iSeries_vio_dev in an include file and includes it
where necessary.  It also fixes arch/ppc64/kernel/mf.c to use the
generic dma API with iSeries_vio_dev.

Please apply.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.4-rc2/arch/ppc64/kernel/iSeries_iommu.c 2.6.4-rc2.mf/arch/ppc64/kernel/iSeries_iommu.c
--- 2.6.4-rc2/arch/ppc64/kernel/iSeries_iommu.c	2004-03-04 18:24:45.000000000 +1100
+++ 2.6.4-rc2.mf/arch/ppc64/kernel/iSeries_iommu.c	2004-03-04 23:22:34.000000000 +1100
@@ -43,6 +43,7 @@
 #include <asm/iommu.h>
 #include <asm/pci-bridge.h>
 #include <asm/iSeries/iSeries_pci.h>
+#include <asm/iSeries/vio.h>
 
 #include <asm/machdep.h>
 
@@ -58,11 +59,6 @@
 static struct pci_dev _veth_dev = { .sysdata = &veth_dev_node };
 static struct pci_dev _vio_dev  = { .sysdata = &vio_dev_node, .dev.bus = &pci_bus_type  };
 
-/*
- * I wonder what the deal is with these.  Nobody uses them.  Why do they
- * exist? Why do we export them to modules? Why is this comment here, and
- * why didn't I just delete them?
- */
 struct pci_dev *iSeries_veth_dev = &_veth_dev;
 struct device *iSeries_vio_dev = &_vio_dev.dev;
 
diff -ruN 2.6.4-rc2/arch/ppc64/kernel/mf.c 2.6.4-rc2.mf/arch/ppc64/kernel/mf.c
--- 2.6.4-rc2/arch/ppc64/kernel/mf.c	2004-02-04 17:24:34.000000000 +1100
+++ 2.6.4-rc2.mf/arch/ppc64/kernel/mf.c	2004-03-04 23:22:34.000000000 +1100
@@ -38,10 +38,9 @@
 #include <asm/iSeries/ItSpCommArea.h>
 #include <asm/iSeries/iSeries_proc.h>
 #include <asm/uaccess.h>
-#include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/bcd.h>
-
-extern struct pci_dev *iSeries_vio_dev;
+#include <asm/iSeries/vio.h>
 
 /*
  * This is the structure layout for the Machine Facilites LPAR event
@@ -791,7 +790,8 @@
 {
 	struct VspCmdData myVspCmd;
 	dma_addr_t dma_addr = 0;
-	char *page = pci_alloc_consistent(iSeries_vio_dev, size, &dma_addr);
+	char *page = dma_alloc_coherent(iSeries_vio_dev, size, &dma_addr,
+			GFP_ATOMIC);
 
 	if (page == NULL) {
 		printk(KERN_ERR "mf.c: couldn't allocate memory to set command line\n");
@@ -809,7 +809,7 @@
 	mb();
 	(void)signal_vsp_instruction(&myVspCmd);
 
-	pci_free_consistent(iSeries_vio_dev, size, page, dma_addr);
+	dma_free_coherent(iSeries_vio_dev, size, page, dma_addr);
 }
 
 int mf_getCmdLine(char *cmdline, int *size, u64 side)
@@ -819,8 +819,8 @@
 	int len = *size;
 	dma_addr_t dma_addr;
 
-	dma_addr = pci_map_single(iSeries_vio_dev, cmdline, len,
-			PCI_DMA_FROMDEVICE);
+	dma_addr = dma_map_single(iSeries_vio_dev, cmdline, len,
+			DMA_FROM_DEVICE);
 	memset(cmdline, 0, len);
 	memset(&myVspCmd, 0, sizeof(myVspCmd));
 	myVspCmd.cmd = 33;
@@ -840,7 +840,7 @@
 #endif
 	}
 
-	pci_unmap_single(iSeries_vio_dev, dma_addr, *size, PCI_DMA_FROMDEVICE);
+	dma_unmap_single(iSeries_vio_dev, dma_addr, *size, DMA_FROM_DEVICE);
 
 	return len;
 }
@@ -851,7 +851,8 @@
 	struct VspCmdData myVspCmd;
 	int rc;
 	dma_addr_t dma_addr = 0;
-	char *page = pci_alloc_consistent(iSeries_vio_dev, size, &dma_addr);
+	char *page = dma_alloc_coherent(iSeries_vio_dev, size, &dma_addr,
+			GFP_ATOMIC);
 
 	if (page == NULL) {
 		printk(KERN_ERR "mf.c: couldn't allocate memory to set vmlinux chunk\n");
@@ -876,7 +877,7 @@
 			rc = -ENOMEM;
 	}
 
-	pci_free_consistent(iSeries_vio_dev, size, page, dma_addr);
+	dma_free_coherent(iSeries_vio_dev, size, page, dma_addr);
 
 	return rc;
 }
@@ -888,8 +889,8 @@
 	int len = *size;
 	dma_addr_t dma_addr;
 
-	dma_addr = pci_map_single(iSeries_vio_dev, buffer, len,
-			PCI_DMA_FROMDEVICE);
+	dma_addr = dma_map_single(iSeries_vio_dev, buffer, len,
+			DMA_FROM_DEVICE);
 	memset(buffer, 0, len);
 	memset(&myVspCmd, 0, sizeof(myVspCmd));
 	myVspCmd.cmd = 32;
@@ -907,7 +908,7 @@
 			rc = -ENOMEM;
 	}
 
-	pci_unmap_single(iSeries_vio_dev, dma_addr, len, PCI_DMA_FROMDEVICE);
+	dma_unmap_single(iSeries_vio_dev, dma_addr, len, DMA_FROM_DEVICE);
 
 	return rc;
 }
diff -ruN 2.6.4-rc2/arch/ppc64/kernel/viopath.c 2.6.4-rc2.mf/arch/ppc64/kernel/viopath.c
--- 2.6.4-rc2/arch/ppc64/kernel/viopath.c	2004-03-04 18:24:46.000000000 +1100
+++ 2.6.4-rc2.mf/arch/ppc64/kernel/viopath.c	2004-03-04 23:22:34.000000000 +1100
@@ -35,7 +35,6 @@
 #include <linux/vmalloc.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
-#include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/wait.h>
 
@@ -49,8 +48,6 @@
 #include <asm/iSeries/iSeries_proc.h>
 #include <asm/iSeries/vio.h>
 
-extern struct device *iSeries_vio_dev;
-
 /* Status of the path to each other partition in the system.
  * This is overkill, since we will only ever establish connections
  * to our hosting partition and the primary partition on the system.
diff -ruN 2.6.4-rc2/include/asm-ppc64/iSeries/vio.h 2.6.4-rc2.mf/include/asm-ppc64/iSeries/vio.h
--- 2.6.4-rc2/include/asm-ppc64/iSeries/vio.h	2004-03-04 18:25:15.000000000 +1100
+++ 2.6.4-rc2.mf/include/asm-ppc64/iSeries/vio.h	2004-03-04 23:22:34.000000000 +1100
@@ -127,4 +127,8 @@
 	viorc_openRejected = 0x0301
 };
 
+struct device;
+
+extern struct device *iSeries_vio_dev;
+
 #endif /* _ISERIES_VIO_H */

--Signature=_Thu__4_Mar_2004_23_28_04_+1100_9sUEwlCIdT2JU7ak
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARyDUFG47PeJeR58RAlKFAJwJ2jrv5YCDw6DrLJg6r37x9Mkh5gCgpZh8
sv0hwr/jD4Bm4y5IK3Fp/io=
=O0+C
-----END PGP SIGNATURE-----

--Signature=_Thu__4_Mar_2004_23_28_04_+1100_9sUEwlCIdT2JU7ak--
