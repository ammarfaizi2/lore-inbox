Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVAXA51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVAXA51 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 19:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVAXA51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 19:57:27 -0500
Received: from mailfe08.swip.net ([212.247.154.225]:11426 "EHLO
	mailfe08.swip.net") by vger.kernel.org with ESMTP id S261400AbVAXA5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 19:57:01 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: Memory leak in 2.6.11-rc1?
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       lennert.vanalboom@ugent.be
In-Reply-To: <20050123023248.263daca9.akpm@osdl.org>
References: <20050121161959.GO3922@fi.muni.cz>
	 <1106360639.15804.1.camel@boxen> <20050123091154.GC16648@suse.de>
	 <20050123011918.295db8e8.akpm@osdl.org> <20050123095608.GD16648@suse.de>
	 <20050123023248.263daca9.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 01:56:59 +0100
Message-Id: <1106528219.867.22.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think I've ever really seen code to diagnose this.
> 
> A simplistic approach would be to add eight or so ulongs into struct page,
> populate them with builtin_return_address(0...7) at allocation time, then
> modify sysrq-m to walk mem_map[] printing it all out for pages which have
> page_count() > 0.  That'd find the culprit.

Hi Andrew

I put something similar together of what you described but I made it a 
proc-file. It lists all pages owned by some caller and keeps a backtrace
of max 8 addresses. Each page has an order, -1 for unused and if used it lists
the order under which the first page is allocated, the rest in the group are kept -1.
Below is also a program to sort the enormous amount of
output, it will group together backtraces that are alike and list them like:

5 times: Page allocated via order 0
[0xffffffff8015861f] __get_free_pages+31
[0xffffffff8015c0ef] cache_alloc_refill+719
[0xffffffff8015bd74] kmem_cache_alloc+84
[0xffffffff8015bddc] alloc_arraycache+60
[0xffffffff8015d15d] do_tune_cpucache+93
[0xffffffff8015bbf8] cache_alloc_debugcheck_after+280
[0xffffffff8015d31d] enable_cpucache+93
[0xffffffff8015d8a5] kmem_cache_create+1365

It's a bit of hackety-hack in the function trace routines because doing
__builtin_return_address(0) - 7 doesn't work very well when it
runs out of the stack and the function itself doesn't check for it.

Tested on x86 with and without CONFIG_FRAME_POINTER and x86-64 (which
might are the only archs it'll work on). I hope you like it ;)


Suggested use is
cat /proc/page_owner > pgown; 
./below_program pgown pgsorted; 
vim pgsorted

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

struct block_list {
	struct block_list *next;
	char *txt;
	int len;
	int num;
};

struct block_list *block_head;

int read_block(char *buf, int fd)
{
	int ret = 0, rd = 0;
	int hit = 0;
	char *curr = buf;
	
	for (;;) {
		rd = read(fd, curr, 1);
		if (rd <= 0)
			return -1;
		
		ret += rd;
		if (*curr == '\n' && hit == 1)
			return ret - 1;
		else if (*curr == '\n')
			hit = 1;
		else
			hit = 0;
		curr++;
	}
}

int find_duplicate(char *buf, int len)
{	
	struct block_list *iterate, *item, *prev;
	char *txt;
		
	iterate = block_head;
	while (iterate) {
		if (len != iterate->len)
			goto iterate;
		if (!memcmp(buf, iterate->txt, len)) {
			iterate->num++;
			return 1;
		}
iterate:
		iterate = iterate->next;
	}
	
	/* this block didn't exist */
	txt = malloc(len);
	item = malloc(sizeof(struct block_list));
	strncpy(txt, buf, len);
	item->len = len;
	item->txt = txt;
	item->num = 1;
	item->next = NULL;

	if (block_head) {
		prev = block_head->next;
		block_head->next = item;
		item->next = prev;
	} else
		block_head = item;

	return 0;
}
int main(int argc, char **argv)
{
	int fdin, fdout;
	char buf[1024];
	int ret;
	struct block_list *item;
	
	fdin = open(argv[1], O_RDONLY);
	fdout = open(argv[2], O_CREAT | O_RDWR | O_EXCL, S_IWUSR | S_IRUSR);
	if (fdin < 0 || fdout < 0) {
		printf("Usage: ./program <input> <output>\n");
		perror("open: ");
		exit(2);
	}

	for(;;) {
		ret = read_block(buf, fdin);
		if (ret < 0)
			break;
		
		buf[ret] = '\0';
		find_duplicate(buf, ret);
	}

	for (item = block_head; item; item = item->next) {
		int written;

		/* errors? what errors... */
		ret = snprintf(buf, 1024, "%d times: ", item->num);
		written = write(fdout, buf, ret);
		written = write(fdout, item->txt, item->len);
		written = write(fdout, "\n", 1);
	}
	return 0;
}




===== fs/proc/proc_misc.c 1.113 vs edited =====
--- 1.113/fs/proc/proc_misc.c	2005-01-12 01:42:35 +01:00
+++ edited/fs/proc/proc_misc.c	2005-01-24 00:59:23 +01:00
@@ -534,6 +534,62 @@ static struct file_operations proc_sysrq
 };
 #endif
 
+#if 1
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
+	ret = snprintf(kbuf, count, "Page allocated via order %d\n", page->order);
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
@@ -610,6 +666,13 @@ void __init proc_misc_init(void)
 		entry = create_proc_entry("ppc_htab", S_IRUGO|S_IWUSR, NULL);
 		if (entry)
 			entry->proc_fops = &ppc_htab_operations;
+	}
+#endif
+#if 1
+	entry = create_proc_entry("page_owner", S_IWUSR | S_IRUGO, NULL);
+	if (entry) {
+		entry->proc_fops = &proc_page_owner_operations;
+		entry->size = 1024;
 	}
 #endif
 }
