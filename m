Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264937AbRGIVQH>; Mon, 9 Jul 2001 17:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264958AbRGIVP6>; Mon, 9 Jul 2001 17:15:58 -0400
Received: from [64.64.109.142] ([64.64.109.142]:21777 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S264937AbRGIVPs>; Mon, 9 Jul 2001 17:15:48 -0400
Message-ID: <3B4A1EFE.130E9E6@didntduck.org>
Date: Mon, 09 Jul 2001 17:15:42 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Shand <larry@spack.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
In-Reply-To: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Shand wrote:
> 
> Where I just started work we run large processes for simulations and
> testing of semi-conductors.  Currently we use Solaris because of past
> limitations on the amount of RAM that a single process can address under
> Linux.  Recently we tried to run some tests on a Dell dual Xeon 1.7GHz
> with 4GB of RAM running Redhat 7.1 box (with the stock Redhat SMP kernel).
> Speedwise it kicked the crap out of our Sunblade (Dual 750MHz with 8GB of
> RAM)but we had problems with process dying right around 2.3GB (according
> to top).
> 
> So I started to investigate, and quickly discovered that there is no good
> source for finding this sort of information on line.  At least not that I
> could find.  Nearly every piece of information I found conflicted in at
> least some small way with another piece of information I found.
> So I ask here in the hopes of a definitive answer.
> 
>  * What is the maximum amount of RAM that a *single* process can address
>    under a 2.4 kernel, with PAE enabled?  Without?

3GB in either mode for user virtual address space.

>  * And, what (if any) paramaters can effect this (recompiling the app
>    etc)?

None.

> What I think I know so far is listed below.  I welcome being flamed, told
> that I'm stupid and that I should have looked "here" so long as said
> messages also contain pointers to definitive information :-)
> 
> Linux 2.4 does support greater then 4GB of RAM with these caveats ...
> 
>  * It does this by supporting Intel's PAE (Physical Address Extension)
>    features which are in all Pentium Pro and newer CPU's.
>  * The PAE extensions allow up to a maximum of 64GB of RAM that the OS
>    (not a process) can address.

64GB of PHYSICAL memory.  The processor is still limited to 4GB of
VIRTUAL memory per page table (per process) which must be shared between
user space and kernel space.  Linux uses a 3:1 split.

>  * It does this via indirect pointers to the higher memory locations, so
>    there is a CPU and RAM hit for using this.

If the kernel needs to access physical memory above the 960MB limit it
must remap it into a virtual address window on demand.  This leads to
TLB misses and poor caching.

>  * Benchmarks seem to indicated around 3-6% CPU hit just for using the PAE
>    extensions (ie. it applies regardless of whether you are actually
>    accessing memory locations greater then 4GB).

This is because the page table entries are 64-bit values, and we all
know how well the x86 does 64-bit stuff.

>  * If the kernel is compiled to use PAE, Linux will not boot on a computer
>    whose hardware doesn't support PAE.

This is by design.  It would be too much overhead to allow runtime
decision on PAE support.

>  * PAE does not increase Linux's ability for *single* processes to see
>    greater then 3GB of RAM (see below).

Correct.  PAE is only for addressing more physical memory.

> So what are the limits without using PAE? Here I'm still having a little
> problem finding definitive answers but ...
> 
>  * With PAE compiled into the kernel the OS can address a maximum of 4GB
>    of RAM.

Almost correct.  There needs to be a hole somewhere for memory mapped
devices, so not all of the physical addresses below 4GB are memory.

>  * With 2.4 kernels (with a large memory configuration) a single process
>    can address up to the total amount of RAM in the machine minus 1GB
>    (reserved for the kernel), to a maximum 3GB.

Not true.  A user process always has 3GB of address space, even if some
of that must be allocated from swap.

>  * By default the kernel reserves 1GB for it's own use, however I think
>    that this is a tunable parameter so if we have 4GB of RAM in a box we
>    can tune it so that most of that should be available to the processes
>    (?).

Again, the kernel reserves 1GB of VIRTUAL address space.  It uses this
to directly map up to 960 MB of physical memory.  The remaining 64 MB is
used for vmalloc, ioremap, and kmap.  Technically, you could change the
user:kernel split to 3.5:1.5, but doing that reduces the amount of
memory the kernel can directly map, leading to reduced performance (ie.
less memory for caches, etc.)

> 
> I have documented the below information on my web site, and will post
> whatever answers I recieve there:
> 
>         http://www.spack.org/index.cgi/LinuxRamLimits
> 
> Thanks,
> Adam.

To summarize:

- The x86 architecture is limited by the design of its addressing modes
and page tables to accessing 4GB of virtual memory.  This is a hard
limit.
- PAE mode (Physical Address Extensions) allows the processor to address
64GB of physical memory via the page tables, but does not change the
size of the virtual address space.
- User processes have 3GB of virtual address space to use.  This is true
even if there is less physical memory, becuase of swap and memory mapped
files (including executable code and shared libraries).
- The kernel has the remaining 1GB of virtual memory.
  - It directly maps up to 960MB of memory.
  - It leaves a 64MB window for dynamic allocations, such as vmalloc,
ioremap, and kmap.
- The user:kernel split can be changed, but this leaves the kernel with
less memory to work with, reducing performance and increasing the risk
of out of memory conditions.
- The only way the kernel can use "high" memory (physical memory over
960MB) is through user space mappings or via vmalloc or kmap on demand.
- There is no sane way around this architectural limit.  Any workrounds
would involve switching page tables and flushing kernel TLB entries
which would kill performance.
- On the user side, you can work within this limit by using shared
memory or mmap more agressively, to map in data on demand and release it
when it's not needed.
- 64-bit architectures aren't as limited in memory usage.  I think (but
I'm not positive) that some non-x86 32-bit architectures allow for
seperate user and kernel page tables in the hardware, expanding the
limits.

--

				Brian Gerst
