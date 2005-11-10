Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVKJBts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVKJBts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVKJBts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:49:48 -0500
Received: from gold.veritas.com ([143.127.12.110]:43827 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751394AbVKJBts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:49:48 -0500
Date: Thu, 10 Nov 2005 01:48:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] mm: unbloat get_futex_key
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100147130.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 01:49:47.0826 (UTC) FILETIME=[0814B920:01C5E599]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The follow_page changes in get_futex_key have left it with two almost
identical blocks, when handling the rare case of a futex in a nonlinear
vma.  get_user_pages will itself do that follow_page, and its additional
find_extend_vma is hardly any overhead since the vma is already cached.
Let's just delete the follow_page block and let get_user_pages do it.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 kernel/futex.c |   15 ---------------
 1 files changed, 15 deletions(-)

--- mm04/kernel/futex.c	2005-11-07 07:39:59.000000000 +0000
+++ mm05/kernel/futex.c	2005-11-09 14:38:47.000000000 +0000
@@ -201,21 +201,6 @@ static int get_futex_key(unsigned long u
 	 * from swap.  But that's a lot of code to duplicate here
 	 * for a rare case, so we simply fetch the page.
 	 */
-
-	/*
-	 * Do a quick atomic lookup first - this is the fastpath.
-	 */
-	page = follow_page(mm, uaddr, FOLL_TOUCH|FOLL_GET);
-	if (likely(page != NULL)) {
-		key->shared.pgoff =
-			page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
-		put_page(page);
-		return 0;
-	}
-
-	/*
-	 * Do it the general way.
-	 */
 	err = get_user_pages(current, mm, uaddr, 1, 0, 0, &page, NULL);
 	if (err >= 0) {
 		key->shared.pgoff =
