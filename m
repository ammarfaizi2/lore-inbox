Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUIEXFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUIEXFM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 19:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUIEXFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 19:05:12 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:15058 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267334AbUIEXFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 19:05:01 -0400
Date: Sun, 5 Sep 2004 23:49:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Marcelo Tosatti <marcelo.tosatte@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] __set_page_dirty_nobuffers mappings
Message-ID: <Pine.LNX.4.44.0409052347180.3218-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo noticed that the BUG_ON in __set_page_dirty_nobuffers doesn't
make much sense: it lost its way in 2.6.7, amidst so many page_mappings!

It's supposed to be checking that, although page->mapping may suddenly
go NULL from truncation, and although tmpfs swizzles page_mapping(page)
between tmpfs inode address_space and swapper_space, there's sufficient
stabilization while here in __set_page_dirty_nobuffers that the mapping
after we locked mapping->tree_lock is the same as the mapping before we
locked mapping->tree_lock i.e. the lock we hold is the right one.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/page-writeback.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

--- 2.6.9-rc1-bk12/mm/page-writeback.c	2004-09-05 12:58:41.000000000 +0100
+++ linux/mm/page-writeback.c	2004-09-05 17:07:14.513083224 +0100
@@ -582,12 +582,13 @@ int __set_page_dirty_nobuffers(struct pa
 
 	if (!TestSetPageDirty(page)) {
 		struct address_space *mapping = page_mapping(page);
+		struct address_space *mapping2;
 
 		if (mapping) {
 			spin_lock_irq(&mapping->tree_lock);
-			mapping = page_mapping(page);
-			if (page_mapping(page)) { /* Race with truncate? */
-				BUG_ON(page_mapping(page) != mapping);
+			mapping2 = page_mapping(page);
+			if (mapping2) { /* Race with truncate? */
+				BUG_ON(mapping2 != mapping);
 				if (!mapping->backing_dev_info->memory_backed)
 					inc_page_state(nr_dirty);
 				radix_tree_tag_set(&mapping->page_tree,

