Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264771AbUFGPnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264771AbUFGPnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264766AbUFGPnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:43:45 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:65224 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S264771AbUFGPnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:43:21 -0400
Date: Mon, 7 Jun 2004 11:43:10 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Duncan Sands <baldrick@free.fr>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Message-ID: <20040607154310.GA10404@babylon.d2dc.net>
Mail-Followup-To: Duncan Sands <baldrick@free.fr>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	"David A. Desrosiers" <desrod@gnu-designs.com>,
	linux-usb-devel@lists.sourceforge.net
References: <20040604193911.GA3261@babylon.d2dc.net> <200406050955.01677.baldrick@free.fr> <20040606063559.GA3018@babylon.d2dc.net> <200406070905.41145.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <200406070905.41145.baldrick@free.fr>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 07, 2004 at 09:05:41AM +0200, Duncan Sands wrote:
> > > Are you sure?  That seems impossible to me!  Can you
> > > get a new call trace please.
> >=20
> > Hrm, I could have sworn that the kernel I tested with was rebuilt with
> > the patch, but now that I am trying it on rc2-mm1 with the patch, it
> > does in fact seem to be working, mostly.
> >=20
> > Thanks a lot, and sorry for the previous report.
> >=20
> > I seem to be seeing a locking related race condition on bulk reads and
> > writes as well, should I start a new thread for those?
>=20
> I don't think it matters much whether you start a new thread or not.  What
> problem are you seeing?

To give some background, the libusb backend of pilot-link is a slightly
odd design, we do the init work, reset the device, and then setup a read
thread, which basicly does a continuous loop of bulk no-timeout reads
=66rom USB.

In the primary thread we do most of the work, including doing the USB
bulk writes to do things like ask the pilot for information.

Which, once I had things working again, sometimes resulted in the
following issue:

lt-pilot-xfer D 00000010     0  3351   3097  3398               (NOTLB)
ca93dec0 00000082 00000001 00000010 cdaa434c caac11e8 cdaa43ec caac11a0
       ca93ded4 ce8b4318 c03a2fc0 00000000 3904f0c0 000f42ec cb7fe398 ca913=
c24
       00000246 ca93c000 ca93defc c0336735 ca913c2c cb7fe1f0 00000001 cb7fe=
1f0
Call Trace:
 [<c0336735>] __down+0x85/0x120
 [<c033692f>] __down_failed+0xb/0x14
 [<c0273245>] .text.lock.devio+0xe5/0x120
 [<c015a45d>] file_ioctl+0x5d/0x170
 [<c015a686>] sys_ioctl+0x116/0x250
 [<c0103f8f>] syscall_call+0x7/0xb

lt-pilot-xfer D 00000001     0  3398   3351                     (NOTLB)
ca8ebe1c 00000082 00000000 00000001 0ca97854 ce5bca08 d7d85000 00000001
       ce5bca08 00000246 ca8ebe2c 00000000 38200f00 000f42ec cb7fe938 ca8eb=
eac
       ca8ea000 ca8ea000 ca8ebe70 c0336eb8 00000000 cb7fe790 c01146a0 00000=
000
Call Trace:
 [<c0336eb8>] wait_for_completion+0x78/0xf0
 [<c026cc0a>] usb_start_wait_urb+0x7a/0xc0
 [<c0271866>] proc_bulk+0x116/0x220
 [<c0272f61>] usbdev_ioctl+0x581/0x710
 [<c015a45d>] file_ioctl+0x5d/0x170
 [<c015a686>] sys_ioctl+0x116/0x250
 [<c0103f8f>] syscall_call+0x7/0xb

With the device not sending us any more data until it receives the
write, and the write not getting to send until the bulk read finishes or
the device goes away.

With the predictable annoyance this causes, of course.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

  Yes, Java is so bulletproofed that to a C programmer it feels like
being in a straightjacket, but it's a really comfy and warm
straightjacket, and the world would be a safer place if everyone was
straightjacketed most of the time.        -- Overheard in the SDM.

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxI0ORFMAi+ZaeAERAiGLAJ9IJjKDwYk5u8n6kEaYkTKsZCJvtQCgwapQ
rIoXx8UZTSEVgKEhejGsgHw=
=havm
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
