Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288978AbSAUATi>; Sun, 20 Jan 2002 19:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288979AbSAUAT2>; Sun, 20 Jan 2002 19:19:28 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:26192 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S288978AbSAUATU>; Sun, 20 Jan 2002 19:19:20 -0500
Date: Mon, 21 Jan 2002 00:21:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        alad@hss.hns.com, linux-kernel@vger.kernel.org
Subject: [PATCH] free_swap_and_cache misses
Message-ID: <Pine.LNX.4.21.0201210016040.1153-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

free_swap_and_cache() often misses its purpose and leaves freeable page
in swap and cache.  Wrong in mainline 2.4 and 2.5, but looks okay in -aa
(so don't bother to apply this if you're now merging that).

Hugh

--- 2.4.18-pre4/mm/swapfile.c	Sun Dec 23 10:47:32 2001
+++ linux/mm/swapfile.c	Sun Jan 20 23:30:52 2002
@@ -344,7 +344,7 @@
 	if (page) {
 		page_cache_get(page);
 		/* Only cache user (+us), or swap space full? Free it! */
-		if (page_count(page) == 2 || vm_swap_full()) {
+		if (page_count(page) - !!page->buffers == 2 || vm_swap_full()) {
 			delete_from_swap_cache(page);
 			SetPageDirty(page);
 		}

