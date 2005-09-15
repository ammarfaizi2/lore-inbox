Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVIORwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVIORwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVIORwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:52:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932352AbVIORwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:52:40 -0400
Date: Thu, 15 Sep 2005 10:52:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@novell.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
In-Reply-To: <20050915165117.GE4122@opteron.random>
Message-ID: <Pine.LNX.4.58.0509151043370.26803@g5.osdl.org>
References: <20050914212405.GD4966@opteron.random>
 <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0509150805150.26803@g5.osdl.org> <20050915154702.GA4122@opteron.random>
 <Pine.LNX.4.58.0509150911180.26803@g5.osdl.org> <20050915162347.GC4122@opteron.random>
 <Pine.LNX.4.58.0509150928030.26803@g5.osdl.org> <20050915165117.GE4122@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Sep 2005, Andrea Arcangeli wrote:
>
> On Thu, Sep 15, 2005 at 09:34:12AM -0700, Linus Torvalds wrote:
> > If you think the data is wrong, then you are arguing against the COW. Yes, 
> > the COW will make the data "wrong", but you can't escape that. That's what 
> > a "write" by ptrace does.
> 
> My point is that exactly because this is the wrong page with the wrong
> data with the wrong ptrace usage, these kind of things will happen in a
> very controlled environment

I disagree.

_The_ most common use of PTRACE_POKE is debugging. And gdb doesn't "know" 
what the process is doing.

> I don't see why the kernel should bother to fix an unfixable case.

I don't see why you argue against trying to do our best.

Let me tell you why you're wrong, with a real-life example.

I debugged "sparse" with making all de-allocations turn the page 
protections to PROT_NONE. 

That's absolutely _wonderful_. It means that when the process does a bad
access, I get a SIGSEGV (and the memory hasn't been allocated to something
else, as would happen if I had just munmapped it). And when debugging 
this, I could _see_ what the old contents were - because PTRACE_PEEK 
could punch through the protections - so I had lots of extra information. 

For example, I could look at the free'd data to see where it came from, 
because the free'd data actually contained pointers to other stuff, giving 
me a very good view of _what_ had gotten free'd too early.

Now, in this case, a SIGSEGV was always fatal, but the fact is, some 
applications actually catch it, and do their own VM management. It's rare, 
but it definitely exists. So should the fact that I looked at the data 
make that the protections changed? HELL NO! My debugger may have looked at 
it, but that doesn't invalidate the notion that the program still expected 
to get a SIGSEGV on it.

And the PTRACE_POKE is _exactly_ the same thing. There's _zero_ 
difference. The fact that PTRACE_POKE _changes_ the data instead of just 
reading it doesn't change anything at all - the fact that data got changed 
in NO WAY invalidates the fact that processes might still depend on 
getting a SIGSEGV.

If you want to change permissions, then add a PTRACE_MPROTECT thing or 
something, and teach gdb to use that. But if you don't want to change 
permissions, then you shouldn't change permissions.

Now, if you have a technical reason why "maybe_mkwrite()" needs to go 
away, then that's a different thing. BUT IT HAS NOTHING TO DO WITH THE 
FACT THAT WE LOOKED AT OR CHANGED THE DATA!

			Linus
