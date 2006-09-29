Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161478AbWI2TEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161478AbWI2TEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161481AbWI2TEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:04:45 -0400
Received: from rs384.securehostserver.com ([72.22.69.69]:43012 "HELO
	rs384.securehostserver.com") by vger.kernel.org with SMTP
	id S1161478AbWI2TEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:04:43 -0400
Subject: [RFC][PATCH 1/2] Swap token re-tuned
From: Ashwin Chaugule <ashwin.chaugule@celunite.com>
Reply-To: ashwin.chaugule@celunite.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 30 Sep 2006 00:34:36 +0530
Message-Id: <1159556677.2141.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to grab swap token before the VM selects pages for eviction. 


Signed-off-by: Ashwin Chaugule <ashwin.chaugule@celunite.com> 


diff --git a/mm/filemap.c b/mm/filemap.c
index afcdc72..190d2c1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1478,8 +1478,8 @@ no_cached_page:
 	 * We're only likely to ever get here if MADV_RANDOM is in
 	 * effect.
 	 */
+	grab_swap_token(); /* Contend for token _before_ we read-in */
 	error = page_cache_read(file, pgoff);
-	grab_swap_token();
 
 	/*
 	 * The page we want has now been added to the page cache.
diff --git a/mm/memory.c b/mm/memory.c
index 92a3ebd..52eb9b8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1974,6 +1974,7 @@ static int do_swap_page(struct mm_struct
 	delayacct_set_flag(DELAYACCT_PF_SWAPIN);
 	page = lookup_swap_cache(entry);
 	if (!page) {
+		grab_swap_token(); /* Contend for token _before_ we read-in */
  		swapin_readahead(entry, address, vma);
  		page = read_swap_cache_async(entry, vma, address);
 		if (!page) {
@@ -1991,7 +1992,6 @@ static int do_swap_page(struct mm_struct
 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
-		grab_swap_token();
 	}
 
 	delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
diff --git a/mm/thrash.c b/mm/thrash.c


