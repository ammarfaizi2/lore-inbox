Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbTFNNfe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 09:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265670AbTFNNfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 09:35:34 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:4523 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265669AbTFNNfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 09:35:23 -0400
Date: Sat, 14 Jun 2003 15:49:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21 zlib merge #3 inffast
Message-ID: <20030614134912.GF15099@wohnheim.fh-wedel.de>
References: <20030614134708.GD15099@wohnheim.fh-wedel.de> <20030614134811.GE15099@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030614134811.GE15099@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reformat zlib_inflate_fast a bit, change one conditional into a loop
and fix one of three conditional cases.

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth

--- linux-2.4.20/lib/zlib_inflate/inffast.c~zlib_merge_inffast	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/lib/zlib_inflate/inffast.c	2003-06-10 17:00:43.000000000 +0200
@@ -88,28 +88,41 @@
 
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
