Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266247AbTGEAu3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 20:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266251AbTGEAu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 20:50:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18381
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266247AbTGEAuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 20:50:23 -0400
Date: Sat, 5 Jul 2003 03:04:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Status of the IO scheduler fixes for 2.4
Message-ID: <20030705010448.GE23578@dualathlon.random>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva> <Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva> <1057197726.20903.1011.camel@tiny.suse.com> <Pine.LNX.4.55L.0307041639020.7389@freak.distro.conectiva> <1057354654.20903.1280.camel@tiny.suse.com> <20030705000544.GC23578@dualathlon.random> <1057366019.20899.1300.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057366019.20899.1300.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 08:47:00PM -0400, Chris Mason wrote:
> On Fri, 2003-07-04 at 20:05, Andrea Arcangeli wrote:
> > On Fri, Jul 04, 2003 at 05:37:35PM -0400, Chris Mason wrote:
> > > I've also attached a patch I've been working on to solve the latencies a
> > > different way.  bdflush-progress.diff changes balance_dirty to wait on
> > > bdflush instead of trying to start io.  It helps a lot here (both
> > > throughput and latency) but hasn't yet been tested on a box with tons of
> > > drives.
> > 
> > that's orthogonal, it changes the write throttling, it doesn't touch the
> > blkdev layer like the other patches does. So if it helps it solves a
> > different kind of latencies.
> 
> It's also almost useless without elevator-low-latency applied ;-)  One
> major source of our latencies is a bunch of procs hammering on
> __get_request_wait, so bdflush-progess helps by reducing the number of
> procs doing io.  It does push some of the latency problem up higher into
> balance_dirty, but I believe it is easier to manage there.
> 
> bdflush-progress doesn't help at all for non-async workloads.

agreed.

> > However the implementation in theory can run the box oom, since it won't
> > limit the dirty buffers anymore. To be safe you need to wait 2
> > generations. I doubt in practice it would be easily reproducible though ;).
> 
> Hmmm, I think the critical part here is to write some buffers after
> marking a buffer dirty.  We don't check the generation number until

btw, not after a buffer, but after as much as "buffers per page" buffers
(infact for the code to be correct on systems with quite big page size
the 32 should be replaced with a max(bh_per_page, 32))

> after marking the buffer dirty, so if the generation has incremented at
> all we've made progress.  What am I missing?

	write 32 buffers
				read generation
	inc generation
				generation changed -> OOM

Am I missing any smp serialization between the two cpus?

Andrea
