Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVBXShZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVBXShZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVBXSeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:34:15 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:13452 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261579AbVBXSc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:32:28 -0500
Message-ID: <421E2CE9.8B5E4DE7@tv-sign.ru>
Date: Thu, 24 Feb 2005 22:37:13 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/4][RESEND] readahead: cleanup blockable_page_cache_readahead()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that do_page_cache_readahead() can be inlined
in blockable_page_cache_readahead(), this makes the
code a bit more readable in my opinion.

Also makes check_ra_success() static inline.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11-rc5/mm/readahead.c~	2005-01-29 15:51:04.000000000 +0300
+++ 2.6.11-rc5/mm/readahead.c	2005-01-29 16:37:05.000000000 +0300
@@ -348,8 +348,8 @@ int force_page_cache_readahead(struct ad
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
@@ -394,15 +394,11 @@ blockable_page_cache_readahead(struct ad
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
+	if (!block && bdi_read_congested(mapping->backing_dev_info))
+		return 0;
+
+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+
 	return check_ra_success(ra, nr_to_read, actual);
 }
