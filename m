Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbSL0VrQ>; Fri, 27 Dec 2002 16:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbSL0VrQ>; Fri, 27 Dec 2002 16:47:16 -0500
Received: from shay.ecn.purdue.edu ([128.46.209.11]:2762 "EHLO
	shay.ecn.purdue.edu") by vger.kernel.org with ESMTP
	id <S264972AbSL0VrP>; Fri, 27 Dec 2002 16:47:15 -0500
From: Kevin Corry <corry@ecn.purdue.edu>
Message-Id: <200212272155.gBRLtWD7013508@shay.ecn.purdue.edu>
Subject: [PATCH] dm.c : Check memory allocations
To: joe@fib011235813.fsnet.co.uk (Joe Thornber)
Date: Fri, 27 Dec 2002 16:55:31 -0500 (EST)
Cc: dm-devel@sistina.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check memory allocations when cloning bio's.

--- linux-2.5.53a/drivers/md/dm.c	Mon Dec 23 23:21:04 2002
+++ linux-2.5.53b/drivers/md/dm.c	Fri Dec 27 14:50:29 2002
@@ -394,6 +393,10 @@
 		 */
 		clone = clone_bio(bio, ci->sector, ci->idx,
 				  bio->bi_vcnt - ci->idx, ci->sector_count);
+		if (!clone) {
+			dec_pending(ci->io, -ENOMEM);
+			return;
+		}
 		__map_bio(ti, clone, ci->io);
 		ci->sector_count = 0;
 
@@ -417,6 +420,10 @@
 		}
 
 		clone = clone_bio(bio, ci->sector, ci->idx, i - ci->idx, len);
+		if (!clone) {
+			dec_pending(ci->io, -ENOMEM);
+			return;
+		}
 		__map_bio(ti, clone, ci->io);
 
 		ci->sector += len;
