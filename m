Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269726AbRHYQbu>; Sat, 25 Aug 2001 12:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269673AbRHYQbl>; Sat, 25 Aug 2001 12:31:41 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:1805 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269726AbRHYQbe>; Sat, 25 Aug 2001 12:31:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nicolas Pitre <nico@cam.org>
Subject: Re: What version of the kernel fixes these VM issues?
Date: Sat, 25 Aug 2001 18:38:12 +0200
X-Mailer: KMail [version 1.3.1]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108241940280.25240-100000@xanadu.home>
In-Reply-To: <Pine.LNX.4.33.0108241940280.25240-100000@xanadu.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010825163138Z16125-32384+506@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 25, 2001 05:00 am, Nicolas Pitre wrote:
> This board has 32MB RAM, no swap.  Root fs is NFS.  On the serial console I
> start a command line mp3 player.  In a first telnet session I start a build
> of gcc 3.0 (./configure; make).  In a second telnet session I start 'top'.
> Music plays while gcc builds and I can see the CPU usage within top.
> Pretty real scenario, real life situation, expected system load, no trick.

You're streaming the mp3 over nfs, right?  From your setup I'd guess there's 
no local hard disk.

> nfs: task 41867 can't get a request slot
> nfs: task 41868 can't get a request slot
> nfs: task 41869 can't get a request slot

Uhuh.  Would you please look in your logs for "allocation failed" messages?
(Side note: reading the nfs code now... to whose eyes are names like tk_rqstp 
beautiful?)

> ( Active: 2007, inactive_dirty: 0, inactive_clean: 0, free: 253 (255 510 
765) )

Whoops, nothing inactive but kswap going full blast.  We're getting warmer.

> 2.4.9 kernel:
> =============
> 
> Unlike the first (quoted) run, this kernel completely stalled when the jam
> conditions were reached just like the run described above.  I mean here
> there is no audio stuttering at all, no echo from telnet sessions, nothing
> in user space gets to run anymore.

Yes, a slight difference, however they are both wedged in the same way, from 
your task samples:

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

> Kernel interrupts and BHs still work i.e. I can ping the box, the serial
> console still echoes characters (kernel termios), and sysrq works but that's
> all.  What's also interesting here is the fact that there is absolutely no
> NFS traffic going on.

That's understandable.  Everything that needs to allocate memory is wedged.

> - The same behavior occurs with 2.4.8-ac4.

How far back do you have to go before you get one that works?  I seem to 
recall the inactive_plenty changes came in at 2.4.8-pre1.  Could you try it 
with 2.4.7, please.

--
Daniel
