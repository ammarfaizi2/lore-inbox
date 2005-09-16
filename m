Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbVIPHBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbVIPHBf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbVIPHBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:01:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:65508 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161072AbVIPHBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:01:11 -0400
Message-Id: <20050916123314.366475000@localhost>
References: <20050916121646.387617000@localhost>
Date: Fri, 16 Sep 2005 08:16:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: ppc64-dev <linuxppc64-dev@ozlabs.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       jordi_caubet@es.ibm.com, Hiroyuki Machida <machida@sm.sony.co.jp>,
       Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch 08/11] spufs: make mem files mmappable
Content-Disposition: inline; filename=spu-backingstore-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it possible to mmap the "mem" files in spufs
even when they are alternating between direct mapping to
on-chip memory and the context save area.

We discard all page table entries during the SPU context switch
and get them back using the nopage operation. Unfortunately,
that requires struct page pointers for the local storage, which
is typically at the top of the 42 bit address space. In order
to get this, we use the current sparsemem support, but that still
wastes 2MB of RAM for its section pointers.

This should get better as soon as extreme sparsemem gets merged.

From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 arch/ppc64/Kconfig            |    2 
 arch/ppc64/kernel/bpa_setup.c |   75 ++++++++++++++++++++++
 fs/spufs/context.c            |   12 +++
 fs/spufs/file.c               |   69 ++++++++++++++++----
 fs/spufs/inode.c              |    2 
 fs/spufs/spufs.h              |    3 
 fs/spufs/switch.c             |   10 ++
 include/asm-ppc64/sparsemem.h |    4 -
 8 files changed, 157 insertions(+), 20 deletions(-)

Index: linux-cg/arch/ppc64/Kconfig
===================================================================
--- linux-cg.orig/arch/ppc64/Kconfig
+++ linux-cg/arch/ppc64/Kconfig
@@ -258,7 +258,7 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
-	depends on ARCH_DISCONTIGMEM_ENABLE
+	depends on ARCH_DISCONTIGMEM_ENABLE || PPC_BPA
 
 source "mm/Kconfig"
 
Index: linux-cg/arch/ppc64/kernel/bpa_setup.c
===================================================================
--- linux-cg.orig/arch/ppc64/kernel/bpa_setup.c
+++ linux-cg/arch/ppc64/kernel/bpa_setup.c
@@ -66,6 +66,77 @@ void bpa_get_cpuinfo(struct seq_file *m)
 	of_node_put(root);
 }
 
+#ifdef CONFIG_SPARSEMEM
+static int __init find_spu_node_id(struct device_node *spe)
+{
+	unsigned int *id;
+#ifdef CONFIG_NUMA
+	struct device_node *cpu;
+	cpu = spe->parent->parent;
+	id = (unsigned int *)get_property(cpu, "node-id", NULL);
+#else
+	id = NULL;
+#endif
+	return id ? *id : 0;
+}
+
+static void __init bpa_spuprop_present(struct device_node *spe,
+				       const char *prop, int early)
+{
+	struct address_prop {
+		unsigned long address;
+		unsigned int len;
+	} __attribute__((packed)) *p;
+	int proplen;
+
+	unsigned long start_pfn, end_pfn, pfn;
+	int node_id;
+
+	p = (void*)get_property(spe, prop, &proplen);
+	WARN_ON(proplen != sizeof (*p));
+
+	node_id = find_spu_node_id(spe);
+
+	start_pfn = p->address >> PAGE_SHIFT;
+	end_pfn = (p->address + p->len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	/* We need to call memory_present *before* the call to sparse_init,
+	   but we can initialize the page structs only *after* that call.
+	   Thus, we're being called twice. */
+	if (early)
+		memory_present(node_id, start_pfn, end_pfn);
+	else {
+		/* As the pages backing SPU LS and I/O are outside the range
+		   of regular memory, their page structs were not initialized
+		   by free_area_init. Do it here instead. */
+		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+			struct page *page = pfn_to_page(pfn);
+			set_page_links(page, ZONE_DMA, node_id, pfn);
+			set_page_count(page, 0);
+			reset_page_mapcount(page);
+			SetPageReserved(page);
+			INIT_LIST_HEAD(&page->lru);
+		}
+	}
+}
+
+static void __init bpa_spumem_init(int early)
+{
+	struct device_node *node;
+	for (node = of_find_node_by_type(NULL, "spe");
+			node; node = of_find_node_by_type(node, "spe")) {
+		bpa_spuprop_present(node, "local-store", early);
+		bpa_spuprop_present(node, "problem", early);
+		bpa_spuprop_present(node, "priv1", early);
+		bpa_spuprop_present(node, "priv2", early);
+	}
+}
+#else
+static void __init bpa_spumem_init(int early)
+{
+}
+#endif
+
 static void bpa_progress(char *s, unsigned short hex)
 {
 	printk("*** %04x : %s\n", hex, s ? s : "");
@@ -97,6 +168,8 @@ static void __init bpa_setup_arch(void)
 #endif
 
 	bpa_nvram_init();
+
+	bpa_spumem_init(0);
 }
 
 /*
@@ -112,6 +185,8 @@ static void __init bpa_init_early(void)
 
 	ppc64_interrupt_controller = IC_BPA_IIC;
 
+	bpa_spumem_init(1);
+
 	DBG(" <- bpa_init_early()\n");
 }
 
Index: linux-cg/include/asm-ppc64/sparsemem.h
===================================================================
--- linux-cg.orig/include/asm-ppc64/sparsemem.h
+++ linux-cg/include/asm-ppc64/sparsemem.h
@@ -8,8 +8,8 @@
  * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
  */
 #define SECTION_SIZE_BITS       24
