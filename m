Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWFTLvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWFTLvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWFTLvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:51:03 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:48001 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030228AbWFTLuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:50:35 -0400
Message-Id: <20060620114805.843358000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:09 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 09/13] JFS: Fix multiple errors in metapage_releasepage
Content-Disposition: inline; filename=jfs-fix-multiple-errors-in-metapage_releasepage.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Dave Kleikamp <shaggy@austin.ibm.com>

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
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/jfs/jfs_metapage.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

--- linux-2.6.16.21.orig/fs/jfs/jfs_metapage.c
+++ linux-2.6.16.21/fs/jfs/jfs_metapage.c
@@ -543,7 +543,7 @@ add_failed:
 static int metapage_releasepage(struct page *page, gfp_t gfp_mask)
 {
 	struct metapage *mp;
-	int busy = 0;
+	int ret = 1;
 	unsigned int offset;
 
 	for (offset = 0; offset < PAGE_CACHE_SIZE; offset += PSIZE) {
@@ -553,30 +553,20 @@ static int metapage_releasepage(struct p
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
 
 static int metapage_invalidatepage(struct page *page, unsigned long offset)

--
