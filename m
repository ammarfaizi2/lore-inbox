Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268497AbUILGz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268497AbUILGz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 02:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268501AbUILGz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 02:55:28 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:30577 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268497AbUILGzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 02:55:24 -0400
Message-ID: <4143E6C6.40908@yahoo.com.au>
Date: Sun, 12 Sep 2004 16:03:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet> <20040912045636.GA2660@holomorphy.com> <4143D07E.3030408@yahoo.com.au> <20040912062703.GF2660@holomorphy.com>
In-Reply-To: <20040912062703.GF2660@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>No, it DTRT. Batching does not directly compensate for increases in
>>>arrival rates, rather most directly compensates for increases to lock
>>>transfer times, which do indeed increase on systems with large numbers
>>>of cpus.
> 
> 
> On Sun, Sep 12, 2004 at 02:28:46PM +1000, Nick Piggin wrote:
> 
>>Generally though I think you could expect the lru lock to be most
>>often taken by the scanner by node local CPUs. Even on the big
>>systems. We'll see.
> 
> 
> No, I'd expect zone->lru_lock to be taken most often for lru_cache_add()
> and lru_cache_del().
> 

Well "lru_cache_del" will be often coming from the scanner.
lru_cache_add should be being performed on newly allocated pages,
which should be node local most of the time.

> 
> William Lee Irwin III wrote:
> 
>>>A 511 item pagevec is 4KB on 64-bit machines.
> 
> 
> On Sun, Sep 12, 2004 at 02:28:46PM +1000, Nick Piggin wrote:
> 
>>Sure. And when you fill it with pages, they'll use up 32KB of dcache
>>by using a single 64B line per page. Now that you've blown the cache,
>>when you go to move those pages to another list, you'll have to pull
>>them out of L2 again one at a time.
> 
> 
> There can be no adequate compile-time metric of L1 cache size. 64B
> cachelines with 16KB caches sounds a bit small, 256 entries, which is
> even smaller than TLB's on various systems.
> 

Although I'm pretty sure that is what Itanium 2 has. P4s may even
have 128B lines and 16K L1 IIRC.

> In general a hard cap at the L1 cache size would be beneficial for
> operations done in tight loops, but there is no adequate detection
> method. Also recall that the page structures things will be touched
> regardless if they are there to be touched in a sufficiently large
> pagevec.  Various pagevecs are meant to amortize locking done in
> scenarios where there is no relationship between calls. Again,
> lru_cache_add() and lru_cache_del() are the poster children. These
> operations are often done for one page at a time in some long codepath,
> e.g. fault handlers, and the pagevec is merely deferring the work until
> enough has accumulated. radix_tree_gang_lookup() and mpage_readpages()
> OTOH execute the operations to be done under the locks in tight loops,
> where the lock acquisitions are to be done immediately by the same caller.
> 
> This differentiation between the characteristics of pagevec users
> happily matches the cases where they're used on-stack and per-cpu.
> In the former case, larger pagevecs are desirable, as the cachelines
> will not be L1-hot regardless; in the latter, L1 size limits apply.
> 

Possibly, I don't know. Performing a large stream of faults to
map in a file could easily keep all pages of a small pagevec
in cache.

Anyway, the point I'm making is just that you don't want to be
expanding this thing just because you can. If all else is equal,
a smaller size is obviously preferable. So obviously, simple
testing is required - but I don't think I need to be telling you
that ;)

> 
> On Sun, Sep 12, 2004 at 02:28:46PM +1000, Nick Piggin wrote:
> 
>>OK, so a 511 item pagevec is pretty unlikely. How about a 64 item one
>>with 128 byte cachelines, and you're touching two cachelines per
>>page operation? That's 16K.
> 
> 
> 4*lg(NR_CPUS) is 64 for 16x-31x boxen. No constant number suffices.
> Adaptation to systems and the usage cases would be an improvement.
> 

Ignore my comments about disliking compile time sizing: the main
thing is to just find improvements, and merge-worthy implementation
can follow.
