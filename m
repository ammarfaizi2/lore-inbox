Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUHTKYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUHTKYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUHTKYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:24:22 -0400
Received: from ozlabs.org ([203.10.76.45]:15822 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266243AbUHTKVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:21:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16677.53391.323328.612628@cargo.ozlabs.ibm.com>
Date: Fri, 20 Aug 2004 20:21:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: John Rose <johnrose@austin.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Extend ioremap/iounmap infrastructure
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below implements the ability to query outstanding imalloc
regions for a given virtual address range.  (Imalloc is the allocator
of virtual space for ioremap.)  The patch extends im_get_area() to
allow a region criterion of IM_REGION_SUPERSET.  For a particular
"superset" virtual address and size passed into im_get_area(), the
function returns the first outstanding region that is contained within
this superset region.

The patch also changes iounmap_explicit() to allow for the unmapping of all 
regions that fit under a "superset".

This ability is necessary for dynamic (runtime) removal of pci host
bridges (PHBs).  For a PHB removal, the platform specification (the
RPA) requires that all of its children slots already be dynamically
removed.  Each of these slot-level removals has fractured the imalloc
region assigned to the PHB at boot.  At PHB removal time, it is
necessary to iounmap() the remaining artifacts of the initial PHB
region.

Signed-off-by:  John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/mm/imalloc.c akpm/arch/ppc64/mm/imalloc.c
--- linux-2.5/arch/ppc64/mm/imalloc.c	2004-02-28 10:11:18.000000000 +1100
+++ akpm/arch/ppc64/mm/imalloc.c	2004-08-20 17:13:51.000000000 +1000
@@ -37,33 +37,51 @@
 	return 0;
 }
 
+/* Return whether the region described by v_addr and size is a subset
+ * of the region described by parent
+ */
+static inline int im_region_is_subset(unsigned long v_addr, unsigned long size,
+			struct vm_struct *parent)
+{
+	return (int) (v_addr >= (unsigned long) parent->addr &&
+	              v_addr < (unsigned long) parent->addr + parent->size &&
+	    	      size < parent->size);
+}
+
+/* Return whether the region described by v_addr and size is a superset
+ * of the region described by child
+ */
+static int im_region_is_superset(unsigned long v_addr, unsigned long size,
+		struct vm_struct *child)
+{
+	struct vm_struct parent;
+
+	parent.addr = (void *) v_addr;
+	parent.size = size;
+
+	return im_region_is_subset((unsigned long) child->addr, child->size,
+			&parent);
+}
+
 /* Return whether the region described by v_addr and size overlaps
- * the region described by vm.  Overlapping regions meet the 
+ * the region described by vm.  Overlapping regions meet the
  * following conditions:
  * 1) The regions share some part of the address space
  * 2) The regions aren't identical
- * 3) The first region is not a subset of the second
+ * 3) Neither region is a subset of the other
  */
