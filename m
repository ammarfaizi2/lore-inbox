Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTKYUuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTKYUuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:50:13 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:30877 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263014AbTKYUuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:50:06 -0500
Date: Tue, 25 Nov 2003 14:48:14 -0600
From: Jack Steiner <steiner@sgi.com>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       "William Lee Irwin, III" <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: Re: hash table sizes
Message-ID: <20031125204814.GA19397@sgi.com>
References: <16323.23221.835676.999857@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16323.23221.835676.999857@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 08:35:49AM -0500, Jes Sorensen wrote:
> Hi,
> 
> On NUMA systems with way too much memory, the current algorithms for
> determining the size of the inode and dentry hash tables ends up trying
> to allocate tables that are so big they may not fit within the physical
> memory of a single node. Ie. on a 256 node system with 512GB of RAM with
> 16KB pages it basically ends up eating up all the memory on node before
> completing a boot because of this. The inode and dentry hashes are 256MB
> each and the IP routing table hash is 128MB.
> 
> I have tried changing the algorithm as below and it seems to produce
> reasonable results and almost identical numbers for the smaller /
> mid-sized configs I looked at.
> 
> This is not meant to be a final patch, any input/oppinion is welcome.
> 
> Thanks,
> Jes
> 
...

> +	mempages >>= (23 - (PAGE_SHIFT - 1));
> +	order = max(2, fls(mempages));
> +	order = min(12, order);
>  

I dont think you want to constrain the allocation to a specific "order". Otherwise,
when the kernel is built with a 64k pagesize, the size of the caches will increase 4X.

Some architectures (IA64, for example) dont have severe limitations on usage of vmalloc
space. Would it make sense to use vmalloc on these architectures. Even if the
max size of the structures being allocated is limited to an acceptible size, it still
concentrates the memory on a single node. In general, we should try to
distribute the memory references across as many nodes as possible - at least in theory. 
(In practice, I wonder if we could actually measure the difference.....)


BTW, I think the network code (tcp_init()) has similar problems.

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


