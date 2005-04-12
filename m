Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVDLKdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVDLKdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVDLKd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:33:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262118AbVDLKbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:05 -0400
Message-Id: <200504121030.j3CAUrDl005171@shell0.pdx.osdl.net>
Subject: [patch 015/198] filemap_getpage can block when MAP_NONBLOCK specified
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jmoyer@redhat.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Moyer <jmoyer@redhat.com>

We will return NULL from filemap_getpage when a page does not exist in the
page cache and MAP_NONBLOCK is specified, here:

	page = find_get_page(mapping, pgoff);
	if (!page) {
		if (nonblock)
			return NULL;
		goto no_cached_page;
	}

But we forget to do so when the page in the cache is not uptodate.  The
following could result in a blocking call:

	/*
	 * Ok, found a page in the page cache, now we need to check
	 * that it's up-to-date.
	 */
	if (!PageUptodate(page))
		goto page_not_uptodate;



Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/mm/filemap.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN mm/filemap.c~filemap_getpage-can-block-when-map_nonblock-specified mm/filemap.c
--- 25/mm/filemap.c~filemap_getpage-can-block-when-map_nonblock-specified	2005-04-12 03:21:07.024069080 -0700
+++ 25-akpm/mm/filemap.c	2005-04-12 03:21:07.028068472 -0700
@@ -1379,8 +1379,13 @@ retry_find:
 	 * Ok, found a page in the page cache, now we need to check
 	 * that it's up-to-date.
 	 */
-	if (!PageUptodate(page))
+	if (!PageUptodate(page)) {
+		if (nonblock) {
+			page_cache_release(page);
+			return NULL;
+		}
 		goto page_not_uptodate;
+	}
 
 success:
 	/*
_