===== include/linux/mm.h 1.211 vs edited =====
--- 1.211/include/linux/mm.h	2005-01-11 02:29:23 +01:00
+++ edited/include/linux/mm.h	2005-01-23 23:22:52 +01:00
@@ -260,6 +260,10 @@ struct page {
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
 #endif /* WANT_PAGE_VIRTUAL */
+#if 1 
+	int order;
+	unsigned long trace[8];
+#endif
 };
 
 /*
===== mm/page_alloc.c 1.254 vs edited =====
--- 1.254/mm/page_alloc.c	2005-01-11 02:29:33 +01:00
+++ edited/mm/page_alloc.c	2005-01-24 01:04:38 +01:00
@@ -103,6 +103,7 @@ static void bad_page(const char *functio
 	tainted |= TAINT_BAD_PAGE;
 }
 
+
 #ifndef CONFIG_HUGETLB_PAGE
 #define prep_compound_page(page, order) do { } while (0)
 #define destroy_compound_page(page, order) do { } while (0)
@@ -680,6 +681,41 @@ int zone_watermark_ok(struct zone *z, in
 	return 1;
 }
 
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
+
 /*
  * This is the 'heart' of the zoned buddy allocator.
  *
@@ -709,6 +745,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	int alloc_type;
 	int do_retry;
 	int can_try_harder;
+	unsigned long address, bp;
 
 	might_sleep_if(wait);
 
@@ -825,6 +862,14 @@ nopage:
 	return NULL;
 got_pg:
 	zone_statistics(zonelist, z);
+	page->order = (int) order;
+#ifdef X86_64
+	asm ("movq %%rbp, %0" : "=r" (bp) : );
+#else
+	asm ("movl %%ebp, %0" : "=r" (bp) : );
+#endif
+	__stack_trace(page, &address, bp);
+	
 	return page;
 }
 
@@ -877,6 +922,7 @@ fastcall void __free_pages(struct page *
 			free_hot_page(page);
 		else
 			__free_pages_ok(page, order);
+		page->order = -1;
 	}
 }
 
@@ -1508,6 +1554,7 @@ void __init memmap_init_zone(unsigned lo
 			set_page_address(page, __va(start_pfn << PAGE_SHIFT));
 #endif
 		start_pfn++;
+		page->order = -1;
 	}
 }
 


