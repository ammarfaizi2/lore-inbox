Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWF0S2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWF0S2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWF0S2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:28:34 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:60475 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030249AbWF0S2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:28:33 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Tue, 27 Jun 2006 20:28:27 +0200
Message-Id: <20060627182827.20891.4063.sendpatchset@lappy>
In-Reply-To: <20060627182801.20891.11456.sendpatchset@lappy>
References: <20060627182801.20891.11456.sendpatchset@lappy>
Subject: [PATCH 2/5] mm: balance dirty pages
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Now that we can detect writers of shared mappings, throttle them.
Avoids OOM by surprise.

Changes -v2:

 - small helper function (Andrew Morton)

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 include/linux/writeback.h |    1 +
 mm/memory.c               |    5 +++--
 mm/page-writeback.c       |   10 ++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

Index: linux-2.6-dirty/mm/memory.c
===================================================================
--- linux-2.6-dirty.orig/mm/memory.c	2006-06-27 12:55:20.000000000 +0200
+++ linux-2.6-dirty/mm/memory.c	2006-06-27 13:01:13.000000000 +0200
@@ -48,6 +48,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/writeback.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -1570,7 +1571,7 @@ gotten:
 unlock:
 	pte_unmap_unlock(page_table, ptl);
 	if (dirty_page) {
-		set_page_dirty(dirty_page);
+		set_page_dirty_balance(dirty_page);
 		put_page(dirty_page);
 	}
 	return ret;
@@ -2214,7 +2215,7 @@ retry:
 unlock:
 	pte_unmap_unlock(page_table, ptl);
 	if (dirty_page) {
-		set_page_dirty(dirty_page);
+		set_page_dirty_balance(dirty_page);
 		put_page(dirty_page);
 	}
 	return ret;
Index: linux-2.6-dirty/include/linux/writeback.h
===================================================================
--- linux-2.6-dirty.orig/include/linux/writeback.h	2006-06-27 12:43:27.000000000 +0200
+++ linux-2.6-dirty/include/linux/writeback.h	2006-06-27 13:01:13.000000000 +0200
@@ -115,6 +115,7 @@ int sync_page_range(struct inode *inode,
 			loff_t pos, loff_t count);
 int sync_page_range_nolock(struct inode *inode, struct address_space *mapping,
 			   loff_t pos, loff_t count);
+void set_page_dirty_balance(struct page *page);
 
 /* pdflush.c */
 extern int nr_pdflush_threads;	/* Global so it can be exported to sysctl
Index: linux-2.6-dirty/mm/page-writeback.c
===================================================================
--- linux-2.6-dirty.orig/mm/page-writeback.c	2006-06-27 13:00:14.000000000 +0200
+++ linux-2.6-dirty/mm/page-writeback.c	2006-06-27 13:01:13.000000000 +0200
@@ -256,6 +256,16 @@ static void balance_dirty_pages(struct a
 		pdflush_operation(background_writeout, 0);
 }
 
+void set_page_dirty_balance(struct page *page)
+{
+	if (set_page_dirty(page)) {
+		struct address_space *mapping = page_mapping(page);
+
+		if (mapping)
+			balance_dirty_pages_ratelimited(mapping);
+	}
+}
+
 /**
  * balance_dirty_pages_ratelimited_nr - balance dirty memory state
  * @mapping: address_space which was dirtied
