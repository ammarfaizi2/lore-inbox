Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbTC3XIY>; Sun, 30 Mar 2003 18:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbTC3XIY>; Sun, 30 Mar 2003 18:08:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55680
	"EHLO x30.random") by vger.kernel.org with ESMTP id <S261326AbTC3XIX>;
	Sun, 30 Mar 2003 18:08:23 -0500
Date: Mon, 31 Mar 2003 01:19:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030330231945.GH2318@x30.local>
References: <20030328040038.GO1350@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030328040038.GO1350@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Didn't you break the linux x86 ABI in mmap? the file offset must be a
multiple of the softpagesize and binary apps can break with -EINVAL with
pgcl. The workaround is to allocate it in anon mem but it's not coherent
if somebody does a change to the binary with MAP_SHARED, so still broken
semantics. In theory we could also have aliasing in the cache, but it
doesn't seem a good idea.

Since you have access to such a machine, can you please try to boot
2.4.21pre5aa2 on such a machine? That must boot just fine too according
to my math, however, there will be little normal zone left, compared to
your kernel with pgcl. But 700M of normal zone are still nothing versus
the 64G of ram, what I mean is that even pgcl isn't guaranteeing general
purpose usability of the box (despite making it much more usable).

Note that 2.5 mem_map is bigger due rmap, my 2.4 w/o the rmap slowdown
should boot just fine w/o pgct that breaks the linux x86 ABI and in turn
binary apps at runtime.

I believe pgcl is very interesting for x86 long term, and for all archs
not providing a flexible hard-page-size. The larger softpagesize can
increase performance, 4k page size is too small these days, especially
on a 64bit arch, infact this softpagesize feature would be most
interesting for x86-64 even in the long term (for a totally different
reason of why you find it most interesting today on the 32bit x86 64G
boxes ;). so it sounds like a good thing to have for mainline >=2.5
regardless. All it matters is that you don't try to make the page
allocator returning anything smaller than the softpagesize to avoid
losing reliability of allocations for core data structures.

Andrea
