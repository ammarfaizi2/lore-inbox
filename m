Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311337AbSCLUe7>; Tue, 12 Mar 2002 15:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311338AbSCLUev>; Tue, 12 Mar 2002 15:34:51 -0500
Received: from [217.79.102.244] ([217.79.102.244]:43515 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S311337AbSCLUed>; Tue, 12 Mar 2002 15:34:33 -0500
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: Beezly <beezly@beezly.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020312.093134.35196670.davem@redhat.com>
In-Reply-To: <1015881102.4312.10.camel@monkey>
	<1015881814.4315.12.camel@monkey> <1015887102.2051.4.camel@monkey> 
	<20020312.093134.35196670.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-2G46QY2ZynEZdVAz4Lva"
X-Mailer: Evolution/1.0.2 
Date: 12 Mar 2002 20:34:29 +0000
Message-Id: <1015965269.1937.22.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2G46QY2ZynEZdVAz4Lva
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

This looks like it's working!

eth0      Link encap:Ethernet  HWaddr 00:03:BA:04:5B:D7
          inet addr:10.0.0.12  Bcast:10.0.0.255  Mask:255.255.255.0
          inet6 addr: fe80::203:baff:fe04:5bd7/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:623264 errors:0 dropped:4 overruns:4 frame:4
          TX packets:501679 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:864388119 (824.3 MiB)  TX bytes:719041874 (685.7 MiB)
          Interrupt:5 Base address:0x8400

There are a few dropped packets, and the card misses a few incoming
immediatly after a dropped packet although I guess this is it picking
itself up off the ground after RX has hung.

Also, regarding the missing MAC address on most architectures, I have it
on good authority that the last six digits of the MAC address are stored
in the Vital Product Data area on the PCI boards (presumably because the
first 6 are the "standard" SUN MAC prefix).

I had a quick fiddle around with pci_find_capability(<blah>,
PCI_CAP_ID_VPD), but it always returns NULL (i.e. no VPD). However, I've
also noticed that no-one appears to use that macro in any of the kernel
source. Is there another way to look at the VPD?

Many Thanks,

Beezly

On Tue, 2002-03-12 at 17:31, David S. Miller wrote:
>    From: Beezly <beezly@beezly.org.uk>
>    Date: 11 Mar 2002 22:51:42 +0000
>=20
>    Ok, I've been fiddling around with the driver tonight and have managed
>    to get a little further by forcing the driver to do a full reset of th=
e
>    chip when the RX buffer over flows. I achieved this by sticking a retu=
rn
>    1; at the top of gem_rxmac_reset().
>   =20
>    I'm guessing this isn't an "optimal" reset for the situation but so fa=
r
>    it's having /reasonable/ results (i.e. I don't have to bring the
>    interface up and down every 30 seconds!).
>  ...  =20
>    Hope this helps,
>=20
> I'll follow up on this and figure out why my RX reset code
> isn't working after I finish up some 2.5.x work.
>=20
> But looking quickly I think I see what is wrong.  Please give
> this a try (and remember to remove your hacks before testing
> this :-):
>=20
> --- drivers/net/sungem.c.~1~	Mon Mar 11 04:24:13 2002
> +++ drivers/net/sungem.c	Tue Mar 12 09:30:38 2002
> @@ -357,6 +357,7 @@ static int gem_rxmac_reset(struct gem *g
> =20
>  		rxd->status_word =3D cpu_to_le64(RXDCTRL_FRESH(gp));
>  	}
> +	gp->rx_new =3D gp->rx_old =3D 0;
> =20
>  	/* Now we must reprogram the rest of RX unit. */
>  	desc_dma =3D (u64) gp->gblock_dvma;


--=-2G46QY2ZynEZdVAz4Lva
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jmZVXu4ZFsMQjPgRAqzTAJ0RDr/R+ywLJ5Qpqj1hiNl+Z6PJjACeMAAy
uKTy1BCM4c7EC9dSf2Jr+Fs=
=0+b/
-----END PGP SIGNATURE-----

--=-2G46QY2ZynEZdVAz4Lva--
