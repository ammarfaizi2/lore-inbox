Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTLAHgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTLAHgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:36:38 -0500
Received: from holomorphy.com ([199.26.172.102]:40136 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261276AbTLAHge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:36:34 -0500
Date: Sun, 30 Nov 2003 23:36:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.6.0-test5-bk3-17
Message-ID: <20031201073632.GQ8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031128041558.GW19856@holomorphy.com> <20031128072148.GY8039@holomorphy.com> <20031130164301.GK8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130164301.GK8039@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 08:43:01AM -0800, William Lee Irwin III wrote:
> I wonder if this would be enough to get sysenter support going again.
> I've not got a sysenter-capable userspace around, so I can't really
> test this myself.
> vs. pgcl-2.6.0-test11-5

Stack decoding fixes, shutting up some compiler warnings, and dumping
PAGE_SIZE and MMUPAGE_SIZE into /proc/meminfo (for lack of a better place).

The printk()'s down there should eventually get ripped out anyway for
minimal impact and a quieter boot, but until then...


-- wli



diff -prauN pgcl-2.6.0-test11-6/arch/i386/kernel/process.c pgcl-2.6.0-test11-7/arch/i386/kernel/process.c
--- pgcl-2.6.0-test11-6/arch/i386/kernel/process.c	2003-11-27 21:55:16.000000000 -0800
+++ pgcl-2.6.0-test11-7/arch/i386/kernel/process.c	2003-11-30 11:37:50.000000000 -0800
@@ -648,12 +648,12 @@ unsigned long get_wchan(struct task_stru
 		return 0;
 	stack_page = (unsigned long)p->thread_info;
 	esp = p->thread.esp;
-	if (!stack_page || esp < stack_page || esp > 8188+stack_page)
+	if (!stack_page || esp < stack_page || esp > THREAD_SIZE+stack_page-4)
 		return 0;
 	/* include/asm-i386/system.h:switch_to() pushes ebp last. */
 	ebp = *(unsigned long *) esp;
 	do {
-		if (ebp < stack_page || ebp > 8184+stack_page)
+		if (ebp < stack_page || ebp > THREAD_SIZE + stack_page - 8)
 			return 0;
 		eip = *(unsigned long *) (ebp+4);
 		if (eip < first_sched || eip >= last_sched)
diff -prauN pgcl-2.6.0-test11-6/arch/i386/mm/discontig.c pgcl-2.6.0-test11-7/arch/i386/mm/discontig.c
--- pgcl-2.6.0-test11-6/arch/i386/mm/discontig.c	2003-11-27 22:02:41.000000000 -0800
+++ pgcl-2.6.0-test11-7/arch/i386/mm/discontig.c	2003-11-30 12:46:50.000000000 -0800
@@ -268,10 +268,10 @@ unsigned long __init setup_memory(void)
 	for (nid = 0; nid < numnodes; nid++)
 		find_max_pfn_node(nid);
 	printk("vmallocspace = [0x%lx, 0x%lx)\n",
-			VMALLOC_START, VMALLOC_END);
+			(unsigned long)VMALLOC_START, (unsigned long)VMALLOC_END);
 	printk("fixmapspace = [0x%lx, 0x%lx)\n",
-			FIXADDR_START, FIXADDR_TOP);
-	printk("MAXMEM = 0x%lx\n", MAXMEM);
+			(unsigned long)FIXADDR_START, (unsigned long)FIXADDR_TOP);
+	printk("MAXMEM = 0x%lx\n", (unsigned long)MAXMEM);
 	for (nid = 0; nid < numnodes; ++nid)
 		printk("node %d at pfns [0x%lx, 0x%lx)\n",
 				nid, node_start_pfn[nid], node_end_pfn[nid]);
diff -prauN pgcl-2.6.0-test11-6/arch/i386/mm/init.c pgcl-2.6.0-test11-7/arch/i386/mm/init.c
--- pgcl-2.6.0-test11-6/arch/i386/mm/init.c	2003-11-27 22:10:55.000000000 -0800
+++ pgcl-2.6.0-test11-7/arch/i386/mm/init.c	2003-11-30 12:45:48.000000000 -0800
@@ -514,24 +514,24 @@ void __init mem_init(void)
 	       );
 	printk("MAXMEM=0x%lx\n", MAXMEM);
 	printk("vmalloc: start = 0x%lx, end = 0x%lx\n",
-			VMALLOC_START, VMALLOC_END);
+			(unsigned long)VMALLOC_START, (unsigned long)VMALLOC_END);
 	printk("fixaddr: start = 0x%lx, end = 0x%lx\n",
-			FIXADDR_START, FIXADDR_TOP);
+			(unsigned long)FIXADDR_START, (unsigned long)FIXADDR_TOP);
 
 #ifdef CONFIG_HIGHMEM
