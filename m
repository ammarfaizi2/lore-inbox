Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTGOFyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTGOFyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:54:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27540 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263187AbTGOFyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:54:16 -0400
Date: Tue, 15 Jul 2003 08:08:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Chris Mason <mason@suse.com>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, sct@redhat.com,
       alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com, akpm@digeo.com,
       viro@math.psu.edu
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715060857.GG833@suse.de>
References: <20030714195138.GX833@suse.de> <Pine.LNX.4.55L.0307141708210.8994@freak.distro.conectiva> <20030714202434.GS16313@dualathlon.random> <1058214881.13313.291.camel@tiny.suse.com> <20030714224528.GU16313@dualathlon.random> <1058229360.13317.364.camel@tiny.suse.com> <20030714175238.3eaddd9a.akpm@osdl.org> <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de> <20030715060101.GB30537@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715060101.GB30537@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15 2003, Andrea Arcangeli wrote:
> On Tue, Jul 15, 2003 at 07:45:51AM +0200, Jens Axboe wrote:
> > On Tue, Jul 15 2003, Andrea Arcangeli wrote:
> > > On Mon, Jul 14, 2003 at 05:52:38PM -0700, Andrew Morton wrote:
> > > > Chris Mason <mason@suse.com> wrote:
> > > > >
> > > > > If we go back to Jens' numbers:
> > > > > 
> > > > > ctar_load:
> > > > > Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> > > > > 2.4.22-pre5            3        235     114.0   25.0    22.1    1.75
> > > > > 2.4.22-pre5-axboe      3        194     138.1   19.7    20.6    1.46
> > > > >                                                ^^^^^^
> > > > > The loads column is the number of times ctar_load managed to run during
> > > > > the kernel compile, and the patched kernel loses each time.  This must
> > > > > partially be caused by the lower run time overall, but it is still
> > > > > important data.  It would be better if contest gave us some kind of
> > > > > throughput numbers (avg load time or something).
> > > > 
> > > > Look at the total CPU utilisation.  It went from 136% to 159% while both
> > > > loads made reasonable progress.  Goodness.
> > > 
> > > if you look at the cpu utilization, stopping more the writer will
> > > generate a cpu utilization even higher, would you mind if Loads shows 15
> > 
> > Correct
> > 
> > > instead of 19.7 so the CPU% can go from 138 to 148 and LCPU only goes
> > > down from 20.6 to 18.8?  Problem is, how much should the writer be
> > > stopped. The LCPU will be almost constant, it's I/O bound anyways. So
> > > the more you stop the writer the higher the global cpu utilization will
> > > be. This doesn't automatically mean goodness.
> > 
> > The above case is pretty much only goodness though, ratio of loads/time
> > unit is about the same and we complete the workload much quicker
> > (because of the higher cpu util).
> 
> the I/O write throughput takes a -24% hit.  The kernel compile runs 21%
> faster.

Yes

> Note that -24% is the opposite of +31%.

Sorry you lost me, what do you mean?

> Problem is that we can't easily compare I/O bandwidth with cpu
> utilization. But slowing down the writer of 31% of its previous
> bandwidth, doesn't look an obvious improvement despite the kernel
> compiles 21% faster. Depends if you were waiting on the write, or on the
> kernel compile.

I don't see the 31% slowdown. We complete less tar loads, but only
because there's less time to complete them in. Well almost, as you list
the numbers don't quite match up, but it's close. I'll do the 2.4.21
comparison to see where we run, using your logic I could say that of
course the tar runs faster on 2.4.22-pre5, it would if I sent a SIGSTOP
to the compile as well. We need to establish a base line, even if 2.4.21
is a pretty boring base line (I think we all agree that kernel isn't
optimal).

> > I don't even think that is necessary, I feel fine with just the single
> > queue free list. I just want to make sure that some reads can get in,
> > while the queue maintains flooded by writes 99.9% of the time (trivial
> 
> that's ok.

Great, then we agree on that.

> > scenario, unlike the 'read starving all writers, might as well SIGSTOP
> > tar' work load you talk about).
> 
> it's still not completely obvious if your improvement didn't came partly
> from the SIGSTOP tar. Probably not because we found later that contest
> uses nr_cpus * 4 and not some bigger number that I expected.

I see tar making progress, how could it be stopped?

-- 
Jens Axboe

