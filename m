Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270321AbTGMRqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 13:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270324AbTGMRqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 13:46:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57261 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270321AbTGMRqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 13:46:21 -0400
Date: Sun, 13 Jul 2003 19:47:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030713174709.GA843@suse.de>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva> <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <1058113238.13313.127.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058113238.13313.127.camel@tiny.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13 2003, Chris Mason wrote:
> On Sun, 2003-07-13 at 05:01, Jens Axboe wrote:
> > On Sat, Jul 12 2003, Chris Mason wrote:
> > > On Sat, 2003-07-12 at 03:37, Jens Axboe wrote:
> > > 
> > > > > I believe the new way provides better overall read performance in the
> > > > > presence of lots of writes.
> > > > 
> > > > I fail to see the logic in that. Reads are now treated fairly wrt
> > > > writes, but it would be really easy to let writes consume the entire
> > > > capacity of the queue (be it all the requests, or just going oversized).
> > > > 
> > > > I think the oversized logic is flawed right now, and should only apply
> > > > to writes. Always let reads get through. And don't let writes consume
> > > > the last 1/8th of the requests, or something like that at least. I'll
> > > > try and do a patch for pre4.
> > > 
> > > If we don't apply oversized checks to reads, what keeps a big streaming
> > > reader from starving out all the writes?
> > 
> > It's just so much easier to full the queue with writes than with reads.
> > 
> 
> Well, I'd say it's a more common problem to have lots of writes, but it
> is pretty easy to fill the queue with reads.

s/easy/occurs often. Bad wording, yes of course it's trivial to make it
happen. But on a desktop machine, it rarely does. Can't say the same
thing about writes.

> > > The current patch provides a relatively fixed amount of work to get a
> > > request, and I don't think we should allow that to be bypassed.  We
> > > might want to add a special case for synchronous reads (like bread), via
> > > a b_state bit that tells the block layer an immediate unplug is coming
> > > soon.  That way the block layer can ignore the oversized checks, grant a
> > > request and unplug right away, hopefully lowering the total number of
> > > unplugs the synchronous reader has to wait through.
> > > 
> > > Anyway, if you've got doubts about the current patch, I'd be happy to
> > > run a specific benchmark you think will show the bad read
> > > characteristics.
> > 
> > No I don't have anything specific, it just seems like a bad heuristic to
> > get rid of. I can try and do some testing tomorrow. I do feel strongly
> > that we should at least make sure to reserve a few requests for reads
> > exclusively, even if you don't agree with the oversized check. Anything
> > else really contradicts all the io testing we have done the past years
> > that shows how important it is to get a read in ASAP. And doing that in
> > the middle of 2.4.22-pre is a mistake imo, if you don't have numbers to
> > show that it doesn't matter for the quick service of reads.
> 
> I believe elevator-lowlatency tries to solve the 'get a read in ASAP'
> from a different direction, by trying to limit both the time required to
> get a request and the time for required for the unplug to run.  Most of
> my numbers so far have been timing reads in the face of lots of writes,
> where elevator-lowlatency is a big win.
> 
> It should make sense to have a reserve of requests for reads, but I
> think this should be limited to the synchronous reads.  Still, I haven't
> been playing with all of this for very long, so your ideas are much
> appreciated.

Just catering to the sync reads is probably good enough, and I think
that passing in that extra bit of information is done the best through
just a b_state bit.

I'll try and bench a bit tomorrow with that patched in.

-- 
Jens Axboe

