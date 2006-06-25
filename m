Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWFYNJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWFYNJP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWFYNJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:09:15 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:3550 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751249AbWFYNJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:09:15 -0400
Message-ID: <351240952.82409@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060625130921.987235199@localhost.localdomain>
References: <20060625130704.464870100@localhost.localdomain>
Date: Sun, 25 Jun 2006 21:07:06 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 2/6] readahead: backward prefetching method fix
Content-Disposition: inline; filename=readahead-backward-prefetching-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- The backward prefetching method fails near start of file. Fix it.
- Make it scale up more quickly by adding ra_min to ra_size.
- Do not discount readahead_hit_rate, that's not a documented behavior.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-mm2.orig/mm/readahead.c
+++ linux-2.6.17-mm2/mm/readahead.c
@@ -1636,8 +1636,9 @@ initial_readahead(struct address_space *
  * Important for certain scientific arenas(i.e. structural analysis).
  */
 static int
-try_read_backward(struct file_ra_state *ra, pgoff_t begin_index,
-			unsigned long ra_size, unsigned long ra_max)
+try_read_backward(struct file_ra_state *ra,
+			pgoff_t begin_index, unsigned long ra_size,
+			unsigned long ra_min, unsigned long ra_max)
 {
 	pgoff_t end_index;
 
@@ -1646,11 +1647,11 @@ try_read_backward(struct file_ra_state *
 		return 0;
 
 	if ((ra->flags & RA_CLASS_MASK) == RA_CLASS_BACKWARD &&
-					ra_has_index(ra, ra->prev_page)) {
-		ra_size += 2 * ra->hit0;
+		ra_has_index(ra, ra->prev_page) && ra_cache_hit_ok(ra)) {
+		ra_size += ra_min + 2 * ra_readahead_size(ra);
 		end_index = ra->la_index;
 	} else {
-		ra_size += ra_size + ra_size * (readahead_hit_rate - 1) / 2;
+		ra_size += ra_size * readahead_hit_rate;
 		end_index = ra->prev_page;
 	}
 
@@ -1661,7 +1662,7 @@ try_read_backward(struct file_ra_state *
 	if (end_index > begin_index + ra_size)
 		return 0;
 
-	begin_index = end_index - ra_size;
+	begin_index = end_index > ra_size ? end_index - ra_size : 0;
 
 	ra_set_class(ra, RA_CLASS_BACKWARD);
 	ra_set_index(ra, begin_index, begin_index);
@@ -1864,7 +1865,7 @@ page_cache_readahead_adaptive(struct add
 	 * Backward read-ahead.
 	 */
 	if (!page && begin_index == index &&
-				try_read_backward(ra, index, size, ra_max))
+				try_read_backward(ra, index, size, ra_min, ra_max))
 		return ra_dispatch(ra, mapping, filp);
 
 	/*

--
