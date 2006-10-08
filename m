Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWJHUXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWJHUXt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 16:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWJHUXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 16:23:49 -0400
Received: from rs384.securehostserver.com ([72.22.69.69]:44553 "HELO
	rs384.securehostserver.com") by vger.kernel.org with SMTP
	id S1751446AbWJHUXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 16:23:49 -0400
Subject: [RFC][PATCH 1/2] grab swap token reordered
From: Ashwin Chaugule <ashwin.chaugule@celunite.com>
Reply-To: ashwin.chaugule@celunite.com
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <20061002005905.a97a7b90.akpm@osdl.org>
References: <1159555312.2141.13.camel@localhost.localdomain>
	 <20061001155608.0a464d4c.akpm@osdl.org> <1159774552.13651.80.camel@lappy>
	 <20061002005905.a97a7b90.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 01:53:41 +0530
Message-Id: <1160339021.17751.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes sure the contention for the token happens _before_ any
read-in and kicks the swap-token algo only when the VM is under
pressure.



Signed-off-by: Ashwin Chaugule <ashwin.chaugule@celunite.com>

--
diff --git a/mm/filemap.c b/mm/filemap.c
index afcdc72..c17b2ab 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1479,7 +1479,6 @@ no_cached_page:
 	 * effect.
 	 */
 	error = page_cache_read(file, pgoff);
-	grab_swap_token();
 
 	/*
 	 * The page we want has now been added to the page cache.
diff --git a/mm/memory.c b/mm/memory.c
index 92a3ebd..4a877e9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1974,6 +1974,7 @@ static int do_swap_page(struct mm_struct
 	delayacct_set_flag(DELAYACCT_PF_SWAPIN);
 	page = lookup_swap_cache(entry);
 	if (!page) {
+		grab_swap_token(); /* Contend for token _before_ read-in */
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
--

