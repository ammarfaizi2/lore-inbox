Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262475AbSI2Nqv>; Sun, 29 Sep 2002 09:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262476AbSI2Nqv>; Sun, 29 Sep 2002 09:46:51 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:26783 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262475AbSI2Nqu>;
	Sun, 29 Sep 2002 09:46:50 -0400
Message-ID: <3D970584.5040606@colorfullife.com>
Date: Sun, 29 Sep 2002 15:52:04 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: Andrew Morton <akpm@digeo.com>,
       John Levon <movement@marcelothewonderpenguin.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 kmem_cache bug
References: <20020928201308.GA59189@compsoc.man.ac.uk> <3D961797.B4094994@digeo.com> <200209290915.52661.tomlins@cam.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
>  
> -	if (__kmem_cache_shrink(cachep)) {
> +	/* remove any empty partial pages */
> +	spin_lock_irq(&cachep->spinlock);
> +	while (!cachep->growing) {
> +		struct list_head *p;
> +		slab_t *slabp;
> +

growing is guaranteed to be false - loop is not necessary.

Actually growing can be removed completely, it's never necessary, 
neither with nor without kmem_cache_reap().

Ed, there are far more cleanups possible in slab.c than just going from 
3 to 2 lists, but IMHO it's far to early to make the design decision for 
2 lists.

Or wait: You want 2 lists? Ok, agreed.

free and partial ;-)

The full list is unnecessary, it's possible to replace it with a 
counter. It also saves several cacheline accesses for the list_del() and 
list_add() into the full list...

--
	Manfred

