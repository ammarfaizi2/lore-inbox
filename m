Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVANGOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVANGOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 01:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVANGOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 01:14:40 -0500
Received: from opersys.com ([64.40.108.71]:64272 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261924AbVANGD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 01:03:57 -0500
Message-ID: <41E7628F.8040902@opersys.com>
Date: Fri, 14 Jan 2005 01:11:27 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH 6/8 ] ltt for 2.6.10 : mm/ events
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


signed-off-by: Karim Yaghmour (karim@opersys.com)

--- linux-2.6.10-relayfs/mm/filemap.c	2004-12-24 16:35:50.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/mm/filemap.c	2005-01-13 22:21:51.000000000 -0500
@@ -28,6 +28,7 @@
 #include <linux/blkdev.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/ltt-events.h>
 /*
  * This is needed for the following functions:
  *  - try_to_release_page
@@ -402,9 +403,13 @@ void fastcall wait_on_page_bit(struct pa
 {
 	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);

+	ltt_ev_memory(LTT_EV_MEMORY_PAGE_WAIT_START, 0);
+
 	if (test_bit(bit_nr, &page->flags))
 		__wait_on_bit(page_waitqueue(page), &wait, sync_page,
 							TASK_UNINTERRUPTIBLE);
+
+	ltt_ev_memory(LTT_EV_MEMORY_PAGE_WAIT_END, 0);
 }
 EXPORT_SYMBOL(wait_on_page_bit);

--- linux-2.6.10-relayfs/mm/memory.c	2004-12-24 16:34:44.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/mm/memory.c	2005-01-13 22:21:51.000000000 -0500
@@ -47,6 +47,9 @@
 #include <linux/module.h>
 #include <linux/init.h>

+#include <linux/module.h>
+#include <linux/ltt-events.h>
+
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
@@ -1346,6 +1349,7 @@ static int do_swap_page(struct mm_struct
 	spin_unlock(&mm->page_table_lock);
 	page = lookup_swap_cache(entry);
 	if (!page) {
+	        ltt_ev_memory(LTT_EV_MEMORY_SWAP_IN, address);
  		swapin_readahead(entry, address, vma);
  		page = read_swap_cache_async(entry, vma, address);
 		if (!page) {
--- linux-2.6.10-relayfs/mm/page_alloc.c	2004-12-24 16:33:51.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/mm/page_alloc.c	2005-01-13 22:21:51.000000000 -0500
@@ -32,6 +32,7 @@
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/nodemask.h>
+#include <linux/ltt-events.h>

 #include <asm/tlbflush.h>

@@ -278,6 +279,8 @@ void __free_pages_ok(struct page *page,
 	LIST_HEAD(list);
 	int i;

+	ltt_ev_memory(LTT_EV_MEMORY_PAGE_FREE, order);
+
 	arch_free_page(page, order);

 	mod_page_state(pgfree, 1 << order);
@@ -752,6 +755,7 @@ fastcall unsigned long __get_free_pages(
 	page = alloc_pages(gfp_mask, order);
 	if (!page)
 		return 0;
+	ltt_ev_memory(LTT_EV_MEMORY_PAGE_ALLOC, order);
 	return (unsigned long) page_address(page);
 }

--- linux-2.6.10-relayfs/mm/page_io.c	2004-12-24 16:33:59.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/mm/page_io.c	2005-01-13 22:21:51.000000000 -0500
@@ -17,6 +17,7 @@
 #include <linux/bio.h>
 #include <linux/swapops.h>
 #include <linux/writeback.h>
+#include <linux/ltt-events.h>
 #include <asm/pgtable.h>

 static struct bio *get_swap_bio(int gfp_flags, pgoff_t index,
@@ -103,6 +104,7 @@ int swap_writepage(struct page *page, st
 	inc_page_state(pswpout);
 	set_page_writeback(page);
 	unlock_page(page);
+	ltt_ev_memory(LTT_EV_MEMORY_SWAP_OUT, (unsigned long) page);
 	submit_bio(rw, bio);
 out:
 	return ret;


