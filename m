Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284952AbRLZWEd>; Wed, 26 Dec 2001 17:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284955AbRLZWEX>; Wed, 26 Dec 2001 17:04:23 -0500
Received: from CPE00E02915899A.cpe.net.cable.rogers.com ([24.112.88.234]:60922
	"EHLO shippou.furryterror.org") by vger.kernel.org with ESMTP
	id <S284952AbRLZWEE>; Wed, 26 Dec 2001 17:04:04 -0500
Date: Wed, 26 Dec 2001 17:03:58 -0500
From: Zygo Blaxell <umsfalfb@umail.furryterror.org>
To: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org, hvr@kernel.org
Subject: Cryptoapi on 2.4.17 (2 patches)
Message-ID: <20011226220358.GA32128@feedme.hungrycats.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: multipart/mixed; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have two patches, one for cryptoAPI (current CVS) and one for the
Linux kernel (2.4.17). =20

The cryptoapi patch fixes a silly symbol name bug.  The
patch for the Linux kernel changes the default lo_iv_mode to
LO_IV_MODE_SECTOR--otherwise, the patch is just a straightforward port
of the patch in cryptoapi/doc in cryptoavi CVS.

I noticed that there doesn't seem to be a way to set lo_iv_mode from
user-space, not even with a module or kernel command-line parameter.
Is this just one of those features that isn't implemented yet, or did
I miss something?

The patches seem to work:  I can swap on an rc6 encrypted partition
using the patches, and I can create an ext2 filesystem on an rc6 loopback
file, copy some data to it, unmount, losetup -d, losetup -e, mount it
again, and _still access the data afterwards_.  Whee!

This still doesn't completely work for encrypted swap because somebody
(who shall remain nameless, but whose name rhymes with socks) seems to
have "lost" the kreclaimd kernel thread.  I thought I would try to get=20
someone else to look at this before tackling that problem...


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p1
Content-Transfer-Encoding: quoted-printable

? tests/.deps
? tests/Makefile
? tests/Makefile.in
Index: api/cryptoloop.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/cryptoapi/cryptoapi/api/cryptoloop.c,v
retrieving revision 1.4
diff -u -r1.4 cryptoloop.c
--- api/cryptoloop.c	2001/12/14 23:38:49	1.4
+++ api/cryptoloop.c	2001/12/26 21:30:57
@@ -44,7 +44,7 @@
 # error you need at least kernel 2.4.3 -- unless you know exacty what you =
are doing
 #endif
=20
-#if !defined(LOOP_IV_SECTOR_SIZE)
+#if !defined(LO_IV_SECTOR_SIZE)
 # error you need to to patch your loop.c driver
 #endif
=20
@@ -85,10 +85,10 @@
   struct cipher_context *cx;
=20
   /* encryption breaks for non sector aligned offsets */
-  if (info->lo_offset % LOOP_IV_SECTOR_SIZE)=20
+  if (info->lo_offset % LO_IV_SECTOR_SIZE)=20
     goto out;
=20
-  lx->blocksize =3D LOOP_IV_SECTOR_SIZE;
+  lx->blocksize =3D LO_IV_SECTOR_SIZE;
   lx->debug =3D 0;
=20
   strncpy(cipher, info->lo_name, LO_NAME_SIZE);
@@ -163,7 +163,7 @@
     out =3D raw_buf;
   }
=20
-  IV /=3D blocksize / LOOP_IV_SECTOR_SIZE;
+  IV /=3D blocksize / LO_IV_SECTOR_SIZE;
=20
 #if defined(CRYPTOLOOP_DEBUG)
   if (lx->debug)
@@ -203,7 +203,7 @@
   switch (cmd) {
   case CRYPTOLOOP_SET_BLKSIZE:
     printk (KERN_DEBUG "cryptoloop: switch to blocksize %d requested\n", *=
arg_int);
-    if (*arg_int >=3D 0 && (*arg_int % LOOP_IV_SECTOR_SIZE =3D=3D 0))
+    if (*arg_int >=3D 0 && (*arg_int % LO_IV_SECTOR_SIZE =3D=3D 0))
       {
         lx->blocksize =3D *arg_int;
         err =3D 0;

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p2
Content-Transfer-Encoding: quoted-printable

--- /home/zblaxell/linux/p3-laptop/kernel-source-2.4.17-zb-p3-laptop-zb2001=
122605/drivers/block/loop.c	Fri Dec 21 12:41:53 2001
+++ drivers/block/loop.c	Wed Dec 26 13:59:05 2001
@@ -36,6 +36,9 @@
  * Al Viro too.
  * Jens Axboe <axboe@suse.de>, Nov 2000
  *
+ * Fixed and made IV calculation customizable by lo_iv_mode
+ * Herbert Valerio Riedel <hvr@gnu.org>, Apr 2001
+ *
  * Still To Fix:
  * - Advisory locking is ignored here.=20
  * - Should use an own CAP_* category instead of CAP_SYS_ADMIN=20
@@ -168,6 +171,43 @@
 					lo->lo_device);
 }
