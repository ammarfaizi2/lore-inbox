Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUDGSLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbUDGSL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:11:26 -0400
Received: from waste.org ([209.173.204.2]:17802 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264056AbUDGSLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:11:03 -0400
Date: Wed, 7 Apr 2004 13:10:45 -0500
From: Matt Mackall <mpm@selenic.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink core hashes on small systems
Message-ID: <20040407181044.GV6248@waste.org>
References: <20040405204957.GF6248@waste.org> <20040405140223.2f775da4.akpm@osdl.org> <20040405211916.GH6248@waste.org> <20040405143824.7f9b7020.akpm@osdl.org> <20040407052103.GB8738@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407052103.GB8738@logos.cnet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 02:21:03AM -0300, Marcelo Tosatti wrote:
> On Mon, Apr 05, 2004 at 02:38:24PM -0700, Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:
> > >
> > > Longer term, I think some serious thought needs to go into scaling
> > > hash sizes across the board, but this serves my purposes on the
> > > low-end without changing behaviour asymptotically.
> > 
> > Can we make longer-term a bit shorter?  init_per_zone_pages_min() only took
> > a few minutes thinking..
> > 
> > I suspect what we need is to replace num_physpages with nr_free_pages(),
> > then account for PAGE_SIZE, then muck around with sqrt() for a while then
> > apply upper and lower bounds to it.
> > 
> > That hard-wired breakpoint seems just too arbitrary to me - some sort of
> > graduated thing which has a little thought and explanation behind it would
> > be preferred please.
> 
> Hi,
> 
> Arjan told me his changes were not to allow orders higher than 5 
> (thus maximizing hash table size to 128K) to avoid possible cache thrashing.
> 
> I've done some tests with dbench during the day with different
> dentry hash table sizes, here are the results on a 2-way P4 2GB box
> (default of 1MB hashtable).
> 
> I ran three consecutive dbenchs (with 32 clients) each reboot (each
> line), and then six consecutive dbenchs on the last run.
> 
> Output is "Mb/s" output from dbench 2.1.
> 
> 128K dentry hashtable:
> 
> 160 145 155
> 152 147 148
> 170 132 132 156 154 127
> 
> 512K dentry hashtable:
> 
> 156 135 144
> 153 146 159
> 157 135 148 149 148 143
> 
> 1Mb dentry hashtable:
> 
> 167 127 139
> 160 144 139
> 144 137 162 153 132 121
> 
> Not much of noticeable difference between them. I was told
> SPECWeb benefits from big hash tables. Any other recommended test? 
> I have no access to SPECWeb. 
> 
> Testing the different hash sizes is not trivial because there are 
> so many different workloads...
> 
> Another thing is we allow the cache to grow too big: 1MB for 2GB, 
> 4Mb for 32Gb, 8Mb for 64Gb (on 32-bit, twice as much on 64-bit). 
> 
> What about the following patch to calculate the sizes of the VFS 
> caches based on more correct variables.
> 
> It might be good to shrink the caches a half (passing "4" instead of "3" to  
> vfs_cache_size() does it). We gain lowmem pinned memory and dont seem 
> to loose performance. Help with testing is very much appreciated.

I'm working on something similar, core code below.
 
> PS: Another improvement which might be interesting is non-power-of-2
> allocations? That would make the increase on the cache size
> "smoother" when memory size increases. AFAICS we dont do that
> because of our allocator is limited.

The other problem is hash functions frequently take advantage of bit
masking to wrap results so powers of two is nice.


My hash-sizing code:

/* calc_hash_order - calculate the page order for a hash table
 * @loworder: smallest allowed hash order
 * @lowpages: keep hash size minimal below this number of pages
 * @hiorder: largest order for linear growth
 * @hipages: point at which to switch to logarithmic growth
 * @pages: number of available pages
 *
 * This calculates the page order for hash tables. It uses linear
 * interpolation for memory sizes between lowpages and hipages and
 * then switches to a logarithmic algorithm. For every factor of 10
 * pages beyond hipages, the hash order is increased by 1. The
 * logarithmic piece is used to future-proof the code on large boxes.
 *
 */

int calc_hash_order(int loworder, unsigned long lowpages,
		    int hiorder, unsigned long hipages, unsigned long pages)
{
	unsigned long lowhash = 1<<loworder, hihash = 1<<hiorder, hash, order;

	if (pages <= hipages) {
		/* linear interpolation on hash sizes, not hash order */
		hash = minhash + ((pages - lopages) * (lowhash - hihash) /
				  (lowpages - hipages));
		order = ffs(hash);
	} else {
		/* for every factor of 10 beyond hipages, increase order
		   by one */
		for (order = hiorder; pages > hipages; pages /= 10)
			order++;
	}

	/* clip order range */
	return max(minorder, order);
}


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
