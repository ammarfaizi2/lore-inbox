Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277653AbRLGM3d>; Fri, 7 Dec 2001 07:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRLGM3S>; Fri, 7 Dec 2001 07:29:18 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:32080 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S282841AbRLGM3C>; Fri, 7 Dec 2001 07:29:02 -0500
Date: Fri, 7 Dec 2001 13:25:05 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA on AXP & barriers
Message-ID: <20011207132505.B4229@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20011206061315.J13427@garloff.etpnet.phys.tue.nl> <20011206125935.A3930@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <20011206125935.A3930@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2001 at 12:59:35PM +0300, Ivan Kokshaysky wrote:
> On Thu, Dec 06, 2001 at 06:13:15AM +0100, Kurt Garloff wrote:
> > I would imagine that the following barriers are nacessary:
> > * After setting up the IDE DMA tables (PRD) and having the data there,
> >   we need to have a barrier before telling the controller to do DMA.
>=20
> Actually, we have more than one - the memory barriers are hidden in outX()
> macros.

You seem to be right.
Here are the results of my investigation:
* IDE DMA on reads just works fine
* IDE DMA on writes does produce corruption of a couple of bytes at offsets
  of multiples of PAGE_SIZE (8k)
* If I limit the DMA SG segments to not cross the page boundaries, DMA write
  seems to work. (I see occasional DMA timeouts though, so it might be
  necessary to limit the SG table length, or maybe to disable all the
  debugging printks currently active.)

Expect a patch soon.

The sg tables are set up correctly, AFAICS.
The only thing which makes me wonder, is why the EOT bit is not set on the
last table entry. But it does not seem to make a difference for the CMD646.

So I  wonder where the bug actually is. Somewhere in hardware; but I wonder
whether the CMD646 or the 2117x (PYXIS/CIA) is to blame. The QLogicISP seems
to happily do BM-DMA, so I'd point to the CMD646. OTOH, the QLogic sits on
the 2nd PCI bus (32bit), which could make a difference as well.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ELUgxmLh6hyYd04RAhHnAJ9fJjEmGTNsKfWkJ9dxzSLXpmss7gCfe+uB
5ygCHd6hKlE4YyAfqCI39b0=
=BDBE
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
