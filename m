Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272390AbRHYEbM>; Sat, 25 Aug 2001 00:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272391AbRHYEbD>; Sat, 25 Aug 2001 00:31:03 -0400
Received: from web10405.mail.yahoo.com ([216.136.130.97]:32517 "HELO
	web10405.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272390AbRHYEaq>; Sat, 25 Aug 2001 00:30:46 -0400
Message-ID: <20010825043102.28960.qmail@web10405.mail.yahoo.com>
Date: Sat, 25 Aug 2001 14:31:02 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: What version of the kernel fixes these VM issues?
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108241940280.25240-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Nicolas Pitre <nico@cam.org> wrote: > 
> 
> On Sat, 25 Aug 2001, Daniel Phillips wrote:
> 
> > On August 24, 2001 10:12 pm, Nicolas Pitre wrote:
> > > On Fri, 24 Aug 2001, Daniel Phillips wrote:
> > >
> > > > On August 24, 2001 08:14 pm, Nicolas Pitre
> wrote:
> > > > > I have a totally different setup but I can
> reproduce the same behavior on
> > > > > the system I have here:
> > > > >
> > > > > ARM board with 32 MB RAM, no cache, NFS
> root.
> > > > > The kernel is based on 2.4.8-ac9 plus some
> small VM fixes from -ac10.
> > > > >
> > > > > My test consist in compiling gcc 3.0 while
> some MP3s are continously playing
> > > > > in the background.  The gcc build goes
> pretty far along until both the mp3
> > > > > player and the gcc build completely jam.
> > > >
> > > > Which sound system, and which sound card
> driver?
> > >
> > > The driver is for the UDA1341 on a SA1110 chip
> written by myself.  It is
> > > fully OSS compliant, no ALSA.
> >
> > Your system should be able to handle that easily. 
> Do you have some meminfo
> > output to look at?  What about 2.4.9?
> 
> OK now I have some comparative data.  Two kernels:
> 
> 1) based on 2.4.8-ac9 + Riel's VM fixes from -ac10
> 2) based on 2.4.9 with no extra VM patches
> 
> 
> The test:
> =========
> 
> This board has 32MB RAM, no swap.  Root fs is NFS. 
> On the serial console I
> start a command line mp3 player.  In a first telnet
> session I start a build
> of gcc 3.0 (./configure; make).  In a second telnet
> session I start 'top'.
> Music plays while gcc builds and I can see the CPU
> usage within top.
> Pretty real scenario, real life situation, expected
> system load, no trick.

Strange enough to me, I can not reproduce this with my
computer nearly the same as your described situation

Except nfs root file system, I started several rxvt
play mpg123 ; compile the kernel ; browsing the net
using mozilla, running top at one rxvt, kernel uses
2.4.9 is fine; 2.4.6 is fine too.

My computer is 686 128Mb RAM only 72Mb swap

