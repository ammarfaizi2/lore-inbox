Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263529AbUDURXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUDURXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 13:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbUDURXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 13:23:04 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:60586 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263529AbUDURW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 13:22:59 -0400
Date: Wed, 21 Apr 2004 19:22:49 +0200 (CEST)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, <andrea@suse.de>, <agruen@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: slab-alignment-rework.patch in -mc
In-Reply-To: <Pine.LNX.4.58.0404201146560.1775@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0404211910510.11762-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

below is a patch that redefines align:

- align not zero: use the specified alignment. I think values smaller than
sizeof(void*) will work, even on archs with strict alignment requirement
(or at least: slab shouldn't crash. Obviously the user must handle the
alignment properly).

- align zero:
* debug on: align to sizeof(void*)
* debug off, SLAB_HWCACHE_ALIGN clear: align to sizeof(void*)
* debug off, SLAB_HWCACHE_ALIGN set: align to the smaller of
   - cache_line_size()
   - the object size, rounded up to the next power of two.
  Slab never honored cache align for tiny objects: otherwise the 32-byte
  kmalloc objects would use 128 byte objects.

The patch is against 2.6.6-rc2. What do you think?

There is one additional point: right now slab uses ints for the bufctls.
Using short would save two bytes for each object. Initially I had used
short, but davem objected. IIRC because some archs do not handle short
effeciently. Should I allow arch overrides for the bufctls? On i386,
saving two bytes might allow a few additional anon_vma objects in each
page.

--
	Manfred

<<<
--- 2.6/mm/slab.c	2004-04-16 22:29:56.000000000 +0200
+++ build-2.6/mm/slab.c	2004-04-21 18:16:03.000000000 +0200
@@ -1150,14 +1150,22 @@
 		BUG();

 	if (align) {
-		/* minimum supported alignment: */
-		if (align < BYTES_PER_WORD)
-			align = BYTES_PER_WORD;
-
 		/* combinations of forced alignment and advanced debugging is
 		 * not yet implemented.
 		 */
 		flags &= ~(SLAB_RED_ZONE|SLAB_STORE_USER);
+	} else {
+		if (flags & SLAB_HWCACHE_ALIGN) {
+			/* Default alignment: as specified by the arch code.
+			 * Except if an object is really small, then squeeze multiple
+			 * into one cacheline.
+			 */
+			align = cache_line_size();
+			while (size <= align/2)
+				align /= 2;
+		} else {
+			align = BYTES_PER_WORD;
+		}
 	}

 	/* Get cache's description obj. */
@@ -1210,15 +1218,6 @@
 		 */
 		flags |= CFLGS_OFF_SLAB;

-	if (!align) {
-		/* Default alignment: compile time specified l1 cache size.
-		 * Except if an object is really small, then squeeze multiple
-		 * into one cacheline.
-		 */
-		align = cache_line_size();
-		while (size <= align/2)
-			align /= 2;
-	}
 	size = ALIGN(size, align);

 	/* Cal size (in pages) of slabs, and the num of objs per slab.
<<<<

