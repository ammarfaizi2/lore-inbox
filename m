Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130486AbRCDRXp>; Sun, 4 Mar 2001 12:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRCDRXf>; Sun, 4 Mar 2001 12:23:35 -0500
Received: from www.wen-online.de ([212.223.88.39]:19213 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130461AbRCDRXb>;
	Sun, 4 Mar 2001 12:23:31 -0500
Date: Sun, 4 Mar 2001 18:23:14 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [TINY patch] VM compromise?
Message-ID: <Pine.LNX.4.33.0103041813280.541-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

Thoughts on the below?

2.4.2.ac11-virgin
real    9m50.322s
user    7m7.810s
sys     0m36.020s

2.4.2.ac11+limit kswap expectations and scan slightly heavier
real    8m23.122s
user    7m8.860s
sys     0m33.960s

At no time do I see cache collapse as in earlier kernels, nor do I see
cache bloat as in virgin ac >= 3.  I think this is a good compromise
candidate.  This is almost as good as my best by fiddling with I/O..
[8m3s] _without_ fiddling with I/O, and it only changes 2 lines instead
of nuking a large chunk of your [damn difficult] balancing work :)

Why do I think it works?

1. kswapd attempting to fix everything in one run doesn't take
into account that tasks not only allocate, they also free.  If
we try to fix everything, we're usually assuring an overreaction.

2. scanning a little more agressively brings the cache shrinkage
to swap ratio to something more realistic for this work load..
and I strongly suspect many others as well.


--- linux-2.4.2.ac11/mm/vmscan.c.org	Sun Mar  4 17:28:54 2001
+++ linux-2.4.2.ac11/mm/vmscan.c	Sun Mar  4 17:15:23 2001
@@ -847,7 +847,7 @@
  * continue with its real work sooner. It also helps balancing when we
  * have multiple processes in try_to_free_pages simultaneously.
  */
-#define DEF_PRIORITY (6)
+#define DEF_PRIORITY (4)
 static int refill_inactive(unsigned int gfp_mask, int user)
 {
 	int count, start_count, maxtry;
@@ -858,7 +858,7 @@
 		maxtry = 6;
 	} else {
 		/* kswapd */
-		count = inactive_shortage() + free_shortage();
+		count = (inactive_shortage() + free_shortage()) >> 2;
 		maxtry = 1 << DEF_PRIORITY;
 	}


