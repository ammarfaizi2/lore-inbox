Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318215AbSGQFWz>; Wed, 17 Jul 2002 01:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318226AbSGQFUi>; Wed, 17 Jul 2002 01:20:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15628 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318218AbSGQFTJ>;
	Wed, 17 Jul 2002 01:19:09 -0400
Message-ID: <3D3500D4.A5ED22EF@zip.com.au>
Date: Tue, 16 Jul 2002 22:29:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 7/13] inline generic_writepages()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



generic_writepages() is just a wrapper around mpage_writepages(), so
inline it.



 fs/block_dev.c        |    1 +
 include/linux/mm.h    |    1 -
 include/linux/mpage.h |    5 +++++
 mm/page-writeback.c   |    6 ------
 mm/page_io.c          |    1 +
 5 files changed, 7 insertions(+), 7 deletions(-)

--- 2.5.26/mm/page-writeback.c~inline-generic_writepages	Tue Jul 16 21:46:36 2002
+++ 2.5.26-akpm/mm/page-writeback.c	Tue Jul 16 21:59:36 2002
@@ -316,12 +316,6 @@ int generic_vm_writeback(struct page *pa
 }
 EXPORT_SYMBOL(generic_vm_writeback);
 
-int generic_writepages(struct address_space *mapping, int *nr_to_write)
-{
-	return mpage_writepages(mapping, nr_to_write, NULL);
-}
-EXPORT_SYMBOL(generic_writepages);
-
 int do_writepages(struct address_space *mapping, int *nr_to_write)
 {
 	if (mapping->a_ops->writepages)
--- 2.5.26/include/linux/mpage.h~inline-generic_writepages	Tue Jul 16 21:46:36 2002
+++ 2.5.26-akpm/include/linux/mpage.h	Tue Jul 16 21:46:36 2002
@@ -16,3 +16,8 @@ int mpage_readpage(struct page *page, ge
 int mpage_writepages(struct address_space *mapping,
 		int *nr_to_write, get_block_t get_block);
 
+static inline int
+generic_writepages(struct address_space *mapping, int *nr_to_write)
+{
+	return mpage_writepages(mapping, nr_to_write, NULL);
+}
--- 2.5.26/fs/block_dev.c~inline-generic_writepages	Tue Jul 16 21:46:36 2002
+++ 2.5.26-akpm/fs/block_dev.c	Tue Jul 16 21:59:36 2002
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/blkpg.h>
 #include <linux/buffer_head.h>
+#include <linux/mpage.h>
 
 #include <asm/uaccess.h>
 
--- 2.5.26/mm/page_io.c~inline-generic_writepages	Tue Jul 16 21:46:36 2002
+++ 2.5.26-akpm/mm/page_io.c	Tue Jul 16 21:46:36 2002
@@ -17,6 +17,7 @@
 #include <linux/bio.h>
 #include <linux/swapops.h>
 #include <linux/buffer_head.h>	/* for block_sync_page() */
+#include <linux/mpage.h>
 #include <asm/pgtable.h>
 
 static struct bio *
--- 2.5.26/include/linux/mm.h~inline-generic_writepages	Tue Jul 16 21:46:36 2002
+++ 2.5.26-akpm/include/linux/mm.h	Tue Jul 16 21:59:35 2002
@@ -461,7 +461,6 @@ extern int filemap_sync(struct vm_area_s
 extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int);
 
 /* mm/page-writeback.c */
-int generic_writepages(struct address_space *mapping, int *nr_to_write);
 int write_one_page(struct page *page, int wait);
 
 /* readahead.c */

.
