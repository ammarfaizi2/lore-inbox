Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVJGLmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVJGLmq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVJGLmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:42:46 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:64686 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932258AbVJGLmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:42:45 -0400
Date: Fri, 7 Oct 2005 13:43:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Rigg <lk@sound-man.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt10 crashes on boot
Message-ID: <20051007114321.GD857@elte.hu>
References: <E1ENgFH-00017G-HI@localhost.localdomain> <Pine.LNX.4.58.0510070234490.3816@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510070234490.3816@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 7 Oct 2005, John Rigg wrote:
> 
> > Below are excerpts from .config and from boot messages via serial
> > console.
> 
> Hmm, I wonder if you're getting a stack overflow?
> 
> Have you tried this with turning on CONFIG_DEBUG_STACKOVERFLOW?

i got overflows in initramfs's gunzip with certain debug options. I have 
improved the stack footprint of the worst offenders in -rt11 (see the 
standalone patch below) - John, does it boot any better?

	Ingo

-------

this patch reduces the ~2500+ worst-case stack footprint of zlib to 
~500 bytes, by making the largest arrays static and by introducing a
spinlock to protect access to them.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/arm/boot/compressed/misc.c    |    1 
 arch/arm26/boot/compressed/misc.c  |    1 
 arch/i386/boot/compressed/misc.c   |    1 
 arch/x86_64/boot/compressed/misc.c |    1 
 lib/inflate.c                      |   44 +++++++++++++++++++++++++++---------
 lib/zlib_inflate/inftrees.c        |   45 ++++++++++++++++++++++++++++---------
 6 files changed, 72 insertions(+), 21 deletions(-)

Index: linux/arch/arm/boot/compressed/misc.c
===================================================================
--- linux.orig/arch/arm/boot/compressed/misc.c
+++ linux/arch/arm/boot/compressed/misc.c
@@ -199,6 +199,7 @@ static ulg free_mem_ptr_end;
 
 #define HEAP_SIZE 0x2000
 
+#define ZLIB_INFLATE_NO_INFLATE_LOCK
 #include "../../../../lib/inflate.c"
 
 #ifndef STANDALONE_DEBUG
Index: linux/arch/arm26/boot/compressed/misc.c
===================================================================
--- linux.orig/arch/arm26/boot/compressed/misc.c
+++ linux/arch/arm26/boot/compressed/misc.c
@@ -184,6 +184,7 @@ static ulg free_mem_ptr_end;
 
 #define HEAP_SIZE 0x2000
 
+#define ZLIB_INFLATE_NO_INFLATE_LOCK
 #include "../../../../lib/inflate.c"
 
 #ifndef STANDALONE_DEBUG
Index: linux/arch/i386/boot/compressed/misc.c
===================================================================
--- linux.orig/arch/i386/boot/compressed/misc.c
+++ linux/arch/i386/boot/compressed/misc.c
@@ -125,6 +125,7 @@ static int lines, cols;
 static void * xquad_portio = NULL;
 #endif
 
+#define ZLIB_INFLATE_NO_INFLATE_LOCK
 #include "../../../../lib/inflate.c"
 
 static void *malloc(int size)
Index: linux/arch/x86_64/boot/compressed/misc.c
===================================================================
--- linux.orig/arch/x86_64/boot/compressed/misc.c
+++ linux/arch/x86_64/boot/compressed/misc.c
@@ -114,6 +114,7 @@ static char *vidmem = (char *)0xb8000;
 static int vidport;
 static int lines, cols;
 
+#define ZLIB_INFLATE_NO_INFLATE_LOCK
 #include "../../../../lib/inflate.c"
 
 static void *malloc(int size)
Index: linux/lib/inflate.c
===================================================================
--- linux.orig/lib/inflate.c
+++ linux/lib/inflate.c
@@ -141,6 +141,25 @@ struct huft {
   } v;
 };
 
