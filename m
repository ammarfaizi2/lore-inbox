Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVKOSGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVKOSGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVKOSGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:06:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964977AbVKOSGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:06:48 -0500
Date: Tue, 15 Nov 2005 10:02:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: torvalds@osdl.org, marcelo.tosatti@cyclades.com, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, lee.schermerhorn@hp.com,
       linux-kernel@vger.kernel.org, magnus.damm@gmail.com, pj@sgi.com,
       haveblue@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 1/5] Swap Migration V5: LRU operations
Message-Id: <20051115100248.5ba2383d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0511150837190.9258@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
	<20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com>
	<20051114214415.1e107c7b.akpm@osdl.org>
	<Pine.LNX.4.62.0511150837190.9258@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Mon, 14 Nov 2005, Andrew Morton wrote:
> 
> > >  +int isolate_lru_page(struct page *page)
> > >  +{
> > >  +	int rc = 0;
> > >  +	struct zone *zone = page_zone(page);
> > >  +
> > >  +redo:
> > >  +	spin_lock_irq(&zone->lru_lock);
> > >  +	rc = __isolate_lru_page(zone, page);
> > >  +	spin_unlock_irq(&zone->lru_lock);
> > >  +	if (rc == 0) {
> > >  +		/*
> > >  +		 * Maybe this page is still waiting for a cpu to drain it
> > >  +		 * from one of the lru lists?
> > >  +		 */
> > >  +		smp_call_function(&lru_add_drain_per_cpu, NULL, 0 , 1);
> > 
> > lru_add_drain() ends up doing spin_unlock_irq(), so we'll enable interrupts
> > within the smp_call_function() handler.  Is that legal on all
> > architectures?
> 
> isolate_lru_pages() is only called within a process context in the swap 
> migration patches. The hotplug folks may have to address this if they want 
> to isolate pages from interrupts etc.

But lru_add_drain_per_cpu() will be called from interrupt context: the IPI
handler.

I'm asking whether it is safe for the IPI handler to reenable interupts on
all architectures.  It might be so, but I don't recall ever having seen it
discussed, nor have I seen code which does it.
