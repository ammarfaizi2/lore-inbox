Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267387AbUGNODY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUGNODY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUGNODY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:03:24 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:1212 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267387AbUGNODJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:03:09 -0400
Date: Wed, 14 Jul 2004 23:02:53 +0900 (JST)
Message-Id: <20040714.230253.46864310.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: Re: [PATCH] memory hotremoval for linux-2.6.7 [2/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.6.7.ORG/include/linux/swap.h	Sat Jul 10 12:30:17 2032
+++ linux-2.6.7/include/linux/swap.h	Sat Jul 10 13:47:57 2032
@@ -174,6 +174,17 @@ extern void swap_setup(void);
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
+typedef enum {
+	/* failed to write page out, page is locked */
+	PAGE_KEEP,
+	/* move page to the active list, page is locked */
+	PAGE_ACTIVATE,
+	/* page has been sent to the disk successfully, page is unlocked */
+	PAGE_SUCCESS,
+	/* page is clean and locked */
+	PAGE_CLEAN,
+} pageout_t;
+extern pageout_t pageout(struct page *, struct address_space *);
 extern int vm_swappiness;
 
 #ifdef CONFIG_MMU
--- linux-2.6.7.ORG/mm/vmscan.c	Sat Jul 10 15:13:47 2032
+++ linux-2.6.7/mm/vmscan.c	Sat Jul 10 13:48:42 2032
@@ -236,22 +241,10 @@ static void handle_write_error(struct ad
 	unlock_page(page);
 }
 
-/* possible outcome of pageout() */
-typedef enum {
-	/* failed to write page out, page is locked */
-	PAGE_KEEP,
-	/* move page to the active list, page is locked */
-	PAGE_ACTIVATE,
-	/* page has been sent to the disk successfully, page is unlocked */
-	PAGE_SUCCESS,
-	/* page is clean and locked */
-	PAGE_CLEAN,
-} pageout_t;
-
 /*
  * pageout is called by shrink_list() for each dirty page. Calls ->writepage().
  */
-static pageout_t pageout(struct page *page, struct address_space *mapping)
+pageout_t pageout(struct page *page, struct address_space *mapping)
 {
 	/*
 	 * If the page is dirty, only perform writeback if that write
