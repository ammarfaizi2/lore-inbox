Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTFQAXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTFQAXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:23:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40119 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264471AbTFQAX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:23:26 -0400
Subject: [RFC] x86 kernel text replication
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>
Content-Type: multipart/mixed; boundary="=-0kGWFzXjf8d/tVi1zPcj"
Organization: 
Message-Id: <1055810135.2465.281.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Jun 2003 17:35:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0kGWFzXjf8d/tVi1zPcj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

One of the vaunted NUMA features on OSes like PTX and AIX is the ability
to duplicate per-node read-only data, so that each node has a local
copy.  This patch does that for kernel text.  

I had to move the _actual_ text data up a bit, to get it away from the
pseudo-text stuff like swapper_pg_dir (see comment in
arch/i386/kernel/head.S).  I also had to align the back end of the text
segment.  

This only works on PAE, becuase I'm lazy, and nobody needs NUMA if they
have <4G of ram anyway (NUMAQ won't even compile :)  It depends on the
sepmd patch, which Martin _still_ needs to readd to his tree.
-- 
Dave Hansen
haveblue@us.ibm.com

--=-0kGWFzXjf8d/tVi1zPcj
Content-Disposition: attachment; filename=kernel-text-replication-2.5.70-mjb1-0.patch
Content-Type: text/x-patch; name=kernel-text-replication-2.5.70-mjb1-0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -rNup linux-2.5.70-mjb1/arch/i386/Kconfig linux-2.5.70-mjb1-textrep/arch/i386/Kconfig
--- linux-2.5.70-mjb1/arch/i386/Kconfig	Thu Jun  5 16:04:33 2003
+++ linux-2.5.70-mjb1-textrep/arch/i386/Kconfig	Mon Jun 16 16:16:27 2003
@@ -731,6 +731,10 @@ config NUMA_SCHED
 	depends on NUMA
 	default y
 
+config KERNEL_TEXT_REPLICATION
+	bool "Kernel text replication"
+	depends on NUMA && HIGHMEM64G
+
 # Need comments to help the hapless user trying to turn on NUMA support
 comment "NUMA (NUMA-Q) requires SMP, 64GB highmem support"
 	depends on X86_NUMAQ && (!HIGHMEM64G || !SMP)
diff -rNup linux-2.5.70-mjb1/arch/i386/kernel/head.S linux-2.5.70-mjb1-textrep/arch/i386/kernel/head.S
--- linux-2.5.70-mjb1/arch/i386/kernel/head.S	Thu Jun  5 16:04:34 2003
+++ linux-2.5.70-mjb1-textrep/arch/i386/kernel/head.S	Mon Jun 16 16:20:44 2003
@@ -413,7 +413,21 @@ ENTRY(pg1)
 .org 0x4000
 ENTRY(empty_zero_page)
 
+#ifdef CONFIG_KERNEL_TEXT_REPLICATION
+/*
+ * text replication uses large pages to map in the copies of kernel
+ * text.  If the pseudo-text data above is included in the same 2MB
+ * segment as the "real" text, then it will be different on each
+ * NUMA node.  This is bad for data that needs to be global :)
+ *
+ * Make this 1MB, because the previous data will always be less
+ * than 1MB, and with this alignment, we will be at 2MB, which
+ * gets it out of the same big page.
+ */
+.org 0x100000
+#else
 .org 0x5000
+#endif
 
 /*
  * Real beginning of normal "text" segment
diff -rNup linux-2.5.70-mjb1/arch/i386/mm/Makefile linux-2.5.70-mjb1-textrep/arch/i386/mm/Makefile
--- linux-2.5.70-mjb1/arch/i386/mm/Makefile	Thu Jun  5 16:04:10 2003
+++ linux-2.5.70-mjb1-textrep/arch/i386/mm/Makefile	Mon Jun 16 15:55:19 2003
@@ -8,3 +8,4 @@ obj-$(CONFIG_DISCONTIGMEM)	+= discontig.
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_BOOT_IOREMAP) += boot_ioremap.o
+obj-$(CONFIG_KERNEL_TEXT_REPLICATION) += text_repl.o
diff -rNup linux-2.5.70-mjb1/arch/i386/mm/text_repl.c linux-2.5.70-mjb1-textrep/arch/i386/mm/text_repl.c
--- linux-2.5.70-mjb1/arch/i386/mm/text_repl.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.70-mjb1-textrep/arch/i386/mm/text_repl.c	Mon Jun 16 16:10:47 2003
@@ -0,0 +1,124 @@
+/*
+ * arch/i386/mm/text_repl.c
+ * 
+ * functions to create copies of kernel text for each numa node
+ *
+ * This is highly dependent on having the kernel text being mapped 
+ * with large pages.
+ * 
+ * Written by Dave Hansen <haveblue@us.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/highmem.h>
+#include <linux/mmzone.h>
+#include <linux/mm.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+
+
+extern char _stext, _etext;
+#define KERNEL_TEXT_START	((unsigned long)&_stext)
+#define KERNEL_TEXT_END		((unsigned long)&_etext)
+
+int text_replicated = 0;
+pmd_t *textpmds;
+static inline int text_pmd_index(int nid, int pmdnum)
+{
+	return numnodes * pmdnum + nid;
+}
+
+static inline pmd_t* text_pmd(int nid, int pmdnum)
+{
+	return &textpmds[text_pmd_index(nid,pmdnum)];
+}
+	
+pmd_t make_pmd_for_pages(struct page *pages)
+{
+	return pfn_pmd(page_to_pfn(pages), PAGE_KERNEL_LARGE);
+}
+
+void setup_textrep(void)
+{
+	unsigned long text_size = KERNEL_TEXT_END - KERNEL_TEXT_START;
+	unsigned long alloc_order = PMD_SHIFT-PAGE_SHIFT;
+	unsigned long pages_per_pmd = PMD_SIZE/PAGE_SIZE;
+	int nid = 0;
+	unsigned long textsrc;
+	int pmdnum = 0;
+	struct page *dstpages, *srcpages;
+	int pmd_array_size = 0;
+
+	pmd_array_size = numnodes*sizeof(pmd_t)*(text_size/PMD_SIZE);
+	textpmds = kmalloc(pmd_array_size, GFP_KERNEL);
+	if (!textpmds) {
+		printk("could not allocate pmd array\n");
+		return;
+	}
+	
+	for (textsrc = KERNEL_TEXT_START; 
+		textsrc < KERNEL_TEXT_END; 
+		textsrc += PMD_SIZE, pmdnum++ ) {
+		srcpages = virt_to_page(textsrc);
+
+		set_pmd(text_pmd(0,pmdnum), make_pmd_for_pages(srcpages));
+		
+		for (nid = 1; nid < numnodes; nid++) {
+			dstpages = alloc_pages_node(nid, __GFP_HIGHMEM, alloc_order);
+			if (!dstpages)
+				goto nomem;
+			copy_highpage_range(dstpages, srcpages, pages_per_pmd);
+			set_pmd(text_pmd(nid,pmdnum),make_pmd_for_pages(srcpages));
+		}
+	}
+	text_replicated = 1;
+	return;
+nomem:
+	printk("couldn't allocate text space for node: %d pmd: %d size: %ld\n", 
+			nid, pmdnum, PAGE_SIZE<<alloc_order);
+	return;
+}
+
+void update_kernel_text(struct mm_struct * oldmm, struct mm_struct * newmm, int nid)
+{
+	int pmdnum = 0;
+	unsigned long textvaddr;
+	int need_to_flush = 1;
+
+	/* 
+	 * make sure that the text has been copied (there are additional
+	 * tasks forked before this happens).  
+	 *
+	 * Also, make sure that no one is trying to switch to a kernel
+	 * thread's pagetables (!newmm).   This is unlikely to happen
+	 * because, in lazy tlb mode, the previous process's pagetables
+	 * will be kept.  Those old pagetables should have correctly
+	 * set kernel text.
+	 */
+	if (!text_replicated || !newmm || (newmm->kernel_text_node == nid))
+		return;
+
+	/*
+	 * If the task we're switching from had a local set of kernel
+	 * text, then we only need to update our pagetables, but we
+	 * don't need to flush the old entry, because it is good.
+	 */
+	if (oldmm && (oldmm->kernel_text_node == nid))
+		need_to_flush = 0;
+
+	for (textvaddr = KERNEL_TEXT_START;
+		textvaddr < KERNEL_TEXT_END;
+		textvaddr += PMD_SIZE, pmdnum++) {
+		pgd_t *pgd;
+		pmd_t *pmd;
+
+		pgd = pgd_offset(newmm, textvaddr);
+		pmd = pmd_offset(pgd, textvaddr);
+		set_pmd(pmd, *text_pmd(nid,pmdnum));
+		if (need_to_flush)
+			__flush_tlb_one(textvaddr);
+	}
+	newmm->kernel_text_node = nid;
+}
diff -rNup linux-2.5.70-mjb1/arch/i386/vmlinux.lds.S linux-2.5.70-mjb1-textrep/arch/i386/vmlinux.lds.S
--- linux-2.5.70-mjb1/arch/i386/vmlinux.lds.S	Thu Jun  5 16:04:34 2003
+++ linux-2.5.70-mjb1-textrep/arch/i386/vmlinux.lds.S	Mon Jun 16 16:07:45 2003
@@ -19,6 +19,11 @@ SECTIONS
 	*(.gnu.warning)
 	} = 0x9090
 
