Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUBDATM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbUBDATM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:19:12 -0500
Received: from peabody.ximian.com ([130.57.169.10]:60565 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266240AbUBDATH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:19:07 -0500
Subject: [patch] 2.4's sys_readahead is borked
From: Robert Love <rml@ximian.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1075853962.8022.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Tue, 03 Feb 2004 19:19:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4, sys_readahead() performs readahead against a maximum of half the
number of inactive pages.  This is dumb, as it ignores the number of
free pages completely.  Worse, in certain situations, such as boot, the
inactive list can be quite small and the free list quite large, but
readahead(2) won't do anything.

The right thing to do is limit sys_readahead() to a maximum of half of
the sum of the number of free pages and inactive pages, which is what
2.6 does.

Attached patch is against 2.4.25-pre8.  Please apply.

	Robert Love

 mm/filemap.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-2.4.25-pre8/mm/filemap.c.orig linux-2.4.25-pre8/mm/filemap.c
--- linux-2.4.25-pre8/mm/filemap.c.orig	2004-02-03 19:13:33.540115456 -0500
+++ linux-2.4.25-pre8/mm/filemap.c	2004-02-03 19:13:49.468693944 -0500
@@ -1965,7 +1965,7 @@
 		nr = max;
 
 	/* And limit it to a sane percentage of the inactive list.. */
-	max = nr_inactive_pages / 2;
+	max = (nr_free_pages() + nr_inactive_pages) / 2;
 	if (nr > max)
 		nr = max;
 

