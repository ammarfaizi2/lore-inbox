Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271367AbRHYDAU>; Fri, 24 Aug 2001 23:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272011AbRHYDAL>; Fri, 24 Aug 2001 23:00:11 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:38904
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S271367AbRHYC7z>; Fri, 24 Aug 2001 22:59:55 -0400
Date: Fri, 24 Aug 2001 23:00:05 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: What version of the kernel fixes these VM issues?
In-Reply-To: <20010824222924Z16116-32383+1243@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0108241940280.25240-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Aug 2001, Daniel Phillips wrote:

> On August 24, 2001 10:12 pm, Nicolas Pitre wrote:
> > On Fri, 24 Aug 2001, Daniel Phillips wrote:
> >
> > > On August 24, 2001 08:14 pm, Nicolas Pitre wrote:
> > > > I have a totally different setup but I can reproduce the same behavior on
> > > > the system I have here:
> > > >
> > > > ARM board with 32 MB RAM, no cache, NFS root.
> > > > The kernel is based on 2.4.8-ac9 plus some small VM fixes from -ac10.
> > > >
> > > > My test consist in compiling gcc 3.0 while some MP3s are continously playing
> > > > in the background.  The gcc build goes pretty far along until both the mp3
> > > > player and the gcc build completely jam.
> > >
> > > Which sound system, and which sound card driver?
> >
> > The driver is for the UDA1341 on a SA1110 chip written by myself.  It is
> > fully OSS compliant, no ALSA.
>
> Your system should be able to handle that easily.  Do you have some meminfo
> output to look at?  What about 2.4.9?

OK now I have some comparative data.  Two kernels:

1) based on 2.4.8-ac9 + Riel's VM fixes from -ac10
2) based on 2.4.9 with no extra VM patches


The test:
=========

This board has 32MB RAM, no swap.  Root fs is NFS.  On the serial console I
start a command line mp3 player.  In a first telnet session I start a build
of gcc 3.0 (./configure; make).  In a second telnet session I start 'top'.
Music plays while gcc builds and I can see the CPU usage within top.
Pretty real scenario, real life situation, expected system load, no trick.


2.4.8-ac9 plus -ac10 VM fixes:
==============================

Everything looks fine for a while.  But all of a sudden: no more music, the
gcc build stalls, system looks dead.  In my first description of the problem
quoted above I said that the audio was spitting glitches of 100 ms every 10
secs or so.  This time there is nothing.  The only difference is the
addition of 'top' in the process list.  Even the telnet sessions aren't
echoing keystrokes anymore.  Only the serial console echoes characters so
kernel BH's are still running.  Sysrq on the serial console works
fortunately.  kswapd is looping like crazy:

kswapd        R C0023CC0     0     4      0             5     3 (L-TLB)

At first NFS traffic occupied the full network bandwidth to page stuff in.
But after a while the following was printed to the console:

nfs: task 41867 can't get a request slot
nfs: task 41868 can't get a request slot
nfs: task 41869 can't get a request slot

and then no more NFS packet on the network.  It is possible to ping the box
which means that the net BH still works.

A couple sysrq-P at random intervals shows the CPU looping in the following
functions:

PC value	System.map
--------	----------
c0040d84	zone_inactive_plenty
c0041024	try_to_swap_out
c00216e0	cpu_sa1100_cache_clean_invalidate_range
c00216d0	cpu_sa1100_cache_clean_invalidate_range
c0041304	swap_out_mm
c0041168	swap_out_pmd
c0044324	__get_swap_page
c0040d60	zone_inactive_plenty
c0041128	swap_out_pmd
c0040fec	try_to_swap_out

Sysrq-M gives:

SysRq : Show Memory
Mem-info:
Free pages:        1012kB (     0kB HighMem)
( Active: 2007, inactive_dirty: 0, inactive_clean: 0, free: 253 (255 510 765) )
3*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 1012kB)
= 0kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0
Free swap:            0kB
8192 pages of RAM
393 free pages
636 reserved pages
33 pages shared
0 pages swap cached
6 page tables cached
Buffer memory:     8000kB


2.4.9 kernel:
=============

Unlike the first (quoted) run, this kernel completely stalled when the jam
conditions were reached just like the run described above.  I mean here
there is no audio stuttering at all, no echo from telnet sessions, nothing
in user space gets to run anymore.  kswapd is well locked in the R state:

kswapd        R C0022CA0     0     4      0             5     3 (L-TLB)

Kernel interrupts and BHs still work i.e. I can ping the box, the serial
console still echoes characters (kernel termios), and sysrq works but that's
all.  What's also interesting here is the fact that there is absolutely no
NFS traffic going on.

A couple sysrq-P at random intervals shows the CPU looping in the following
functions:

PC value	System.map
--------	----------
c003f6e0	zone_inactive_plenty
c003fa58	swap_out_pmd
c0060324	prune_icache
c003f6fc	zone_inactive_plenty
c003faac	swap_out_pmd
c00209a0	cpu_sa1100_set_pte
c003fc80	swap_out_mm
c0040c10	refill_inactive_scan
c00206c0	cpu_sa1100_cache_clean_invalidate_range
c003fa90	swap_out_pmd

Sysrq-M gives:

SysRq: Show Memory
Mem-info:
Free pages:        1008kB (     0kB HighMem)
( Active: 2546, inactive_dirty: 63, inactive_clean: 0, free: 252 (255 510 765) )
0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 1008kB)
= 0kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0
Free swap:            0kB
8192 pages of RAM
392 free pages
602 reserved pages
576 pages shared
0 pages swap cached
8 page tables cached
Buffer memory:     8000kB


Notes:
======

- Both kernels go flat after approx 14 min of mp3 playback.
- With enough retries (i.e. reboots) the gcc build succeed, so there is no
  lack of ressources in theory.
- SEnding a signal to the mp3 player (^C on the serial console) doesn't
  change anything.
- The only way out is the reset button.
- Both kernels (with or without -ac) deadlock.
- The same behavior occurs with 2.4.8-ac4.


Hope this helps somehow.  If I can provide anything else please ask.


Nicolas

