Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWGMKoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWGMKoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 06:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWGMKoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 06:44:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9651 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750817AbWGMKod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 06:44:33 -0400
Subject: Re: [patch] lockdep: more annotations for mm/slab.c
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060713091804.GA11572@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra>
	 <20060713071221.GA31349@elte.hu> <20060713002803.cd206d91.akpm@osdl.org>
	 <20060713072635.GA907@elte.hu> <20060713004445.cf7d1d96.akpm@osdl.org>
	 <20060713084213.GA6985@elte.hu> <20060713084613.GA7177@elte.hu>
	 <20060713020801.44b99061.akpm@osdl.org>  <20060713091804.GA11572@elte.hu>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 12:44:29 +0200
Message-Id: <1152787469.3024.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 11:18 +0200, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > ---
> > >  mm/slab.c |   45 +++++++++++++++++++++++++--------------------
> > 
> > geeze, what fuss.  Can't we just tell lockdep "the locking here is 
> > correct, so buzz off"?
> 
> well, lockdep already found a locking bug in slab.c, so by telling 
> lockdep to buzz off we lose the proof of correctness :-)
> 
> but i agree that this is getting a bit too intrusive. This patch is 
> really just another expression of: 'slab locking is too complex', but i 
> digress. Not all hope is lost though: Arjan thinks he can do a much 
> simpler annotation.


I am hoping I can get away with just this patch; the idea is to give the
cache_cache slab a special lock type since it'll be nested all the time
(and has a natural ordering due to it's special position in the slab
code). I'm not yet sure I found all places where this stuff is
initialized (the slab code has gotten terribly complex with all the numa
stuff added to it); I've started to test this now at least and so far it
seems to work on my test box.


Index: linux-2.6.18-rc1/mm/slab.c
===================================================================
--- linux-2.6.18-rc1.orig/mm/slab.c
+++ linux-2.6.18-rc1/mm/slab.c
@@ -317,6 +317,16 @@ static void enable_cpucache(struct kmem_
 static void cache_reap(void *unused);
 
 /*
+ * Slab sometimes uses the kmalloc slabs to store the slab headers
+ * for other slabs "off slab".
+ * The locking for this is tricky in that it
+ * nests within the locks of all other slabs in a few
+ * places; to deal with this special locking we give
+ * this one slab a special class.
+ */
+static struct lock_class_key slab_name_lock_key;
+
+/*
  * This function must be completely optimized away if a constant is passed to
  * it.  Mostly the same as what is in linux/slab.h except it returns an index.
  */
@@ -1443,6 +1453,7 @@ void __init kmem_cache_init(void)
 		/* Replace the static kmem_list3 structures for the boot cpu */
 		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE],
 			  numa_node_id());
+		lockdep_set_class(&(cache_cache.nodelists[numa_node_id()]->list_lock), &slab_name_lock_key);
 
 		for_each_online_node(node) {
 			init_list(malloc_sizes[INDEX_AC].cs_cachep,


