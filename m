Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318032AbSGWLmy>; Tue, 23 Jul 2002 07:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSGWLmy>; Tue, 23 Jul 2002 07:42:54 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:63171 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S318032AbSGWLmw>; Tue, 23 Jul 2002 07:42:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: William Lee Irwin III <wli@holomorphy.com>,
       Craig Kulesa <ckulesa@as.arizona.edu>
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
Date: Tue, 23 Jul 2002 07:45:53 -0400
X-Mailer: KMail [version 1.4]
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Steven Cole <scole@lanl.gov>
References: <20020722222150.GF919@holomorphy.com> <Pine.LNX.4.44.0207221520301.14311-100000@loke.as.arizona.edu> <20020723043653.GF13589@holomorphy.com>
In-Reply-To: <20020723043653.GF13589@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207230745.53629.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On July 23, 2002 12:36 am, William Lee Irwin III wrote:
> On Mon, 22 Jul 2002, William Lee Irwin III wrote:
> >> The pte_chain mempool was ridiculously huge and the use of mempool for
> >> this at all was in error.
>
> On Mon, Jul 22, 2002 at 03:36:33PM -0700, Craig Kulesa wrote:
> > That's what I thoguht too -- but Steven tried making the pool 1/4th the
> > size and it still failed.  OTOH, he tried 2.5.27-rmap, which uses the
> > *same mempool patch* and he had no problem with the monster 128KB
> > allocation.  Maybe it was all luck. :)  I can't yet see anything in the
> > slablru patch that has anything to do with it...
>
> While waiting for the other machine to boot I tried these out. There
> appear to be bootstrap ordering problems either introduced by or
> exposed by this patch:

I would vote for ordering.  The slab init code was changed to initialize 
new fields...   Allocating memory for slabs is another story.  They depend on
the lru lists and the pagemap_lru_lock being setup...   Has this happened 
when slab storage is initialized?  If not a call to do this in the slab init logic 
would fix things.  It could also be fixed using this fragment (slab.c):

+       /*
+        * We want the pagemap_lru_lock, in UP spin locks to not
+        * protect us in interrupt context...  In SMP they do but,
+        * optimizating for speed, we process if we do not get it.
+        */
+       if (!(cachep->flags & SLAB_NO_REAP)) {
+#ifdef CONFIG_SMP
+               locked = spin_trylock(&pagemap_lru_lock);
+#else
+               locked = !in_interrupt() && spin_trylock(&pagemap_lru_lock);
+#endif
+               if (!locked && !in_interrupt())
+                       goto opps1;

If there is some way to verify that the pagemap_lru_lock is ready.  Note its
fine to just set locked to 0 and proceed - as long as this condition does not
last forever.  Also this code is in a fastpath so efficient is good...

Thoughts?
Ed Tomlinson




