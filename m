Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262335AbSI1V3w>; Sat, 28 Sep 2002 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262336AbSI1V3w>; Sat, 28 Sep 2002 17:29:52 -0400
Received: from packet.digeo.com ([12.110.80.53]:23197 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262335AbSI1V3v>;
	Sat, 28 Sep 2002 17:29:51 -0400
Message-ID: <3D96208A.B1E6BDEB@digeo.com>
Date: Sat, 28 Sep 2002 14:35:06 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Levon <movement@marcelothewonderpenguin.com>
CC: Ed Tomlinson <tomlins@cam.org>, Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 kmem_cache bug
References: <20020928201308.GA59189@compsoc.man.ac.uk> <3D961797.B4094994@digeo.com> <20020928212308.GA61236@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2002 21:35:06.0991 (UTC) FILETIME=[E9E6D7F0:01C26736]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
> 
> On Sat, Sep 28, 2002 at 01:56:55PM -0700, Andrew Morton wrote:
> 
> >       if (list_empty(&cachep->slabs_free))
> >               list_add(&slabp->list, &cachep->slabs_free);
> >       else
> >               kmem_slab_destroy(cachep, slabp);
> 
> This seems to work for me on a quick test.
> 

Thanks.    I'll send the below patch.




Slab currently has a policy of buffering a single spare page per slab. 
We're putting that on the partially-full list, which confuses
kmem_cache_destroy().

So put it on cachep->slabs_free, which is where empty pages go.




 mm/slab.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

--- 2.5.39/mm/slab.c~slab-fix	Sat Sep 28 14:20:52 2002
+++ 2.5.39-akpm/mm/slab.c	Sat Sep 28 14:23:50 2002
@@ -1499,9 +1499,9 @@ static inline void kmem_cache_free_one(k
 		if (unlikely(!--slabp->inuse)) {
 			/* Was partial or full, now empty. */
 			list_del(&slabp->list);
-/*			list_add(&slabp->list, &cachep->slabs_free); 		*/
-			if (unlikely(list_empty(&cachep->slabs_partial)))
-				list_add(&slabp->list, &cachep->slabs_partial);
+			/* We only buffer a single page */
+			if (list_empty(&cachep->slabs_free))
+				list_add(&slabp->list, &cachep->slabs_free);
 			else
 				kmem_slab_destroy(cachep, slabp);
 		} else if (unlikely(inuse == cachep->num)) {
@@ -1977,8 +1977,7 @@ static int s_show(struct seq_file *m, vo
 	}
 	list_for_each(q,&cachep->slabs_partial) {
 		slabp = list_entry(q, slab_t, list);
-		if (slabp->inuse == cachep->num)
-			BUG();
+		BUG_ON(slabp->inuse == cachep->num || !slabp->inuse);
 		active_objs += slabp->inuse;
 		active_slabs++;
 	}

.
