Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbVGHU66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVGHU66 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVGHU6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:58:49 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:30110 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262851AbVGHU5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:57:15 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Patch for slab leak debugging
From: Alexander Nyberg <alexn@telia.com>
To: akpm@osdl.org, manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 08 Jul 2005 22:56:59 +0200
Message-Id: <1120856219.25294.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we really need an option in the kernel to help users in tracking
slab leaks so that they can be brought down easier. This patch tracks
the caller of the first five objects to be created within a slab. This
is not much but as slab leaks normally are quite obvious with the
exception that we don't know who the caller is, I think this approach
will do fine.

No NUMA handling, only looks at nodelists[0] at the moment

list_ff() is distasteful, but I've yet to come up with a better approach
and at the same time not screwing up the slab core too much (I've not
seen too big latencies even with 7M size-32 objects, with that size it
took around 1 minute to cat /proc/slab_owner > meepmeep.txt on a 1.2Ghz
athlon. We could even limit the size of the output as it'll be pretty
repetetive anyway).

To use it, look at /proc/slabinfo to identify the cache that looks to
have leakin callers. Then echo cachename > /proc/slab_owner;
cat /proc/slab_owner > unsorted_slab_owner

Although glancing at this file will likely reveal the leaking caller,
there's a user-space program called slab_owner.c in Documentation/
to help sort the output in the same manner as page_owner

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: akpm/lib/Kconfig.debug
===================================================================
--- akpm.orig/lib/Kconfig.debug	2005-07-08 22:49:18.000000000 +0200
+++ akpm/lib/Kconfig.debug	2005-07-08 22:49:27.000000000 +0200
@@ -85,6 +85,14 @@
 	  allocation as well as poisoning memory on free to catch use of freed
 	  memory. This can make kmalloc/kfree-intensive workloads much slower.
 
+config SLAB_OWNER
+	bool "Track owner of slab objects"
+	depends on DEBUG_KERNEL && DEBUG_SLAB
+	help
+	  Say Y here to make the kernel keep track of some of the functions 
+	  allocating slab objects. Expensive, should only be used to track 
+	  down slab leaks.
+
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT
Index: akpm/mm/slab.c
===================================================================
--- akpm.orig/mm/slab.c	2005-07-08 22:49:18.000000000 +0200
+++ akpm/mm/slab.c	2005-07-08 22:49:27.000000000 +0200
@@ -222,6 +222,10 @@
 	unsigned int		inuse;		/* num of objs active in slab */
 	kmem_bufctl_t		free;
 	unsigned short          nodeid;
