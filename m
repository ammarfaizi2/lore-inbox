Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292599AbSCRLEs>; Mon, 18 Mar 2002 06:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292829AbSCRLE3>; Mon, 18 Mar 2002 06:04:29 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:7684 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S292599AbSCRLEX>;
	Mon, 18 Mar 2002 06:04:23 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15509.51214.495427.580341@argo.ozlabs.ibm.com>
Date: Mon, 18 Mar 2002 21:57:18 +1100 (EST)
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH] zlib double-free bug
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently CERT published an advisory, warning about a bug in zlib where
a chunk of memory could get freed twice, depending on the data being
decompressed, which could potentially give a way to attack a system
using zlib.  The reference is

	http://www.cert.org/advisories/CA-2002-07.html

All 3 of the versions of zlib in the current 2.4 kernel have this bug.
The version in 2.5 doesn't because it handles memory allocation in a
different way.

The patch below fixes this bug in each of the three copies of zlib.c,
in the same way that it is fixed in the zlib-1.1.4 release (basically
by making sure that s->sub.trees.blens is always freed whenever, and
only when, s->mode is changed from BTREE or DTREE to some other value).

In the longer term I recommend that the 2.5.x changes to use a single
copy of zlib in lib/zlib_{deflate,inflate} should be back-ported to
2.4.  For now, this patch should be applied to 2.4.x since the bug is
a potential security hole if you are using PPP with Deflate
compression.

