Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTI1XCo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTI1XCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:02:44 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:64786 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262745AbTI1XCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:02:39 -0400
Date: Sun, 28 Sep 2003 16:02:38 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: error in drivers/block/scsi_ioctl.c and ll_rw_block.c?
Message-ID: <20030928160238.A18507@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While working on usb-storage (a virtual SCSI HBA), I noticed that the
command 'eject /dev/scd0' sent a START_STOP command to the device with the
data direction set to SCSI_DATA_WRITE but a transfer length of zero.  This
causes a problem for some code paths.

For clarity, the START_STOP command doesn't want to move any data at all.

It looks to me like the error is a combination of
drivers/block/scsi_ioctl.c and ll_rw_block.c

scsi_ioctl.c calls blk_get_request(q, WRITE, __GFP_WAIT) to allocate the
request -- specifying WRITE here is one problem.

In ll_rw_block.c, blk_get_request() calls BUG_ON(rq !=3D READ && rw !=3D WR=
ITE)
-- in other words, it can only allocate a request for reading or writing,
but not for no data.  I'm not familiar with this code, but it looks like
requests are tracked by data direction, so making this accept NONE may be
difficult.

One possible solution may be to re-write the CDROMEJECT ioctl into a call
to sg_scsi_ioctl(), but that doesn't fix the general problem with
ll_rw_block.c -- if, indeed, that is a problem.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It's not that hard.  No matter what the problem is, tell the customer=20
to reinstall Windows.
					-- Nurse
User Friendly, 3/22/1998

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/d2iOIjReC7bSPZARAoCfAJ9W2zvI3ro1vVBGLEuKBBicDa/QfQCfQMgl
zdzsCP+Ahr4c5f6aRXion+A=
=zt2T
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
