Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbTFETdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 15:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbTFETdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 15:33:49 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:48592 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264921AbTFETdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 15:33:32 -0400
Date: Thu, 5 Jun 2003 21:46:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk9 kick FAR out of the zlib
Message-ID: <20030605194644.GA22439@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while back:

On Fri, 30 May 2003 14:38:07 -0700, Linus Torvalds wrote:
> On Fri, 30 May 2003, Jörn Engel wrote:
> > 
> > How about an all or nothing approach?  If you really want to get rid
> > of K&R, change indentation as well, rip out some of the rather
> > tasteless macros (ZEXPORT, ZEXPORTVA, ZEXTERN, FAR, ...) and so on.
> 
> I'd love to, but I suspect we lack the motivation to do so, and there 
> aren't any obvious upsides. Yes, the code is ugly, but it's also fairly 
> stable so people seldom need to look at it.

Today was a lazy day and that is often motivation enough.  The patch
below removes FAR, the typedefs using FAR (Bytef and friends) and the
function prototypes for zalloc and zfree that should have gone earlier
already.

Hope you like it.

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon


--- linux-2.5.70-bk9/include/linux/zconf.h~zlib_cleanup_FAR	2003-04-07 19:32:18.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zconf.h	2003-06-05 21:35:04.000000000 +0200
@@ -66,21 +66,10 @@
 #ifndef ZEXTERN
 #  define ZEXTERN extern
 #endif
-#ifndef FAR
-#   define FAR
-#endif
 
 typedef unsigned char  Byte;  /* 8 bits */
 typedef unsigned int   uInt;  /* 16 bits or more */
 typedef unsigned long  uLong; /* 32 bits or more */
-
-typedef Byte  FAR Bytef;
-typedef char  FAR charf;
-typedef int   FAR intf;
-typedef uInt  FAR uIntf;
-typedef uLong FAR uLongf;
-
-typedef void FAR *voidpf;
 typedef void     *voidp;
 
 #include <linux/types.h> /* for off_t */
--- linux-2.5.70-bk9/include/linux/zlib.h~zlib_cleanup_FAR	2003-06-05 18:26:01.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zlib.h	2003-06-05 21:30:48.000000000 +0200
@@ -60,22 +60,19 @@
   crash even in case of corrupted input.
 */
 
-typedef voidpf (*alloc_func) OF((voidpf opaque, uInt items, uInt size));
-typedef void   (*free_func)  OF((voidpf opaque, voidpf address));
-
 struct internal_state;
 
 typedef struct z_stream_s {
-    Bytef    *next_in;  /* next input byte */
+    Byte    *next_in;   /* next input byte */
     uInt     avail_in;  /* number of bytes available at next_in */
     uLong    total_in;  /* total nb of input bytes read so far */
 
-    Bytef    *next_out; /* next output byte should be put there */
+    Byte    *next_out;  /* next output byte should be put there */
     uInt     avail_out; /* remaining free space at next_out */
     uLong    total_out; /* total nb of bytes output so far */
 
     char     *msg;      /* last error message, NULL if no error */
-    struct internal_state FAR *state; /* not visible by applications */
+    struct internal_state *state; /* not visible by applications */
 
     void     *workspace; /* memory allocated for this stream */
     int      ws_num;    /* index in the internal workspace array */
@@ -85,7 +82,7 @@
     uLong   reserved;   /* reserved for future use */
 } z_stream;
 
-typedef z_stream FAR *z_streamp;
+typedef z_stream *z_streamp;
 
 /*
    The application must update next_in and avail_in when avail_in has
@@ -465,7 +462,7 @@
 */
                             
 ZEXTERN int ZEXPORT zlib_deflateSetDictionary OF((z_streamp strm,
-						     const Bytef *dictionary,
+						     const Byte *dictionary,
 						     uInt  dictLength));
 /*
      Initializes the compression dictionary from the given byte sequence
@@ -574,7 +571,7 @@
 */
 
 ZEXTERN int ZEXPORT zlib_inflateSetDictionary OF((z_streamp strm,
-						     const Bytef *dictionary,
+						     const Byte *dictionary,
 						     uInt  dictLength));
 /*
      Initializes the decompression dictionary from the given uncompressed byte
@@ -656,9 +653,9 @@
     struct internal_state {int dummy;}; /* hack for buggy compilers */
 #endif
 
-ZEXTERN const char   * ZEXPORT zlib_zError           OF((int err));
-ZEXTERN int            ZEXPORT zlib_inflateSyncPoint OF((z_streamp z));
-ZEXTERN const uLongf * ZEXPORT zlib_get_crc_table    OF((void));
+ZEXTERN const char  * ZEXPORT zlib_zError           OF((int err));
+ZEXTERN int           ZEXPORT zlib_inflateSyncPoint OF((z_streamp z));
+ZEXTERN const uLong * ZEXPORT zlib_get_crc_table    OF((void));
 
 #ifdef __cplusplus
 }
