Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWHGOzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWHGOzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWHGOzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:55:44 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:34435 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750844AbWHGOzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:55:43 -0400
Date: Mon, 07 Aug 2006 10:54:56 -0400
From: David Hollis <dhollis@davehollis.com>
Subject: Re: [PATCH] please review mcs7830 (DeLOCK USB etherner) driver
In-reply-to: <200608071500.55903.arnd.bergmann@de.ibm.com>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, support@moschip.com,
       Michael Helmling <supermihi@web.de>
Message-id: <1154962496.2496.12.camel@dhollis-lnx.sunera.com>
MIME-version: 1.0
X-Mailer: Evolution 2.7.4 (2.7.4-4)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-djnEjU8a+k/grQnLDsuA"
References: <200608071500.55903.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-djnEjU8a+k/grQnLDsuA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-08-07 at 15:00 +0200, Arnd Bergmann wrote:
> +
> +/* index for PHY registers */
> +enum {
> +	PHY_CONTROL_REG_INDEX			=3D  0,
> +	PHY_STATUS_REG_INDEX			=3D  1,
> +	PHY_IDENTIFICATION1_REG_INDEX		=3D  2,
> +	PHY_IDENTIFICATION2_REG_INDEX		=3D  3,
> +	PHY_AUTONEGADVT_REG_INDEX		=3D  4,
> +	PHY_AUTONEGLINK_REG_INDEX		=3D  5,
> +	PHY_AUTONEGEXP_REG_INDEX		=3D  6,

These values are dupes of the MII_xxxx constants from linux/mii.h.  It
would be clearer and more consistent to use those instead

> +	PHY_MIRROR_REG_INDEX			=3D 16,
> +	PHY_INTERRUPTENABLE_REG_INDEX		=3D 17,
> +	PHY_INTERRUPTSTATUS_REG_INDEX		=3D 18,
> +	PHY_CONFIG_REG_INDEX			=3D 19,
> +	PHY_CHIPSTATUS_REG_INDEX		=3D 20,
> +};

These values are device specific so you would want to define them here.
Following the MII_xxxxx naming convention may be helpful.

> +
> +static DEFINE_MUTEX(mcs7830_phy_mutex);
> +

Does this need to be global?  Isn't it really just to prevent
simultaneous access to the adapters PHY?  What if you have multiple
adapters installed?

> +
> +static int mcs7830_bind(struct usbnet *dev, struct usb_interface *udev)
> +{
> +	struct net_device *net =3D dev->net;
> +	int ret;
> +
> +	ret =3D mcs7830_init_dev(dev);
> +	if (ret)
> +		goto out;
> +
> +	net->do_ioctl =3D mcs7830_ioctl;
> +	net->set_multicast_list =3D mcs7830_set_multicast;
> +	mcs7830_set_multicast(net);
> +
> +	dev->mii.mdio_read =3D mcs7830_mdio_read;
> +	dev->mii.mdio_write =3D mcs7830_mdio_write;
> +	dev->mii.dev =3D net;
> +	dev->mii.phy_id_mask =3D 0x3f;
> +	dev->mii.reg_num_mask =3D 0x1f;
> +	dev->mii.phy_id =3D *((u8 *) net->dev_addr + 1);
> +
> +	dev->in =3D usb_rcvbulkpipe(dev->udev, 1);
> +	dev->out =3D usb_sndbulkpipe(dev->udev, 2);

Couldn't you use usbnet_getendpoints() here.  It will also pick up the
status pipe.

> +out:
> +	return ret;
> +}
> +
> +static int mcs7830_check_connect(struct usbnet *dev)
> +{
> +	int ret;
> +	ret =3D mcs7830_mdio_read(dev->net, dev->mii.phy_id, 1);

use MII_BMSR here instead of the magic value '1'.
> +	return !ret;
> +}
> +

--=20
David Hollis <dhollis@davehollis.com>

--=-djnEjU8a+k/grQnLDsuA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE11RAxasLqOyGHncRAgGzAJ4x3jEQA1ttDa6+b0CAKU3k0GhWawCfWOXo
vcK0NW7OY9ramwHXtfXAf5E=
=awyr
-----END PGP SIGNATURE-----

--=-djnEjU8a+k/grQnLDsuA--

