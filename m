Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275526AbRJFTHc>; Sat, 6 Oct 2001 15:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275529AbRJFTHW>; Sat, 6 Oct 2001 15:07:22 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:14345 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275526AbRJFTHS>; Sat, 6 Oct 2001 15:07:18 -0400
Date: Sat, 6 Oct 2001 21:07:31 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Anton Blanchard <anton@samba.org>
cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <20011007041201.D15309@krispykreme>
Message-ID: <Pine.LNX.3.96.1011006203014.7808A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Of course vmalloc space can overflow - but it overflows only when the
> > machine is overloaded with too many processes, too many processes with
> > many filedescriptors etc. On the other hand, the buddy allocator fails
> > *RANDOMLY*. Totally randomly, depending on cache access patterns and
> > page allocation times.
> 
> vmalloc space is also much worse for tlb usage when the main kernel mapping
> uses large hardware ptes. Ingo and davem pointed this out to me recently
> when I wanted to allocate the pagecache hash using vmalloc (at the
> moment it maxes out at order 10 which is much to small for machines
> with large memory).

OK, but my patch uses vmalloc only as a fallback when buddy fails. The
probability that buddy fails is small. It is slower but with very small
probability.

It is perfectly OK to have a bit slower access to task_struct with
probability 1/1000000.

But it is ***BAD*BUG*** if allocation of task_struct fails with
probability 1/1000000.

> If you could get away with a single page stack, then you could allocate
> the task struct separately and avoid any order 1 allocation. But you
> would probably need interrupt stacks to get away with a single page
> stack.

Yes, but there are still other dangerous usages of kmalloc and
__get_free_pages. (The most offending one is in select.c)


It is sad that core VM developers did not write any documentation that
explains that high-order allocations can fail any time and the caller must
not abort his operation when it happens. Instead - they are trying to make
high-order allocations fail less often :-/  How should random
Joe-driver-developer know, that kmalloc(4096) is safe and kmalloc(4097) is
not?

Now parts of a kernel written by people who know about buddy allocator
(page/buffer/dentry/inode hash allocations, filedescriptor array
allocation) are written correctly with the assumption that high-order
allocation may fail. 

Other parts of kernel written by people who do not know about buddy
allocator (task_struct allocation, select and probably a lot of drivers)
assume that high-order allocation always succeeds. task_struct and select
can be fixed easily, but cleaning the shit in drivers will be real pain
and it will probably never be finished :-(

Mikulas



