Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264946AbUGBVyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbUGBVyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbUGBVyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:54:35 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:5085 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S264946AbUGBVyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:54:09 -0400
Date: Fri, 2 Jul 2004 17:52:53 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Duncan Sands <baldrick@free.fr>, linux-usb-devel@lists.sourceforge.net,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Message-ID: <20040702215253.GD3447@babylon.d2dc.net>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Duncan Sands <baldrick@free.fr>,
	linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	"David A. Desrosiers" <desrod@gnu-designs.com>
References: <20040702204756.GC3447@babylon.d2dc.net> <Pine.LNX.4.44L0.0407021700110.21819-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0407021700110.21819-100000@netrider.rowland.org>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 02, 2004 at 05:11:52PM -0400, Alan Stern wrote:
> On Fri, 2 Jul 2004, Zephaniah E. Hull wrote:
>=20
> > On Tue, Jun 08, 2004 at 10:19:40PM +0200, Duncan Sands wrote:
> > > > Great, could you send me the patch? (So I have something usable unt=
il it
> > > > gets into mainline and a kernel is released with it.)
> > >=20
> > > Sure - I just have to write it first!  It's a bit tricky to do right.=
=2E.
> >=20
> > Has there been any progress on this?
> >=20
> > I have been looking at the code in question and I am curious as to what
> > events we are attempting to protect against with the serialize spinlock?
> >=20
> > Thanks.
>=20
> There has been progress.  If you start with the latest 2.6.7 kernels=20
> (vanilla or -mm) and apply these two patches:
>=20
> http://marc.theaimsgroup.com/?l=3Dlinux-usb-devel&m=3D108810394203966&q=
=3Draw
> http://marc.theaimsgroup.com/?l=3Dlinux-usb-devel&m=3D108810535225278&q=
=3Draw
>=20
> the deadlock problems should be solved.  Although those patches haven't=
=20
> yet been merged, I'm pretty sure they will be.

Actually, there is still one remaining from looking at the patches I am
afraid.

Admittedly, it is due to the use of a somewhat, unelegant approach,
however it worked quite well (very nice speed bonuses) before the
locking patches.

Specificly, if you have a thread doing bulk reads on a USB device in a
loop, and the device stops talking to you (for instance, waiting for you
to reply), it becomes impossible to take any action on the device,
including aborting the read or issuing a write to the device to tell it
to keep talking until such a time as the read times out, the device
speaks to us, or the device is physically disconnected.

Using timeouts can mediate this, but at the cost of being far less
responsive unless you use a very short timeout.

I am unsure if the kernel provides the locking infrastructure to allow
us to keep us from reading/writing while doing the various events, while
also allowing us to read and write at the same time.

> To answer your other question...  The serialize semaphore (not spinlock)=
=20
> prevents the system from trying to do several incompatible things to a US=
B=20
> device at the same time.  For example, reset the device while a driver is=
=20
> probing it.  Or reset it while it is being suspended.

Ah, my mistake.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

> Is there an API or other means to determine what video
> card, namely the chipset, that the user has installed
> on his machine?

On a modern X86 machine use the PCI/AGP bus data. On a PS/2 use the MCA bus
data. On nubus use the nubus probe data. On old style ISA bus PCs done a la=
rge
pointy hat and spend several years reading arcane and forbidden scrolls

 -- Alan Cox

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5dk1RFMAi+ZaeAERAoIaAJ9O3IS3IOkwSuOinA3FyRzdJVAcgQCgz7uY
CdXmC+PUrQYyOxd7fDDjoy0=
=wL6y
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
