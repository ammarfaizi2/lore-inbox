Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752453AbWCFWfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbWCFWfI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbWCFWfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:35:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751308AbWCFWfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:35:05 -0500
Date: Mon, 6 Mar 2006 14:34:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
In-Reply-To: <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com> 
 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>  <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
  <200603062136.17098.jesper.juhl@gmail.com> 
 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com> 
 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com> 
 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ok, 
 I have a new favorite suspect.

It is this one: commit 4d268eba1187ef66844a6a33b9431e5d0dadd4ad:

    [PATCH] slab: extract slab order calculation to separate function
    
    This patch moves the ugly loop that determines the 'optimal' size (page order)
    of cache slabs from kmem_cache_create() to a separate function and cleans it
    up a bit.
    
    Thanks to Matthew Wilcox for the help with this patch.
    
    Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

and I think it may be broken.

In particular, as far as I can tell, that

+               /* More than offslab_limit objects will cause problems */
+               if (flags & CFLGS_OFF_SLAB && cachep->num > offslab_limit)
+                       break;

has been incorrectly translated for several reasons:

 - we shouldn't check "cachep->num > offslab_limit". We should check just 
   "num > offslab_limit" (cachep->num is the _previous_ number we tested).

 - when we do "break", we've already incremented "gfporder", and we should 
   correct for that.

Now, maybe I'm just off my rocker again (I've certainly been batting 0.000 
so far, even if I think I've been finding real bugs). So who knows. But I 
get the feeling that that patch is broken.

Either revert it, or try this (TOTALLY UNTESTED!!!) patch..

And hey, maybe I'm just crazy.

		Linus

----
diff --git a/mm/slab.c b/mm/slab.c
index 2b0b151..1cca41d 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1628,25 +1628,22 @@ static inline size_t calculate_slab_orde
 			size_t size, size_t align, unsigned long flags)
 {
 	size_t left_over = 0;
+	int gfporder;
 
-	for (;; cachep->gfporder++) {
+	for (gfporder = 0 ; gfporder < MAX_GFP_ORDER; gfporder++) {
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
