Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUCSVkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 16:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUCSVkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 16:40:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18694 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262132AbUCSVkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 16:40:00 -0500
Date: Fri, 19 Mar 2004 21:39:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] inflate.c rework arch testing needed
Message-ID: <20040319213957.K14431@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040318231006.GK11010@waste.org> <20040319103126.A12519@flint.arm.linux.org.uk> <20040319171615.GN11010@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040319171615.GN11010@waste.org>; from mpm@selenic.com on Fri, Mar 19, 2004 at 11:16:15AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 11:16:15AM -0600, Matt Mackall wrote:
> On Fri, Mar 19, 2004 at 10:31:26AM +0000, Russell King wrote:
> > On Thu, Mar 18, 2004 at 05:10:06PM -0600, Matt Mackall wrote:
> > > I've reworked the mess that is lib/inflate.c, including:
> > 
> > Please don't - this will probably break the PIC decompressor on ARM.
> 
> If it works now, I don't see why it should. My last version of this
> was test-booted on ARM.

One test boot isn't sufficient - it's a combination of toolchain and
the way you boot which will bring up the issue.  Maybe you're using an
older toolchain from me, or not actually using the relocatable feature.

Basically, we rely on the toolchain generating GOT relocations for
data references, and we use the GOT table to point them to an area
of RAM.  However, later toolchains seem to "optimise" this and use
GOTOFF relocations for static data.  The GOT table is at a fixed
offset from the text segment, and this effectively makes the whole
thing unrelocatable.

(Having GOTOFF relocs for static read only data is fine though.
It's the read/write data which must use GOT relocs.)

> > There are un-merged patches in the pipeline which make this all work
> > correctly with todays toolchains - which mostly means getting rid of
> > all static data to make the compiler produce the right relocations.
> 
> Well perhaps you could send them to me.

I think this is everything...

diff -urpN orig/arch/arm/boot/compressed/misc.c linux/arch/arm/boot/compressed/misc.c
--- orig/arch/arm/boot/compressed/misc.c	Sun Sep 28 09:53:47 2003
+++ linux/arch/arm/boot/compressed/misc.c	Sun Sep 28 09:46:13 2003
@@ -113,7 +113,7 @@ static inline __ptr_t memcpy(__ptr_t __d
  * gzip delarations
  */
 #define OF(args)  args
-#define STATIC static
+#define STATIC
 
 typedef unsigned char  uch;
 typedef unsigned short ush;
@@ -122,12 +122,12 @@ typedef unsigned long  ulg;
 #define WSIZE 0x8000		/* Window size must be at least 32k, */
 				/* and a power of two */
 
-static uch *inbuf;		/* input buffer */
-static uch window[WSIZE];	/* Sliding window buffer */
+unsigned char *inbuf;		/* input buffer */
+unsigned char window[WSIZE];	/* Sliding window buffer */
 
-static unsigned insize;		/* valid bytes in inbuf */
-static unsigned inptr;		/* index of next byte to be processed in inbuf */
-static unsigned outcnt;		/* bytes in output buffer */
+unsigned int insize;		/* valid bytes in inbuf */
+unsigned int inptr;		/* index of next byte to be processed in inbuf */
+unsigned int outcnt;		/* bytes in output buffer */
 
 /* gzip flag byte */
 #define ASCII_FLAG   0x01 /* bit 0 set: file probably ascii text */
@@ -166,9 +166,9 @@ static void gzip_release(void **);
 extern char input_data[];
 extern char input_data_end[];
 
-static uch *output_data;
-static ulg output_ptr;
-static ulg bytes_out;
+unsigned char *output_data;
+unsigned long output_ptr;
+unsigned long bytes_out;
 
 static void *malloc(int size);
 static void free(void *where);
@@ -179,8 +179,8 @@ static void gzip_release(void **);
 static void puts(const char *);
 
 extern int end;
-static ulg free_mem_ptr;
-static ulg free_mem_ptr_end;
+unsigned long free_mem_ptr;
+unsigned long free_mem_ptr_end;
 
 #define HEAP_SIZE 0x2000
 
--- orig/lib/inflate.c	Fri Jan  9 22:40:07 2004
+++ linux/lib/inflate.c	Fri Jan  9 22:52:48 2004
@@ -1025,8 +1025,8 @@ STATIC int inflate(void)
  *
  **********************************************************************/
 
-static ulg crc_32_tab[256];
-static ulg crc;		/* initialized in makecrc() so it'll reside in bss */
+STATIC ulg crc_32_tab[256];
+STATIC ulg crc;		/* initialized in makecrc() so it'll reside in bss */
 #define CRC_VALUE (crc ^ 0xffffffffUL)
 
 /*



-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
