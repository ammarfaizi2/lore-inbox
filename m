Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268455AbUILFUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268455AbUILFUc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUILFUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:20:32 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:37022 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268455AbUILFUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:20:22 -0400
Message-ID: <4143D07E.3030408@yahoo.com.au>
Date: Sun, 12 Sep 2004 14:28:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet> <20040912045636.GA2660@holomorphy.com>
In-Reply-To: <20040912045636.GA2660@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> On Fri, Sep 10, 2004 at 02:49:15PM -0300, Marcelo Tosatti wrote:
> 
>>Oops, right. wli's patch is borked for NUMA. Clamping it at 64 should
>>do fine.
> 
> 
> No, it DTRT. Batching does not directly compensate for increases in
> arrival rates, rather most directly compensates for increases to lock
> transfer times, which do indeed increase on systems with large numbers
> of cpus.
> 

Generally though I think you could expect the lru lock to be most
often taken by the scanner by node local CPUs. Even on the big
systems. We'll see.

> 
> On Fri, Sep 10, 2004 at 02:56:11PM +1000, Nick Piggin wrote:
> 
>>>Secondly is that you'll might really start putting pressure on small L1
>>>caches (eg. Itanium 2) if you bite off too much in one go. If you blow
>>>it, you'll have to pull all the pages into cache again as you process
>>>the pagevec.
> 
> 
> On Fri, Sep 10, 2004 at 02:49:15PM -0300, Marcelo Tosatti wrote:
> 
>>Whats the L1 cache size of Itanium2? Each page is huge compared to the pagevec
>>structure (you need a 64 item pagevec array on 64-bits to occupy the space of 
>>one 4KB page). So I think you wont blow up the cache even with a really big 
>>pagevec.
> 
> 
> A 511 item pagevec is 4KB on 64-bit machines.
> 

Sure. And when you fill it with pages, they'll use up 32KB of dcache
by using a single 64B line per page. Now that you've blown the cache,
when you go to move those pages to another list, you'll have to pull
them out of L2 again one at a time.

OK, so a 511 item pagevec is pretty unlikely. How about a 64 item one
with 128 byte cachelines, and you're touching two cachelines per
page operation? That's 16K.
