Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbSLWGWA>; Mon, 23 Dec 2002 01:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266627AbSLWGWA>; Mon, 23 Dec 2002 01:22:00 -0500
Received: from chaos.ao.net ([205.244.242.21]:57236 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S266622AbSLWGV7>;
	Mon, 23 Dec 2002 01:21:59 -0500
Date: Mon, 23 Dec 2002 01:29:43 -0500
From: harik@chaos.ao.net
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: raid5 multi-drive-failure and recovery?
Message-ID: <20021223062943.GB14954@chaos.ao.net>
References: <200212200049.gBK0n5NS016297@chaos.ao.net> <15874.27493.835799.195199@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <15874.27493.835799.195199@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4i
X-Bayes-Status: No, probability=0.000
X-Bayes-Debug: , Dec:0.010, pgp-signature:0.010, kernel:0.010, uptodate:0.990, Dec:0.010, Debian-6:0.990, Dec:0.010, pgp-sha1:0.010, --Dan:0.010, -----END:0.010, vulpine:0.010, Uptodate:0.990, vulpine:0.010, raid:0.010, 4i:0.010
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Dec 2002, Neil Brown wrote:

> > fail, catch it in raid5_end_read_request then tag the stripe_head
> > with the device that's failed.  If one has already failed, return
> > EIO.   This way further reads on the stripe_head will go to the parity
> > disk (until it's eventually freed.  One IO error per stripe isn't too
> > harsh a price to pay for disaster recovery)
> >=20
> > in 2.4.20, I'm at raid5.c:421 where we're about to call md_error.
> > What happens to the bh from that point?  Obviously, it's not up-to-date,
> > so when 1 drive fails how does it get re-issued to be pulled from a par=
ity
> > drive to reconstruct it?
>=20
> Nothing much happens to the bh.  It just has Uptodate cleared.
>=20
> A little later (line 433) we call release_stripe.  Once all the active
> IO requests have finished the stripe will be completely released and
> handle_stripe gets called (from raid5d) to handle the stripe.
> It notices there is a block that is being read (bh_read) but that
> isn't uptodate, and so tries to schedule a read.  Line 949 notices
> that the block it wants to read is on a failed drive, so it causes all
> blocks to be read in.  Once they are read in, handle_stripe gets
> called again, and this time it gets to line 955 where it computes the
> block that you want.

Ok, I was unclear what the retry-magic was.  We stall a request on a
failure, mark the drive 'failed' and eventually we notice "Hey, that
wasn't finished" and restart it (on the good drive)

I'll try to toss a prelim patch up in the near future.   Is there a
patch for loopback to simulate errors-on-demand?  I've already done
drive forensics to recover the disks in question, and I'd much rather
test on a set of 500meg loops rather then a 60gig raid. (For obvious
reasons)

Thanks,

--Dan


--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iD8DBQE+Bq1XkycScExRgsgRAnrpAJ9M7CYl1b5gEc6LDx6DsJED8qLuXACfdzmq
2p6xubL/3QFiRnVU0M2lqAI=
=+QQ3
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