=20
+static inline int loop_get_bs(struct loop_device *lo)
+{
+	int bs =3D 0;
+
+	if (blksize_size[MAJOR(lo->lo_device)])
+		bs =3D blksize_size[MAJOR(lo->lo_device)][MINOR(lo->lo_device)];
+	if (!bs)
+		bs =3D BLOCK_SIZE;=09
+
+	return bs;
+}
+
+static inline unsigned long loop_get_iv(struct loop_device *lo,
+					unsigned long sector)
+{
+	unsigned long offset, IV;
+	int bs;
+
+	switch (lo->lo_iv_mode) {
+		case LO_IV_MODE_SECTOR:
+			IV =3D sector + (lo->lo_offset >> LO_IV_SECTOR_BITS);
+			break;
+
+		default:
+			printk (KERN_WARNING "loop: unexpected lo_iv_mode\n");
+		case LO_IV_MODE_DEFAULT:
+			bs =3D loop_get_bs(lo);
+			IV =3D sector / (bs >> 9) + lo->lo_offset / bs;
+			offset =3D ((sector % (bs >> 9)) << 9) + lo->lo_offset % bs;
+			if (offset >=3D bs)
+				IV++;
+			break;
+	}
+
+	return IV;
+}
+
 static int lo_send(struct loop_device *lo, struct buffer_head *bh, int bsi=
ze,
 		   loff_t pos)
 {
@@ -186,7 +226,7 @@
 	len =3D bh->b_size;
 	data =3D bh->b_data;
 	while (len > 0) {
-		int IV =3D index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
+                unsigned long IV =3D loop_get_iv(lo, (pos - lo->lo_offset)=
 >> LO_IV_SECTOR_BITS);
 		int transfer_result;
=20
 		size =3D PAGE_CACHE_SIZE - offset;
@@ -244,7 +284,10 @@
 	unsigned long count =3D desc->count;
 	struct lo_read_data *p =3D (struct lo_read_data*)desc->buf;
 	struct loop_device *lo =3D p->lo;
-	int IV =3D page->index * (PAGE_CACHE_SIZE/p->bsize) + offset/p->bsize;
+	unsigned long IV =3D loop_get_iv(lo,
+		((page->index <<  (PAGE_CACHE_SHIFT - LO_IV_SECTOR_BITS))
+		+ (offset >> LO_IV_SECTOR_BITS)
+		- (lo->lo_offset >> LO_IV_SECTOR_BITS)));
=20
 	if (size > count)
 		size =3D count;
@@ -284,32 +327,6 @@
 	return desc.error;
 }
=20
-static inline int loop_get_bs(struct loop_device *lo)
-{
-	int bs =3D 0;
-
-	if (blksize_size[MAJOR(lo->lo_device)])
-		bs =3D blksize_size[MAJOR(lo->lo_device)][MINOR(lo->lo_device)];
-	if (!bs)
-		bs =3D BLOCK_SIZE;=09
-
-	return bs;
-}
-
-static inline unsigned long loop_get_iv(struct loop_device *lo,
-					unsigned long sector)
-{
-	int bs =3D loop_get_bs(lo);
-	unsigned long offset, IV;
-
-	IV =3D sector / (bs >> 9) + lo->lo_offset / bs;
-	offset =3D ((sector % (bs >> 9)) << 9) + lo->lo_offset % bs;
-	if (offset >=3D bs)
-		IV++;
-
-	return IV;
-}
-
 static int do_bh_filebacked(struct loop_device *lo, struct buffer_head *bh=
, int rw)
 {
 	loff_t pos;
@@ -677,6 +694,7 @@
 	lo->lo_backing_file =3D file;
 	lo->transfer =3D NULL;
 	lo->ioctl =3D NULL;
+	lo->lo_iv_mode =3D LO_IV_MODE_SECTOR;
 	figure_loop_size(lo);
 	lo->old_gfp_mask =3D inode->i_mapping->gfp_mask;
 	inode->i_mapping->gfp_mask =3D GFP_NOIO;

--0ntfKIWw70PvrIHh--

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8KklOzPNvkygjRK0RAneMAJ46i2Nvs+IMEAGxo0hRKWI1S4elNACfRQMY
Gjirc+H+KETLCzQn7vZNe8c=
=kBTT
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
