Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbVA2KHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbVA2KHN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 05:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbVA2KHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 05:07:12 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:45793 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262888AbVA2KG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 05:06:58 -0500
Message-ID: <41FB6F3C.64BEB61A@tv-sign.ru>
Date: Sat, 29 Jan 2005 14:10:52 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/4] readahead: cleanup get_next_ra_size
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

get_next_ra_size() can get all info from file_ra_state.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11-rc2/mm/readahead.c~	2005-01-26 19:29:49.000000000 +0300
+++ 2.6.11-rc2/mm/readahead.c	2005-01-27 22:14:39.000000000 +0300
@@ -85,14 +85,16 @@ static unsigned long get_init_ra_size(un
  * not for each call to readahead.  If a cache miss occured, reduce next I/O
  * size, else increase depending on how close to max we are.
  */
-static unsigned long get_next_ra_size(unsigned long cur, unsigned long max,
-				unsigned long min, unsigned long * flags)
+static unsigned long get_next_ra_size(struct file_ra_state *ra)
 {
+	unsigned long max = get_max_readahead(ra);
+	unsigned long min = get_min_readahead(ra);
+	unsigned long cur = ra->size;
 	unsigned long newsize;
 
-	if (*flags & RA_FLAG_MISS) {
+	if (ra->flags & RA_FLAG_MISS) {
+		ra->flags &= ~RA_FLAG_MISS;
 		newsize = max((cur - 2), min);
-		*flags &= ~RA_FLAG_MISS;
 	} else if (cur < max / 16) {
 		newsize = 4 * cur;
 	} else {
@@ -413,7 +415,7 @@ page_cache_readahead(struct address_spac
 		     struct file *filp, unsigned long offset,
 		     unsigned long req_size)
 {
-	unsigned long max, min;
+	unsigned long max;
 	unsigned long newsize = req_size;
 	unsigned long block;
 
@@ -427,7 +429,6 @@ page_cache_readahead(struct address_spac
 		goto out;
 
 	max = get_max_readahead(ra);
-	min = get_min_readahead(ra);
 	newsize = min(req_size, max);
 
 	if (newsize == 0 || (ra->flags & RA_FLAG_INCACHE)) {
@@ -457,8 +458,7 @@ page_cache_readahead(struct address_spac
 		 * immediately.
 		 */
 		if (req_size >= max) {
-			ra->ahead_size = get_next_ra_size(ra->size, max, min,
-							  &ra->flags);
+			ra->ahead_size = get_next_ra_size(ra);
 			ra->ahead_start = ra->start + ra->size;
 			blockable_page_cache_readahead(mapping, filp,
 				 ra->ahead_start, ra->ahead_size, ra, 1);
@@ -484,8 +484,7 @@ page_cache_readahead(struct address_spac
 	 */
 
 	if (ra->ahead_start == 0) {	 /* no ahead window yet */
-		ra->ahead_size = get_next_ra_size(ra->size, max, min,
-						  &ra->flags);
+		ra->ahead_size = get_next_ra_size(ra);
 		ra->ahead_start = ra->start + ra->size;
 		block = ((offset + newsize -1) >= ra->ahead_start);
 		if (!blockable_page_cache_readahead(mapping, filp,
@@ -517,9 +516,8 @@ page_cache_readahead(struct address_spac
 	if ((offset + newsize - 1) >= ra->ahead_start) {
 		ra->start = ra->ahead_start;
 		ra->size = ra->ahead_size;
-		ra->ahead_start = ra->ahead_start + ra->ahead_size;
-		ra->ahead_size = get_next_ra_size(ra->ahead_size,
-						  max, min, &ra->flags);
+		ra->ahead_start = ra->start + ra->size;
+		ra->ahead_size = get_next_ra_size(ra);
 		block = ((offset + newsize - 1) >= ra->ahead_start);
 		if (!blockable_page_cache_readahead(mapping, filp,
 			ra->ahead_start, ra->ahead_size, ra, block)) {
