Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286545AbRLUJPb>; Fri, 21 Dec 2001 04:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286532AbRLUJPM>; Fri, 21 Dec 2001 04:15:12 -0500
Received: from holomorphy.com ([216.36.33.161]:31104 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S286344AbRLUJPJ>;
	Fri, 21 Dec 2001 04:15:09 -0500
Date: Fri, 21 Dec 2001 01:14:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAX_MP_BUSSES increase
Message-ID: <20011221011453.A766@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011220235648.A1663@averell> <Pine.LNX.4.33.0112211113570.2196-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0112211113570.2196-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Dec 21, 2001 at 11:31:10AM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before trying to divorce the issues, I'd like to thank James for the
moral support. =)

On Fri, Dec 21, 2001 at 11:31:10AM +0100, Ingo Molnar wrote:
> yes, the current bootmem is a pretty effective linear allocator - you can
> even allocate 1 byte chunks without any space loss - and it's also a
> pretty simple allocator. During boot-time we allocate linearly in 99% of
> the cases. The only chance for some very minor loss is when the linear
> 'point of allocation' reaches a physical discontinuity and a bigger
> allocation has to skip over that point. For every such skipover (which
> skipover never happens with typical PCs, and it happens once with PCs that
> have lots of RAM) the 'loss' of RAM due to granularity is 2 KB. Plus
> deallocation can introduce fragmentation, the average cost for one
> fragment is 2KB. Almost no code frees bootmem (apart from the final
> freeing of bootmem), so this effect just does not happen on my box.

The page coalescing algorithm in the stock bootmem is designed only to
handle allocations in linear sequences. Which is probably the important
case. The extra generality in my code is something I'd like to call a bonus.

On Fri, Dec 21, 2001 at 11:31:10AM +0100, Ingo Molnar wrote:
> a tree structure will not avoid this 'skipping' loss either, in the
> majority of cases. (the basic reason for skipping is the need for a bigger
> chunk of RAM, and tree structure wont solve this.)

Essentially memory savings during boot-time reservations are minor if
present at all. They are seen, though. And your point here holds.

On Fri, Dec 21, 2001 at 11:31:10AM +0100, Ingo Molnar wrote:
> So i'm very doubtful about some of wli's claims about the RAM savings the
> tree changes bring - the 200 KB cited is i'd say physically impossible.
> The best-case would be 4 KB saved. And a tree data structure increases
> complexity significantly. (we had enough bugs in the current form of
> bootmem already.)

> I'd very much like if wli clarified this point - he knows his code, he
> should know the exact effect. In fact he should know the exact RAM
> allocation difference on his own box, with and without the tree-structure
> patch. It seems that this 'tree structure saves 200 KB' misinformation has
> stuck in people's mind to a certain degree. William?

200KB sounds extreme to me, and I don't recall mentioning that specific
number. The highest I've heard on i386 is 2MB, which was reported, but
almost implausible. ACPI on IA64 makes very heavy use of bootmem
allocations, which is where much larger space savings are seen, although
once again, compared to the total amount of system memory, it's very minor.
And I recall 3MB on IA64 Lion systems, though as I've been waiting for
feedback (even of this kind), I've not done tests there in a few weeks.

More than 4KB is seen. On i386 I have personally seen up to 12KB, and
see 8KB on my i386 machine at home without variation.

Essentially you have pointed out an error on my part, which is reporting
back a fairly implausible result that was reported to me without filtering
it for sanity.

On the other hand, I'm unclear on what tree-based bootmem has to do with
MAX_MP_BUSSES. Shall we take it to another thread? I'm interested in
discussing more about the tradeoffs involved with extent-based
representations of physical memory and where I can actively work to
simplify the interface to boot-time memory reservation, by whatever means.

And this has nothing to do with PCI busses.

Cheers,
Bill
