Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVCIBlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVCIBlM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVCIBlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:41:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:62608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262277AbVCIBir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:38:47 -0500
Date: Tue, 8 Mar 2005 17:38:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tobias Hennerich <Tobias@Hennerich.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange memory leak in 2.6.x
Message-Id: <20050308173811.0cd767c3.akpm@osdl.org>
In-Reply-To: <20050308133735.A13586@bart.hennerich.de>
References: <20050308133735.A13586@bart.hennerich.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Hennerich <Tobias@Hennerich.de> wrote:
>
>  we kindly ask for some suggestions about how to trace a memory leak
>  which we suspect in the linux kernel version 2.6:

Please grab 2.6.11, apply the below patch, set CONFIG_PAGE_OWNER and follow
the below instructions.



From: Alexander Nyberg <alexn@dsv.su.se>

Introduces CONFIG_PAGE OWNER that keeps track of the call chain under which
a page was allocated.  Includes a user-space helper in
Documentation/page_owner.c to sort the enormous amount of output that this
may give (thanks tridge).

Information available through /proc/page_owner

x86_64 introduces some stack noise in certain call chains so for exact
output use of x86 && CONFIG_FRAME_POINTER is suggested.  Tested on x86, x86
&& CONFIG_FRAME_POINTER, x86_64

Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/Documentation/page_owner.c |  140 +++++++++++++++++++++++++++++++++++++
 25-akpm/fs/proc/proc_misc.c        |   63 ++++++++++++++++
 25-akpm/include/linux/mm.h         |    4 +
 25-akpm/lib/Kconfig.debug          |   10 ++
 25-akpm/mm/page_alloc.c            |   56 ++++++++++++++
 5 files changed, 273 insertions(+)

diff -puN /dev/null Documentation/page_owner.c
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ 25-akpm/Documentation/page_owner.c	2005-02-22 18:17:32.000000000 -0800
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
diff -puN fs/proc/proc_misc.c~page-owner-tracking-leak-detector fs/proc/proc_misc.c
--- 25/fs/proc/proc_misc.c~page-owner-tracking-leak-detector	2005-02-22 18:17:32.000000000 -0800
+++ 25-akpm/fs/proc/proc_misc.c	2005-02-22 18:17:32.000000000 -0800
@@ -534,6 +534,62 @@ static struct file_operations proc_sysrq
 };
 #endif
 
+#ifdef CONFIG_PAGE_OWNER
+#include <linux/bootmem.h>
+#include <linux/kallsyms.h>
+static ssize_t
+read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct page *start = pfn_to_page(min_low_pfn);
+	static struct page *page;
+	char *kbuf, *modname;
+	const char *symname;
+	int ret = 0, next_idx = 1;
+	char namebuf[128];
+	unsigned long offset = 0, symsize;
+	int i;
+
+	page = start + *ppos;
+	for (; page < pfn_to_page(max_pfn); page++) {
+		if (page->order >= 0)
+			break;
+		next_idx++;
+		continue;
+	}
+
+	if (page >= pfn_to_page(max_pfn))
+		return 0;
+
+	*ppos += next_idx;
+
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	ret = snprintf(kbuf, 1024, "Page allocated via order %d\n", page->order);
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
@@ -612,4 +668,11 @@ void __init proc_misc_init(void)
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
diff -puN include/linux/mm.h~page-owner-tracking-leak-detector include/linux/mm.h
--- 25/include/linux/mm.h~page-owner-tracking-leak-detector	2005-02-22 18:17:32.000000000 -0800
+++ 25-akpm/include/linux/mm.h	2005-02-22 18:17:32.000000000 -0800
@@ -260,6 +260,10 @@ struct page {
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
 #endif /* WANT_PAGE_VIRTUAL */
+#ifdef CONFIG_PAGE_OWNER
+	int order;
+	unsigned long trace[8];
+#endif
 };
 
 /*
diff -puN lib/Kconfig.debug~page-owner-tracking-leak-detector lib/Kconfig.debug
--- 25/lib/Kconfig.debug~page-owner-tracking-leak-detector	2005-02-22 18:17:32.000000000 -0800
+++ 25-akpm/lib/Kconfig.debug	2005-02-22 18:17:32.000000000 -0800
@@ -167,6 +167,16 @@ config DEBUG_IOREMAP
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
diff -puN mm/page_alloc.c~page-owner-tracking-leak-detector mm/page_alloc.c
--- 25/mm/page_alloc.c~page-owner-tracking-leak-detector	2005-02-22 18:17:32.000000000 -0800
+++ 25-akpm/mm/page_alloc.c	2005-02-22 18:17:32.000000000 -0800
@@ -719,6 +719,43 @@ int zone_watermark_ok(struct zone *z, in
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
@@ -882,6 +919,19 @@ nopage:
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
+	__stack_trace(page, &address, bp);
+	}
+#endif /* CONFIG_PAGE_OWNER */
 	zone_statistics(zonelist, z);
 	return page;
 }
@@ -935,6 +985,9 @@ fastcall void __free_pages(struct page *
 			free_hot_page(page);
 		else
 			__free_pages_ok(page, order);
+#ifdef CONFIG_PAGE_OWNER
+		page->order = -1;
+#endif
 	}
 }
 
@@ -1578,6 +1631,9 @@ void __init memmap_init_zone(unsigned lo
 			set_page_address(page, __va(start_pfn << PAGE_SHIFT));
 #endif
 		start_pfn++;
+#ifdef CONFIG_PAGE_OWNER
+		page->order = -1;
+#endif
 	}
 }
 
_

