Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTLaQIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 11:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbTLaQIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 11:08:17 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:1002 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265182AbTLaQIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 11:08:15 -0500
Subject: Re: question about BIO/request ordering / barriers
From: Christophe Saout <christophe@saout.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       DM-Devel <dm-devel@sistina.com>
In-Reply-To: <20031231155607.GA5523@suse.de>
References: <1072879267.22227.10.camel@leto.cs.pocnet.net>
	 <20031231155607.GA5523@suse.de>
Content-Type: text/plain
Message-Id: <1072886889.4395.7.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Dec 2003 17:08:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, den 31.12.2003 schrieb Jens Axboe um 16:56:

[Sorry for quoting the whole thing again, but I think the DM developers
might know about the issue too]

> On Wed, Dec 31 2003, Christophe Saout wrote:
> > Hi!
> > 
> > I'm just digging through the device-mapper code and a question came up:
> > 
> > Are "intermediate block device drivers" (like device-mapper) allowed to
> > reorder BIOs?
> > 
> > I'm not talking about BIOs submitted from different threads at the same
> > time but BIOs submitted from the same thread sequentially, especially
> > writes.
> > 
> > That would mean that BIOs might be reordered around barriers which would
> > break potential users.
> 
> That would not be a good idea. Reordering around a barrier is forbidden,
> you may reorder as you please otherwise. Consider yourself the io
> scheduler, that is essentially the function you are performing. The io
> scheduler will honor the barrier as well.
> 
> > At the moment I suppose this shouldn't be an issue because I didn't find
> > a single user in the whole kernel that actually submits BIOs with
> > BIO_RW_BARRIER set via submit_bio/generic_make_request (journaling
> > filesystems are simply waiting until all writes are finished before
> > continueing, right?).
> 
> Right, there are some missing bits still.

Ah, ok. So things are probably going to break in the future if they
aren't fixed now. That's what I wanted do know.

> > There are same cases (in device-mapper) where
> > 
> > a) writes get get suspended and queued for later submission where it is
> > not ensured that those writes are submitted before any other writes that
> > could possibly occur after the device gets resumed (generic dm code)
> > b) a stack (instead of a fifo) is used to queue requests and submit them
> > later (not yet included code)
> > c) writes can get queued but reads are directly passed through
> > (snapshotting code too)
> > 
> > Also, if DM recevices a barrier shouldn't this barrier be somehow sent
> > to all real devices instead of the one that the request is actually sent
> > to?
> 
> Yes, the driver must take whatever precautions necessary...

Ok, thanks. Let's see what can be done about that.

Is it possible to create empty BIOs that just act as barrier? 

Because I think when device-mapper encounters a BIO with BIO_RW_BARRIER
set it then should also create barriers for the other devices.


