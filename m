Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273179AbRISTlP>; Wed, 19 Sep 2001 15:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274149AbRISTlG>; Wed, 19 Sep 2001 15:41:06 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:53421 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S273179AbRISTkp>; Wed, 19 Sep 2001 15:40:45 -0400
Date: Wed, 19 Sep 2001 20:42:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: pre12 VM doubts and patch
In-Reply-To: <Pine.LNX.4.21.0109191850370.1133-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0109192026280.1502-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Hugh Dickins wrote:
> 
> thank you.  A few doubts: in the first case I've appended a patch; for
> the rest you may prefer to make your own patch, or ask me for patch,
> or reject my doubts.

Please add another:

6. Why has swap_writepage lost its check for stale entries?  If your
   other changes have somehow made that too rare a case to bother
   about, please remove the comment above swap_writepage instead.

Hugh

--- 2.4.10-pre12/mm/swap_state.c	Wed Sep 19 14:05:54 2001
+++ linux/mm/swap_state.c	Mon Sep 17 06:30:26 2001
@@ -23,6 +23,17 @@
  */
 static int swap_writepage(struct page *page)
 {
+	/* One for the page cache, one for this user, one for page->buffers */
+	if (page_count(page) > 2 + !!page->buffers)
+		goto in_use;
+	if (swap_count(page) > 1)
+		goto in_use;
+
+	delete_from_swap_cache_nolock(page);
+	UnlockPage(page);
+	return 0;
+
+in_use:
 	rw_swap_page(WRITE, page);
 	return 0;
 }