+#ifdef CONFIG_SLAB_OWNER
+	short			owner_idx;
+	unsigned long		owner[5];
+#endif
 };
 
 /*
@@ -2062,7 +2066,9 @@
 	slabp->inuse = 0;
 	slabp->colouroff = colour_off;
 	slabp->s_mem = objp+colour_off;
-
+#ifdef CONFIG_SLAB_OWNER
+	slabp->owner_idx = 0;
+#endif
 	return slabp;
 }
 
@@ -2502,6 +2508,13 @@
 
 		cachep->ctor(objp, cachep, ctor_flags);
 	}	
+#ifdef CONFIG_SLAB_OWNER
+	{
+	struct slab *slabp = GET_PAGE_SLAB(virt_to_page(objp));
+	if (slabp->owner_idx < 5)
+		slabp->owner[slabp->owner_idx++] = (unsigned long) caller;
+	}
+#endif
 	return objp;
 }
 #else
@@ -3604,3 +3617,131 @@
 	return buf;
 }
 EXPORT_SYMBOL(kstrdup);
+
+#ifdef CONFIG_SLAB_OWNER
+/* The slab_owner mechanism doesn't aim to be accurate, merely to give
+ * a (big) hint as to what caller is allocating objects but not releasing
+ * them. In almost every case this will be quite obvious even with only
+ * 5 caller addresses per slab saved.
+ */
+static char slab_owner_name[32];
+static unsigned long saved_addr[40];
+
+/* list fast forward 'n' elements */
+static struct list_head *list_ff(struct list_head *start, int n)
+{
+	int i;
+	struct list_head *list = start->next;
+	
+	for (i = 0; i < n; i++) {
+		list = list->next;
+		if (list == start)
+			return NULL;
+	}
+
+	return list;
+}
+
+static ssize_t
+read_slab_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	char *modname;
+	int ret = 0, x, hit = 0;
+	char namebuf[KSYM_NAME_LEN];
+	unsigned long offset = 0, symsize;
+	kmem_cache_t *kcache;
+	struct list_head *start;
+	struct kmem_list3 *rl3;
+	char *page = NULL;
+        
+	down(&cache_chain_sem);
+	list_for_each_entry(kcache, &cache_cache.next, next) {
+		if (!strcmp(kcache->name, slab_owner_name)) {
+			/* This way we'll just have to look at one element */
+			list_move(&kcache->next, &cache_cache.next);
+			hit = 1;
+			break;
+		}
+	}
+
+	if (!hit) {
+		ret = -ENOENT;
+		goto out_sem;
+	}
+
+	page = (char *) __get_free_page(GFP_KERNEL);
+	if (!page) {
+		ret = -ENOMEM;
+		goto out_sem;
+	}
+
+	rl3 = kcache->nodelists[0];
+	spin_lock_irq(&rl3->list_lock);
+	start = list_ff(&rl3->slabs_full, *ppos);
+	if (!start) {
+		ret = 0;
+		goto out_spin;
+	}
+
+	for (x = 0; x < 8; x++) {
+		struct slab *slabp = list_entry(start, struct slab, list);
+		memcpy(saved_addr + x*5, slabp->owner, sizeof(slabp->owner));
+		start = start->next;
+		
+		if (start == &rl3->slabs_full) {
+			saved_addr[x] = 0;
+			break;
+		}
+	}
+	
+	spin_unlock_irq(&rl3->list_lock);
+	up(&cache_chain_sem);
+
+	for (x = 0; x < 40; x++) {
+		if (!saved_addr[x])
+			break;
+		kallsyms_lookup(saved_addr[x], &symsize, &offset, &modname, namebuf);
+		ret += snprintf(page + ret, count - ret, "[0x%lx] %s+%lu\n",
+			saved_addr[x], namebuf, offset);
+	}
+	
+	*ppos += 8;
+	
+	if (copy_to_user(buf, page, ret))
+		ret = -EFAULT;
+
+	free_page((unsigned long) page);
+	return ret;
+
+out_spin:
+	spin_unlock_irq(&rl3->list_lock);
+out_sem:
+	up(&cache_chain_sem);
+	free_page((unsigned long) page);
+	return ret;
+}
+
+static ssize_t 
+write_slab_owner(struct file *file, const char __user *buffer,
+		size_t count, loff_t *ppos)
+{
+	char *c;
+	
+	if (count >= 32)
+		return -EINVAL;
+	if (copy_from_user(slab_owner_name, buffer, count))
+		return -EFAULT;
+	slab_owner_name[31] = '\0';
+
+	c = strchr(slab_owner_name, '\n');
+	if (c)
+		*c = '\0';
+	
+	return count;
+}
+
+struct file_operations proc_slab_owner_operations = {
+	.read = read_slab_owner,
+	.write = write_slab_owner,
+};
+#endif
Index: akpm/fs/proc/proc_misc.c
===================================================================
--- akpm.orig/fs/proc/proc_misc.c	2005-07-08 22:49:18.000000000 +0200
+++ akpm/fs/proc/proc_misc.c	2005-07-08 22:49:27.000000000 +0200
@@ -704,4 +704,12 @@
 		entry->size = 1024;
 	}
 #endif
+#ifdef CONFIG_SLAB_OWNER
+	extern struct file_operations proc_slab_owner_operations;
+	entry = create_proc_entry("slab_owner", S_IWUSR | S_IRUGO, NULL);
+	if (entry) {
+		entry->proc_fops = &proc_slab_owner_operations;
+		entry->size = 4096;
+	}
+#endif
 }
--- /dev/null	2005-04-04 14:58:41.000000000 +0200
+++ apkm/Documentation/slab_owner.c	2005-07-08 21:04:09.000000000 +0200
@@ -0,0 +1,135 @@
+/*
+ * User-space helper to sort the output of /proc/slab_owner
+ *
+ * Example use:
+ * cat /proc/slab_owner > slab_owner.txt
+ * ./sort slab_owner.txt sorted_slab_owner.txt
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
+	char *curr = buf;
+
+	for (;;) {
+		*curr = getc(fin);
+		if (*curr == EOF) 
+			return -1;
+
+		ret++;
+		if (*curr == '\n')
+			return ret - 1;
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
+	if (list_size != 0 && len == list[list_size-1].len &&
+			memcmp(buf, list[list_size-1].txt, len) == 0) {
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
+	for (i = count = 0 ; i < list_size; i++) {
+		if (count == 0 ||
+		    strcmp(list2[count-1].txt, list[i].txt) != 0) {
+			list2[count++] = list[i];
+		} else 
+			list2[count-1].num += list[i].num;
+		
+	}
+
+	qsort(list2, count, sizeof(list[0]), compare_num);
+
+	for (i = 0; i < count; i++)
+		fprintf(fout, "%d times:\n%s\n", list2[i].num, list2[i].txt);
+
+	return 0;
+}