-	printk("FIX_KMAP_END == %lx\n", __fix_to_virt(FIX_KMAP_END));
+	printk("FIX_KMAP_END == %lx\n", (unsigned long)__fix_to_virt(FIX_KMAP_END));
 	if (__fix_to_virt(FIX_KMAP_END) % PAGE_SIZE)
 		printk(KERN_CRIT "kmap_atomic() area misaligned!\n");
 
-	printk("FIX_KMAP_BEGIN == %lx\n", __fix_to_virt(FIX_KMAP_BEGIN));
+	printk("FIX_KMAP_BEGIN == %lx\n", (unsigned long)__fix_to_virt(FIX_KMAP_BEGIN));
 	if ((__fix_to_virt(FIX_KMAP_BEGIN) + MMUPAGE_SIZE) % PAGE_SIZE)
 		printk(KERN_CRIT "kmap_atomic() area misaligned!\n");
 
-	printk("FIX_PKMAP_END == %lx\n", __fix_to_virt(FIX_PKMAP_END));
+	printk("FIX_PKMAP_END == %lx\n", (unsigned long)__fix_to_virt(FIX_PKMAP_END));
 	if (__fix_to_virt(FIX_PKMAP_END) % PAGE_SIZE)
 		printk(KERN_CRIT "kmap() area misaligned!\n");
 
-	printk("FIX_PKMAP_BEGIN == %lx\n", __fix_to_virt(FIX_PKMAP_BEGIN));
+	printk("FIX_PKMAP_BEGIN == %lx\n", (unsigned long)__fix_to_virt(FIX_PKMAP_BEGIN));
 	if ((__fix_to_virt(FIX_PKMAP_BEGIN) + MMUPAGE_SIZE) % PAGE_SIZE)
 		printk(KERN_CRIT "kmap() area misaligned!\n");
 #endif
diff -prauN pgcl-2.6.0-test11-6/fs/proc/proc_misc.c pgcl-2.6.0-test11-7/fs/proc/proc_misc.c
--- pgcl-2.6.0-test11-6/fs/proc/proc_misc.c	2003-11-27 21:55:19.000000000 -0800
+++ pgcl-2.6.0-test11-7/fs/proc/proc_misc.c	2003-11-30 12:50:32.000000000 -0800
@@ -206,7 +206,9 @@ static int meminfo_read_proc(char *page,
 		"PageTables:   %8lu kB\n"
 		"VmallocTotal: %8lu kB\n"
 		"VmallocUsed:  %8lu kB\n"
-		"VmallocChunk: %8lu kB\n",
+		"VmallocChunk: %8lu kB\n"
+		"PAGE_SIZE:    %8lu kB\n"
+		"MMUPAGE_SIZE: %8d kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.bufferram),
@@ -228,7 +230,9 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_page_table_pages),
 		vmtot,
 		vmi.used,
-		vmi.largest_chunk
+		vmi.largest_chunk,
+		K(PAGE_SIZE),
+		K(MMUPAGE_SIZE)
 		);
 
 		len += hugetlb_report_meminfo(page + len);
diff -prauN pgcl-2.6.0-test11-6/include/asm-i386/processor.h pgcl-2.6.0-test11-7/include/asm-i386/processor.h
--- pgcl-2.6.0-test11-6/include/asm-i386/processor.h	2003-11-26 12:42:55.000000000 -0800
+++ pgcl-2.6.0-test11-7/include/asm-i386/processor.h	2003-11-30 11:41:11.000000000 -0800
@@ -495,8 +495,16 @@ extern unsigned long thread_saved_pc(str
 void show_trace(struct task_struct *task, unsigned long *stack);
 
 unsigned long get_wchan(struct task_struct *p);
-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1022])
+
+#define THREAD_SIZE_LONGS	(THREAD_SIZE/sizeof(unsigned long))
+#define task_pt_regs(task)						\
+({									\
+	unsigned long *__ptr__ = (unsigned long *)(task)->thread_info;	\
+	(struct pt_regs *)(&__ptr__[THREAD_SIZE_LONGS-1]);		\
+})
+
+#define KSTK_EIP(task)	(task_pt_regs(task)->eip)
+#define KSTK_ESP(task)	(task_pt_regs(task)->esp)
 
 struct microcode_header {
 	unsigned int hdrver;
