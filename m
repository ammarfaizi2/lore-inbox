Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbUJYWD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbUJYWD7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 18:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbUJYV4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:56:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50650 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261294AbUJYVwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:52:15 -0400
Date: Mon, 25 Oct 2004 17:51:48 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Javier Marcet <javier@marcet.info>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
In-Reply-To: <20041023125948.GC9488@marcet.info>
Message-ID: <Pine.LNX.4.44.0410251735470.21539-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.44.0410251735472.21539@chimarrao.boston.redhat.com>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004, Javier Marcet wrote:

> I'm not saying everything within the patch is needed, not even that it's
> the right thing to change.

I suspect the following (still untested) patch might be
needed, too.  Basically when the VM gets tight, it could
still ignore swappable pages with the referenced bit set.
Both really referenced pages and pages from the process
that currently has the swap token.

Forcefully deactivating a few pages when we run with
priority 0 might get rid of the false OOM kills.

I'm about to test this on a very small system here, and
will let you know how things go.


===== mm/vmscan.c 1.231 vs edited =====
--- 1.231/mm/vmscan.c	Sun Oct 17 01:07:24 2004
+++ edited/mm/vmscan.c	Mon Oct 25 17:38:56 2004
@@ -379,7 +379,7 @@
 
 		referenced = page_referenced(page, 1);
 		/* In active use or really unfreeable?  Activate it. */
-		if (referenced && page_mapping_inuse(page))
+		if (referenced && sc->priority && page_mapping_inuse(page))
 			goto activate_locked;
 
 #ifdef CONFIG_SWAP
@@ -715,7 +715,7 @@
 		if (page_mapped(page)) {
 			if (!reclaim_mapped ||
 			    (total_swap_pages == 0 && PageAnon(page)) ||
-			    page_referenced(page, 0)) {
+			    (page_referenced(page, 0) && sc->priority)) {
 				list_add(&page->lru, &l_active);
 				continue;
 			}


