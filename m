Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266031AbRGHWzb>; Sun, 8 Jul 2001 18:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbRGHWzL>; Sun, 8 Jul 2001 18:55:11 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7181 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S266031AbRGHWzK>;
	Sun, 8 Jul 2001 18:55:10 -0400
Date: Mon, 9 Jul 2001 00:55:02 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: swap read ahead bug
Message-ID: <Pine.LNX.4.33.0107090015160.28551-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In do_swap_page() we don't flush read ahead pages to memory, so the cpu
might read the wrong data into the icache. I can reproduce this on my ppc
machine and the patch below fixes this problem.
If the patch is ok, you might also want to remove the wait_on_page() since
the following lock_page() implies this wait already.

bye, Roman

diff -u -r1.1.1.13 -r1.3
--- mm/memory.c	2001/07/08 15:05:26	1.1.1.13
+++ mm/memory.c	2001/07/08 17:12:37	1.3
@@ -1109,8 +1109,6 @@
 			return -1;
 		}
 		wait_on_page(page);
-		flush_page_to_ram(page);
-		flush_icache_page(vma, page);
 	}

 	/*
@@ -1140,6 +1138,8 @@
 		pte = pte_mkwrite(pte_mkdirty(pte));
 	UnlockPage(page);

+	flush_page_to_ram(page);
+	flush_icache_page(vma, page);
 	set_pte(page_table, pte);

 	/* No need to invalidate - it was non-present before */

