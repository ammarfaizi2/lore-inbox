Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261674AbSI0IcJ>; Fri, 27 Sep 2002 04:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261670AbSI0IcJ>; Fri, 27 Sep 2002 04:32:09 -0400
Received: from beppo.feral.com ([192.67.166.79]:6672 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S261652AbSI0IcH>;
	Fri, 27 Sep 2002 04:32:07 -0400
Date: Fri, 27 Sep 2002 01:37:18 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Jens Axboe <axboe@suse.de>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file
 transfers
In-Reply-To: <20020927074509.GA860@suse.de>
Message-ID: <Pine.BSF.4.21.0209270055290.18408-100000@beppo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Fri, Sep 27 2002, Matthew Jacob wrote:
> > 
> > The issue here is not whether it's appropriate to oversaturate the
> > 'standard' SCSI drive- it isn't- I never suggested it was.
> 
> Ok so we agree. I think our oversaturate thresholds are different,
> though.

I think we simply disagree as to where to put them. See below.

> 
> > I'd just suggest that it's asinine to criticise an HBA for running up to
> > reasonable limits when it's the non-toy OS that will do sensible I/O
> > scheduling. So point your gums elsewhere.
> 
> Well I don't think 253 is a reasonable limit, that was the whole point.
> How can sane io scheduling ever prevent starvation in that case? I can't
> point my gums elsewhere, this is where I'm seeing starvation.

You're in starvation because the I/O midlayer and buffer cache are
allowing you to build enough transactions on one bus to impact system
response times. This is an old problem with Linux that comes and goes
(as it has come and gone for most systems). There are a number of
possible solutions to this problem- but because this is in 2.4 perhaps
the most sensible one is to limit how much you *ask* from an HBA,
perhaps based upon even as vague a set of parameters as CPU speed and
available memory divided by the number of <n-scsibus/total spindles).

It's the job of the HBA driver to manage resources on the the HBA and on
the bus the HBA interfaces to. If the HBA and its driver can efficiently
manage 1000 concurrent commands per lun and 16384 luns per target and
500 'targets' in a fabric, let it.

Let oversaturation of a *spindle* be informed by device quirks and the
rate of QFULLs received, or even, if you will, by finding the knee in
the per-command latency curve (if you can and you think that it's
meaningful). Let oversaturation of the system be done elsewhere- let the
buffer cache manager and system policy knobs decide whether the fact
that the AIC driver is so busy moving I/O that the user can't get window
focus onto the window in N-P complete time to kill the runaway tar.

Sorry- an overlong response. It *is* easier to just say "well, 'fix' the
HBA driver so it doesn't allow the system to get too busy or
overloaded". But it seems to me that this is even best solved in the
midlayer which should, in fact, know best (better than a single HBA).

-matt


