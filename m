Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbRGJC5a>; Mon, 9 Jul 2001 22:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRGJC5U>; Mon, 9 Jul 2001 22:57:20 -0400
Received: from mail.intrex.net ([209.42.192.246]:37133 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S265385AbRGJC5K>;
	Mon, 9 Jul 2001 22:57:10 -0400
Date: Mon, 9 Jul 2001 23:01:51 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Message-ID: <20010709230151.A13704@bessie.localdomain>
In-Reply-To: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org>; from larry@spack.org on Mon, Jul 09, 2001 at 01:01:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 01:01:17PM -0700, Adam Shand wrote:
> 
> Where I just started work we run large processes for simulations and
> testing of semi-conductors.  Currently we use Solaris because of past
> limitations on the amount of RAM that a single process can address under
> Linux.  Recently we tried to run some tests on a Dell dual Xeon 1.7GHz
> with 4GB of RAM running Redhat 7.1 box (with the stock Redhat SMP kernel).
> Speedwise it kicked the crap out of our Sunblade (Dual 750MHz with 8GB of
> RAM)but we had problems with process dying right around 2.3GB (according
> to top).

I have had the same experience.  I work with machines that run large single
processes, and while the Linux machines are much faster than the Solaris
machines we have, the Linux machines do not handle large processes very well.

I asked some questions on this list similar to yours and got a lot of useful
information.  One important thing that did not come up, probably because its
not considered a kernel issue, is that the malloc() in glibc has some
limitations that keep you from using all 3G of virtual address space that
your process has.  Here is a description of the problem, its from memory so
the numbers may not be exact, but it will give you the idea.  When you run
a program, your address space gets divided up into several regions.  Your
program itself gets mapped into low memory a few megs above 0x0.  Your programs
stack gets mapped into the top of memory at 0xc0000000 and it grows down
tword the program text.  Files or shared libraries are mmaped in starting
at 0x40000000 (1G) and each new mmap() occurs at a higher address so that
the mapped area grows tword the stack.
its something like this:

       0x00000000 ---> Unmapped
       0x08048000 ---> Text/Data
       0x40000000 ---> Shared libs and mmaped
       0xc0000000 ---> Stack

Now when you call malloc() it can get its memory in one of two ways.  For small
requests (less than 128K), it uses the sbrk() call which gets memory space
that grows up from the top up the text/data area.  When this area grows up
into the shared libs, sbrk() fails and malloc can not give you any more memory,
even though you have about 2G of address space available above the shared
libs.

For large requests malloc() calls mmap(), which starts allocating at the top
of your shared libs and will fail when this area hits the stack.  You can
get close to 2G of memory this way, but that still leaves almost 1G of unused
memory below 0x40000000.

There are some environment variables that let you tune exactly when malloc()
calls mmap() and when it calls sbrk().  These did not help me though, because
our program allocates most of its memory in small blocks that are too small
to be mmap()ed effectivly.

I thought I could get around this by statically linking my program.  That did
not work because there still seems to be a single page mapped in at 0x40000000.

Next I tried the hoard allocator.  That worked better than the glibc malloc
because it always uses mmap() so I got close to 2G of memory rather than
slightly less than 1G.

Next I patched the hoard allocator so that instead of calling mmap(0, ...)
it would call it as something like mmap(0x10000000, ...) which causes it
to start allocating memory that would normally be reserved for sbrk().
I think I could get close to 2.5G from the hoard malloc after this patch.
This change got incorporated into the latest hoard, but I had problems
building the latest hoard, so you may want to wait for a future release.

Anyway, I just wanted to let you know that there are some glibc issues that
are more restrictive than the kernel issues.

Hope this helps,

Jim