The patch also raises the minimum value of `windowBits' for
compression from 8 to 9, since using windowBits==8 causes memory
corruption (this was discovered by James Carlson, see
http://playground.sun.com/~carlsonj/ for details).  Current versions
of pppd avoid using windowBits==8 for this reason, but it is better to
have zlib protect itself as well.

Paul.

diff -urN linux-2.4.19-pre3/arch/ppc/boot/lib/zlib.c pmac/arch/ppc/boot/lib/zlib.c
--- linux-2.4.19-pre3/arch/ppc/boot/lib/zlib.c	Mon Mar 18 13:34:47 2002
+++ pmac/arch/ppc/boot/lib/zlib.c	Mon Mar 18 21:15:55 2002
@@ -928,7 +928,10 @@
       {
         r = t;
         if (r == Z_DATA_ERROR)
+	{
+          ZFREE(z, s->sub.trees.blens, s->sub.trees.nblens * sizeof(uInt));
           s->mode = BADB;
+	}
         LEAVE
       }
       s->sub.trees.index = 0;
@@ -964,6 +967,7 @@
           if (i + j > 258 + (t & 0x1f) + ((t >> 5) & 0x1f) ||
               (c == 16 && i < 1))
           {
+            ZFREE(z, s->sub.trees.blens, s->sub.trees.nblens * sizeof(uInt));
             s->mode = BADB;
             z->msg = "invalid bit length repeat";
             r = Z_DATA_ERROR;
@@ -991,7 +995,10 @@
         if (t != Z_OK)
         {
           if (t == (uInt)Z_DATA_ERROR)
+	  {
+            ZFREE(z, s->sub.trees.blens, s->sub.trees.nblens * sizeof(uInt));
             s->mode = BADB;
+	  }
           r = t;
           LEAVE
         }
@@ -1003,11 +1010,11 @@
           r = Z_MEM_ERROR;
           LEAVE
         }
-        ZFREE(z, s->sub.trees.blens, s->sub.trees.nblens * sizeof(uInt));
         s->sub.decode.codes = c;
         s->sub.decode.tl = tl;
         s->sub.decode.td = td;
       }
+      ZFREE(z, s->sub.trees.blens, s->sub.trees.nblens * sizeof(uInt));
       s->mode = CODES;
     case CODES:
       UPDATE
diff -urN linux-2.4.19-pre3/drivers/net/zlib.c pmac/drivers/net/zlib.c
--- linux-2.4.19-pre3/drivers/net/zlib.c	Sat Apr 28 23:02:45 2001
+++ pmac/drivers/net/zlib.c	Mon Mar 18 12:12:17 2002
@@ -14,7 +14,7 @@
  */
 
 /* 
- *  ==FILEVERSION 971210==
+ *  ==FILEVERSION 20020318==
  *
  * This marker is used by the Linux installation script to determine
  * whether an up-to-date version of this file is already installed.
@@ -772,7 +772,7 @@
         windowBits = -windowBits;
     }
     if (memLevel < 1 || memLevel > MAX_MEM_LEVEL || method != Z_DEFLATED ||
-        windowBits < 8 || windowBits > 15 || level < 0 || level > 9 ||
+        windowBits < 9 || windowBits > 15 || level < 0 || level > 9 ||
 	strategy < 0 || strategy > Z_HUFFMAN_ONLY) {
         return Z_STREAM_ERROR;
     }
@@ -3860,10 +3860,12 @@
                              &s->sub.trees.tb, z);
       if (t != Z_OK)
       {
-        ZFREE(z, s->sub.trees.blens);
         r = t;
         if (r == Z_DATA_ERROR)
+	{
+	  ZFREE(z, s->sub.trees.blens);
           s->mode = BADB;
+	}
         LEAVE
       }
       s->sub.trees.index = 0;
@@ -3928,11 +3930,13 @@
 #endif
         t = inflate_trees_dynamic(257 + (t & 0x1f), 1 + ((t >> 5) & 0x1f),
                                   s->sub.trees.blens, &bl, &bd, &tl, &td, z);
-        ZFREE(z, s->sub.trees.blens);
         if (t != Z_OK)
         {
           if (t == (uInt)Z_DATA_ERROR)
+	  {
+	    ZFREE(z, s->sub.trees.blens);
             s->mode = BADB;
+	  }
           r = t;
           LEAVE
         }
@@ -3949,6 +3953,7 @@
         s->sub.decode.tl = tl;
         s->sub.decode.td = td;
       }
+      ZFREE(z, s->sub.trees.blens);
       s->mode = CODES;
     case CODES:
       UPDATE
diff -urN linux-2.4.19-pre3/fs/jffs2/zlib.c pmac/fs/jffs2/zlib.c
--- linux-2.4.19-pre3/fs/jffs2/zlib.c	Mon Sep 24 09:31:33 2001
+++ pmac/fs/jffs2/zlib.c	Mon Mar 18 21:16:32 2002
@@ -14,7 +14,7 @@
  */
 
 /* 
- *  ==FILEVERSION 971210==
+ *  ==FILEVERSION 20020318==
  *
  * This marker is used by the Linux installation script to determine
  * whether an up-to-date version of this file is already installed.
@@ -772,7 +772,7 @@
         windowBits = -windowBits;
     }
     if (memLevel < 1 || memLevel > MAX_MEM_LEVEL || method != Z_DEFLATED ||
-        windowBits < 8 || windowBits > 15 || level < 0 || level > 9 ||
+        windowBits < 9 || windowBits > 15 || level < 0 || level > 9 ||
 	strategy < 0 || strategy > Z_HUFFMAN_ONLY) {
         return Z_STREAM_ERROR;
     }
@@ -3860,10 +3860,12 @@
                              &s->sub.trees.tb, z);
       if (t != Z_OK)
       {
-        ZFREE(z, s->sub.trees.blens);
         r = t;
         if (r == Z_DATA_ERROR)
+	{
+	  ZFREE(z, s->sub.trees.blens);
           s->mode = BADB;
+	}
         LEAVE
       }
       s->sub.trees.index = 0;
@@ -3928,11 +3930,13 @@
 #endif
         t = inflate_trees_dynamic(257 + (t & 0x1f), 1 + ((t >> 5) & 0x1f),
                                   s->sub.trees.blens, &bl, &bd, &tl, &td, z);
-        ZFREE(z, s->sub.trees.blens);
         if (t != Z_OK)
         {
           if (t == (uInt)Z_DATA_ERROR)
+	  {
+	    ZFREE(z, s->sub.trees.blens);
             s->mode = BADB;
+	  }
           r = t;
           LEAVE
         }
@@ -3949,6 +3953,7 @@
         s->sub.decode.tl = tl;
         s->sub.decode.td = td;
       }
+      ZFREE(z, s->sub.trees.blens);
       s->mode = CODES;
     case CODES:
       UPDATE
