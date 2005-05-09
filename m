Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVEIIaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVEIIaC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 04:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVEIIaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 04:30:02 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:48577 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261173AbVEII31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 04:29:27 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: How to diagnose a kernel memory leak
From: Alexander Nyberg <alexn@dsv.su.se>
To: Bruce Guenter <bruceg@em.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050509035823.GA13715@em.ca>
References: <20050509035823.GA13715@em.ca>
Content-Type: text/plain
Date: Mon, 09 May 2005 10:29:21 +0200
Message-Id: <1115627361.936.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am trying to diagnose a slow kernel memory leak, and am having no luck
> in pining it down.
> 
> I am currently running unpatched 2.6.12-rc3 (x86 on Gentoo, I saw the
> same symptoms with gentoo-sources 2.6.11-r6 and 2.6.11-r4.  Over the
> course of several days, the server in question has the amount of
> available memory (free minus buffers+cache) gradually decrease.  If I
> leave it go, it does eventually thrash itself to death after about a
> week (give or take).  The rate is about 150MB per day (the system has
> 2GB of RAM total so it takes several days).  The working set of
> processes remains the same through the whole period at between 50-150MB
> (depending on if you count VSZ or RSS).  Nothing shows up in dmesg
> except for a couple of one-time lockd and nfs messages  (the system uses
> two remote filesystems).  The local filesystems are ReiserFS on a 3Ware
> 7500-4 controller, and the NIC is an Intel E100.

You should keep an eye on /proc/meminfo but if there is memory that is
not accounted for then the patch below might help as it works on a lower
level. It accounts for bare pages in the system available
from /proc/page_owner. So a cat /proc/page_owner > tmpfile would be good
when the system starts to go low. There's a sorting program in
Documentation/page_owner.c used to sort the rather large output.
Also the meminfo you posted, how long had the box been alive when you
took it?

Select Track page owner under kernel hacking.


Index: linux-2.6/Documentation/page_owner.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/Documentation/page_owner.c	2005-05-09 09:50:08.000000000 +0200
@@ -0,0 +1,140 @@
+/*
+ * User-space helper to sort the output of /proc/page_owner
+ *
+ * Example use:
+ * cat /proc/page_owner > page_owner.txt
+ * ./sort page_owner.txt sorted_page_owner.txt
+*/
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+
+struct block_list {
+	char *txt;
+	int len;
+	int num;
+};
+
+
+static struct block_list *list;
+static int list_size;
+static int max_size;
+
+struct block_list *block_head;
+
+int read_block(char *buf, FILE *fin)
+{
+	int ret = 0;
+	int hit = 0;
+	char *curr = buf;
+
+	for (;;) {
+		*curr = getc(fin);
+		if (*curr == EOF) return -1;
+
+		ret++;
+		if (*curr == '\n' && hit == 1)
+			return ret - 1;
+		else if (*curr == '\n')
+			hit = 1;
+		else
+			hit = 0;
+		curr++;
+	}
+}
+
+static int compare_txt(struct block_list *l1, struct block_list *l2)
+{
+	return strcmp(l1->txt, l2->txt);
+}
+
+static int compare_num(struct block_list *l1, struct block_list *l2)
+{
+	return l2->num - l1->num;
+}
+
+static void add_list(char *buf, int len)
+{
+	if (list_size != 0 &&
+	    len == list[list_size-1].len &&
+	    memcmp(buf, list[list_size-1].txt, len) == 0) {
+		list[list_size-1].num++;
+		return;
+	}
+	if (list_size == max_size) {
+		printf("max_size too small??\n");
+		exit(1);
+	}
+	list[list_size].txt = malloc(len+1);
+	list[list_size].len = len;
+	list[list_size].num = 1;
+	memcpy(list[list_size].txt, buf, len);
+	list[list_size].txt[len] = 0;
+	list_size++;
+	if (list_size % 1000 == 0) {
+		printf("loaded %d\r", list_size);
+		fflush(stdout);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	FILE *fin, *fout;
+	char buf[1024];
+	int ret, i, count;
+	struct block_list *list2;
+	struct stat st;
+
+	fin = fopen(argv[1], "r");
+	fout = fopen(argv[2], "w");
+	if (!fin || !fout) {
+		printf("Usage: ./program <input> <output>\n");
+		perror("open: ");
+		exit(2);
+	}
+
+	fstat(fileno(fin), &st);
+	max_size = st.st_size / 100; /* hack ... */
+
+	list = malloc(max_size * sizeof(*list));
+
+	for(;;) {
+		ret = read_block(buf, fin);
+		if (ret < 0)
+			break;
+
+		buf[ret] = '\0';
+		add_list(buf, ret);
+	}
+
+	printf("loaded %d\n", list_size);
+
+	printf("sorting ....\n");
+
+	qsort(list, list_size, sizeof(list[0]), compare_txt);
+
+	list2 = malloc(sizeof(*list) * list_size);
+
+	printf("culling\n");
+
+	for (i=count=0;i<list_size;i++) {
+		if (count == 0 ||
+		    strcmp(list2[count-1].txt, list[i].txt) != 0) {
+			list2[count++] = list[i];
+		} else {
+			list2[count-1].num += list[i].num;
+		}
+	}
+
+	qsort(list2, count, sizeof(list[0]), compare_num);
+
+	for (i=0;i<count;i++) {
+		fprintf(fout, "%d times:\n%s\n", list2[i].num, list2[i].txt);
+	}
+	return 0;
+}
Index: linux-2.6/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.orig/fs/proc/proc_misc.c	2005-05-09 09:50:04.000000000 +0200
+++ linux-2.6/fs/proc/proc_misc.c	2005-05-09 09:50:10.000000000 +0200
@@ -539,6 +539,67 @@
 };
 #endif
 
+#ifdef CONFIG_PAGE_OWNER
+#include <linux/bootmem.h>
+#include <linux/kallsyms.h>
+static ssize_t
+read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	unsigned long start_pfn = min_low_pfn;
+	static unsigned long pfn;
+	struct page *page;
+	char *kbuf, *modname;
+	const char *symname;
+	int ret = 0, next_idx = 1;
+	char namebuf[128];
+	unsigned long offset = 0, symsize;
+	int i;
+
+	pfn = start_pfn + *ppos;
+	page = pfn_to_page(pfn);
+	for (; pfn < max_pfn; pfn++) {
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		if (page->order >= 0)
+			break;
+		next_idx++;
+	}
+
+	if (!pfn_valid(pfn))
+		return 0;
+
+	*ppos += next_idx;
+
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	ret = snprintf(kbuf, 1024, "Page allocated via order %d, mask 0x%x\n",
+			page->order, page->gfp_mask);
+
+	for (i = 0; i < 8; i++) {
+		if (!page->trace[i])
+			break;
+		symname = kallsyms_lookup(page->trace[i], &symsize, &offset, &modname, namebuf);
+		ret += snprintf(kbuf + ret, count - ret, "[0x%lx] %s+%lu\n",
+			page->trace[i], namebuf, offset);
+	}
+
+	ret += snprintf(kbuf + ret, count -ret, "\n");
+
+	if (copy_to_user(buf, kbuf, ret))
+		ret = -EFAULT;
+
+	kfree(kbuf);
+	return ret;
+}
+
+static struct file_operations proc_page_owner_operations = {
+	.read		= read_page_owner,
+};
+#endif
+
 struct proc_dir_entry *proc_root_kcore;
 
 void create_seq_entry(char *name, mode_t mode, struct file_operations *f)
