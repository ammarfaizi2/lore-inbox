Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUD1Ej1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUD1Ej1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 00:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUD1Ej1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 00:39:27 -0400
Received: from o.q.net ([64.142.67.161]:29956 "EHLO O.Q.NET")
	by vger.kernel.org with ESMTP id S264298AbUD1EjW (ORCPT
	<rfc822;linux-kernel@VGER.KERNEL.ORG>);
	Wed, 28 Apr 2004 00:39:22 -0400
RECEIVED: FROM a.q.net ([2001:5a8:4:ed0:66::1] helo=localhost)
	BY O.Q.NET WITH esmtp (Exim 4.31 #1 (Debian))
	ID 1BIgqt-0000cD-Ok; Tue, 27 Apr 2004 21:39:19 -0700
Date: Tue, 27 Apr 2004 21:39:19 -0700 (PDT)
Message-Id: <20040427.213919.884032925.ulmo-u@Q.Net>
References: <20040222164941.D6046@foo.ardendo.se>
	<20040223121959.A8354@infradead.org>
	<1077543963.1246.20.camel@harrier.lucky.linux.kernel>
To: linux-kernel@VGER.KERNEL.ORG
Cc: Brad Allen <Ulmo-Usenet@Usenet.Q.Net>
from: Brad Allen <Ulmo-Usenet@Usenet.Q.Net>
Subject: allocation failures with CBQ bandwidth limiting & high net use
 (was Re: Filesystem kernel hangup, 2.6.3 (bad: scheduling while atomic!))
X-Mailer: Mew version 3.3 on XEmacs 21.4.12 (Portable Code)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just tried it without HyperThreading, with JFS, the filesystem
> hanged without any kernel oops after about 10 minutes of 1Gbit/s FTP
> input.
> 
> What I got was:   [...]
> mserv4 kernel: swapper: page allocation failure. order:0, mode:0x20   [...]
> mserv4 kernel:  [<c02ad599>] e1000_alloc_rx_buffers+0x59/0x100


I just corresponded a problem I originally thought yours might be
related to, so now I think it's even less likely they're related.

After a due-diligence check for latest version before post, I found
and upgraded to kernel version 2.6.6-rc3, and during my tests of that
new version inadvertently finally found the test that revealed a
correspondence with these errors: running CBQ network bandwidth
limiting, queuing and prioritization, *and* high network use (using
that bandwidth limiting).  The CBQ stuff is done at boot.  As soon as
I started the high network use, the problem started (see below
"full_kernel_output" file for an idea of what kernel messages I was
seeing en masse), and then during this high network use, I turned off
CBQ and everything was normal again.


This is what I wrote before the above discovery, which gives
background:


I'm also seeing "page allocation failure" errors in a 2.6 series
kernel with e1000 driver with lots of filesystem access and lots of
outbound network, which I think are our common themes.  I'm seeing the
call trace with e1000 driver routines in nearly every list.
Otherwise, much else is different:

* Linux kernel 2.6.6-rc2 used for this particular run
  as documented, but same allocation failure errors
  also seen in 2.6.6-rc3, 2.6.6-rc1, 2.6.5,
  2.6.5+kraxel263-1, 2.6.4+kraxel263-1 (+kraxel is
  drivers/media/video stuff ported in sooner than 2.6
  series got it).
* I was doing relatively heavy client NFSv3, not XFS
  or JFS like you: ~2MiB/s steady write, ~2MiB/s
  steady read.  (Test ran for ~2 hours.  Crashed
  with only 37s to go before filling up remote disk!
  Coincidence, because it had no idea the remote disk
  was getting full, I think ... but never did finish
  filling it, which was my planned test end point.)
* I am using experimental IVTV driver, which is
  itself having trouble and undergoing active
  development, to record and play TV using Hauppauge
  990 (WinTV PVR 350).  This card does all the heavy
  compute intensive stuff: MPEG2 encode & decode, as
  well as TV stuff.  The computer merely has to
  bitshuffle & stuff, which is *not* that hard.  The
  bandwidth of the system ought to allow more like four
  of these cards recording & at least one playing, if
  things were tuned right, I think.
* My IRQ is shared with that above TV card, e1000
  (Intel GbE) card, and video output card; the first
  two get used extensively (the last one -- the local
  console video -- almost never gets used, except for
  printk).
* I had network output going almost full-bore, as
  a stress test of the above, but I still get the
  errors when this isn't the case.  61,840B/s inside
  TCP/IP.
* I am using CBQ to limit network output speed to
  Intenret, and priority of packets.  62,464B/s including
  IP packets (headers, etc.).  Link measured max at a
  rough ~66,560B/s inside TCP/IP, so I stay away from it.
  So, this is basically definitely hitting output
  speed buffering on occasion.
* It's bridging between two ethernet cards (sender
  of through-IP traffic (~61,840B/s) in from the
  e1000 GbE card, being sent out an on-board 100MbE).
  NFSv3 (from & to server) isn't bridged, but also
  is going via that e1000 GbE card.
