Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTH1Iil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 04:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263610AbTH1Iil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:38:41 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:54682 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263843AbTH1Ho1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 03:44:27 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v850]  Guard some symbol exports with #ifdef CONFIG_MMU
References: <20030828051553.8E6203718@mcspd15.ucom.lsi.nec.co.jp>
	<20030828082324.A32093@infradead.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 28 Aug 2003 16:44:06 +0900
In-Reply-To: <20030828082324.A32093@infradead.org>
Message-ID: <buoy8xe8bw9.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
> What about moving the exports to the definitions instead?

Sounds good to me; how's this (it compiles on a no-MMU system, but ...):


diff -ruN -X../cludes linux-2.6.0-test4-uc0/kernel/ksyms.c linux-2.6.0-test4-uc0-v850-20030828/kernel/ksyms.c
--- linux-2.6.0-test4-uc0/kernel/ksyms.c	2003-08-25 13:23:54.000000000 +0900
+++ linux-2.6.0-test4-uc0-v850-20030828/kernel/ksyms.c	2003-08-28 16:36:28.000000000 +0900
@@ -120,7 +120,6 @@
 EXPORT_SYMBOL(max_mapnr);
 #endif
 EXPORT_SYMBOL(high_memory);
-EXPORT_SYMBOL_GPL(invalidate_mmap_range);
 EXPORT_SYMBOL(vmtruncate);
 EXPORT_SYMBOL(find_vma);
 EXPORT_SYMBOL(get_unmapped_area);
@@ -198,7 +197,6 @@
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
 EXPORT_SYMBOL(truncate_inode_pages);
-EXPORT_SYMBOL(install_page);
 EXPORT_SYMBOL(fsync_bdev);
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(vfs_permission);
diff -ruN -X../cludes linux-2.6.0-test4-uc0/mm/fremap.c linux-2.6.0-test4-uc0-v850-20030828/mm/fremap.c
--- linux-2.6.0-test4-uc0/mm/fremap.c	2003-05-27 11:31:39.000000000 +0900
+++ linux-2.6.0-test4-uc0-v850-20030828/mm/fremap.c	2003-08-28 16:38:39.000000000 +0900
@@ -3,7 +3,7 @@
  * 
  * Explicit pagetable population and nonlinear (random) mappings support.
  *
- * started by Ingo Molnar, Copyright (C) 2002
+ * started by Ingo Molnar, Copyright (C) 2002, 2003
  */
 
 #include <linux/mm.h>
@@ -13,6 +13,8 @@
 #include <linux/pagemap.h>
 #include <linux/swapops.h>
 #include <linux/rmap-locking.h>
+#include <linux/module.h>
+
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
@@ -95,6 +97,8 @@
 err:
 	return err;
 }
+EXPORT_SYMBOL(install_page);
+
 
 /***
  * sys_remap_file_pages - remap arbitrary pages of a shared backing store
diff -ruN -X../cludes linux-2.6.0-test4-uc0/mm/memory.c linux-2.6.0-test4-uc0-v850-20030828/mm/memory.c
--- linux-2.6.0-test4-uc0/mm/memory.c	2003-08-25 13:27:38.000000000 +0900
+++ linux-2.6.0-test4-uc0-v850-20030828/mm/memory.c	2003-08-28 16:38:53.000000000 +0900
@@ -45,6 +45,7 @@
 #include <linux/pagemap.h>
 #include <linux/vcache.h>
 #include <linux/rmap-locking.h>
+#include <linux/module.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -1138,6 +1139,7 @@
 		invalidate_mmap_range_list(&mapping->i_mmap_shared, hba, hlen);
 	up(&mapping->i_shared_sem);
 }
+EXPORT_SYMBOL_GPL(invalidate_mmap_range);
 
 /*
  * Handle all mappings that got truncated by a "truncate()"



-Miles
-- 
I'm beginning to think that life is just one long Yoko Ono album; no rhyme
or reason, just a lot of incoherent shrieks and then it's over.  --Ian Wolff
