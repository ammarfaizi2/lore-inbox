Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTEHQCv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTEHQCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:02:51 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:4876 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S261842AbTEHQCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:02:44 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]  Moving sg_dma_{len,address} to scatterlist.h
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 08 May 2003 18:10:41 +0200
Message-ID: <wrp8ythpgfy.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, LKML,

Since struct scatterlist is used by both the generic DMA mapping API
and the PCI API, it makes sense to put macros that manipulates this
structure in asm/scatterlist.h, instead of asm/pci.h. asm/pci.h is
already including asm/scatterlist.h, so this is not a problem.

On x86, it is then possible to use the sg_dma_{len,address} macros
with the DMA mapping API without including asm/pci.h on old PCI-less
systems (EISA only...).

Some architectures are already doing that (alpha, sparc, sparc64,
ppc...), so the included patch (against 2.5.69) cleans up the
situation. Affected architectures are i386, ia64, mips, mips64, ppc64,
sh and x86_64.

Regards,

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1152  -> 1.1153 
#	include/asm-sh/scatterlist.h	1.4     -> 1.5    
#	include/asm-mips64/pci.h	1.8     -> 1.9    
#	include/asm-mips64/scatterlist.h	1.3     -> 1.4    
#	include/asm-ppc64/pci.h	1.5     -> 1.6    
#	include/asm-x86_64/pci.h	1.6     -> 1.7    
#	include/asm-i386/pci.h	1.21    -> 1.22   
#	include/asm-ppc64/scatterlist.h	1.1     -> 1.2    
#	include/asm-i386/scatterlist.h	1.3     -> 1.4    
#	include/asm-ia64/scatterlist.h	1.7     -> 1.8    
#	include/asm-sh/pci.h	1.11    -> 1.12   
#	include/asm-mips/scatterlist.h	1.3     -> 1.4    
#	include/asm-mips/pci.h	1.9     -> 1.10   
#	include/asm-ia64/pci.h	1.14    -> 1.15   
#	include/asm-x86_64/scatterlist.h	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/08	maz@hina.wild-wind.fr.eu.org	1.1153
# move sg_dma_{len,address} from asm/pci.h to asm/scatterlist.h
# --------------------------------------------
#
diff -Nru a/include/asm-i386/pci.h b/include/asm-i386/pci.h
--- a/include/asm-i386/pci.h	Thu May  8 17:38:33 2003
+++ b/include/asm-i386/pci.h	Thu May  8 17:38:33 2003
@@ -82,14 +82,6 @@
 	flush_write_buffers();
 }
 
-/* These macros should be used after a pci_map_sg call has been done
- * to get bus addresses of each of the SG entries and their lengths.
- * You should only work with the number of sg entries pci_map_sg
- * returns.
- */
-#define sg_dma_address(sg)	((sg)->dma_address)
-#define sg_dma_len(sg)		((sg)->length)
-
 /* Return the index of the PCI controller for device. */
 static inline int pci_controller_num(struct pci_dev *dev)
 {
diff -Nru a/include/asm-i386/scatterlist.h b/include/asm-i386/scatterlist.h
--- a/include/asm-i386/scatterlist.h	Thu May  8 17:38:33 2003
+++ b/include/asm-i386/scatterlist.h	Thu May  8 17:38:33 2003
@@ -8,6 +8,14 @@
     unsigned int	length;
 };
 
+/* These macros should be used after a {dma,pci}_map_sg call has been
+ * done to get bus addresses of each of the SG entries and their
+ * lengths.  You should only work with the number of sg entries
+ * {dma,pci}_map_sg returns.
+ */
+#define sg_dma_address(sg)	((sg)->dma_address)
+#define sg_dma_len(sg)		((sg)->length)
+
 #define ISA_DMA_THRESHOLD (0x00ffffff)
 
 #endif /* !(_I386_SCATTERLIST_H) */
diff -Nru a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h	Thu May  8 17:38:33 2003
+++ b/include/asm-ia64/pci.h	Thu May  8 17:38:33 2003
@@ -90,9 +90,6 @@
 /* Return the index of the PCI controller for device PDEV. */
 #define pci_controller_num(PDEV)	(0)
 
-#define sg_dma_len(sg)		((sg)->dma_length)
-#define sg_dma_address(sg)	((sg)->dma_address)
-
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
 				enum pci_mmap_state mmap_state, int write_combine);
