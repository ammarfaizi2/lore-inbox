Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWDNUAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWDNUAo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWDNUAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:00:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14047 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965067AbWDNUAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:00:44 -0400
Date: Fri, 14 Apr 2006 12:53:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: Implement lookup_swap_cache for migration entries
Message-Id: <20060414125320.72599c7e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604141214060.22652@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	<20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
	<20060413171331.1752e21f.akpm@osdl.org>
	<Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
	<20060413174232.57d02343.akpm@osdl.org>
	<Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
	<20060413180159.0c01beb7.akpm@osdl.org>
	<Pine.LNX.4.64.0604131827210.16220@schroedinger.engr.sgi.com>
	<20060413222921.2834d897.akpm@osdl.org>
	<Pine.LNX.4.64.0604141025310.18575@schroedinger.engr.sgi.com>
	<20060414113104.72a5059b.akpm@osdl.org>
	<Pine.LNX.4.64.0604141143520.22475@schroedinger.engr.sgi.com>
	<20060414121537.11134d26.akpm@osdl.org>
	<Pine.LNX.4.64.0604141214060.22652@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Fri, 14 Apr 2006, Andrew Morton wrote:
> 
> > > > What locking ensures that the state of `entry' remains unaltered across the
> > > > is_migration_entry() and migration_entry_to_page() calls?
> > > 
> > > entry is a variable passed by value to the function.
> > 
> > Sigh.
> > 
> > What locking ensures that the state of the page referred to by `entry' is
> > stable?
> 
> Oh, that.
> 
> Well, there is no locking when retrieving a pte atomically from the page 
> table. In do_swap_cache we figure out the page from the pte, lock the page 
> and then check that the pte has not changed. If it has changed then we 
> redo the fault. If the pte is still the same then we know that the page 
> was stable in the sense that it is still mapped the same way. So it was 
> not freed.
> 
> This applies to all pages handled by do_swap_page().
> 
> The differences are:
> 
> 1. A migration entry does not take the tree_lock in lookup_swap_cache().
> 
> 2. The migration thread will restore the regular pte before 
>    dropping the page lock.
> 
> So after we succeed with the page lock we know that the pte has been 
> changed. The fault will be redone with the regular pte.\

So we're doing a get_page() on a random page which could be in any state -
it could be on the freelists, or in the per-cpu pages arrays, it could have
been reused for something else.

There's code in the kernel which assumes that we don't do that sort of
thing.  For example:

static inline int page_is_buddy(struct page *page, int order)
{
#ifdef CONFIG_HOLES_IN_ZONE
	if (!pfn_valid(page_to_pfn(page)))
		return 0;
#endif

	if (PageBuddy(page) && page_order(page) == order) {
		BUG_ON(page_count(page) != 0);
               return 1;
	}
       return 0;
}

