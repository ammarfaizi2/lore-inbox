Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSGQUtR>; Wed, 17 Jul 2002 16:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSGQUr6>; Wed, 17 Jul 2002 16:47:58 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:28759 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316774AbSGQUrC>; Wed, 17 Jul 2002 16:47:02 -0400
Date: Wed, 17 Jul 2002 22:49:38 +0200
From: Kurt Garloff <garloff@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] IDE: memset kmalloced gendisk structures
Message-ID: <20020717204938.GL2568@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andre Hedrick <andre@linux-ide.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/UvyDgxjlFfP/4zZ"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/UvyDgxjlFfP/4zZ
Content-Type: multipart/mixed; boundary="3hAdtgBjtgL7p0NQ"
Content-Disposition: inline


--3hAdtgBjtgL7p0NQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the IDE driver does kmalloc() memory for filling in the gendisk structure.
But it does neither copy an initialized structure in there nor does it
memset(,0,) the structure, so the fields not initialized explicitly
are filled with random values, often with 0x5a5a5a5a (slab poisoning) ...

This is bound to break as soon as some field gets added to the gendisk
struct; normally authors assume that the unknown/unused fields are
initialized to zero by the compiler.

Patch against 2.4.19rc1 attached.
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations    <K.Garloff@TUE.NL>     [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--3hAdtgBjtgL7p0NQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-memset0-2419rc1.diff"

--- linux-2.4.18.S18.scsimany3/drivers/ide/ide-probe.c	Wed Jun 12 11:37:15 2002
+++ linux-2.4.18.S18.scsimany/drivers/ide/ide-probe.c	Wed Jul 17 14:49:29 2002
@@ -779,6 +779,7 @@
 	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
 	if (!gd)
 		goto err_kmalloc_gd;
+	memset (gd, 0, sizeof(struct gendisk));
 	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
 	if (!gd->sizes)
 		goto err_kmalloc_gd_sizes;

--3hAdtgBjtgL7p0NQ--

--/UvyDgxjlFfP/4zZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9NdhixmLh6hyYd04RAn3yAJ9SirXg7/NxGNic5+FHdI/hOxfoRwCeNQn+
cYdRvMty+AlklbsyAMCPKbY=
=NOkv
-----END PGP SIGNATURE-----

--/UvyDgxjlFfP/4zZ--
