Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVKIX25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVKIX25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbVKIX25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:28:57 -0500
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:17006 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750978AbVKIX25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:28:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DgIl6xNgFWW/NzpqfBFlQqbUUgQfAusKDH2Cu8IQlUP9lNMinr5zORuaCCyaKDtZZKbHHwqLjGMphMwtMKydT9tV1YfJSQF5fWm2aLw7bkoJJfzxallUkLHJ8MJb7cew9SqhaolR0zqzhKvKBNpdlKiBwILO6B4yvCvRgKCLFdM=  ;
Message-ID: <437286BD.4000107@yahoo.com.au>
Date: Thu, 10 Nov 2005 10:31:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 04/16] radix-tree: look-aside cache
References: <20051109134938.757187000@localhost.localdomain> <20051109141448.974675000@localhost.localdomain>
In-Reply-To: <20051109141448.974675000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> This introduces a set of lookup functions to radix tree for the read-ahead
> logic.  Other access patterns with high locality may also benefit from them.
> 

Hi Wu,

Does this cache add much performance compared with simple repeated
lookups? If the access patterns are highly local, the top of the
radix tree should be in cache.

I worry that it is a fair bit of extra complexity for something
slow like the IO path - however I haven't looked at how you use the
cache.

> Most of them are best inlined, so some macros/structs in .c are moved into .h.
> 

I would not inline them. You'd find that the extra icache misses
that costs outweighs the improvements for larger functions.

> +
> +struct radix_tree_node {
> +	unsigned int	count;
> +	void		*slots[RADIX_TREE_MAP_SIZE];
> +	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
> +};
> +

Would be much nicer if this weren't declared in the header file, so
people don't start trying to use the nodes where they shouldn't.
This ought to be possible after uninlining a couple of things.

>  struct radix_tree_root {
>  	unsigned int		height;
>  	gfp_t			gfp_mask;
>  	struct radix_tree_node	*rnode;
>  };
>  
> +/*
> + * Support access patterns with strong locality.
> + */

Do you think you could provide a simple 'use case' for an overview
of how you use the cache and what calls to make?

> +struct radix_tree_cache {
> +	unsigned long first_index;
> +	struct radix_tree_node *tree_node;
> +};
> +

> +static inline void radix_tree_cache_init(struct radix_tree_cache *cache)
> +{
> +	cache->first_index = 0x77;
> +	cache->tree_node = NULL;
> +}
> +
> +static inline int radix_tree_cache_size(struct radix_tree_cache *cache)
> +{
> +	return RADIX_TREE_MAP_SIZE;
> +}
> +
> +static inline int radix_tree_cache_count(struct radix_tree_cache *cache)
> +{
> +	if (cache->first_index != 0x77)
> +		return cache->tree_node->count;
> +	else
> +		return 0;
> +}
> +

What's 0x77 for? And what happens if your cache gets big enough that
the first index is 0x77?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
