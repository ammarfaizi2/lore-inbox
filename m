Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262501AbSJAViX>; Tue, 1 Oct 2002 17:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262521AbSJAViX>; Tue, 1 Oct 2002 17:38:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:452 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262501AbSJAViV>; Tue, 1 Oct 2002 17:38:21 -0400
Date: Tue, 1 Oct 2002 22:44:36 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 1/9 shmem_vm_writeback
Message-ID: <Pine.LNX.4.44.0210012240470.2602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of nine tmpfs patches, equivalent to (but aesthetic differences
from) what I sent wli a few days ago: starting from 2.5.40-mm1 base.

Diffstat for the whole lot:
 include/linux/shmem_fs.h |    6 
 mm/shmem.c               | 1269 ++++++++++++++++++++++++++---------------------
 2 files changed, 726 insertions(+), 549 deletions(-)

This is not the end of tmpfs mods for 2.5: I should have six or seven
more patches to come (including loopable unless loop.c does it first);
but let's publish these before they go stale.  I know a swap_free goes
missing occasionally, before and after these patches: I wanted to sort
that out before sending these, but it's elusive so far: tests running.

tmpfs 1/9 shmem_vm_writeback

Give tmpfs its own shmem_vm_writeback (and empty shmem_writepages):
going through the default mpage_writepages is very wrong for tmpfs,
since that may write nearby pages while still mapped into mms, but
"writing" converts pages from tmpfs file identity to swap backing
identity: doing so while mapped breaks assumptions throughout e.g.
the shared file is liable to disintegrate into private instances.

--- 2.5.40-mm1/mm/shmem.c	Tue Oct  1 15:35:33 2002
+++ tmpfs1/mm/shmem.c	Tue Oct  1 19:48:54 2002
@@ -515,9 +515,8 @@
 
 	if (!PageLocked(page))
 		BUG();
-
-	if (!(current->flags & PF_MEMALLOC))
-		return fail_writepage(page);
+	if (page_mapped(page))
+		BUG();
 
 	mapping = page->mapping;
 	index = page->index;
@@ -551,6 +550,19 @@
 	return fail_writepage(page);
 }
 
+static int shmem_writepages(struct address_space *mapping, struct writeback_control *wbc)
+{
+	return 0;
+}
+
+static int shmem_vm_writeback(struct page *page, struct writeback_control *wbc)
+{
+	clear_page_dirty(page);
+	if (shmem_writepage(page) < 0)
+		set_page_dirty(page);
+	return 0;
+}
+
 /*
  * shmem_getpage_locked - either get the page from swap or allocate a new one
  *
@@ -1524,6 +1536,8 @@
 
 static struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
+	.writepages	= shmem_writepages,
+	.vm_writeback	= shmem_vm_writeback,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 };
 

