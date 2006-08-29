Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWH2Bai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWH2Bai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWH2Bai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:30:38 -0400
Received: from ns1.suse.de ([195.135.220.2]:2952 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750914AbWH2Bag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:30:36 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 29 Aug 2006 11:30:28 +1000
Message-Id: <1060829013028.18507@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: v9fs-developer@lists.sourceforge.net, trond.myklebust@fys.uio.no,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 2] Invalidate_inode_pages2 shouldn't abort on first error.
References: <20060829111641.18391.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


invalidate_inode_pages2 is called when the caller has reason to
believe that the pagecache is out-of-sync with the backing storage.
This can happen with networked filesystems (nfs, 9p) when they believe
something might have changed on the server, and it can happen
with O_DIRECT writing when a write has bypassed the page cache.

It is possible for invalidate_inode_pages2 to fail to invalidate a
page.  This can happen if the page is in Writeback or if the
filesystem is unable to release 'private' data for some reason.

This can happen even if the caller has protected against concurrent
writes by claiming i_mutex, and has unmapped and flushed the mapping.
This is because there is no way to lock against an uptodate page being
faulted into an address space and being dirtied.

If invalidate_inode_pages2 finds a page that it cannot invalidate, it
gives up and doesn't bother trying to invalidate any more pages.

This is wrong.  There is no justification for aborting early, and
doing so unnecessarily leaves part of the pagecache inconsistant with
the backing store.

This patch removes the early-abort logic from invalidate_inode_pages2_range.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./mm/truncate.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff .prev/mm/truncate.c ./mm/truncate.c
--- .prev/mm/truncate.c	2006-08-28 16:38:09.000000000 +1000
+++ ./mm/truncate.c	2006-08-29 10:24:34.000000000 +1000
@@ -293,10 +293,10 @@ int invalidate_inode_pages2_range(struct
 
 	pagevec_init(&pvec, 0);
 	next = start;
-	while (next <= end && !ret && !wrapped &&
+	while (next <= end && !wrapped &&
 		pagevec_lookup(&pvec, mapping, next,
 			min(end - next, (pgoff_t)PAGEVEC_SIZE - 1) + 1)) {
-		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
+		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 			pgoff_t page_index;
 			int was_dirty;
