Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVKOSJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVKOSJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVKOSJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:09:01 -0500
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:43205 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S964983AbVKOSJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:09:01 -0500
Subject: Re: [PATCH 1/5] Swap Migration V5: LRU operations
From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Reply-To: lee.schermerhorn@hp.com
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       marcelo.tosatti@cyclades.com, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, linux-kernel@vger.kernel.org,
       magnus.damm@gmail.com, pj@sgi.com, haveblue@us.ibm.com,
       kamezawa.hiroyu@jp.fujitsu.com
In-Reply-To: <Pine.LNX.4.62.0511150837190.9258@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
	 <20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com>
	 <20051114214415.1e107c7b.akpm@osdl.org>
	 <Pine.LNX.4.62.0511150837190.9258@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: LOSL, Nashua
Date: Tue, 15 Nov 2005 13:08:35 -0500
Message-Id: <1132078115.5230.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 08:38 -0800, Christoph Lameter wrote:
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
> 

I believe Andrew is refering to the calls from the interprocessor
interrupt handlers triggered by the smp_call_function().  Looks like
ia64 runs IPI handlers with interrupts enabled [SA_INTERRUPT], so should
be OK there, but maybe not for all archs?

Lee

