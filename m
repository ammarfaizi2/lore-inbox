Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTFFTrd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 15:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTFFTrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 15:47:32 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:13503 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262254AbTFFTrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 15:47:31 -0400
Date: Fri, 6 Jun 2003 22:00:51 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk11 zlib merge #3 inffast.c
Message-ID: <20030606200051.GI10487@wohnheim.fh-wedel.de>
References: <20030606183126.GA10487@wohnheim.fh-wedel.de> <20030606183247.GB10487@wohnheim.fh-wedel.de> <20030606183920.GC10487@wohnheim.fh-wedel.de> <20030606185210.GE10487@wohnheim.fh-wedel.de> <20030606192325.GG10487@wohnheim.fh-wedel.de> <20030606192814.GH10487@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030606192814.GH10487@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This patch took me only 30 minutes to verify, too easy! :)

Most of it is reformatting, but the functional bits should fix real
problems.  A loop is introduced, just like in the turboc patch and one
of the three condition bodies has been expanded.

Jörn

-- 
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike

--- linux-2.5.70-bk11/lib/zlib_inflate/inffast.c~zlib_merge_inffast	2003-06-06 15:56:15.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/inffast.c	2003-06-06 21:53:50.000000000 +0200
@@ -90,28 +90,41 @@
 
             /* do the copy */
             m -= c;
-            if ((uInt)(q - s->window) >= d)     /* offset before dest */
-            {                                   /*  just copy */
-              r = q - d;
-              *q++ = *r++;  c--;        /* minimum count is three, */
-              *q++ = *r++;  c--;        /*  so unroll loop a little */
-            }
-            else                        /* else offset after destination */
+            r = q - d;
+            if (r < s->window)                  /* wrap if needed */
             {
-              e = d - (uInt)(q - s->window); /* bytes from offset to end */
-              r = s->end - e;           /* pointer to offset */
-              if (c > e)                /* if source crosses, */
+              do {
+                r += s->end - s->window;        /* force pointer in window */
+              } while (r < s->window);          /* covers invalid distances */
+              e = s->end - r;
+              if (c > e)
               {
-                c -= e;                 /* copy to end of window */
+                c -= e;                         /* wrapped copy */
                 do {
-                  *q++ = *r++;
+                    *q++ = *r++;
                 } while (--e);
-                r = s->window;          /* copy rest from start of window */
+                r = s->window;
+                do {
+                    *q++ = *r++;
+                } while (--c);
+              }
+              else                              /* normal copy */
+              {
+                *q++ = *r++;  c--;
+                *q++ = *r++;  c--;
+                do {
+                    *q++ = *r++;
+                } while (--c);
               }
             }
-            do {                        /* copy all or what's left */
-              *q++ = *r++;
-            } while (--c);
+            else                                /* normal copy */
+            {
+              *q++ = *r++;  c--;
+              *q++ = *r++;  c--;
+              do {
+                *q++ = *r++;
+              } while (--c);
+            }
             break;
           }
           else if ((e & 64) == 0)
