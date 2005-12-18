Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVLRIX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVLRIX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 03:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbVLRIX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 03:23:27 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:36076 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932544AbVLRIX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 03:23:27 -0500
Subject: [PATCH] micro optimization of cache_estimate in slab.c
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 03:23:09 -0500
Message-Id: <1134894189.13138.208.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I know this is really just a micro optimization, but I figured I'd
submit it anyway.  Looking into the slab code, I came across the
cache_estimate function, which has the following code:

	i = 0;
	while (i*size + ALIGN(base+i*extra, align) <= wastage)
		i++;
	if (i > 0)
		i--;

Now this is counting linearly up and will be O(n) for n = number of
objects in the page order. Since objects range up to 202 (according to
my /proc/slabinfo). So I figured there must be a better way.  So I added
this:

	i = 0;
	do {
		x = 1;
		while ((x+i)*size + ALIGN(base+(x+i)*extra, align) <= wastage)
			x <<= 1;
		i += (x >> 1);
	} while (x > 1);

Which now makes it O(log n).  This basically does a binary search for
the upper range.  I tested this code in userspace, and it works just the
same as the original code, but with less iterations.

I know this is really a micro optimization, but if you think every usec
counts, then we can use this patch ;)

-- Steve

Index: linux-2.6.15-rc5/mm/slab.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/slab.c	2005-12-16 16:24:09.000000000 -0500
+++ linux-2.6.15-rc5/mm/slab.c	2005-12-18 03:16:18.000000000 -0500
@@ -700,6 +700,7 @@
 		 int flags, size_t *left_over, unsigned int *num)
 {
 	int i;
+	int x;
 	size_t wastage = PAGE_SIZE<<gfporder;
 	size_t extra = 0;
 	size_t base = 0;
@@ -709,10 +710,12 @@
 		extra = sizeof(kmem_bufctl_t);
 	}
 	i = 0;
-	while (i*size + ALIGN(base+i*extra, align) <= wastage)
-		i++;
-	if (i > 0)
-		i--;
+	do {
+		x = 1;
+		while ((x+i)*size + ALIGN(base+(x+i)*extra, align) <= wastage)
+			x <<= 1;
+		i += (x >> 1);
+	} while (x > 1);
 
 	if (i > SLAB_LIMIT)
 		i = SLAB_LIMIT;


