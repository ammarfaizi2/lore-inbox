Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272983AbTGaKyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272980AbTGaKwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:52:55 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:60933 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S272976AbTGaKvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:51:44 -0400
Date: Thu, 31 Jul 2003 11:51:43 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 6/6] dm: use sector_div()
Message-ID: <20030731105143.GJ394@fib011235813.fsnet.co.uk>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731104517.GD394@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use sector_div() rather than defining own version.  [Christophe Saout]
--- diff/drivers/md/dm-stripe.c	2003-06-30 10:07:21.000000000 +0100
+++ source/drivers/md/dm-stripe.c	2003-07-31 11:31:48.000000000 +0100
@@ -64,30 +64,6 @@
 }
 
 /*
- * FIXME: Nasty function, only present because we can't link
- * against __moddi3 and __divdi3.
- *
- * returns a == b * n
- */
-static int multiple(sector_t a, sector_t b, sector_t *n)
-{
-	sector_t acc, prev, i;
-
-	*n = 0;
-	while (a >= b) {
-		for (acc = b, prev = 0, i = 1;
-		     acc <= a;
-		     prev = acc, acc <<= 1, i <<= 1)
-			;
-
-		a -= prev;
-		*n += i >> 1;
-	}
-
-	return a == 0;
-}
-
-/*
  * Construct a striped mapping.
  * <number of stripes> <chunk size (2^^n)> [<dev_path> <offset>]+
  */
@@ -126,7 +102,8 @@
 		return -EINVAL;
 	}
 
-	if (!multiple(ti->len, stripes, &width)) {
+	width = ti->len;
+	if (sector_div(width, stripes)) {
 		ti->error = "dm-stripe: Target length not divisable by "
 		    "number of stripes";
 		return -EINVAL;
