Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290228AbSCKVMR>; Mon, 11 Mar 2002 16:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290713AbSCKVL6>; Mon, 11 Mar 2002 16:11:58 -0500
Received: from [217.79.102.244] ([217.79.102.244]:39663 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S290228AbSCKVLp>; Mon, 11 Mar 2002 16:11:45 -0500
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: Beezly <beezly@beezly.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020311.110236.133275094.davem@redhat.com>
In-Reply-To: <1015849164.2153.3.camel@monkey>
	<20020311.042124.103955441.davem@redhat.com>
	<1015871701.2832.1.camel@monkey> 
	<20020311.110236.133275094.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-PM27SmrODWXWBKciDQiW"
X-Mailer: Evolution/1.0.2 
Date: 11 Mar 2002 21:11:42 +0000
Message-Id: <1015881102.4312.10.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PM27SmrODWXWBKciDQiW
Content-Type: multipart/mixed; boundary="=-G8+FGwSuhXanN/s429MM"


--=-G8+FGwSuhXanN/s429MM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

It seems I fubar'd. I recompiled the module and run it through the test
again... no hang. It looks like I forgot to copy the new module into my
/lib/modules/<blah>. Apologies for messing up there.

Anyway... the new driver still drops packets after the initial RX
overflow, so I had a poke around with it and I've seen some definate
improvement by forcing the whole chip to reset when the RX overflows.

My modifications to the driver are evil and I only intend them to be a
test, but it helps to shed some extra light on what's going on.

When the chip does a full reset I loose a whole load of packets, but I'm
guessing this is normal :(

Also, I can't remember where I read it, but the Extreme Summit 48 is
supposed to support *receiving* the xon/xoff Pause stuff (I'm no expert
in this area, so I could be talking complete twaddle!), no transmit
capability though.

Here's what I get out of the module when it resets (with my limit=3D5000
mod);

eth0: RX buffer overflowed - running rxmac_reset
eth0: RX MAC resetting
eth0: RX MAC *ONLY* reset
eth0: RX MAC reset ok?
eth0: RX MAC will not disable, resetting whole chip.
eth0: PCS AutoNEG complete.
eth0: PCS link is now up.

Without the limit=3D5000, it appears that the module detects the RX
section is "un-hung" when it isn't.

Cheers,

Beezly

On Mon, 2002-03-11 at 19:02, David S. Miller wrote:
>    From: Beezly <beezly@beezly.org.uk>
>    Date: 11 Mar 2002 18:35:01 +0000
>=20
>    Sorry it took so long for me to get back to you. Sadly it also hung wi=
th
>    this patch ;) I was unable to get an oops out of it (machine was
>    completely hosed and in X so I couldn't even note the oops on paper :(
>    ).
>   =20
> So rerun the test not under X please?


--=-G8+FGwSuhXanN/s429MM
Content-Disposition: attachment; filename=sungem.testing.diff
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

--- sungem.c	Mon Mar 11 20:37:57 2002
+++ sungem.c.testing	Mon Mar 11 20:31:12 2002
@@ -302,14 +302,23 @@
 	u64 desc_dma;
 	u32 val;
=20
+	printk(KERN_ERR "%s: RX MAC resetting\n", dev->name);
 	/* First, reset MAC RX. */
 	writel(gp->mac_rx_cfg & ~MAC_RXCFG_ENAB,
 	       gp->regs + MAC_RXCFG);
+	printk(KERN_ERR "%s: RX MAC *ONLY* reset\n", dev->name);
+=09
 	for (limit =3D 0; limit < 5000; limit++) {
-		if (!(readl(gp->regs + MAC_RXCFG) & MAC_RXCFG_ENAB))
+		if (!(readl(gp->regs + MAC_RXCFG) & MAC_RXCFG_ENAB)) {
+			printk(KERN_ERR "%s: RX MAC reset ok?\n", dev->name);
 			break;
+		}
 		udelay(10);
 	}
+
+	/* RX MAC reset doesn't appear to work so I force a whole reset */
+	limit =3D 5000;
+=09
 	if (limit =3D=3D 5000) {
 		printk(KERN_ERR "%s: RX MAC will not disable, resetting whole "
 		       "chip.\n", dev->name);
@@ -323,6 +332,9 @@
 			break;
 		udelay(10);
 	}
+
+	limit=3D5000;
+
 	if (limit =3D=3D 5000) {
 		printk(KERN_ERR "%s: RX DMA will not disable, resetting whole "
 		       "chip.\n", dev->name);
@@ -399,6 +411,8 @@
 	if (rxmac_stat & MAC_RXSTAT_OFLW) {
 		gp->net_stats.rx_over_errors++;
 		gp->net_stats.rx_fifo_errors++;
+		printk(KERN_DEBUG "%s: RX buffer overflowed - running rxmac_reset\n",
+			gp->dev->name);
=20
 		ret =3D gem_rxmac_reset(gp);
 	}

--=-G8+FGwSuhXanN/s429MM--

--=-PM27SmrODWXWBKciDQiW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jR2OXu4ZFsMQjPgRAoRmAKCNMu/XJd8nAtuNhLU4LNKGbpVC+wCbBpdR
fAmoEWinYZuH3Mdc9cU23gw=
=5FJZ
-----END PGP SIGNATURE-----

--=-PM27SmrODWXWBKciDQiW--
