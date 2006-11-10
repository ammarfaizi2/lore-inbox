Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945990AbWKJGsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945990AbWKJGsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945991AbWKJGsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:48:40 -0500
Received: from ns1.suse.de ([195.135.220.2]:6090 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1945990AbWKJGsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:48:39 -0500
From: Andi Kleen <ak@suse.de>
To: Amul Shah <amul.shah@unisys.com>
Subject: Re: [PATCH] x86_64: Make the NUMA hash function nodemap allocation dynamic and remove NODEMAPSIZE
Date: Fri, 10 Nov 2006 07:48:30 +0100
User-Agent: KMail/1.9.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <1163029076.3553.36.camel@ustr-linux-shaha1.unisys.com>
In-Reply-To: <1163029076.3553.36.camel@ustr-linux-shaha1.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611100748.30889.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -uprN linux-2.6.19-rc4/arch/x86_64/kernel/e820.c linux-2.6.19-rc4-az/arch/x86_64/kernel/e820.c
> --- linux-2.6.19-rc4/arch/x86_64/kernel/e820.c	2006-10-31 17:38:41.000000000 -0500
> +++ linux-2.6.19-rc4-az/arch/x86_64/kernel/e820.c	2006-11-08 17:55:48.000000000 -0500
> @@ -83,6 +83,12 @@ static inline int bad_addr(unsigned long
>  		return 1;
>  	}
>  
> +	/* NUMA memory to node map */
> +	if (last >= nodemap_addr && addr < nodemap_addr + nodemap_size) {
> +		*addrp = nodemap_addr + nodemap_size;
> +		return 1;
> +	}

Using the e820 allocator will now mean it's rounded up to pages.
That will waste a bit of memory, but i suppose it's ok.

> +	for (i=20; !(bitfield&(1UL << i)) && i<BITS_PER_LONG; i++);

That's find_first_bit() ?  Please use that

>  
> +	shift = extract_lsb_from_nodes(nodes, numnodes);
> +	if ( allocate_cachealigned_memnodemap() )

No extra spaces here please (and in some other places)


> +	u8 *map;
> +	u8 zero;

zero?

>  } ____cacheline_aligned;
>  extern struct memnode memnode;
>  #define memnode_shift memnode.shift
>  #define memnodemap memnode.map
> +#define memnodemapsize memnode.mapsize

Have you checked how much the code .text size changes because
of the pointer reference? If it's a lot phys_to_nid might need to 
be out of lined.

-Andi
