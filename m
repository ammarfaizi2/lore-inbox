Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751993AbWG1Oyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbWG1Oyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbWG1Oyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:54:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31135 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751993AbWG1Oye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:54:34 -0400
Date: Fri, 28 Jul 2006 07:53:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: alokk@calsoftinc.com, tglx@linutronix.de,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
In-Reply-To: <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607280744530.18198@schroedinger.engr.sgi.com>
References: <1154044607.27297.101.camel@localhost.localdomain>
 <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006, Pekka Enberg wrote:

> > [   57.976447]  [<ffffffff802542fc>] __lock_acquire+0x8cc/0xcb0
> > [   57.976562]  [<ffffffff80254a02>] lock_acquire+0x52/0x70
> > [   57.976675]  [<ffffffff8028f201>] kmem_cache_free+0x141/0x210
> > [   57.976790]  [<ffffffff804a6b74>] _spin_lock+0x34/0x50
> > [   57.976903]  [<ffffffff8028f201>] kmem_cache_free+0x141/0x210
> > [   57.977018]  [<ffffffff8028f388>] slab_destroy+0xb8/0xf0

Huh? _spin_lock calls kmem_cache_free?

>  cache_reap
>  reap_alien	(grabs l3->alien[node]->lock)
>  __drain_alien_cache
>  free_block
>  slab_destroy	(slab management off slab)
>  kmem_cache_free
>  __cache_free
>  cache_free_alien (recursive attempt on l3->alien[node] lock)
> 
> Christoph?

This should not happen. __drain_alien_cache frees node local elements
thus cache_free_alien should not be called. However, if the slab 
management was allocated on a different node from the slab data then we 
may have an issue. However, both slab managemnt and the slab data are 
allocated on the same node (with alloc_pages_node() and kmalloc_node).

If something went wrong with kmalloc_node or alloc_pages_node (fallback?) 
then we may have an issue. Guess we need to look into this some more.
Alok,  have you thought about this issue before?
