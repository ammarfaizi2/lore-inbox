Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVCBSLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVCBSLa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVCBSGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:06:50 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:59042 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262394AbVCBSDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:03:30 -0500
Message-ID: <42260F2C.FCAA1915@tv-sign.ru>
Date: Wed, 02 Mar 2005 22:08:28 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] readahead: simplify ra->size testing
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of "readahead: cleanup blockable_page_cache_readahead()",
see http://marc.theaimsgroup.com/?l=linux-kernel&m=110927049500942

Currently page_cache_readahead() treats ra->size == 0 (first read)
and ra->size == -1 (ra_off was called) separately, but does exactly
the same in both cases.

With this patch we may assume that the reading starts in 'ra_off()'
state, so we don't need to consider the first read as a special case.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11/mm/readahead.c~	2005-02-04 21:33:40.000000000 +0300
+++ 2.6.11/mm/readahead.c	2005-02-04 21:33:57.000000000 +0300
@@ -55,7 +55,7 @@ static inline void ra_off(struct file_ra
 {
 	ra->start = 0;
 	ra->flags = 0;
-	ra->size = -1;
+	ra->size = 0;
 	ra->ahead_start = 0;
 	ra->ahead_size = 0;
 	return;
@@ -452,7 +452,7 @@ page_cache_readahead(struct address_spac
 	 * perturbing the readahead window expansion logic.
 	 * If size is zero, there is no read ahead window so we need one
 	 */
-	if (offset == ra->prev_page && req_size == 1 && ra->size != 0)
+	if (offset == ra->prev_page && req_size == 1)
 		goto out;
 
 	ra->prev_page = offset;
@@ -471,9 +471,7 @@ page_cache_readahead(struct address_spac
 	 * at start of file, and grow the window fast.  Or detect first
 	 * sequential access
 	 */
-	if ((ra->size == 0 && offset == 0)	/* first io and start of file */
-	    || (ra->size == -1 && sequential)) {
-		/* First sequential */
+	if (sequential && ra->size == 0) {
 		ra->size = get_init_ra_size(newsize, max);
 		ra->start = offset;
 		if (!blockable_page_cache_readahead(mapping, filp, offset,
@@ -499,7 +497,7 @@ page_cache_readahead(struct address_spac
 	 * partial page reads and first access were handled above,
 	 * so this must be the next page otherwise it is random
 	 */
-	if (!sequential || (ra->size == 0)) {
+	if (!sequential) {
 		ra_off(ra);
 		blockable_page_cache_readahead(mapping, filp, offset,
 				 newsize, ra, 1);
