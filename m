Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUG1LX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUG1LX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 07:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266874AbUG1LX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 07:23:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:64187 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266839AbUG1LXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 07:23:04 -0400
Date: Wed, 28 Jul 2004 13:22:22 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] fix zlib debug in ppc boot header
Message-ID: <20040728112222.GA7670@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ppc bootloader code will not compile with zlib debug enabled.
printf was not defined. Tested with vmlinux.coff
This patch was sent out earlier. Appearently it is not possible
to use the generic zlib copy in linux/lib

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.8-rc2-bk6.orig/arch/ppc/boot/common/misc-common.c linux-2.6.8-rc2-bk6/arch/ppc/boot/common/misc-common.c
--- linux-2.6.8-rc2-bk6.orig/arch/ppc/boot/common/misc-common.c	2004-06-16 05:19:23.000000000 +0000
+++ linux-2.6.8-rc2-bk6/arch/ppc/boot/common/misc-common.c	2004-07-28 07:10:40.163537401 +0000
@@ -67,6 +67,17 @@ extern unsigned char serial_getc(unsigne
 extern void serial_putc(unsigned long com_port, unsigned char c);
 #endif
 
+int
+printf(char const *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	_vprintk(putc, fmt, ap);
+	va_end(ap);
+	return 0;
+}
+
 void pause(void)
 {
 	puts("pause\n");
diff -purN linux-2.6.8-rc2-bk6.orig/arch/ppc/boot/lib/zlib.c linux-2.6.8-rc2-bk6/arch/ppc/boot/lib/zlib.c
--- linux-2.6.8-rc2-bk6.orig/arch/ppc/boot/lib/zlib.c	2004-06-16 05:19:03.000000000 +0000
+++ linux-2.6.8-rc2-bk6/arch/ppc/boot/lib/zlib.c	2004-07-28 07:47:52.879321378 +0000
@@ -1,3 +1,7 @@
+#if 0
+#define DEBUG_ZLIB 1
+#define verbose 1
+#endif
 /*
  * This file is derived from various .h and .c files from the zlib-0.95
  * distribution by Jean-loup Gailly and Mark Adler, with some additions
@@ -85,16 +89,16 @@ extern char *z_errmsg[]; /* indexed by 1
 
 /* Diagnostic functions */
 #ifdef DEBUG_ZLIB
-#  include <stdio.h>
+#  include <nonstdio.h>
 #  ifndef verbose
 #    define verbose 0
 #  endif
-#  define Assert(cond,msg) {if(!(cond)) z_error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
+#  define Assert(cond,msg) {if(!(cond)) printf(msg);}
+#  define Trace(x) printf x
+#  define Tracev(x) {if (verbose) printf x ;}
+#  define Tracevv(x) {if (verbose>1) printf x ;}
+#  define Tracec(c,x) {if (verbose && (c)) printf x ;}
+#  define Tracecv(c,x) {if (verbose>1 && (c)) printf x ;}
 #else
 #  define Assert(cond,msg)
 #  define Trace(x)
@@ -311,7 +315,7 @@ int inflateReset(
   z->msg = Z_NULL;
   z->state->mode = z->state->nowrap ? BLOCKS : METHOD;
   inflate_blocks_reset(z->state->blocks, z, &c);
-  Trace((stderr, "inflate: reset\n"));
+  Trace(("inflate: reset\n"));
   return Z_OK;
 }
 
@@ -328,7 +332,7 @@ int inflateEnd(
     inflate_blocks_free(z->state->blocks, z, &c);
   ZFREE(z, z->state, sizeof(struct internal_state));
   z->state = Z_NULL;
-  Trace((stderr, "inflate: end\n"));
+  Trace(("inflate: end\n"));
   return Z_OK;
 }
 
@@ -372,7 +376,7 @@ int inflateInit2(
     inflateEnd(z);
     return Z_MEM_ERROR;
   }
-  Trace((stderr, "inflate: allocated\n"));
+  Trace(("inflate: allocated\n"));
 
   /* reset state */
   inflateReset(z);
@@ -437,7 +441,7 @@ int inflate(
         z->state->sub.marker = 5;       /* can't try inflateSync */
         break;
       }
-      Trace((stderr, "inflate: zlib header ok\n"));
+      Trace(("inflate: zlib header ok\n"));
       z->state->mode = BLOCKS;
     case BLOCKS:
       r = inflate_blocks(z->state->blocks, z, r);
@@ -482,7 +486,7 @@ int inflate(
         z->state->sub.marker = 5;       /* can't try inflateSync */
         break;
       }
-      Trace((stderr, "inflate: zlib check ok\n"));
+      Trace(("inflate: zlib check ok\n"));
       z->state->mode = DONE;
     case DONE:
       return Z_STREAM_END;
@@ -766,7 +770,7 @@ local void inflate_blocks_reset(
   s->read = s->write = s->window;
   if (s->checkfn != Z_NULL)
     s->check = (*s->checkfn)(0L, Z_NULL, 0);
-  Trace((stderr, "inflate:   blocks reset\n"));
+  Trace(("inflate:   blocks reset\n"));
 }
 
 
@@ -789,7 +793,7 @@ local inflate_blocks_statef *inflate_blo
   s->end = s->window + w;
   s->checkfn = c;
   s->mode = TYPE;
-  Trace((stderr, "inflate:   blocks allocated\n"));
+  Trace(("inflate:   blocks allocated\n"));
   inflate_blocks_reset(s, z, &s->check);
   return s;
 }
@@ -822,7 +826,7 @@ local int inflate_blocks(
       switch (t >> 1)
       {
         case 0:                         /* stored */
-          Trace((stderr, "inflate:     stored block%s\n",
+          Trace(("inflate:     stored block%s\n",
                  s->last ? " (last)" : ""));
           DUMPBITS(3)
           t = k & 7;                    /* go to byte boundary */
@@ -830,7 +834,7 @@ local int inflate_blocks(
           s->mode = LENS;               /* get length of stored block */
           break;
         case 1:                         /* fixed */
-          Trace((stderr, "inflate:     fixed codes block%s\n",
+          Trace(("inflate:     fixed codes block%s\n",
                  s->last ? " (last)" : ""));
           {
             uInt bl, bd;
@@ -850,7 +854,7 @@ local int inflate_blocks(
           s->mode = CODES;
           break;
         case 2:                         /* dynamic */
-          Trace((stderr, "inflate:     dynamic codes block%s\n",
+          Trace(("inflate:     dynamic codes block%s\n",
                  s->last ? " (last)" : ""));
           DUMPBITS(3)
           s->mode = TABLE;
@@ -874,7 +878,7 @@ local int inflate_blocks(
       }
       s->sub.left = (uInt)b & 0xffff;
       b = k = 0;                      /* dump bits */
-      Tracev((stderr, "inflate:       stored length %u\n", s->sub.left));
+      Tracev(("inflate:       stored length %u\n", s->sub.left));
       s->mode = s->sub.left ? STORED : TYPE;
       break;
     case STORED:
@@ -889,7 +893,7 @@ local int inflate_blocks(
       q += t;  m -= t;
       if ((s->sub.left -= t) != 0)
         break;
-      Tracev((stderr, "inflate:       stored end, %lu total out\n",
+      Tracev(("inflate:       stored end, %lu total out\n",
               z->total_out + (q >= s->read ? q - s->read :
               (s->end - s->read) + (q - s->window))));
       s->mode = s->last ? DRY : TYPE;
@@ -917,7 +921,7 @@ local int inflate_blocks(
       s->sub.trees.nblens = t;
       DUMPBITS(14)
       s->sub.trees.index = 0;
-      Tracev((stderr, "inflate:       table sizes ok\n"));
+      Tracev(("inflate:       table sizes ok\n"));
       s->mode = BTREE;
     case BTREE:
       while (s->sub.trees.index < 4 + (s->sub.trees.table >> 10))
@@ -939,7 +943,7 @@ local int inflate_blocks(
         LEAVE
       }
       s->sub.trees.index = 0;
-      Tracev((stderr, "inflate:       bits tree ok\n"));
+      Tracev(("inflate:       bits tree ok\n"));
       s->mode = DTREE;
     case DTREE:
       while (t = s->sub.trees.table,
@@ -1002,7 +1006,7 @@ local int inflate_blocks(
           r = t;
           LEAVE
         }
-        Tracev((stderr, "inflate:       trees ok\n"));
+        Tracev(("inflate:       trees ok\n"));
         if ((c = inflate_codes_new(bl, bd, tl, td, z)) == Z_NULL)
         {
           inflate_trees_free(td, z);
@@ -1025,7 +1029,7 @@ local int inflate_blocks(
       inflate_trees_free(s->sub.decode.td, z);
       inflate_trees_free(s->sub.decode.tl, z);
       LOAD
-      Tracev((stderr, "inflate:       codes end, %lu total out\n",
+      Tracev(("inflate:       codes end, %lu total out\n",
               z->total_out + (q >= s->read ? q - s->read :
               (s->end - s->read) + (q - s->window))));
       if (!s->last)
@@ -1068,7 +1072,7 @@ local int inflate_blocks_free(
   inflate_blocks_reset(s, z, c);
   ZFREE(z, s->window, s->end - s->window);
   ZFREE(z, s, sizeof(struct inflate_blocks_state));
-  Trace((stderr, "inflate:   blocks freed\n"));
+  Trace(("inflate:   blocks freed\n"));
   return Z_OK;
 }
 
@@ -1230,7 +1234,7 @@ local uInt cpdext[] = { /* Extra bits fo
 #define N_MAX 288       /* maximum number of codes in any set */
 
 #ifdef DEBUG_ZLIB
-  uInt inflate_hufts;
+  local uInt inflate_hufts;
 #endif
 
 local int huft_build(
@@ -1687,7 +1691,7 @@ local inflate_codes_statef *inflate_code
     c->dbits = (Byte)bd;
     c->ltree = tl;
     c->dtree = td;
-    Tracev((stderr, "inflate:       codes new\n"));
+    Tracev(("inflate:       codes new\n"));
   }
   return c;
 }
@@ -1743,7 +1747,7 @@ local int inflate_codes(
       if (e == 0)               /* literal */
       {
         c->sub.lit = t->base;
-        Tracevv((stderr, t->base >= 0x20 && t->base < 0x7f ?
+        Tracevv((t->base >= 0x20 && t->base < 0x7f ?
                  "inflate:         literal '%c'\n" :
                  "inflate:         literal 0x%02x\n", t->base));
         c->mode = LIT;
@@ -1764,7 +1768,7 @@ local int inflate_codes(
       }
       if (e & 32)               /* end of block */
       {
-        Tracevv((stderr, "inflate:         end of block\n"));
+        Tracevv(("inflate:         end of block\n"));
         c->mode = WASH;
         break;
       }
@@ -1779,7 +1783,7 @@ local int inflate_codes(
       DUMPBITS(j)
       c->sub.code.need = c->dbits;
       c->sub.code.tree = c->dtree;
-      Tracevv((stderr, "inflate:         length %u\n", c->len));
+      Tracevv(("inflate:         length %u\n", c->len));
       c->mode = DIST;
     case DIST:          /* i: get distance next */
       j = c->sub.code.need;
@@ -1809,7 +1813,7 @@ local int inflate_codes(
       NEEDBITS(j)
       c->sub.copy.dist += (uInt)b & inflate_mask[j];
       DUMPBITS(j)
-      Tracevv((stderr, "inflate:         distance %u\n", c->sub.copy.dist));
+      Tracevv(("inflate:         distance %u\n", c->sub.copy.dist));
       c->mode = COPY;
     case COPY:          /* o: copying bytes in window, waiting for space */
 #ifndef __TURBOC__ /* Turbo C bug for following expression */
@@ -1860,7 +1864,7 @@ local void inflate_codes_free(
 )
 {
   ZFREE(z, c, sizeof(struct inflate_codes_state));
-  Tracev((stderr, "inflate:       codes free\n"));
+  Tracev(("inflate:       codes free\n"));
 }
 
 /*+++++*/
@@ -1995,7 +1999,7 @@ local int inflate_fast(
     if ((e = (t = tl + ((uInt)b & ml))->exop) == 0)
     {
       DUMPBITS(t->bits)
-      Tracevv((stderr, t->base >= 0x20 && t->base < 0x7f ?
+      Tracevv((t->base >= 0x20 && t->base < 0x7f ?
                 "inflate:         * literal '%c'\n" :
                 "inflate:         * literal 0x%02x\n", t->base));
       *q++ = (Byte)t->base;
@@ -2010,7 +2014,7 @@ local int inflate_fast(
         e &= 15;
         c = t->base + ((uInt)b & inflate_mask[e]);
         DUMPBITS(e)
-        Tracevv((stderr, "inflate:         * length %u\n", c));
+        Tracevv(("inflate:         * length %u\n", c));
 
         /* decode distance base of block to copy */
         GRABBITS(15);           /* max bits for distance code */
@@ -2024,7 +2028,7 @@ local int inflate_fast(
             GRABBITS(e)         /* get extra bits (up to 13) */
             d = t->base + ((uInt)b & inflate_mask[e]);
             DUMPBITS(e)
-            Tracevv((stderr, "inflate:         * distance %u\n", d));
+            Tracevv(("inflate:         * distance %u\n", d));
 
             /* do the copy */
             m -= c;
@@ -2069,7 +2073,7 @@ local int inflate_fast(
         if ((e = (t = t->next + ((uInt)b & inflate_mask[e]))->exop) == 0)
         {
           DUMPBITS(t->bits)
-          Tracevv((stderr, t->base >= 0x20 && t->base < 0x7f ?
+          Tracevv((t->base >= 0x20 && t->base < 0x7f ?
                     "inflate:         * literal '%c'\n" :
                     "inflate:         * literal 0x%02x\n", t->base));
           *q++ = (Byte)t->base;
@@ -2079,7 +2083,7 @@ local int inflate_fast(
       }
       else if (e & 32)
       {
-        Tracevv((stderr, "inflate:         * end of block\n"));
+        Tracevv(("inflate:         * end of block\n"));
         UNGRAB
         UPDATE
         return Z_STREAM_END;
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
