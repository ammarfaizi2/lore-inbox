Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUABKo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 05:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbUABKo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 05:44:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48060 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265500AbUABKoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 05:44:24 -0500
Date: Fri, 2 Jan 2004 11:44:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Christophe Saout <christophe@saout.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       DM-Devel <dm-devel@sistina.com>
Subject: Re: question about BIO/request ordering / barriers
Message-ID: <20040102104419.GM5523@suse.de>
References: <1072879267.22227.10.camel@leto.cs.pocnet.net> <20031231155607.GA5523@suse.de> <1072886889.4395.7.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072886889.4395.7.camel@leto.cs.pocnet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31 2003, Christophe Saout wrote:
> Am Mi, den 31.12.2003 schrieb Jens Axboe um 16:56:
> 
> [Sorry for quoting the whole thing again, but I think the DM developers
> might know about the issue too]
> 
> > On Wed, Dec 31 2003, Christophe Saout wrote:
> > > Hi!
> > > 
> > > I'm just digging through the device-mapper code and a question came up:
> > > 
> > > Are "intermediate block device drivers" (like device-mapper) allowed to
> > > reorder BIOs?
> > > 
> > > I'm not talking about BIOs submitted from different threads at the same
> > > time but BIOs submitted from the same thread sequentially, especially
> > > writes.
> > > 
> > > That would mean that BIOs might be reordered around barriers which would
> > > break potential users.
> > 
> > That would not be a good idea. Reordering around a barrier is forbidden,
> > you may reorder as you please otherwise. Consider yourself the io
> > scheduler, that is essentially the function you are performing. The io
> > scheduler will honor the barrier as well.
> > 
> > > At the moment I suppose this shouldn't be an issue because I didn't find
> > > a single user in the whole kernel that actually submits BIOs with
> > > BIO_RW_BARRIER set via submit_bio/generic_make_request (journaling
> > > filesystems are simply waiting until all writes are finished before
> > > continueing, right?).
> > 
> > Right, there are some missing bits still.
> 
> Ah, ok. So things are probably going to break in the future if they
> aren't fixed now. That's what I wanted do know.

Yep

> > > There are same cases (in device-mapper) where
> > > 
> > > a) writes get get suspended and queued for later submission where it is
> > > not ensured that those writes are submitted before any other writes that
> > > could possibly occur after the device gets resumed (generic dm code)
> > > b) a stack (instead of a fifo) is used to queue requests and submit them
> > > later (not yet included code)
> > > c) writes can get queued but reads are directly passed through
> > > (snapshotting code too)
> > > 
> > > Also, if DM recevices a barrier shouldn't this barrier be somehow sent
> > > to all real devices instead of the one that the request is actually sent
> > > to?
> > 
> > Yes, the driver must take whatever precautions necessary...
> 
> Ok, thanks. Let's see what can be done about that.
> 
> Is it possible to create empty BIOs that just act as barrier? 

Unfortunately no, the barrier bit currently has to be tied to a bio with
content. I'd be willing to accept a patch to send down empty barrier
bio's though, it's a useful feature in this context.

> Because I think when device-mapper encounters a BIO with BIO_RW_BARRIER
> set it then should also create barriers for the other devices.

It's pretty tricky. Search the list archives for past discussions on
this.

-- 
Jens Axboe

