Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTFTIwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 04:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTFTIwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 04:52:17 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:25472
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id S262451AbTFTIwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 04:52:14 -0400
Date: Fri, 20 Jun 2003 11:06:12 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Initial Vector Fix for loop.c.
Message-ID: <20030620090612.GA1322@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1056963973.bf26@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Meta information:=20

This mail proposes a fix for:=20
must-fix list item "drivers/block/loop.c" and
should-fix list item "drivers/block/cryptoloop"

Content:

loop.c is broken. It's broken since 2.4. In particular the initial vector
calculation which every cryptographic loop transformation uses is broken.

What's the problem you might ask.. It's that that the IV calculation is
based on the logical block sector of the block device. Just think of what
happends if you move your image to another device with a different block
size..

Correct! The IV metric changes and everyone who knows what's CBC
encryption will correctly conclude: you can't read your image.=20

That's bad. And that's the reason why every project which provides you with
encryption via loop.c will also provide you with a patch for this broken
loop.c behavior.=20

The fix is quite simple. Just switch to a fixed IV metric. Which is: the
smallest granulity -> fixed 512-byte and kerneli.org's cryptoloop as well as
Jari's loop-AES do exactly that.

These two packages are the only facilities I'm aware of that provides
harddisc encryption for the 2.4. kernel. However marcello refused to switch
the IV metric for 2.4. because it will - yes that's correct - break any
image which has been created with a IV-sensitiv loop transformation..

=2E.BUT except for cryptoloop and loop-AES there are no such loop
transformation modules! And those two projects have already fixed this
issue. So we're providing backward compatiblity for nothing here. No user
base could ever benefit from this backward compatiblity, since the only
reason the initial vector calculation is done is for crypto and every crypto
project out there already uses the 512-byte IV-metric.

So go for it. Fix it before 2.6.x is out and we're stuck with this crap
again.=20

http://bugzilla.kernel.org/show_bug.cgi?id=3D192

Just apply the patch.=20

If this bug is fixed, we can go ahead and add cryptoloop which is ready and
tested.

Regards, Clemens

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop-clemens-2.5.70.diff"
Content-Transfer-Encoding: quoted-printable

--- drivers/block/loop.c.orig	Fri Jun 20 11:02:10 2003
+++ drivers/block/loop.c	Fri Jun 20 11:02:49 2003
@@ -79,6 +79,8 @@
=20
 #include <asm/uaccess.h>
=20
+#define LOOP_IV_SECTOR_BITS 9
+
 static int max_loop =3D 8;
 static struct loop_device *loop_dev;
 static struct gendisk **disks;
@@ -196,7 +198,7 @@
 	data =3D kmap(bvec->bv_page) + bvec->bv_offset;
 	len =3D bvec->bv_len;
 	while (len > 0) {
-		sector_t IV =3D index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
+		sector_t IV =3D (index << (PAGE_CACHE_SHIFT - LOOP_IV_SECTOR_BITS)) + (o=
ffset >> LOOP_IV_SECTOR_BITS);
 		int transfer_result;
=20
 		size =3D PAGE_CACHE_SIZE - offset;
@@ -279,7 +281,7 @@
 	unsigned long count =3D desc->count;
 	struct lo_read_data *p =3D (struct lo_read_data*)desc->buf;
 	struct loop_device *lo =3D p->lo;
-	int IV =3D page->index * (PAGE_CACHE_SIZE/p->bsize) + offset/p->bsize;
+	int IV =3D  (page->index << (PAGE_CACHE_SHIFT - LOOP_IV_SECTOR_BITS)) + (=
offset >> LOOP_IV_SECTOR_BITS);
=20
 	if (size > count)
 		size =3D count;
@@ -484,7 +486,7 @@
 bio_transfer(struct loop_device *lo, struct bio *to_bio,
 			      struct bio *from_bio)
 {
-	unsigned long IV =3D loop_get_iv(lo, from_bio->bi_sector);
+	unsigned long IV =3D from_bio->bi_sector + (lo->lo_offset >> LOOP_IV_SECT=
OR_BITS);
 	struct bio_vec *from_bvec, *to_bvec;
 	char *vto, *vfrom;
 	int ret =3D 0, i;
@@ -545,7 +547,7 @@
 	 * piggy old buffer on original, and submit for I/O
 	 */
 	new_bio =3D loop_get_buffer(lo, old_bio);
-	IV =3D loop_get_iv(lo, old_bio->bi_sector);
+	IV =3D old_bio->bi_sector + (lo->lo_offset >> LOOP_IV_SECTOR_BITS);
 	if (rw =3D=3D WRITE) {
 		if (bio_transfer(lo, new_bio, old_bio))
 			goto err;

--zhXaljGHf11kAtnf--

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+8s6EW7sr9DEJLk4RAmybAJ0Tl0cZLYLEU6WXvdafUbnJKOCEwgCfTw97
Ql4EuQlvvHRkFdAqkfnrv6Y=
=3vmS
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
