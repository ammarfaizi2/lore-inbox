Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbTCYWJd>; Tue, 25 Mar 2003 17:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261620AbTCYWIc>; Tue, 25 Mar 2003 17:08:32 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:18897 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261570AbTCYWHa>; Tue, 25 Mar 2003 17:07:30 -0500
Date: Tue, 25 Mar 2003 22:20:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 10/13 tmpfs atomics
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252219570.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

move_from_swap_cache and add_to_page_cache_lru are using GFP_ATOMIC,
which can easily fail in an intermittent way.  Rude if shmem_getpage
then fails with -ENOMEM: cond_resched to let kswapd in, and repeat.

--- swap09/mm/shmem.c	Tue Mar 25 20:44:24 2003
+++ swap10/mm/shmem.c	Tue Mar 25 20:44:35 2003
@@ -838,8 +838,7 @@
 			SetPageUptodate(filepage);
 			set_page_dirty(filepage);
 			swap_free(swap);
-		} else if (!(error = move_from_swap_cache(
-				swappage, idx, mapping))) {
+		} else if (move_from_swap_cache(swappage, idx, mapping) == 0) {
 			shmem_swp_set(info, entry, 0);
 			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
@@ -850,8 +849,8 @@
 			spin_unlock(&info->lock);
 			unlock_page(swappage);
 			page_cache_release(swappage);
-			if (error != -EEXIST)
-				goto failed;
+			/* let kswapd refresh zone for GFP_ATOMICs */
+			cond_resched();
 			goto repeat;
 		}
 	} else if (sgp == SGP_READ && !filepage) {
@@ -897,15 +896,16 @@
 				swap = *entry;
 				shmem_swp_unmap(entry);
 			}
-			if (error || swap.val ||
-			    (error = add_to_page_cache_lru(
-					filepage, mapping, idx, GFP_ATOMIC))) {
+			if (error || swap.val || 0 != add_to_page_cache_lru(
+					filepage, mapping, idx, GFP_ATOMIC)) {
 				spin_unlock(&info->lock);
 				page_cache_release(filepage);
 				shmem_free_block(inode);
 				filepage = NULL;
-				if (error != -EEXIST)
+				if (error)
 					goto failed;
+				/* let kswapd refresh zone for GFP_ATOMICs */
+				cond_resched();
 				goto repeat;
 			}
 		}

