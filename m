Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752120AbWCGIsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbWCGIsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 03:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbWCGIsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 03:48:04 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11999 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1752120AbWCGIsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 03:48:02 -0500
Date: Tue, 7 Mar 2006 10:47:46 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>
Subject: [PATCH] slab: fix offslab_limit in calculate_slab_order (Was: Slab
 corruption in 2.6.16-rc5-mm2)
In-Reply-To: <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0603071042370.18351@sbz-30.cs.Helsinki.FI>
References: <200603060117.16484.jesper.juhl@gmail.com> 
 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>  <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
  <200603062136.17098.jesper.juhl@gmail.com> 
 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com> 
 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com> 
 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org> <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006, Linus Torvalds wrote:
> In particular, as far as I can tell, that
> 
> +               /* More than offslab_limit objects will cause problems */
> +               if (flags & CFLGS_OFF_SLAB && cachep->num > offslab_limit)
> +                       break;
> 
> has been incorrectly translated for several reasons:
> 
>  - we shouldn't check "cachep->num > offslab_limit". We should check just 
>    "num > offslab_limit" (cachep->num is the _previous_ number we tested).
> 
>  - when we do "break", we've already incremented "gfporder", and we should 
>    correct for that.
> 
> Now, maybe I'm just off my rocker again (I've certainly been batting 0.000 
> so far, even if I think I've been finding real bugs). So who knows. But I 
> get the feeling that that patch is broken.
> 
> Either revert it, or try this (TOTALLY UNTESTED!!!) patch..
> 
> And hey, maybe I'm just crazy.

No you're not, it's broken. However, I think you're forgetting to reset 
cachep->num when we go over MAX_GFP_ORDER, no? This patch boots although 
I don't hit offslab limit.

			Pekka

[PATCH] slab: fix offslab_limit in calculate_slab_order

From: Linus Torvalds <torvalds@osdl.org>

The commit "[PATCH] slab: extract slab order calculation to separate
function" broke offslab_limit handling:

  - We should check for num instead of cachep->num because the latter
    is the number of objects for the _previous_ gfp order.

  - After hitting the offslab_limit, we need to correct gfporder and
    calculate left_over and cachep->num for that before exiting. We
    do this by keeping current state in local variables and previous
    state in cachep.

Linus spotted the problem and wrote the patch. I fixed gfporder
resetting when we go over MAX_GFP_ORDER and tested it with UM.

Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

diff --git a/mm/slab.c b/mm/slab.c
index add05d8..fe63479 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1628,25 +1628,22 @@ static inline size_t calculate_slab_orde
 			size_t size, size_t align, unsigned long flags)
 {
 	size_t left_over = 0;
+	int gfporder;
 
-	for (;; cachep->gfporder++) {
+	for (gfporder = 0 ; gfporder <= MAX_GFP_ORDER; gfporder++) {
 		unsigned int num;
 		size_t remainder;
 
-		if (cachep->gfporder > MAX_GFP_ORDER) {
-			cachep->num = 0;
-			break;
-		}
-
-		cache_estimate(cachep->gfporder, size, align, flags,
-			       &remainder, &num);
+		cache_estimate(gfporder, size, align, flags, &remainder, &num);
 		if (!num)
 			continue;
+
 		/* More than offslab_limit objects will cause problems */
-		if (flags & CFLGS_OFF_SLAB && cachep->num > offslab_limit)
+		if ((flags & CFLGS_OFF_SLAB) && num > offslab_limit)
 			break;
 
 		cachep->num = num;
+		cachep->gfporder = gfporder;
 		left_over = remainder;
 
 		/*
@@ -1660,6 +1657,9 @@ static inline size_t calculate_slab_orde
 			/* Acceptable internal fragmentation */
 			break;
 	}
+	if (cachep->gfporder > MAX_GFP_ORDER)
+		cachep->num = 0;
+
 	return left_over;
 }
 