+/*
+ * turn off the inflate_lock for the bootloader code, it is
+ * single-threaded and has no need for (nor access to) the
+ * kernel's locking primitives:
+ */
+#ifdef ZLIB_INFLATE_NO_INFLATE_LOCK
+# undef DEFINE_SPINLOCK
+# undef spin_lock
+# undef spin_unlock
+# define DEFINE_SPINLOCK(x)	int x
+# define spin_lock(x)		(void)(x)
+# define spin_unlock(x)		(void)(x)
+#endif
+
+/*
+ * lock protecting static variables of huft_build() and other inflate
+ * functions, to reduce their insane stack footprint.
+ */
+static DEFINE_SPINLOCK(inflate_lock);
 
 /* Function prototypes */
 STATIC int INIT huft_build OF((unsigned *, unsigned, unsigned, 
@@ -304,7 +323,7 @@ STATIC int INIT huft_build(
   register struct huft *q;      /* points to current table */
   struct huft r;                /* table entry for structure assignment */
   struct huft *u[BMAX];         /* table stack */
-  unsigned v[N_MAX];            /* values in order of bit length */
+  static unsigned v[N_MAX];     /* values in order of bit length */
   register int w;               /* bits before this table == (l * h) */
   unsigned x[BMAX+1];           /* bit offsets, then code stack */
   unsigned *xp;                 /* pointer into x */
@@ -705,7 +724,7 @@ STATIC int noinline INIT inflate_fixed(v
   struct huft *td;      /* distance code table */
   int bl;               /* lookup bits for tl */
   int bd;               /* lookup bits for td */
-  unsigned l[288];      /* length list for huft_build */
+  static unsigned l[288];      /* length list for huft_build */
 
 DEBG("<fix");
 
@@ -767,9 +786,9 @@ STATIC int noinline INIT inflate_dynamic
   unsigned nl;          /* number of literal/length codes */
   unsigned nd;          /* number of distance codes */
 #ifdef PKZIP_BUG_WORKAROUND
-  unsigned ll[288+32];  /* literal/length and distance code lengths */
+  static unsigned ll[288+32];  /* literal/length and distance code lengths */
 #else
-  unsigned ll[286+30];  /* literal/length and distance code lengths */
+  static unsigned ll[286+30];  /* literal/length and distance code lengths */
 #endif
   register ulg b;       /* bit buffer */
   register unsigned k;  /* number of bits in bit buffer */
@@ -940,6 +959,7 @@ STATIC int INIT inflate_block(
   unsigned t;           /* block type */
   register ulg b;       /* bit buffer */
   register unsigned k;  /* number of bits in bit buffer */
+  unsigned ret;         /* return code */
 
   DEBG("<blk");
 
@@ -965,17 +985,19 @@ STATIC int INIT inflate_block(
   bk = k;
 
   /* inflate that block type */
-  if (t == 2)
-    return inflate_dynamic();
-  if (t == 0)
-    return inflate_stored();
-  if (t == 1)
-    return inflate_fixed();
+  ret = 2;
+  spin_lock(&inflate_lock);
+  switch (t) {
+	case 2: ret = inflate_dynamic(); break;
+	case 0: ret = inflate_stored();  break;
+	case 1: ret = inflate_fixed();   break;
+  }
+  spin_unlock(&inflate_lock);
 
   DEBG(">");
 
   /* bad block type */
-  return 2;
+  return ret;
 
  underrun:
   return 4;			/* Input underrun */
Index: linux/lib/zlib_inflate/inftrees.c
===================================================================
--- linux.orig/lib/zlib_inflate/inftrees.c
+++ linux/lib/zlib_inflate/inftrees.c
@@ -4,11 +4,19 @@
  */
 
 #include <linux/zutil.h>
+#include <linux/spinlock.h>
 #include "inftrees.h"
 #include "infutil.h"
 
 static const char inflate_copyright[] __attribute_used__ =
    " inflate 1.1.3 Copyright 1995-1998 Mark Adler ";
+
+/*
+ * lock protecting static variables of huft_build() and other inflate
+ * functions, to reduce their insane stack footprint.
+ */
+static DEFINE_SPINLOCK(inflate_lock);
+
 /*
   If you use the zlib library in a product, an acknowledgment is welcome
   in the documentation of your product. If for some reason you cannot
@@ -107,7 +115,7 @@ static int huft_build(
 {
 
   uInt a;                       /* counter for codes of length k */
-  uInt c[BMAX+1];               /* bit length count table */
+  static uInt c[BMAX+1];        /* bit length count table */
   uInt f;                       /* i repeats in table every f entries */
   int g;                        /* maximum code length */
   int h;                        /* table level */
@@ -118,10 +126,10 @@ static int huft_build(
   uInt mask;                    /* (1 << w) - 1, to avoid cc -O bug on HP */
   register uInt *p;             /* pointer into c[], b[], or v[] */
   inflate_huft *q;              /* points to current table */
-  struct inflate_huft_s r;      /* table entry for structure assignment */
-  inflate_huft *u[BMAX];        /* table stack */
+  static struct inflate_huft_s r; /* table entry for structure assignment */
+  static inflate_huft *u[BMAX]; /* table stack */
   register int w;               /* bits before this table == (l * h) */
-  uInt x[BMAX+1];               /* bit offsets, then code stack */
+  static uInt x[BMAX+1];        /* bit offsets, then code stack */
   uInt *xp;                     /* pointer into x */
   int y;                        /* number of dummy codes added */
   uInt z;                       /* number of entries in current table */
@@ -300,9 +308,13 @@ int zlib_inflate_trees_bits(
   int r;
   uInt hn = 0;          /* hufts used in space */
   uInt *v;              /* work area for huft_build */
-  
+
   v = WS(z)->tree_work_area_1;
+
+  spin_lock(&inflate_lock);
   r = huft_build(c, 19, 19, NULL, NULL, tb, bb, hp, &hn, v);
+  spin_unlock(&inflate_lock);
+
   if (r == Z_DATA_ERROR)
     z->msg = (char*)"oversubscribed dynamic bit lengths tree";
   else if (r == Z_BUF_ERROR || *bb == 0)
@@ -333,7 +345,10 @@ int zlib_inflate_trees_dynamic(
   v = WS(z)->tree_work_area_2;
 
   /* build literal/length tree */
+  spin_lock(&inflate_lock);
   r = huft_build(c, nl, 257, cplens, cplext, tl, bl, hp, &hn, v);
+  spin_unlock(&inflate_lock);
+
   if (r != Z_OK || *bl == 0)
   {
     if (r == Z_DATA_ERROR)
@@ -347,7 +362,10 @@ int zlib_inflate_trees_dynamic(
   }
 
   /* build distance tree */
+  spin_lock(&inflate_lock);
   r = huft_build(c + nl, nd, 0, cpdist, cpdext, td, bd, hp, &hn, v);
+  spin_unlock(&inflate_lock);
+
   if (r != Z_OK || (*bd == 0 && nl > 257))
   {
     if (r == Z_DATA_ERROR)
@@ -383,9 +401,11 @@ int zlib_inflate_trees_fixed(
 	z_streamp z              /* for memory allocation */
 )
 {
-  int i;                /* temporary variable */
-  unsigned l[288];      /* length list for huft_build */
-  uInt *v;              /* work area for huft_build */
+  int i;                       /* temporary variable */
+  static unsigned l[288];      /* length list for huft_build */
+  uInt *v;                     /* work area for huft_build */
+
+  spin_lock(&inflate_lock);
 
   /* set up literal table */
   for (i = 0; i < 144; i++)
@@ -398,15 +418,20 @@ int zlib_inflate_trees_fixed(
     l[i] = 8;
   *bl = 9;
   v = WS(z)->tree_work_area_1;
-  if ((i = huft_build(l, 288, 257, cplens, cplext, tl, bl, hp,  &i, v)) != 0)
+  if ((i = huft_build(l, 288, 257, cplens, cplext, tl, bl, hp,  &i, v)) != 0) {
+    spin_unlock(&inflate_lock);
     return i;
+  }
 
   /* set up distance table */
   for (i = 0; i < 30; i++)      /* make an incomplete code set */
     l[i] = 5;
   *bd = 5;
-  if ((i = huft_build(l, 30, 0, cpdist, cpdext, td, bd, hp, &i, v)) > 1)
+  if ((i = huft_build(l, 30, 0, cpdist, cpdext, td, bd, hp, &i, v)) > 1) {
+    spin_unlock(&inflate_lock);
     return i;
+  }
 
+  spin_unlock(&inflate_lock);
   return Z_OK;
 }
