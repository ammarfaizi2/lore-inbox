Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291081AbSCKVZS>; Mon, 11 Mar 2002 16:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292533AbSCKVZJ>; Mon, 11 Mar 2002 16:25:09 -0500
Received: from [217.79.102.244] ([217.79.102.244]:43503 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S290797AbSCKVY6>; Mon, 11 Mar 2002 16:24:58 -0500
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: Beezly <beezly@beezly.org.uk>
To: Beezly <beezly@beezly.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1015881102.4312.10.camel@monkey>
In-Reply-To: <1015849164.2153.3.camel@monkey>
	<20020311.042124.103955441.davem@redhat.com>
	<1015871701.2832.1.camel@monkey> 
	<20020311.110236.133275094.davem@redhat.com> 
	<1015881102.4312.10.camel@monkey>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Ac4Tnx4o/vg3aJc6DNZY"
X-Mailer: Evolution/1.0.2 
Date: 11 Mar 2002 21:23:34 +0000
Message-Id: <1015881814.4315.12.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ac4Tnx4o/vg3aJc6DNZY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

David,

I've been looking some more at what my changes did.... it might be best
to completely ignore them ;) I had no clue what I was doing!

Cheers,

Beezly

On Mon, 2002-03-11 at 21:11, Beezly wrote:
> Hi David,
>=20
> It seems I fubar'd. I recompiled the module and run it through the test
> again... no hang. It looks like I forgot to copy the new module into my
> /lib/modules/<blah>. Apologies for messing up there.
>=20
> Anyway... the new driver still drops packets after the initial RX
> overflow, so I had a poke around with it and I've seen some definate
> improvement by forcing the whole chip to reset when the RX overflows.
>=20
> My modifications to the driver are evil and I only intend them to be a
> test, but it helps to shed some extra light on what's going on.
>=20
> When the chip does a full reset I loose a whole load of packets, but I'm
> guessing this is normal :(
>=20
> Also, I can't remember where I read it, but the Extreme Summit 48 is
> supposed to support *receiving* the xon/xoff Pause stuff (I'm no expert
> in this area, so I could be talking complete twaddle!), no transmit
> capability though.
>=20
> Here's what I get out of the module when it resets (with my limit=3D5000
> mod);
>=20
> eth0: RX buffer overflowed - running rxmac_reset
> eth0: RX MAC resetting
> eth0: RX MAC *ONLY* reset
> eth0: RX MAC reset ok?
> eth0: RX MAC will not disable, resetting whole chip.
> eth0: PCS AutoNEG complete.
> eth0: PCS link is now up.
>=20
> Without the limit=3D5000, it appears that the module detects the RX
> section is "un-hung" when it isn't.
>=20
> Cheers,
>=20
> Beezly
>=20
> On Mon, 2002-03-11 at 19:02, David S. Miller wrote:
> >    From: Beezly <beezly@beezly.org.uk>
> >    Date: 11 Mar 2002 18:35:01 +0000
> >=20
> >    Sorry it took so long for me to get back to you. Sadly it also hung =
with
> >    this patch ;) I was unable to get an oops out of it (machine was
> >    completely hosed and in X so I couldn't even note the oops on paper =
:(
> >    ).
> >   =20
> > So rerun the test not under X please?
>=20
> ----
>=20

> --- sungem.c	Mon Mar 11 20:37:57 2002
> +++ sungem.c.testing	Mon Mar 11 20:31:12 2002
> @@ -302,14 +302,23 @@
>  	u64 desc_dma;
>  	u32 val;
> =20
> +	printk(KERN_ERR "%s: RX MAC resetting\n", dev->name);
>  	/* First, reset MAC RX. */
>  	writel(gp->mac_rx_cfg & ~MAC_RXCFG_ENAB,
>  	       gp->regs + MAC_RXCFG);
> +	printk(KERN_ERR "%s: RX MAC *ONLY* reset\n", dev->name);
> +=09
>  	for (limit =3D 0; limit < 5000; limit++) {
> -		if (!(readl(gp->regs + MAC_RXCFG) & MAC_RXCFG_ENAB))
> +		if (!(readl(gp->regs + MAC_RXCFG) & MAC_RXCFG_ENAB)) {
> +			printk(KERN_ERR "%s: RX MAC reset ok?\n", dev->name);
>  			break;
> +		}
>  		udelay(10);
>  	}
> +
> +	/* RX MAC reset doesn't appear to work so I force a whole reset */
> +	limit =3D 5000;
> +=09
>  	if (limit =3D=3D 5000) {
>  		printk(KERN_ERR "%s: RX MAC will not disable, resetting whole "
>  		       "chip.\n", dev->name);
> @@ -323,6 +332,9 @@
>  			break;
>  		udelay(10);
>  	}
> +
> +	limit=3D5000;
> +
>  	if (limit =3D=3D 5000) {
>  		printk(KERN_ERR "%s: RX DMA will not disable, resetting whole "
>  		       "chip.\n", dev->name);
> @@ -399,6 +411,8 @@
>  	if (rxmac_stat & MAC_RXSTAT_OFLW) {
>  		gp->net_stats.rx_over_errors++;
>  		gp->net_stats.rx_fifo_errors++;
> +		printk(KERN_DEBUG "%s: RX buffer overflowed - running rxmac_reset\n",
> +			gp->dev->name);
> =20
>  		ret =3D gem_rxmac_reset(gp);
>  	}


--=-Ac4Tnx4o/vg3aJc6DNZY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jSBWXu4ZFsMQjPgRAsNPAKDE5sdyk8KAY0maXT+m+SSaA1VibQCgtfEY
ou5AhHNm1YriHRZzsCrJmss=
=c4kS
-----END PGP SIGNATURE-----

--=-Ac4Tnx4o/vg3aJc6DNZY--