@@ -617,4 +678,11 @@
 			entry->proc_fops = &ppc_htab_operations;
 	}
 #endif
+#ifdef CONFIG_PAGE_OWNER
+	entry = create_proc_entry("page_owner", S_IWUSR | S_IRUGO, NULL);
+	if (entry) {
+		entry->proc_fops = &proc_page_owner_operations;
+		entry->size = 1024;
+	}
+#endif
 }
Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h	2005-05-09 09:50:04.000000000 +0200
+++ linux-2.6/include/linux/mm.h	2005-05-09 09:50:10.000000000 +0200
@@ -257,6 +257,11 @@
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
 #endif /* WANT_PAGE_VIRTUAL */
+#ifdef CONFIG_PAGE_OWNER
+	int order;
+	unsigned int gfp_mask;
+	unsigned long trace[8];
+#endif
 };
 
 /*
Index: linux-2.6/lib/Kconfig.debug
===================================================================
--- linux-2.6.orig/lib/Kconfig.debug	2005-05-09 09:50:04.000000000 +0200
+++ linux-2.6/lib/Kconfig.debug	2005-05-09 09:50:08.000000000 +0200
@@ -139,6 +139,16 @@
 	  automatically, but we'd like to make it more efficient by not
 	  having to do that.
 
+config PAGE_OWNER
+	bool "Track page owner"
+	depends on DEBUG_KERNEL && X86
+	help
+	  This keeps track of what call chain is the owner of a page, may
+	  help to find bare alloc_page(s) leaks. Eats a fair amount of memory.
+	  See Documentation/page_owner.c for user-space helper.
+
+	  If unsure, say N.
+
 config DEBUG_FS
 	bool "Debug Filesystem"
 	depends on DEBUG_KERNEL
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2005-05-09 09:50:04.000000000 +0200
+++ linux-2.6/mm/page_alloc.c	2005-05-09 09:50:10.000000000 +0200
@@ -724,6 +724,43 @@
 	return 1;
 }
 
+#ifdef CONFIG_PAGE_OWNER
+static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
+{
+	return	p > (void *)tinfo &&
+		p < (void *)tinfo + THREAD_SIZE - 3;
+}
+
+static inline void __stack_trace(struct page *page, unsigned long *stack, unsigned long bp)
+{
+	int i = 0;
+	unsigned long addr;
+	struct thread_info *tinfo = (struct thread_info *)
+		((unsigned long)stack & (~(THREAD_SIZE - 1)));
+
+	memset(page->trace, 0, sizeof(long) * 8);
+
+#ifdef	CONFIG_FRAME_POINTER
+	while (valid_stack_ptr(tinfo, (void *)bp)) {
+		addr = *(unsigned long *)(bp + sizeof(long));
+		page->trace[i] = addr;
+		if (++i >= 8)
+			break;
+		bp = *(unsigned long *)bp;
+	}
+#else
+	while (valid_stack_ptr(tinfo, stack)) {
+		addr = *stack++;
+		if (__kernel_text_address(addr)) {
+			page->trace[i] = addr;
+			if (++i >= 8)
+				break;
+		}
+	}
+#endif
+}
+#endif /* CONFIG_PAGE_OWNER */
+
 /*
  * This is the 'heart' of the zoned buddy allocator.
  */
@@ -908,6 +945,20 @@
 	}
 	return NULL;
 got_pg:
+
+#ifdef CONFIG_PAGE_OWNER /* huga... */
+	{
+	unsigned long address, bp;
+#ifdef X86_64
+	asm ("movq %%rbp, %0" : "=r" (bp) : );
+#else
+	asm ("movl %%ebp, %0" : "=r" (bp) : );
+#endif
+	page->order = (int) order;
+	page->gfp_mask = gfp_mask;
+	__stack_trace(page, &address, bp);
+	}
+#endif /* CONFIG_PAGE_OWNER */
 	zone_statistics(zonelist, z);
 	return page;
 }
@@ -961,6 +1012,9 @@
 			free_hot_page(page);
 		else
 			__free_pages_ok(page, order);
+#ifdef CONFIG_PAGE_OWNER
+		page->order = -1;
+#endif
 	}
 }
 
@@ -1602,6 +1656,9 @@
 			set_page_address(page, __va(start_pfn << PAGE_SHIFT));
 #endif
 		start_pfn++;
+#ifdef CONFIG_PAGE_OWNER
+		page->order = -1;
+#endif
 	}
 }
 


