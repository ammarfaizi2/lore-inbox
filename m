Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267799AbTAMRpd>; Mon, 13 Jan 2003 12:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbTAMRpd>; Mon, 13 Jan 2003 12:45:33 -0500
Received: from host194.steeleye.com ([66.206.164.34]:39181 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267799AbTAMRp3>; Mon, 13 Jan 2003 12:45:29 -0500
Message-Id: <200301131754.h0DHsB802889@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@SteelEye.com, rmk@arm.linux.org.uk
Subject: [PATCH] 4 patches to allow dma_alloc_coherent to use GFP_ flags
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_17438245270"
Date: Mon, 13 Jan 2003 12:54:11 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_17438245270
Content-Type: text/plain; charset=us-ascii

The attached are four patches that update the API, implementing architecture 
and consumers to supply GFP_ flags for dma_alloc_[non]coherent.

They are:

dma-alloc-1.955: core changes
dma-alloc-1.956: x86 arch implementation
dma-alloc-1.957: arm arch implementation (minor header change)
dma-alloc-1.958: driver updates

James


--==_Exmh_17438245270
Content-Type: text/plain ; name="dma-alloc-1.955.diff"; charset=us-ascii
Content-Description: dma-alloc-1.955.diff
Content-Disposition: attachment; filename="dma-alloc-1.955.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.954   -> 1.955  
#	include/asm-generic/pci-dma-compat.h	1.2     -> 1.3    
#	Documentation/DMA-API.txt	1.1     -> 1.2    
#	include/asm-generic/dma-mapping.h	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/13	jejb@raven.il.steeleye.com	1.955
# Update the generic DMA API to take GFP_ flags on allocation
# 
# dma_alloc_[non]coherent now takes the GFP_ flags as the last argument.
# The flags passed in may not interfere with the memory zone.
# --------------------------------------------
#
diff -Nru a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
--- a/Documentation/DMA-API.txt	Mon Jan 13 11:06:42 2003
+++ b/Documentation/DMA-API.txt	Mon Jan 13 11:06:42 2003
@@ -22,7 +22,7 @@
 
 void *
 dma_alloc_coherent(struct device *dev, size_t size,
-			     dma_addr_t *dma_handle)
+			     dma_addr_t *dma_handle, int flag)
 void *
 pci_alloc_consistent(struct pci_dev *dev, size_t size,
 			     dma_addr_t *dma_handle)
@@ -43,6 +43,12 @@
 minimum allocation length may be as big as a page, so you should
 consolidate your requests for consistent memory as much as possible.
 
+The flag parameter (dma_alloc_coherent only) allows the caller to
+specify the GFP_ flags (see kmalloc) for the allocation (the
+implementation may chose to ignore flags that affect the location of
+the returned memory, like GFP_DMA).  For pci_alloc_consistent, you
+must assume GFP_ATOMIC behaviour.
+
 void
 dma_free_coherent(struct device *dev, size_t size, void *cpu_addr
 			   dma_addr_t dma_handle)
@@ -261,7 +267,7 @@
 
 void *
 dma_alloc_noncoherent(struct device *dev, size_t size,
-			       dma_addr_t *dma_handle)
+			       dma_addr_t *dma_handle, int flag)
 
 Identical to dma_alloc_coherent() except that the platform will
 choose to return either consistent or non-consistent memory as it sees
diff -Nru a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
--- a/include/asm-generic/dma-mapping.h	Mon Jan 13 11:06:42 2003
+++ b/include/asm-generic/dma-mapping.h	Mon Jan 13 11:06:42 2003
@@ -30,9 +30,10 @@
 }
 
 static inline void *
-dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle)
+dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		   int flag)
 {
-	BUG_ON(dev->bus != &pci_bus_type);
+	BUG_ON(dev->bus != &pci_bus_type || (flag & GFP_ATOMIC) != GFP_ATOMIC);
 
 	return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
 }
@@ -121,7 +122,7 @@
 
 /* Now for the API extensions over the pci_ one */
 
-#define dma_alloc_noncoherent(d, s, h) dma_alloc_coherent(d, s, h)
+#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 #define dma_is_consistent(d)	(1)
 
diff -Nru a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
--- a/include/asm-generic/pci-dma-compat.h	Mon Jan 13 11:06:42 2003
+++ b/include/asm-generic/pci-dma-compat.h	Mon Jan 13 11:06:42 2003
@@ -19,7 +19,7 @@
 pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
 		     dma_addr_t *dma_handle)
 {
-	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle);
+	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle, GFP_ATOMIC);
 }
 
 static inline void

