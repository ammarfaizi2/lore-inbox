Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268486AbUILG1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbUILG1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 02:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268488AbUILG1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 02:27:12 -0400
Received: from holomorphy.com ([207.189.100.168]:35971 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268486AbUILG1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 02:27:08 -0400
Date: Sat, 11 Sep 2004 23:27:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-ID: <20040912062703.GF2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet> <20040912045636.GA2660@holomorphy.com> <4143D07E.3030408@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4143D07E.3030408@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> No, it DTRT. Batching does not directly compensate for increases in
>> arrival rates, rather most directly compensates for increases to lock
>> transfer times, which do indeed increase on systems with large numbers
>> of cpus.

On Sun, Sep 12, 2004 at 02:28:46PM +1000, Nick Piggin wrote:
> Generally though I think you could expect the lru lock to be most
> often taken by the scanner by node local CPUs. Even on the big
> systems. We'll see.

No, I'd expect zone->lru_lock to be taken most often for lru_cache_add()
and lru_cache_del().


William Lee Irwin III wrote:
>> A 511 item pagevec is 4KB on 64-bit machines.

On Sun, Sep 12, 2004 at 02:28:46PM +1000, Nick Piggin wrote:
> Sure. And when you fill it with pages, they'll use up 32KB of dcache
> by using a single 64B line per page. Now that you've blown the cache,
> when you go to move those pages to another list, you'll have to pull
> them out of L2 again one at a time.

There can be no adequate compile-time metric of L1 cache size. 64B
cachelines with 16KB caches sounds a bit small, 256 entries, which is
even smaller than TLB's on various systems.

In general a hard cap at the L1 cache size would be beneficial for
operations done in tight loops, but there is no adequate detection
method. Also recall that the page structures things will be touched
regardless if they are there to be touched in a sufficiently large
pagevec.  Various pagevecs are meant to amortize locking done in
scenarios where there is no relationship between calls. Again,
lru_cache_add() and lru_cache_del() are the poster children. These
operations are often done for one page at a time in some long codepath,
e.g. fault handlers, and the pagevec is merely deferring the work until
enough has accumulated. radix_tree_gang_lookup() and mpage_readpages()
OTOH execute the operations to be done under the locks in tight loops,
where the lock acquisitions are to be done immediately by the same caller.

This differentiation between the characteristics of pagevec users
happily matches the cases where they're used on-stack and per-cpu.
In the former case, larger pagevecs are desirable, as the cachelines
will not be L1-hot regardless; in the latter, L1 size limits apply.


On Sun, Sep 12, 2004 at 02:28:46PM +1000, Nick Piggin wrote:
> OK, so a 511 item pagevec is pretty unlikely. How about a 64 item one
> with 128 byte cachelines, and you're touching two cachelines per
> page operation? That's 16K.

4*lg(NR_CPUS) is 64 for 16x-31x boxen. No constant number suffices.
Adaptation to systems and the usage cases would be an improvement.


-- wli
