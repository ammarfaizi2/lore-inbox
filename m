Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318114AbSHLOzY>; Mon, 12 Aug 2002 10:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSHLOzY>; Mon, 12 Aug 2002 10:55:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:19216 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318114AbSHLOzX>; Mon, 12 Aug 2002 10:55:23 -0400
Date: Mon, 12 Aug 2002 11:58:47 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
Subject: [PATCH] rmap bugfix, try_to_unmap
Message-ID: <Pine.LNX.4.44L.0208121156160.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch corrects a bug where rmap would continue
trying to swap out a page even after it failed on one pte,
which could result in leaked pte chains and a bug when exiting
applications which use mlock().

The bug was tracked down by Christian Ehrhardt, the reason
it wasn't found earlier was a subtlety in the code, so I've
taken the liberty of changing Christian's patch into something
more explicit, we shouldn't let this one happen again ;)

please apply,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


===== mm/rmap.c 1.7 vs edited =====
--- 1.7/mm/rmap.c	Wed Jul 31 06:58:53 2002
+++ edited/mm/rmap.c	Mon Aug 12 11:22:05 2002
@@ -328,7 +328,7 @@
 				case SWAP_SUCCESS:
 					/* Free the pte_chain struct. */
 					pte_chain_free(pc, prev_pc, page);
-					break;
+					continue;
 				case SWAP_AGAIN:
 					/* Skip this pte, remembering status. */
 					prev_pc = pc;
@@ -336,12 +336,13 @@
 					continue;
 				case SWAP_FAIL:
 					ret = SWAP_FAIL;
-					break;
+					goto give_up;
 				case SWAP_ERROR:
 					ret = SWAP_ERROR;
-					break;
+					goto give_up;
 			}
 		}
+give_up:
 		/* Check whether we can convert to direct pte pointer */
 		pc = page->pte.chain;
 		if (pc && !pc->next) {

