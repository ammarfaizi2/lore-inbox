Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272321AbTHNM1B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 08:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272323AbTHNM1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 08:27:01 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:50560
	"HELO leto2.endorphin.org") by vger.kernel.org with SMTP
	id S272321AbTHNM04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 08:26:56 -0400
Date: Thu, 14 Aug 2003 14:26:55 +0200
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] cryptoloop: 2 fixes. resend
Message-ID: <20030814122655.GA1485@leto2.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1061728015.bf63@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Two fixes for cryptoloop:

Patch #1: Fixes ECB mode. cryptoloop won't oops anymore if ECB mode is
requested.=20

Patch #2: Fixes disk corruption under CBC mode caused by improper IV
calculation in loop.c. Tested:=20
http://marc.theaimsgroup.com/?t=3D106048335200003&r=3D1&w=3D2

Please apply.

Regards, Clemens

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cryptoloop-ecb.diff"
Content-Transfer-Encoding: quoted-printable

--- drivers/block/cryptoloop.c.orig	Sun Jul 27 19:03:58 2003
+++ drivers/block/cryptoloop.c	Sat Aug  9 13:51:03 2003
@@ -79,20 +79,70 @@
 	return err;
 }
=20
-typedef int (*encdec_t)(struct crypto_tfm *tfm,
+
+typedef int (*encdec_ecb_t)(struct crypto_tfm *tfm,
+			struct scatterlist *sg_out,
+			struct scatterlist *sg_in,
+			unsigned int nsg);
+
+
+static int
+cryptoloop_transfer_ecb(struct loop_device *lo, int cmd, char *raw_buf,
+		     char *loop_buf, int size, sector_t IV)
+{
+	struct crypto_tfm *tfm =3D (struct crypto_tfm *) lo->key_data;
+	struct scatterlist sg_out =3D { 0, };
+	struct scatterlist sg_in =3D { 0, };
+
+	encdec_ecb_t encdecfunc;
+	char const *in;
+	char *out;
+
+	if (cmd =3D=3D READ) {
+		in =3D raw_buf;
+		out =3D loop_buf;
+		encdecfunc =3D tfm->crt_u.cipher.cit_decrypt;
+	} else {
+		in =3D loop_buf;
+		out =3D raw_buf;
+		encdecfunc =3D tfm->crt_u.cipher.cit_encrypt;
+	}
+
+	while (size > 0) {
+		const int sz =3D min(size, LOOP_IV_SECTOR_SIZE);
+
+		sg_in.page =3D virt_to_page(in);
+		sg_in.offset =3D (unsigned long)in & ~PAGE_MASK;
+		sg_in.length =3D sz;
+
+		sg_out.page =3D virt_to_page(out);
+		sg_out.offset =3D (unsigned long)out & ~PAGE_MASK;
+		sg_out.length =3D sz;
+
+		encdecfunc(tfm, &sg_out, &sg_in, sz);
+
+		size -=3D sz;
+		in +=3D sz;
+		out +=3D sz;
+	}
+
+	return 0;
+}
+
+typedef int (*encdec_cbc_t)(struct crypto_tfm *tfm,
 			struct scatterlist *sg_out,
 			struct scatterlist *sg_in,
 			unsigned int nsg, u8 *iv);
=20
 static int
-cryptoloop_transfer(struct loop_device *lo, int cmd, char *raw_buf,
+cryptoloop_transfer_cbc(struct loop_device *lo, int cmd, char *raw_buf,
 		     char *loop_buf, int size, sector_t IV)
 {
 	struct crypto_tfm *tfm =3D (struct crypto_tfm *) lo->key_data;
 	struct scatterlist sg_out =3D { 0, };
 	struct scatterlist sg_in =3D { 0, };
=20
-	encdec_t encdecfunc;
+	encdec_cbc_t encdecfunc;
 	char const *in;
 	char *out;
=20
@@ -130,6 +180,27 @@
 	return 0;
 }
=20
+static int
+cryptoloop_transfer(struct loop_device *lo, int cmd, char *raw_buf,
+		     char *loop_buf, int size, sector_t IV)
+{
+	struct crypto_tfm *tfm =3D (struct crypto_tfm *) lo->key_data;
+	if(tfm->crt_cipher.cit_mode =3D=3D CRYPTO_TFM_MODE_ECB)
+	{
+		lo->transfer =3D cryptoloop_transfer_ecb;
+		return cryptoloop_transfer_ecb(lo, cmd, raw_buf, loop_buf, size, IV);
+	}=09
+	if(tfm->crt_cipher.cit_mode =3D=3D CRYPTO_TFM_MODE_CBC)
+	{=09
+		lo->transfer =3D cryptoloop_transfer_cbc;
+		return cryptoloop_transfer_cbc(lo, cmd, raw_buf, loop_buf, size, IV);
+	}
+=09
+	/*  This is not supposed to happen */
+
+	printk( KERN_ERR "cryptoloop: unsupported cipher mode in cryptoloop_trans=
fer!\n");
+	return -EINVAL;
+}
=20
 static int
 cryptoloop_ioctl(struct loop_device *lo, int cmd, unsigned long arg)

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop-2.6t2.diff"
Content-Transfer-Encoding: quoted-printable

--- drivers/block/loop.c~	Sun Jul 27 19:03:16 2003
+++ drivers/block/loop.c	Sun Aug 10 04:22:44 2003
@@ -513,6 +513,7 @@
 					from_bvec->bv_len, IV);
 		kunmap(from_bvec->bv_page);
 		kunmap(to_bvec->bv_page);
+		IV +=3D from_bvec->bv_len >> 9;
 	}
=20
 	return ret;

--PEIAKu/WMn1b1Hv9--

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/O4APW7sr9DEJLk4RAnhLAKCNW0isb21MTx058N5M5SICCbv0GwCcCGnY
/OzrMzoyT6EGsdFqTL5zwSM=
=ZGp1
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
