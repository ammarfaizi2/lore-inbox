Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWBWJkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWBWJkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWBWJkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:40:40 -0500
Received: from inbox2.nyi.net ([64.147.100.114]:12742 "HELO inbox2.nyi.net")
	by vger.kernel.org with SMTP id S1751078AbWBWJkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:40:40 -0500
Date: Thu, 23 Feb 2006 15:05:45 +0530 (IST)
From: Alok Kataria <alok.kataria@calsoftinc.com>
X-X-Sender: alok.kataria@localhost.localdomain
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Christoph Lameter <clameter@engr.sgi.com>, akpm@osdl.org,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: slab: Remove SLAB_NO_REAP option
Message-ID: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 14:18, Pekka Enberg wrote:
On 2/23/06, Alok Kataria <alok.kataria@calsoftinc.com> wrote:
> > There can be some caches which are not used quite often, kmem_cache 
> > for instance. Now from performance perspective having SLAB_NO_REAP for 
> > such caches is good.
>
> Yeah, kmem_cache sounds like a realistic user, but I am wondering if
> it makes any sense for anyone else to use it?
>
Right, thats why my question still is why do these iscsi & ocfs  cache 
have this flag set.

If we are sure that the flag is still required, we can use the patch 
below.

> If you're not using a
> cache that often, perhaps we're better off using kmalloc() instead?
>

Right.

Thanks & Regards,
Alok

--
As pointed by Christoph, there is a problem with SLAB_NO_REAP flag. If set 
then the recovery of objects from alien caches is switched off.
Objects not freed on the same node where they were initially
allocated will only be reused if a certain amount of objects
accumulates from one alien node (not very likely) or if the cache is
explicitly shrunk.
This patch facilitates draining of the alien caches irrespective of the value
of SLAB_NO_REAP flag.

Signed-off-by: Alok N Kataria <alok.kataria@calsoftinc.com>

Index: linux-2.6.16-rc4-git5/mm/slab.c
===================================================================
--- linux-2.6.16-rc4-git5.orig/mm/slab.c	2006-02-23 01:09:49.000000000 -0800
+++ linux-2.6.16-rc4-git5/mm/slab.c	2006-02-23 01:12:54.000000000 -0800
@@ -3488,14 +3488,15 @@ static void cache_reap(void *unused)

  		searchp = list_entry(walk, struct kmem_cache, next);

-		if (searchp->flags & SLAB_NO_REAP)
-			goto next;
-
  		check_irq_on();

  		l3 = searchp->nodelists[numa_node_id()];
  		if (l3->alien)
  			drain_alien_cache(searchp, l3->alien);
+
+		if (searchp->flags & SLAB_NO_REAP)
+			goto next;
+
  		spin_lock_irq(&l3->list_lock);

  		drain_array_locked(searchp, cpu_cache_get(searchp), 0,