diff -Nru a/include/asm-ia64/scatterlist.h b/include/asm-ia64/scatterlist.h
--- a/include/asm-ia64/scatterlist.h	Thu May  8 17:38:33 2003
+++ b/include/asm-ia64/scatterlist.h	Thu May  8 17:38:33 2003
@@ -15,6 +15,9 @@
 	unsigned int dma_length;
 };
 
+#define sg_dma_len(sg)		((sg)->dma_length)
+#define sg_dma_address(sg)	((sg)->dma_address)
+
 #define ISA_DMA_THRESHOLD	(~0UL)
 
 #endif /* _ASM_IA64_SCATTERLIST_H */
diff -Nru a/include/asm-mips/pci.h b/include/asm-mips/pci.h
--- a/include/asm-mips/pci.h	Thu May  8 17:38:33 2003
+++ b/include/asm-mips/pci.h	Thu May  8 17:38:33 2003
@@ -240,16 +240,6 @@
 /* Return the index of the PCI controller for device. */
 #define pci_controller_num(pdev)	(0)
 
-/*
- * These macros should be used after a pci_map_sg call has been done
- * to get bus addresses of each of the SG entries and their lengths.
- * You should only work with the number of sg entries pci_map_sg
- * returns, or alternatively stop on the first sg_dma_len(sg) which
- * is 0.
- */
-#define sg_dma_address(sg)	(virt_to_bus((sg)->address))
-#define sg_dma_len(sg)		((sg)->length)
-
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */
diff -Nru a/include/asm-mips/scatterlist.h b/include/asm-mips/scatterlist.h
--- a/include/asm-mips/scatterlist.h	Thu May  8 17:38:33 2003
+++ b/include/asm-mips/scatterlist.h	Thu May  8 17:38:33 2003
@@ -16,6 +16,16 @@
         __u32 dvma_addr;
 };
 
+/*
+ * These macros should be used after a pci_map_sg call has been done
+ * to get bus addresses of each of the SG entries and their lengths.
+ * You should only work with the number of sg entries pci_map_sg
+ * returns, or alternatively stop on the first sg_dma_len(sg) which
+ * is 0.
+ */
+#define sg_dma_address(sg)	(virt_to_bus((sg)->address))
+#define sg_dma_len(sg)		((sg)->length)
+
 #define ISA_DMA_THRESHOLD (0x00ffffff)
 
 #endif /* __ASM_MIPS_SCATTERLIST_H */
diff -Nru a/include/asm-mips64/pci.h b/include/asm-mips64/pci.h
--- a/include/asm-mips64/pci.h	Thu May  8 17:38:33 2003
+++ b/include/asm-mips64/pci.h	Thu May  8 17:38:33 2003
@@ -260,16 +260,6 @@
  */
 #define pci_controller_num(pdev)	(0)
 
-/*
- * These macros should be used after a pci_map_sg call has been done
- * to get bus addresses of each of the SG entries and their lengths.
- * You should only work with the number of sg entries pci_map_sg
- * returns, or alternatively stop on the first sg_dma_len(sg) which
- * is 0.
- */
-#define sg_dma_address(sg)	((unsigned long)((sg)->address))
-#define sg_dma_len(sg)		((sg)->length)
-
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */
diff -Nru a/include/asm-mips64/scatterlist.h b/include/asm-mips64/scatterlist.h
--- a/include/asm-mips64/scatterlist.h	Thu May  8 17:38:33 2003
+++ b/include/asm-mips64/scatterlist.h	Thu May  8 17:38:33 2003
@@ -16,6 +16,16 @@
         __u32 dvma_addr;
 };
 
+/*
+ * These macros should be used after a pci_map_sg call has been done
+ * to get bus addresses of each of the SG entries and their lengths.
+ * You should only work with the number of sg entries pci_map_sg
+ * returns, or alternatively stop on the first sg_dma_len(sg) which
+ * is 0.
+ */
+#define sg_dma_address(sg)	((unsigned long)((sg)->address))
+#define sg_dma_len(sg)		((sg)->length)
+
 #define ISA_DMA_THRESHOLD (0x00ffffffUL)
 
 #endif /* __ASM_MIPS64_SCATTERLIST_H */
diff -Nru a/include/asm-ppc64/pci.h b/include/asm-ppc64/pci.h
--- a/include/asm-ppc64/pci.h	Thu May  8 17:38:33 2003
+++ b/include/asm-ppc64/pci.h	Thu May  8 17:38:33 2003
@@ -97,9 +97,6 @@
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP	1
 
