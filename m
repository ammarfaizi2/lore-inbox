Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVCCSdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVCCSdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVCCSbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:31:47 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:10898 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262538AbVCCS3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:29:43 -0500
Message-ID: <422766D3.1D7DD2D@tv-sign.ru>
Date: Thu, 03 Mar 2005 22:34:43 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] readahead: trivial, small comments update
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of "[PATCH 2/2] readahead: improve sequential read detection".

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11/mm/readahead.c~	Thu Mar  3 21:04:43 2005
+++ 2.6.11/mm/readahead.c	Thu Mar  3 22:23:57 2005
@@ -192,18 +192,16 @@ out:
  * size:	Number of pages in that read
  *              Together, these form the "current window".
  *              Together, start and size represent the `readahead window'.
- * next_size:   The number of pages to read on the next readahead miss.
- *              Has the magical value -1UL if readahead has been disabled.
  * prev_page:   The page which the readahead algorithm most-recently inspected.
- *              prev_page is mainly an optimisation: if page_cache_readahead
- *		sees that it is again being called for a page which it just
- *		looked at, it can return immediately without making any state
- *		changes.
+ *              It is mainly used to detect sequential file reading.
+ *              If page_cache_readahead sees that it is again being called for
+ *              a page which it just looked at, it can return immediately without
+ *              making any state changes.
  * ahead_start,
  * ahead_size:  Together, these form the "ahead window".
  * ra_pages:	The externally controlled max readahead for this fd.
  *
- * When readahead is in the off state (size == -1UL), readahead is disabled.
+ * When readahead is in the off state (size == 0), readahead is disabled.
  * In this state, prev_page is used to detect the resumption of sequential I/O.
  *
  * The readahead code manages two windows - the "current" and the "ahead"
@@ -224,7 +222,7 @@ out:
  *           ahead window.
  *
  * A `readahead hit' occurs when a read request is made against a page which is
- * the next sequential page. Ahead windowe calculations are done only when it
+ * the next sequential page. Ahead window calculations are done only when it
  * is time to submit a new IO.  The code ramps up the size agressively at first,
  * but slow down as it approaches max_readhead.
  *
@@ -235,12 +233,9 @@ out:
  * read happens to be the first page of the file, it is assumed that a linear
  * read is about to happen and the window is immediately set to the initial size
  * based on I/O request size and the max_readahead.
- * 
- * A page request at (start + size) is not a miss at all - it's just a part of
- * sequential file reading.
  *
  * This function is to be called for every read request, rather than when
- * it is time to perform readahead.  It is called only oce for the entire I/O
+ * it is time to perform readahead.  It is called only once for the entire I/O
  * regardless of size unless readahead is unable to start enough I/O to satisfy
  * the request (I/O request > max_readahead).
  */
@@ -447,28 +442,28 @@ page_cache_readahead(struct address_spac
 	int sequential;
 
 	/*
-	 * Here we detect the case where the application is performing
-	 * sub-page sized reads.  We avoid doing extra work and bogusly
-	 * perturbing the readahead window expansion logic.
+	 * We avoid doing extra work and bogusly perturbing the readahead
+	 * window expansion logic.
 	 */
 	if (offset == ra->prev_page && --req_size)
 		++offset;
 
+	/* Note that prev_page == -1 if it is a first read */
 	sequential = (offset == ra->prev_page + 1);
 	ra->prev_page = offset;
 
 	max = get_max_readahead(ra);
 	newsize = min(req_size, max);
 
-	/* No readahead or file already in cache or sub-page sized read */
+	/* No readahead or sub-page sized read or file already in cache */
 	if (newsize == 0 || (ra->flags & RA_FLAG_INCACHE))
 		goto out;
 
 	ra->prev_page += newsize - 1;
 
 	/*
-	 * Special case - first read.  We'll assume it's a whole-file read if
-	 * at start of file, and grow the window fast.  Or detect first
+	 * Special case - first read at start of file. We'll assume it's
+	 * a whole-file read and grow the window fast.  Or detect first
 	 * sequential access
 	 */
 	if (sequential && ra->size == 0) {
