Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbVKDGij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbVKDGij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 01:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbVKDGij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 01:38:39 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:9102 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161084AbVKDGii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 01:38:38 -0500
Date: Fri, 4 Nov 2005 07:38:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, andy@thermo.lanl.gov,
       mbligh@mbligh.org, akpm@osdl.org, arjan@infradead.org,
       arjanv@infradead.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mel@csn.ul.ie, nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051104063820.GA19505@elte.hu>
References: <20051104010021.4180A184531@thermo.lanl.gov> <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org> <20051103221037.33ae0f53.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103221037.33ae0f53.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> Linus wrote:
> > Maybe you'd be willing on compromising by using a few kernel boot-time 
> > command line options for your not-very-common load.
> 
> If we were only a few options away from running Andy's varying load 
> mix with something close to ideal performance, we'd be in fat city, 
> and Andy would never have been driven to write that rant.
> 
> There's more to it than that, but it is not as impossible as a battery 
> with the efficiencies you (and the rest of us) dream of.

just to make sure i didnt get it wrong, wouldnt we get most of the 
benefits Andy is seeking by having a: boot-time option which sets aside 
a "hugetlb zone", with an additional sysctl to grow (or shrink) the pool 
- with the growing happening on a best-effort basis, without guarantees?

i have implemented precisely such a scheme for 'bigpages' years ago, and 
it worked reasonably well. (i was lazy and didnt implement it as a 
resizable zone, but as a list of large pages taken straight off the 
buddy allocator. This made dynamic resizing really easy and i didnt have 
to muck with the buddy and mem_map[] data structures that zone-resizing 
forces us to do. It had the disadvantage of those pages skewing the 
memory balance of the affected zone.)

my quick solution was good enough that on a test-system i could resize 
the pool across Oracle test-runs, when the box was otherwise quiet. I'd 
expect a well-controlled HPC system to be equally resizable.

what we cannot offer is a guarantee to be able to grow the pool. Hence 
the /proc mechanism would be called:

	/proc/sys/vm/try_to_grow_hugemem_pool

to clearly stress the 'might easily fail' restriction. But if userspace 
is well-behaved on Andy's systems (which it seems to be), then in 
practice it should be resizable. On a generic system, only the boot-time 
option is guaranteed to allocate as much RAM as possible. And once this 
functionality has been clearly communicated and separated, the 'try to 
alloc a large page' thing could become more agressive: it could attempt 
to construct large pages if it can.

i dont think we object to such a capability, as long as the restrictions 
are clearly communicated. (and no, that doesnt mean some obscure 
Documentation/ entry - the restrictions have to be obvious from the 
primary way of usage. I.e. no /proc/sys/vm/hugemem_pool_size thing where 
growing could fail.)

	Ingo
