Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbWEXNKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbWEXNKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 09:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbWEXNKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 09:10:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:61137 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932735AbWEXNKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 09:10:21 -0400
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060524131008.2D77882E0B@kleikamp.austin.ibm.com>
Date: Wed, 24 May 2006 08:10:08 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

This will update the following file:

 fs/jfs/jfs_metapage.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

through these ChangeSets:

JFS: Fix multiple errors in metapage_releasepage

It looks like metapage_releasepage was making in invalid assumption that
the releasepage method would not be called on a dirty page.  Instead of
issuing a warning and releasing the metapage, it should return 0, indicating
that the private data for the page cannot be released.

I also realized that metapage_releasepage had the return code all wrong.  If
it is successful in releasing the private data, it should return 1, otherwise
it needs to return 0.

Lastly, there is no need to call wait_on_page_writeback, since
try_to_release_page will not call us with a page in writback state.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

---
commit b964638ffd59b61c13f02b81e5118a6e573d91cd
tree 118ab6ba3bceab3ab39d7d22070d03af2ace6f18
parent 387e2b0439026aa738a9edca15a57e5c0bcb4dfc
author Dave Kleikamp <shaggy@austin.ibm.com> Wed, 24 May 2006 07:43:38 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 24 May 2006 07:43:38 -0500

 fs/jfs/jfs_metapage.c |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index f28696f..2b220dd 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -542,7 +542,7 @@ add_failed:
 static int metapage_releasepage(struct page *page, gfp_t gfp_mask)
 {
 	struct metapage *mp;
-	int busy = 0;
+	int ret = 1;
 	unsigned int offset;
 
 	for (offset = 0; offset < PAGE_CACHE_SIZE; offset += PSIZE) {
@@ -552,30 +552,20 @@ static int metapage_releasepage(struct p
 			continue;
 
 		jfs_info("metapage_releasepage: mp = 0x%p", mp);
-		if (mp->count || mp->nohomeok) {
+		if (mp->count || mp->nohomeok ||
+		    test_bit(META_dirty, &mp->flag)) {
 			jfs_info("count = %ld, nohomeok = %d", mp->count,
 				 mp->nohomeok);
-			busy = 1;
+			ret = 0;
 			continue;
 		}
-		wait_on_page_writeback(page);
-		//WARN_ON(test_bit(META_dirty, &mp->flag));
-		if (test_bit(META_dirty, &mp->flag)) {
-			dump_mem("dirty mp in metapage_releasepage", mp,
-				 sizeof(struct metapage));
-			dump_mem("page", page, sizeof(struct page));
-			dump_stack();
-		}
 		if (mp->lsn)
 			remove_from_logsync(mp);
 		remove_metapage(page, mp);
 		INCREMENT(mpStat.pagefree);
 		free_metapage(mp);
 	}
-	if (busy)
-		return -1;
-
-	return 0;
+	return ret;
 }
 
 static void metapage_invalidatepage(struct page *page, unsigned long offset)
