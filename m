Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbSI0KUD>; Fri, 27 Sep 2002 06:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbSI0KUD>; Fri, 27 Sep 2002 06:20:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45463 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261683AbSI0KUA>;
	Fri, 27 Sep 2002 06:20:00 -0400
Date: Fri, 27 Sep 2002 12:25:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthew Jacob <mjacob@feral.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file transfers
Message-ID: <20020927102503.GA15101@suse.de>
References: <20020927074509.GA860@suse.de> <Pine.BSF.4.21.0209270055290.18408-100000@beppo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.21.0209270055290.18408-100000@beppo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27 2002, Matthew Jacob wrote:
> > > I'd just suggest that it's asinine to criticise an HBA for running up to
> > > reasonable limits when it's the non-toy OS that will do sensible I/O
> > > scheduling. So point your gums elsewhere.
> > 
> > Well I don't think 253 is a reasonable limit, that was the whole point.
> > How can sane io scheduling ever prevent starvation in that case? I can't
> > point my gums elsewhere, this is where I'm seeing starvation.
> 
> You're in starvation because the I/O midlayer and buffer cache are
> allowing you to build enough transactions on one bus to impact system
> response times. This is an old problem with Linux that comes and goes

That's one type of starvation, but that's one that can be easily
prevented by the os. Not a problem.

The starvation I'm talking about is the drive starving requests. Just
keep it moderately busy (10-30 outstanding tags), and a read can take a
long time to complete. The hba can try to prevent this from happening by
issuing ever Xth request as on ordered tag, however the fact that we
even need to consider doing this suggests to me that something is
broken. That a drive can starve a single request for that long is _bad_.
Issuing every 1024th request as ordered helps absolutely zip for good
interactive behaviour. It might help on a single request basis, but good
latency feel typically requires more than that.

We _can_ try and prevent this type of starvation. If we encounter a
read, don't queue any more writes to the drive before it completes.
That's some simple logic that will probably help a lot. This is the type
of thing the deadline io scheduler tries to do. This is working around
broken drive firmware in my oppinion, the drive shouldn't be starving
requests like that.

However, it's stupid to try and work around a problem if we can simply
prevent the problem in the first place. What is the problem? It's lots
of tags causing the drive to starve requests. Do we need lots of tags?
In my experience 4 tags is more than plenty for a typical drive, there's
simply _no_ benefit from going beyond that. It doesn't buy you extra
throughput, it doesn't buy you better io scheduling (au contraire). All
it gets you is lots of extra latency. So why would I want lots of tags
on a typical scsi drive? I don't.

> (as it has come and gone for most systems). There are a number of
> possible solutions to this problem- but because this is in 2.4 perhaps
> the most sensible one is to limit how much you *ask* from an HBA,
> perhaps based upon even as vague a set of parameters as CPU speed and
> available memory divided by the number of <n-scsibus/total spindles).

This doesn't make much sense to me. Why would the CPU speed and
available memory impact this at all? We don't want to deplete system
resources (the case Justin mentioned), of course, but beyond that I
don't think it makes much sense.

> It's the job of the HBA driver to manage resources on the the HBA and on
> the bus the HBA interfaces to. If the HBA and its driver can efficiently
> manage 1000 concurrent commands per lun and 16384 luns per target and
> 500 'targets' in a fabric, let it.

Yes, if the hba and its drive _and_ the target can _efficiently_ handle
it, I'm all for it. Again you seem to be comparing the typical scsi hard
drive to more esoteric devices. I'll note again that I'm not talking
about such devices.

> Let oversaturation of a *spindle* be informed by device quirks and the
> rate of QFULLs received, or even, if you will, by finding the knee in

If device quirks are that 90% (pulling this number out of my ass) of
scsi drives use pure internal sptf scheduling and thus heavily starve
requests, then why bother? Queue full contains no latency information.

> the per-command latency curve (if you can and you think that it's

I can try to get a decent default. 253 clearly isn't it, far from it.

> meaningful). Let oversaturation of the system be done elsewhere- let the
> buffer cache manager and system policy knobs decide whether the fact
> that the AIC driver is so busy moving I/O that the user can't get window
> focus onto the window in N-P complete time to kill the runaway tar.

This is not a problem with the vm flooding a spindle. We want it to be
flooded, the more we can shove into the io scheduler to work with, the
better chance it has of doing a good job.

> Sorry- an overlong response. It *is* easier to just say "well, 'fix' the
> HBA driver so it doesn't allow the system to get too busy or
> overloaded". But it seems to me that this is even best solved in the
> midlayer which should, in fact, know best (better than a single HBA).

Agrh. Who's saying 'fix' the hba driver? Either I'm not expressing
myself very clearly, or you are simply not reading what I write.

-- 
Jens Axboe

