Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVGTOtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVGTOtO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVGTOtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:49:13 -0400
Received: from mivlgu.ru ([81.18.140.87]:49880 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S261323AbVGTOsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:48:45 -0400
Date: Wed, 20 Jul 2005 18:34:20 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Stephen Evanchik <evanchsa@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics and TrackPoint problems in 2.6.12
Message-Id: <20050720183420.282f72f4.vsu@altlinux.ru>
In-Reply-To: <a71293c2050719204047bd2afe@mail.gmail.com>
References: <a71293c2050719204047bd2afe@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__20_Jul_2005_18_34_20_+0400_VlCx/IirFlmVBaHw"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__20_Jul_2005_18_34_20_+0400_VlCx/IirFlmVBaHw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 19 Jul 2005 23:40:18 -0400 Stephen Evanchik wrote:

> I have been receiving a lot of complaints that TrackPoints on
> Synaptics pass-thru ports stopped working with 2.6.12. I retested
> 2.6.9 and 2.6.11-rc3 successfully, I believe 2.6.11.7 may also work
> but that is unconfirmed at this point.
> 
> The behavior is always the same .. after sending the read secondary ID
> command, the TrackPoint seems to be disabled from that point forward.
> 
> Any ideas?

Looks like this problem was introduced by the change from PSMOUSE_PS2 to
PSMOUSE_TRACKPOINT in the TrackPoint support patch.  The Synaptics
driver needs to know whether the device on the pass-thru port is using
3-byte or 4-byte packets; however, instead of checking child->pktsize,
it checks child->type >= PSMOUSE_GENPS - and this check is now giving a
wrong result.  Therefore the Synaptics driver configures the pass-thru
port for 4-byte packets, and all 3-byte packets from TrackPoint seem to
be thrown away.

The patch below is reported to fix the problem - now the 4-byte mode is
used only if child->pktsize == 4.  Another option is to change the
PSMOUSE_TRACKPOINT value so that it is less than PSMOUSE_GENPS, however,
I think that checking child->pktsize is more correct in this case.

In theory, someone could attach a device which uses 6-byte packets to
the Synaptics pass-thru port; I'm not sure what would happen in this
case, but with Synaptics confugured for 3-byte packets (as the patch
below will do) this configuration even has a chance of working.

---
Subject: [PATCH] Fix pass-thru port configuration in the Synaptics driver

The Synaptics driver uses child->type to select either 3-byte or 4-byte
packet size for the pass-thru port; this gives wrong results at least
for PSMOUSE_TRACKPOINT.  Change the check to use child->pktsize instead.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

--- linux-2.6.12/drivers/input/mouse/synaptics.c.alt-synaptics-with-trackpoint	2005-06-17 23:48:29 +0400
+++ linux-2.6.12/drivers/input/mouse/synaptics.c	2005-07-09 21:09:01 +0400
@@ -219,7 +219,7 @@ static void synaptics_pass_pt_packet(str
 		serio_interrupt(ptport, packet[1], 0, NULL);
 		serio_interrupt(ptport, packet[4], 0, NULL);
 		serio_interrupt(ptport, packet[5], 0, NULL);
-		if (child->type >= PSMOUSE_GENPS)
+		if (child->pktsize == 4)
 			serio_interrupt(ptport, packet[2], 0, NULL);
 	} else
 		serio_interrupt(ptport, packet[1], 0, NULL);
@@ -233,7 +233,7 @@ static void synaptics_pt_activate(struct
 
 	/* adjust the touchpad to child's choice of protocol */
 	if (child) {
-		if (child->type >= PSMOUSE_GENPS)
+		if (child->pktsize == 4)
 			priv->mode |= SYN_BIT_FOUR_BYTE_CLIENT;
 		else
 			priv->mode &= ~SYN_BIT_FOUR_BYTE_CLIENT;


--Signature=_Wed__20_Jul_2005_18_34_20_+0400_VlCx/IirFlmVBaHw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC3mDvW82GfkQfsqIRAsPdAJ47TjrnTJpf8GNDfFNdQGgXyCkjOgCgliv4
eCpSO25/4keY9mED7nd9lfA=
=Pvam
-----END PGP SIGNATURE-----

--Signature=_Wed__20_Jul_2005_18_34_20_+0400_VlCx/IirFlmVBaHw--
