Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267683AbUHVWVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267683AbUHVWVa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 18:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUHVWUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 18:20:54 -0400
Received: from mx-out.forthnet.gr ([193.92.150.5]:48278 "EHLO
	mx-out-02.forthnet.gr") by vger.kernel.org with ESMTP
	id S267635AbUHVWT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 18:19:29 -0400
From: Stefanos Harhalakis <v13@priest.com>
To: rmk@arm.linux.org.uk
Subject: [PATCH] Reread partition table when a partition is added
Date: Mon, 23 Aug 2004 01:19:06 +0300
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1956643.Aa7maqyi5A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408230119.12878.v13@priest.com>
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1956643.Aa7maqyi5A
Content-Type: multipart/mixed;
  boundary="Boundary-01=_bvRKBa4MDf2NMVf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_bvRKBa4MDf2NMVf
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  This small patch rereads the partition table even if the block device is=
=20
beeing used. It only rereads it when there are no changes at the current=20
partitions and there are new partitions added at the end. Any existing=20
partition change will/should make it fail.

  Is it OK and/or useful ?

  (I'm quite inexperienced about kernel coding so be gentle :)

Signed-off-by: Stefanos Harhalakis <v13@priest.com>

RCS file: /usr/local/cvsroot/linux-2.6/fs/partitions/check.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 check.c
=2D-- check.c	22 Aug 2004 11:08:27 -0000	1.1.1.1
+++ check.c	22 Aug 2004 22:09:11 -0000
@@ -391,19 +391,44 @@ void register_disk(struct gendisk *disk)
 	blkdev_put(bdev);
 }
=20
+/*
+ * Determine the last partition.
+ * Return the partition number or 0 if there is no partition
+ */
+static int get_last_partition(struct gendisk *disk)
+{
+	int	n, ret =3D 0;
+
+	for (n=3D0; n < disk->minors ; n++) {
+		if (disk->part[n])
+			ret=3Dn+1;
+	}
+
+	return(ret);
+}
+
 int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct parsed_partitions *state;
+	struct hd_struct *phd;
 	int p, res;
+	int is_busy =3D 0, last_partition =3D 0;
+
+	if (bdev->bd_part_count) {
+		is_busy =3D 1;
+		last_partition=3Dget_last_partition(disk);
+	}
=20
=2D	if (bdev->bd_part_count)
=2D		return -EBUSY;
 	res =3D invalidate_partition(disk, 0);
 	if (res)
 		return res;
 	bdev->bd_invalidated =3D 0;
=2D	for (p =3D 1; p < disk->minors; p++)
=2D		delete_partition(disk, p);
+
+	if (!is_busy) {
+		for (p =3D 1; p < disk->minors; p++)
+			delete_partition(disk, p);
+	}
+
 	if (disk->fops->revalidate_disk)
 		disk->fops->revalidate_disk(disk);
 	if (!get_capacity(disk) || !(state =3D check_partition(disk, bdev)))
@@ -411,13 +436,29 @@ int rescan_partitions(struct gendisk *di
 	for (p =3D 1; p < state->limit; p++) {
 		sector_t size =3D state->parts[p].size;
 		sector_t from =3D state->parts[p].from;
+
+		if (is_busy && p<=3Dlast_partition) {
+			phd=3Ddisk->part[p-1];
+			if (phd !=3D NULL && (phd->start_sect !=3D from ||
+			 	phd->nr_sects !=3D size)) {
+				printk(KERN_INFO
+					"Existing partition was changed. "
+					"Reboot is required.\n");
+				res=3D-EBUSY;
+				break;
+			}
+		}
+
 		if (!size)
 			continue;
=2D		add_partition(disk, p, from, size);
+
+		if (!is_busy || p>last_partition) {
+			add_partition(disk, p, from, size);
 #ifdef CONFIG_BLK_DEV_MD
=2D		if (state->parts[p].flags)
=2D			md_autodetect_dev(bdev->bd_dev+p);
+			if (state->parts[p].flags)
+				md_autodetect_dev(bdev->bd_dev+p);
 #endif
+		}
 	}
 	kfree(state);
 	return res;

--Boundary-01=_bvRKBa4MDf2NMVf
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rescan_partitions.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rescan_partitions.patch"

RCS file: /usr/local/cvsroot/linux-2.6/fs/partitions/check.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 check.c
=2D-- check.c	22 Aug 2004 11:08:27 -0000	1.1.1.1
+++ check.c	22 Aug 2004 22:09:11 -0000
@@ -391,19 +391,44 @@ void register_disk(struct gendisk *disk)
 	blkdev_put(bdev);
 }
=20
+/*
+ * Determine the last partition.
+ * Return the partition number or 0 if there is no partition
+ */
+static int get_last_partition(struct gendisk *disk)
+{
+	int	n, ret =3D 0;
+
+	for (n=3D0; n < disk->minors ; n++) {
+		if (disk->part[n])
+			ret=3Dn+1;
+	}
+
+	return(ret);
+}
+
 int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct parsed_partitions *state;
+	struct hd_struct *phd;
 	int p, res;
+	int is_busy =3D 0, last_partition =3D 0;
+
+	if (bdev->bd_part_count) {
+		is_busy =3D 1;
+		last_partition=3Dget_last_partition(disk);
+	}
=20
=2D	if (bdev->bd_part_count)
=2D		return -EBUSY;
 	res =3D invalidate_partition(disk, 0);
 	if (res)
 		return res;
 	bdev->bd_invalidated =3D 0;
=2D	for (p =3D 1; p < disk->minors; p++)
=2D		delete_partition(disk, p);
+
+	if (!is_busy) {
+		for (p =3D 1; p < disk->minors; p++)
+			delete_partition(disk, p);
+	}
+
 	if (disk->fops->revalidate_disk)
 		disk->fops->revalidate_disk(disk);
 	if (!get_capacity(disk) || !(state =3D check_partition(disk, bdev)))
@@ -411,13 +436,29 @@ int rescan_partitions(struct gendisk *di
 	for (p =3D 1; p < state->limit; p++) {
 		sector_t size =3D state->parts[p].size;
 		sector_t from =3D state->parts[p].from;
+
+		if (is_busy && p<=3Dlast_partition) {
+			phd=3Ddisk->part[p-1];
+			if (phd !=3D NULL && (phd->start_sect !=3D from ||
+			 	phd->nr_sects !=3D size)) {
+				printk(KERN_INFO
+					"Existing partition was changed. "
+					"Reboot is required.\n");
+				res=3D-EBUSY;
+				break;
+			}
+		}
+
 		if (!size)
 			continue;
=2D		add_partition(disk, p, from, size);
+
+		if (!is_busy || p>last_partition) {
+			add_partition(disk, p, from, size);
 #ifdef CONFIG_BLK_DEV_MD
=2D		if (state->parts[p].flags)
=2D			md_autodetect_dev(bdev->bd_dev+p);
+			if (state->parts[p].flags)
+				md_autodetect_dev(bdev->bd_dev+p);
 #endif
+		}
 	}
 	kfree(state);
 	return res;

--Boundary-01=_bvRKBa4MDf2NMVf--

--nextPart1956643.Aa7maqyi5A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBKRvgVEjwdyuhmSoRAiIfAJ9mGhZfcX6xKiEKh9S/R/ODiTw3pQCgwwf8
GqFP6F78abh7fr7NfY5Bak8=
=Ga1P
-----END PGP SIGNATURE-----

--nextPart1956643.Aa7maqyi5A--
