Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVBXSgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVBXSgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVBXSez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:34:55 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:11404 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261645AbVBXSc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:32:29 -0500
Message-ID: <421E2CE6.68721B87@tv-sign.ru>
Date: Thu, 24 Feb 2005 22:37:10 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/4][RESEND] readahead: factor out duplicated code
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces make_ahead_window() function for
simplification of page_cache_readahead.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11-rc5/mm/readahead.c~	2005-02-04 21:28:19.000000000 +0300
+++ 2.6.11-rc5/mm/readahead.c	2005-02-04 21:30:08.000000000 +0300
@@ -85,7 +85,7 @@ static unsigned long get_init_ra_size(un
  * not for each call to readahead.  If a cache miss occured, reduce next I/O
  * size, else increase depending on how close to max we are.
  */
-static unsigned long get_next_ra_size(struct file_ra_state *ra)
+static inline unsigned long get_next_ra_size(struct file_ra_state *ra)
 {
 	unsigned long max = get_max_readahead(ra);
 	unsigned long min = get_min_readahead(ra);
@@ -406,6 +406,38 @@ blockable_page_cache_readahead(struct ad
 	return check_ra_success(ra, nr_to_read, actual);
 }
 
+static int make_ahead_window(struct address_space *mapping, struct file *filp,
+				struct file_ra_state *ra, int force)
+{
+	int block, ret;
+
+	ra->ahead_size = get_next_ra_size(ra);
+	ra->ahead_start = ra->start + ra->size;
+
+	block = force || (ra->prev_page >= ra->ahead_start);
+	ret = blockable_page_cache_readahead(mapping, filp,
+			ra->ahead_start, ra->ahead_size, ra, block);
+
+	if (!ret && !force) {
+		/* A read failure in blocking mode, implies pages are
+		 * all cached. So we can safely assume we have taken
+		 * care of all the pages requested in this call.
+		 * A read failure in non-blocking mode, implies we are
+		 * reading more pages than requested in this call.  So
+		 * we safely assume we have taken care of all the pages
+		 * requested in this call.
+		 *
+		 * Just reset the ahead window in case we failed due to
+		 * congestion.  The ahead window will any way be closed
+		 * in case we failed due to excessive page cache hits.
+		 */
+		ra->ahead_start = 0;
+		ra->ahead_size = 0;
+	}
+
+	return ret;
+}
+
 /*
  * page_cache_readahead is the main function.  If performs the adaptive
  * readahead window size management and submits the readahead I/O.
@@ -415,9 +447,8 @@ page_cache_readahead(struct address_spac
 		     struct file *filp, unsigned long offset,
 		     unsigned long req_size)
 {
-	unsigned long max;
-	unsigned long newsize = req_size;
-	unsigned long block;
+	unsigned long max, newsize = req_size;
+	int sequential = (offset == ra->prev_page + 1);
 
 	/*
 	 * Here we detect the case where the application is performing
@@ -428,6 +459,7 @@ page_cache_readahead(struct address_spac
 	if (offset == ra->prev_page && req_size == 1 && ra->size != 0)
 		goto out;
 
+	ra->prev_page = offset;
 	max = get_max_readahead(ra);
 	newsize = min(req_size, max);
 
@@ -435,13 +467,16 @@ page_cache_readahead(struct address_spac
 		newsize = 1;
 		goto out;	/* No readahead or file already in cache */
 	}
+
+	ra->prev_page += newsize - 1;
+
 	/*
 	 * Special case - first read.  We'll assume it's a whole-file read if
 	 * at start of file, and grow the window fast.  Or detect first
 	 * sequential access
 	 */
 	if ((ra->size == 0 && offset == 0)	/* first io and start of file */
-	    || (ra->size == -1 && ra->prev_page == offset - 1)) {
+	    || (ra->size == -1 && sequential)) {
 		/* First sequential */
 		ra->size = get_init_ra_size(newsize, max);
 		ra->start = offset;
@@ -457,12 +492,9 @@ page_cache_readahead(struct address_spac
 		 * IOs,* thus preventing stalls. so issue the ahead window
 		 * immediately.
 		 */
-		if (req_size >= max) {
-			ra->ahead_size = get_next_ra_size(ra);
-			ra->ahead_start = ra->start + ra->size;
-			blockable_page_cache_readahead(mapping, filp,
-				 ra->ahead_start, ra->ahead_size, ra, 1);
-		}
+		if (req_size >= max)
+			make_ahead_window(mapping, filp, ra, 1);
+
 		goto out;
 	}
 
@@ -471,7 +503,7 @@ page_cache_readahead(struct address_spac
 	 * partial page reads and first access were handled above,
 	 * so this must be the next page otherwise it is random
 	 */
-	if ((offset != (ra->prev_page+1) || (ra->size == 0))) {
+	if (!sequential || (ra->size == 0)) {
 		ra_off(ra);
 		blockable_page_cache_readahead(mapping, filp, offset,
 				 newsize, ra, 1);
@@ -484,27 +516,8 @@ page_cache_readahead(struct address_spac
 	 */
 
 	if (ra->ahead_start == 0) {	 /* no ahead window yet */
-		ra->ahead_size = get_next_ra_size(ra);
-		ra->ahead_start = ra->start + ra->size;
-		block = ((offset + newsize -1) >= ra->ahead_start);
-		if (!blockable_page_cache_readahead(mapping, filp,
-		    ra->ahead_start, ra->ahead_size, ra, block)) {
-			/* A read failure in blocking mode, implies pages are
-			 * all cached. So we can safely assume we have taken
-			 * care of all the pages requested in this call. A read
-			 * failure in non-blocking mode, implies we are reading
-			 * more pages than requested in this call.  So we safely
-			 * assume we have taken care of all the pages requested
-			 * in this call.
-			 *
-			 * Just reset the ahead window in case we failed due to
-			 * congestion.  The ahead window will any way be closed
-			 * in case we failed due to exessive page cache hits.
-			 */
-			ra->ahead_start = 0;
-			ra->ahead_size = 0;
+		if (!make_ahead_window(mapping, filp, ra, 0))
 			goto out;
-		}
 	}
 	/*
 	 * Already have an ahead window, check if we crossed into it.
@@ -513,33 +526,13 @@ page_cache_readahead(struct address_spac
 	 * we get called back on the first page of the ahead window which
 	 * will allow us to submit more IO.
 	 */
-	if ((offset + newsize - 1) >= ra->ahead_start) {
+	if (ra->prev_page >= ra->ahead_start) {
 		ra->start = ra->ahead_start;
 		ra->size = ra->ahead_size;
-		ra->ahead_start = ra->start + ra->size;
-		ra->ahead_size = get_next_ra_size(ra);
-		block = ((offset + newsize - 1) >= ra->ahead_start);
-		if (!blockable_page_cache_readahead(mapping, filp,
-			ra->ahead_start, ra->ahead_size, ra, block)) {
-			/* A read failure in blocking mode, implies pages are
-			 * all cached. So we can safely assume we have taken
-			 * care of all the pages requested in this call.
-			 * A read failure in non-blocking mode, implies we are
-			 * reading more pages than requested in this call.  So
-			 * we safely assume we have taken care of all the pages
-			 * requested in this call.
-			 *
-			 * Just reset the ahead window in case we failed due to
-			 * congestion.  The ahead window will any way be closed
-			 * in case we failed due to excessive page cache hits.
-			 */
-			ra->ahead_start = 0;
-			ra->ahead_size = 0;
-		}
+		make_ahead_window(mapping, filp, ra, 0);
 	}
 
 out:
-	ra->prev_page = offset + newsize - 1;
 	return newsize;
 }
