Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265174AbTLaP4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbTLaP4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:56:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40884 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265174AbTLaP4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:56:12 -0500
Date: Wed, 31 Dec 2003 16:56:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Christophe Saout <christophe@saout.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question about BIO/request ordering / barriers
Message-ID: <20031231155607.GA5523@suse.de>
References: <1072879267.22227.10.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072879267.22227.10.camel@leto.cs.pocnet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31 2003, Christophe Saout wrote:
> Hi!
> 
> I'm just digging through the device-mapper code and a question came up:
> 
> Are "intermediate block device drivers" (like device-mapper) allowed to
> reorder BIOs?
> 
> I'm not talking about BIOs submitted from different threads at the same
> time but BIOs submitted from the same thread sequentially, especially
> writes.
> 
> That would mean that BIOs might be reordered around barriers which would
> break potential users.

That would not be a good idea. Reordering around a barrier is forbidden,
you may reorder as you please otherwise. Consider yourself the io
scheduler, that is essentially the function you are performing. The io
scheduler will honor the barrier as well.

> At the moment I suppose this shouldn't be an issue because I didn't find
> a single user in the whole kernel that actually submits BIOs with
> BIO_RW_BARRIER set via submit_bio/generic_make_request (journaling
> filesystems are simply waiting until all writes are finished before
> continueing, right?).

Right, there are some missing bits still.

> There are same cases (in device-mapper) where
> 
> a) writes get get suspended and queued for later submission where it is
> not ensured that those writes are submitted before any other writes that
> could possibly occur after the device gets resumed (generic dm code)
> b) a stack (instead of a fifo) is used to queue requests and submit them
> later (not yet included code)
> c) writes can get queued but reads are directly passed through
> (snapshotting code too)
> 
> Also, if DM recevices a barrier shouldn't this barrier be somehow sent
> to all real devices instead of the one that the request is actually sent
> to?

Yes, the driver must take whatever precautions necessary...

-- 
Jens Axboe

