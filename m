Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVCCJEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVCCJEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVCCJEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:04:20 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:7886 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261674AbVCCJDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:03:41 -0500
Message-ID: <4226E22A.2526DE09@tv-sign.ru>
Date: Thu, 03 Mar 2005 13:08:42 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxram@us.ibm.com, slpratt@austin.ibm.com
Subject: Re: [PATCH 1/2] readahead: simplify ra->size testing
References: <42260F2C.FCAA1915@tv-sign.ru> <20050302175947.6f1e6b5f.akpm@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> So...  the big "how it all works" comment needs an update..

Same patch, comment updated.

Currently page_cache_readahead() treats ra->size == 0 (first read)
and ra->size == -1 (ra_off was called) separately, but does exactly
the same in both cases.

With this patch we may assume that the reading starts in 'ra_off()'
state, so we don't need to consider the first read as a special case.


file_ra_state_init() sets
	ra->prev_page = -1;
	ra->size      =  0;

When the page_cache_readahead() is called for the first time it sets
ra->size to nonzero value either via get_init_ra_size() or ra_off().
So ra->size == 0 implies that ra->prev_page == -1. I am ignoring the
case when readahead is disabled via ra->ra_pages == 0.


page_cache_readahead detects sub-page sized reads:
	if (offset == ra->prev_page && req_size == 1 && ra->size != 0)

But if offset == ra->prev_page, then ra->size == 0 can happen only if
offset == -1, so there is no need to check ra->size here. If application
starts reading 16Tb file from the last page then readahead can't help.


First offset==0 read or first sequential detection:
	if ((ra->size == 0 && offset == 0) || (ra->size == -1 && sequential)
could be changed to:
	if ((ra->size == 0 && sequential) || (ra->size == -1 && sequential)
which means:
	if (sequential && (ra->size == 0 || ra->size == -1))


Random case detection:
	if (!sequential || (ra->size == 0))
But if sequential == 1, then ra->size can't be 0, this case is already handled
before.


Now we have:

	if (offset == ra->prev_page && req_size == 1)
		/* sub-page reads */

	if (sequential && (ra->size == 0 || ra->size == -1))
		/* first offset==0 read or first sequential */

	if (!sequential)
		/* random case */

Now ->size is checked only in one place, so ra_off() can set ra->size = 0,
and we can just test ->size against 0.

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