-#define sg_dma_address(sg)	((sg)->dma_address)
-#define sg_dma_len(sg)		((sg)->dma_length)
-
 #define pci_map_page(dev, page, off, size, dir) \
 		pci_map_single(dev, (page_address(page) + (off)), size, dir)
 #define pci_unmap_page(dev,addr,sz,dir) pci_unmap_single(dev,addr,sz,dir)
diff -Nru a/include/asm-ppc64/scatterlist.h b/include/asm-ppc64/scatterlist.h
--- a/include/asm-ppc64/scatterlist.h	Thu May  8 17:38:33 2003
+++ b/include/asm-ppc64/scatterlist.h	Thu May  8 17:38:33 2003
@@ -23,6 +23,9 @@
 	u32 dma_length;
 };
 
+#define sg_dma_address(sg)	((sg)->dma_address)
+#define sg_dma_len(sg)		((sg)->dma_length)
+
 #define ISA_DMA_THRESHOLD	(~0UL)
 
 #endif /* !(_PPC64_SCATTERLIST_H) */
diff -Nru a/include/asm-sh/pci.h b/include/asm-sh/pci.h
--- a/include/asm-sh/pci.h	Thu May  8 17:38:33 2003
+++ b/include/asm-sh/pci.h	Thu May  8 17:38:33 2003
@@ -229,15 +229,6 @@
 /* Return the index of the PCI controller for device PDEV. */
 #define pci_controller_num(PDEV)	(0)
 
-/* These macros should be used after a pci_map_sg call has been done
- * to get bus addresses of each of the SG entries and their lengths.
- * You should only work with the number of sg entries pci_map_sg
- * returns, or alternatively stop on the first sg_dma_len(sg) which
- * is 0.
- */
-#define sg_dma_address(sg)	(virt_to_bus((sg)->address))
-#define sg_dma_len(sg)		((sg)->length)
-
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */
diff -Nru a/include/asm-sh/scatterlist.h b/include/asm-sh/scatterlist.h
--- a/include/asm-sh/scatterlist.h	Thu May  8 17:38:33 2003
+++ b/include/asm-sh/scatterlist.h	Thu May  8 17:38:33 2003
@@ -8,6 +8,15 @@
     unsigned int length;
 };
 
+/* These macros should be used after a pci_map_sg call has been done
+ * to get bus addresses of each of the SG entries and their lengths.
+ * You should only work with the number of sg entries pci_map_sg
+ * returns, or alternatively stop on the first sg_dma_len(sg) which
+ * is 0.
+ */
+#define sg_dma_address(sg)	(virt_to_bus((sg)->address))
+#define sg_dma_len(sg)		((sg)->length)
+
 #define ISA_DMA_THRESHOLD (0x1fffffff)
 
 #endif /* !(__ASM_SH_SCATTERLIST_H) */
diff -Nru a/include/asm-x86_64/pci.h b/include/asm-x86_64/pci.h
--- a/include/asm-x86_64/pci.h	Thu May  8 17:38:33 2003
+++ b/include/asm-x86_64/pci.h	Thu May  8 17:38:33 2003
@@ -268,14 +268,6 @@
 	flush_write_buffers();
 }
 
-/* These macros should be used after a pci_map_sg call has been done
- * to get bus addresses of each of the SG entries and their lengths.
- * You should only work with the number of sg entries pci_map_sg
- * returns.
- */
-#define sg_dma_address(sg)	((sg)->dma_address)
-#define sg_dma_len(sg)		((sg)->length)
-
 /* Return the index of the PCI controller for device. */
 static inline int pci_controller_num(struct pci_dev *dev)
 {
diff -Nru a/include/asm-x86_64/scatterlist.h b/include/asm-x86_64/scatterlist.h
--- a/include/asm-x86_64/scatterlist.h	Thu May  8 17:38:33 2003
+++ b/include/asm-x86_64/scatterlist.h	Thu May  8 17:38:33 2003
@@ -8,6 +8,14 @@
     dma_addr_t		dma_address;
 };
 
+/* These macros should be used after a pci_map_sg call has been done
+ * to get bus addresses of each of the SG entries and their lengths.
+ * You should only work with the number of sg entries pci_map_sg
+ * returns.
+ */
+#define sg_dma_address(sg)	((sg)->dma_address)
+#define sg_dma_len(sg)		((sg)->length)
+
 #define ISA_DMA_THRESHOLD (0x00ffffff)
 
 #endif 

-- 
Places change, faces change. Life is so very strange.