--- linux-2.5.70-bk9/include/linux/zutil.h~zlib_cleanup_FAR	2003-06-05 18:26:01.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zutil.h	2003-06-05 21:18:26.000000000 +0200
@@ -24,9 +24,7 @@
 /* compile with -Dlocal if your debugger can't find static symbols */
 
 typedef unsigned char  uch;
-typedef uch FAR uchf;
 typedef unsigned short ush;
-typedef ush FAR ushf;
 typedef unsigned long  ulg;
 
         /* common constants */
@@ -64,7 +62,7 @@
 
          /* functions */
 
-typedef uLong (ZEXPORT *check_func) OF((uLong check, const Bytef *buf,
+typedef uLong (ZEXPORT *check_func) OF((uLong check, const Byte *buf,
 				       uInt len));
 
 
@@ -96,7 +94,7 @@
      if (adler != original_adler) error();
 */
 static inline uLong zlib_adler32(uLong adler,
-				 const Bytef *buf,
+				 const Byte *buf,
 				 uInt len)
 {
     unsigned long s1 = adler & 0xffff;
--- linux-2.5.70-bk9/lib/zlib_deflate/deflate.c~zlib_cleanup_FAR	2003-06-05 20:54:12.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_deflate/deflate.c	2003-06-05 21:20:57.000000000 +0200
@@ -73,7 +73,7 @@
 local void lm_init        OF((deflate_state *s));
 local void putShortMSB    OF((deflate_state *s, uInt b));
 local void flush_pending  OF((z_streamp strm));
-local int read_buf        OF((z_streamp strm, Bytef *buf, unsigned size));
+local int read_buf        OF((z_streamp strm, Byte *buf, unsigned size));
 local uInt longest_match  OF((deflate_state *s, IPos cur_match));
 
 #ifdef DEBUG_ZLIB
@@ -161,7 +161,7 @@
  */
 #define CLEAR_HASH(s) \
     s->head[s->hash_size-1] = NIL; \
-    memset((charf *)s->head, 0, (unsigned)(s->hash_size-1)*sizeof(*s->head));
+    memset((char *)s->head, 0, (unsigned)(s->hash_size-1)*sizeof(*s->head));
 
 /* ========================================================================= */
 int zlib_deflateInit_(
@@ -194,7 +194,7 @@
     static char* my_version = ZLIB_VERSION;
     deflate_workspace *mem;
 
-    ushf *overlay;
+    ush *overlay;
     /* We overlay pending_buf and d_buf+l_buf. This works since the average
      * output size for (length,distance) codes is <= 24 bits.
      */
@@ -222,7 +222,7 @@
         return Z_STREAM_ERROR;
     }
     s = (deflate_state *) &(mem->deflate_memory);
-    strm->state = (struct internal_state FAR *)s;
+    strm->state = (struct internal_state *)s;
     s->strm = strm;
 
     s->noheader = noheader;
@@ -235,14 +235,14 @@
     s->hash_mask = s->hash_size - 1;
     s->hash_shift =  ((s->hash_bits+MIN_MATCH-1)/MIN_MATCH);
 
-    s->window = (Bytef *) mem->window_memory;
-    s->prev   = (Posf *)  mem->prev_memory;
-    s->head   = (Posf *)  mem->head_memory;
+    s->window = (Byte *) mem->window_memory;
+    s->prev   = (Pos *)  mem->prev_memory;
+    s->head   = (Pos *)  mem->head_memory;
 
     s->lit_bufsize = 1 << (memLevel + 6); /* 16K elements by default */
 
-    overlay = (ushf *) mem->overlay_memory;
-    s->pending_buf = (uchf *) overlay;
+    overlay = (ush *) mem->overlay_memory;
+    s->pending_buf = (uch *) overlay;
     s->pending_buf_size = (ulg)s->lit_bufsize * (sizeof(ush)+2L);
 
     s->d_buf = overlay + s->lit_bufsize/sizeof(ush);
@@ -258,7 +258,7 @@
 /* ========================================================================= */
 int zlib_deflateSetDictionary(
 	z_streamp strm,
-	const Bytef *dictionary,
+	const Byte *dictionary,
 	uInt  dictLength
 )
 {
@@ -282,7 +282,7 @@
 	dictionary += dictLength - length; /* use the tail of the dictionary */
 #endif
     }
-    memcpy((charf *)s->window, dictionary, length);
+    memcpy((char *)s->window, dictionary, length);
     s->strstart = length;
     s->block_start = (long)length;
 
@@ -583,7 +583,7 @@
 #else
     deflate_state *ds;
     deflate_state *ss;
-    ushf *overlay;
+    ush *overlay;
     deflate_workspace *mem;
 
 
@@ -599,15 +599,15 @@
 
     ds = &(mem->deflate_memory);
 
-    dest->state = (struct internal_state FAR *) ds;
+    dest->state = (struct internal_state *) ds;
     *ds = *ss;
     ds->strm = dest;
 
-    ds->window = (Bytef *) mem->window_memory;
-    ds->prev   = (Posf *)  mem->prev_memory;
-    ds->head   = (Posf *)  mem->head_memory;
-    overlay = (ushf *) mem->overlay_memory;
-    ds->pending_buf = (uchf *) overlay;
+    ds->window = (Byte *) mem->window_memory;
+    ds->prev   = (Pos *)  mem->prev_memory;
+    ds->head   = (Pos *)  mem->head_memory;
+    overlay = (ush *) mem->overlay_memory;
+    ds->pending_buf = (uch *) overlay;
 
     memcpy(ds->window, ss->window, ds->w_size * 2 * sizeof(Byte));
     memcpy(ds->prev, ss->prev, ds->w_size * sizeof(Pos));
@@ -635,7 +635,7 @@
  */
 local int read_buf(
 	z_streamp strm,
-	Bytef *buf,
+	Byte *buf,
 	unsigned size
 )
 {
@@ -698,8 +698,8 @@
     IPos cur_match;                             /* current match */
 {
     unsigned chain_length = s->max_chain_length;/* max hash chain length */
-    register Bytef *scan = s->window + s->strstart; /* current string */
-    register Bytef *match;                       /* matched string */
+    register Byte *scan = s->window + s->strstart; /* current string */
+    register Byte *match;                       /* matched string */
     register int len;                           /* length of current match */
     int best_len = s->prev_length;              /* best match length so far */
     int nice_match = s->nice_match;             /* stop if match long enough */
@@ -708,18 +708,18 @@
     /* Stop when cur_match becomes <= limit. To simplify the code,
      * we prevent matches with the string of window index 0.
      */
-    Posf *prev = s->prev;
+    Pos *prev = s->prev;
     uInt wmask = s->w_mask;
 
 #ifdef UNALIGNED_OK
     /* Compare two bytes at a time. Note: this is not always beneficial.
      * Try with and without -DUNALIGNED_OK to check.
      */
-    register Bytef *strend = s->window + s->strstart + MAX_MATCH - 1;
-    register ush scan_start = *(ushf*)scan;
-    register ush scan_end   = *(ushf*)(scan+best_len-1);
+    register Byte *strend = s->window + s->strstart + MAX_MATCH - 1;
+    register ush scan_start = *(ush*)scan;
+    register ush scan_end   = *(ush*)(scan+best_len-1);
 #else
-    register Bytef *strend = s->window + s->strstart + MAX_MATCH;
+    register Byte *strend = s->window + s->strstart + MAX_MATCH;
     register Byte scan_end1  = scan[best_len-1];
     register Byte scan_end   = scan[best_len];
 #endif
@@ -751,8 +751,8 @@
         /* This code assumes sizeof(unsigned short) == 2. Do not use
          * UNALIGNED_OK if your compiler uses a different size.
          */
-        if (*(ushf*)(match+best_len-1) != scan_end ||
-            *(ushf*)match != scan_start) continue;
+        if (*(ush*)(match+best_len-1) != scan_end ||
+            *(ush*)match != scan_start) continue;
 
         /* It is not necessary to compare scan[2] and match[2] since they are
          * always equal when the other bytes match, given that the hash keys
@@ -766,10 +766,10 @@
         Assert(scan[2] == match[2], "scan[2]?");
         scan++, match++;
         do {
-        } while (*(ushf*)(scan+=2) == *(ushf*)(match+=2) &&
-                 *(ushf*)(scan+=2) == *(ushf*)(match+=2) &&
-                 *(ushf*)(scan+=2) == *(ushf*)(match+=2) &&
-                 *(ushf*)(scan+=2) == *(ushf*)(match+=2) &&
+        } while (*(ush*)(scan+=2) == *(ush*)(match+=2) &&
+                 *(ush*)(scan+=2) == *(ush*)(match+=2) &&
+                 *(ush*)(scan+=2) == *(ush*)(match+=2) &&
+                 *(ush*)(scan+=2) == *(ush*)(match+=2) &&
                  scan < strend);
         /* The funny "do {}" generates better code on most compilers */
 
@@ -818,7 +818,7 @@
             best_len = len;
             if (len >= nice_match) break;
 #ifdef UNALIGNED_OK
-            scan_end = *(ushf*)(scan+best_len-1);
+            scan_end = *(ush*)(scan+best_len-1);
 #else
             scan_end1  = scan[best_len-1];
             scan_end   = scan[best_len];
@@ -841,8 +841,8 @@
     int length;
 {
     /* check that the match is indeed a match */
-    if (memcmp((charf *)s->window + match,
-                (charf *)s->window + start, length) != EQUAL) {
+    if (memcmp((char *)s->window + match,
+                (char *)s->window + start, length) != EQUAL) {
         fprintf(stderr, " start %u, match %u, length %d\n",
 		start, match, length);
         do {
@@ -873,7 +873,7 @@
     deflate_state *s;
 {
     register unsigned n, m;
-    register Posf *p;
+    register Pos *p;
     unsigned more;    /* Amount of free space at the end of the window. */
     uInt wsize = s->w_size;
 
@@ -895,7 +895,7 @@
          */
         } else if (s->strstart >= wsize+MAX_DIST(s)) {
 
-            memcpy((charf *)s->window, (charf *)s->window+wsize,
+            memcpy((char *)s->window, (char *)s->window+wsize,
                    (unsigned)wsize);
             s->match_start -= wsize;
             s->strstart    -= wsize; /* we now have strstart >= MAX_DIST */
@@ -964,8 +964,8 @@
  */
 #define FLUSH_BLOCK_ONLY(s, eof) { \
    zlib_tr_flush_block(s, (s->block_start >= 0L ? \
-                   (charf *)&s->window[(unsigned)s->block_start] : \
-                   (charf *)Z_NULL), \
+                   (char *)&s->window[(unsigned)s->block_start] : \
+                   (char *)Z_NULL), \
 		(ulg)((long)s->strstart - s->block_start), \
 		(eof)); \
    s->block_start = s->strstart; \
--- linux-2.5.70-bk9/lib/zlib_deflate/deftree.c~zlib_cleanup_FAR	2003-06-05 17:48:50.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_deflate/deftree.c	2003-06-05 21:23:40.000000000 +0200
@@ -113,7 +113,7 @@
 
 struct static_tree_desc_s {
     const ct_data *static_tree;  /* static tree or NULL */
-    const intf *extra_bits;      /* extra bits for each code or NULL */
+    const int *extra_bits;       /* extra bits for each code or NULL */
     int     extra_base;          /* base index for extra_bits */
     int     elems;               /* max number of elements in the tree */
     int     max_length;          /* max bit length for the codes */
@@ -136,7 +136,7 @@
 local void init_block     OF((deflate_state *s));
 local void pqdownheap     OF((deflate_state *s, ct_data *tree, int k));
 local void gen_bitlen     OF((deflate_state *s, tree_desc *desc));
-local void gen_codes      OF((ct_data *tree, int max_code, ushf *bl_count));
+local void gen_codes      OF((ct_data *tree, int max_code, ush *bl_count));
 local void build_tree     OF((deflate_state *s, tree_desc *desc));
 local void scan_tree      OF((deflate_state *s, ct_data *tree, int max_code));
 local void send_tree      OF((deflate_state *s, ct_data *tree, int max_code));
@@ -149,7 +149,7 @@
 local unsigned bi_reverse OF((unsigned value, int length));
 local void bi_windup      OF((deflate_state *s));
 local void bi_flush       OF((deflate_state *s));
-local void copy_block     OF((deflate_state *s, charf *buf, unsigned len,
+local void copy_block     OF((deflate_state *s, char *buf, unsigned len,
                               int header));
 
 #ifndef DEBUG_ZLIB
@@ -414,7 +414,7 @@
     ct_data *tree        = desc->dyn_tree;
     int max_code         = desc->max_code;
     const ct_data *stree = desc->stat_desc->static_tree;
-    const intf *extra    = desc->stat_desc->extra_bits;
+    const int *extra     = desc->stat_desc->extra_bits;
     int base             = desc->stat_desc->extra_base;
     int max_length       = desc->stat_desc->max_length;
     int h;              /* heap index */
@@ -497,7 +497,7 @@
 local void gen_codes(
 	ct_data *tree,             /* the tree to decorate */
 	int max_code,              /* largest code with non zero frequency */
-	ushf *bl_count             /* number of codes at each bit length */
+	ush *bl_count             /* number of codes at each bit length */
 )
 {
     ush next_code[MAX_BITS+1]; /* next code value for each bit length */
@@ -793,7 +793,7 @@
  */
 void zlib_tr_stored_block(
 	deflate_state *s,
-	charf *buf,       /* input block */
+	char *buf,        /* input block */
 	ulg stored_len,   /* length of input block */
 	int eof           /* true if this is the last block for a file */
 )
@@ -857,7 +857,7 @@
  */
 ulg zlib_tr_flush_block(
 	deflate_state *s,
-	charf *buf,       /* input block, or NULL if too old */
+	char *buf,        /* input block, or NULL if too old */
 	ulg stored_len,   /* length of input block */
 	int eof           /* true if this is the last block for a file */
 )
@@ -914,7 +914,7 @@
     if (stored_len <= opt_lenb && eof && s->compressed_len==0L && seekable()) {
 #  endif
         /* Since LIT_BUFSIZE <= 2*WSIZE, the input data must be there: */
-        if (buf == (charf*)0) error ("block vanished");
+        if (buf == (char*)0) error ("block vanished");
 
         copy_block(s, buf, (unsigned)stored_len, 0); /* without header */
         s->compressed_len = stored_len << 3;
@@ -1090,7 +1090,7 @@
  */
 local void copy_block(
 	deflate_state *s,
-	charf    *buf,    /* the input data */
+	char    *buf,     /* the input data */
 	unsigned len,     /* its length */
 	int      header   /* true if block header must be written */
 )
--- linux-2.5.70-bk9/lib/zlib_deflate/defutil.h~zlib_cleanup_FAR	2003-06-05 20:54:12.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_deflate/defutil.h	2003-06-05 21:22:04.000000000 +0200
@@ -46,7 +46,7 @@
         ush  dad;        /* father node in Huffman tree */
         ush  len;        /* length of bit string */
     } dl;
-} FAR ct_data;
+} ct_data;
 
 #define Freq fc.freq
 #define Code fc.code
@@ -59,10 +59,9 @@
     ct_data *dyn_tree;           /* the dynamic tree */
     int     max_code;            /* largest code with non zero frequency */
     static_tree_desc *stat_desc; /* the corresponding static tree */
-} FAR tree_desc;
+} tree_desc;
 
 typedef ush Pos;
-typedef Pos FAR Posf;
 typedef unsigned IPos;
 
 /* A Pos is an index in the character window. We use short instead of int to
@@ -72,9 +71,9 @@
 typedef struct deflate_state {
     z_streamp strm;      /* pointer back to this zlib stream */
     int   status;        /* as the name implies */
-    Bytef *pending_buf;  /* output still pending */
+    Byte *pending_buf;   /* output still pending */
     ulg   pending_buf_size; /* size of pending_buf */
-    Bytef *pending_out;  /* next pending byte to output to the stream */
+    Byte *pending_out;   /* next pending byte to output to the stream */
     int   pending;       /* nb of bytes in the pending buffer */
     int   noheader;      /* suppress zlib header and adler32 */
     Byte  data_type;     /* UNKNOWN, BINARY or ASCII */
@@ -87,7 +86,7 @@
     uInt  w_bits;        /* log2(w_size)  (8..16) */
     uInt  w_mask;        /* w_size - 1 */
 
-    Bytef *window;
+    Byte *window;
     /* Sliding window. Input bytes are read into the second half of the window,
      * and move to the first half later to keep a dictionary of at least wSize
      * bytes. With this organization, matches are limited to a distance of
@@ -102,13 +101,13 @@
      * is directly used as sliding window.
      */
 
-    Posf *prev;
+    Pos *prev;
     /* Link to older string with same hash index. To limit the size of this
      * array to 64K, this link is maintained only for the last 32K strings.
      * An index in this array is thus a window index modulo 32K.
      */
 
-    Posf *head; /* Heads of the hash chains or NIL. */
+    Pos *head; /* Heads of the hash chains or NIL. */
 
     uInt  ins_h;          /* hash index of string to be inserted */
     uInt  hash_size;      /* number of elements in hash table */
@@ -188,7 +187,7 @@
     /* Depth of each subtree used as tie breaker for trees of equal frequency
      */
 
-    uchf *l_buf;          /* buffer for literals or lengths */
+    uch *l_buf;          /* buffer for literals or lengths */
 
     uInt  lit_bufsize;
     /* Size of match buffer for literals/lengths.  There are 4 reasons for
@@ -212,7 +211,7 @@
 
     uInt last_lit;      /* running index in l_buf */
 
-    ushf *d_buf;
+    ush *d_buf;
     /* Buffer for distances. To simplify the code, d_buf and l_buf have
      * the same number of elements. To use different lengths, an extra flag
      * array would be necessary.
@@ -237,7 +236,7 @@
      * are always zero.
      */
 
-} FAR deflate_state;
+} deflate_state;
 
 typedef struct deflate_workspace {
     /* State memory for the deflator */
@@ -267,10 +266,10 @@
         /* in trees.c */
 void zlib_tr_init         OF((deflate_state *s));
 int  zlib_tr_tally        OF((deflate_state *s, unsigned dist, unsigned lc));
-ulg  zlib_tr_flush_block  OF((deflate_state *s, charf *buf, ulg stored_len,
+ulg  zlib_tr_flush_block  OF((deflate_state *s, char *buf, ulg stored_len,
 			      int eof));
 void zlib_tr_align        OF((deflate_state *s));
-void zlib_tr_stored_block OF((deflate_state *s, charf *buf, ulg stored_len,
+void zlib_tr_stored_block OF((deflate_state *s, char *buf, ulg stored_len,
 			      int eof));
 void zlib_tr_stored_type_only OF((deflate_state *));
 
--- linux-2.5.70-bk9/lib/zlib_inflate/infcodes.c~zlib_cleanup_FAR	2003-06-05 17:48:50.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/infcodes.c	2003-06-05 21:12:06.000000000 +0200
@@ -47,11 +47,11 @@
   uInt e;               /* extra bits or operation */
   uLong b;              /* bit buffer */
   uInt k;               /* bits in bit buffer */
-  Bytef *p;             /* input data pointer */
+  Byte *p;              /* input data pointer */
   uInt n;               /* bytes available there */
-  Bytef *q;             /* output window write pointer */
+  Byte *q;              /* output window write pointer */
   uInt m;               /* bytes to end of window or read pointer */
-  Bytef *f;             /* pointer to copy strings from */
+  Byte *f;              /* pointer to copy strings from */
   inflate_codes_statef *c = s->sub.decode.codes;  /* codes state */
 
   /* copy input/output information to locals (UPDATE macro restores) */
--- linux-2.5.70-bk9/lib/zlib_inflate/infcodes.h~zlib_cleanup_FAR	2003-04-07 19:30:59.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/infcodes.h	2003-06-05 21:34:12.000000000 +0200
@@ -14,7 +14,7 @@
 #include "infblock.h"
 
 struct inflate_codes_state;
-typedef struct inflate_codes_state FAR inflate_codes_statef;
+typedef struct inflate_codes_state inflate_codes_statef;
 
 extern inflate_codes_statef *zlib_inflate_codes_new OF((
     uInt, uInt,
--- linux-2.5.70-bk9/lib/zlib_inflate/inftrees.c~zlib_cleanup_FAR	2003-06-05 20:54:12.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/inftrees.c	2003-06-05 21:26:36.000000000 +0200
@@ -23,16 +23,16 @@
 
 
 local int huft_build OF((
-    uIntf *,            /* code lengths in bits */
+    uInt *,             /* code lengths in bits */
     uInt,               /* number of codes */
     uInt,               /* number of "simple" codes */
-    const uIntf *,      /* list of base values for non-simple codes */
-    const uIntf *,      /* list of extra bits for non-simple codes */
-    inflate_huft * FAR*,/* result: starting table */
-    uIntf *,            /* maximum lookup bits (returns actual) */
+    const uInt *,       /* list of base values for non-simple codes */
+    const uInt *,       /* list of extra bits for non-simple codes */
+    inflate_huft **,    /* result: starting table */
+    uInt *,             /* maximum lookup bits (returns actual) */
     inflate_huft *,     /* space for trees */
     uInt *,             /* hufts used in space */
-    uIntf * ));         /* space for values */
+    uInt * ));          /* space for values */
 
 /* Tables for deflate from PKZIP's appnote.txt. */
 local const uInt cplens[31] = { /* Copy lengths for literal codes 257..285 */
@@ -88,16 +88,16 @@
 #define BMAX 15         /* maximum bit length of any code */
 
 local int huft_build(
-	uIntf *b,               /* code lengths in bits (all assumed <= BMAX) */
-	uInt n,                 /* number of codes (assumed <= 288) */
-	uInt s,                 /* number of simple-valued codes (0..s-1) */
-	const uIntf *d,         /* list of base values for non-simple codes */
-	const uIntf *e,         /* list of extra bits for non-simple codes */
-	inflate_huft * FAR *t,  /* result: starting table */
-	uIntf *m,               /* maximum lookup bits, returns actual */
-	inflate_huft *hp,       /* space for trees */
-	uInt *hn,               /* hufts used in space */
-	uIntf *v                /* working area: values in order of bit length */
+	uInt *b,               /* code lengths in bits (all assumed <= BMAX) */
+	uInt n,                /* number of codes (assumed <= 288) */
+	uInt s,                /* number of simple-valued codes (0..s-1) */
+	const uInt *d,         /* list of base values for non-simple codes */
+	const uInt *e,         /* list of extra bits for non-simple codes */
+	inflate_huft **t,      /* result: starting table */
+	uInt *m,               /* maximum lookup bits, returns actual */
+	inflate_huft *hp,      /* space for trees */
+	uInt *hn,              /* hufts used in space */
+	uInt *v                /* working area: values in order of bit length */
 )
 /* Given a list of code lengths and a maximum table size, make a set of
    tables to decode that set of codes.  Return Z_OK on success, Z_BUF_ERROR
@@ -116,13 +116,13 @@
   register int k;               /* number of bits in current code */
   int l;                        /* bits per table (returned in m) */
   uInt mask;                    /* (1 << w) - 1, to avoid cc -O bug on HP */
-  register uIntf *p;            /* pointer into c[], b[], or v[] */
+  register uInt *p;             /* pointer into c[], b[], or v[] */
   inflate_huft *q;              /* points to current table */
   struct inflate_huft_s r;      /* table entry for structure assignment */
   inflate_huft *u[BMAX];        /* table stack */
   register int w;               /* bits before this table == (l * h) */
   uInt x[BMAX+1];               /* bit offsets, then code stack */
-  uIntf *xp;                    /* pointer into x */
+  uInt *xp;                     /* pointer into x */
   int y;                        /* number of dummy codes added */
   uInt z;                       /* number of entries in current table */
 
@@ -290,19 +290,19 @@
 
 
 int zlib_inflate_trees_bits(
-	uIntf *c,               /* 19 code lengths */
-	uIntf *bb,              /* bits tree desired/actual depth */
-	inflate_huft * FAR *tb, /* bits tree result */
+	uInt *c,                /* 19 code lengths */
+	uInt *bb,               /* bits tree desired/actual depth */
+	inflate_huft **tb,      /* bits tree result */
 	inflate_huft *hp,       /* space for trees */
 	z_streamp z             /* for messages */
 )
 {
   int r;
   uInt hn = 0;          /* hufts used in space */
-  uIntf *v;             /* work area for huft_build */
+  uInt *v;              /* work area for huft_build */
   
   v = WS(z)->tree_work_area_1;
-  r = huft_build(c, 19, 19, (uIntf*)Z_NULL, (uIntf*)Z_NULL,
+  r = huft_build(c, 19, 19, (uInt*)Z_NULL, (uInt*)Z_NULL,
                  tb, bb, hp, &hn, v);
   if (r == Z_DATA_ERROR)
     z->msg = (char*)"oversubscribed dynamic bit lengths tree";
@@ -317,18 +317,18 @@
 int zlib_inflate_trees_dynamic(
 	uInt nl,                /* number of literal/length codes */
 	uInt nd,                /* number of distance codes */
-	uIntf *c,               /* that many (total) code lengths */
-	uIntf *bl,              /* literal desired/actual bit depth */
-	uIntf *bd,              /* distance desired/actual bit depth */
-	inflate_huft * FAR *tl, /* literal/length tree result */
-	inflate_huft * FAR *td, /* distance tree result */
+	uInt *c,                /* that many (total) code lengths */
+	uInt *bl,               /* literal desired/actual bit depth */
+	uInt *bd,               /* distance desired/actual bit depth */
+	inflate_huft **tl,      /* literal/length tree result */
+	inflate_huft **td,      /* distance tree result */
 	inflate_huft *hp,       /* space for trees */
 	z_streamp z             /* for messages */
 )
 {
   int r;
   uInt hn = 0;          /* hufts used in space */
-  uIntf *v;             /* work area for huft_build */
+  uInt *v;              /* work area for huft_build */
 
   /* allocate work area */
   v = WS(z)->tree_work_area_2;
@@ -380,10 +380,10 @@
 
 
 int zlib_inflate_trees_fixed(
-	uIntf *bl,               /* literal desired/actual bit depth */
-	uIntf *bd,               /* distance desired/actual bit depth */
-	inflate_huft * FAR *tl,  /* literal/length tree result */
-	inflate_huft * FAR *td,  /* distance tree result */
+	uInt *bl,                /* literal desired/actual bit depth */
+	uInt *bd,                /* distance desired/actual bit depth */
+	inflate_huft **tl,       /* literal/length tree result */
+	inflate_huft **td,       /* distance tree result */
 	z_streamp z              /* for memory allocation */
 )
 {
--- linux-2.5.70-bk9/lib/zlib_inflate/inftrees.h~zlib_cleanup_FAR	2003-06-05 20:54:12.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/inftrees.h	2003-06-05 21:34:42.000000000 +0200
@@ -14,7 +14,7 @@
 #ifndef _INFTREES_H
 #define _INFTREES_H
 
-typedef struct inflate_huft_s FAR inflate_huft;
+typedef struct inflate_huft_s inflate_huft;
 
 struct inflate_huft_s {
   union {
@@ -36,28 +36,28 @@
 #define MANY 1440
 
 extern int zlib_inflate_trees_bits OF((
-    uIntf *,                    /* 19 code lengths */
-    uIntf *,                    /* bits tree desired/actual depth */
-    inflate_huft * FAR *,       /* bits tree result */
+    uInt *,                     /* 19 code lengths */
+    uInt *,                     /* bits tree desired/actual depth */
+    inflate_huft **,            /* bits tree result */
     inflate_huft *,             /* space for trees */
     z_streamp));                /* for messages */
 
 extern int zlib_inflate_trees_dynamic OF((
     uInt,                       /* number of literal/length codes */
     uInt,                       /* number of distance codes */
-    uIntf *,                    /* that many (total) code lengths */
-    uIntf *,                    /* literal desired/actual bit depth */
-    uIntf *,                    /* distance desired/actual bit depth */
-    inflate_huft * FAR *,       /* literal/length tree result */
-    inflate_huft * FAR *,       /* distance tree result */
+    uInt *,                     /* that many (total) code lengths */
+    uInt *,                     /* literal desired/actual bit depth */
+    uInt *,                     /* distance desired/actual bit depth */
+    inflate_huft **,            /* literal/length tree result */
+    inflate_huft **,            /* distance tree result */
     inflate_huft *,             /* space for trees */
     z_streamp));                /* for messages */
 
 extern int zlib_inflate_trees_fixed OF((
-    uIntf *,                    /* literal desired/actual bit depth */
-    uIntf *,                    /* distance desired/actual bit depth */
-    inflate_huft * FAR *,       /* literal/length tree result */
-    inflate_huft * FAR *,       /* distance tree result */
+    uInt *,                     /* literal desired/actual bit depth */
+    uInt *,                     /* distance desired/actual bit depth */
+    inflate_huft **,            /* literal/length tree result */
+    inflate_huft **,            /* distance tree result */
     z_streamp));                /* for memory allocation */
 
 #endif /* _INFTREES_H */
--- linux-2.5.70-bk9/lib/zlib_inflate/infblock.c~zlib_cleanup_FAR	2003-06-05 17:48:50.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/infblock.c	2003-06-05 21:28:38.000000000 +0200
@@ -68,7 +68,7 @@
 void zlib_inflate_blocks_reset(
 	inflate_blocks_statef *s,
 	z_streamp z,
-	uLongf *c
+	uLong *c
 )
 {
   if (c != Z_NULL)
@@ -80,7 +80,7 @@
   s->bitb = 0;
   s->read = s->write = s->window;
   if (s->checkfn != Z_NULL)
-    z->adler = s->check = (*s->checkfn)(0L, (const Bytef *)Z_NULL, 0);
+    z->adler = s->check = (*s->checkfn)(0L, (const Byte *)Z_NULL, 0);
 }
 
 inflate_blocks_statef *zlib_inflate_blocks_new(
@@ -111,9 +111,9 @@
   uInt t;               /* temporary storage */
   uLong b;              /* bit buffer */
   uInt k;               /* bits in bit buffer */
-  Bytef *p;             /* input data pointer */
+  Byte *p;              /* input data pointer */
   uInt n;               /* bytes available there */
-  Bytef *q;             /* output window write pointer */
+  Byte *q;              /* output window write pointer */
   uInt m;               /* bytes to end of window or read pointer */
 
   /* copy input/output information to locals (UPDATE macro restores) */
@@ -340,7 +340,7 @@
 
 void zlib_inflate_set_dictionary(
 	inflate_blocks_statef *s,
-	const Bytef *d,
+	const Byte *d,
 	uInt  n
 )
 {
--- linux-2.5.70-bk9/lib/zlib_inflate/inffast.c~zlib_cleanup_FAR	2003-06-05 17:48:50.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/inffast.c	2003-06-05 21:15:43.000000000 +0200
@@ -38,15 +38,15 @@
   uInt e;               /* extra bits or operation */
   uLong b;              /* bit buffer */
   uInt k;               /* bits in bit buffer */
-  Bytef *p;             /* input data pointer */
+  Byte *p;              /* input data pointer */
   uInt n;               /* bytes available there */
-  Bytef *q;             /* output window write pointer */
+  Byte *q;              /* output window write pointer */
   uInt m;               /* bytes to end of window or read pointer */
   uInt ml;              /* mask for literal/length tree */
   uInt md;              /* mask for distance tree */
   uInt c;               /* bytes to copy */
   uInt d;               /* distance back to copy from */
-  Bytef *r;             /* copy source pointer */
+  Byte *r;              /* copy source pointer */
 
   /* load input, output, bit values */
   LOAD
--- linux-2.5.70-bk9/lib/zlib_inflate/infutil.h~zlib_cleanup_FAR	2003-04-07 19:32:17.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/infutil.h	2003-06-05 21:27:33.000000000 +0200
@@ -40,7 +40,7 @@
     struct {
       uInt table;               /* table lengths (14 bits) */
       uInt index;               /* index into blens (or border) */
-      uIntf *blens;             /* bit lengths of codes */
+      uInt *blens;              /* bit lengths of codes */
       uInt bb;                  /* bit length tree depth */
       inflate_huft *tb;         /* bit length decoding tree */
     } trees;            /* if DTREE, decoding info for trees */
@@ -55,10 +55,10 @@
   uInt bitk;            /* bits in bit buffer */
   uLong bitb;           /* bit buffer */
   inflate_huft *hufts;  /* single malloc for tree space */
-  Bytef *window;        /* sliding window */
-  Bytef *end;           /* one byte after sliding window */
-  Bytef *read;          /* window read pointer */
-  Bytef *write;         /* window write pointer */
+  Byte *window;         /* sliding window */
+  Byte *end;            /* one byte after sliding window */
+  Byte *read;           /* window read pointer */
+  Byte *write;          /* window write pointer */
   check_func checkfn;   /* check function */
   uLong check;          /* check on output */
 
--- linux-2.5.70-bk9/lib/zlib_inflate/infutil.c~zlib_cleanup_FAR	2003-06-05 17:48:50.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/infutil.c	2003-06-05 21:17:26.000000000 +0200
@@ -27,8 +27,8 @@
 )
 {
   uInt n;
-  Bytef *p;
-  Bytef *q;
+  Byte *p;
+  Byte *q;
 
   /* local copies of source and destination pointers */
   p = z->next_out;
--- linux-2.5.70-bk9/lib/zlib_inflate/infblock.h~zlib_cleanup_FAR	2003-04-07 19:31:47.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/infblock.h	2003-06-05 21:34:33.000000000 +0200
@@ -12,7 +12,7 @@
 #define _INFBLOCK_H
 
 struct inflate_blocks_state;
-typedef struct inflate_blocks_state FAR inflate_blocks_statef;
+typedef struct inflate_blocks_state inflate_blocks_statef;
 
 extern inflate_blocks_statef * zlib_inflate_blocks_new OF((
     z_streamp z,
@@ -27,7 +27,7 @@
 extern void zlib_inflate_blocks_reset OF((
     inflate_blocks_statef *,
     z_streamp ,
-    uLongf *));                  /* check value on output */
+    uLong *));                  /* check value on output */
 
 extern int zlib_inflate_blocks_free OF((
     inflate_blocks_statef *,
@@ -35,7 +35,7 @@
 
 extern void zlib_inflate_set_dictionary OF((
     inflate_blocks_statef *s,
-    const Bytef *d,  /* dictionary */
+    const Byte *d,   /* dictionary */
     uInt  n));       /* dictionary length */
 
 extern int zlib_inflate_blocks_sync_point OF((
