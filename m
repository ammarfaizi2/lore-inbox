Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbRH0Tz7>; Mon, 27 Aug 2001 15:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbRH0Tzu>; Mon, 27 Aug 2001 15:55:50 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:26124
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S267534AbRH0Tzl>; Mon, 27 Aug 2001 15:55:41 -0400
Date: Mon, 27 Aug 2001 12:55:48 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
        Linux SCSI list <linux-scsi@vger.kernel.org>,
        Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Possible patch for MODE_SENSE?
Message-ID: <20010827125548.B9994@one-eyed-alien.net>
Mail-Followup-To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Linux SCSI list <linux-scsi@vger.redhat.com>,
	Kernel Developer List <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Warning, this is crossposted to several lists.  Beware of Reply-To-All.

Attached to this message is a one-line patch which changes the way Write
Protect detection is done in sd.c

Formerly, we requested "all pages" but only "8 bytes" so we could get the
header data to test the WP bit.  But, I'm seeing more and more devices
which _really_ don't like this... and we wind up with bizzare results,
because the device basically is confused.

The problem is, apparently, our friends in Redmond don't do it this way.
And that's all anyone ever designs towards anymore.

This patch increases the requested data to 255 bytes.  That's enough in the
testing I've done (or had people do -- about 3 different devices, so far)
to avoid the problem entirely.

I'd like people to try this patch and let me know if it breaks anything on
their system.  I don't think it should -- any device which responded
properly to request for 8 bytes should work fine with larger requests, and
devices which didn't work the old way will either (a) still not work, or
(b) start working.

At least, that's the theory.

I'd like some wider testing on this... can people give it a whirl and let
me know what they get?

Matt Dharm

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I'll scuff my feet on the carpet and zap your nose hairs unless you=20
TALK mister!! Who put you up to this?
					-- Pitr
User Friendly, 3/30/1998

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

diff -u -uNr linux-2.4.9/drivers/scsi/sd.c linux/drivers/scsi/sd.c
--- linux-2.4.9/drivers/scsi/sd.c	Sat Aug 25 15:57:07 2001
+++ linux/drivers/scsi/sd.c	Fri Aug 24 14:56:01 2001
@@ -1020,7 +1020,7 @@
 		cmd[1] = (rscsi_disks[i].device->scsi_level <= SCSI_2) ?
 			 ((rscsi_disks[i].device->lun << 5) & 0xe0) : 0;
 		cmd[2] = 0x3f;	/* Get all pages */
-		cmd[4] = 8;     /* But we only want the 8 byte header */
+		cmd[4] = 255;     /* But we only want the 8 byte header */
 		SRpnt->sr_cmd_len = 0;
 		SRpnt->sr_sense_buffer[0] = 0;
 		SRpnt->sr_sense_buffer[2] = 0;

--X1bOJ3K7DJ5YkBrT--

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7iqXEz64nssGU+ykRAqXIAJ9/SnzalbvXHu28AdD8+V4MVPz0UgCgvwWq
/8tOQgh1fNGnMSuKbB9/cfM=
=r4KN
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
