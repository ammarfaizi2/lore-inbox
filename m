Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbTFNNda (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 09:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbTFNNd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 09:33:29 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:56746 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265661AbTFNNd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 09:33:28 -0400
Date: Sat, 14 Jun 2003 15:47:08 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21 zlib merge #1 turboc
Message-ID: <20030614134708.GD15099@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo!

This patchset hat already made it into Linus' tree.  It merges the
interesting bits from zlib 1.1.4 into the kernel zlib, which is based
on 1.1.3.

Remove Turbo C workaround and fix modulo operation.

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack

--- linux-2.4.20/lib/zlib_inflate/infcodes.c~zlib_merge_turboc	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/lib/zlib_inflate/infcodes.c	2003-06-10 16:59:38.000000000 +0200
@@ -146,15 +146,9 @@
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
