Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKIQU7>; Thu, 9 Nov 2000 11:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKIQUt>; Thu, 9 Nov 2000 11:20:49 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:56583 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S129060AbQKIQUf>; Thu, 9 Nov 2000 11:20:35 -0500
Date: Thu, 9 Nov 2000 18:30:32 +0100 (MET)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] Reserve VM for root (was: Re: Looking for better VM)
In-Reply-To: <Pine.LNX.4.05.10011081450320.3666-100000@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0011091731100.1155-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Nov 2000, Rik van Riel wrote:

> OK. This is a lot more reasonable. 

Just the same what was in my first in email.

> I'm actually looking into putting non-overcommit as a configurable
> option in the kernel.

Nice to hear, please make it a boot time option, not a compile time
one. Also a control for how many percent the kernel can overcommit
would be nice -- this is how modern Unices do.
 
> However, this does not save you from the fact that the
> system is essentially deadlocked when nothing can get
> more memory and nothing goes away. 

I've also never said OOM killer should be disabled. In theory the
non-overcommitting systems deadlock, Linux survives. Ironically
usually it's just the opposite in practice. Any user can
deadlock/crash Linux [default install, no quotas] but not an
non-overcommitting system [root can clean up]. Here is an example code
"simulating" a leaking daemon that will "deadlock" Linux even with
your OOM killer patch [that is anyway *MUCH* better than the actually
non-existing one in 2.2.x kernels]:

main() { while(1) if (fork()) malloc(1); }

With the patch below I could ssh to the host and killall the offending
processes. To enable reserving VM space for root do 

echo -1 > /proc/sys/vm/overcommit_memory 

The number of reserved pages can be tuned via /proc/sys/vm/reserved,
default is 5% of the RAM (note, RAM won't be reserved, but VM).

BTW, I wanted to take a look at the frequently mentioned beancounter patch, 
here is the current state,
	http://www.asp-linux.com/en/products/ubpatch.shtml 
"Sorry, due to growing expenses for support of public version of ASPcomplete 
we do not provide sources till first official release."

	Szaka


diff -ur linux.orig/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux.orig/include/linux/sysctl.h	Thu Nov  9 08:20:19 2000
+++ linux/include/linux/sysctl.h	Thu Nov  9 06:30:11 2000
@@ -122,7 +122,8 @@
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
 	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
-	VM_PAGE_CLUSTER=10	/* int: set number of pages to swap together */
+	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
+	VM_RESERVED=11		/* int: number of pages reserved for root */
 };
 
 
diff -ur linux.orig/kernel/sysctl.c linux/kernel/sysctl.c
--- linux.orig/kernel/sysctl.c	Thu Nov  9 08:20:19 2000
+++ linux/kernel/sysctl.c	Thu Nov  9 06:27:33 2000
@@ -37,6 +37,7 @@
 extern int bdf_prm[], bdflush_min[], bdflush_max[];
 extern char binfmt_java_interpreter[], binfmt_java_appletviewer[];
 extern int sysctl_overcommit_memory;
+extern int vm_reserved;
 extern int nr_queued_signals, max_queued_signals;
 
 #ifdef CONFIG_KMOD
@@ -259,6 +260,8 @@
 	 &pgt_cache_water, 2*sizeof(int), 0600, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
 	 &page_cluster, sizeof(int), 0600, NULL, &proc_dointvec},
+	{VM_RESERVED, "reserved", 
+	 &vm_reserved, sizeof(int), 0600, NULL, &proc_dointvec},
 	{0}
 };
 
diff -ur linux.orig/mm/mmap.c linux/mm/mmap.c
--- linux.orig/mm/mmap.c	Thu Nov  9 08:20:19 2000
+++ linux/mm/mmap.c	Thu Nov  9 08:17:10 2000
@@ -40,6 +40,7 @@
 kmem_cache_t *vm_area_cachep;
 
 int sysctl_overcommit_memory;
+int vm_reserved;
 
 /* Check that a process has enough memory to allocate a
  * new virtual mapping.
@@ -59,7 +60,7 @@
 	long free;
 	
         /* Sometimes we want to use more memory than we have. */
-	if (sysctl_overcommit_memory)
+	if (sysctl_overcommit_memory == 1)
 	    return 1;
 
 	free = buffermem >> PAGE_SHIFT;
@@ -67,6 +68,8 @@
 	free += nr_free_pages;
 	free += nr_swap_pages;
 	free -= (page_cache.min_percent + buffer_mem.min_percent + 2)*num_physpages/100; 
+	if (sysctl_overcommit_memory == -1 && current->uid && free < vm_reserved)
+		return 0;
 	return free > pages;
 }
 
@@ -872,6 +875,11 @@
 
 void __init vma_init(void)
 {
+	struct sysinfo i;
+
+	si_meminfo(&i);
+	vm_reserved = (i.totalram >> PAGE_SHIFT) / 20;  
+
 	vm_area_cachep = kmem_cache_create("vm_area_struct",
 					   sizeof(struct vm_area_struct),
 					   0, SLAB_HWCACHE_ALIGN,

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
