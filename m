Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSI2NMQ>; Sun, 29 Sep 2002 09:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262470AbSI2NMP>; Sun, 29 Sep 2002 09:12:15 -0400
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:927 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262469AbSI2NMO>; Sun, 29 Sep 2002 09:12:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>,
       John Levon <movement@marcelothewonderpenguin.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.5.39 kmem_cache bug
Date: Sun, 29 Sep 2002 09:15:52 -0400
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20020928201308.GA59189@compsoc.man.ac.uk> <3D961797.B4094994@digeo.com>
In-Reply-To: <3D961797.B4094994@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209290915.52661.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 28, 2002 04:56 pm, Andrew Morton wrote:
> John Levon wrote:
> > kmem_cache_destroy() is falsely reporting
> > "kmem_cache_destroy: Can't free all objects" in 2.5.39. I have
> > verified my code was freeing all allocated items correctly.
> >
> > Reverting this chunk :
> >
> > -                       list_add(&slabp->list, &cachep->slabs_free);
> > +/*                     list_add(&slabp->list, &cachep->slabs_free);     
> >       */ +                       if
> > (unlikely(list_empty(&cachep->slabs_partial))) +                         
> >      list_add(&slabp->list, &cachep->slabs_partial); +                   
> >    else
> > +                               kmem_slab_destroy(cachep, slabp);
> >
> > and the problem goes away. I haven't investigated why.
>
> Thanks.  That's the code which leaves one empty page available
> for new allocations rather than freeing it immediately.
>
> It's temporary.  Ed, I think we can just do
>
> 	if (list_empty(&cachep->slabs_free))
> 		list_add(&slabp->list, &cachep->slabs_free);
> 	else
> 		kmem_slab_destroy(cachep, slabp);
>
> there?

How about this (untested) instead.  If we can avoid using cachep->slabs_free its 
a good thing.  Why use three lists when two can do the job?  I use a loop to clean 
the partial list since its possible that for some caches we may want to have more
than one slabp of buffer.

Thoughts?
Ed

---------
diff -Nru a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	Sun Sep 29 09:08:53 2002
+++ b/mm/slab.c	Sun Sep 29 09:08:53 2002
@@ -1036,7 +1036,26 @@
 	list_del(&cachep->next);
 	up(&cache_chain_sem);
 
-	if (__kmem_cache_shrink(cachep)) {
+	/* remove any empty partial pages */
+	spin_lock_irq(&cachep->spinlock);
+	while (!cachep->growing) {
+		struct list_head *p;
+		slab_t *slabp;
+
+		p = cachep->slabs_partial.prev;
+		if (p == &cachep->slabs_partial)
+			break;
+
+		slabp = list_entry(cachep->slabs_partial.prev, slab_t, list);
+		if (slabp->inuse)
+			break;
+
+		list_del(&slabp->list);
+
+	}
+	spin_unlock_irq(&cachep->spinlock);
+
+	if (!list_empty(&cachep->slabs_full) || !list_empty(&cachep->slabs_partial)) {
 		printk(KERN_ERR "kmem_cache_destroy: Can't free all objects %p\n",
 		       cachep);
 		down(&cache_chain_sem);

---------

