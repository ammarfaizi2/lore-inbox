Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUFNS22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUFNS22 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUFNS21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:28:27 -0400
Received: from [196.25.168.8] ([196.25.168.8]:46212 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S263770AbUFNS17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:27:59 -0400
Date: Mon, 14 Jun 2004 20:27:37 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: webvenza@libero.it, linux-kernel@vger.kernel.org
Subject: Re: [HANG] SIS900 + P4 Hyperthread
Message-ID: <20040614182737.GG18169@lbsd.net>
References: <40C0E37C.4030905@lbsd.net> <20040604214721.GC22679@picchio.gall.it> <20040605005033.A26051@electric-eye.fr.zoreil.com> <20040605070239.GM14247@lbsd.net> <20040605130526.A31872@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
In-Reply-To: <20040605130526.A31872@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Any more ideas?  :(

-Nigel

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

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAze4ZKoUGSidwLE4RAiIJAKCcbkfoui5Ci3FER/ra5dca6MGwYQCgviDQ
OcQJeUgjkUpfzbc8lPoZsjs=
=IgqY
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
