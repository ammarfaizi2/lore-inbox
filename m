Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTFKDlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 23:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTFKDlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 23:41:51 -0400
Received: from [61.95.53.28] ([61.95.53.28]:27658 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S264054AbTFKDlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 23:41:49 -0400
Date: Wed, 11 Jun 2003 13:55:26 +1000
From: Simon Fowler <simon@himi.org>
To: Andrew Morton <akpm@digeo.com>
Cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk radeonfb oops on boot.
Message-ID: <20030611035525.GB2852@himi.org>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	jsimmons@infradead.org, linux-kernel@vger.kernel.org
References: <20030610061654.GB25390@himi.org> <20030610130204.GC27768@himi.org> <20030610141440.26fad221.akpm@digeo.com> <20030611021926.GA2241@himi.org> <20030610201641.220a4927.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <20030610201641.220a4927.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2003 at 08:16:41PM -0700, Andrew Morton wrote:
> Simon Fowler <simon@himi.org> wrote:
> >
> > On Tue, Jun 10, 2003 at 02:14:40PM -0700, Andrew Morton wrote:
> > > Simon Fowler <simon@himi.org> wrote:
> > > >
> > > > On Tue, Jun 10, 2003 at 04:16:54PM +1000, Simon Fowler wrote:
> > > > > I've started seeing a hard lockup on boot with my Fujitsu Lifebook
> > > > > p2120 laptop, with a radeon mobility M6 LY, when using a Linus bk
> > > > > kernel as of 2003-06-09 (possibly earlier - the last kernel I've
> > > > > tested is bk as of 2003-06-04). lspci lists this hardware:
> > > > >=20
> > > > I've narrowed the start of the problem down: 2.5.70-bk13 works,
> > > > -bk14 oopses.=20
> > >=20
> > > That's funny.  bk13->bk14 was almost all arm stuff.  diffstat below.
> > >=20
> > > It might be worth reverting this chunk, see if that fixes it:
> > >=20
> > > --- b/drivers/char/mem.c        Thu Jun  5 23:36:40 2003
> > > +++ b/drivers/char/mem.c        Sun Jun  8 05:02:24 2003
> > > @@ -716 +716 @@
> > > -__initcall(chr_dev_init);
> > > +subsys_initcall(chr_dev_init);
> > >=20
> > And we have a winner . . . Reverting this hunk fixes the oops.
> >=20
>=20
> So it's another initcall problem in the PCI layer.
>=20
> pci_enable_device_bars() is needing things which are not yet set up.  A l=
ot
> of the PCI initialisation is at subsys_initcall() as well, and you got
> unlucky with link order.
>=20
> I expect the below patch will fix this as well.  Could you please put the
> above change back to normal and see if this one fixes it?
>=20
I applied this to a clean 2.5.70-bk14 tree, and it failed to boot -
I've copied the output after switching to the framebuffer:

--------------------------------------------------
onsole: switching to colour frame buffer device 160x48
pty: 256 Unix98 ptys configured.
block request queues:
  4/128 requests per read queue
  4/128 requests per write queue
  Enter congestion at 15
  Exit congestion at 17
PCI: Cannot allocate resource region 0 of device 00:14.0
PCI: Cannot allocate resource region 2 of device 00:14.0
--------------------------------------------------

00:14.0 is the Radeon.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+5qgtQPlfmRRKmRwRArngAJ9qtgYfFOiZhoQEcLOXC+bR/e1L/ACfYBdd
+Ys9yUUNd0rxqZXZAaL+pxY=
=RGVc
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
