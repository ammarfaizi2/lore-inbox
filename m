Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbTFFS0L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbTFFS0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:26:11 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:27831 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262170AbTFFSZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:25:48 -0400
Date: Fri, 6 Jun 2003 20:39:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk11 zlib cleanup #3 Z_NULL
Message-ID: <20030606183920.GC10487@wohnheim.fh-wedel.de>
References: <20030606183126.GA10487@wohnheim.fh-wedel.de> <20030606183247.GB10487@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030606183247.GB10487@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

s/Z_NULL/NULL/g.

This still demands a follow-up patch as I didn't remove the pointless
casts.  (inflate_huft *)NULL indeed.

How do you feel about "if (z->state->blocks != NULL)"?  Remove the
pointless !=NULL or keep it?

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."

--- linux-2.5.70-bk11/lib/zlib_inflate/inflate.c~zlib_cleanup_Z_NULL	2003-06-06 20:14:10.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/inflate.c	2003-06-06 20:14:27.000000000 +0200
@@ -18,12 +18,12 @@
 	z_streamp z
 )
 {
-  if (z == Z_NULL || z->state == Z_NULL || z->workspace == Z_NULL)
+  if (z == NULL || z->state == NULL || z->workspace == NULL)
     return Z_STREAM_ERROR;
   z->total_in = z->total_out = 0;
-  z->msg = Z_NULL;
+  z->msg = NULL;
   z->state->mode = z->state->nowrap ? BLOCKS : METHOD;
-  zlib_inflate_blocks_reset(z->state->blocks, z, Z_NULL);
+  zlib_inflate_blocks_reset(z->state->blocks, z, NULL);
   return Z_OK;
 }
 
@@ -32,11 +32,11 @@
 	z_streamp z
 )
 {
-  if (z == Z_NULL || z->state == Z_NULL || z->workspace == Z_NULL)
+  if (z == NULL || z->state == NULL || z->workspace == NULL)
     return Z_STREAM_ERROR;
-  if (z->state->blocks != Z_NULL)
+  if (z->state->blocks != NULL)
     zlib_inflate_blocks_free(z->state->blocks, z);
-  z->state = Z_NULL;
+  z->state = NULL;
   return Z_OK;
 }
 
