Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265140AbUAHPRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265143AbUAHPRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:17:18 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:14599 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S265140AbUAHPPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:15:31 -0500
Date: Thu, 8 Jan 2004 18:15:02 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: Relocation overflow with modules on Alpha
Message-ID: <20040108181502.B9562@jurassic.park.msu.ru>
References: <yw1xy8sn2nry.fsf@ford.guide> <20040106004435.A3228@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040106004435.A3228@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Tue, Jan 06, 2004 at 12:44:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 12:44:35AM +0000, Thorsten Kranzkowski wrote:
> : relocation truncated to fit: BRADDR .init.text
> init/built-in.o(.text+0xf10): In function `inflate_codes':

Looks like it's a GCC-3.3 bug.
lib/inflate.c is directly included in init/initramfs.c and
init/do_mounts_rd.c, so the compiler assumes that all subroutines in these
files as "local" and uses branches (bsr instead of jsr) for function calls.
Even though some of those functions are in different sections
(.text vs .init.text)...
GCC-3.4 seems to be OK.

> It seems my kernel crossed the 4 MB barrier in consumed RAM and possibly
> some relocation type(s) can't cope with that. Time to use -fpic or 
> some such?

I'm thinking about some __init tricks in lib/inflate.c.
What about this patch? It has a nice side effect - the "inflate"
code gets freed after init is done.

Ivan.

--- rc3/lib/inflate.c	Thu Jan  8 16:52:19 2004
+++ linux/lib/inflate.c	Thu Jan  8 17:55:14 2004
@@ -120,6 +120,10 @@ static char rcsid[] = "#Id: inflate.c,v 
 	
 #define slide window
 
+#ifndef __init
+#define __init		/* included from bootloader */
+#endif
+
 /* Huffman code lookup table entry--this entry is four bytes for machines
    that have 16-bit pointers (e.g. PC's in the small or medium model).
    Valid extra bits are 0..13.  e == 15 is EOB (end of block), e == 16
@@ -271,7 +275,7 @@ STATIC const int dbits = 6;          /* 
 STATIC unsigned hufts;         /* track memory usage */
 
 
-STATIC int huft_build(
+STATIC int __init huft_build(
 	unsigned *b,            /* code lengths in bits (all assumed <= BMAX) */
 	unsigned n,             /* number of codes (assumed <= N_MAX) */
 	unsigned s,             /* number of simple-valued codes (0..s-1) */
@@ -490,7 +494,7 @@ DEBG("huft7 ");
 
 
 
-STATIC int huft_free(
+STATIC int __init huft_free(
 	struct huft *t         /* table to free */
 	)
 /* Free the malloc'ed tables built by huft_build(), which makes a linked
@@ -512,7 +516,7 @@ STATIC int huft_free(
 }
 
 
-STATIC int inflate_codes(
+STATIC int __init inflate_codes(
 	struct huft *tl,    /* literal/length decoder tables */
 	struct huft *td,    /* distance decoder tables */
 	int bl,             /* number of bits decoded by tl[] */
@@ -627,7 +631,7 @@ STATIC int inflate_codes(
 
 
 
-STATIC int inflate_stored(void)
+STATIC int __init inflate_stored(void)
 /* "decompress" an inflated type 0 (stored) block. */
 {
   unsigned n;           /* number of bytes in block */
@@ -686,7 +690,7 @@ DEBG("<stor");
 
 
 
-STATIC int inflate_fixed(void)
+STATIC int __init inflate_fixed(void)
 /* decompress an inflated type 1 (fixed Huffman codes) block.  We should
    either replace this with a custom decoder, or at least precompute the
    Huffman tables. */
@@ -740,7 +744,7 @@ DEBG("<fix");
 
 
 
-STATIC int inflate_dynamic(void)
+STATIC int __init inflate_dynamic(void)
 /* decompress an inflated type 2 (dynamic Huffman codes) block. */
 {
   int i;                /* temporary variables */
@@ -921,7 +925,7 @@ DEBG("dyn7 ");
 
 
 
-STATIC int inflate_block(
+STATIC int __init inflate_block(
 	int *e                  /* last block flag */
 	)
 /* decompress an inflated block */
@@ -972,7 +976,7 @@ STATIC int inflate_block(
 
 
 
-STATIC int inflate(void)
+STATIC int __init inflate(void)
 /* decompress an inflated entry */
 {
   int e;                /* last block flag */
@@ -1034,7 +1038,7 @@ static ulg crc;		/* initialized in makec
  * gzip-1.0.3/makecrc.c.
  */
 
-static void
+static void __init 
 makecrc(void)
 {
 /* Not copyrighted 1990 Mark Adler	*/
@@ -1082,7 +1086,7 @@ makecrc(void)
 /*
  * Do the uncompression!
  */
-static int gunzip(void)
+static int __init gunzip(void)
 {
     uch flags;
     unsigned char magic[2]; /* magic header */
