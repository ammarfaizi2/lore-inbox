Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRKIIti>; Fri, 9 Nov 2001 03:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278120AbRKIIt3>; Fri, 9 Nov 2001 03:49:29 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:5125
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S274875AbRKIItT>;
	Fri, 9 Nov 2001 03:49:19 -0500
Subject: Re: [Ext2-devel] disk throughput
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Constantin Loizides <Constantin.Loizides@isg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3BEB72DA.7ADA8332@zip.com.au>
In-Reply-To: <3BEAA3B7.A7F9328E@isg.de>, <3BE647F4.AD576FF2@zip.com.au>
	<Pine.GSO.4.21.0111050904000.23204-100000@weyl.math.psu.edu>
	<3BE71131.59BA0CFC@zip.com.au> 
	<20011106105138Z16653-12382+40@humbolt.nl.linux.org>
	<1005063444.25686.18.camel@ixodes.goop.org>  <3BEAA3B7.A7F9328E@isg.de>
	<1005237961.4537.0.camel@ixodes.goop.org>  <3BEB72DA.7ADA8332@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 09 Nov 2001 00:49:17 -0800
Message-Id: <1005295757.5672.4.camel@ixodes.goop.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-08 at 22:08, Andrew Morton wrote:
> How do you avoid aftifacts from Linux caching with this test?

Randomly seeking around a 40G disk isn't going to give the caching much
to work with (that was on a 256Mbyte machine).  Also, I tried it with
raw devices, but it made no difference to the measurements.

> > I found the random seeking was the only way I could get reasonable
> > numbers out of the drive; any of the ordered patterns of the form "OK,
> > lets measure N block seeks" seemed to be predicted by the drive and gave
> > unreasonably fast results.
> > 
> 
> But we *want* unreasonably fast results!  We need to understand
> this device-level prediction, then decide if it's sufficiently
> widespread for us to go and exploit the hell out of it.
> 
> Have you any ideas as to what's happening?

Not really.  I wanted results which at least confirm the simple model of
how the disk works.  When I did deterministic seeks, it was something
like:

	for(n = 0; n < disksize/2; n += about_a_cylinder) {
		seek(n);
		read();
		seek(disksize-n);
		read();
	}

I suspect that the drive was partitioning its cache and using lots of
readahead to satisfy the reads at either end of the seek.  I was trying
to work around that by making the n increment large enough, but it
didn't seem to work.  Maybe the drive was being extra special clever, or
maybe I miscalculated the cylinder size.  Or maybe I just happened to be
hitting a rotational sweet-spot.

For this kind of test, it would be interesting to know what differences
there are between read and write.  In principle the drive could start
writing a track anywhere it wants so long as it has enough to write the
whole thing.  That would automatically make it get the track-track skew
right...

	J