+#ifdef CONFIG_KERNEL_TEXT_REPLICATION
+  _erealtext = .;
+  . = ALIGN(1<<21);		/* align on a big page boundary */
+#endif
+
   _etext = .;			/* End of text section */
 
   . = ALIGN(16);		/* Exception table */
diff -rNup linux-2.5.70-mjb1/include/linux/highmem.h linux-2.5.70-mjb1-textrep/include/linux/highmem.h
--- linux-2.5.70-mjb1/include/linux/highmem.h	Thu Jun  5 16:04:07 2003
+++ linux-2.5.70-mjb1-textrep/include/linux/highmem.h	Sat Jun 14 17:40:41 2003
@@ -92,4 +92,10 @@ static inline void copy_highpage(struct 
 	kunmap_atomic(vto, KM_USER1);
 }
 
+static inline void copy_highpage_range(struct page *to, struct page *from, int len)
+{
+	while(len--)
+		copy_highpage(to++, from++);
+}
+
 #endif /* _LINUX_HIGHMEM_H */
diff -rNup linux-2.5.70-mjb1/include/linux/sched.h linux-2.5.70-mjb1-textrep/include/linux/sched.h
--- linux-2.5.70-mjb1/include/linux/sched.h	Thu Jun  5 16:04:34 2003
+++ linux-2.5.70-mjb1-textrep/include/linux/sched.h	Mon Jun 16 15:49:53 2003
@@ -218,6 +218,16 @@ struct mm_struct {
 #ifdef CONFIG_HUGETLB_PAGE
 	int used_hugetlb;
 #endif
+#ifdef CONFIG_KERNEL_TEXT_REPLICATION
+	/* 
+	 * which copy of kernel text is in the pagetables? 
+	 * this defaults to 0, from the memset during mm initialization
+	 * 
+	 * i386, copies the original pgd from swapper_pg_dir,
+	 * which is always pointed to node0's text.
+	 */
+	int kernel_text_node;
+#endif
 	/* Architecture-specific MM context */
 	mm_context_t context;
 
@@ -876,6 +886,14 @@ static inline void set_task_cpu(struct t
 }
 
 #endif /* CONFIG_SMP */
+
+#ifdef CONFIG_KERNEL_TEXT_REPLICATION
+extern void setup_textrep(void);
+extern void update_kernel_text(struct mm_struct * oldmm, struct mm_struct * newmm, int nid);
+#else
+#define setup_textrep(...) do {} while(0)
+#define update_kernel_text(...) do {} while(0)
+#endif /* CONFIG_KERNEL_TEXT_REPLICATION */
 
 #endif /* __KERNEL__ */
 
diff -rNup linux-2.5.70-mjb1/init/main.c linux-2.5.70-mjb1-textrep/init/main.c
--- linux-2.5.70-mjb1/init/main.c	Thu Jun  5 16:04:34 2003
+++ linux-2.5.70-mjb1-textrep/init/main.c	Mon Jun 16 16:14:14 2003
@@ -598,6 +598,7 @@ static int init(void * unused)
 	 * initmem segments and start the user-mode stuff..
 	 */
 	free_initmem();
+	setup_textrep();
 	unlock_kernel();
 	system_running = 1;
 
diff -rNup linux-2.5.70-mjb1/kernel/sched.c linux-2.5.70-mjb1-textrep/kernel/sched.c
--- linux-2.5.70-mjb1/kernel/sched.c	Thu Jun  5 16:04:34 2003
+++ linux-2.5.70-mjb1-textrep/kernel/sched.c	Mon Jun 16 15:52:54 2003
@@ -854,6 +854,8 @@ static inline task_t * context_switch(ru
 	/* Here we just switch the register state and the stack. */
 	switch_to(prev, next, prev);
 
+	update_kernel_text(oldmm, mm, numa_node_id());
+	
 	return prev;
 }
 /*

--=-0kGWFzXjf8d/tVi1zPcj--

