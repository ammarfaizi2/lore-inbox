Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWDNSsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWDNSsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWDNSsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:48:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51121 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751408AbWDNSst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:48:49 -0400
Date: Fri, 14 Apr 2006 11:48:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: Implement lookup_swap_cache for migration entries
In-Reply-To: <20060414113104.72a5059b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604141143520.22475@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org> <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
 <20060413174232.57d02343.akpm@osdl.org> <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
 <20060413180159.0c01beb7.akpm@osdl.org> <Pine.LNX.4.64.0604131827210.16220@schroedinger.engr.sgi.com>
 <20060413222921.2834d897.akpm@osdl.org> <Pine.LNX.4.64.0604141025310.18575@schroedinger.engr.sgi.com>
 <20060414113104.72a5059b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006, Andrew Morton wrote:

> > @@ -305,6 +306,12 @@ struct page * lookup_swap_cache(swp_entr
> >  {
> >  	struct page *page;
> >  
> > +	if (is_migration_entry(entry)) {
> > +		page = migration_entry_to_page(entry);
> > +		get_page(page);
> > +		return page;
> > +	}
> 
> What locking ensures that the state of `entry' remains unaltered across the
> is_migration_entry() and migration_entry_to_page() calls?

entry is a variable passed by value to the function.

> > +/*
> > + * Must use a macro for lookup_swap_cache since the functions
> > + * used are only available in certain contexts.
> > + */
> > +#define lookup_swap_cache(__swp)				\
> > +({	struct page *p = NULL;					\
> > +	if (is_migration_entry(__swp)) {			\
> > +		p = migration_entry_to_page(__swp);		\
> > +		get_page(p);					\
> > +	}							\
> > +	p;							\
> > +})
> 
> hm.  Can nommu do any of this?

If page migration is off (methinks nommu may not support numa) then
the fallback functions are used.

Fallback is

is_migration_entry() == 0 

therefore

#define lookup_swap_cache(__swp) NULL

like before.
 
