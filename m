Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbTCYV5g>; Tue, 25 Mar 2003 16:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbTCYV5g>; Tue, 25 Mar 2003 16:57:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:1880 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261389AbTCYV5f>; Tue, 25 Mar 2003 16:57:35 -0500
Date: Tue, 25 Mar 2003 22:10:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 01/13 no SWAP_ERROR
Message-ID: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of thirteen miscellaneous independent patches in the swap/rmap
area, several touching the same files therefore numbered in sequence.
Many but not all fixes extracted from the reverted anobjrmap patch.
Based upon 2.5.65-mm4, the aggregate has diffstat:

 include/linux/rmap-locking.h |    2 
 include/linux/swap.h         |   18 ++----
 mm/fremap.c                  |   12 ++--
 mm/mmap.c                    |    8 --
 mm/rmap.c                    |   68 ++++++++++++++-----------
 mm/shmem.c                   |   26 ++++++---
 mm/swap_state.c              |    4 -
 mm/swapfile.c                |  115 ++++++++++++++++++++++++++-----------------
 mm/vmscan.c                  |   14 ++---
 9 files changed, 151 insertions(+), 116 deletions(-)

swap 01/13 no SWAP_ERROR
Delete unused SWAP_ERROR and non-existent page_over_rsslimit().

--- 2.5.65-mm4/include/linux/swap.h	Wed Mar  5 07:26:34 2003
+++ swap01/include/linux/swap.h	Tue Mar 25 20:42:56 2003
@@ -174,13 +174,11 @@
 					struct pte_chain *));
 void FASTCALL(page_remove_rmap(struct page *, pte_t *));
 int FASTCALL(try_to_unmap(struct page *));
-int FASTCALL(page_over_rsslimit(struct page *));
 
 /* return values of try_to_unmap */
 #define	SWAP_SUCCESS	0
 #define	SWAP_AGAIN	1
 #define	SWAP_FAIL	2
-#define	SWAP_ERROR	3
 
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
--- 2.5.65-mm4/mm/rmap.c	Sun Mar 23 10:30:15 2003
+++ swap01/mm/rmap.c	Tue Mar 25 20:42:56 2003
@@ -677,7 +677,6 @@
  * SWAP_SUCCESS	- we succeeded in removing all mappings
  * SWAP_AGAIN	- we missed a trylock, try again later
  * SWAP_FAIL	- the page is unswappable
- * SWAP_ERROR	- an error occurred
  */
 int try_to_unmap(struct page * page)
 {
@@ -754,9 +753,6 @@
 			case SWAP_FAIL:
 				ret = SWAP_FAIL;
 				goto out;
-			case SWAP_ERROR:
-				ret = SWAP_ERROR;
-				goto out;
 			}
 		}
 	}
--- 2.5.65-mm4/mm/vmscan.c	Tue Feb 18 02:14:32 2003
+++ swap01/mm/vmscan.c	Tue Mar 25 20:42:56 2003
@@ -284,7 +284,6 @@
 		 */
 		if (page_mapped(page) && mapping) {
 			switch (try_to_unmap(page)) {
-			case SWAP_ERROR:
 			case SWAP_FAIL:
 				pte_chain_unlock(page);
 				goto activate_locked;

