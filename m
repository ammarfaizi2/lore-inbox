Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281865AbRLDANE>; Mon, 3 Dec 2001 19:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284556AbRLDAF2>; Mon, 3 Dec 2001 19:05:28 -0500
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:54797 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S284592AbRLCONc>; Mon, 3 Dec 2001 09:13:32 -0500
Subject: RFC(ry): breaking loop.c's IV calculation
From: Herbert Valerio Riedel <hvr@hvrlab.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jari Ruusu <jari.ruusu@pp.inet.fi>, axboe@suse.de,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20011202234625.A3447@athlon.random>
In-Reply-To: <3C0A51B0.9AD14E74@pp.inet.fi>
	<Pine.LNX.4.33.0112021716001.2563-100000@janus.txd.hvrlab.org> 
	<20011202234625.A3447@athlon.random>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-9WjS3VUjl/IGkOks5AOz"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 03 Dec 2001 15:12:42 +0100
Message-Id: <1007388763.1674.37.camel@janus.txd.hvrlab.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9WjS3VUjl/IGkOks5AOz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2001-12-02 at 23:46, Andrea Arcangeli wrote:
> > >> ps: any chance to get a sector-based-IV calculation (instead of the
> > >> actual broken soft blocksize based one) into loop.c?!?
> > > I can extract all loop.c bug fixes from loop-AES, excluding AES ciphe=
r, if
> > > someone wants them. Well, I can include AES cipher too, but that woul=
d
> > > royally piss-off the cryptoapi people.
> > ..maybe :-))
> >=20
> > > Does anyone want the bug fixes? Jens? Marcelo?
> > I hope jens & andrea still remember the motivation this IV thing... :-)

> Of course I remeber. I still vote for breaking the IV API and to avoid
> the compatibility cruft. Please post to l-k the patch to change the IV
> granularity from the softblocksize to 512 fixed describing our
> discussion, so if anybody really cares about the current IV API he will
> have a chance to complain before we post the patch for inclusion to
> Marcelo and Linus.
=20
> > btw, I don't care, whether my backward-compatible (or=20
> > 'toothpaste-back-into-tube'-approach as jari=20
> > would call it ;) patch gets approved or whether a radical switch to sec=
tor=20
> > based IV calculation as jari proposes gets accepted...
> >=20
> > we just need a consistent IV metric, regardless of the underlying mediu=
m=20
> > (/dev/cdrom,/dev/fd0,/dev/hda,...) or any involved layers (lvm, md, ...=
)
>=20
> Indeed.

well, I've put one patch together (it still needs (constructive)
auditing though! jari?) here it is (it's against 2.4.16's loop.[ch])

(also available as /pub/linux/kernel/people/hvr/loop2-iv-2.4.16.patch)

