Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTGAQCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTGAQCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:02:16 -0400
Received: from [213.39.233.138] ([213.39.233.138]:36008 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262601AbTGAQCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:02:14 -0400
Date: Tue, 1 Jul 2003 18:16:37 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH RFC] 2.5.73 zlib #2 codefold
Message-ID: <20030701161637.GC25363@wohnheim.fh-wedel.de>
References: <20030701154522.GB25363@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030701154522.GB25363@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch folds three calls to memmove_update into one.  This is the
same structure that was in the 1.1.3 version of the zlib as well.  The
change towards 1.1.4 was mixed with a real bugfix, so it slipped
through my brain.

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon

--- linux-2.5.73/lib/zlib_inflate/inffast.c~zlib_codefold	2003-06-30 03:57:31.000000000 +0200
+++ linux-2.5.73/lib/zlib_inflate/inffast.c	2003-06-30 04:11:37.000000000 +0200
@@ -99,28 +99,18 @@
             /* do the copy */
             m -= c;
             r = q - d;
-            if (r < s->window)                  /* wrap if needed */
-            {
-              do {
+            if (r < s->window) {                /* wrap if needed */
+	      while (r < s->window) {
                 r += s->end - s->window;        /* force pointer in window */
-              } while (r < s->window);          /* covers invalid distances */
+              }                                 /* covers invalid distances */
               e = s->end - r;
-              if (c > e)
-              {
+              if (c > e) {
                 c -= e;                         /* wrapped copy */
 		memmove_update(&q, &r, &e);
                 r = s->window;
-		memmove_update(&q, &r, &c);
-              }
-              else                              /* normal copy */
-              {
-		memmove_update(&q, &r, &c);
               }
             }
-            else                                /* normal copy */
-            {
-              memmove_update(&q, &r, &c);
-            }
+            memmove_update(&q, &r, &c);
             break;
           }
           else if ((e & 64) == 0)