@@ -48,16 +48,16 @@
 	int stream_size
 )
 {
-  if (version == Z_NULL || version[0] != ZLIB_VERSION[0] ||
-      stream_size != sizeof(z_stream) || z->workspace == Z_NULL)
+  if (version == NULL || version[0] != ZLIB_VERSION[0] ||
+      stream_size != sizeof(z_stream) || z->workspace == NULL)
       return Z_VERSION_ERROR;
 
   /* initialize state */
-  if (z == Z_NULL)
+  if (z == NULL)
     return Z_STREAM_ERROR;
-  z->msg = Z_NULL;
+  z->msg = NULL;
   z->state = &WS(z)->internal_state;
-  z->state->blocks = Z_NULL;
+  z->state->blocks = NULL;
 
   /* handle undocumented nowrap option (no zlib header or check) */
   z->state->nowrap = 0;
@@ -77,8 +77,8 @@
 
   /* create inflate_blocks state */
   if ((z->state->blocks =
-      zlib_inflate_blocks_new(z, z->state->nowrap ? Z_NULL : zlib_adler32, (uInt)1 << w))
-      == Z_NULL)
+      zlib_inflate_blocks_new(z, z->state->nowrap ? NULL : zlib_adler32, (uInt)1 << w))
+      == NULL)
   {
     zlib_inflateEnd(z);
     return Z_MEM_ERROR;
@@ -125,7 +125,7 @@
   int r, trv;
   uInt b;
 
-  if (z == Z_NULL || z->state == Z_NULL || z->next_in == Z_NULL)
+  if (z == NULL || z->state == NULL || z->next_in == NULL)
     return Z_STREAM_ERROR;
   trv = f == Z_FINISH ? Z_BUF_ERROR : Z_OK;
   r = Z_BUF_ERROR;
@@ -260,7 +260,7 @@
   uLong r, w;   /* temporaries to save total_in and total_out */
 
   /* set up */
-  if (z == Z_NULL || z->state == Z_NULL)
+  if (z == NULL || z->state == NULL)
     return Z_STREAM_ERROR;
   if (z->state->mode != I_BAD)
   {
@@ -313,7 +313,7 @@
 	z_streamp z
 )
 {
-  if (z == Z_NULL || z->state == Z_NULL || z->state->blocks == Z_NULL)
+  if (z == NULL || z->state == NULL || z->state->blocks == NULL)
     return Z_STREAM_ERROR;
   return zlib_inflate_blocks_sync_point(z->state->blocks);
 }
@@ -352,7 +352,7 @@
 	/* is there room until end of buffer? */
 	if (t > m) t = m;
 	/* update check information */
-	if (s->checkfn != Z_NULL)
+	if (s->checkfn != NULL)
 	    s->check = (*s->checkfn)(s->check, q, t);
 	memcpy(q, p, t);
 	q += t;
--- linux-2.5.70-bk11/lib/zlib_deflate/deflate.c~zlib_cleanup_Z_NULL	2003-06-06 20:14:10.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_deflate/deflate.c	2003-06-06 20:14:27.000000000 +0200
@@ -199,13 +199,13 @@
      * output size for (length,distance) codes is <= 24 bits.
      */
 
-    if (version == Z_NULL || version[0] != my_version[0] ||
+    if (version == NULL || version[0] != my_version[0] ||
         stream_size != sizeof(z_stream)) {
 	return Z_VERSION_ERROR;
     }
-    if (strm == Z_NULL) return Z_STREAM_ERROR;
+    if (strm == NULL) return Z_STREAM_ERROR;
 
-    strm->msg = Z_NULL;
+    strm->msg = NULL;
 
     if (level == Z_DEFAULT_COMPRESSION) level = 6;
 
@@ -266,7 +266,7 @@
     uInt n;
     IPos hash_head = 0;
 
-    if (strm == Z_NULL || strm->state == Z_NULL || dictionary == Z_NULL)
+    if (strm == NULL || strm->state == NULL || dictionary == NULL)
 	return Z_STREAM_ERROR;
 
     s = (deflate_state *) strm->state;
@@ -305,11 +305,11 @@
 {
     deflate_state *s;
     
-    if (strm == Z_NULL || strm->state == Z_NULL)
+    if (strm == NULL || strm->state == NULL)
         return Z_STREAM_ERROR;
 
     strm->total_in = strm->total_out = 0;
-    strm->msg = Z_NULL;
+    strm->msg = NULL;
     strm->data_type = Z_UNKNOWN;
 
     s = (deflate_state *)strm->state;
@@ -340,7 +340,7 @@
     compress_func func;
     int err = Z_OK;
 
-    if (strm == Z_NULL || strm->state == Z_NULL) return Z_STREAM_ERROR;
+    if (strm == NULL || strm->state == NULL) return Z_STREAM_ERROR;
     s = (deflate_state *) strm->state;
 
     if (level == Z_DEFAULT_COMPRESSION) {
@@ -394,7 +394,7 @@
     if (len > strm->avail_out) len = strm->avail_out;
     if (len == 0) return;
 
-    if (strm->next_out != Z_NULL) {
+    if (strm->next_out != NULL) {
 	memcpy(strm->next_out, s->pending_out, len);
 	strm->next_out += len;
     }
@@ -416,13 +416,13 @@
     int old_flush; /* value of flush param for previous deflate call */
     deflate_state *s;
 
-    if (strm == Z_NULL || strm->state == Z_NULL ||
+    if (strm == NULL || strm->state == NULL ||
 	flush > Z_FINISH || flush < 0) {
         return Z_STREAM_ERROR;
     }
     s = (deflate_state *) strm->state;
 
-    if ((strm->next_in == Z_NULL && strm->avail_in != 0) ||
+    if ((strm->next_in == NULL && strm->avail_in != 0) ||
 	(s->status == FINISH_STATE && flush != Z_FINISH)) {
         return Z_STREAM_ERROR;
     }
@@ -553,7 +553,7 @@
     int status;
     deflate_state *s;
 
-    if (strm == Z_NULL || strm->state == Z_NULL) return Z_STREAM_ERROR;
+    if (strm == NULL || strm->state == NULL) return Z_STREAM_ERROR;
     s = (deflate_state *) strm->state;
 
     status = s->status;
@@ -562,7 +562,7 @@
       return Z_STREAM_ERROR;
     }
 
-    strm->state = Z_NULL;
+    strm->state = NULL;
 
     return status == BUSY_STATE ? Z_DATA_ERROR : Z_OK;
 }
@@ -584,7 +584,7 @@
     deflate_workspace *mem;
 
 
-    if (source == Z_NULL || dest == Z_NULL || source->state == Z_NULL) {
+    if (source == NULL || dest == NULL || source->state == NULL) {
         return Z_STREAM_ERROR;
     }
 
@@ -962,7 +962,7 @@
 #define FLUSH_BLOCK_ONLY(s, eof) { \
    zlib_tr_flush_block(s, (s->block_start >= 0L ? \
                    (char *)&s->window[(unsigned)s->block_start] : \
-                   (char *)Z_NULL), \
+                   (char *)NULL), \
 		(ulg)((long)s->strstart - s->block_start), \
 		(eof)); \
    s->block_start = s->strstart; \
--- linux-2.5.70-bk11/lib/zlib_inflate/infblock.c~zlib_cleanup_Z_NULL	2003-06-06 20:14:10.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/infblock.c	2003-06-06 20:14:27.000000000 +0200
@@ -71,7 +71,7 @@
 	uLong *c
 )
 {
-  if (c != Z_NULL)
+  if (c != NULL)
     *c = s->check;
   if (s->mode == CODES)
     zlib_inflate_codes_free(s->sub.decode.codes, z);
@@ -79,8 +79,8 @@
   s->bitk = 0;
   s->bitb = 0;
   s->read = s->write = s->window;
-  if (s->checkfn != Z_NULL)
-    z->adler = s->check = (*s->checkfn)(0L, (const Byte *)Z_NULL, 0);
+  if (s->checkfn != NULL)
+    z->adler = s->check = (*s->checkfn)(0L, (const Byte *)NULL, 0);
 }
 
 inflate_blocks_statef *zlib_inflate_blocks_new(
@@ -97,7 +97,7 @@
   s->end = s->window + w;
   s->checkfn = c;
   s->mode = TYPE;
-  zlib_inflate_blocks_reset(s, z, Z_NULL);
+  zlib_inflate_blocks_reset(s, z, NULL);
   return s;
 }
 
@@ -141,7 +141,7 @@
 
             zlib_inflate_trees_fixed(&bl, &bd, &tl, &td, z);
             s->sub.decode.codes = zlib_inflate_codes_new(bl, bd, tl, td, z);
-            if (s->sub.decode.codes == Z_NULL)
+            if (s->sub.decode.codes == NULL)
             {
               r = Z_MEM_ERROR;
               LEAVE
@@ -270,7 +270,7 @@
           s->sub.trees.index = i;
         }
       }
-      s->sub.trees.tb = Z_NULL;
+      s->sub.trees.tb = NULL;
       {
         uInt bl, bd;
         inflate_huft *tl, *td;
@@ -289,7 +289,7 @@
           r = t;
           LEAVE
         }
-        if ((c = zlib_inflate_codes_new(bl, bd, tl, td, z)) == Z_NULL)
+        if ((c = zlib_inflate_codes_new(bl, bd, tl, td, z)) == NULL)
         {
           r = Z_MEM_ERROR;
           LEAVE
@@ -333,7 +333,7 @@
 	z_streamp z
 )
 {
-  zlib_inflate_blocks_reset(s, z, Z_NULL);
+  zlib_inflate_blocks_reset(s, z, NULL);
   return Z_OK;
 }
 
@@ -351,7 +351,7 @@
 
 /* Returns true if inflate is currently at the end of a block generated
  * by Z_SYNC_FLUSH or Z_FULL_FLUSH. 
- * IN assertion: s != Z_NULL
+ * IN assertion: s != NULL
  */
 int zlib_inflate_blocks_sync_point(
 	inflate_blocks_statef *s
--- linux-2.5.70-bk11/lib/zlib_inflate/inftrees.c~zlib_cleanup_Z_NULL	2003-06-06 20:14:10.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/inftrees.c	2003-06-06 20:14:27.000000000 +0200
@@ -139,7 +139,7 @@
   } while (--i);
   if (c[0] == n)                /* null input--all zero length codes */
   {
-    *t = (inflate_huft *)Z_NULL;
+    *t = (inflate_huft *)NULL;
     *m = 0;
     return Z_OK;
   }
@@ -193,8 +193,8 @@
   p = v;                        /* grab values in bit order */
   h = -1;                       /* no tables yet--level -1 */
   w = -l;                       /* bits decoded == (l * h) */
-  u[0] = (inflate_huft *)Z_NULL;        /* just to keep compilers happy */
-  q = (inflate_huft *)Z_NULL;   /* ditto */
+  u[0] = (inflate_huft *)NULL;        /* just to keep compilers happy */
+  q = (inflate_huft *)NULL;     /* ditto */
   z = 0;                        /* ditto */
 
   /* go through the bit lengths (k already is bits in shortest code) */
@@ -302,7 +302,7 @@
   uInt *v;              /* work area for huft_build */
   
   v = WS(z)->tree_work_area_1;
-  r = huft_build(c, 19, 19, (uInt*)Z_NULL, (uInt*)Z_NULL,
+  r = huft_build(c, 19, 19, (uInt*)NULL, (uInt*)NULL,
                  tb, bb, hp, &hn, v);
   if (r == Z_DATA_ERROR)
     z->msg = (char*)"oversubscribed dynamic bit lengths tree";
--- linux-2.5.70-bk11/lib/zlib_inflate/infutil.c~zlib_cleanup_Z_NULL	2003-06-06 20:14:10.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_inflate/infutil.c	2003-06-06 20:14:27.000000000 +0200
@@ -44,7 +44,7 @@
   z->total_out += n;
 
   /* update check information */
-  if (s->checkfn != Z_NULL)
+  if (s->checkfn != NULL)
     z->adler = s->check = (*s->checkfn)(s->check, q, n);
 
   /* copy as far as end of window */
@@ -70,7 +70,7 @@
     z->total_out += n;
 
     /* update check information */
-    if (s->checkfn != Z_NULL)
+    if (s->checkfn != NULL)
       z->adler = s->check = (*s->checkfn)(s->check, q, n);
 
     /* copy */
--- linux-2.5.70-bk11/include/linux/zlib.h~zlib_cleanup_Z_NULL	2003-06-06 20:14:10.000000000 +0200
+++ linux-2.5.70-bk11/include/linux/zlib.h	2003-06-06 20:15:04.000000000 +0200
@@ -91,7 +91,7 @@
    memory management. The compression library attaches no meaning to the
    opaque value.
 
-   zalloc must return Z_NULL if there is not enough memory for the object.
+   zalloc must return NULL if there is not enough memory for the object.
    If zlib is used in a multi-threaded application, zalloc and zfree must be
    thread safe.
 
@@ -153,8 +153,6 @@
 #define Z_DEFLATED   8
 /* The deflate compression method (the only one supported in this version) */
 
-#define Z_NULL  0  /* for initializing zalloc, zfree, opaque */
-
                         /* basic functions */
 
 extern const char * zlib_zlibVersion (void);
@@ -176,7 +174,7 @@
 
      Initializes the internal stream state for compression. The fields
    zalloc, zfree and opaque must be initialized before by the caller.
-   If zalloc and zfree are set to Z_NULL, deflateInit updates them to
+   If zalloc and zfree are set to NULL, deflateInit updates them to
    use default allocation functions.
 
      The compression level must be Z_DEFAULT_COMPRESSION, or between 0 and 9:
@@ -298,11 +296,11 @@
 
      Initializes the internal stream state for decompression. The fields
    next_in, avail_in, and workspace must be initialized before by
-   the caller. If next_in is not Z_NULL and avail_in is large enough (the exact
+   the caller. If next_in is not NULL and avail_in is large enough (the exact
    value depends on the compression method), inflateInit determines the
    compression method from the zlib header and allocates all data structures
    accordingly; otherwise the allocation will be deferred to the first call of
-   inflate.  If zalloc and zfree are set to Z_NULL, inflateInit updates them to
+   inflate.  If zalloc and zfree are set to NULL, inflateInit updates them to
    use default allocation functions.
 
      inflateInit returns Z_OK if success, Z_MEM_ERROR if there was not enough
--- linux-2.5.70-bk11/include/linux/zutil.h~zlib_cleanup_Z_NULL	2003-06-06 19:50:47.000000000 +0200
+++ linux-2.5.70-bk11/include/linux/zutil.h	2003-06-06 20:16:34.000000000 +0200
@@ -81,7 +81,7 @@
    An Adler-32 checksum is almost as reliable as a CRC32 but can be computed
    much faster. Usage example:
 
-     uLong adler = adler32(0L, Z_NULL, 0);
+     uLong adler = adler32(0L, NULL, 0);
 
      while (read_buffer(buffer, length) != EOF) {
        adler = adler32(adler, buffer, length);
@@ -96,7 +96,7 @@
     unsigned long s2 = (adler >> 16) & 0xffff;
     int k;
 
-    if (buf == Z_NULL) return 1L;
+    if (buf == NULL) return 1L;
 
     while (len > 0) {
         k = len < NMAX ? len : NMAX;
