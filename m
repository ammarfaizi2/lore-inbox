Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262331AbSI1Uvm>; Sat, 28 Sep 2002 16:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262332AbSI1Uvm>; Sat, 28 Sep 2002 16:51:42 -0400
Received: from packet.digeo.com ([12.110.80.53]:40348 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262331AbSI1Uvl>;
	Sat, 28 Sep 2002 16:51:41 -0400
Message-ID: <3D961797.B4094994@digeo.com>
Date: Sat, 28 Sep 2002 13:56:55 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Levon <movement@marcelothewonderpenguin.com>,
       Ed Tomlinson <tomlins@cam.org>,
       Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 kmem_cache bug
References: <20020928201308.GA59189@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2002 20:56:56.0098 (UTC) FILETIME=[946C5020:01C26731]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
> 
> kmem_cache_destroy() is falsely reporting
> "kmem_cache_destroy: Can't free all objects" in 2.5.39. I have
> verified my code was freeing all allocated items correctly.
> 
> Reverting this chunk :
> 
> -                       list_add(&slabp->list, &cachep->slabs_free);
> +/*                     list_add(&slabp->list, &cachep->slabs_free);            */
> +                       if (unlikely(list_empty(&cachep->slabs_partial)))
> +                               list_add(&slabp->list, &cachep->slabs_partial);
> +                       else
> +                               kmem_slab_destroy(cachep, slabp);
> 
> and the problem goes away. I haven't investigated why.
> 

Thanks.  That's the code which leaves one empty page available
for new allocations rather than freeing it immediately.

It's temporary.  Ed, I think we can just do

	if (list_empty(&cachep->slabs_free))
		list_add(&slabp->list, &cachep->slabs_free);
	else
		kmem_slab_destroy(cachep, slabp);

there?
