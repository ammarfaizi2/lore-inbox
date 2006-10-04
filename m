Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161575AbWJDQcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161575AbWJDQcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161567AbWJDQbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:31:34 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:24020 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161563AbWJDQbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:31:01 -0400
Message-Id: <20061004161456.928051000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:11 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 01/14] spufs: cell spu problem state mapping updates
Content-Disposition: inline; filename=spufs-64k-mapping-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch adds a new "psmap" file to spufs that allows mmap of all of
the problem state mapping of SPEs. It is compatible with 64k pages. In
addition, it removes mmap ability of individual files when using 64k
pages, with the exception of signal1 and signal2 which will both map the
entire 64k page holding both registers. It also removes
CONFIG_SPUFS_MMAP as there is no point in not building mmap support in
spufs.

It goes along a separate patch to libspe implementing usage of that new
file to access problem state registers.

Another patch will follow up to fix races opened up by accessing
the 'runcntl' register directly, which is made possible with this
patch.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -36,6 +36,8 @@
 
 #include "spufs.h"
 
+#define SPUFS_MMAP_4K (PAGE_SIZE == 0x1000)
+
 
 static int
 spufs_mem_open(struct inode *inode, struct file *file)
@@ -88,7 +90,6 @@ spufs_mem_write(struct file *file, const
 	return ret;
 }
 
-#ifdef CONFIG_SPUFS_MMAP
 static struct page *
 spufs_mem_mmap_nopage(struct vm_area_struct *vma,
 		      unsigned long address, int *type)
@@ -133,22 +134,19 @@ spufs_mem_mmap(struct file *file, struct
 	vma->vm_ops = &spufs_mem_mmap_vmops;
 	return 0;
 }
-#endif
 
 static struct file_operations spufs_mem_fops = {
 	.open	 = spufs_mem_open,
 	.read    = spufs_mem_read,
 	.write   = spufs_mem_write,
 	.llseek  = generic_file_llseek,
-#ifdef CONFIG_SPUFS_MMAP
 	.mmap    = spufs_mem_mmap,
-#endif
 };
 