Index: drivers/block/loop.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux-2.4-xfs/linux/drivers/block/loop.c,v
retrieving revision 1.43
diff -u -r1.43 loop.c
--- drivers/block/loop.c	2001/11/20 18:59:02	1.43
+++ drivers/block/loop.c	2001/12/03 15:03:36
@@ -85,7 +85,7 @@
  * Transfer functions
  */
 static int transfer_none(struct loop_device *lo, int cmd, char *raw_buf,
-			 char *loop_buf, int size, int real_block)
+			 char *loop_buf, int size, loop_iv_t IV)
 {
 	if (raw_buf !=3D loop_buf) {
 		if (cmd =3D=3D READ)
@@ -98,7 +98,7 @@
 }
=20
 static int transfer_xor(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, int real_block)
+			char *loop_buf, int size, loop_iv_t IV)
 {
 	char	*in, *out, *key;
 	int	i, keysize;
@@ -186,7 +186,7 @@
 	len =3D bh->b_size;
 	data =3D bh->b_data;
 	while (len > 0) {
-		int IV =3D index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
+		const loop_iv_t IV =3D (index << (PAGE_CACHE_SHIFT - LOOP_IV_SECTOR_BITS=
)) + (offset >> LOOP_IV_SECTOR_BITS);
 		int transfer_result;
=20
 		size =3D PAGE_CACHE_SIZE - offset;
@@ -244,7 +244,7 @@
 	unsigned long count =3D desc->count;
 	struct lo_read_data *p =3D (struct lo_read_data*)desc->buf;
 	struct loop_device *lo =3D p->lo;
-	int IV =3D page->index * (PAGE_CACHE_SIZE/p->bsize) + offset/p->bsize;
+	const loop_iv_t IV =3D (page->index << (PAGE_CACHE_SHIFT - LOOP_IV_SECTOR=
_BITS)) + (offset >> LOOP_IV_SECTOR_BITS);
=20
 	if (size > count)
 		size =3D count;
@@ -296,20 +296,6 @@
 	return bs;
 }
=20
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
@@ -455,7 +441,7 @@
 {
 	struct buffer_head *bh =3D NULL;
 	struct loop_device *lo;
-	unsigned long IV;
+	loop_iv_t IV;
=20
 	if (!buffer_locked(rbh))
 		BUG();
@@ -502,7 +488,7 @@
 	 * piggy old buffer on original, and submit for I/O
 	 */
 	bh =3D loop_get_buffer(lo, rbh);
-	IV =3D loop_get_iv(lo, rbh->b_rsector);
+	IV =3D rbh->b_rsector + (lo->lo_offset >> LOOP_IV_SECTOR_BITS);
 	if (rw =3D=3D WRITE) {
 		set_bit(BH_Dirty, &bh->b_state);
 		if (lo_do_transfer(lo, WRITE, bh->b_data, rbh->b_data,
@@ -539,7 +525,7 @@
 		bh->b_end_io(bh, !ret);
 	} else {
 		struct buffer_head *rbh =3D bh->b_private;
-		unsigned long IV =3D loop_get_iv(lo, rbh->b_rsector);
+		const loop_iv_t IV =3D rbh->b_rsector + (lo->lo_offset >> LOOP_IV_SECTOR=
_BITS);
=20
 		ret =3D lo_do_transfer(lo, READ, bh->b_data, rbh->b_data,
 				     bh->b_size, IV);
Index: include/linux/loop.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux-2.4-xfs/linux/include/linux/loop.h,v
retrieving revision 1.5
diff -u -r1.5 loop.h
--- include/linux/loop.h	2001/09/21 16:28:50	1.5
+++ include/linux/loop.h	2001/12/03 15:03:36
@@ -17,6 +17,12 @@
=20
 #ifdef __KERNEL__
=20
+/* definitions for IV metric */
+#define LOOP_IV_SECTOR_BITS 9
+#define LOOP_IV_SECTOR_SIZE (1 << LO_IV_SECTOR_BITS)
+
+typedef unsigned long loop_iv_t;
+
 /* Possible states of device */
 enum {
 	Lo_unbound,
@@ -24,6 +30,12 @@
 	Lo_rundown,
 };
=20
+struct loop_device;
+
+typedef	int (* transfer_proc_t)(struct loop_device *, int cmd,
+				char *raw_buf, char *loop_buf, int size,
+				loop_iv_t IV);
+
 struct loop_device {
 	int		lo_number;
 	int		lo_refcnt;
@@ -32,9 +44,7 @@
 	int		lo_encrypt_type;
 	int		lo_encrypt_key_size;
 	int		lo_flags;
-	int		(*transfer)(struct loop_device *, int cmd,
-				    char *raw_buf, char *loop_buf, int size,
-				    int real_block);
+	transfer_proc_t transfer;
 	char		lo_name[LO_NAME_SIZE];
 	char		lo_encrypt_key[LO_KEY_SIZE];
 	__u32           lo_init[2];
@@ -58,17 +68,13 @@
 	atomic_t		lo_pending;
 };
=20
-typedef	int (* transfer_proc_t)(struct loop_device *, int cmd,
-				char *raw_buf, char *loop_buf, int size,
-				int real_block);
-
 static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rb=
uf,
-				 char *lbuf, int size, int rblock)
+				 char *lbuf, int size, loop_iv_t IV)
 {
 	if (!lo->transfer)
 		return 0;
=20
-	return lo->transfer(lo, cmd, rbuf, lbuf, size, rblock);
+	return lo->transfer(lo, cmd, rbuf, lbuf, size, IV);
 }
 #endif /* __KERNEL__ */
=20
@@ -122,6 +128,8 @@
 #define LO_CRYPT_IDEA     6
 #define LO_CRYPT_DUMMY    9
 #define LO_CRYPT_SKIPJACK 10
+#define LO_CRYPT_AES      16   /* loop-AES */
+#define LO_CRYPT_CRYPTOAPI 18  /* international crypto patch */
 #define MAX_LO_CRYPT	20
=20
 #ifdef __KERNEL__
@@ -129,7 +137,7 @@
 struct loop_func_table {
 	int number; 	/* filter type */=20
 	int (*transfer)(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, int real_block);
+			char *loop_buf, int size, loop_iv_t IV);
 	int (*init)(struct loop_device *, struct loop_info *);=20
 	/* release is called from loop_unregister_transfer or clr_fd */
 	int (*release)(struct loop_device *);=20

--=20
Herbert Valerio Riedel       /    Phone: (EUROPE) +43-1-58801-18840
Email: hvr@hvrlab.org       /    Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F
4142

--=-9WjS3VUjl/IGkOks5AOz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8C4hZSYHgZIg/QUIRAm4UAJ4uFZfaVxC4++F8xAgbf5XAVJvycQCfarn9
xgROB2DD6m8Gzh5gIM0pzO8=
=1lbO
-----END PGP SIGNATURE-----

--=-9WjS3VUjl/IGkOks5AOz--

