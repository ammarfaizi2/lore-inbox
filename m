Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754416AbWKMKjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbWKMKjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 05:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbWKMKjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 05:39:11 -0500
Received: from styx.suse.cz ([82.119.242.94]:56543 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1754416AbWKMKjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 05:39:10 -0500
Subject: [PATCH] Update disk statistics for cciss and cpqarray devices
From: Petr =?iso-8859-2?Q?Tesa=F8=EDk?= <ptesarik@suse.cz>
To: iss_storagedev@hp.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z5WNUaT51RnjKb1ZTdg0"
Organization: SuSE CR
Date: Mon, 13 Nov 2006 11:40:27 +0100
Message-Id: <1163414428.14165.4.camel@golias.tesarici.cz>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z5WNUaT51RnjKb1ZTdg0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The request functions for cciss and cpqarray drivers do not update
statistics upon request completion.  This would normally be done in
end_that_request_first(), but this function is not used by these
drivers, so the number of sectors read/written (as reported
in /proc/diskstat and consequently also by utilities like iostat) is
always zero.

The following patch adds correct statistics for both drivers.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 6ffe2b2..235ecce 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -1298,6 +1298,12 @@ static void cciss_softirq_done(struct re
 		pci_unmap_page(h->pdev, temp64.val, cmd->SG[i].Len, ddir);
 	}
=20
+	if (blk_fs_request(rq)) {
+                const int rw =3D rq_data_dir(rq);
+
+                disk_stat_add(rq->rq_disk, sectors[rw], bio_sectors(rq->bi=
o));
+	}
+
 	complete_buffers(rq->bio, rq->errors);
=20
 #ifdef CCISS_DEBUG
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
index 570d2f0..902155d 100644
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -998,6 +998,7 @@ static inline void complete_buffers(stru
  */
 static inline void complete_command(cmdlist_t *cmd, int timeout)
 {
+	struct request *rq =3D cmd->rq;
 	int ok=3D1;
 	int i, ddir;
=20
@@ -1029,12 +1030,18 @@ static inline void complete_command(cmdl
                 pci_unmap_page(hba[cmd->ctlr]->pci_dev, cmd->req.sg[i].add=
r,
 				cmd->req.sg[i].size, ddir);
=20
-	complete_buffers(cmd->rq->bio, ok);
+	if (blk_fs_request(rq)) {
+                const int rw =3D rq_data_dir(rq);
=20
-	add_disk_randomness(cmd->rq->rq_disk);
+                disk_stat_add(rq->rq_disk, sectors[rw], bio_sectors(rq->bi=
o));
+	}
+
+	complete_buffers(rq->bio, ok);
+
+	add_disk_randomness(rq->rq_disk);
=20
-        DBGPX(printk("Done with %p\n", cmd->rq););
-	end_that_request_last(cmd->rq, ok ? 1 : -EIO);
+	DBGPX(printk("Done with %p\n", rq););
+	end_that_request_last(rq, ok ? 1 : -EIO);
 }
=20
 /*


--=-Z5WNUaT51RnjKb1ZTdg0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Toto je =?iso-8859-2?Q?digit=E1ln=EC?=
	=?ISO-8859-1?Q?_podepsan=E1?= =?iso-8859-2?Q?_=E8=E1st?=
	=?ISO-8859-1?Q?_zpr=E1vy?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFWEuajpY2ODFi2ogRAnqeAJ40jQ1dVuMUgJIQ7VAFxd+N0AbDKACghWWJ
59/9Zku56TosG1AFKskpbtA=
=3D1q
-----END PGP SIGNATURE-----

--=-Z5WNUaT51RnjKb1ZTdg0--