--==_Exmh_17438245270
Content-Type: text/plain ; name="dma-alloc-1.956.diff"; charset=us-ascii
Content-Description: dma-alloc-1.956.diff
Content-Disposition: attachment; filename="dma-alloc-1.956.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.955   -> 1.956  
#	arch/i386/kernel/pci-dma.c	1.10    -> 1.11   
#	include/asm-i386/dma-mapping.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/13	jejb@raven.il.steeleye.com	1.956
# Update x86 DMA API implementation to take GFP_ flags
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/pci-dma.c b/arch/i386/kernel/pci-dma.c
--- a/arch/i386/kernel/pci-dma.c	Mon Jan 13 11:07:01 2003
+++ b/arch/i386/kernel/pci-dma.c	Mon Jan 13 11:07:01 2003
@@ -14,10 +14,11 @@
 #include <asm/io.h>
 
 void *dma_alloc_coherent(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle)
+			   dma_addr_t *dma_handle, int gfp)
 {
 	void *ret;
-	int gfp = GFP_ATOMIC;
+	/* ignore region specifiers */
+	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
 	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
 		gfp |= GFP_DMA;
diff -Nru a/include/asm-i386/dma-mapping.h b/include/asm-i386/dma-mapping.h
--- a/include/asm-i386/dma-mapping.h	Mon Jan 13 11:07:01 2003
+++ b/include/asm-i386/dma-mapping.h	Mon Jan 13 11:07:01 2003
@@ -3,11 +3,11 @@
 
 #include <asm/cache.h>
 
-#define dma_alloc_noncoherent(d, s, h) dma_alloc_coherent(d, s, h)
+#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 
 void *dma_alloc_coherent(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle);
+			   dma_addr_t *dma_handle, int flag);
 
 void dma_free_coherent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle);

--==_Exmh_17438245270
Content-Type: text/plain ; name="dma-alloc-1.957.diff"; charset=us-ascii
Content-Description: dma-alloc-1.957.diff
Content-Disposition: attachment; filename="dma-alloc-1.957.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.956   -> 1.957  
#	include/asm-arm/dma-mapping.h	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/13	jejb@raven.il.steeleye.com	1.957
# Update arm implementation of DMA API to include GFP_ flags
# --------------------------------------------
#
diff -Nru a/include/asm-arm/dma-mapping.h b/include/asm-arm/dma-mapping.h
--- a/include/asm-arm/dma-mapping.h	Mon Jan 13 11:07:19 2003
+++ b/include/asm-arm/dma-mapping.h	Mon Jan 13 11:07:19 2003
@@ -82,10 +82,8 @@
  * device-viewed address.
  */
 static inline void *
-dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle)
+dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, int gfp)
 {
-	int gfp = GFP_ATOMIC;
-
 	if (dev == NULL || dmadev_is_sa1111(dev) || *dev->dma_mask != 0xffffffff)
 		gfp |= GFP_DMA;
 

--==_Exmh_17438245270
Content-Type: text/plain ; name="dma-alloc-1.958.diff"; charset=us-ascii
Content-Description: dma-alloc-1.958.diff
Content-Disposition: attachment; filename="dma-alloc-1.958.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.957   -> 1.958  
#	drivers/scsi/53c700.c	1.21    -> 1.22   
#	drivers/scsi/sym53c8xx_comm.h	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/13	jejb@raven.il.steeleye.com	1.958
# update drivers using dma_alloc_[non]coherent for GFP_ flags
# --------------------------------------------
#
diff -Nru a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
--- a/drivers/scsi/53c700.c	Mon Jan 13 11:07:37 2003
+++ b/drivers/scsi/53c700.c	Mon Jan 13 11:07:37 2003
@@ -246,7 +246,7 @@
 	int j;
 
 	memory = dma_alloc_noncoherent(hostdata->dev, TOTAL_MEM_SIZE,
-					 &pScript);
+				       &pScript, GFP_KERNEL);
 	if(memory == NULL) {
 		printk(KERN_ERR "53c700: Failed to allocate memory for driver, detatching\n");
 		return NULL;
diff -Nru a/drivers/scsi/sym53c8xx_comm.h b/drivers/scsi/sym53c8xx_comm.h
--- a/drivers/scsi/sym53c8xx_comm.h	Mon Jan 13 11:07:37 2003
+++ b/drivers/scsi/sym53c8xx_comm.h	Mon Jan 13 11:07:37 2003
@@ -797,7 +797,7 @@
 		dma_addr_t daddr;
 		vp = (m_addr_t) dma_alloc_coherent(mp->bush,
 						PAGE_SIZE<<MEMO_PAGE_ORDER,
-						&daddr);
+						&daddr, GFP_KERNEL);
 		if (vp) {
 			int hc = VTOB_HASH_CODE(vp);
 			vbp->vaddr = vp;

--==_Exmh_17438245270--


