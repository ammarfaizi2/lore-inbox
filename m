Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310284AbSCBCqP>; Fri, 1 Mar 2002 21:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310283AbSCBCqM>; Fri, 1 Mar 2002 21:46:12 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:38234 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310284AbSCBCpv>; Fri, 1 Mar 2002 21:45:51 -0500
Date: Sat, 2 Mar 2002 03:44:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: early ioremap not working with 2.4.19-pre1-aa1 ?
Message-ID: <20020302034448.M4431@inspiron.random>
In-Reply-To: <174730000.1015026374@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174730000.1015026374@flay>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 03:46:14PM -0800, Martin J. Bligh wrote:
> I have code for the NUMA-Q systems that does an ioremap
> as the first thing in smp_boot_cpus (ia32 tree). This seems to 
> work fine until I install the aa patches ... then it hangs in the 
> ioremap.

this sounds like the same problem of the MXT patch. In short pte_alloc
and in turn ioremap was usable only after the initcalls.

Does this incremental patch fix it?  (untested)

--- 2.4.19pre1aa1/include/linux/highmem.h.~1~	Fri Mar  1 20:19:05 2002
+++ 2.4.19pre1aa1/include/linux/highmem.h	Sat Mar  2 03:43:42 2002
@@ -12,6 +12,7 @@
 
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
+extern void init_kmap(void);
 
 extern struct buffer_head *create_bounce(int rw, struct buffer_head * bh_orig);
 
@@ -64,6 +65,7 @@
 #else /* CONFIG_HIGHMEM */
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
+#define init_kmap() do { } while(0)
 
 static inline void *kmap(struct page *page) { return page_address(page); }
 
--- 2.4.19pre1aa1/init/main.c.~1~	Wed Feb 27 12:46:19 2002
+++ 2.4.19pre1aa1/init/main.c	Sat Mar  2 03:42:52 2002
@@ -599,6 +599,7 @@
 	mem_init();
 	kmem_cache_sizes_init();
 	pgtable_cache_init();
+	init_kmap();
 
 #ifdef CONFIG_PERFMON
 	perfmon_init();
--- 2.4.19pre1aa1/mm/highmem.c.~1~	Wed Feb 27 12:46:13 2002
+++ 2.4.19pre1aa1/mm/highmem.c	Sat Mar  2 03:43:50 2002
@@ -45,7 +45,7 @@
 
 static wait_queue_head_t pkmap_map_wait[KM_NR_SERIES];
 
-static __init int init_kmap(void)
+void __init init_kmap(void)
 {
 	int i;
 
@@ -56,7 +56,6 @@
 #endif
 	return 0;
 }
-__initcall(init_kmap);
 
 static void flush_all_zero_pkmaps(void)
 {
> 
> Has anyone got any idea why this might be? I'd really like to
> test out the -aa vm patches on this box ... I can debug it some
> more - just looking for an easy answer ;-)
> 
> Thanks,
> 
> Martin.


Andrea
