Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTEUH7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTEUH4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:56:08 -0400
Received: from zeus.kernel.org ([204.152.189.113]:37591 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261785AbTEUHn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:43:27 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH 1/3] Per-cpu UP unification 
Cc: linux-kernel@vger.kernel.org, davidm@hpl.hp.com, dipankar@in.ibm.com
In-reply-to: Your message of "Tue, 20 May 2003 03:53:22 MST."
             <20030520035322.27211c07.akpm@digeo.com> 
Date: Wed, 21 May 2003 12:02:39 +1000
Message-Id: <20030521022932.E29212C015@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030520035322.27211c07.akpm@digeo.com> you write:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > [ Untested on ia64, but fairly trivial if I've broken something ].
> > 
> > Name: Unification of per-cpu headers for non-SMP
> > Author: Rusty Russell
> > Status: Trivial
> 
> I applied all these to the ppc64 kernel (you missed ppc64 btw) and it dies.
> 
> Quite late in boot, during floppy_init->init_disk_stats->alloc_percpu.
> 
> I'm reduced to debugging with printk on ppc64.  __alloc_percpu() calls
> new_block(), loops around and then dies in here:

Hmm, Works For Me(TM).  Here's my test code: change
init_alloc_percpu() to call test_percpu() explicitly at the end (so
before you hit the current bug).

I'll test on bk14 here, and if that passes I'll seek a PPC64 box...

Thanks!
Rusty.

Name: kmalloc testing patch
Author: Rusty Russell
Status: Tested on 2.5.69-bk13
Depends: Misc/kmalloc_percpu-full.patch.gz

D: This adds simple test code to kmalloc percpu.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.69-bk13-kmalloc_percpu-full/mm/percpu.c working-2.5.69-bk13-kmalloc_percpu-debug/mm/percpu.c
--- working-2.5.69-bk13-kmalloc_percpu-full/mm/percpu.c	2003-05-20 12:54:21.000000000 +1000
+++ working-2.5.69-bk13-kmalloc_percpu-debug/mm/percpu.c	2003-05-20 12:53:47.000000000 +1000
@@ -245,6 +245,159 @@ void free_percpu(const void *freeme)
 	BUG();
 }
 
+#if 1
+#include <linux/random.h>
+
+static void check_values(unsigned int *ptrs[],
+			 unsigned int sizes[],
+			 unsigned int num)
+{
+	unsigned int cpu, i;
+	unsigned char *ptr;
+
+	if (!ptrs[num])
+		return;
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		ptr = (unsigned char *)per_cpu_ptr(ptrs[num], cpu);
+		for (i = 0; i < sizes[num]; i++) {
+			if (ptr[i] != (unsigned char)(num + cpu))
+				BUG();
+		}
+	}
+}
+
+static void check_blocklen(void)
+{
+	struct pcpu_block *i;
+	unsigned int count = 0;
+
+	list_for_each_entry(i, &pcpu_blocks, list)
+		count++;
+
+	printk("Total blocks = %u\n", count);
+}
+
+static void dump_blocks(const char *start_or_end)
+{
+	struct pcpu_block *i;
+
+	list_for_each_entry(i, &pcpu_blocks, list) {
+		int expected_blocks = 1;
+
+		if (i->base_ptr == percpu_base)
+			expected_blocks = 2;
+		if (i->num_used != expected_blocks) {
+			printk("Block %p has %u subs at %s\n",
+			       i->base_ptr, i->num_used, start_or_end);
+		}
+	}
+}	
+
+static void mymemset(void *ptr, int c, unsigned long len)
+{
+	unsigned char *p = ptr;
+	while (len > 0) {
+		*p = c;
+		p++;
+		len--;
+	}
+}		
+
+static int random(void)
+{
+	unsigned short s;
+
+	get_random_bytes(&s, sizeof(s));
+	return s;
+}
+
+static int test_percpu(void)
+{
+	unsigned int i, allocs, frees;
+	unsigned int *ptr;
+	static unsigned int *ptrs[PERCPU_MAX], sizes[PERCPU_MAX];
+
+	dump_blocks("start");
+	allocs = frees = 0;
+	ptr = __alloc_percpu(4, 4); allocs++;
+	printk("This cpu = %p (%u)\n",
+	       __get_cpu_ptr(ptr), *__get_cpu_ptr(ptr));
+	for (i = 0; i < NR_CPUS; i++) {
+		printk("&ptr[i] == %p (%u)\n",
+		       per_cpu_ptr(ptr, i), *per_cpu_ptr(ptr, i));
+		*per_cpu_ptr(ptr, i) = i;
+	}
+	free_percpu(ptr); frees++;
+
+	BUG_ON(allocs != frees);
+
+	for (i = 4; i < PERCPU_MAX; i+=27) {
+		unsigned int j;
+		ptrs[i] = __alloc_percpu(i, 4); allocs++;
+		for (j = 0; j < NR_CPUS; j++) {
+			mymemset(per_cpu_ptr(ptrs[i], j), 0, i);
+			*per_cpu_ptr(ptrs[i], j) = i;
+		}
+	}
+
+	for (i = 4; i < PERCPU_MAX; i+=27) {
+		unsigned int j;
+		for (j = 0; j < NR_CPUS; j++)
+			if (*per_cpu_ptr(ptrs[i], j) != i)
+				BUG();
+	}
+	for (i = 4; i < PERCPU_MAX; i+=27) {
+		free_percpu(ptrs[i]); frees++;
+		ptrs[i] = NULL;
+	}
+
+	BUG_ON(allocs != frees);
+
+	/* Randomized test. */
+	for (i = 0; i < 10000; i++) {
+		unsigned int j = random() % PERCPU_MAX;
+		if (!ptrs[j]) {
+			unsigned int cpu;
+
+			sizes[j] = random() % PERCPU_MAX;
+			if (sizes[j] < 4)
+				sizes[j] = 4;
+			ptrs[j] = __alloc_percpu(sizes[j], 1<<(random()%L1_CACHE_SHIFT));
+			allocs++;
+
+			for (cpu = 0; cpu < NR_CPUS; cpu++)
+				memset(per_cpu_ptr(ptrs[j], cpu), j+cpu,
+				       sizes[j]);
+		} else {
+			if (random() % 1000 == 0) {
+				printk("c\n");
+				for (j = 0; j < PERCPU_MAX; j++)
+					check_values(ptrs, sizes, j);
+			} else {
+				check_values(ptrs, sizes, j);
+				free_percpu(ptrs[j]); frees++;
+				ptrs[j] = NULL;
+			}
+		}
+		if (i % (10000/10) == 0)
+			printk(".\n");
+	}
+	check_blocklen();
+
+	for (i = 0; i < PERCPU_MAX; i++) {
+		if (ptrs[i]) {
+			free_percpu(ptrs[i]); frees++;
+			ptrs[i] = NULL;
+		}
+	}
+	BUG_ON(allocs != frees);
+	dump_blocks("end");
+	return 0;
+}
+late_initcall(test_percpu);
+#endif
+
 unsigned long __per_cpu_offset[NR_CPUS];
 EXPORT_SYMBOL(__per_cpu_offset);
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
