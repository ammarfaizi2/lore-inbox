Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVAGU7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVAGU7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVAGU50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:57:26 -0500
Received: from [213.85.13.118] ([213.85.13.118]:2434 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261601AbVAGUzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:55:54 -0500
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] per thread page reservation patch
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	<20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com>
	<1105019521.7074.79.camel@tribesman.namesys.com>
	<20050107144644.GA9606@infradead.org>
	<1105118217.3616.171.camel@tribesman.namesys.com>
	<41DEDF87.8080809@grupopie.com>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Fri, 07 Jan 2005 23:55:39 +0300
In-Reply-To: <41DEDF87.8080809@grupopie.com> (Paulo Marques's message of
 "Fri, 07 Jan 2005 19:14:15 +0000")
Message-ID: <m1llb5q7qs.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques <pmarques@grupopie.com> writes:

[...]

>
> This seems like a very asymmetrical behavior. If the code explicitly
> reserves pages, it should explicitly use them, or it will become
> impossible to track down who is using what (not to mention that this
> will slow down every regular user of __alloc_pages, even if it is just
> for a quick test).
>
> Why are there specialized functions to reserve the pages, but then they
> are used through the standard __alloc_pages interface?

That's the whole idea behind this patch: at the beginning of "atomic"
operation, some number of pages is reserved. As these pages are
available through page allocator, _all_ allocations done by atomic
operation will use reserved pages transparently. For example:

        perthread_pages_reserve(nr, GFP_KERNEL);

        foo()->

            bar()->

                page = find_or_create_page(some_mapping, ...);

        perthread_pages_release(unused_pages);

find_or_create() pages will use pages reserved for this thread and,
hence, is guaranteed to succeed (given correct reservation).

Alternative is to pass some sort of handle all the way down to actual
calls to allocator, and to modify all generic code to use reservations.

Nikita.
