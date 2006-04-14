Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWDNSir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWDNSir (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWDNSir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:38:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8649 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751407AbWDNSiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:38:46 -0400
Date: Fri, 14 Apr 2006 11:31:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: Implement lookup_swap_cache for migration entries
Message-Id: <20060414113104.72a5059b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604141025310.18575@schroedinger.engr.sgi.com>
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
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> This undoes the optimization that resulted in a yield in do_swap_cache().
> do_swap_cache() stays as is. Instead we convert the migration entry to
> a page * in lookup_swap_cache.
> 
> For the non swap case we need a special macro version of lookup_swap_cache
> that is only capable of handling migration cache entries.
> 
> ...
>
> @@ -305,6 +306,12 @@ struct page * lookup_swap_cache(swp_entr
>  {
>  	struct page *page;
>  
> +	if (is_migration_entry(entry)) {
> +		page = migration_entry_to_page(entry);
> +		get_page(page);
> +		return page;
> +	}

What locking ensures that the state of `entry' remains unaltered across the
is_migration_entry() and migration_entry_to_page() calls?

>  
> +/*
> + * Must use a macro for lookup_swap_cache since the functions
> + * used are only available in certain contexts.
> + */
> +#define lookup_swap_cache(__swp)				\
> +({	struct page *p = NULL;					\
> +	if (is_migration_entry(__swp)) {			\
> +		p = migration_entry_to_page(__swp);		\
> +		get_page(p);					\
> +	}							\
> +	p;							\
> +})

hm.  Can nommu do any of this?
