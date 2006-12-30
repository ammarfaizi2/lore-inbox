Return-Path: <linux-kernel-owner+w=401wt.eu-S965232AbWL3Avm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWL3Avm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 19:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWL3Avm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 19:51:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36953 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965229AbWL3Avk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 19:51:40 -0500
Date: Fri, 29 Dec 2006 16:50:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Theodore Tso <tytso@mit.edu>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro,
       linux-ext4@vger.kernel.org
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
In-Reply-To: <20061229160520.e498789f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612291633500.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
 <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
 <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
 <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org> <20061229141632.51c8c080.akpm@osdl.org>
 <Pine.LNX.4.64.0612291431200.4473@woody.osdl.org> <20061229233207.GA21461@thunk.org>
 <20061229160520.e498789f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Andrew Morton wrote:
> 
> Adam Richter spent considerable time a few years ago trying to make the
> mpage code go direct-to-BIO in all cases and we eventually gave up.  The
> conceptual layering of page<->blocks<->bio is pretty clean, and it is hard
> and ugly to fully optimise away the "block" bit in the middle.

Using the buffer cache as a translation layer to the physical address is 
fine. That's what _any_ block device will do.

I'm not at all sayign that "buffer heads must go away". They work fine.

What I'm saying is that

 - if you index by buffer heads, you're screwed.
 - if you do IO by starting at buffer heads, you're screwed.

Both indexing and writeback decisions should be done at the page cache 
layer. Then, when you actually need to do IO, you look at the buffers. But 
you start from the "page". YOU SHOULD NEVER LOOK UP a buffer on its own 
merits, and YOU SHOULD NEVER DO IO on a buffer head on its own cognizance.

So by all means keep the buffer heads as a way to keep the 
"virtual->physical" translation. It's what they were designed for. But 
they were _originally_ also designed for "lookup" and "driving the start 
of IO", and that is wrong, and has been wrong for a long time now, because

 - lookup based on physical address is fundamentally slow and inefficient. 
   You have to look up the virtual->physical translation somewhere else, 
   so it's by design an unnecessary indirection _and_ that "somewere 
   else" is also by definition filesystem-specific, so you can't do any 
   of these things at the VFS layer.

   Ergo: anything that needs to look up the physical address in order to 
   find the buffer head is BROKEN in this day and age. We look up the 
   _virtual_ page cache page, and then we can trivially find the buffer 
   heads within that page thanks to page->buffers.

   Example: ext2 vs ext3 readdir. One of them sucks, the other doesn't. 

 - starting IO based on the physical entity is insane. It's insane exactly 
   _because_ the VM doesn't actually think in physical addresses, or in 
   buffer-sized blocks. The VM only really knows about whole pages, and 
   all the VM decisions fundamentally have to be page-based. We don't ever 
   "free a buffer". We free a whole page, and as such, doing writeback 
   based on buffers is pointless, because it doesn't actually say anything 
   about the "page state" which is what the VM tracks.

But neither of these means that "buffer_head" itself has to go away. They 
both really boil down to the same thing: you should never KEY things by 
the buffer head. All actions should be based on virtual indexes as far as 
at all humanly possible.

Once you do lookup and locking and writeback _starting_ from the page, 
it's then easy to look up the actual buffer head within the page, and use 
that as a way to do the actual _IO_ on the physical address. So the buffer 
heads still exist in ext2, for example, but they don't drive the show 
quite as much.

(They still do in some areas: the allocation bitmaps, the xattr code etc. 
But as long as none of those have big VM footprints, and as long as no 
_common_ operations really care deeply, and as long as those data 
structures never need to be touched by the VM or VFS layer, nobody will 
ever really care).

The directory case comes up just because "readdir()" actually is very 
common, and sometimes very slow. And it can have a big VM working set 
footprint ("find"), so trying to be page-based actually really helps, 
because it all drives things like writeback on the _right_ issues, and we 
can do things like LRU's and writeback decisions on the level that really 
matters.

I actually suspect that the inode tables could benefit from being in the 
page cache too (although I think that the inode buffer address is actually 
"physical", so there's no indirection for inode tables, which means that 
the virtual vs physical addressing doesn't matter). For directories, there 
definitely is a big cost to continually doing the virtual->physical 
translation all the time.

		Linus
