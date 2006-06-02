Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWFBTpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWFBTpE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWFBTpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:45:03 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:24285 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750863AbWFBTpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:45:01 -0400
Date: Fri, 2 Jun 2006 21:45:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paolo Ornati <ornati@fastwebnet.it>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: [patch] mm/slab.c: fix early init assumption
Message-ID: <20060602194510.GA971@elte.hu>
References: <20060602134458.GA4914@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602134458.GA4914@elte.hu>
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

Subject: mm/slab.c: fix early init assumption
From: Ingo Molnar <mingo@elte.hu>

the SLAB bootstrap code assumes that the first two kmalloc caches
created (the INDEX_AC and INDEX_L3 kmalloc caches) wont be off-slab.
But due to AC and L3 structure size increase in lockdep, one of them
ended up being off-slab, and subsequently crashing with:

Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
 [<ffffffff80267478>] kmem_cache_alloc+0x26/0x7d

the fix is to introduce a bootstrap flag and to use it to prevent
off-slab caches being created so early during bootup.

(the calculation for off-slab caches is quite complex so i didnt want
to complicate things with introducing yet another INDEX_ calculation,
the flag approach is simpler and smaller.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 mm/slab.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -333,6 +333,8 @@ static __always_inline int index_of(cons
 	return 0;
 }
 
+static int slab_early_init = 1;
+
 #define INDEX_AC index_of(sizeof(struct arraycache_init))
 #define INDEX_L3 index_of(sizeof(struct kmem_list3))
 
@@ -1377,6 +1379,8 @@ void __init kmem_cache_init(void)
 				NULL, NULL);
 	}
 
+	slab_early_init = 0;
+
 	while (sizes->cs_size != ULONG_MAX) {
 		/*
 		 * For performance, all the general caches are L1 aligned.
@@ -2128,8 +2132,12 @@ kmem_cache_create (const char *name, siz
 #endif
 #endif
 
-	/* Determine if the slab management is 'on' or 'off' slab. */
-	if (size >= (PAGE_SIZE >> 3))
+	/*
+	 * Determine if the slab management is 'on' or 'off' slab.
+	 * (bootstrapping cannot cope with offslab caches so dont do
+	 *  it too early on.)
+	 */
+	if ((size >= (PAGE_SIZE >> 3)) && !slab_early_init)
 		/*
 		 * Size is large, assume best to place the slab management obj
 		 * off-slab (should allow better packing of objs).
