Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVAHMoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVAHMoz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 07:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVAHMoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 07:44:55 -0500
Received: from [213.85.13.118] ([213.85.13.118]:16256 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261867AbVAHMow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 07:44:52 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: pmarques@grupopie.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: [RFC] per thread page reservation patch
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	<20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com>
	<1105019521.7074.79.camel@tribesman.namesys.com>
	<20050107144644.GA9606@infradead.org>
	<1105118217.3616.171.camel@tribesman.namesys.com>
	<41DEDF87.8080809@grupopie.com> <m1llb5q7qs.fsf@clusterfs.com>
	<20050107132459.033adc9f.akpm@osdl.org> <m1d5wgrir7.fsf@clusterfs.com>
	<20050107150315.3c1714a4.akpm@osdl.org> <m18y74rfqs.fsf@clusterfs.com>
	<20050107154305.790b8a51.akpm@osdl.org>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Sat, 08 Jan 2005 15:44:31 +0300
In-Reply-To: <20050107154305.790b8a51.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 7 Jan 2005 15:43:05 -0800")
Message-ID: <m1vfa8w0nk.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Nikita Danilov <nikita@clusterfs.com> wrote:
>>
>> >
>> > Why does the filesystem risk going oom during the rebalance anyway?  Is it
>> > doing atomic allocations?
>> 
>> No, just __alloc_pages(GFP_KERNEL, 0, ...) returns NULL. When this
>> happens, the only thing balancing can do is to panic.
>
> __alloc_pages(GFP_KERNEL, ...) doesn't return NULL.  It'll either succeed
> or never return ;) That behaviour may change at any time of course, but it

Hmm... it used to, when I wrote that code.

> does make me wonder why we're bothering with this at all.  Maybe it's
> because of the possibility of a GFP_IO failure under your feet or
> something?

This is what happens:

 - we start inserting new item into balanced tree,

 - lock nodes on the leaf level and modify them

 - go to the parent level

 - lock nodes on the parent level and modify them. This may require
   allocating new nodes. If allocation fails---we have to panic, because
   tree is in inconsistent state and there is no roll-back; if allocation
   hangs forever---deadlock is on its way, because we are still keeping
   locks on nodes on the leaf level.

>
> What happens if reiser4 simply doesn't use this code?

At the time I tested it, it panicked after getting NULL from
__alloc_pages(). With current `do_retry' logic in __alloc_pages() it
will deadlock, I guess.

>
>
> If we introduce this mechanism, people will end up using it all over the
> place.  Probably we could remove radix_tree_preload(), which is the only
> similar code I can I can immediately think of.
>
> Page reservation is not a bad thing per-se, but it does need serious
> thought.
>
> How does reiser4 end up deciding how many pages to reserve?  Gross
> overkill?

Worst-case behavior of tree algorithms is well-known. Yes it's overkill.

Nikita.