OOP, 2.4.9 applied the one small patch for VM fix
(just one line
> 
> 2.4.8-ac9 plus -ac10 VM fixes:
> ==============================
> 
> Everything looks fine for a while.  But all of a
> sudden: no more music, the
> gcc build stalls, system looks dead.  In my first
> description of the problem
> quoted above I said that the audio was spitting
> glitches of 100 ms every 10
> secs or so.  This time there is nothing.  The only
> difference is the
> addition of 'top' in the process list.  Even the
> telnet sessions aren't
> echoing keystrokes anymore.  Only the serial console
> echoes characters so
> kernel BH's are still running.  Sysrq on the serial
> console works
> fortunately.  kswapd is looping like crazy:
> 
> kswapd        R C0023CC0     0     4      0         
>    5     3 (L-TLB)
> 
> At first NFS traffic occupied the full network
> bandwidth to page stuff in.
> But after a while the following was printed to the
> console:
> 
> nfs: task 41867 can't get a request slot
> nfs: task 41868 can't get a request slot
> nfs: task 41869 can't get a request slot
> 
> and then no more NFS packet on the network.  It is
> possible to ping the box
> which means that the net BH still works.
> 
> A couple sysrq-P at random intervals shows the CPU
> looping in the following
> functions:
> 
> PC value	System.map
> --------	----------
> c0040d84	zone_inactive_plenty
> c0041024	try_to_swap_out
> c00216e0	cpu_sa1100_cache_clean_invalidate_range
> c00216d0	cpu_sa1100_cache_clean_invalidate_range
> c0041304	swap_out_mm
> c0041168	swap_out_pmd
> c0044324	__get_swap_page
> c0040d60	zone_inactive_plenty
> c0041128	swap_out_pmd
> c0040fec	try_to_swap_out
> 
> Sysrq-M gives:
> 
> SysRq : Show Memory
> Mem-info:
> Free pages:        1012kB (     0kB HighMem)
> ( Active: 2007, inactive_dirty: 0, inactive_clean:
> 0, free: 253 (255 510 765) )
> 3*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB
> 1*512kB 0*1024kB 0*2048kB = 1012kB)
> = 0kB)
> = 0kB)
> Swap cache: add 0, delete 0, find 0/0
> Free swap:            0kB
> 8192 pages of RAM
> 393 free pages
> 636 reserved pages
> 33 pages shared
> 0 pages swap cached
> 6 page tables cached
> Buffer memory:     8000kB
> 
> 
> 2.4.9 kernel:
> =============
> 
> Unlike the first (quoted) run, this kernel
> completely stalled when the jam
> conditions were reached just like the run described
> above.  I mean here
> there is no audio stuttering at all, no echo from
> telnet sessions, nothing
> in user space gets to run anymore.  kswapd is well
> locked in the R state:
> 
> kswapd        R C0022CA0     0     4      0         
>    5     3 (L-TLB)
> 
> Kernel interrupts and BHs still work i.e. I can ping
> the box, the serial
> console still echoes characters (kernel termios),
> and sysrq works but that's
> all.  What's also interesting here is the fact that
> there is absolutely no
> NFS traffic going on.
> 
> A couple sysrq-P at random intervals shows the CPU
> looping in the following
> functions:
> 
> PC value	System.map
> --------	----------
> c003f6e0	zone_inactive_plenty
> c003fa58	swap_out_pmd
> c0060324	prune_icache
> c003f6fc	zone_inactive_plenty
> c003faac	swap_out_pmd
> c00209a0	cpu_sa1100_set_pte
> c003fc80	swap_out_mm
> c0040c10	refill_inactive_scan
> c00206c0	cpu_sa1100_cache_clean_invalidate_range
> c003fa90	swap_out_pmd
> 
> Sysrq-M gives:
> 
> SysRq: Show Memory
> Mem-info:
> Free pages:        1008kB (     0kB HighMem)
> ( Active: 2546, inactive_dirty: 63, inactive_clean:
> 0, free: 252 (255 510 765) )
> 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB
> 1*512kB 0*1024kB 0*2048kB = 1008kB)
> = 0kB)
> = 0kB)
> Swap cache: add 0, delete 0, find 0/0
> Free swap:            0kB
> 8192 pages of RAM
> 392 free pages
> 602 reserved pages
> 576 pages shared
> 0 pages swap cached
> 8 page tables cached
> Buffer memory:     8000kB
> 
> 
> Notes:
> ======
> 
> - Both kernels go flat after approx 14 min of mp3
> playback.
> - With enough retries (i.e. reboots) the gcc build
> succeed, so there is no
>   lack of ressources in theory.
> - SEnding a signal to the mp3 player (^C on the
> serial 
=== message truncated === 

=====
S.KIEU

_____________________________________________________________________________
http://shopping.yahoo.com.au - Father's Day Shopping
- Find the perfect gift for your Dad for Father's Day
