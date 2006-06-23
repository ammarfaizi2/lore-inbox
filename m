Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752139AbWFWWb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbWFWWb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbWFWWb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:31:27 -0400
Received: from [213.46.243.16] ([213.46.243.16]:17244 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1752139AbWFWWbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:31:25 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Sat, 24 Jun 2006 00:31:23 +0200
Message-Id: <20060623223123.11513.5779.sendpatchset@lappy>
In-Reply-To: <20060623223103.11513.50991.sendpatchset@lappy>
References: <20060623223103.11513.50991.sendpatchset@lappy>
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

Index: 2.6-mm/mm/memory.c
===================================================================
--- 2.6-mm.orig/mm/memory.c	2006-06-23 01:08:11.000000000 +0200
+++ 2.6-mm/mm/memory.c	2006-06-23 11:02:03.000000000 +0200
@@ -49,6 +49,7 @@
 #include <linux/module.h>
 #include <linux/delayacct.h>
 #include <linux/init.h>
+#include <linux/writeback.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -1571,7 +1572,7 @@ gotten:
 unlock:
 	pte_unmap_unlock(page_table, ptl);
 	if (dirty_page) {
-		set_page_dirty(dirty_page);
+		set_page_dirty_balance(dirty_page);
 		put_page(dirty_page);
 	}
 	return ret;
@@ -2218,7 +2219,7 @@ retry:
 unlock:
 	pte_unmap_unlock(page_table, ptl);
 	if (dirty_page) {
-		set_page_dirty(dirty_page);
+		set_page_dirty_balance(dirty_page);
 		put_page(dirty_page);
 	}
 	return ret;
Index: 2.6-mm/include/linux/writeback.h
===================================================================
--- 2.6-mm.orig/include/linux/writeback.h	2006-06-22 17:59:07.000000000 +0200
+++ 2.6-mm/include/linux/writeback.h	2006-06-23 11:02:03.000000000 +0200
@@ -121,6 +121,7 @@ int sync_page_range(struct inode *inode,
 			loff_t pos, loff_t count);
 int sync_page_range_nolock(struct inode *inode, struct address_space *mapping,
 			   loff_t pos, loff_t count);
+void set_page_dirty_balance(struct page *page);
 
 /* pdflush.c */
 extern int nr_pdflush_threads;	/* Global so it can be exported to sysctl
Index: 2.6-mm/mm/page-writeback.c
===================================================================
--- 2.6-mm.orig/mm/page-writeback.c	2006-06-23 00:27:09.000000000 +0200
+++ 2.6-mm/mm/page-writeback.c	2006-06-23 11:02:03.000000000 +0200
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
