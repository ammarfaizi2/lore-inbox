Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVAYK5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVAYK5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 05:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVAYK41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 05:56:27 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:11678 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261889AbVAYKze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 05:55:34 -0500
Message-ID: <41F63498.72DB416F@tv-sign.ru>
Date: Tue, 25 Jan 2005 14:59:20 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/4] blockable_page_cache_readahead() cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that do_page_cache_readahead() can be inlined
in blockable_page_cache_readahead(), this makes the
code a bit more readable in my opinion.

Also makes check_ra_success() static inline.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11-rc2/mm/readahead.c~	2005-01-25 17:26:34.000000000 +0300
+++ 2.6.11-rc2/mm/readahead.c	2005-01-25 17:29:26.000000000 +0300
@@ -349,8 +349,8 @@ int force_page_cache_readahead(struct ad
  * readahead isn't helping.
  *
  */
-int check_ra_success(struct file_ra_state *ra, unsigned long nr_to_read,
-				 unsigned long actual)
+static inline int check_ra_success(struct file_ra_state *ra,
+			unsigned long nr_to_read, unsigned long actual)
 {
 	if (actual == 0) {
 		ra->cache_hit += nr_to_read;
@@ -395,15 +395,11 @@ blockable_page_cache_readahead(struct ad
 {
 	int actual;
 
-	if (block) {
-		actual = __do_page_cache_readahead(mapping, filp,
-						offset, nr_to_read);
-	} else {
-		actual = do_page_cache_readahead(mapping, filp,
-						offset, nr_to_read);
-		if (actual == -1)
-			return 0;
-	}
+	if (block && bdi_read_congested(mapping->backing_dev_info))
+		return 0;
+
+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+
 	return check_ra_success(ra, nr_to_read, actual);
 }
