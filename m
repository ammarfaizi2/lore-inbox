Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVC3USF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVC3USF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVC3UQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:16:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4549 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261823AbVC3UOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:14:47 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16971.2290.29297.636175@segfault.boston.redhat.com>
Date: Wed, 30 Mar 2005 15:15:46 -0500
To: linux-kernel@vger.kernel.org
Subject: [patch] filemap_getpage can block when MAP_NONBLOCK specified
X-Mailer: VM 7.19 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

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

Patch attached.

Thanks,

Jeff

--- linux-2.6.11/mm/filemap.c.orig	2005-03-30 14:57:02.252975936 -0500
+++ linux-2.6.11/mm/filemap.c	2005-03-30 15:02:51.808835368 -0500
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
