Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312944AbSDMLdh>; Sat, 13 Apr 2002 07:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313093AbSDMLdg>; Sat, 13 Apr 2002 07:33:36 -0400
Received: from imladris.infradead.org ([194.205.184.45]:14088 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312944AbSDMLdg>; Sat, 13 Apr 2002 07:33:36 -0400
Date: Sat, 13 Apr 2002 12:32:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] don't allocate ratnodes under PF_MEMALLOC
Message-ID: <20020413123244.A4470@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CB7D75F.FEE95D28@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  
>  /*
> + * On the swap_out path, the radix-tree node allocations are performing
> + * GFP_ATOMIC allocations under PF_MEMALLOC.  They can completely
> + * exhaust the page allocator.  This is bad; some pages should be left
> + * available for the I/O system to start sending the swapcache contents
> + * to disk.
> + *
> + * So PF_MEMALLOC is dropped here.  This causes the slab allocations to fail
> + * earlier, so radix-tree nodes will then be allocated from the mempool
> + * reserves.
> + */
> +static inline int
> +swap_out_add_to_swap_cache(struct page *page, swp_entry_t entry)
> +{
> +	int flags = current->flags;
> +	int ret;
> +
> +	current->flags &= ~PF_MEMALLOC;
> +	ret = add_to_swap_cache(page, entry);
> +	current->flags = flags;
> +	return ret;
> +}

I don't like this soloution very - I think porting th add_to_swap() logic
from -rmap and implementing the flags fiddling in that function makes
more sense.  I will do so once a -pre4 is out to resync.

	Christoph

