Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSJHSGo>; Tue, 8 Oct 2002 14:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSJHSGd>; Tue, 8 Oct 2002 14:06:33 -0400
Received: from mailout.mbnet.fi ([194.100.161.24]:36361 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id <S261305AbSJHSEo> convert rfc822-to-8bit;
	Tue, 8 Oct 2002 14:04:44 -0400
Message-ID: <001101c26ef8$fcd41f20$4fa564c2@windows>
From: "Matti Annala" <gval@mbnet.fi>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] page_alloc.c and mincore.c
Date: Tue, 8 Oct 2002 21:31:56 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-OriginalArrivalTime: 08 Oct 2002 19:07:17.0481 (UTC) FILETIME=[EB648590:01C26EFD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one removes a strange unused parameter in balance_classzone() and also slightly cleans up __alloc_pages().

--- page_alloc.c.orig 2002-10-06 19:46:06.000000000 +0300
+++ page_alloc.c 2002-10-06 19:47:52.000000000 +0300
@@ -259,17 +259,17 @@
 
 static /* inline */ struct page *
 balance_classzone(struct zone* classzone, unsigned int gfp_mask,
-   unsigned int order, int * freed)
+   unsigned int order)
 {
  struct page * page = NULL;
- int __freed = 0;
+ int freed = 0;
 
  BUG_ON(in_interrupt());
 
  current->allocation_order = order;
  current->flags |= PF_MEMALLOC | PF_FREE_PAGES;
 
- __freed = try_to_free_pages(classzone, gfp_mask, order);
+ freed = try_to_free_pages(classzone, gfp_mask, order);
 
  current->flags &= ~(PF_MEMALLOC | PF_FREE_PAGES);
 
@@ -280,7 +280,7 @@
 
   local_pages = &current->local_pages;
 
-  if (likely(__freed)) {
+  if (likely(freed)) {
    /* pick from the last inserted so we're lifo */
    entry = local_pages->next;
    do {
@@ -306,7 +306,6 @@
   }
   current->nr_local_pages = 0;
  }
- *freed = __freed;
  return page;
 }
 
@@ -320,7 +319,7 @@
  unsigned long min;
  struct zone **zones, *classzone;
  struct page * page;
- int freed, i;
+ int i;
 
  if (gfp_mask & __GFP_WAIT)
   might_sleep();
@@ -397,7 +396,7 @@
   goto nopage;
 
  inc_page_state(allocstall);
- page = balance_classzone(classzone, gfp_mask, order, &freed);
+ page = balance_classzone(classzone, gfp_mask, order);
  if (page)
   return page;
 
------------------------------

This one fixes a typo in mm/mincore.c

--- mincore.c.orig 2002-10-06 19:51:10.000000000 +0300
+++ mincore.c 2002-10-06 19:51:20.000000000 +0300
@@ -59,7 +59,7 @@
   return error;
 
  /* (end - start) is # of pages, and also # of bytes in "vec */
- remaining = (end - start),
+ remaining = (end - start);
 
  error = 0;
  for (i = 0; remaining > 0; remaining -= PAGE_SIZE, i++) {


