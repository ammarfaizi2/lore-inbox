Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWBFX2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWBFX2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWBFX2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:28:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964865AbWBFX2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:28:49 -0500
Date: Mon, 6 Feb 2006 15:30:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, sonny@burdell.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [patch 2/3] NUMA slab locking fixes - move irq disabling from
 cahep->spinlock to l3 lock
Message-Id: <20060206153008.361202e1.akpm@osdl.org>
In-Reply-To: <20060206225117.GB3578@localhost.localdomain>
References: <20060203205341.GC3653@localhost.localdomain>
	<20060203140748.082c11ee.akpm@osdl.org>
	<Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com>
	<20060204010857.GG3653@localhost.localdomain>
	<20060204012800.GI3653@localhost.localdomain>
	<20060204014828.44792327.akpm@osdl.org>
	<20060206225117.GB3578@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> On Sat, Feb 04, 2006 at 01:48:28AM -0800, Andrew Morton wrote:
> > Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > >
> > > Earlier, we had to disable on chip interrupts while taking the cachep->spinlock
> > >  because, at cache_grow, on every addition of a slab to a slab cache, we 
> > >  incremented colour_next which was protected by the cachep->spinlock, and
> > >  cache_grow could occur at interrupt context.  Since, now we protect the 
> > >  per-node colour_next with the node's list_lock, we do not need to disable 
> > >  on chip interrupts while taking the per-cache spinlock, but we
> > >  just need to disable interrupts when taking the per-node kmem_list3 list_lock.
> > 
> > It'd be nice to have some comments describing what cachep->spinlock
> > actually protects.
> 
> Actually, it does not protect much anymore.  Here's a cleanup+comments
> patch (against current mainline).

This is getting scary.  Manfred, Christoph, Pekka: have you guys taken a
close look at what's going on in here?

> The non atomic stats on the cachep structure now needs serialization though,
> would a spinlock be better there instead of changing them over to atomic_t s
> ? I wonder...

It's common for the kernel to use non-atomic ops for stats such as this
(networking especially).  We accept the small potential for small
inaccuracy as an acceptable tradeoff for improved performance.

But given that a) these stats are only enabled with CONFIG_DEBUG_SLAB and
b) CONFIG_DEBUG_SLAB causes performance to suck the big one anyway and c)
the slab.c stats are wrapped in handy macros, yes, I guess it wouldn't hurt
to make these guys atomic_t.  Sometime.  My slab.c is looking rather
overpatched again at present.

A problem right now is the -mm-only slab debug patches
(slab-leak-detector.patch, slab-cache-shrinker-statistics.patch and the
currently-dropped
periodically-scan-redzone-entries-and-slab-control-structures.patch).  It
would be good if we could finish these things off and get them into mainline
so things get a bit sane again.


