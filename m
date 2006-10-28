Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWJ1TO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWJ1TO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWJ1TO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:14:57 -0400
Received: from master.altlinux.org ([62.118.250.235]:11015 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932074AbWJ1TO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:14:56 -0400
Date: Sat, 28 Oct 2006 23:14:40 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] usb initialization order (usbhid vs. appletouch)
Message-ID: <20061028191440.GA17787@procyon.home>
Mail-Followup-To: Soeren Sonnenburg <kernel@nn7.de>,
	Oliver Neukum <oliver@neukum.org>,
	linux-usb-devel@lists.sourceforge.net,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1161856438.5214.2.camel@no.intranet.wo.rk> <200610261220.05707.oliver@neukum.org> <1161863380.18657.38.camel@no.intranet.wo.rk> <200610261436.47463.oliver@neukum.org> <1162054576.3769.15.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <1162054576.3769.15.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(sorry for the duplicate - the message was considered as spam by some
servers due to local misconfiguration on my end)

On Sat, Oct 28, 2006 at 06:56:16PM +0200, Soeren Sonnenburg wrote:
[...]
> OK, so I tried adding all of them to the HID_QUIRK_IGNORE LIST, i.e.
>=20
>=20
> #define USB_DEVICE_ID_APPLE_GEYSER_ANSI 0x0214
> #define USB_DEVICE_ID_APPLE_GEYSER_ISO  0x0215
> #define USB_DEVICE_ID_APPLE_GEYSER_JIS  0x0216
> #define USB_DEVICE_ID_APPLE_GEYSER3_ANSI    0x0217
> #define USB_DEVICE_ID_APPLE_GEYSER3_ISO     0x0218
> #define USB_DEVICE_ID_APPLE_GEYSER3_JIS     0x0219
>=20
>=20
>     { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI, HID_QUIRK_IGN=
ORE },
>     { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO, HID_QUIRK_IGNO=
RE },
>     { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS, HID_QUIRK_IGNO=
RE },
>     { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI, HID_QUIRK_IG=
NORE },
>     { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO, HID_QUIRK_IGN=
ORE },
>     { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS, HID_QUIRK_IGN=
ORE },
>     { USB_VENDOR_ID_APPLE, 0x020E, HID_QUIRK_IGNORE },
>     { USB_VENDOR_ID_APPLE, 0x020F, HID_QUIRK_IGNORE },
>     { USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_IGNORE },
>     { USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_IGNORE },
>=20
>=20
> however this did (and cannot) work, as the product id stands for both
> keyboard AND mouse.=20

You mean that the device has multiple HID interfaces, but only one of
them should be ignored by usbhid and passed to appletouch?  Then you
probably need to add a new quirk flag to hiddev (patch completely
untested):

---

=46rom: Sergey Vlasov <vsu@altlinux.ru>
Subject: usbhid: Add HID_QUIRK_IGNORE_MOUSE flag

Some HID devices by Apple have both keyboard and mouse interfaces; the
keyboard interface is handled by usbhid, but the mouse (really
touchpad) interface must be handled by the separate 'appletouch'
driver.  Using HID_QUIRK_IGNORE will make hiddev ignore both
interfaces, therefore a new quirk flag to ignore only the mouse
interface is required.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
index 45f44fe..feb41e7 100644
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1872,6 +1872,9 @@ static struct hid_device *usb_hid_config
=20
 	if (quirks & HID_QUIRK_IGNORE)
 		return NULL;
+	if ((quirks & HID_QUIRK_IGNORE_MOUSE) &&
+	    (interface->desc.bInterfaceProtocol =3D=3D USB_INTERFACE_PROTOCOL_MOU=
SE))
+		return NULL;
=20
 	if (usb_get_extra_descriptor(interface, HID_DT_HID, &hdesc) &&
 	    (!interface->desc.bNumEndpoints ||
diff --git a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
index 9b50eff..abd7b52 100644
--- a/drivers/usb/input/hid.h
+++ b/drivers/usb/input/hid.h
@@ -260,6 +260,7 @@ struct hid_item {
 #define HID_QUIRK_POWERBOOK_HAS_FN		0x00001000
 #define HID_QUIRK_POWERBOOK_FN_ON		0x00002000
 #define HID_QUIRK_INVERT_HWHEEL			0x00004000
+#define HID_QUIRK_IGNORE_MOUSE			0x00008000
=20
 /*
  * This is the global environment of the parser. This information is

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFQ6wgW82GfkQfsqIRAvRLAJ9jtTuuHFnV27leyWh0zvqOdvxLRwCfcE0e
N4Z3zSqO5g6EvmUNSchVfig=
=ZZdy
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
