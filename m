Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbTGEAdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 20:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbTGEAdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 20:33:22 -0400
Received: from 69-55-72-144.ppp.netsville.net ([69.55.72.144]:429 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S266244AbTGEAdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 20:33:21 -0400
Subject: Re: Status of the IO scheduler fixes for 2.4
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Nick Piggin <piggin@cyberone.com.au>
In-Reply-To: <20030705000544.GC23578@dualathlon.random>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva>
	 <Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva>
	 <1057197726.20903.1011.camel@tiny.suse.com>
	 <Pine.LNX.4.55L.0307041639020.7389@freak.distro.conectiva>
	 <1057354654.20903.1280.camel@tiny.suse.com>
	 <20030705000544.GC23578@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1057366019.20899.1300.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 04 Jul 2003 20:47:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-04 at 20:05, Andrea Arcangeli wrote:
> On Fri, Jul 04, 2003 at 05:37:35PM -0400, Chris Mason wrote:
> > I've also attached a patch I've been working on to solve the latencies a
> > different way.  bdflush-progress.diff changes balance_dirty to wait on
> > bdflush instead of trying to start io.  It helps a lot here (both
> > throughput and latency) but hasn't yet been tested on a box with tons of
> > drives.
> 
> that's orthogonal, it changes the write throttling, it doesn't touch the
> blkdev layer like the other patches does. So if it helps it solves a
> different kind of latencies.

It's also almost useless without elevator-low-latency applied ;-)  One
major source of our latencies is a bunch of procs hammering on
__get_request_wait, so bdflush-progess helps by reducing the number of
procs doing io.  It does push some of the latency problem up higher into
balance_dirty, but I believe it is easier to manage there.

bdflush-progress doesn't help at all for non-async workloads.

> However the implementation in theory can run the box oom, since it won't
> limit the dirty buffers anymore. To be safe you need to wait 2
> generations. I doubt in practice it would be easily reproducible though ;).

Hmmm, I think the critical part here is to write some buffers after
marking a buffer dirty.  We don't check the generation number until
after marking the buffer dirty, so if the generation has incremented at
all we've made progress.  What am I missing?

-chris


