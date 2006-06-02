Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWFBNou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWFBNou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWFBNou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:44:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41181 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932098AbWFBNot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:44:49 -0400
Date: Fri, 2 Jun 2006 15:44:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paolo Ornati <ornati@fastwebnet.it>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: [patch] mm/slab.c: fix offslab_limit bug
Message-ID: <20060602134458.GA4914@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: slab.c: fix offslab_limit bug
From: Ingo Molnar <mingo@elte.hu>

mm/slab.c's offlab_limit logic is totally broken.

Firstly, "offslab_limit" is a global variable while it should either be 
calculated in situ or should be passed in as a parameter.

Secondly, the more serious problem with it is that the condition for 
calculating it:

               if (!(OFF_SLAB(sizes->cs_cachep))) {
                       offslab_limit = sizes->cs_size - sizeof(struct slab);
                       offslab_limit /= sizeof(kmem_bufctl_t);

is in total disconnect with the condition that makes use of it:

               /* More than offslab_limit objects will cause problems */
               if ((flags & CFLGS_OFF_SLAB) && num > offslab_limit)
                       break;

but due to offslab_limit being a global variable this breakage was 
hidden.

Up until lockdep came along and perturbed the slab sizes sufficiently so 
that the first off-slab cache would still see a (non-calculated) zero 
value for offslab_limit and would panic with:

  kmem_cache_create: couldn't create cache size-512.

  Call Trace:
   [<ffffffff8020a5b9>] show_trace+0x96/0x1c8
   [<ffffffff8020a8f0>] dump_stack+0x13/0x15
   [<ffffffff8022994f>] panic+0x39/0x21a
   [<ffffffff80270814>] kmem_cache_create+0x5a0/0x5d0
   [<ffffffff80aced62>] kmem_cache_init+0x193/0x379
   [<ffffffff80abf779>] start_kernel+0x17f/0x218
   [<ffffffff80abf263>] _sinittext+0x263/0x26a
 
  Kernel panic - not syncing: kmem_cache_create(): failed to create slab `size-512'

Paolo Ornati's config on x86_64 managed to trigger it.

The fix is to move the calculation to the place that makes use of it. 
This also makes slab.o 54 bytes smaller.

Btw., the check itself is quite silly. Its intention is to test whether 
the number of objects per slab would be higher than the number of slab 
control pointers possible. In theory it could be triggered: if someone 
tried to allocate 4-byte objects cache and explicitly requested with 
CFLGS_OFF_SLAB. So i kept the check.

Out of historic interest i checked how old this bug was and it's 
ancient, 10 years old! It is the oldest hidden and then truly triggering 
bugs i ever saw being fixed in the kernel!

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 mm/slab.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -209,11 +209,6 @@ typedef unsigned long kmem_bufctl_t;
 #define	BUFCTL_ACTIVE	(((kmem_bufctl_t)(~0U))-2)
 #define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-3)
 
-/* Max number of objs-per-slab for caches which use off-slab slabs.
- * Needed to avoid a possible looping condition in cache_grow().
- */
-static unsigned long offslab_limit;
-
 /*
  * struct slab
  *
@@ -1398,12 +1393,6 @@ void __init kmem_cache_init(void)
 					NULL, NULL);
 		}
 
-		/* Inc off-slab bufctl limit until the ceiling is hit. */
-		if (!(OFF_SLAB(sizes->cs_cachep))) {
-			offslab_limit = sizes->cs_size - sizeof(struct slab);
-			offslab_limit /= sizeof(kmem_bufctl_t);
-		}
-
 		sizes->cs_dmacachep = kmem_cache_create(names->name_dma,
 					sizes->cs_size,
 					ARCH_KMALLOC_MINALIGN,
@@ -1841,6 +1830,7 @@ static void set_up_list3s(struct kmem_ca
 static size_t calculate_slab_order(struct kmem_cache *cachep,
 			size_t size, size_t align, unsigned long flags)
 {
+	unsigned long offslab_limit;
 	size_t left_over = 0;
 	int gfporder;
 
@@ -1852,9 +1842,18 @@ static size_t calculate_slab_order(struc
 		if (!num)
 			continue;
 
-		/* More than offslab_limit objects will cause problems */
-		if ((flags & CFLGS_OFF_SLAB) && num > offslab_limit)
-			break;
+		if (flags & CFLGS_OFF_SLAB) {
+			/*
+			 * Max number of objs-per-slab for caches which
+			 * use off-slab slabs. Needed to avoid a possible
+			 * looping condition in cache_grow().
+			 */
+			offslab_limit = size - sizeof(struct slab);
+			offslab_limit /= sizeof(kmem_bufctl_t);
+
+ 			if (num > offslab_limit)
+				break;
+		}
 
 		/* Found something acceptable - save it away */
 		cachep->num = num;
