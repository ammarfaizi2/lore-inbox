Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268605AbVBERt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268605AbVBERt0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 12:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268640AbVBERt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 12:49:26 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19583 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268605AbVBERtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 12:49:22 -0500
Date: Sat, 5 Feb 2005 17:48:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs caused truncate BUG
Message-ID: <Pine.LNX.4.61.0502051745500.16107@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just before removing truncate_complete_page's BUG_ON(page_mapped(page)),
thought I'd recheck on a few filesystems.  The shame!  Easily triggered
with tmpfs: not because of recent changes, but because shmem_nopage
omitted the i_size_read from Andrea's careful truncate_count/i_size_read
/cachelookup/truncate_count sequence.  For varying reasons, other users
of shmem_getpage can't go beyond i_size, so just add it to shmem_nopage.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.11-rc3/mm/shmem.c	2005-02-03 09:06:16.000000000 +0000
+++ linux/mm/shmem.c	2005-02-05 16:52:57.000000000 +0000
@@ -1162,6 +1162,8 @@ struct page *shmem_nopage(struct vm_area
 	idx = (address - vma->vm_start) >> PAGE_SHIFT;
 	idx += vma->vm_pgoff;
 	idx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
+	if (((loff_t) idx << PAGE_CACHE_SHIFT) >= i_size_read(inode))
+		return NOPAGE_SIGBUS;
 
 	error = shmem_getpage(inode, idx, &page, SGP_CACHE, type);
 	if (error)
