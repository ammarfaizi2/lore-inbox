Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTKYE6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 23:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTKYE6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 23:58:37 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:42199 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261947AbTKYE6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 23:58:35 -0500
Date: Mon, 24 Nov 2003 20:58:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] Make balance_dirty_pages zone aware (1/2)
Message-ID: <1070800000.1069736303@[10.10.2.4]>
In-Reply-To: <20031124170506.4024bb30.akpm@osdl.org>
References: <3FBEB27D.5010007@us.ibm.com><20031123143627.1754a3f0.akpm@osdl.org><1034580000.1069688202@[10.10.2.4]><20031124100043.5416ed4c.akpm@osdl.org><39670000.1069719009@flay> <20031124170506.4024bb30.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well ... not so sure of this as I once was ... so be gentle with me ;-)
>> But if the system has been running for a while, memory is full of pagecache,
>> etc. We try to allocate from the local node, fail, and fall back to the
>> other nodes, which are all full as well. Then we wake up kswapd, but all
>> pages in this node are dirty, so we block for ages on writeout, making 
>> mem allocate really latent and slow (which was presumably what
>> balance_dirty_pages was there to solve in the first place). 
> 
> It is possible.  You'd be pretty unlucky to dirty so much lowmem when there
> is such a huge amount of highmem floating about, but yes, if you tried hard
> enough...

I'm not really worried about lowmem vs highem - that was almost an 
afterthought. I'm more worried about the NUMA bit - it's easy to fill
one node's memory completely with dirty pages by just a writer running 
on that node.
 
> I have a feeling that some observed problem must have prompted this coding
> frenzy from Matthew.  Surely some problem was observed, and this patch
> fixed it up??

No, just an observation whilst looking at balance_dirty_pages, that it's
not working as intended on NUMA. It's just easy to goad Matt into a frenzy,
I guess ;-) ;-)

"dd if=/dev/zero of=foo" would trigger it, I'd think. Watching the IO
rate, it should go wierd after ram is full (on a 3 or more node system, 
so there's < 40% of RAM for each node). Yeah, I know you're going to give
me crap for not actually trying it  ... and rightly so ... but it just
seemed so obvious ... ;-) 

>> > If we make the dirty threshold a proportion of the initial amount of free
>> > memory in ZONE_NORMAL, as is done in 2.4 it will not be possible to fill
>> > any node with dirty pages.
>> 
>> True. But that seems a bit extreme for a system with 64GB of RAM, and only
>> 896Mb in ZONE_NORMAL ;-) Doesn't really seem like the right way to fix it.
>> 
> 
> Increasing /proc/sys/vm/lower_zone_protection can be used to teach the VM
> to not use lowmem for pagecache.  Does this solve the elusive problem too?

Don't think so - see comment above re NUMA.

M.

