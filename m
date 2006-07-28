Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752008AbWG1RKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbWG1RKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbWG1RKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:10:19 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:21917 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1752008AbWG1RKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:10:17 -0400
Date: Fri, 28 Jul 2006 10:11:55 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, alokk@calsoftinc.com,
       tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
Message-ID: <20060728171155.GA3739@localhost.localdomain>
References: <1154044607.27297.101.camel@localhost.localdomain> <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com> <Pine.LNX.4.64.0607280744530.18198@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607280744530.18198@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 07:53:56AM -0700, Christoph Lameter wrote:
> On Fri, 28 Jul 2006, Pekka Enberg wrote:
> 
> > > [   57.976447]  [<ffffffff802542fc>] __lock_acquire+0x8cc/0xcb0
> > > [   57.976562]  [<ffffffff80254a02>] lock_acquire+0x52/0x70
> > > [   57.976675]  [<ffffffff8028f201>] kmem_cache_free+0x141/0x210
> > > [   57.976790]  [<ffffffff804a6b74>] _spin_lock+0x34/0x50
> > > [   57.976903]  [<ffffffff8028f201>] kmem_cache_free+0x141/0x210
> > > [   57.977018]  [<ffffffff8028f388>] slab_destroy+0xb8/0xf0
> 
> Huh? _spin_lock calls kmem_cache_free?
> 
> >  cache_reap
> >  reap_alien	(grabs l3->alien[node]->lock)
> >  __drain_alien_cache
> >  free_block
> >  slab_destroy	(slab management off slab)
> >  kmem_cache_free
> >  __cache_free
> >  cache_free_alien (recursive attempt on l3->alien[node] lock)
> > 
> > Christoph?
> 
> This should not happen. __drain_alien_cache frees node local elements
> thus cache_free_alien should not be called. However, if the slab 
> management was allocated on a different node from the slab data then we 
> may have an issue. However, both slab managemnt and the slab data are 
> allocated on the same node (with alloc_pages_node() and kmalloc_node).

cache_free_alien could get called, but there is no recursion here:

1. reap_alien tries dropping remote objects freed by local node (A) to the 
remote node (B) shared array cache (choosing a remote node as indicated by the 
node rotor), to do this, it takes the local alien cache lock (A), and calls 
__drain_alien_cache. The remote object comes from a slab cache X say.

2. __drain_alien_cache. takes the remote node l3 lock (B), transfers as many
objects as shared array cache of the remote node can hold, and calls
free_block to free remaining objects that could not be dropped in into the
shared array cache of remote node (B).  Now free_block is being called from
(A) to free objects on (B). 

3. free_block calls slab_destroy for the slab belonging to B. calls
kmem_cache_free for the slab management, which calls __cache_free, and 
hence cache_free_alien().  Now since this is being called from A for a local
object of B, the check in cache_free_alien fails, and cache_free_alien
*does* get executed.  Since slab management of a slab from B, local to B is
freed from A, A tries to write to the local alien cache corresponding to B,
which comes from a slab cache Y.  There is a recursion if X and Y are the
same caches.   But that is not a possibility at all, as the off slab management
for a slab cache cannot come from the same slab cache.  So this looks like a
false positive from lockdep.  

tglx, does the machine boot without lockdep?  If yes, then this is a false 
positive IMO.

Thanks,
Kiran
