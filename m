Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272338AbTHIMFf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 08:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272336AbTHIMFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 08:05:35 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:36737
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id S272338AbTHIMF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 08:05:28 -0400
Date: Sat, 9 Aug 2003 14:05:28 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cryptoloop: Fixing ECB Mode
Message-ID: <20030809120528.GA13541@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1061294728.19ea@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

When cit_en/decrypt_iv has been introduced for cryptoapi,
cryptoloop_transfer has been changed unintentionally from a generic version
for ECB/CBC to CBC-specific code. This patch fixes this mistake.

Regards, Clemens

--7JfCtLOvnd9MIVvH
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

--7JfCtLOvnd9MIVvH--

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/NOOIW7sr9DEJLk4RAlHaAJ99HgThLjR9lfQ0RlUrgSqTxj0JLQCfXGM1
TvSLJL1QODhKWsz/WltgZRM=
=VLMw
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
