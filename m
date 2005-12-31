Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVLaHct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVLaHct (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 02:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVLaHcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 02:32:48 -0500
Received: from hera.kernel.org ([140.211.167.34]:56000 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751318AbVLaHcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 02:32:48 -0500
Date: Sat, 31 Dec 2005 05:32:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>, torvalds@osdl.org,
       kravetz@us.ibm.com, raybry@mpdtxmail.amd.com, lee.schermerhorn@hp.com,
       linux-kernel@vger.kernel.org, magnus.damm@gmail.com, pj@sgi.com,
       haveblue@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 1/5] Swap Migration V5: LRU operations
Message-ID: <20051231073231.GA12526@dmt.cnet>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com> <20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com> <20051114214415.1e107c7b.akpm@osdl.org> <Pine.LNX.4.62.0511150837190.9258@schroedinger.engr.sgi.com> <20051115100248.5ba2383d.akpm@osdl.org> <Pine.LNX.4.62.0511151011150.10267@schroedinger.engr.sgi.com> <20051115104605.5020764d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115104605.5020764d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 10:46:05AM -0800, Andrew Morton wrote:
> Christoph Lameter <clameter@engr.sgi.com> wrote:
> >
> > On Tue, 15 Nov 2005, Andrew Morton wrote:
> > 
> > > But lru_add_drain_per_cpu() will be called from interrupt context: the IPI
> > > handler.
> > 
> > Ahh.. thought you meant the lru_add_drain run on the local processor.
> >  
> > > I'm asking whether it is safe for the IPI handler to reenable interupts on
> > > all architectures.  It might be so, but I don't recall ever having seen it
> > > discussed, nor have I seen code which does it.
> > 
> > smp_call_function is also used by the slab allocator to drain the 
> > pages. All the spinlocks in there and those of the page allocator (called 
> > for freeing pages) use spin_lock_irqsave. Why is this not used for 
> > lru_add_drain() and friends?
> 
> It's a microoptimisation - lru_add_drain() is always called with local irqs
> enabled, so no need for irqsave.
> 
> I don't think spin_lock_irqsave() is notably more expensive than
> spin_lock_irq() - the cost is in the irq disabling and in the atomic
> operation.

Pardon me, but spin_lock_irqsave() needs to write data to the stack,
which is likely to be cache-cold, so you have to fault the cacheline in 
from slow memory.

And thats much slower than the atomic operation, isnt it?