-#define MAX_PHYSADDR_BITS       38
-#define MAX_PHYSMEM_BITS        36
+#define MAX_PHYSADDR_BITS       42
+#define MAX_PHYSMEM_BITS        42
 
 #endif /* CONFIG_SPARSEMEM */
 
Index: linux-cg/fs/spufs/context.c
===================================================================
--- linux-cg.orig/fs/spufs/context.c
+++ linux-cg/fs/spufs/context.c
@@ -20,12 +20,14 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <asm/spu.h>
 #include <asm/spu_csa.h>
 #include "spufs.h"
 
-struct spu_context *alloc_spu_context(void)
+struct spu_context *alloc_spu_context(struct address_space *local_store)
 {
 	struct spu_context *ctx;
 	ctx = kmalloc(sizeof *ctx, GFP_KERNEL);
@@ -55,6 +57,7 @@ struct spu_context *alloc_spu_context(vo
 	kref_init(&ctx->kref);
 	init_rwsem(&ctx->state_sema);
 	ctx->state = SPU_STATE_SAVED;
+	ctx->local_store = local_store;
 	goto out;
 out_free:
 	kfree(ctx);
@@ -94,6 +97,11 @@ void spu_release(struct spu_context *ctx
 	up_read(&ctx->state_sema);
 }
 
+static void spu_unmap_mappings(struct spu_context *ctx)
+{
+	unmap_mapping_range(ctx->local_store, 0, LS_SIZE, 1);
+}
+
 void spu_acquire_runnable(struct spu_context *ctx)
 {
 	down_read(&ctx->state_sema);
@@ -106,6 +114,7 @@ void spu_acquire_runnable(struct spu_con
 	down_write(&ctx->state_sema);
 
 	if (ctx->state == SPU_STATE_SAVED) {
+		spu_unmap_mappings(ctx);
 		spu_restore(&ctx->csa, ctx->spu);
 		ctx->state = SPU_STATE_RUNNABLE;
 	}
@@ -125,6 +134,7 @@ void spu_acquire_saved(struct spu_contex
 	down_write(&ctx->state_sema);
 
 	if (ctx->state == SPU_STATE_RUNNABLE) {
+		spu_unmap_mappings(ctx);
 		spu_save(&ctx->csa, ctx->spu);
 		ctx->state = SPU_STATE_SAVED;
 	}
Index: linux-cg/fs/spufs/file.c
===================================================================
--- linux-cg.orig/fs/spufs/file.c
+++ linux-cg/fs/spufs/file.c
@@ -38,6 +38,7 @@ spufs_mem_open(struct inode *inode, stru
 {
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	file->private_data = i->i_ctx;
+	file->f_mapping = i->i_ctx->local_store;
 	return 0;
 }
 
@@ -93,32 +94,72 @@ spufs_mem_write(struct file *file, const
 	return ret;
 }
 
+#ifdef CONFIG_SPARSEMEM
+static struct page *
+spufs_mem_mmap_nopage(struct vm_area_struct *vma,
+		      unsigned long address, int *type)
+{
+	struct page *page = NOPAGE_SIGBUS;
+
+	struct spu_context *ctx = vma->vm_file->private_data;
+	unsigned long offset = address - vma->vm_start;
+	offset += vma->vm_pgoff << PAGE_SHIFT;
+
+	spu_acquire(ctx);
+
+	if (ctx->state == SPU_STATE_SAVED)
+		page = vmalloc_to_page(ctx->csa.lscsa->ls + offset);
+	else
+		page = pfn_to_page((ctx->spu->local_store_phys + offset)
+				   >> PAGE_SHIFT);
+
+	spu_release(ctx);
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+
+	return page;
+}
+
+static struct vm_operations_struct spufs_mem_mmap_vmops = {
+	.nopage = spufs_mem_mmap_nopage,
+};
+#endif
+
 static int
 spufs_mem_mmap(struct file *file, struct vm_area_struct *vma)
 {
+#ifndef CONFIG_SPARSEMEM
 	struct spu_context *ctx = file->private_data;
-	struct spu *spu = ctx->spu;
-	unsigned long pfn;
-	int ret = 0;
+#endif
 
-	spu_acquire_runnable(ctx);
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
 
+	/* FIXME: */
 	vma->vm_flags |= VM_RESERVED;
-	vma->vm_page_prot = __pgprot(pgprot_val (vma->vm_page_prot)
-							| _PAGE_NO_CACHE);
-	pfn = spu->local_store_phys >> PAGE_SHIFT;
+	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
+				     | _PAGE_NO_CACHE);
+
+#ifndef CONFIG_SPARSEMEM
+	spu_acquire_runnable(ctx);
+
 	/*
 	 * This will work for actual SPUs, but not for vmalloc memory:
 	 */
-	if (remap_pfn_range(vma, vma->vm_start, pfn,
-				vma->vm_end-vma->vm_start, vma->vm_page_prot))
-		ret = -EAGAIN;
-
-	if (!ret)
-		ctx->state = SPU_STATE_LOCKED;
+	if (remap_pfn_range(vma, vma->vm_start,
+			    ctx->spu->local_store_phys >> PAGE_SHIFT,
+			    vma->vm_end - vma->vm_start, vma->vm_page_prot)) {
+		spu_release(ctx);
+		return -EAGAIN;
+	}
 
+	ctx->state = SPU_STATE_LOCKED;
 	spu_release(ctx);
-	return ret;
+#else
+	vma->vm_ops = &spufs_mem_mmap_vmops;
+#endif
+	return 0;
 }
 
 static struct file_operations spufs_mem_fops = {
Index: linux-cg/fs/spufs/inode.c
===================================================================
--- linux-cg.orig/fs/spufs/inode.c
+++ linux-cg/fs/spufs/inode.c
@@ -282,7 +282,7 @@ spufs_mkdir(struct inode *dir, struct de
 		inode->i_gid = dir->i_gid;
 		inode->i_mode &= S_ISGID;
 	}
-	ctx = alloc_spu_context();
+	ctx = alloc_spu_context(inode->i_mapping);
 	SPUFS_I(inode)->i_ctx = ctx;
 	if (!ctx)
 		goto out_iput;
Index: linux-cg/fs/spufs/spufs.h
===================================================================
--- linux-cg.orig/fs/spufs/spufs.h
+++ linux-cg/fs/spufs/spufs.h
@@ -40,6 +40,7 @@ struct spu_context {
 	struct spu_state csa;		  /* SPU context save area. */
 	struct rw_semaphore backing_sema; /* protects the above */
 	spinlock_t mmio_lock;		  /* protects mmio access */
+	struct address_space *local_store;/* local store backing store */
 
 	enum { SPU_STATE_RUNNABLE, SPU_STATE_SAVED, SPU_STATE_LOCKED } state;
 	struct rw_semaphore state_sema;
@@ -63,7 +64,7 @@ long spufs_create_thread(struct nameidat
 			 unsigned int flags, mode_t mode);
 
 /* context management */
-struct spu_context * alloc_spu_context(void);
+struct spu_context * alloc_spu_context(struct address_space *local_store);
 void destroy_spu_context(struct kref *kref);
 struct spu_context * get_spu_context(struct spu_context *ctx);
 int put_spu_context(struct spu_context *ctx);
Index: linux-cg/fs/spufs/switch.c
===================================================================
--- linux-cg.orig/fs/spufs/switch.c
+++ linux-cg/fs/spufs/switch.c
@@ -2191,6 +2191,7 @@ static void init_priv2(struct spu_state 
 void spu_init_csa(struct spu_state *csa)
 {
 	struct spu_lscsa *lscsa;
+	unsigned char *p;
 
 	if (!csa)
 		return;
@@ -2203,6 +2204,10 @@ void spu_init_csa(struct spu_state *csa)
 	memset(lscsa, 0, sizeof(struct spu_lscsa));
 	csa->lscsa = lscsa;
 
+	/* Set LS pages reserved to allow for user-space mapping. */
+	for (p = lscsa->ls; p < lscsa->ls + LS_SIZE; p += PAGE_SIZE)
+		SetPageReserved(vmalloc_to_page(p));
+
 	init_prob(csa);
 	init_priv1(csa);
 	init_priv2(csa);
@@ -2210,5 +2215,10 @@ void spu_init_csa(struct spu_state *csa)
 
 void spu_fini_csa(struct spu_state *csa)
 {
+	/* Clear reserved bit before vfree. */
+	unsigned char *p;
+	for (p = csa->lscsa->ls; p < csa->lscsa->ls + LS_SIZE; p += PAGE_SIZE)
+		ClearPageReserved(vmalloc_to_page(p));
+
 	vfree(csa->lscsa);
 }

--

