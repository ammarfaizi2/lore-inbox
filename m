Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318013AbSHLNlk>; Mon, 12 Aug 2002 09:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318014AbSHLNlk>; Mon, 12 Aug 2002 09:41:40 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:20153 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S318009AbSHLNlj>; Mon, 12 Aug 2002 09:41:39 -0400
Message-ID: <20020812134527.18720.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Mon, 12 Aug 2002 15:45:27 +0200
To: riel@nl.linux.org
Cc: linux-kernel@vger.kernel.org
Subject: pte_chain leak in rmap code (2.5.31)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

While browsing through rmap.c in 2.5.31 I found what looks like a
bug introduced by the PageDirect optimizations. Look at the following
piece of code in try_to_unmap:

	for (pc = page->pte.chain; pc; pc = next_pc) {
		next_pc = pc->next;
		switch (try_to_unmap_one(page, pc->ptep)) {
			case SWAP_SUCCESS:
				/* Free the pte_chain struct. */
				pte_chain_free(pc, prev_pc, page);
				break;
			case SWAP_AGAIN:
				/* Skip this pte, remembering status. */
				prev_pc = pc;
				ret = SWAP_AGAIN;
				continue;
			case SWAP_FAIL:
				ret = SWAP_FAIL;
				break;
			case SWAP_ERROR:
				ret = SWAP_ERROR;
				break;
		}
	}

Note the strange use of continue and break which both achieve the same!
What was meant to happen (judging from rmap-13c) is that we break
out of the for-Loop once SWAP_FAIL or SWAP_ERROR is returned from
try_to_unmap_one. However, this doesn't happen and a subsequent call
to pte_chain_free will use the wrong value for prev_pc.

The impact seems to be at least leakage of pte_chain structures.

I propose the following (untested) patch:

--- rmap.c      Sun Aug 11 03:41:54 2002
+++ /home/ehrhardt/rmap.c       Mon Aug 12 15:49:25 2002
@@ -336,9 +336,11 @@
                                        continue;
                                case SWAP_FAIL:
                                        ret = SWAP_FAIL;
+                                       pc = NULL
                                        break;
                                case SWAP_ERROR:
                                        ret = SWAP_ERROR;
+                                       pc = NULL
                                        break;
                        }
                }

   regards   Christian Ehrhardt

-- 
THAT'S ALL FOLKS!
