Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293013AbSCOR5h>; Fri, 15 Mar 2002 12:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293020AbSCOR52>; Fri, 15 Mar 2002 12:57:28 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21794 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293013AbSCOR5M>; Fri, 15 Mar 2002 12:57:12 -0500
Date: Fri, 15 Mar 2002 18:57:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre3aa2
Message-ID: <20020315185747.P10073@dualathlon.random>
In-Reply-To: <20020314032801.C1273@dualathlon.random> <3C912ACF.AF3EE6F0@pp.inet.fi> <20020315105621.GA22169@suse.de> <3C9230C6.4119CB4C@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C9230C6.4119CB4C@pp.inet.fi>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 07:35:02PM +0200, Jari Ruusu wrote:
> Jens Axboe wrote:
> > On Fri, Mar 15 2002, Jari Ruusu wrote:
> > > - No more illegal sleeping in generic_make_request().
> > 
> > I've told you this before -- sleeping in make_request is not illegal,
> > heck it happens _all the time_. Safely sleeping requires a reserved pool
> > of the units you wish to allocate, of course. In fact I think that would
> > be much nicer than the path you are following here by delaying
> > allocations to the loop thread (and still not using a reserved pool).
> 
> Yes, I know you have told me that before, but I'm being overcareful. See:
> 
> <quote> from device drivers book by Alessandro Rubini, chapter 12, page 331
> The request function has one very important constraint: it must be atomic.
> request is not usually called in direct response to user requests, and it is
> not running in the context of any particular process. It can be called at
> interrupt time, from tasklets, or from any number of other places. Thus, it
> must not sleep while carrying out its tasks.
> </quote>

loop isn't implement via ->request_fn anymore. Loop since 2.4 is only
driven by the ->make_request_fn, that for the other more normal devices
just means the old legacy __make_request. request_fn is subject to the
rules pointed out by Alessandro, but ->make_request_fn can sleep just
like ll_rw_block can sleep.  ->make_request_fn and in turn
loop_make_request can only run in normal context with irq enabled and
they're both allowed to sleep just like ll_rw_block and submit_bh.

Nevertheless as Jens said the infinite-loop-allocation in the
->make_request_fn path are deadlock prone at the moment, not because
they sleeps but because they need a reserved mempool to guarantee
operations can go ahead slowly without deadlocks even if dynamic
allocation fails, but this is not a very pratical problem, it's very
unlikely to deadlock there (it's not worse than the other infinite loop
in getblk() that affects not just loop).

Andrea
