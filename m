Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbVKWGyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbVKWGyh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 01:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbVKWGyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 01:54:36 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:65231 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S1030336AbVKWGyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 01:54:35 -0500
Date: Tue, 22 Nov 2005 22:54:27 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Bob Copeland <me@bobcopeland.com>
Cc: linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH] usb-storage: Add support for Rio Karma
Message-ID: <20051123065427.GA23218@one-eyed-alien.net>
Mail-Followup-To: Bob Copeland <me@bobcopeland.com>,
	linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20051123040752.GA5595@hash.localnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20051123040752.GA5595@hash.localnet>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm guessing you're missing some significant portions of patch here... this
code isn't compiled/linked, you don't add to the unusual_devs table, all
you have here is an initializer function, etc etc.

The material on your web page supports this conclusion.

Matt

On Tue, Nov 22, 2005 at 11:07:52PM -0500, Bob Copeland wrote:
> Add support for the Rio Karma portable digital audio player to usb-storag=
e.
>=20
> Signed-off-by: Bob Copeland <me@bobcopeland.com>
>=20
> ---
>=20
> This is the first in a pair of patches to add the Rio Karma as a mass
> storage device.  This patch exposes the player as a block device when
> connected to USB, and the next patch, "Read Rio Karma boot sector," also
> properly exposes the partitions.  This is useful as-is to users for purpo=
ses
> of back-up/restore or blanking the disk on the unit, e.g. with dd.
>=20
> A filesystem driver for the Optimized MPEG File System, used by both Rio =
Karma
> and ReplayTV, is in an embryonic stage at http://bobcopeland.com/karma/.
>=20
>  drivers/usb/storage/rio_karma.c |  104 +++++++++++++++++++++++++++++++++=
++++++
>  drivers/usb/storage/rio_karma.h |    9 +++
>  2 files changed, 113 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/storage/rio_karma.c
>  create mode 100644 drivers/usb/storage/rio_karma.h
>=20
> applies-to: 3c36672829527bef6951ca2f1eae7da4285fee31
> ece6a8eb17d1b6464349ab2b025fdb8bc76e00da
> diff --git a/drivers/usb/storage/rio_karma.c b/drivers/usb/storage/rio_ka=
rma.c
> new file mode 100644
> index 0000000..ea1be9a
> --- /dev/null
> +++ b/drivers/usb/storage/rio_karma.c
> @@ -0,0 +1,104 @@
> +/* USB driver for DNNA Rio Karma=20
> + *
> + * (C) 2005 Bob Copeland (me@bobcopeland.com)
> + *
> + * The Karma is a mass storage device, although it requires some=20
> + * initialization code to get in that mode. =20
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2, or (at your option) any
> + * later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, write to the Free Software Foundation, Inc=
.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/string.h>
> +#include <linux/jiffies.h>
> +#include "rio_karma.h"
> +#include "usb.h"
> +#include "transport.h"
> +#include "debug.h"
> +
> +#define RIO_MSC 0x08
> +#define RIOP_INIT "RIOP\x00\x01\x08\x00"
> +#define CMD_LEN 40
> +#define RECV_LEN 0x200
> +
> +/* Initialize the Karma and get it into mass storage mode. =20
> + *=20
> + * The initialization begins by sending 40 bytes starting
> + * RIOP\x00\x01\x08\x00, which the device will ack with a 512-byte
> + * packet with the high four bits set and everything else null.
> + *
> + * Next, we send RIOP\x80\x00\x08\x00.  Each time, a 512 byte response
> + * must be read, but we must loop until byte 5 in the response is 0x08,
> + * indicating success.=20
> + */
> +int rio_karma_init(struct us_data *us)=20
> +{
> +	int result, partial;
> +	char *recv;
> +	static char init_cmd[] =3D RIOP_INIT;
> +	unsigned long timeout;
> +
> +	// us->iobuf is big enough to hold cmd but not receive
> +	if (!(recv =3D kmalloc(RECV_LEN, GFP_KERNEL | __GFP_DMA)))
> +		goto die_nomem;
> +
> +	US_DEBUGP("Initializing Karma...\n");
> +
> +	memcpy(us->iobuf, init_cmd, sizeof(init_cmd));
> +	memset(&us->iobuf[sizeof(init_cmd)], 0, CMD_LEN - sizeof(init_cmd));
> +
> +	result =3D usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe,=20
> +		us->iobuf, CMD_LEN, &partial);
> +	if (result !=3D USB_STOR_XFER_GOOD)
> +		goto die;
> +
> +	result =3D usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,=20
> +		recv, RECV_LEN, &partial);
> +	if (result !=3D USB_STOR_XFER_GOOD)
> +		goto die;
> +
> +	us->iobuf[4] =3D 0x80;
> +	us->iobuf[5] =3D 0;
> +	timeout =3D jiffies + msecs_to_jiffies(3000);=20
> +	for (;;) {
> +		US_DEBUGP("Sending init command\n");
> +		result =3D usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe,=20
> +			us->iobuf, CMD_LEN, &partial);
> +		if (result !=3D USB_STOR_XFER_GOOD)
> +			goto die;
> +
> +		result =3D usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,=20
> +			recv, RECV_LEN, &partial);
> +		if (result !=3D USB_STOR_XFER_GOOD)
> +			goto die;
> +	=09
> +		if (recv[5] =3D=3D RIO_MSC)=20
> +			break;
> +		if (time_after(jiffies, timeout))
> +			goto die;
> +		msleep(10);
> +	}
> +	US_DEBUGP("Karma initialized.\n");
> +	kfree(recv);
> +	return 0;
> +
> +die:
> +	kfree(recv);
> +die_nomem:
> +	US_DEBUGP("Could not initialize karma.\n");
> +	return USB_STOR_TRANSPORT_FAILED;
> +}
> +
> diff --git a/drivers/usb/storage/rio_karma.h b/drivers/usb/storage/rio_ka=
rma.h
> new file mode 100644
> index 0000000..99b44fd
> --- /dev/null
> +++ b/drivers/usb/storage/rio_karma.h
> @@ -0,0 +1,9 @@
> +#ifndef _RIO_KARMA_H
> +#define _RIO_KARMA_H
> +
> +#include <linux/config.h>
> +#include "usb.h"
> +
> +int rio_karma_init(struct us_data *);
> +
> +#endif
> ---
> 0.99.9i
> --=20
> Bob Copeland %% www.bobcopeland.com=20

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

G:  Money isn't everything, A.J.
AJ: Who convinced you of that?
G:  The Chief, at my last salary review.
					-- Mike and Greg
User Friendly, 11/3/1998

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDhBIjHL9iwnUZqnkRAtVZAJ0V+/BR1k0i2vcpD7y8LBoTpfdbLQCfYPnr
o3+YTDBbv8sYF+m+vP2h51A=
=mSE9
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
