Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbTGAPbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 11:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTGAPbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 11:31:10 -0400
Received: from [213.39.233.138] ([213.39.233.138]:10396 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262445AbTGAPbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 11:31:05 -0400
Date: Tue, 1 Jul 2003 17:45:22 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH RFC] 2.5.73 zlib #1 memmove
Message-ID: <20030701154522.GB25363@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I currently have some mail problems that might take a while to
  resolve.  wohnheim.fh-wedel.de has a new dns-entry and the old one
  has a max lifetime on one week. :(

  I'm trying to resolve that problem but please keep linux-kernel on
  CC:. That way I can at least read the archives until the problems
  are history. ]

Joakim found a performance issue in the zlib and after some back and
forth, it appears that memmove() should be the correct solution.

The code in question copies a string from the LZ77 sliding window into
the output buffer.  The string is 3-258 bytes long with a tendency
towards small strings.  The zlib uses this code to do the copy:

*q++ = *r++;  c--;
*q++ = *r++;  c--;
do {
	*q++ = *r++;
} while (--c);

The first two lines are loop unrolling.  Apart from being ugly, this
should also be slower than memmove(), so I propose this patch.

Jörn

-- 
Fantasy is more important than knowlegde. Knowlegde is limited,
while fantasy embraces the whole world.
-- Albert Einstein

--- linux-2.5.73/lib/zlib_inflate/inffast.c~zlib_memcpy	2003-06-30 03:51:54.000000000 +0200
+++ linux-2.5.73/lib/zlib_inflate/inffast.c	2003-06-30 04:22:32.000000000 +0200
@@ -20,6 +20,14 @@
 #define GRABBITS(j) {while(k<(j)){b|=((uLong)NEXTBYTE)<<k;k+=8;}}
 #define UNGRAB {c=z->avail_in-n;c=(k>>3)<c?k>>3:c;n+=c;p-=c;k-=c<<3;}
 
+static inline void memmove_update(Byte **dest, Byte **src, size_t *n)
+{
+	memmove(*dest, *src, *n);
+	*dest += *n;
+	*src += *n;
+	*n = 0;
+}
+
 /* Called with number of bytes left to write in window at least 258
    (the maximum string length) and number of input bytes available
    at least ten.  The ten bytes are six bytes for the longest length/
@@ -100,30 +108,18 @@
               if (c > e)
               {
                 c -= e;                         /* wrapped copy */
-                do {
-                    *q++ = *r++;
-                } while (--e);
+		memmove_update(&q, &r, &e);
                 r = s->window;
-                do {
-                    *q++ = *r++;
-                } while (--c);
+		memmove_update(&q, &r, &c);
               }
               else                              /* normal copy */
               {
-                *q++ = *r++;  c--;
-                *q++ = *r++;  c--;
-                do {
-                    *q++ = *r++;
-                } while (--c);
+		memmove_update(&q, &r, &c);
               }
             }
             else                                /* normal copy */
             {
-              *q++ = *r++;  c--;
-              *q++ = *r++;  c--;
-              do {
-                *q++ = *r++;
-              } while (--c);
+              memmove_update(&q, &r, &c);
             }
             break;
           }
