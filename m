Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTFFTJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 15:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTFFTJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 15:09:59 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:5054 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262221AbTFFTJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 15:09:58 -0400
Date: Fri, 6 Jun 2003 21:23:25 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk11 zlib merge #1 turboc
Message-ID: <20030606192325.GG10487@wohnheim.fh-wedel.de>
References: <20030606183126.GA10487@wohnheim.fh-wedel.de> <20030606183247.GB10487@wohnheim.fh-wedel.de> <20030606183920.GC10487@wohnheim.fh-wedel.de> <20030606185210.GE10487@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030606185210.GE10487@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This is the first bit of the missing merge towards 1.1.4.  Applies on
top of the previous cleanups.

This one rips out an ugly #ifdef and seems to catch a theoretical
error possibility.  Always thought that they fixed more than they
officially admitted.

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu

--- linux-2.5.70-bk11/lib/zlib_inflate/infcodes.c~zlib_merge_turboc	2003-06-06 15:56:15.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/infcodes.c	2003-06-06 21:18:16.000000000 +0200
@@ -149,15 +149,9 @@
       DUMPBITS(j)
       c->mode = COPY;
     case COPY:          /* o: copying bytes in window, waiting for space */
-#ifndef __TURBOC__ /* Turbo C bug for following expression */
-      f = (uInt)(q - s->window) < c->sub.copy.dist ?
-          s->end - (c->sub.copy.dist - (q - s->window)) :
-          q - c->sub.copy.dist;
-#else
       f = q - c->sub.copy.dist;
-      if ((uInt)(q - s->window) < c->sub.copy.dist)
-        f = s->end - (c->sub.copy.dist - (uInt)(q - s->window));
-#endif
+      while (f < s->window)             /* modulo window size-"while" instead */
+        f += s->end - s->window;        /* of "if" handles invalid distances */
       while (c->len)
       {
         NEEDOUT
