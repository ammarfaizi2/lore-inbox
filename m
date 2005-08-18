Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVHRHPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVHRHPA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 03:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVHRHPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 03:15:00 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:25297 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750823AbVHRHO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 03:14:59 -0400
Message-ID: <43043567.3040204@cosmosbay.com>
Date: Thu, 18 Aug 2005 09:14:47 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: ak@suse.de, bcrl@linux.intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct file cleanup : the very large file_ra_state is
 now allocated only on demand.
References: <20050817215357.GU3996@wotan.suse.de>	<4303D90E.2030103@cosmosbay.com>	<20050818010524.GW3996@wotan.suse.de> <20050817.194315.111196480.davem@davemloft.net>
In-Reply-To: <20050817.194315.111196480.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [62.23.185.226]); Thu, 18 Aug 2005 09:14:53 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller a écrit :
> From: Andi Kleen <ak@suse.de>
> Date: Thu, 18 Aug 2005 03:05:25 +0200
> 
> 
>>I would just set the ra pointer to a single global structure if the
>>allocation fails. Then you can avoid all the other checks. It will
>>slow down things and trash some state, but not fail and nobody
>>should expect good performance after out of memory anyways. The only
>>check still needed would be on freeing.
> 
> 
> I would think twice about that due to repeatability concerns.  Yes, we
> should care less when memory is so low, but if we can avoid this kind
> of scenerio easily we should.
> 
> Having said that, I would like to recommend looking into a scheme
> where the path leading to the filp allocation states whether the
> read-ahead bits are needed or not.  This has two benefits:
> 
> 1) Repeatability, and error signalling at the correct place
>    should the memory allocation fail.
> 
> 2) We can avoid the pointer dereference overhead.  The read-ahead
>    state is always at (filp + 1).  Macro'ized or static inline
>    function'ized interfaces for this access can make it look
>    clean and perhaps even implement debugging of the case where
>    we try to get at the read-ahead state for a non-read-ahead
>    filp.
> 
> I do really think that would be a better approach.  A quick glance
> shows that it should be easy to propagate the "need_read_ahead"
> state, just by passing a boolean to get_unused_fd() via
> sock_map_fd().

Thanks David and Andi

Hum... get_unused_fd() allocates a file descriptor, not a 'struct file *'
Maybe you meant get_empty_filp(void), that we might change to get_empty_filp(int need_read_ahead)

After reading your suggestions, I understand we still need two slabs.
One (filp_cachep) without the readahead data, the other one (filp_ra_cachep) with it.

static inline struct file_ra_state *get_ra_state(struct file *f)
{
#ifdef CONFIG_DEBUG_READAHEAD
	BUG_ON(filp_ra_cachep != GET_PAGE_CACHE(virt_to_page(f)));
#endif
	return (struct file_ra_state *)(f+1);
}


struct file *get_empty_filp(int need_read_ahead)
{
	struct file *f;
	...
	f = kmem_cache_alloc(need_read_ahead ? filp_ra_cachep : filp_cachep, GFP_KERNEL);
	if (f == NULL)
		goto fail;
	memset(f, 0, need_read_ahead ? sizeof(struct file) : sizeof(struct file) + sizeof(struct file_ra_state));
	...
}

file_free() then call kfree() that should find the right kmem_cache_t *

static inline void file_free(struct file *f)
{
	kfree(f);
}


I will provide a new version of the patch in a later mail

Eric
