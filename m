Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUHHOTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUHHOTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 10:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUHHOTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 10:19:16 -0400
Received: from colin2.muc.de ([193.149.48.15]:5637 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265383AbUHHOTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 10:19:09 -0400
Date: 8 Aug 2004 16:19:08 +0200
Date: Sun, 8 Aug 2004 16:19:08 +0200
From: Andi Kleen <ak@muc.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow to disable shmem.o
Message-ID: <20040808141908.GA94449@muc.de>
References: <m3vffulhou.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0408081248560.1443-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408081248560.1443-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 02:03:09PM +0100, Hugh Dickins wrote:
> > To make sure this doesn't happen by
> > accident I made the TMPFS configuration dependent on CONFIG_EMBEDDED.
> > This means a normal configuration enables TMPFS, which is ok 
> > since it is only minor additional overhead to shmem.o and also quite
> > useful for shared memory.
> 
> At the least you need to add a dependency on CONFIG_SYSVIPC.
> And you shouldn't disable standard functionality without
> saying so in the Kconfig help.

Hmm, right. Appended is a new patch that adds a select TMPFS to SYSVIPC.
i suspect the standard functionality is already covered by CONFIG_EMBEDDED.

> You're completely changing the meaning and configurability of
> CONFIG_TMPFS.  Perhaps it's not a useful config option any more
> (too often needed "y", too little saved by "n"), and yours is
> more useful.  But if you want to go this way, you must change
> its name and Documentation and #ifdefs too.

Perhaps, but calling it CONFIG_TMPFS is not too bad.

> I do agree that mm/shmem.o is larger (did someone at the back say
> "bloated"?) than we'd wish, that embedded in particular would like
> it smaller, and embedded might have no need to support SysV IPC
> and Posix SHM and shared anonymous and tmpfs.
> 
> But I prefer Matt's tiny tiny-shmem.c which does support all those,
> using ramfs instead, and says in Kconfig what it's doing.
> But perhaps you're wanting to avoid ramfs too?


Makes sense, adding this may be an additional useful step.
For the beginning I think my patch is fine though.

RAMFS cannot be turned off right now. I tried. 

> 
> A lot (but less than I once imagined) of the overhead in mm/shmem.o
> does come from its support for swap.  I've not been eager to pepper
> it with #ifdef CONFIG_SWAPs; but if there's a real demand for that
> I could give it a try (while abstracting away the #ifdefs as much
> as possible).

I personally don't want to turn off CONFIG_SWAP. I doubt my architecture
would even compile without that.

Andrew, please consider merging this version.

-Andi

-------------------------------------------------------

Allow to disable shmem.o by disabling CONFIG_TMPFS. This will 
disable MAP_ANONYMOUS|MAP_SHARED. To make sure this doesn't
happen by mistake make tmpfs dependent on CONFIG_EMBEDDED now.


diff -u linux-2.6.7-boot64/drivers/char/mem.c-SHMEM linux-2.6.7-boot64/drivers/char/mem.c
diff -u linux-2.6.7-boot64/include/linux/mm.h-SHMEM linux-2.6.7-boot64/include/linux/mm.h
--- linux-2.6.7-boot64/include/linux/mm.h-SHMEM	2004-06-16 12:23:40.000000000 +0200
+++ linux-2.6.7-boot64/include/linux/mm.h	2004-08-08 00:06:04.000000000 +0200
@@ -496,7 +496,15 @@
 					unsigned long addr);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
 void shmem_lock(struct file * file, int lock);
+
+#ifdef CONFIG_TMPFS
 int shmem_zero_setup(struct vm_area_struct *);
+#else
+static inline int shmem_zero_setup(struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+#endif
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
diff -u linux-2.6.7-boot64/include/linux/swap.h-SHMEM linux-2.6.7-boot64/include/linux/swap.h
--- linux-2.6.7-boot64/include/linux/swap.h-SHMEM	2004-06-16 12:23:41.000000000 +0200
+++ linux-2.6.7-boot64/include/linux/swap.h	2004-08-08 00:07:23.000000000 +0200
@@ -177,8 +177,15 @@
 extern int vm_swappiness;
 
 #ifdef CONFIG_MMU
+#ifdef CONFIG_TMPFS
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
+#else
+static inline int shmem_unuse(swp_entry_t entry, struct page *page)
+{
+	return 0;
+}
+#endif
 #endif /* CONFIG_MMU */
 
 extern void swap_unplug_io_fn(struct backing_dev_info *, struct page *);
diff -u linux-2.6.7-boot64/fs/Kconfig-SHMEM linux-2.6.7-boot64/fs/Kconfig
--- linux-2.6.7-boot64/fs/Kconfig-SHMEM	2004-06-16 12:23:18.000000000 +0200
+++ linux-2.6.7-boot64/fs/Kconfig	2004-08-08 00:07:46.000000000 +0200
@@ -914,7 +914,8 @@
 	  extended attributes for file security labels, say N.
 
 config TMPFS
-	bool "Virtual memory file system support (former shm fs)"
+	bool "Virtual memory file system support (former shm fs)" if EMBEDDED
+	default y
 	help
 	  Tmpfs is a file system which keeps all files in virtual memory.
 
diff -u linux-2.6.7-boot64/mm/Makefile-SHMEM linux-2.6.7-boot64/mm/Makefile
--- linux-2.6.7-boot64/mm/Makefile-SHMEM	2004-06-16 12:23:42.000000000 +0200
+++ linux-2.6.7-boot64/mm/Makefile	2004-08-07 23:57:49.000000000 +0200
@@ -5,13 +5,14 @@
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
-			   shmem.o vmalloc.o
+			   vmalloc.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o prio_tree.o \
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   $(mmu-y)
 
+obj-$(CONFIG_TMPFS)	+= shmem.o
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
diff -u linux-2.6.7-boot64/mm/mmap.c-SHMEM linux-2.6.7-boot64/mm/mmap.c
diff -u linux-2.6.7-boot64/mm/swapfile.c-SHMEM linux-2.6.7-boot64/mm/swapfile.c
diff -u linux-2.6.7-boot64/init/Kconfig-SHMEM linux-2.6.7-boot64/init/Kconfig
--- linux-2.6.7-boot64/init/Kconfig-SHMEM	2004-06-16 12:23:42.000000000 +0200
+++ linux-2.6.7-boot64/init/Kconfig	2004-08-08 16:12:50.000000000 +0200
@@ -77,6 +77,7 @@
 
 config SYSVIPC
 	bool "System V IPC"
+	select TMPFS
 	---help---
 	  Inter Process Communication is a suite of library functions and
 	  system calls which let processes (running programs) synchronize and
