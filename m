Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSI2Lln>; Sun, 29 Sep 2002 07:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSI2Lln>; Sun, 29 Sep 2002 07:41:43 -0400
Received: from tomts9.bellnexxia.net ([209.226.175.53]:15855 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262449AbSI2Lln>; Sun, 29 Sep 2002 07:41:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>,
       John Levon <movement@marcelothewonderpenguin.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.5.39 kmem_cache bug
Date: Sun, 29 Sep 2002 07:45:20 -0400
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20020928201308.GA59189@compsoc.man.ac.uk> <3D961797.B4094994@digeo.com>
In-Reply-To: <3D961797.B4094994@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209290745.20484.tomlins@cam.org>
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
>kmem_cache_destroy
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

Yes we can do this.  I would rather fix kmem_cache_destroy though.  Think that, if 
we play our cards right, we can get rid of the cachep->slabs_free list with out too
much pain.

Ed

