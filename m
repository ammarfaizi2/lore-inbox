Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293574AbSCKWxg>; Mon, 11 Mar 2002 17:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293547AbSCKWxS>; Mon, 11 Mar 2002 17:53:18 -0500
Received: from [217.79.102.244] ([217.79.102.244]:23536 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S293574AbSCKWvq>; Mon, 11 Mar 2002 17:51:46 -0500
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: Beezly <beezly@beezly.org.uk>
To: Beezly <beezly@beezly.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1015881814.4315.12.camel@monkey>
In-Reply-To: <1015849164.2153.3.camel@monkey>
	<20020311.042124.103955441.davem@redhat.com>
	<1015871701.2832.1.camel@monkey> 
	<20020311.110236.133275094.davem@redhat.com> 
	<1015881102.4312.10.camel@monkey>  <1015881814.4315.12.camel@monkey>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-zCu0jHbhxe0m+UD89yJ8"
X-Mailer: Evolution/1.0.2 
Date: 11 Mar 2002 22:51:42 +0000
Message-Id: <1015887102.2051.4.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zCu0jHbhxe0m+UD89yJ8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

Sorry about the mindless waffle earlier on - I'd just come in from work
and was suffering from brain death ;) I must remember to wait an hour or
so before touching a computer after I come in from work.

Ok, I've been fiddling around with the driver tonight and have managed
to get a little further by forcing the driver to do a full reset of the
chip when the RX buffer over flows. I achieved this by sticking a return
1; at the top of gem_rxmac_reset().

I'm guessing this isn't an "optimal" reset for the situation but so far
it's having /reasonable/ results (i.e. I don't have to bring the
interface up and down every 30 seconds!).

Here's the output of the ping;

monkey:/home/andy# ping -f -s 1472 shroom
PING shroom.beezly.org.uk (10.0.0.15) from 10.0.0.12 : 1472(1500) bytes
of
data.......................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
.........=20
--- shroom.beezly.org.uk ping statistics ---
366892 packets transmitted, 366288 received, 0% loss, time 343836ms
rtt min/avg/max/mdev =3D 0.445/0.471/5.377/0.038 ms, pipe 2, ipg/ewma
0.937/0.465 ms

Hope this helps,

Beezly

On Mon, 2002-03-11 at 21:23, Beezly wrote:
> David,
>=20
> I've been looking some more at what my changes did.... it might be best
> to completely ignore them ;) I had no clue what I was doing!
>=20
> Cheers,
>=20
> Beezly
>=20
> On Mon, 2002-03-11 at 21:11, Beezly wrote:
> > Hi David,
> >=20
> > It seems I fubar'd. I recompiled the module and run it through the test
> > again... no hang. It looks like I forgot to copy the new module into my
> > /lib/modules/<blah>. Apologies for messing up there.
> >=20
> > Anyway... the new driver still drops packets after the initial RX
> > overflow, so I had a poke around with it and I've seen some definate
> > improvement by forcing the whole chip to reset when the RX overflows.
> >=20
> > My modifications to the driver are evil and I only intend them to be a
> > test, but it helps to shed some extra light on what's going on.
> >=20
> > When the chip does a full reset I loose a whole load of packets, but I'=
m
> > guessing this is normal :(
> >=20
> > Also, I can't remember where I read it, but the Extreme Summit 48 is
> > supposed to support *receiving* the xon/xoff Pause stuff (I'm no expert
> > in this area, so I could be talking complete twaddle!), no transmit
> > capability though.
> >=20
> > Here's what I get out of the module when it resets (with my limit=3D500=
0
> > mod);
> >=20
> > eth0: RX buffer overflowed - running rxmac_reset
> > eth0: RX MAC resetting
> > eth0: RX MAC *ONLY* reset
> > eth0: RX MAC reset ok?
> > eth0: RX MAC will not disable, resetting whole chip.
> > eth0: PCS AutoNEG complete.
> > eth0: PCS link is now up.
> >=20
> > Without the limit=3D5000, it appears that the module detects the RX
> > section is "un-hung" when it isn't.
> >=20
> > Cheers,
> >=20
> > Beezly
> >=20
> > On Mon, 2002-03-11 at 19:02, David S. Miller wrote:
> > >    From: Beezly <beezly@beezly.org.uk>
> > >    Date: 11 Mar 2002 18:35:01 +0000
> > >=20
> > >    Sorry it took so long for me to get back to you. Sadly it also hun=
g with
> > >    this patch ;) I was unable to get an oops out of it (machine was
> > >    completely hosed and in X so I couldn't even note the oops on pape=
r :(
> > >    ).
> > >   =20
> > > So rerun the test not under X please?
> >=20
> > ----
> >=20
>=20
> > --- sungem.c	Mon Mar 11 20:37:57 2002
> > +++ sungem.c.testing	Mon Mar 11 20:31:12 2002
> > @@ -302,14 +302,23 @@
> >  	u64 desc_dma;
> >  	u32 val;
> > =20
> > +	printk(KERN_ERR "%s: RX MAC resetting\n", dev->name);
> >  	/* First, reset MAC RX. */
> >  	writel(gp->mac_rx_cfg & ~MAC_RXCFG_ENAB,
> >  	       gp->regs + MAC_RXCFG);
> > +	printk(KERN_ERR "%s: RX MAC *ONLY* reset\n", dev->name);
> > +=09
> >  	for (limit =3D 0; limit < 5000; limit++) {
> > -		if (!(readl(gp->regs + MAC_RXCFG) & MAC_RXCFG_ENAB))
> > +		if (!(readl(gp->regs + MAC_RXCFG) & MAC_RXCFG_ENAB)) {
> > +			printk(KERN_ERR "%s: RX MAC reset ok?\n", dev->name);
> >  			break;
> > +		}
> >  		udelay(10);
> >  	}
> > +
> > +	/* RX MAC reset doesn't appear to work so I force a whole reset */
> > +	limit =3D 5000;
> > +=09
> >  	if (limit =3D=3D 5000) {
> >  		printk(KERN_ERR "%s: RX MAC will not disable, resetting whole "
> >  		       "chip.\n", dev->name);
> > @@ -323,6 +332,9 @@
> >  			break;
> >  		udelay(10);
> >  	}
> > +
> > +	limit=3D5000;
> > +
> >  	if (limit =3D=3D 5000) {
> >  		printk(KERN_ERR "%s: RX DMA will not disable, resetting whole "
> >  		       "chip.\n", dev->name);
> > @@ -399,6 +411,8 @@
> >  	if (rxmac_stat & MAC_RXSTAT_OFLW) {
> >  		gp->net_stats.rx_over_errors++;
> >  		gp->net_stats.rx_fifo_errors++;
> > +		printk(KERN_DEBUG "%s: RX buffer overflowed - running rxmac_reset\n"=
,
> > +			gp->dev->name);
> > =20
> >  		ret =3D gem_rxmac_reset(gp);
> >  	}
>=20


--=-zCu0jHbhxe0m+UD89yJ8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jTT+Xu4ZFsMQjPgRAhRYAJ400LrenhkBzLFKGcgjvrbEXE+ICACdFVSS
e08MxdpumajxS9qk5b/avHA=
=6Nrh
-----END PGP SIGNATURE-----

--=-zCu0jHbhxe0m+UD89yJ8--
