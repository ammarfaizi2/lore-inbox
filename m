Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265030AbUFHL1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbUFHL1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbUFHL1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:27:16 -0400
Received: from [196.25.168.8] ([196.25.168.8]:38599 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S265030AbUFHL1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:27:08 -0400
Date: Tue, 8 Jun 2004 13:26:04 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: webvenza@libero.it, linux-kernel@vger.kernel.org
Subject: Re: [HANG] SIS900 + P4 Hyperthread
Message-ID: <20040608112604.GY14247@lbsd.net>
References: <40C0E37C.4030905@lbsd.net> <20040604214721.GC22679@picchio.gall.it> <20040605005033.A26051@electric-eye.fr.zoreil.com> <20040605070239.GM14247@lbsd.net> <20040605130526.A31872@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4mUolEm2oNas7DxE"
Content-Disposition: inline
In-Reply-To: <20040605130526.A31872@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4mUolEm2oNas7DxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

No luck,

Funny thing is there is nothing in dmesg or even /var/log/messages for
a matter of fact, nor does it kick into sysrq console.

if i ping flood to a ip local on the network from the box giving the
problem, it does not hang.

if i copy something from the box giving the problem onto another pc,
BANG at around 30Mb (varying up to 60Mb) it bombs.

hang is such that nothing can be run, numlock. .. work fine. can't
execute any proggies or anything.

very weird.

I tried the patch to no avail, if i enable debugging the problem does
not occur (so it must be extreme load related).

as I said 2.4.x works fine with hyperthreading, 2.6.x bombs. seeing as
there isn't very much extreme driver change (and seeing as none should
be required) i suspect the problem is deeper.


-Nigel Kukard


On Sat, Jun 05, 2004 at 01:05:26PM +0200, Francois Romieu wrote:
> Nigel Kukard <nkukard@lbsd.net> :
> [...]
> > Any quick fix i can hack?
>=20
> Instant hack below. I do not expect it to make a difference but it _could_
> make one.
>=20
> You probably want to increase NUM_RX_DESC in sis900.h as well and see if
> it changes things: at 7.5Mb/s, it takes 3ms of interrupt processing laten=
cy
> before the network adapter exhaust the Rx ring (this should appear on the
> output of 'ifconfig' btw). So if anything keeps the irq masked for that l=
ong,
> you experience the usually very well tested error/uncommon paths of the
> drivers :o)
>=20
> NUM_RX_DESC at 64 or 256 should not hurt but I do not know if the datashe=
et
> limits the number of Rx descriptors. Fiddling with NUM_RX_DESC could chan=
ge
> the behavior from "computer hangs" to "computer takes noticeably more time
> to hang".
>=20
> --- sis900.c.orig	2004-06-05 11:47:27.000000000 +0200
> +++ sis900.c	2004-06-05 12:43:48.000000000 +0200
> @@ -1626,7 +1626,7 @@ static int sis900_rx(struct net_device *
>  		       "status:0x%8.8x\n",
>  		       sis_priv->cur_rx, sis_priv->dirty_rx, rx_status);
> =20
> -	while (rx_status & OWN) {
> +	while (rx_status & OWN & sis_priv->rx_skbuff[entry]) {
>  		unsigned int rx_size;
> =20
>  		rx_size =3D (rx_status & DSIZE) - CRC_SIZE;
> @@ -1651,16 +1651,6 @@ static int sis900_rx(struct net_device *
>  		} else {
>  			struct sk_buff * skb;
> =20
> -			/* This situation should never happen, but due to
> -			   some unknow bugs, it is possible that
> -			   we are working on NULL sk_buff :-( */
> -			if (sis_priv->rx_skbuff[entry] =3D=3D NULL) {
> -				printk(KERN_INFO "%s: NULL pointer "=20
> -				       "encountered in Rx ring, skipping\n",
> -				       net_dev->name);
> -				break;
> -			}
> -
>  			pci_unmap_single(sis_priv->pci_dev,=20
>  				sis_priv->rx_ring[entry].bufptr, RX_BUF_SIZE,=20
>  				PCI_DMA_FROMDEVICE);
> @@ -1688,18 +1678,21 @@ static int sis900_rx(struct net_device *
>  				       "deferring packet.\n",
>  				       net_dev->name);
>  				sis_priv->rx_skbuff[entry] =3D NULL;
> -				/* reset buffer descriptor state */
> -				sis_priv->rx_ring[entry].cmdsts =3D 0;
> +				/*
> +				 * reset buffer descriptor state and keep it
> +				 * under host control
> +				 */
> +				sis_priv->rx_ring[entry].cmdsts =3D OWN;
>  				sis_priv->rx_ring[entry].bufptr =3D 0;
> -				sis_priv->stats.rx_dropped++;
> -				break;
> +				continue;
>  			}
>  			skb->dev =3D net_dev;
>  			sis_priv->rx_skbuff[entry] =3D skb;
> -			sis_priv->rx_ring[entry].cmdsts =3D RX_BUF_SIZE;
>                  	sis_priv->rx_ring[entry].bufptr =3D=20
>  				pci_map_single(sis_priv->pci_dev, skb->tail,=20
>  					RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
> +			wmb();
> +			sis_priv->rx_ring[entry].cmdsts =3D RX_BUF_SIZE;
>  			sis_priv->dirty_rx++;
>  		}
>  		sis_priv->cur_rx++;
> @@ -1728,10 +1721,11 @@ static int sis900_rx(struct net_device *
>  			}
>  			skb->dev =3D net_dev;
>  			sis_priv->rx_skbuff[entry] =3D skb;
> -			sis_priv->rx_ring[entry].cmdsts =3D RX_BUF_SIZE;
>                  	sis_priv->rx_ring[entry].bufptr =3D
>  				pci_map_single(sis_priv->pci_dev, skb->tail,
>  					RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
> +			wmb();
> +			sis_priv->rx_ring[entry].cmdsts =3D RX_BUF_SIZE;
>  		}
>  	}
>  	/* re-enable the potentially idle receive state matchine */

--4mUolEm2oNas7DxE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAxaJMKoUGSidwLE4RAv4oAJ9OjQwcvoPqyWA7TTElyjWxGKZEcgCfYutH
0aW8WC5Qa3xYolDbK+dV244=
=7def
-----END PGP SIGNATURE-----

--4mUolEm2oNas7DxE--
