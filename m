Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317004AbSFAIlc>; Sat, 1 Jun 2002 04:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316993AbSFAIka>; Sat, 1 Jun 2002 04:40:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50186 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316994AbSFAIj0>;
	Sat, 1 Jun 2002 04:39:26 -0400
Message-ID: <3CF88908.179B10BF@zip.com.au>
Date: Sat, 01 Jun 2002 01:42:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 10/16] give swapper_space a set_page_dirty a_op
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Give swapper_space a ->set_page_dirty() address_space_operation.

So swapcache pages do not need special-casing in
set_page_dirty_buffers().



=====================================

--- 2.5.19/mm/swap_state.c~swap-set_page_dirty	Sat Jun  1 01:18:11 2002
+++ 2.5.19-akpm/mm/swap_state.c	Sat Jun  1 01:18:11 2002
@@ -48,9 +48,10 @@ static int swap_vm_writeback(struct page
 }
 
 static struct address_space_operations swap_aops = {
-	vm_writeback: swap_vm_writeback,
-	writepage: swap_writepage,
-	sync_page: block_sync_page,
+	vm_writeback:	swap_vm_writeback,
+	writepage:	swap_writepage,
+	sync_page:	block_sync_page,
+	set_page_dirty:	__set_page_dirty_nobuffers,
 };
 
 /*
--- 2.5.19/mm/page-writeback.c~swap-set_page_dirty	Sat Jun  1 01:18:11 2002
+++ 2.5.19-akpm/mm/page-writeback.c	Sat Jun  1 01:18:11 2002
@@ -497,7 +497,7 @@ int __set_page_dirty_buffers(struct page
 
 	spin_lock(&mapping->private_lock);
 
-	if (page_has_buffers(page) && !PageSwapCache(page)) {
+	if (page_has_buffers(page)) {
 		struct buffer_head *head = page_buffers(page);
 		struct buffer_head *bh = head;
 


-