-static inline int im_region_overlaps(unsigned long v_addr, unsigned long size,
+static int im_region_overlaps(unsigned long v_addr, unsigned long size,
 		     struct vm_struct *vm)
 {
+	if (im_region_is_superset(v_addr, size, vm))
+		return 0;
+
 	return (v_addr + size > (unsigned long) vm->addr + vm->size &&
 		v_addr < (unsigned long) vm->addr + vm->size) ||
 	       (v_addr < (unsigned long) vm->addr &&
 		v_addr + size > (unsigned long) vm->addr);
 }
 
-/* Return whether the region described by v_addr and size is a subset
- * of the region described by vm
- */
-static inline int im_region_is_subset(unsigned long v_addr, unsigned long size,
-			struct vm_struct *vm)
-{
-	return (int) (v_addr >= (unsigned long) vm->addr && 
-	              v_addr < (unsigned long) vm->addr + vm->size &&
-	    	      size < vm->size);
-}
-
 /* Determine imalloc status of region described by v_addr and size.
  * Can return one of the following:
  * IM_REGION_UNUSED   -  Entire region is unallocated in imalloc space.
@@ -73,28 +91,37 @@
  * IM_REGION_EXISTS -    Exact region already allocated in imalloc space.
  *                       vm will be assigned to a ptr to the existing imlist
  *                       member.
- * IM_REGION_OVERLAPS -  A portion of the region is already allocated in 
- *                       imalloc space.
+ * IM_REGION_OVERLAPS -  Region overlaps an allocated region in imalloc space.
+ * IM_REGION_SUPERSET -  Region is a superset of a region that is already
+ *                       allocated in imalloc space.
  */
-static int im_region_status(unsigned long v_addr, unsigned long size, 
+static int im_region_status(unsigned long v_addr, unsigned long size,
 		    struct vm_struct **vm)
 {
 	struct vm_struct *tmp;
 
-	for (tmp = imlist; tmp; tmp = tmp->next) 
-		if (v_addr < (unsigned long) tmp->addr + tmp->size) 
+	for (tmp = imlist; tmp; tmp = tmp->next)
+		if (v_addr < (unsigned long) tmp->addr + tmp->size)
 			break;
-					
+
 	if (tmp) {
 		if (im_region_overlaps(v_addr, size, tmp))
 			return IM_REGION_OVERLAP;
 
 		*vm = tmp;
-		if (im_region_is_subset(v_addr, size, tmp))
+		if (im_region_is_subset(v_addr, size, tmp)) {
+			/* Return with tmp pointing to superset */
 			return IM_REGION_SUBSET;
-		else if (v_addr == (unsigned long) tmp->addr && 
-		 	 size == tmp->size) 
+		}
+		if (im_region_is_superset(v_addr, size, tmp)) {
+			/* Return with tmp pointing to first subset */
+			return IM_REGION_SUPERSET;
+		}
+		else if (v_addr == (unsigned long) tmp->addr &&
+		 	 size == tmp->size) {
+			/* Return with tmp pointing to exact region */
 			return IM_REGION_EXISTS;
+		}
 	}
 
 	*vm = NULL;
@@ -208,6 +235,10 @@
 		tmp = split_im_region(req_addr, size, tmp);
 		break;
 	case IM_REGION_EXISTS:
+		/* Return requested region */
+		break;
+	case IM_REGION_SUPERSET:
+		/* Return first existing subset of requested region */
 		break;
 	default:
 		printk(KERN_ERR "%s() unexpected imalloc region status\n",
diff -urN linux-2.5/arch/ppc64/mm/init.c akpm/arch/ppc64/mm/init.c
--- linux-2.5/arch/ppc64/mm/init.c	2004-08-03 08:07:43.000000000 +1000
+++ akpm/arch/ppc64/mm/init.c	2004-08-20 17:16:38.000000000 +1000
@@ -392,9 +392,28 @@
 	return;
 }
 
+static int iounmap_subset_regions(void *addr, unsigned long size)
+{
+	struct vm_struct *area;
+
+	/* Check whether subsets of this region exist */
+	area = im_get_area((unsigned long) addr, size, IM_REGION_SUPERSET);
+	if (area == NULL)
+		return 1;
+
+	while (area) {
+		iounmap(area->addr);
+		area = im_get_area((unsigned long) addr, size,
+				IM_REGION_SUPERSET);
+	}
+
+	return 0;
+}
+
 int iounmap_explicit(void *addr, unsigned long size)
 {
 	struct vm_struct *area;
+	int rc;
 	
 	/* addr could be in EEH or IO region, map it to IO region regardless.
 	 */
@@ -407,9 +426,16 @@
 	area = im_get_area((unsigned long) addr, size, 
 			    IM_REGION_EXISTS | IM_REGION_SUBSET);
 	if (area == NULL) {
-		printk(KERN_ERR "%s() cannot unmap nonexistent range 0x%lx\n",
-				__FUNCTION__, (unsigned long) addr);
-		return 1;
+		/* Determine whether subset regions exist.  If so, unmap */
+		rc = iounmap_subset_regions(addr, size);
+		if (rc) {
+			printk(KERN_ERR
+			       "%s() cannot unmap nonexistent range 0x%lx\n",
+ 				__FUNCTION__, (unsigned long) addr);
+			return 1;
+		}
+	} else {
+		iounmap(area->addr);
 	}
 
 	iounmap(area->addr);
diff -urN linux-2.5/include/asm-ppc64/pgtable.h akpm/include/asm-ppc64/pgtable.h
--- linux-2.5/include/asm-ppc64/pgtable.h	2004-07-06 08:43:03.000000000 +1000
+++ akpm/include/asm-ppc64/pgtable.h	2004-08-20 17:07:00.000000000 +1000
@@ -497,6 +497,7 @@
 #define IM_REGION_SUBSET	0x2
 #define IM_REGION_EXISTS	0x4
 #define IM_REGION_OVERLAP	0x8
+#define IM_REGION_SUPERSET	0x10
 
 extern struct vm_struct * im_get_free_area(unsigned long size);
 extern struct vm_struct * im_get_area(unsigned long v_addr, unsigned long size,
