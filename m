Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270359AbTGMTTN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270360AbTGMTTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:19:13 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11183
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270359AbTGMTTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:19:06 -0400
Date: Sun, 13 Jul 2003 21:33:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chris Mason <mason@suse.com>, Jens Axboe <axboe@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030713193334.GK16313@dualathlon.random>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva> <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <1058113238.13313.127.camel@tiny.suse.com> <3F118CC6.9080906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F118CC6.9080906@pobox.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 12:45:58PM -0400, Jeff Garzik wrote:
> Chris Mason wrote:
> >Well, I'd say it's a more common problem to have lots of writes, but it
> >is pretty easy to fill the queue with reads.
> 
> Well....
> 
> * you will usually have more reads than writes
> * reads are more dependent than writes, on the whole
> * writes are larger due to delays and merging
> 
> All this is obviously workload dependent, but it seems like the 60% 
> common case, at least...

sync-reads may be as much as 99%. I'm not overlooking sync-reads, I'm
saying sync-writes are important too, and this design is meant to fix
sync-reads as well as sync-writes.

> Basically when I hear people talking about lots of writes, that seems to 
> be downplaying the fact that seeing 20 writes and 2 reads on a queue 
> does not take into account the userspace applications currently 
> blocking, waiting to do another read.

this is not overlooked. The point is that those 2 reads tends to wait
for at least batch_sectors anyways, so it doesn't matter if they wait
for those batch_sectors inside the I/O queue, or in wait_for_request. I
mean, I don't see why being able to wait only in the I/O queue could
make a relevant latency improvement (of course it will save a schedule
but who cares about a schedule on such a sync-workload?)

What you've to care about is that this "read-sync" is the very next one
to get the I/O in wait_for_request, not the write. and this is fixed
now.

in the past (even in 2.4.21) the wait_for_request was broken, so hitting
that path would risk to hang reads forever (there was no ->full control
etc..). Now it's not the case anymore. if the read is still stalled
forever it means wait_for_request needs more fixes than what's already
in mainline in 22pre5.

In the past with broken wait_for_request things were completely
different so using old benchmarks as an argument doesn't sound
completely correct to me. More interesting would be the theories about
why those past benchmarks shown the relevant improvements (latency?
throughput?), so we can see if those theories still applies to the new
lowlatency-elevator fixed code in mainline.

Andrea
