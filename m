Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVA0OfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVA0OfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 09:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVA0OfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 09:35:23 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:48077 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262625AbVA0OfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 09:35:13 -0500
Subject: Re: swap on dmcrypt crashes machine
From: Christophe Saout <christophe@saout.de>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <200501251828.17569.mbuesch@freenet.de>
References: <200501251828.17569.mbuesch@freenet.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SLDThBeWXDz/psYJ2Tbs"
Date: Thu, 27 Jan 2005 15:34:50 +0100
Message-Id: <1106836490.27812.6.camel@server.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SLDThBeWXDz/psYJ2Tbs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 25.01.2005, 18:28 +0100 schrieb Michael Buesch:

> I set up swap on an encrypted dmcrypt device.
> While stressing swap usage with make -j200 in the
> kernel tree, the machine crashes:
>=20
> Adding 1461872k swap on /dev/mapper/swap.  Priority:-2 extents:1
> ------------[ cut here ]------------
> kernel BUG at drivers/block/ll_rw_blk.c:2193!
> invalid operand: 0000 [#1]
> SMP=20
> Modules linked in: ipv6 ohci_hcd tuner tvaudio msp3400 bttv video_buf fir=
mware_class btcx_risc nvidia ehci_hcd uhci_hcd usbcore intel_agp agpgart ev=
dev
> CPU:    0
> EIP:    0060:[<c0218b8a>]    Tainted: P      VLI
> EFLAGS: 00210002   (2.6.10-ck4-defaultidle)=20
> EIP is at __blk_put_request+0x87/0x91

This seems to be this BUG:

BUG_ON(!list_empty(&req->queuelist));

in drivers/block/ll_rw_blk.c. I don't know how this could be non-empty
since scsi_end_request calls

if (blk_rq_tagged(req))
         blk_queue_end_tag(q, req);

just before calling end_that_request_last inside the same spinlock.

I don't know anything about tagged request handling but I don't think
this is the fault of the dm-crypt driver, perhaps it's stressing the
queue in some unexpected way? I have no idea what's going on here.


--=-SLDThBeWXDz/psYJ2Tbs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB+PwKZCYBcts5dM0RAsYnAJ9FkVAVeeRjhD9ub2buLpcum+C0dACdEzli
0AZOe1jPRnA7ByrIBrHcYm4=
=UXo8
-----END PGP SIGNATURE-----

--=-SLDThBeWXDz/psYJ2Tbs--