* The computer I'm seeing this on is relatively old
  and moderately low resource for today's memory &
  CPU use standards:
  1999 Dell Optiplex GX1 PIII 450MHz 128MiB ram

I'm not sure if this is related to your problem.  I searched
linux-kernel by using the two quoted phrases "page allocation failure"
"e1000_alloc_rx_buffers" in Google, and your above message is the only
one that came out.

I am worried that perhaps page allocation failures are very vague
diagnostic tools.  I take it this simply means I ran out of (perhaps a
certain kind of, e.g. and what I suspect, kernel) memory.

Here is the kernel message output (one sample excerpt below):

  ftp://ftp.sonic.net/pub/users/ulmo/ivtv/full_kernel_output.bz2

and .config options:

  ftp://ftp.sonic.net/pub/users/ulmo/SW/OS/linux/2.6.6-rc2.config.bz2

Here's my CBQ script:

  ftp://ftp.sonic.net/pub/users/ulmo/SW/OS/linux/tc.sh

Note that I *do* use LVM (everyone I talk to seems to -- although I
think it's called DM now; btw, I do use and like EVMS on more modern
hosts -- and I'm sure I'd like it on old ones, too, but just haven't
bothered to do it there), but since not much of that computer's access
is via local disk, I doubt that matters that much.

My MTU for GbE (e1000) is 9000, and NFS block size 8192 bytes.
That GbE is a consumer grade Intel model.

Here is a sample of the kernel output; note please that these errors
are not all exactly identical, so if you are reading them please check
the above full_kernel_output for any nuances and big differences (all
kernel messages for about two hours from boot to crash).

swapper: page allocation failure. order:3, mode:0x20
Call Trace:
 [__alloc_pages+696/784] __alloc_pages+0x2b8/0x310
 [__get_free_pages+34/80] __get_free_pages+0x22/0x50
 [cache_grow+165/656] cache_grow+0xa5/0x290
 [cache_alloc_refill+354/512] cache_alloc_refill+0x162/0x200
 [do_timer+224/240] do_timer+0xe0/0xf0
 [__kmalloc+140/176] __kmalloc+0x8c/0xb0
 [alloc_skb+72/240] alloc_skb+0x48/0xf0
 [e1000_alloc_rx_buffers+102/272] e1000_alloc_rx_buffers+0x66/0x110
 [e1000_clean_rx_irq+225/1056] e1000_clean_rx_irq+0xe1/0x420
 [scheduler_tick+31/1312] scheduler_tick+0x1f/0x520
 [e1000_intr+58/144] e1000_intr+0x3a/0x90
 [handle_IRQ_event+59/112] handle_IRQ_event+0x3b/0x70
 [do_IRQ+150/336] do_IRQ+0x96/0x150
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [default_idle+38/64] default_idle+0x26/0x40
 [cpu_idle+52/64] cpu_idle+0x34/0x40
 [start_kernel+415/480] start_kernel+0x19f/0x1e0
 [unknown_bootoption+0/288] unknown_bootoption+0x0/0x120
