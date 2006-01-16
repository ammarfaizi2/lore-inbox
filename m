Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWAQUV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWAQUV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWAQUVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:21:17 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:34003 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964815AbWAQUVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:21:02 -0500
Message-Id: <20060117195015.586435000@klappe.arndb.de>
References: <20060117194942.647145000@klappe.arndb.de>
Date: Tue, 17 Jan 2006 00:00:03 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, jordi_caubet@es.ibm.com,
       Mark Nutter <mnutter@us.ibm.com>, Arnd Bergmann <arndb@de.ibm.com>
Subject: [RFC/PATCH 3/3] spufs: enable SPE problem state MMIO access.
Content-Disposition: inline; filename=spufs-ps-mapping-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is layered on top of CONFIG_SPARSEMEM
and is patterned after direct mapping of LS.

This patch allows mmap() of the following regions: 
"mfc", which represents the area from [0x0000 - 0x0fff]; 
"cntl", which represents the area from [0x4000 - 0x5fff]; 
"signal1" which begins at offset 0x14000; "signal2" which 
begins at offset 0x1c000.

The signal1 & signal2 files may be mmap()'d by regular user 
processes.  The cntl and mfc file, on the other hand, may
only be accessed if the owning process has CAP_SYS_RAWIO,
because they have the potential to confuse the kernel
with regard to parallel access to the same files with
regular file operations: the kernel always holds a spinlock
when accessing registers in these areas to serialize them,
which can not be guaranteed with user mmaps,

