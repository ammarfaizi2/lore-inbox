Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSEFHZR>; Mon, 6 May 2002 03:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314244AbSEFHZQ>; Mon, 6 May 2002 03:25:16 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:5137 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314243AbSEFHZP>; Mon, 6 May 2002 03:25:15 -0400
Date: Mon, 6 May 2002 17:27:41 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: bgerst@didntduck.org, torvalds@transmeta.com, davej@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu updates
Message-Id: <20020506172741.6a7213b4.rusty@rustcorp.com.au>
In-Reply-To: <3CD4B042.A4355FD3@zip.com.au>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 May 2002 21:08:34 -0700
Andrew Morton <akpm@zip.com.au> wrote:

> And again, the numbers in /proc/meminfo are whacko:
> 
> LowFree:         94724 kB
> SwapTotal:     4000040 kB
> SwapFree:      3999700 kB
> Dirty:            7232 kB
> Writeback:    4294967264 kB

Hmmm.... I've just applied the page-flags.h and page_alloc.c changes,
and I don't get this problem at all on my 2xi386 box on 2.5.13.  I 
even changed the name of "page_states" to "xpage_states" to find any
other references, and inserted a BUG() if it was being dereferenced
before per-cpu offsets were initialized.

Here's the diff: do you see problems when booting with this?
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.13/include/asm-generic/percpu.h working-2.5.13-page-per-cpu/include/asm-generic/percpu.h
--- linux-2.5.13/include/asm-generic/percpu.h	Mon Apr 15 11:47:44 2002
+++ working-2.5.13-page-per-cpu/include/asm-generic/percpu.h	Mon May  6 17:00:55 2002
@@ -5,6 +5,7 @@
 #include <linux/compiler.h>
 
 extern unsigned long __per_cpu_offset[NR_CPUS];
+extern int per_cpu_areas_done;
 
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&var, __per_cpu_offset[cpu]))
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.13/include/linux/page-flags.h working-2.5.13-page-per-cpu/include/linux/page-flags.h
--- linux-2.5.13/include/linux/page-flags.h	Mon May  6 11:12:01 2002
+++ working-2.5.13-page-per-cpu/include/linux/page-flags.h	Mon May  6 17:01:43 2002
@@ -42,6 +42,8 @@
  * address space...
  */
 
+#include <linux/percpu.h>
+
 /*
  * Don't use the *_dontuse flags.  Use the macros.  Otherwise you'll break
  * locked- and dirty-page accounting.  The top eight bits of page->flags are
@@ -69,18 +71,21 @@
 /*
  * Global page accounting.  One instance per CPU.
  */
-extern struct page_state {
+struct page_state {
 	unsigned long nr_dirty;
 	unsigned long nr_writeback;
 	unsigned long nr_pagecache;
-} ____cacheline_aligned_in_smp page_states[NR_CPUS];
+};
+
+extern struct page_state __per_cpu_data xpage_states;
 
 extern void get_page_state(struct page_state *ret);
 
 #define mod_page_state(member, delta)					\
 	do {								\
 		preempt_disable();					\
-		page_states[smp_processor_id()].member += (delta);	\
+		if (!per_cpu_areas_done) BUG();				\
+		this_cpu(xpage_states).member += (delta);		\
 		preempt_enable();					\
 	} while (0)
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.13/init/main.c working-2.5.13-page-per-cpu/init/main.c
--- linux-2.5.13/init/main.c	Wed May  1 15:09:29 2002
+++ working-2.5.13-page-per-cpu/init/main.c	Mon May  6 16:55:22 2002
@@ -278,6 +278,7 @@
 
 #ifdef __GENERIC_PER_CPU
 unsigned long __per_cpu_offset[NR_CPUS];
+int per_cpu_areas_done;
 
 static void __init setup_per_cpu_areas(void)
 {
@@ -297,6 +298,7 @@
 		__per_cpu_offset[i] = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, size);
 	}
+	per_cpu_areas_done = 1;
 }
 #endif /* !__GENERIC_PER_CPU */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.13/mm/page_alloc.c working-2.5.13-page-per-cpu/mm/page_alloc.c
--- linux-2.5.13/mm/page_alloc.c	Mon May  6 11:12:01 2002
+++ working-2.5.13-page-per-cpu/mm/page_alloc.c	Mon May  6 17:02:20 2002
@@ -576,8 +576,8 @@
  * The result is unavoidably approximate - it can change
  * during and after execution of this function.
  */
-struct page_state page_states[NR_CPUS] __cacheline_aligned;
-EXPORT_SYMBOL(page_states);
+struct page_state __per_cpu_data xpage_states;
+EXPORT_SYMBOL(xpage_states);
 
 void get_page_state(struct page_state *ret)
 {
@@ -590,7 +590,7 @@
 	for (pcpu = 0; pcpu < smp_num_cpus; pcpu++) {
 		struct page_state *ps;
 
-		ps = &page_states[cpu_logical_map(pcpu)];
+		ps = &per_cpu(xpage_states,cpu_logical_map(pcpu));
 		ret->nr_dirty += ps->nr_dirty;
 		ret->nr_writeback += ps->nr_writeback;
 		ret->nr_pagecache += ps->nr_pagecache;
