Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbTAARB6>; Wed, 1 Jan 2003 12:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbTAARB6>; Wed, 1 Jan 2003 12:01:58 -0500
Received: from host194.steeleye.com ([66.206.164.34]:54026 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264986AbTAARBz>; Wed, 1 Jan 2003 12:01:55 -0500
Message-Id: <200301011710.h01HAFR02253@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@digeo.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, david-b@pacbell.net,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update) 
In-Reply-To: Message from Andrew Morton <akpm@digeo.com> 
   of "Tue, 31 Dec 2002 14:41:44 PST." <3E121D28.47282D77@digeo.com> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_20063775060"
Date: Wed, 01 Jan 2003 11:10:15 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_20063775060
Content-Type: text/plain; charset=us-ascii

akpm@digeo.com said:
> If anything comes out of this discussion, please let it be the
> removal of the hard-wired GFP_ATOMIC in dma_alloc_coherent.  That's
> quite broken - the interface should (always) be designed so that the
> caller can pass in the gfp flags (__GFP_WAIT,__GFP_IO,__GFP_FS, at
> least) 

How about the attached?  I'll also make the changes for parisc (any arch 
maintainers who just implemented the dma_ API are going to be annoyed about 
this change, though).

James





--==_Exmh_20063775060
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.930   -> 1.934  
#	drivers/scsi/53c700.c	1.21    -> 1.22   
#	include/asm-generic/pci-dma-compat.h	1.2     -> 1.3    
#	arch/i386/kernel/pci-dma.c	1.9     -> 1.11   
#	Documentation/DMA-API.txt	1.1     -> 1.3    
#	include/asm-generic/dma-mapping.h	1.2     -> 1.3    
#	include/asm-i386/dma-mapping.h	1.1     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/31	jejb@raven.il.steeleye.com	1.931
# add GFP_ flag to dma_alloc_[non]coherent
# --------------------------------------------
# 03/01/01	jejb@raven.il.steeleye.com	1.932
# update noncoherent #define for flag
# --------------------------------------------
# 03/01/01	jejb@raven.il.steeleye.com	1.933
# tidy up docs and flags
# --------------------------------------------
# 03/01/01	jejb@raven.il.steeleye.com	1.934
# update generic prototype for gfp flag
# --------------------------------------------
#
diff -Nru a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
--- a/Documentation/DMA-API.txt	Wed Jan  1 11:08:55 2003
+++ b/Documentation/DMA-API.txt	Wed Jan  1 11:08:55 2003
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
diff -Nru a/arch/i386/kernel/pci-dma.c b/arch/i386/kernel/pci-dma.c
--- a/arch/i386/kernel/pci-dma.c	Wed Jan  1 11:08:55 2003
+++ b/arch/i386/kernel/pci-dma.c	Wed Jan  1 11:08:55 2003
@@ -14,10 +14,12 @@
 #include <asm/io.h>
 
 void *dma_alloc_coherent(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle)
+			   dma_addr_t *dma_handle, int gfp)
 {
 	void *ret;
-	int gfp = GFP_ATOMIC;
+
+	/* ignore region specifiers */
+	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
 	if (dev == NULL || ((u32)*dev->dma_mask != 0xffffffff))
 		gfp |= GFP_DMA;
diff -Nru a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
--- a/drivers/scsi/53c700.c	Wed Jan  1 11:08:55 2003
+++ b/drivers/scsi/53c700.c	Wed Jan  1 11:08:55 2003
@@ -246,7 +246,7 @@
 	int j;
 
 	memory = dma_alloc_noncoherent(hostdata->dev, TOTAL_MEM_SIZE,
-					 &pScript);
+				       &pScript, GFP_KERNEL);
 	if(memory == NULL) {
 		printk(KERN_ERR "53c700: Failed to allocate memory for driver, detatching\n");
 		return NULL;
diff -Nru a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
--- a/include/asm-generic/dma-mapping.h	Wed Jan  1 11:08:55 2003
+++ b/include/asm-generic/dma-mapping.h	Wed Jan  1 11:08:55 2003
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
--- a/include/asm-generic/pci-dma-compat.h	Wed Jan  1 11:08:55 2003
+++ b/include/asm-generic/pci-dma-compat.h	Wed Jan  1 11:08:55 2003
@@ -19,7 +19,7 @@
 pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
 		     dma_addr_t *dma_handle)
 {
-	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle);
+	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle, GFP_ATOMIC);
 }
 
 static inline void
diff -Nru a/include/asm-i386/dma-mapping.h b/include/asm-i386/dma-mapping.h
--- a/include/asm-i386/dma-mapping.h	Wed Jan  1 11:08:55 2003
+++ b/include/asm-i386/dma-mapping.h	Wed Jan  1 11:08:55 2003
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

--==_Exmh_20063775060--