From: Mark Nutter <mnutter@us.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spu_base.c
@@ -570,6 +570,11 @@ static int __init spu_map_device(struct 
 	if (!spu->local_store)
 		goto out;
 
+	prop = get_property(spe, "problem", NULL);
+	if (!prop)
+		goto out_unmap;
+	spu->problem_phys = *(unsigned long *)prop;
+
 	spu->problem= map_spe_prop(spe, "problem");
 	if (!spu->problem)
 		goto out_unmap;
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/context.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/context.c
@@ -27,7 +27,7 @@
 #include <asm/spu_csa.h>
 #include "spufs.h"
 
-struct spu_context *alloc_spu_context(struct address_space *local_store)
+struct spu_context *alloc_spu_context(void)
 {
 	struct spu_context *ctx;
 	ctx = kmalloc(sizeof *ctx, GFP_KERNEL);
@@ -53,7 +53,10 @@ struct spu_context *alloc_spu_context(st
 	ctx->mfc_fasync = NULL;
 	ctx->tagwait = 0;
 	ctx->state = SPU_STATE_SAVED;
-	ctx->local_store = local_store;
+	ctx->local_store = NULL;
+	ctx->cntl = NULL;
+	ctx->signal1 = NULL;
+	ctx->signal2 = NULL;
 	ctx->spu = NULL;
 	ctx->ops = &spu_backing_ops;
 	ctx->owner = get_task_mm(current);
@@ -110,7 +113,16 @@ void spu_release(struct spu_context *ctx
 
 void spu_unmap_mappings(struct spu_context *ctx)
 {
-	unmap_mapping_range(ctx->local_store, 0, LS_SIZE, 1);
+	if (ctx->local_store)
+		unmap_mapping_range(ctx->local_store, 0, LS_SIZE, 1);
+	if (ctx->mfc)
+		unmap_mapping_range(ctx->mfc, 0, 0x1000, 1);
+	if (ctx->cntl)
+		unmap_mapping_range(ctx->cntl, 0, 0x1000, 1);
+	if (ctx->signal1)
+		unmap_mapping_range(ctx->signal1, 0, 0x1000, 1);
+	if (ctx->signal2)
+		unmap_mapping_range(ctx->signal2, 0, 0x1000, 1);
 }
 
 int spu_acquire_runnable(struct spu_context *ctx)
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/file.c
@@ -41,8 +41,10 @@ static int
 spufs_mem_open(struct inode *inode, struct file *file)
 {
 	struct spufs_inode_info *i = SPUFS_I(inode);
-	file->private_data = i->i_ctx;
-	file->f_mapping = i->i_ctx->local_store;
+	struct spu_context *ctx = i->i_ctx;
+	file->private_data = ctx;
+	file->f_mapping = inode->i_mapping;
+	ctx->local_store = inode->i_mapping;
 	return 0;
 }
 
@@ -86,7 +88,7 @@ spufs_mem_write(struct file *file, const
 	return ret;
 }
 
-#ifdef CONFIG_SPARSEMEM
+#ifdef CONFIG_SPUFS_MMAP
 static struct page *
 spufs_mem_mmap_nopage(struct vm_area_struct *vma,
 		      unsigned long address, int *type)
@@ -138,11 +140,113 @@ static struct file_operations spufs_mem_
 	.read    = spufs_mem_read,
 	.write   = spufs_mem_write,
 	.llseek  = generic_file_llseek,
-#ifdef CONFIG_SPARSEMEM
+#ifdef CONFIG_SPUFS_MMAP
 	.mmap    = spufs_mem_mmap,
 #endif
 };
 
+#ifdef CONFIG_SPUFS_MMAP
+static struct page *spufs_ps_nopage(struct vm_area_struct *vma,
+				    unsigned long address,
+				    int *type, unsigned long ps_offs)
+{
+	struct page *page = NOPAGE_SIGBUS;
+	int fault_type = VM_FAULT_SIGBUS;
+	struct spu_context *ctx = vma->vm_file->private_data;
+	unsigned long offset = address - vma->vm_start;
+	unsigned long area;
+	int ret;
+
+	offset += vma->vm_pgoff << PAGE_SHIFT;
+	if (offset > 0x1000)
+		goto out;
+
+	ret = spu_acquire_runnable(ctx);
+	if (ret)
+		goto out;
+
+	area = ctx->spu->problem_phys + ps_offs;
+	page = pfn_to_page((area + offset) >> PAGE_SHIFT);
+	fault_type = VM_FAULT_MINOR;
+	page_cache_get(page);
+
+	spu_release(ctx);
+
+      out:
+	if (type)
+		*type = fault_type;
+
+	return page;
+}
+
+static struct page *spufs_cntl_mmap_nopage(struct vm_area_struct *vma,
+					   unsigned long address, int *type)
+{
+	return spufs_ps_nopage(vma, address, type, 0x4000);
+}
+
+static struct vm_operations_struct spufs_cntl_mmap_vmops = {
+	.nopage = spufs_cntl_mmap_nopage,
+};
+
+/*
+ * mmap support for problem state control area [0x4000 - 0x4fff].
+ * Mapping this area requires that the application have CAP_SYS_RAWIO,
+ * as these registers require special care when read/writing.
+ */
+static int spufs_cntl_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
+				     | _PAGE_NO_CACHE);
+
+	vma->vm_ops = &spufs_cntl_mmap_vmops;
+	return 0;
+}
+#endif
+
+static int spufs_cntl_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+	struct spu_context *ctx = i->i_ctx;
+
+	file->private_data = ctx;
+	file->f_mapping = inode->i_mapping;
+	ctx->cntl = inode->i_mapping;
+	return 0;
+}
+
+static ssize_t
+spufs_cntl_read(struct file *file, char __user *buffer,
+		size_t size, loff_t *pos)
+{
+	/* FIXME: read from spu status */
+	return -EINVAL;
+}
+
+static ssize_t
+spufs_cntl_write(struct file *file, const char __user *buffer,
+		 size_t size, loff_t *pos)
+{
+	/* FIXME: write to runctl bit */
+	return -EINVAL;
+}
+
+static struct file_operations spufs_cntl_fops = {
+	.open = spufs_cntl_open,
+	.read = spufs_cntl_read,
+	.write = spufs_cntl_write,
+#ifdef CONFIG_SPUFS_MMAP
+	.mmap = spufs_cntl_mmap,
+#endif
+};
+
 static int
 spufs_regs_open(struct inode *inode, struct file *file)
 {
@@ -503,6 +607,16 @@ static struct file_operations spufs_wbox
 	.read	= spufs_wbox_stat_read,
 };
 
