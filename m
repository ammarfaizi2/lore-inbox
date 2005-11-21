Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVKUNXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVKUNXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 08:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVKUNXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 08:23:46 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:20384 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750718AbVKUNXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 08:23:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=m8ZOZqyarXIkPft+qzz/5UW4Ybk8pNzXulPnCAU4ohx3srLC1vls5vQNdJmD4XdgzIvRaLOdw4T54qDBbpCUpFmFy7/iMzpipfioTrtxPJQI82kbcbgcwMvXqCXIuYFsJyCickiMB1kNZQt2VyhROYrz4uTi825qUNy/d4kXvSU=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121123942.14370.90399.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 1/12] mm: free_pages_and_swap_cache opt
Date: Mon, 21 Nov 2005 08:23:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor optimization (though it doesn't help in the PREEMPT case, severely
constrained by small ZAP_BLOCK_SIZE).  free_pages_and_swap_cache works in
chunks of 16, calling release_pages which works in chunks of PAGEVEC_SIZE.
But PAGEVEC_SIZE was dropped from 16 to 14 in 2.6.10, so we're now doing
more spin_lock_irq'ing than necessary: use PAGEVEC_SIZE throughout.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c
+++ linux-2.6/mm/swap_state.c
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/backing-dev.h>
+#include <linux/pagevec.h>
 
 #include <asm/pgtable.h>
 
@@ -272,12 +273,11 @@ void free_page_and_swap_cache(struct pag
  */
 void free_pages_and_swap_cache(struct page **pages, int nr)
 {
-	int chunk = 16;
 	struct page **pagep = pages;
 
 	lru_add_drain();
 	while (nr) {
-		int todo = min(chunk, nr);
+		int todo = min(nr, PAGEVEC_SIZE);
 		int i;
 
 		for (i = 0; i < todo; i++)
Send instant messages to your online friends http://au.messenger.yahoo.com 
