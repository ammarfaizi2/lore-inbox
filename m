Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130324AbRBZQdl>; Mon, 26 Feb 2001 11:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130323AbRBZQdV>; Mon, 26 Feb 2001 11:33:21 -0500
Received: from www.wen-online.de ([212.223.88.39]:15884 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130329AbRBZQdR>;
	Mon, 26 Feb 2001 11:33:17 -0500
Date: Mon, 26 Feb 2001 17:33:09 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM balancing problems under 2.4.2-ac1
In-Reply-To: <Pine.LNX.4.31.0102232120531.8568-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0102261719180.2759-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, Rik van Riel wrote:

> If anybody as a good idea to make this code auto-balancing,
> please let me know.

(I haven't seen even one suggestion posted.. must be a real bugger)

I haven't found any silver bullets ;) but the one line bend-adjust
below does help the cache problem a little on my wimpy 128mb box.

Worth trying out on other boxen with other loads?  It doesn't get
swap in/out to a 1:1 ratio, but does improve it considerably by
scanning a larger portion of active pages prior to swapout.

(the other two lines are there only because it seemed reasonable;)

	-Mike

against 2.4.2-ac4

--- mm/vmscan.c.org	Mon Feb 26 09:31:46 2001
+++ mm/vmscan.c	Mon Feb 26 16:32:46 2001
@@ -278,6 +278,8 @@
 	/* Always start by trying to penalize the process that is allocating memory */
 	if (mm)
 		retval = swap_out_mm(mm, swap_amount(mm));
+	if (retval)
+		return retval;

 	/* Then, look at the other mm's */
 	counter = (mmlist_nr << SWAP_SHIFT) >> priority;
@@ -846,7 +848,7 @@
  * continue with its real work sooner. It also helps balancing when we
  * have multiple processes in try_to_free_pages simultaneously.
  */
-#define DEF_PRIORITY (6)
+#define DEF_PRIORITY (2)
 static int refill_inactive(unsigned int gfp_mask, int user)
 {
 	int count, start_count, maxtry;

