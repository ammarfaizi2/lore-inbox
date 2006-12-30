Return-Path: <linux-kernel-owner+w=401wt.eu-S1753172AbWL3AMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbWL3AMM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 19:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755078AbWL3AML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 19:12:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35513 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbWL3AMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 19:12:10 -0500
Date: Fri, 29 Dec 2006 16:11:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
In-Reply-To: <20061229155118.3feb0c17.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612291559540.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
 <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
 <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
 <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org> <20061229141632.51c8c080.akpm@osdl.org>
 <Pine.LNX.4.64.0612291431200.4473@woody.osdl.org> <20061229155118.3feb0c17.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Andrew Morton wrote:
> 
> They're extra.  As in "can be optimised away".

Sure. Don't use buffer heads.

> The buffer_head is not an IO container.  It is the kernel's core
> representation of a disk block.

Please come back from the 90's.

The buffer heads are nothing but a mapping of where the hardware block is. 
If you use it for anything else, you're basically screwed.

> JBD implements physical block-based journalling, so it is 100% appropriate
> that JBD deal with these disk blocks using their buffer_head
> representation.

And as long as it does that, you just have to face the fact that it's 
going to perform like crap, including what you call "extra" writes, and 
what I call "deal with it".

Btw, you can make pages be physically indexed too, but they obviously
 (a) won't be coherent with any virtual mapping laid on top of it
 (b) will be _physical_, so any readahead etc will be based on physical 
     addresses too.

> I thought I fixed the performance problem?

No, you papered over it, for the reasonably common case where things were 
physically contiguous - exactly by using a physical page cache, so now it 
can do read-ahead based on that. Then, because the pages contain buffer 
heads, the directory accesses can look up buffers, and if it was all 
physically contiguous, it all works fine.

But if you actually want virtualluy indexed caching (and all _users_ want 
it), it really doesn't work.

> Somewhat nastily, but as ext3 directories are metadata it is appropriate
> that modifications to them be done in terms of buffer_heads (ie: blocks).

No. There is nothing "appropriate" about using buffer_heads for metadata. 

It's quite proper - and a hell of a lot more efficient - to use virtual 
page-caching for metadata too.

Look at the ext2 readdir() implementation, and compare it to the crapola 
horror that is ext3. Guess what? ext2 uses virtually indexed metadata, and 
as a result it is both simpler, smaller and a LOT faster than ext3 in 
accessing that metadata.

Face it, Andrew, you're wrong on this one. Really. Just take a look at 
ext2_readdir(). 

[ I'm not saying that ext2_readdir() is _beautiful_. If it had been 
  written with the page cache in mind, it would probably have been done 
  very differently. And it doesn't do any readahead, probably because 
  nobody cared enough, but it should be trivial to add, and it would 
  automatically "do the right thing" just because it's much easier at the 
  page cache level.

  But I _am_ saying that compared to ext3, the ext2 readdir is a work of 
  art. ]

"metadata" has _zero_ to do with "physically indexed". There is no 
correlation what-so-ever. If you think there is a correlation, it's all in 
your mind.

		Linus
