Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTJJSg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTJJSg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:36:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:38124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263125AbTJJSgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:36:50 -0400
Date: Fri, 10 Oct 2003 11:36:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <20031010182021.GF16013@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0310101126120.20420-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Oct 2003, Andrea Arcangeli wrote:
> 
> O_DIRECT only walk the pagetables, no pte mangling, no tlb flushes, the
> TLB is preserved fully.

Yes. However, it's even _nicer_ if you don't need to walk the page tables 
at all.

Quite a lot of operations could be done directly on the page cache. I'm 
not a huge fan of mmap() myself - the biggest advantage of mmap is when 
you don't know your access patterns, and you have reasonably good 
locality. In many other cases mmap is just a total loss, because the page 
table walking is often more expensive than even a memcpy().

That's _especially_ true if you have to move mappings around, and you have 
to invalidate TLB's. 

memcpy() often gets a bad name. Yeah, memory is slow, but especially if 
you copy something you just worked on, you're actually often better off 
letting the CPU cache do its job, rather than walking page tables and 
trying to be clever.

Just as an example: copying often means that you don't need nearly as much 
locking and synchronization - which in turn avoids one whole big mess 
(yes, the memcpy() will look very hot in profiles, but then doing extra 
work to avoid the memcpy() will cause spread-out overhead that is a lot 
worse and harder to think about).

This is why a simple read()/write() loop often _beats_ mmap approaches. 
And often it's actually better to not even have big buffers (ie the old 
"avoid system calls by aggregation" approach) because that just blows your 
cache away.

Right now, the fastest way to copy a file is apparently by doing lots of
~8kB read/write pairs (that data may be slightly stale, but it was true at
some point). Never mind the system call overhead - just having the extra
buffer stay in the L1 cache and avoiding page faults from mmap is a bigger
win.

And I don't think mmap _can_ beat that. It's fundamental. 

In contrast, direct page cache accesses really can do so. Exactly because 
they don't touch any page tables at all, and because they can take 
advantage of internal kernel data structure layout and move pages around 
without any cost..

		Linus

