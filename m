Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311176AbSCPWbF>; Sat, 16 Mar 2002 17:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311175AbSCPWa4>; Sat, 16 Mar 2002 17:30:56 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:19403 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311176AbSCPWap>;
	Sat, 16 Mar 2002 17:30:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Date: Sat, 16 Mar 2002 23:25:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203161046400.31913-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203161046400.31913-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16mMcT-0000m9-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 16, 2002 08:01 pm, Linus Torvalds wrote:
> On Sat, 16 Mar 2002, Daniel Phillips wrote:
> > It could be a lot more abstract than that.  Chuck Cranor's UVM (which 
> > seems to bear some sort of filial relationship to the FreeBSD VM) buries 
> > all  accesses to the page table behind a 'pmap' API, and implements the 
> > standard Unix VM semantics at the 'memory object' level.
> 
> Who knows, maybe we'll change the abstraction in Linux some day too.. 
> However, I personally tend to prefer "thin" abstractions that don't hide 
> details.
> 
> The problem with the thick abstractions ("high level") is that they often
> lead you down the wrong path. You start thinking that it's really cheap to
> share partial address spaces etc ("hey, I just map this 'memory object'
> into another process, and it's just a matter of one linked list operation
> and incrementing a reference ount").

My opinion, which I implied in the previous post but didn't state in so many 
words, is that the whole Real Unix crowd - Chuck Cranor and Matt Dillon, Sun, 
SGI and IBM etc - got off on the wrong track with respect to implementing 
Unix VM semantics, and that we will achieve all the design goals they set for 
themselves in a simpler, more efficient way.  (That is, assuming I ever 
finish debugging the page table sharing[1] and extend it to shared mmaps.)  I 
attribute that whole wrong turn to a too-heavy abstraction of the page table, 
distracting the eye from the observation that the page table itself provides 
sufficient state to do the same job as memory objects.  I'm curious to hear 
Matt's opinion on that by the way, I have to go bother him about this.

> Until you realize that the actual sharing still implies a TLB switch 
> between the two "threads", and that you need to instantiate the TLB in 
> both processes etc. And suddenly that instantiation is actually the _real_ 
> cost - and your clever highlevel abstraction was actually a lot more 
> expensive than you realized.

Well I don't have any problem with the TLB cost being hidden, what bothers me 
is the complexity of the mechanism required to make the abstraction work.  
Sort-of work I mean, just google 'all-shadowed case' to see one nasty 
difficulty.

> [ Side note: I'm very biased by reality. In theory, a non-page-table based 
>   approach which used only a front-side TLB and a fast lookup into higher- 
>   level abstractions might be a really nice setup. However, in practice, 
>   the world is 99%+ based on hardware that natively looks up the TLB in a 
>   tree, and is really good at it too.  So I'm biased. I'd rather do good 
>   on the 99% than care about some theoretical 1% ]

It breaks down somewhat as virtual memory range goes way beyond 4GB.  
There's the relatively minor issue of extra levels of tree traversal, 
currently limited to 4 by AMD's architecture but not so limited on other 
architectures.  A bigger problem is what to do about internal fragmentation 
in the page table tree, say if somebody mmaps a 2 TB sparse file, then writes 
one byte every 2 meg.  Bang, 4 gig worth of page tables, this is probably not 
what we want.  IMHO, 'don't do that then' isn't a reasonable response.

What we might want to do there is evict some page tables when they start 
proliferating too much, and that's when we find out we have no good model for 
doing that.  I think this needs to be looked at.

[1] I finally got a little more work done on it today

-- 
Daniel
