Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271600AbRIJTFx>; Mon, 10 Sep 2001 15:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271599AbRIJTFn>; Mon, 10 Sep 2001 15:05:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22802 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271598AbRIJTFd>; Mon, 10 Sep 2001 15:05:33 -0400
Date: Mon, 10 Sep 2001 21:06:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010910210607.C715@athlon.random>
In-Reply-To: <20010910175416.A714@athlon.random> <200109101741.f8AHfwx17136@ns.caldera.de> <20010910200344.C714@athlon.random> <20010910205250.B22889@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010910205250.B22889@caldera.de>; from hch@caldera.de on Mon, Sep 10, 2001 at 08:52:50PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 08:52:50PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 10, 2001 at 08:03:44PM +0200, Andrea Arcangeli wrote:
> > > Do we really need yet-another per-CPU thread for this?  I'd prefer to have
> > > the context thread per-CPU instead (like in Ben's asynchio patch) and do
> > > this as well.
> > 
> > The first desing solution I proposed to Paul and Dipankar was just to
> > use ksoftirqd for that (in short set need_resched and wait it to be
> > cleared), it worked out nicely and it was a sensible improvement with
> > respect to their previous patches. (also it was reliable, we cannot
> > afford allocations in the wait_for_rcu path to avoid having to introduce
> > fail paths) it was also a noop to the ksoftirqd paths.
> > 
> > However they remarked ksoftirqd wasn't a RT thread so under very high
> > load it could introduce an higher latency to the wait_for_rcu calls.
> 
> Hmm, I don't see why latency is important for rcu - we only want to
> free datastructures.. (mm load?).

latency isn't critical, infact the point of rcu is not to care about the
performance of the writer, so it wouldn't be a showstopper if it takes
more time, but still this doesn't change that with RT threads the writer
will be faster.

> My problem with this appropech is just that we use kernel threads for
> more and more stuff - always creating new ones.  I think at some point
> they will sum up badly.

They almost only costs memory. I also don't like unnecessary kernel
threads but I can see usefulness for this one, OTOH as you said the
latency of the wait_for_rcu isn't very critical but usually I prefer to
save cycles with memory where I can and where it's even cleaner to do so.

Andrea