+static int spufs_signal1_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+	struct spu_context *ctx = i->i_ctx;
+	file->private_data = ctx;
+	file->f_mapping = inode->i_mapping;
+	ctx->signal1 = inode->i_mapping;
+	return nonseekable_open(inode, file);
+}
+
 static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
@@ -543,12 +657,50 @@ static ssize_t spufs_signal1_write(struc
 	return 4;
 }
 
+#ifdef CONFIG_SPUFS_MMAP
+static struct page *spufs_signal1_mmap_nopage(struct vm_area_struct *vma,
+					      unsigned long address, int *type)
+{
+	return spufs_ps_nopage(vma, address, type, 0x14000);
+}
+
+static struct vm_operations_struct spufs_signal1_mmap_vmops = {
+	.nopage = spufs_signal1_mmap_nopage,
+};
+
+static int spufs_signal1_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
+				     | _PAGE_NO_CACHE);
+
+	vma->vm_ops = &spufs_signal1_mmap_vmops;
+	return 0;
+}
+#endif
+
 static struct file_operations spufs_signal1_fops = {
-	.open = spufs_pipe_open,
+	.open = spufs_signal1_open,
 	.read = spufs_signal1_read,
 	.write = spufs_signal1_write,
+#ifdef CONFIG_SPUFS_MMAP
+	.mmap = spufs_signal1_mmap,
+#endif
 };
 
+static int spufs_signal2_open(struct inode *inode, struct file *file)
+{
+	struct spufs_inode_info *i = SPUFS_I(inode);
+	struct spu_context *ctx = i->i_ctx;
+	file->private_data = ctx;
+	file->f_mapping = inode->i_mapping;
+	ctx->signal2 = inode->i_mapping;
+	return nonseekable_open(inode, file);
+}
+
 static ssize_t spufs_signal2_read(struct file *file, char __user *buf,
 			size_t len, loff_t *pos)
 {
@@ -591,10 +743,39 @@ static ssize_t spufs_signal2_write(struc
 	return 4;
 }
 
+#ifdef CONFIG_SPUFS_MMAP
+static struct page *spufs_signal2_mmap_nopage(struct vm_area_struct *vma,
+					      unsigned long address, int *type)
+{
+	return spufs_ps_nopage(vma, address, type, 0x1c000);
+}
+
+static struct vm_operations_struct spufs_signal2_mmap_vmops = {
+	.nopage = spufs_signal2_mmap_nopage,
+};
+
+static int spufs_signal2_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	/* FIXME: */
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
+				     | _PAGE_NO_CACHE);
+
+	vma->vm_ops = &spufs_signal2_mmap_vmops;
+	return 0;
+}
+#endif
+
 static struct file_operations spufs_signal2_fops = {
-	.open = spufs_pipe_open,
+	.open = spufs_signal2_open,
 	.read = spufs_signal2_read,
 	.write = spufs_signal2_write,
+#ifdef CONFIG_SPUFS_MMAP
+	.mmap = spufs_signal2_mmap,
+#endif
 };
 
 static void spufs_signal1_type_set(void *data, u64 val)
