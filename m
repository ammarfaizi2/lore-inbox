Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263844AbUCZBLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbUCZADA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:03:00 -0500
Received: from waste.org ([209.173.204.2]:50585 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263823AbUCYX6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:01 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11.524465763@selenic.com>
Message-Id: <12.524465763@selenic.com>
Subject: [PATCH 11/22] /dev/random: flag pools that need entropy reserve
Date: Thu, 25 Mar 2004 17:57:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  flag pools that need entropy reserve

Add flag for pools that need to leave an entropy reserve


 tiny-mpm/drivers/char/random.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/char/random.c~reserved-in-struct drivers/char/random.c
--- tiny/drivers/char/random.c~reserved-in-struct	2004-03-20 13:38:27.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:27.000000000 -0600
@@ -497,6 +497,7 @@ struct entropy_store {
 	unsigned add_ptr;
 	int entropy_count;
 	int input_rotate;
+	int reserved;
 	struct poolinfo *poolinfo;
 	spinlock_t lock;
 	__u32 pool[0];
@@ -1277,13 +1278,14 @@ static inline void xfer_secondary_pool(s
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo->POOLBITS) {
 		int bytes = min_t(int, nbytes, TMP_BUF_SIZE);
+		int reserved = r->reserved ? random_read_wakeup_thresh/4 : 0;
 
 		DEBUG_ENT("going to reseed %s with %d bits "
 			  "(%d of %d requested)\n", r->name,
 			  bytes * 8, nbytes * 8, r->entropy_count);
 
 		bytes=extract_entropy(input_pool, tmp, bytes,
-				      random_read_wakeup_thresh / 8, 0,
+				      random_read_wakeup_thresh/8, reserved,
 				      EXTRACT_ENTROPY_LIMIT);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);

_
