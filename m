Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292888AbSCPTER>; Sat, 16 Mar 2002 14:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310422AbSCPTEI>; Sat, 16 Mar 2002 14:04:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15367 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310402AbSCPTDz>; Sat, 16 Mar 2002 14:03:55 -0500
Date: Sat, 16 Mar 2002 11:01:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <E16mG2N-0000d7-00@starship>
Message-ID: <Pine.LNX.4.33.0203161046400.31913-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002, Daniel Phillips wrote:
> 
> I meant that the functions are hardwired to the tree structure, which they 
> certainly are

Oh yes.

Sure, you can abstract the VM stuff much more - and many people do, to the 
point of actually having a per-architecture VM with very little shared 
information.

The thing I like about the explicit tree is that while it _is_ an abstract 
data structure, it's also a data structure that people are very aware of 
how it maps to the actual hardware, which means that the abstraction 
doesn't come with a performance penalty. 

(There are two kinds of performance penalties in abstractions: (a) just 
the translation overhead for compilers etc, and (b) the _mental_ overhead 
of doing the wrong thing because you don't think of what it actually means 
in terms of hardware).

Now, the linux tree abstraction is obviously _so_ close to a common set of
hardware that many people don't realize at all that it's really meant to
be an abstraction (albeit one with a good mapping to reality).

> It could be a lot more abstract than that.  Chuck Cranor's UVM (which seems 
> to bear some sort of filial relationship to the FreeBSD VM) buries all 
> accesses to the page table behind a 'pmap' API, and implements the standard 
> Unix VM semantics at the 'memory object' level.

Who knows, maybe we'll change the abstraction in Linux some day too.. 
However, I personally tend to prefer "thin" abstractions that don't hide 
details.

The problem with the thick abstractions ("high level") is that they often
lead you down the wrong path. You start thinking that it's really cheap to
share partial address spaces etc ("hey, I just map this 'memory object'
into another process, and it's just a matter of one linked list operation
and incrementing a reference ount").

Until you realize that the actual sharing still implies a TLB switch 
between the two "threads", and that you need to instantiate the TLB in 
both processes etc. And suddenly that instantiation is actually the _real_ 
cost - and your clever highlevel abstraction was actually a lot more 
expensive than you realized.

[ Side note: I'm very biased by reality. In theory, a non-page-table based 
  approach which used only a front-side TLB and a fast lookup into higher- 
  level abstractions might be a really nice setup. However, in practice, 
  the world is 99%+ based on hardware that natively looks up the TLB in a 
  tree, and is really good at it too.  So I'm biased. I'd rather do good 
  on the 99% than care about some theoretical 1% ]

			Linus