@@ -643,6 +824,38 @@ static u64 spufs_signal2_type_get(void *
 DEFINE_SIMPLE_ATTRIBUTE(spufs_signal2_type, spufs_signal2_type_get,
 					spufs_signal2_type_set, "%llu");
 
+#ifdef CONFIG_SPUFS_MMAP
+static struct page *spufs_mfc_mmap_nopage(struct vm_area_struct *vma,
+					   unsigned long address, int *type)
+{
+	return spufs_ps_nopage(vma, address, type, 0x0000);
+}
+
+static struct vm_operations_struct spufs_mfc_mmap_vmops = {
+	.nopage = spufs_mfc_mmap_nopage,
+};
+
+/*
+ * mmap support for problem state MFC DMA area [0x0000 - 0x0fff].
+ * Mapping this area requires that the application have CAP_SYS_RAWIO,
+ * as these registers require special care when read/writing.
+ */
+static int spufs_mfc_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
+				     | _PAGE_NO_CACHE);
+
+	vma->vm_ops = &spufs_mfc_mmap_vmops;
+	return 0;
+}
+#endif
 
 static int spufs_mfc_open(struct inode *inode, struct file *file)
 {
@@ -932,6 +1145,9 @@ static struct file_operations spufs_mfc_
 	.flush	 = spufs_mfc_flush,
 	.fsync	 = spufs_mfc_fsync,
 	.fasync	 = spufs_mfc_fasync,
+#ifdef CONFIG_SPUFS_MMAP
+	.mmap	 = spufs_mfc_mmap,
+#endif
 };
 
 static void spufs_npc_set(void *data, u64 val)
@@ -1077,6 +1293,7 @@ struct tree_descr spufs_dir_contents[] =
 	{ "signal1_type", &spufs_signal1_type, 0666, },
 	{ "signal2_type", &spufs_signal2_type, 0666, },
 	{ "mfc", &spufs_mfc_fops, 0666, },
+	{ "cntl", &spufs_cntl_fops,  0666, },
 	{ "npc", &spufs_npc_ops, 0666, },
 	{ "fpcr", &spufs_fpcr_fops, 0666, },
 	{ "decr", &spufs_decr_ops, 0666, },
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/inode.c
@@ -241,7 +241,7 @@ spufs_mkdir(struct inode *dir, struct de
 		inode->i_gid = dir->i_gid;
 		inode->i_mode &= S_ISGID;
 	}
-	ctx = alloc_spu_context(inode->i_mapping);
+	ctx = alloc_spu_context();
 	SPUFS_I(inode)->i_ctx = ctx;
 	if (!ctx)
 		goto out_iput;
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -43,7 +43,11 @@ struct spu_context {
 	struct spu *spu;		  /* pointer to a physical SPU */
 	struct spu_state csa;		  /* SPU context save area. */
 	spinlock_t mmio_lock;		  /* protects mmio access */
-	struct address_space *local_store;/* local store backing store */
+	struct address_space *local_store; /* local store mapping.  */
+	struct address_space *mfc;	   /* 'mfc' area mappings. */
+	struct address_space *cntl; 	   /* 'control' area mappings. */
+	struct address_space *signal1; 	   /* 'signal1' area mappings. */
+	struct address_space *signal2; 	   /* 'signal2' area mappings. */
 
 	enum { SPU_STATE_RUNNABLE, SPU_STATE_SAVED } state;
 	struct rw_semaphore state_sema;
@@ -125,7 +129,7 @@ long spufs_create_thread(struct nameidat
 extern struct file_operations spufs_context_fops;
 
 /* context management */
-struct spu_context * alloc_spu_context(struct address_space *local_store);
+struct spu_context * alloc_spu_context(void);
 void destroy_spu_context(struct kref *kref);
 struct spu_context * get_spu_context(struct spu_context *ctx);
 int put_spu_context(struct spu_context *ctx);
Index: linux-2.6.16-rc/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.16-rc.orig/include/asm-powerpc/spu.h
+++ linux-2.6.16-rc/include/asm-powerpc/spu.h
@@ -110,6 +110,7 @@ struct spu {
 	char *name;
 	unsigned long local_store_phys;
 	u8 *local_store;
+	unsigned long problem_phys;
 	struct spu_problem __iomem *problem;
 	struct spu_priv1 __iomem *priv1;
 	struct spu_priv2 __iomem *priv2;
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/Kconfig
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/Kconfig
@@ -10,4 +10,9 @@ config SPU_FS
 	  Units on machines implementing the Broadband Processor
 	  Architecture.
 
+config SPUFS_MMAP
+	bool
+	depends on SPU_FS && SPARSEMEM && !PPC_64K_PAGES
+	default y
+
 endmenu

--

