Return-Path: <linux-kernel-owner+w=401wt.eu-S965226AbWL2X7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbWL2X7y (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755103AbWL2X7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:59:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35006 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100AbWL2X7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:59:51 -0500
Date: Fri, 29 Dec 2006 15:59:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Theodore Tso <tytso@mit.edu>
cc: Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro,
       linux-ext4@vger.kernel.org
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
In-Reply-To: <20061229233207.GA21461@thunk.org>
Message-ID: <Pine.LNX.4.64.0612291542260.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
 <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
 <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
 <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org> <20061229141632.51c8c080.akpm@osdl.org>
 <Pine.LNX.4.64.0612291431200.4473@woody.osdl.org> <20061229233207.GA21461@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Theodore Tso wrote:
>
> If we do get this fixed for ext4, one interesting question is whether
> people would accept a patch to backport the fixes to ext3, given the
> the grief this is causing the page I/O and VM routines.

I don't think backporting is the smartest option (unless it's done _way_ 
later), but the real problem with it isn't actually the VM behaviour, but 
simply the fact that cached performance absoluely _sucks_ with the buffer 
cache.

With the physically indexed buffer cache thing, you end up always having 
to do these complicated translations into block numbers for every single 
access, and at some point when I benchmarked it, it was a huge overhead 
for doing simple things like readdir.

It's also a major pain for read-ahead, exactly partly due to the high cost 
of translation - because you can't cheaply check whether the next block is 
there, the cost of even asking the question "should I try to read ahead?" 
is much much higher. As a result, read-ahead is seriously limited, because 
it's so expensive for the cached case (which is still hopefully the 
_common_ case).

So because read-ahead is limited, the non-cached case then _really_ sucks.

It was somewhat fixed in a really god-awful fashion by having 
ext3_readdir() actually do _readahead_ though the page cache, even though 
it does everything else through the buffer cache. And that just happens to 
work because we hopefully have physically contiguous blocks, but when that 
isn't true, the readahead doesn't do squat.

It's really quite fundamentally broken. But none of that causes any 
problems for the VM, since directories cannot be mmap'ed anyway. But it's 
really pitiful, and it really doesn't work very well. Of course, other 
filesystems _also_ suck at this, and other operating systems haev even 
MORE problems, so people don't always seem to realize how horribly 
horribly broken this all is.

I really wish somebody would write a filesystem that did large cold-cache 
directories well. Open some horrible file manager on /usr/bin with cold 
caches, and weep. The biggest problem is the inode indirection, but at 
some point when I looked at why it sucked, it was doing basically 
synchronous single-buffer reads on the directory too, because readahead 
didn't work properly.

I was hoping that something like SpadFS would actually take off, because 
it seemed to do a lot of good design choices (having inodes in-line in the 
directory for when there are no hardlinks is probably a requirement for a 
good filesystem these days. The separate inode table had its uses, but 
indirection in a filesystem really does suck, and stat information is too 
important to be indirect unless it absolutely has to).

But I suspect it needs more than somebody who just wants to get his thesis 
written ;)

		Linus
