Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVI0S4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVI0S4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVI0S4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:56:36 -0400
Received: from vena.lwn.net ([206.168.112.25]:27580 "HELO lwn.net")
	by vger.kernel.org with SMTP id S965044AbVI0S4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:56:36 -0400
Message-ID: <20050927185635.8023.qmail@lwn.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm - swap_prefetch-11 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 23 Sep 2005 17:11:47 +1000."
             <200509231711.47822.kernel@kolivas.org> 
Date: Tue, 27 Sep 2005 12:56:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Con,

> This patch implements swap prefetching when the vm is relatively idle and
> there is free ram available. 

I'm having a look at it now (better late than never...), and a couple of
questions come to mind...

The more general of the two is: would it make sense to somehow merge
your swapped_entry data structure with Rik's page-remembering scheme for
CLOCK-PRO?  Assumed that both are someday destined for inclusion, it
seems it would make sense to add just one "remember info about swapped
pages" data structure, rather than two.

Second question:

> +++ linux-2.6.13-sp/include/linux/fs.h	2005-09-23 16:57:03.000000000 +1000
> @@ -340,6 +340,8 @@ struct address_space {
>  	struct inode		*host;		/* owner: inode, block_device */
>  	struct radix_tree_root	page_tree;	/* radix tree of all pages */
>  	rwlock_t		tree_lock;	/* and rwlock protecting it */
> +	struct radix_tree_root	swap_tree;	/* radix tree of swapped pages */
> +	struct list_head	swapped_pages;	/* list of swapped pages */

It looks like you are adding these fields to every address_space
structure in the system - and there can be a fair number of those.  But
further down, when it comes time to remember a swapped page:

> +void add_to_swapped_list(unsigned long index)
> +{
> +	struct swapped_entry_t *entry;
> +	struct address_space *mapping = &swapper_space;

You're only actually remembering pages associated with a single address
space.  

Do you anticipate adding prefetching from other address spaces as well?
If not, it might be worth putting these structures somewhere else to
avoid bloating the address_space structure.

...or am I missing something again...?

Thanks,

jon
