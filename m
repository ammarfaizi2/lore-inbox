Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTGOFL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTGOFL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:11:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25741 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262283AbTGOFL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:11:57 -0400
Date: Tue, 15 Jul 2003 07:26:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Chris Mason <mason@suse.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715052640.GY833@suse.de>
References: <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <20030714201637.GQ16313@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714201637.GQ16313@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14 2003, Andrea Arcangeli wrote:
> On Mon, Jul 14, 2003 at 09:51:39PM +0200, Jens Axboe wrote:
> > -	rl = &q->rq;
> > -	if (!list_empty(&rl->free) && !blk_oversized_queue(q)) {
> > +	if ((rw == WRITE) && (blk_oversized_queue(q) || (rl->count < 4)))
> 
> did you disable the oversized queue check completely for reads? This

Yes

> looks unsafe, you can end with loads of ram locked up this way, the
> request queue cannot be limited in requests anymore. this isn't the
> "request reservation", this a "nearly unlimited amount of ram locked in
> for reads".

Sorry, but I think that is nonsense. This is the way we have always
worked. You just have to maintain a decent queue length still (like we
always have in 2.4) and there are no problems.

> Of course, the more reads can be in the queue, the less the background
> write loads will hurt parallel apps like a kernel compile as shown in
> xtar_load.
> 
> This is very different from the schedule advantage provided by the old
> queue model. If you allow an unlimited I/O queue for reads, that means
> the I/O queues will be filled by an huge amount of reads and a few
> writes (no matter how fast the xtar_load is writing to disk).
> 
> In the past (2.4.22pre4) the I/O queue would been at most 50/50, with
> your patch it can be 90/10, hence it can generate an huge performance
> difference, that can penealize tremendously the writers in server loads
> using fsync plus it can hurt the VM badly if all ram is locked up by
> parallel reads. Of course contest mostly cares about reads, not writes.
> 
> Overall I think your patch is unsafe and shouldn't be applied.

It is _not_ unsafe, stop spewing nonsense like that. The patch should
not be applied, it's just the first few things I did to see if it would
make a difference like I described. And it had a big effect, so I posted
results and went to bed. Know we have a grounds for further discussion,
and I'll bench the changes seperately too as well. It's about getting
data points you can use, you have to try extremese as well.

> Still if you want to allow 50/50, go ahead, that logic in pre4 was an
> order of magnitude more fair and generic than this patch.

Sigh... No I don't want 90/10 distribution of course, that would be
silly.

-- 
Jens Axboe

