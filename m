Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWGSDVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWGSDVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 23:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWGSDVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 23:21:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:32957 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932482AbWGSDVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 23:21:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ccJk3CUzfTIxF6DBSUuXsGy8C9oi4ppE14znssu379j0iahwkLDqQSL34W42G6WMMfmgIgItgpwn7gwft7xNuCRwBNjQILiKA/yPRngbnhJGP8aE5Zc6fbws0BTheHEDD3TlqWazOGQbzuCxq3VM8eKbHvnUzD0SW18LWop5UlU=
Message-ID: <4df04b840607182021hecef3b6v24c4794444a8e53c@mail.gmail.com>
Date: Wed, 19 Jul 2006 11:21:53 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: Improvement on memory subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <84144f020607180925s62e6a7abvbaf66c672849170b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
	 <84144f020607180925s62e6a7abvbaf66c672849170b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/7/19, Pekka Enberg <penberg@cs.helsinki.fi>:
> On 7/18/06, yunfeng zhang <zyf.zeroos@gmail.com> wrote:
> > 3. All slabs are all off-slab type. Store slab instance in page structure.
>
> Not sure what you mean. We need much more than sizeof(struct page) for
> slab management. Hmm?
>

Current page struct is just like this
struct page {
	unsigned long flags;
	atomic_t _count;
	atomic_t _mapcount;
	union {
		struct {
			unsigned long private;
			struct address_space *mapping;
		};
#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
		spinlock_t ptl;
#endif
	};
	pgoff_t index;
	struct list_head lru;
#if defined(WANT_PAGE_VIRTUAL)
	void *virtual;
#endif /* WANT_PAGE_VIRTUAL */
};
Most fields in the page structure is used for user page, to a core
slab page, these aren't touched at all.
So I think we should define a union
struct page {
	unsigned long flags;
	struct slab {
		struct list_head list;
		unsigned long colouroff;
		void *s_mem;
		unsigned int inuse;
		kmem_bufctl_t free;
		unsigned short nodeid;
	};
};
