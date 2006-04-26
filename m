Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWDZNmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWDZNmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWDZNmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:42:16 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:42402 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932438AbWDZNmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:42:15 -0400
Message-ID: <444F78AB.6030803@sgi.com>
Date: Wed, 26 Apr 2006 15:42:03 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060223)
MIME-Version: 1.0
To: Dean Nelson <dcn@sgi.com>
CC: akpm@osdl.org, tony.luck@intel.com, avolkov@varma-el.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       paulus@samba.org, holt@sgi.com
Subject: Re: [PATCH] change gen_pool allocator to not touch managed memory
References: <444D1A7E.mailx85W11DZZU@aqua.americas.sgi.com> <20060424181626.09966912.akpm@osdl.org> <20060425155051.GA19248@sgi.com> <444F3990.5030100@sgi.com> <20060426132803.GA30360@sgi.com>
In-Reply-To: <20060426132803.GA30360@sgi.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dean Nelson wrote:
> On Wed, Apr 26, 2006 at 11:12:48AM +0200, Jes Sorensen wrote:
>> Dean Nelson wrote:
>>> +	if (nbytes > PAGE_SIZE) {
>>> +		chunk = vmalloc_node(nbytes, nid);
>>> +	} else {
>>> +		chunk = kmalloc_node(nbytes, GFP_KERNEL, nid);
>>> +	}
>> Any patch that adds vmalloc() calls to code always makes the little
>> hairs on the back of my neck stand up. Any chance we could get away with
>> alloc_pages_node() for this?
> 
> Is it the mapping of the pages that bothers you? If using alloc_pages_node()
> is the preferred way, I certainly can make the change. But if I do there is
> a greater potential that we may have to return failure to the caller of
> gen_pool_add(), that is if we can't get the necessary number of contiguous
> pages. Now granted the likelyhood that anyone would require more than a
> page for a bitmap is very very small. I'd say the vast majority of callers
> will end up using kmalloc_node(). I can go either way, just let me know
> whether I should make the change or not.

vmalloc mappings are $$$ on many archs so they should be avoided if in
any way possible. Also, kmalloc can handle more than just a page, and it
might be better to just use that here rather than alloc_pages actually
since I presume there is nothing preventing the bitmap sharing pages
with other data.

In this case I think adding the vmalloc call is overkill, I would simply
make it call kmalloc_node() unconditionally for all sizes and let it
fail if that situation occurs, given how unlikely it is.

>>> Index: linux-2.6/arch/ia64/sn/kernel/sn2/cache.c
>>> ===================================================================
>>> --- linux-2.6.orig/arch/ia64/sn/kernel/sn2/cache.c	2006-04-24 12:25:36.234717101 -0500
>>> +++ linux-2.6/arch/ia64/sn/kernel/sn2/cache.c	2006-04-24 12:27:56.012899026 -0500
>> This part we should maybe do in a seperate patch? It seems valid on it's
>> own?
> 
> I thought of this, but if this patch were separated out then the remaining
> patch would be dependent on it since the uncached allocator is being
> changed to call sn_flush_all_caches() with an uncached address.
> It certainly could be done, but is it worth the effort? Let me know
> how I should proceed with this.

I would expect this part of the patch to be able to go in as is,
straight away so I don't think it should be a problem. It's not a big
deal whether we do it one way or another to me.

Cheers,
Jes

