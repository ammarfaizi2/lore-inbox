Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269630AbUJSRbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269630AbUJSRbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269518AbUJSR2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:28:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62892 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269903AbUJSRQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:16:29 -0400
Date: Tue, 19 Oct 2004 19:17:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019171743.GA15832@elte.hu>
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019144642.GA6512@elte.hu> <28172.195.245.190.93.1098199429.squirrel@195.245.190.93> <20041019155008.GA9116@elte.hu> <20041019162047.GA12055@elte.hu> <20041019162811.GA13454@elte.hu> <20041019163125.GA13498@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019163125.GA13498@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> enabling 8K stacks ought to help this one. I've made the limit a bit
> too conservative - there's still 1000 bytes left and the assert hits.
> Here's the full trace, the large footprint seems to be in zlib
> initialization:
> 
> mcount: stack overflow: 1008

i've added a stackframe-size field to the end of every stack trace
entry:

mcount: stack overflow: 1008
 [<c012cdaf>] ___trace+0x105/0x117 (12)
 [<c012cde7>] __mcount+0x1d/0x1f (32)
 [<c013e025>] cache_grow+0xe/0x1ab (4)
 [<c013e3dd>] cache_alloc_refill+0x21b/0x253 (4)
 [<c010effc>] mcount+0x14/0x18 (8)
 [<c013e025>] cache_grow+0xe/0x1ab (20)
 [<c013e3dd>] cache_alloc_refill+0x21b/0x253 (52)
 [<c013e740>] __kmalloc+0x82/0x9f (48)
 [<c03607c8>] malloc+0x1e/0x20 (28)
 [<c01008c9>] huft_build+0x309/0x5e8 (16)
 [<c0101bec>] inflate+0x4c/0xb0 (1444)
 [<c010effc>] mcount+0x14/0x18 (8)
 [<c0101279>] inflate_fixed+0xcb/0x1a4 (20)
 [<c0101bec>] inflate+0x4c/0xb0 (1212)
 [<c010effc>] mcount+0x14/0x18 (12)
 [<c0101eae>] gunzip+0x1d4/0x396 (20)
 [<c036130e>] unpack_to_rootfs+0x162/0x225 (28)
 [<c010effc>] mcount+0x14/0x18 (8)
 [<c0100434>] init+0x0/0x124 (4)
 [<c03613fe>] populate_rootfs+0x2d/0x3f (16)
 [<c010046b>] init+0x37/0x124 (20)
 [<c0102365>] kernel_thread_helper+0x5/0xb (20)

as suspected, zlib's huft_build() is fun:

  lib/inflate.c:

  #define N_MAX 288       /* maximum number of codes in any set */

  STATIC int huft_build(
  ...
  {

    unsigned v[N_MAX];            /* values in order of bit length */

a whopping 1152 bytes for this local variable alone! The patch below
fixes this, but there are other overflows as well, later in the bootup.

	Ingo

--- linux/lib/inflate.c.orig
+++ linux/lib/inflate.c
@@ -300,7 +300,7 @@ STATIC int huft_build(
   register struct huft *q;      /* points to current table */
   struct huft r;                /* table entry for structure assignment */
   struct huft *u[BMAX];         /* table stack */
-  unsigned v[N_MAX];            /* values in order of bit length */
+  unsigned *v;                  /* values in order of bit length */
   register int w;               /* bits before this table == (l * h) */
   unsigned x[BMAX+1];           /* bit offsets, then code stack */
   unsigned *xp;                 /* pointer into x */
@@ -309,6 +309,10 @@ STATIC int huft_build(
 
 DEBG("huft1 ");
 
+  /* allocate new table */
+  v = (unsigned *)malloc(sizeof(unsigned)*N_MAX);
+  if (!v)
+    return 3;             /* not enough memory */
   /* Generate counts for each bit length */
   memzero(c, sizeof(c));
   p = b;  i = n;
@@ -322,6 +326,7 @@ DEBG("huft1 ");
   {
     *t = (struct huft *)NULL;
     *m = 0;
+    free(v);
     return 0;
   }
 
@@ -347,10 +352,14 @@ DEBG("huft3 ");
 
   /* Adjust last length count to fill out codes, if needed */
   for (y = 1 << j; j < i; j++, y <<= 1)
-    if ((y -= c[j]) < 0)
+    if ((y -= c[j]) < 0) {
+      free(v);
       return 2;                 /* bad input: more codes than bits */
-  if ((y -= c[i]) < 0)
+    }
+  if ((y -= c[i]) < 0) {
+    free(v);
     return 2;
+  }
   c[i] += y;
 
 DEBG("huft4 ");
@@ -422,6 +431,7 @@ DEBG1("3 ");
         {
           if (h)
             huft_free(u[0]);
+          free(v);
           return 3;             /* not enough memory */
         }
 DEBG1("4 ");
@@ -485,6 +495,7 @@ DEBG("h6f ");
 
 DEBG("huft7 ");
 
+  free(v);
   /* Return true (1) if we were given an incomplete table */
   return y != 0 && g != 1;
 }
