Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRCXEMY>; Fri, 23 Mar 2001 23:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131564AbRCXEMP>; Fri, 23 Mar 2001 23:12:15 -0500
Received: from smtp2.Stanford.EDU ([171.64.14.116]:50906 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S131563AbRCXEME>; Fri, 23 Mar 2001 23:12:04 -0500
From: "Zack Weinberg" <zackw@stanford.edu>
Date: Fri, 23 Mar 2001 20:11:22 -0800
To: linux-kernel@vger.kernel.org
Cc: Kevin Buhr <buhr@stat.wisc.edu>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Message-ID: <20010323201122.Y699@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
In-Reply-To: <vbawv9hyuj0.fsf@mozart.stat.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Buhr wrote:
> Jakob Østergaard <jakob@unthought.net> writes:
> >
> > Try compiling something like Qt/KDE/gtk-- which are really heavy on
> > templates (with all the benefits and drawbacks of that).
> 
> Okay, I just compiled gtk-- 1.0.3 (with CFLAGS = "-O2 -g") under three
> versions of GCC (Debian 2.95.3, RedHat 2.96, and a CVS pull of the
> "gcc-3_0-branch") on the same Debian machine running kernel 2.4.2.
> 
> In all cases, the "cc1plus" processes appeared to max out around 25M
> total size. The "maps" pseudofiles for the 2.95.3 and and 3.0
> compiles never grew past 250 lines, but the "maps" pseudofiles for the
> RedHat 2.96 compile were gigantic, jumping to 3000 or 5000 lines at
> times.
> 
> The results speak for themselves:
> 
>     CVS gcc 3.0:	Debian gcc 2.95.3:	RedHat gcc 2.96:
>                       
>     real 16m8.423s	real 8m2.417s		real 12m24.939s
>     user 15m23.710s	user 7m22.200s		user 10m14.420s
>     sys 0m48.730s	sys 0m41.040s		sys 2m13.910s
> maps: <250 lines	<250 lines		>3000 lines

Let me inject some information about what gcc's doing in each version.

2.95.3 allocates its memory via a bunch of 'obstacks' which,
underneath, get memory from malloc, and therefore brk(2).  I'm very
surprised to see it had ~250 vmas; it should be more like 10.

2.96 and later versions use a garbage collecting allocator instead; it
was becoming much too hard to decide which obstack to use when.  The
garbage collector allocates memory with mmap(..., MAP_ANON, ...).
This is to avoid interfering with malloc, which is still used in many
places; and to get page-aligned memory without wasting tons of space,
as valloc(3) does.

In Red Hat's 2.96, that allocator gets memory from mmap one page at a
time.  If I understand what's going on in the kernel correctly, that
means each page is its own vma.  25 megs of GC arena is roughly 6400
vmas in that regime.

In CVS 3.0-to-be (and trunk), the allocator gets memory in 32-page
chunks instead.  So 25 megs of GC arena is only 200 vmas.

However, 25 megs of GC arena is small as these things go.  GCC's
memory consumption can _easily_ get up to 200 or 300 megs.  The
example I'm familiar with is insn-attrtab.c from GCC's own sources
(it's machine-generated code, with several huge functions).  256 megs
of GC arena, in 32-page chunks, is 2048 vmas.  Yes, at this point the
machine is swapping... but if I understand the issue, it's just when
we're swapping that having thousands of vmas causes problems.

In conclusion, I think that GCC's allocator still makes a good case
for merging vmas.

zw
