Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVCHQEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVCHQEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 11:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVCHQEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 11:04:46 -0500
Received: from mailfe04.swip.net ([212.247.154.97]:18913 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261399AbVCHQDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 11:03:06 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Re: Strange memory leak in 2.6.x
From: Alexander Nyberg <alexn@dsv.su.se>
To: Tobias Hennerich <Tobias@Hennerich.de>
Cc: Timo Hennerich <Timo@Hennerich.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050308154042.A388@bart.hennerich.de>
References: <20050308133735.A13586@bart.hennerich.de>
	 <1110291647.2294.12.camel@boxen>  <20050308154042.A388@bart.hennerich.de>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 17:03:04 +0100
Message-Id: <1110297784.2445.3.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry, I somehow didn't do reply-to-all in the first mail, lkml back]

> > > Out of Memory: Killed process 29603 (cleanup).
> > 
> > This looks to me like someone is leaking pages. Could you please try
> > 2.6.11 and the patch I'm putting at the bottom of this mail, there'll be
> > a CONFIG_PAGE_OWNER option under kernel hacking.
> > 
> > There will be a /proc/page_owner and Documentation/page_owner.c that
> > contains a program to sort the output. When it starts getting messy do:
> > cat /proc/page_owner > page_owner.txt
> > ./sort page_owner.txt sorted_page_owner.txt
> > 
> > The sorted_page_owner.txt will tell us who is grabbing pages.
> 
> Thank you for your mail, wonderful, exactly what I was looking for!
> 
> Before we are installing the new kernel with your patch: Can you say
> anything about the performance, which this patch costs? The machine is
> used by a bigger company and I want to be prepared, if several thousand
> employees can't mail or use the web anymore...
> 

I doubt you'll notice any performance overhead, however this patch eats
some memory, on your system (4GB / 4096) * 36 bytes something like 36M
of low memory.

Btw, I recalled I haven't updated my previous patch for a discontig mem
(NUMA) update I got (doesn't matter on most machines) but anyway, I've
updated it and here it is.

This updated patch has been in -mm for a while so it should have proven
itself stable.

Thanks for taking time to help shake this out. 



===== fs/proc/proc_misc.c 1.113 vs edited =====
--- 1.113/fs/proc/proc_misc.c	2005-01-12 01:42:35 +01:00
+++ edited/fs/proc/proc_misc.c	2005-03-08 16:40:15 +01:00
@@ -534,6 +534,66 @@ static struct file_operations proc_sysrq
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
@@ -610,6 +670,13 @@ void __init proc_misc_init(void)
 		entry = create_proc_entry("ppc_htab", S_IRUGO|S_IWUSR, NULL);
 		if (entry)
 			entry->proc_fops = &ppc_htab_operations;
+	}
+#endif
+#ifdef CONFIG_PAGE_OWNER
+	entry = create_proc_entry("page_owner", S_IWUSR | S_IRUGO, NULL);
+	if (entry) {
+		entry->proc_fops = &proc_page_owner_operations;
+		entry->size = 1024;
 	}
 #endif
 }
===== include/linux/mm.h 1.215 vs edited =====
--- 1.215/include/linux/mm.h	2005-03-05 07:41:14 +01:00
+++ edited/include/linux/mm.h	2005-03-08 16:38:02 +01:00
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
===== lib/Kconfig.debug 1.13 vs edited =====
--- 1.13/lib/Kconfig.debug	2005-01-21 06:00:21 +01:00
+++ edited/lib/Kconfig.debug	2005-03-08 16:38:02 +01:00
@@ -140,6 +140,16 @@ config DEBUG_FS
 
 	  If unsure, say N.
 
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
 if !X86_64
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
===== mm/page_alloc.c 1.258 vs edited =====
--- 1.258/mm/page_alloc.c	2005-01-31 07:20:14 +01:00
+++ edited/mm/page_alloc.c	2005-03-08 16:38:02 +01:00
@@ -688,6 +688,43 @@ int zone_watermark_ok(struct zone *z, in
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
@@ -851,6 +888,19 @@ nopage:
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
@@ -904,6 +954,9 @@ fastcall void __free_pages(struct page *
 			free_hot_page(page);
 		else
 			__free_pages_ok(page, order);
+#ifdef CONFIG_PAGE_OWNER
+		page->order = -1;
+#endif
 	}
 }
 
@@ -1547,6 +1600,9 @@ void __init memmap_init_zone(unsigned lo
 			set_page_address(page, __va(start_pfn << PAGE_SHIFT));
 #endif
 		start_pfn++;
+#ifdef CONFIG_PAGE_OWNER
+		page->order = -1;
+#endif
 	}
 }
 
--- /dev/null	2004-08-25 14:12:53.000000000 +0200
+++ linus-2.5/Documentation/page_owner.c	2005-03-08 16:27:42.000000000 +0100
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


