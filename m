Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293721AbSCSFWN>; Tue, 19 Mar 2002 00:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293725AbSCSFWE>; Tue, 19 Mar 2002 00:22:04 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:44040 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S293721AbSCSFVo>;
	Tue, 19 Mar 2002 00:21:44 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15510.50722.885343.139998@argo.ozlabs.ibm.com>
Date: Tue, 19 Mar 2002 16:01:22 +1100 (EST)
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
In-Reply-To: <15509.51214.495427.580341@argo.ozlabs.ibm.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone pointed me at a previously-posted patch for the zlib
vulnerability.  While I was looking at that patch I realized that both
that patch and mine were buggy in different ways.  My patch was
freeing s->sub.trees.blens after that word had been overwritten by an
assignment to s->sub.decode.codes, whereas with the previously-posted
patch, it is still possible to get a double-free (if inflate_codes_new
returns NULL, it will leave s->mode == DTREE but s->sub.trees.blens
has already been freed).

Here is a new patch which should fix both those problems.

Paul.

diff -urN linux-2.4.19-pre3/arch/ppc/boot/lib/zlib.c pmac/arch/ppc/boot/lib/zlib.c
--- linux-2.4.19-pre3/arch/ppc/boot/lib/zlib.c	Mon Mar 18 13:34:47 2002
+++ pmac/arch/ppc/boot/lib/zlib.c	Tue Mar 19 15:46:09 2002
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.zlib.c 1.10 01/11/02 10:46:07 trini
+ * BK Id: SCCS/s.zlib.c 1.9 12/05/01 16:19:42 mporter
  */
 /*
  * This file is derived from various .h and .c files from the zlib-0.95
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
diff -urN linux-2.4.19-pre3/drivers/net/zlib.c pmac/drivers/net/zlib.c
--- linux-2.4.19-pre3/drivers/net/zlib.c	Sat Apr 28 23:02:45 2001
+++ pmac/drivers/net/zlib.c	Tue Mar 19 15:45:40 2002
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
@@ -3945,6 +3949,7 @@
           r = Z_MEM_ERROR;
           LEAVE
         }
+        ZFREE(z, s->sub.trees.blens);
         s->sub.decode.codes = c;
         s->sub.decode.tl = tl;
         s->sub.decode.td = td;
diff -urN linux-2.4.19-pre3/fs/jffs2/zlib.c pmac/fs/jffs2/zlib.c
--- linux-2.4.19-pre3/fs/jffs2/zlib.c	Mon Sep 24 09:31:33 2001
+++ pmac/fs/jffs2/zlib.c	Tue Mar 19 15:46:47 2002
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
@@ -3945,6 +3949,7 @@
           r = Z_MEM_ERROR;
           LEAVE
         }
+        ZFREE(z, s->sub.trees.blens);
         s->sub.decode.codes = c;
         s->sub.decode.tl = tl;
         s->sub.decode.td = td;
