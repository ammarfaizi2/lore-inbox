Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129439AbRBGSBH>; Wed, 7 Feb 2001 13:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129865AbRBGSBA>; Wed, 7 Feb 2001 13:01:00 -0500
Received: from [62.172.234.2] ([62.172.234.2]:11861 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129444AbRBGSAr>; Wed, 7 Feb 2001 13:00:47 -0500
Date: Wed, 7 Feb 2001 18:00:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <Pine.LNX.4.21.0102071744440.5204-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0102071755200.5243-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Linus Torvalds wrote:
> > -		if (bh->b_size % correct_size) {
> > +		if (bh->b_size != correct_size) {
> 
> Actually, I'd rather leave it in, but speed it up with the saner and
> faster  	if (bh->b_size & (correct_size-1)) {

Micro-optimization season?

--- linux-2.4.2-pre1/include/linux/swap.h	Wed Feb  7 15:21:13 2001
+++ linux/include/linux/swap.h	Wed Feb  7 17:21:25 2001
@@ -200,8 +200,8 @@
  * with the pagemap_lru_lock held!
  */
 #define DEBUG_ADD_PAGE \
-	if (PageActive(page) || PageInactiveDirty(page) || \
-					PageInactiveClean(page)) BUG();
+	if ((page)->flags & ((1<<PG_active)|(1<<PG_inactive_dirty)| \
+					(1<<PG_inactive_clean))) BUG();
 
 #define ZERO_PAGE_BUG \
 	if (page_count(page) == 0) BUG();

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
