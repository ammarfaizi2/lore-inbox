Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWGMTZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWGMTZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWGMTZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:25:40 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33929 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030310AbWGMTZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:25:39 -0400
Date: Thu, 13 Jul 2006 21:19:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       arjan@infradead.org
Subject: Re: [patch] lockdep: annotate mm/slab.c
Message-ID: <20060713191959.GA27252@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu> <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu> <20060713004445.cf7d1d96.akpm@osdl.org> <20060713124603.GB18936@elte.hu> <Pine.LNX.4.64.0607131147530.5623@g5.osdl.org> <20060713191719.GA26824@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713191719.GA26824@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Why isn't the "on_slab_key" local to just the init_lock_keys() 
> > function, and the #ifdef around it all?
> 
> yeah - find updated patch below.

(find yet another update below - there were too many newlines added 
after the function.)

------->
Subject: lockdep: annotate mm/slab.c
From: Arjan van de Ven <arjan@infradead.org>

mm/slab.c uses nested locking when dealing with 'off-slab'
caches, in that case it allocates the slab header from the
(on-slab) kmalloc caches. Teach the lock validator about
this by putting all on-slab caches into a separate class.

this patch has no effect on non-lockdep kernels.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 mm/slab.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -674,6 +674,28 @@ static struct kmem_cache cache_cache = {
 #endif
 };
 
+/*
+ * Slab sometimes uses the kmalloc slabs to store the slab headers
+ * for other slabs "off slab".
+ * The locking for this is tricky in that it nests within the locks
+ * of all other slabs in a few places; to deal with this special
+ * locking we put on-slab caches into a separate lock-class.
+ */
+static inline void init_lock_keys(struct cache_sizes *s)
+{
+#ifdef CONFIG_LOCKDEP
+	static struct lock_class_key on_slab_key;
+	int q;
+
+	for (q = 0; q < MAX_NUMNODES; q++) {
+		if (!s->cs_cachep->nodelists[q] || OFF_SLAB(s->cs_cachep))
+			continue;
+		lockdep_set_class(&s->cs_cachep->nodelists[q]->list_lock,
+				  &on_slab_key);
+	}
+#endif
+}
+
 /* Guard access to the cache-chain. */
 static DEFINE_MUTEX(cache_chain_mutex);
 static struct list_head cache_chain;
@@ -1391,6 +1413,7 @@ void __init kmem_cache_init(void)
 					ARCH_KMALLOC_FLAGS|SLAB_PANIC,
 					NULL, NULL);
 		}
+		init_lock_keys(sizes);
 
 		sizes->cs_dmacachep = kmem_cache_create(names->name_dma,
 					sizes->cs_size,
