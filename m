Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270826AbTGNUQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270820AbTGNUOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:14:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23952
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270812AbTGNUNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:13:00 -0400
Date: Mon, 14 Jul 2003 22:27:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jens Axboe <axboe@suse.de>, Chris Mason <mason@suse.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030714202728.GT16313@dualathlon.random>
References: <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <20030714201637.GQ16313@dualathlon.random> <Pine.LNX.4.55L.0307141716400.8994@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307141716400.8994@freak.distro.conectiva>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 05:17:16PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Mon, 14 Jul 2003, Andrea Arcangeli wrote:
> 
> > On Mon, Jul 14, 2003 at 09:51:39PM +0200, Jens Axboe wrote:
> > > -	rl = &q->rq;
> > > -	if (!list_empty(&rl->free) && !blk_oversized_queue(q)) {
> > > +	if ((rw == WRITE) && (blk_oversized_queue(q) || (rl->count < 4)))
> >
> > did you disable the oversized queue check completely for reads? This
> > looks unsafe, you can end with loads of ram locked up this way, the
> > request queue cannot be limited in requests anymore. this isn't the
> > "request reservation", this a "nearly unlimited amount of ram locked in
> > for reads".
> >
> > Of course, the more reads can be in the queue, the less the background
> > write loads will hurt parallel apps like a kernel compile as shown in
> > xtar_load.
> >
> > This is very different from the schedule advantage provided by the old
> > queue model. If you allow an unlimited I/O queue for reads, that means
> > the I/O queues will be filled by an huge amount of reads and a few
> > writes (no matter how fast the xtar_load is writing to disk).
> >
> > In the past (2.4.22pre4) the I/O queue would been at most 50/50, with
> > your patch it can be 90/10, hence it can generate an huge performance
> > difference, that can penealize tremendously the writers in server loads
> > using fsync plus it can hurt the VM badly if all ram is locked up by
> > parallel reads. Of course contest mostly cares about reads, not writes.
> >
> > Overall I think your patch is unsafe and shouldn't be applied.
> >
> > Still if you want to allow 50/50, go ahead, that logic in pre4 was an
> > order of magnitude more fair and generic than this patch.
> 
> Well, I change my mind and wont apply it as-is in -pre6.

I would at least wait a clarification from Jens first. If I missed
something fundamental in my analysis of his patch, of course we could
apply it then, but at the moment it looks not safe and a bit cheating ;)

thanks,

Andrea
