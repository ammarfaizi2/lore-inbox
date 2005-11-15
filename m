Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVKOSqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVKOSqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVKOSqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:46:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964968AbVKOSqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:46:53 -0500
Date: Tue, 15 Nov 2005 10:46:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: torvalds@osdl.org, marcelo.tosatti@cyclades.com, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, lee.schermerhorn@hp.com,
       linux-kernel@vger.kernel.org, magnus.damm@gmail.com, pj@sgi.com,
       haveblue@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 1/5] Swap Migration V5: LRU operations
Message-Id: <20051115104605.5020764d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0511151011150.10267@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
	<20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com>
	<20051114214415.1e107c7b.akpm@osdl.org>
	<Pine.LNX.4.62.0511150837190.9258@schroedinger.engr.sgi.com>
	<20051115100248.5ba2383d.akpm@osdl.org>
	<Pine.LNX.4.62.0511151011150.10267@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Tue, 15 Nov 2005, Andrew Morton wrote:
> 
> > But lru_add_drain_per_cpu() will be called from interrupt context: the IPI
> > handler.
> 
> Ahh.. thought you meant the lru_add_drain run on the local processor.
>  
> > I'm asking whether it is safe for the IPI handler to reenable interupts on
> > all architectures.  It might be so, but I don't recall ever having seen it
> > discussed, nor have I seen code which does it.
> 
> smp_call_function is also used by the slab allocator to drain the 
> pages. All the spinlocks in there and those of the page allocator (called 
> for freeing pages) use spin_lock_irqsave. Why is this not used for 
> lru_add_drain() and friends?

It's a microoptimisation - lru_add_drain() is always called with local irqs
enabled, so no need for irqsave.

I don't think spin_lock_irqsave() is notably more expensive than
spin_lock_irq() - the cost is in the irq disabling and in the atomic
operation.

> Maybe we need to start a new thread so that others see it?

Spose so.  If we cannot convince ourselves that local_irq_enable() in an
ipi handler is safe, we need to convert any called functions to use
irqsave.
