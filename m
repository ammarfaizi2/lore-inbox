Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965290AbWHWXBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbWHWXBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbWHWXBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:01:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965290AbWHWXBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:01:37 -0400
Date: Wed, 23 Aug 2006 15:51:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 8/18] 2.6.17.9 perfmon2 patch for review: event sets and
 multiplexing support
Message-Id: <20060823155148.a2945c4e.akpm@osdl.org>
In-Reply-To: <200608230805.k7N85x2H000432@frankl.hpl.hp.com>
References: <200608230805.k7N85x2H000432@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 01:05:59 -0700
Stephane Eranian <eranian@frankl.hpl.hp.com> wrote:

> This patch contains the event set and multiplexing support.
> 
> On many PMU models, there is not enough counter to collect
> certain metric in one run. Even on those that have potentially
> lots of counters, e.g. P4 with 18, there are oftentimes constraints
> which make measuring certain event together impossible. In those
> situation the user has n choice but to measure with multiple
> runs which is not always practical and prone to errors.
> 
> One way to alleviate the problem is to introduce the notion
> of an event set. Each set encapsulates the entire PMU state.
> If a PMU has M counters then each set can define M events. 
> Multiple sets can be defined. They are then multiplexed onto
> the actual PMU such that only one is active at any time.
> The collected counts can then be scaled to get an *estimate*
> of what they would have been had each event been measured across
> the entire run. It is important to note that this remains an
> estimate. The faster we can switch, the smaller the blind spots are
> but the higher the overhead is.
> 
> Sets and set switching can be implemented at the user level. Yet
> by having kernel support for it, we can signification improve
> performance especially for non self-monitoring per-thread context where
> we guarantee switching always occurs in the context of the monitored thread.
> 
> By default, any perfmon2 context is created with a default set, i.e., set0.
> Set can be dynamically created/deleted with specific system calls. A set
> is identified by a simple number (0-65535). The number determines the
> position of the set in an ordered list. The order in the list determines
> the switch order. Switching occurs in a round-robin fashion.
> 
> Switching can be triggered by a timeout or after a certain number of overflows.
> The type of switching as well as the timeout is determined per set.
> The timeout granularity is determined by that of the timer tick. The actual
> timeout value is returned to the user.
> 
> The file perfmon_sets.c implements:
> 	- set-related back-end system calls: __pfm_create_evtsets(), __pfm_delete_evtsets(), __pfm_getinfo_evtsets()
> 	- set switching: pfm_switch_sets(), __pfm_handle_switch_timeout()
> 
>
> ...
>
> +struct pfm_event_set *pfm_find_set(struct pfm_context *ctx, u16 set_id,
> +					  int alloc)
> +{
> +	kmem_cache_t *cachep;
> +	struct pfm_event_set *set, *new_set, *prev;
> +	unsigned long offs;
> +	size_t view_size;
> +	void *view;
> +
> +	PFM_DBG("looking for set=%u", set_id);
> +
> +	/*
> +	 * shortcut for set 0: always exist, cannot be removed
> +	 */
> +	if (set_id == 0 && !alloc)
> +		return list_entry(ctx->list.next, struct pfm_event_set, list);
> +
> +	prev = NULL;
> +	list_for_each_entry(set, &ctx->list, list) {
> +		if (set->id == set_id)
> +			return set;
> +		if (set->id > set_id)
> +			break;
> +		prev = set;
> +	}
> +
> +	if (!alloc)
> +		return NULL;
> +
> +	cachep = ctx->flags.mapset ? pfm_set_cachep : pfm_lg_set_cachep;
> +
> +	new_set = kmem_cache_alloc(cachep, SLAB_ATOMIC);

SLAB_ATOMIC is unreliable.  Is it possible to use SLAB_KERNEL here?  If
coms ecallers can sleep and others cannot then passing in the gfp_flags
would permit improvement here.

> +	if (new_set) {
> +		memset(new_set, 0, sizeof(*set));

kmem_cache_zalloc() exists.

> +		if (ctx->flags.mapset) {
> +			view_size = PAGE_ALIGN(sizeof(struct pfm_set_view));
> +			view      = vmalloc(view_size);

vmalloc() sleeps, so this _could_ have used SLAB_ATOMIC.

> +static struct page *pfm_view_map_pagefault(struct vm_area_struct *vma,
> +					   unsigned long address, int *type)
> +{
> +	void *kaddr;
> +	struct page *page;
> +
> +	kaddr = vma->vm_private_data;
> +	if (kaddr == NULL) {
> +		PFM_DBG("no view");
> +		return NOPAGE_SIGBUS;
> +	}
> +
> +	if ( (address < (unsigned long) vma->vm_start) ||
> +	     (address > (unsigned long) (vma->vm_start + PAGE_SIZE)) )

Should that be >=?