-#ifdef CONFIG_SPUFS_MMAP
 static struct page *spufs_ps_nopage(struct vm_area_struct *vma,
 				    unsigned long address,
-				    int *type, unsigned long ps_offs)
+				    int *type, unsigned long ps_offs,
+				    unsigned long ps_size)
 {
 	struct page *page = NOPAGE_SIGBUS;
 	int fault_type = VM_FAULT_SIGBUS;
@@ -158,7 +156,7 @@ static struct page *spufs_ps_nopage(stru
 	int ret;
 
 	offset += vma->vm_pgoff << PAGE_SHIFT;
-	if (offset >= 0x4000)
+	if (offset >= ps_size)
 		goto out;
 
 	ret = spu_acquire_runnable(ctx);
@@ -179,10 +177,11 @@ static struct page *spufs_ps_nopage(stru
 	return page;
 }
 
+#if SPUFS_MMAP_4K
 static struct page *spufs_cntl_mmap_nopage(struct vm_area_struct *vma,
 					   unsigned long address, int *type)
 {
-	return spufs_ps_nopage(vma, address, type, 0x4000);
+	return spufs_ps_nopage(vma, address, type, 0x4000, 0x1000);
 }
 
 static struct vm_operations_struct spufs_cntl_mmap_vmops = {
@@ -191,17 +190,12 @@ static struct vm_operations_struct spufs
 
 /*
  * mmap support for problem state control area [0x4000 - 0x4fff].
- * Mapping this area requires that the application have CAP_SYS_RAWIO,
- * as these registers require special care when read/writing.
  */
 static int spufs_cntl_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_RAWIO))
-		return -EPERM;
-
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
@@ -209,7 +203,9 @@ static int spufs_cntl_mmap(struct file *
 	vma->vm_ops = &spufs_cntl_mmap_vmops;
 	return 0;
 }
-#endif
+#else /* SPUFS_MMAP_4K */
+#define spufs_cntl_mmap NULL
+#endif /* !SPUFS_MMAP_4K */
 
 static int spufs_cntl_open(struct inode *inode, struct file *file)
 {
@@ -242,9 +238,7 @@ static struct file_operations spufs_cntl
 	.open = spufs_cntl_open,
 	.read = spufs_cntl_read,
 	.write = spufs_cntl_write,
-#ifdef CONFIG_SPUFS_MMAP
 	.mmap = spufs_cntl_mmap,
-#endif
 };
 
 static int
@@ -657,11 +651,19 @@ static ssize_t spufs_signal1_write(struc
 	return 4;
 }
 
-#ifdef CONFIG_SPUFS_MMAP
 static struct page *spufs_signal1_mmap_nopage(struct vm_area_struct *vma,
 					      unsigned long address, int *type)
 {
-	return spufs_ps_nopage(vma, address, type, 0x14000);
+#if PAGE_SIZE == 0x1000
+	return spufs_ps_nopage(vma, address, type, 0x14000, 0x1000);
+#elif PAGE_SIZE == 0x10000
+	/* For 64k pages, both signal1 and signal2 can be used to mmap the whole
+	 * signal 1 and 2 area
+	 */
+	return spufs_ps_nopage(vma, address, type, 0x10000, 0x10000);
+#else
+#error unsupported page size
+#endif
 }
 
 static struct vm_operations_struct spufs_signal1_mmap_vmops = {
@@ -680,15 +682,12 @@ static int spufs_signal1_mmap(struct fil
 	vma->vm_ops = &spufs_signal1_mmap_vmops;
 	return 0;
 }
-#endif
 
 static struct file_operations spufs_signal1_fops = {
 	.open = spufs_signal1_open,
 	.read = spufs_signal1_read,
 	.write = spufs_signal1_write,
-#ifdef CONFIG_SPUFS_MMAP
 	.mmap = spufs_signal1_mmap,
-#endif
 };
 
 static int spufs_signal2_open(struct inode *inode, struct file *file)
@@ -743,11 +742,20 @@ static ssize_t spufs_signal2_write(struc
 	return 4;
 }
 
-#ifdef CONFIG_SPUFS_MMAP
+#if SPUFS_MMAP_4K
 static struct page *spufs_signal2_mmap_nopage(struct vm_area_struct *vma,
 					      unsigned long address, int *type)
 {
-	return spufs_ps_nopage(vma, address, type, 0x1c000);
+#if PAGE_SIZE == 0x1000
+	return spufs_ps_nopage(vma, address, type, 0x1c000, 0x1000);
+#elif PAGE_SIZE == 0x10000
+	/* For 64k pages, both signal1 and signal2 can be used to mmap the whole
+	 * signal 1 and 2 area
+	 */
+	return spufs_ps_nopage(vma, address, type, 0x10000, 0x10000);
+#else
+#error unsupported page size
+#endif
 }
 
 static struct vm_operations_struct spufs_signal2_mmap_vmops = {
@@ -767,15 +775,15 @@ static int spufs_signal2_mmap(struct fil
 	vma->vm_ops = &spufs_signal2_mmap_vmops;
 	return 0;
 }
-#endif
+#else /* SPUFS_MMAP_4K */
+#define spufs_signal2_mmap NULL
+#endif /* !SPUFS_MMAP_4K */
 
 static struct file_operations spufs_signal2_fops = {
 	.open = spufs_signal2_open,
 	.read = spufs_signal2_read,
 	.write = spufs_signal2_write,
-#ifdef CONFIG_SPUFS_MMAP
 	.mmap = spufs_signal2_mmap,
-#endif
 };
 
 static void spufs_signal1_type_set(void *data, u64 val)
@@ -824,11 +832,11 @@ static u64 spufs_signal2_type_get(void *
 DEFINE_SIMPLE_ATTRIBUTE(spufs_signal2_type, spufs_signal2_type_get,
 					spufs_signal2_type_set, "%llu");
 
-#ifdef CONFIG_SPUFS_MMAP
+#if SPUFS_MMAP_4K
 static struct page *spufs_mss_mmap_nopage(struct vm_area_struct *vma,
 					   unsigned long address, int *type)
 {
-	return spufs_ps_nopage(vma, address, type, 0x0000);
+	return spufs_ps_nopage(vma, address, type, 0x0000, 0x1000);
 }
 
 static struct vm_operations_struct spufs_mss_mmap_vmops = {
@@ -837,17 +845,12 @@ static struct vm_operations_struct spufs
 
 /*
  * mmap support for problem state MFC DMA area [0x0000 - 0x0fff].
- * Mapping this area requires that the application have CAP_SYS_RAWIO,
- * as these registers require special care when read/writing.
  */
 static int spufs_mss_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_RAWIO))
-		return -EPERM;
-
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
@@ -855,7 +858,9 @@ static int spufs_mss_mmap(struct file *f
 	vma->vm_ops = &spufs_mss_mmap_vmops;
 	return 0;
 }
-#endif
+#else /* SPUFS_MMAP_4K */
+#define spufs_mss_mmap NULL
+#endif /* !SPUFS_MMAP_4K */
 
 static int spufs_mss_open(struct inode *inode, struct file *file)
 {
@@ -867,17 +872,54 @@ static int spufs_mss_open(struct inode *
 
 static struct file_operations spufs_mss_fops = {
 	.open	 = spufs_mss_open,
-#ifdef CONFIG_SPUFS_MMAP
 	.mmap	 = spufs_mss_mmap,
-#endif
+};
+
+static struct page *spufs_psmap_mmap_nopage(struct vm_area_struct *vma,
+					   unsigned long address, int *type)
+{
+	return spufs_ps_nopage(vma, address, type, 0x0000, 0x20000);
+}
+
+static struct vm_operations_struct spufs_psmap_mmap_vmops = {
+	.nopage = spufs_psmap_mmap_nopage,
+};
+
+/*
+ * mmap support for full problem state area [0x00000 - 0x1ffff].
+ */
+static int spufs_psmap_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
+				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
+
+	vma->vm_ops = &spufs_psmap_mmap_vmops;
+	return 0;
+}
+
+static int spufs_psmap_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+
+	file->private_data = i->i_ctx;
+	return nonseekable_open(inode, file);
+}
+
+static struct file_operations spufs_psmap_fops = {
+	.open	 = spufs_psmap_open,
+	.mmap	 = spufs_psmap_mmap,
 };
 
 
-#ifdef CONFIG_SPUFS_MMAP
+#if SPUFS_MMAP_4K
 static struct page *spufs_mfc_mmap_nopage(struct vm_area_struct *vma,
 					   unsigned long address, int *type)
 {
-	return spufs_ps_nopage(vma, address, type, 0x3000);
+	return spufs_ps_nopage(vma, address, type, 0x3000, 0x1000);
 }
 
 static struct vm_operations_struct spufs_mfc_mmap_vmops = {
@@ -886,17 +928,12 @@ static struct vm_operations_struct spufs
 
 /*
  * mmap support for problem state MFC DMA area [0x0000 - 0x0fff].
- * Mapping this area requires that the application have CAP_SYS_RAWIO,
- * as these registers require special care when read/writing.
  */
 static int spufs_mfc_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_RAWIO))
-		return -EPERM;
-
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
 				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
@@ -904,7 +941,9 @@ static int spufs_mfc_mmap(struct file *f
 	vma->vm_ops = &spufs_mfc_mmap_vmops;
 	return 0;
 }
-#endif
+#else /* SPUFS_MMAP_4K */
+#define spufs_mfc_mmap NULL
+#endif /* !SPUFS_MMAP_4K */
 
 static int spufs_mfc_open(struct inode *inode, struct file *file)
 {
@@ -1194,9 +1233,7 @@ static struct file_operations spufs_mfc_
 	.flush	 = spufs_mfc_flush,
 	.fsync	 = spufs_mfc_fsync,
 	.fasync	 = spufs_mfc_fasync,
-#ifdef CONFIG_SPUFS_MMAP
 	.mmap	 = spufs_mfc_mmap,
-#endif
 };
 
 static void spufs_npc_set(void *data, u64 val)
@@ -1368,5 +1405,6 @@ struct tree_descr spufs_dir_contents[] =
 	{ "event_mask", &spufs_event_mask_ops, 0666, },
 	{ "srr0", &spufs_srr0_ops, 0666, },
 	{ "phys-id", &spufs_id_ops, 0666, },
+	{ "psmap", &spufs_psmap_fops, 0666, },
 	{},
 };
Index: linux-2.6/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/Kconfig
+++ linux-2.6/arch/powerpc/platforms/cell/Kconfig
@@ -16,11 +16,6 @@ config SPU_BASE
 	bool
 	default n
 
-config SPUFS_MMAP
-	bool
-	depends on SPU_FS && SPARSEMEM
-	default y
-
 config CBE_RAS
 	bool "RAS features for bare metal Cell BE"
 	default y

--

