Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUIAIeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUIAIeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 04:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUIAIeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 04:34:37 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:60164 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S263962AbUIAI2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 04:28:32 -0400
Date: Wed, 1 Sep 2004 10:28:19 +0200
From: Andreas Happe <andreashappe@flatline.ath.cx>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz
Subject: [cryptoapi/sysfs] display cipher details in sysfs
Message-ID: <20040901082819.GA2489@final-judgement.ath.cx>
References: <20040831175449.GA2946@final-judgement.ath.cx> <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com>
X-Request-PGP: subkeys.pgp.net
X-Hangover: none
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

following-up to: James Morris <jmorris@redhat.com> [040901 09:35]:
>This looks potentially useful, although I'm not sure yet whether the=20
>userland crypto API should be exposed via sysfs or a separate filesystem.
>
>I suggest you post the patch to linux-kernel and the crypto API list at:
>http://lists.logix.cz/pipermail/cryptoapi  as an RFC, for wider feedback.

the attached patch creates a /sys/cryptoapi/<cipher-name>/ hierarchie
which includes all information which is currently offered by
/proc/crypto. This was done by embedding a kobject in struct crypto_alg
(include/linux/crypto.h) and using a kset/subsystem instead of the
currently used list (crypto_alg->cra_list was removed, as it shouldn't
be needed anymore). crypto/proc.c was converted to use the subsystem
internal rwlock/list for its iteration of ciphers.

I think that the place for the cryptoapi-tree in sysfs is wrong (but the
others (block, module, bus, class, etc.) seemed worse). But the effort
to change this should be neglectable (and centered at syfs.c).

Also the different cipher types (digest, compress..) could be seperated
into own ksets/directories, but this would make the crypto/proc.c code
worse.

small example:
| bash-2.05b# cd /sys/cryptoapi/
| bash-2.05b# ls
| aes  blowfish  cipher_null  compress_null  deflate  des  des3_ede
| digest_null  md5  serpent  sha1  sha256  twofish
| bash-2.05b# cd aes/
| bash-2.05b# ls
| blocksize  maxkeysize  minkeysize  module  name  type
| bash-2.05b# cat blocksize=20
| 16
| bash-2.05b# cd ./../sha1/
| bash-2.05b# ls
| digestsize  module  name  type
| bash-2.05b# cat digestsize=20
| 20
| bash-2.05b# cat type=20
| digest

	--Andreas

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.9-rc1-cryptoapi-sysfs"
Content-Transfer-Encoding: quoted-printable

diff -u -N -r linux-2.6.9-rc1/arch/i386/crypto/aes.c linux-2.6.9-rc1-sys2/a=
rch/i386/crypto/aes.c
--- linux-2.6.9-rc1/arch/i386/crypto/aes.c	2004-08-28 15:33:41.000000000 +0=
200
+++ linux-2.6.9-rc1-sys2/arch/i386/crypto/aes.c	2004-08-31 22:50:01.0000000=
00 +0200
@@ -488,7 +488,6 @@
 	.cra_blocksize		=3D	AES_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct aes_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(aes_alg.cra_list),
 	.cra_u			=3D	{
 		.cipher =3D {
 			.cia_min_keysize	=3D	AES_MIN_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/aes.c linux-2.6.9-rc1-sys2/crypto/aes.c
--- linux-2.6.9-rc1/crypto/aes.c	2004-08-28 16:20:48.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/aes.c	2004-08-31 22:29:06.000000000 +0200
@@ -437,7 +437,6 @@
 	.cra_blocksize		=3D	AES_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct aes_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(aes_alg.cra_list),
 	.cra_u			=3D	{
 		.cipher =3D {
 			.cia_min_keysize	=3D	AES_MIN_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/api.c linux-2.6.9-rc1-sys2/crypto/api.c
--- linux-2.6.9-rc1/crypto/api.c	2004-06-16 07:20:04.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/api.c	2004-08-31 22:21:01.000000000 +0200
@@ -18,40 +18,58 @@
 #include <linux/errno.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
+#include <linux/kernel.h>
 #include "internal.h"
=20
-LIST_HEAD(crypto_alg_list);
-DECLARE_RWSEM(crypto_alg_sem);
+#ifdef CONFIG_SYSFS
+extern struct sysfs_ops cryptoapi_ops;
+extern struct attribute cryptoapi_attr_blocksize;
+extern struct attribute cryptoapi_attr_digestsize;
+extern struct attribute cryptoapi_attr_minkeysize;
+extern struct attribute cryptoapi_attr_maxkeysize;
+extern struct attribute *cryptoapi_attributes[];
+
+extern ssize_t cryptoapi_show(struct kobject *kobj, struct attribute *attr=
, char *buffer);
+#endif
+void cryptoapi_release(struct kobject *kobj);
+
+static struct kobj_type cryptoapi_type =3D {
+	.release   =3D cryptoapi_release,
+#ifdef CONFIG_SYSFS
+	.sysfs_ops =3D &cryptoapi_ops,
+	.default_attrs =3D cryptoapi_attributes
+#endif
+};
+
+decl_subsys(cryptoapi, &cryptoapi_type, NULL);
+
+void cryptoapi_release(struct kobject *kobj) {}
=20
 static inline int crypto_alg_get(struct crypto_alg *alg)
 {
+	kobject_get(&(alg->cra_obj));
 	return try_module_get(alg->cra_module);
 }
=20
 static inline void crypto_alg_put(struct crypto_alg *alg)
 {
+	kobject_put(&(alg->cra_obj));
 	module_put(alg->cra_module);
 }
=20
 struct crypto_alg *crypto_alg_lookup(const char *name)
 {
-	struct crypto_alg *q, *alg =3D NULL;
-
-	if (!name)
-		return NULL;
-=09
-	down_read(&crypto_alg_sem);
+	struct kobject *obj=3DNULL;
+	struct crypto_alg *result=3DNULL;
 =09
-	list_for_each_entry(q, &crypto_alg_list, cra_list) {
-		if (!(strcmp(q->cra_name, name))) {
-			if (crypto_alg_get(q))
-				alg =3D q;
-			break;
-		}
+	obj =3D kset_find_obj(&(cryptoapi_subsys.kset), name);
+
+	if(obj) {
+		result =3D container_of(obj, struct crypto_alg, cra_obj);
+		if(result)
+			result =3D (crypto_alg_get(result))?result:NULL;
 	}
-=09
-	up_read(&crypto_alg_sem);
-	return alg;
+	return result;
 }
=20
 static int crypto_init_flags(struct crypto_tfm *tfm, u32 flags)
@@ -163,40 +181,38 @@
 int crypto_register_alg(struct crypto_alg *alg)
 {
 	int ret =3D 0;
-	struct crypto_alg *q;
-=09
-	down_write(&crypto_alg_sem);
 =09
-	list_for_each_entry(q, &crypto_alg_list, cra_list) {
-		if (!(strcmp(q->cra_name, alg->cra_name))) {
-			ret =3D -EEXIST;
-			goto out;
+	if(kset_find_obj(&(cryptoapi_subsys.kset), alg->cra_name)) {
+		ret =3D -EEXIST;
+	} else {
+		kobject_init(&(alg->cra_obj));
+		BUG_ON(kobject_set_name(&(alg->cra_obj), alg->cra_name));
+		alg->cra_obj.kset =3D &cryptoapi_subsys.kset;
+		BUG_ON(kobject_add(&(alg->cra_obj)));
+#ifdef CONFIG_SYSFS
+		switch(alg->cra_flags & CRYPTO_ALG_TYPE_MASK) {
+		case CRYPTO_ALG_TYPE_CIPHER:
+			WARN_ON(sysfs_create_file(&(alg->cra_obj), &cryptoapi_attr_blocksize));
+			WARN_ON(sysfs_create_file(&(alg->cra_obj), &cryptoapi_attr_minkeysize));
+			WARN_ON(sysfs_create_file(&(alg->cra_obj), &cryptoapi_attr_maxkeysize));
+		break;
+		case CRYPTO_ALG_TYPE_DIGEST:
+			WARN_ON(sysfs_create_file(&(alg->cra_obj), &cryptoapi_attr_digestsize));
+		break;
 		}
+#endif
 	}
-=09
-	list_add_tail(&alg->cra_list, &crypto_alg_list);
-out:=09
-	up_write(&crypto_alg_sem);
 	return ret;
 }
=20
 int crypto_unregister_alg(struct crypto_alg *alg)
 {
 	int ret =3D -ENOENT;
-	struct crypto_alg *q;
-=09
-	BUG_ON(!alg->cra_module);
-=09
-	down_write(&crypto_alg_sem);
-	list_for_each_entry(q, &crypto_alg_list, cra_list) {
-		if (alg =3D=3D q) {
-			list_del(&alg->cra_list);
-			ret =3D 0;
-			goto out;
-		}
+
+	if(kset_find_obj(&(cryptoapi_subsys.kset), alg->cra_name)) {
+		kobject_unregister(&(alg->cra_obj));
+		ret =3D 0;
 	}
-out:=09
-	up_write(&crypto_alg_sem);
 	return ret;
 }
=20
@@ -216,6 +232,7 @@
 static int __init init_crypto(void)
 {
 	printk(KERN_INFO "Initializing Cryptographic API\n");
+	subsystem_register(&cryptoapi_subsys);
 	crypto_init_proc();
 	return 0;
 }
diff -u -N -r linux-2.6.9-rc1/crypto/arc4.c linux-2.6.9-rc1-sys2/crypto/arc=
4.c
--- linux-2.6.9-rc1/crypto/arc4.c	2004-08-28 16:20:48.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/arc4.c	2004-08-31 22:29:13.000000000 +0200
@@ -75,7 +75,6 @@
 	.cra_blocksize		=3D	ARC4_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct arc4_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(arc4_alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	ARC4_MIN_KEY_SIZE,
 	.cia_max_keysize	=3D	ARC4_MAX_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/blowfish.c linux-2.6.9-rc1-sys2/crypto=
/blowfish.c
--- linux-2.6.9-rc1/crypto/blowfish.c	2004-08-28 16:20:48.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/blowfish.c	2004-08-31 22:29:19.000000000 +0=
200
@@ -452,7 +452,6 @@
 	.cra_blocksize		=3D	BF_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct bf_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	BF_MIN_KEY_SIZE,
 	.cia_max_keysize	=3D	BF_MAX_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/cast5.c linux-2.6.9-rc1-sys2/crypto/ca=
st5.c
--- linux-2.6.9-rc1/crypto/cast5.c	2004-06-16 07:19:29.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/cast5.c	2004-08-31 22:29:27.000000000 +0200
@@ -821,7 +821,6 @@
 	.cra_blocksize 	=3D CAST5_BLOCK_SIZE,
 	.cra_ctxsize 	=3D sizeof(struct cast5_ctx),
 	.cra_module 	=3D THIS_MODULE,
-	.cra_list 	=3D LIST_HEAD_INIT(alg.cra_list),
 	.cra_u 		=3D {
 		.cipher =3D {
 			.cia_min_keysize =3D CAST5_MIN_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/cast6.c linux-2.6.9-rc1-sys2/crypto/ca=
st6.c
--- linux-2.6.9-rc1/crypto/cast6.c	2004-06-16 07:19:01.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/cast6.c	2004-08-31 22:29:37.000000000 +0200
@@ -534,7 +534,6 @@
 	.cra_blocksize =3D CAST6_BLOCK_SIZE,
 	.cra_ctxsize =3D sizeof(struct cast6_ctx),
 	.cra_module =3D THIS_MODULE,
-	.cra_list =3D LIST_HEAD_INIT(alg.cra_list),
 	.cra_u =3D {
 		  .cipher =3D {
 			     .cia_min_keysize =3D CAST6_MIN_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/crc32c.c linux-2.6.9-rc1-sys2/crypto/c=
rc32c.c
--- linux-2.6.9-rc1/crypto/crc32c.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/crc32c.c	2004-08-31 22:29:46.000000000 +0200
@@ -80,7 +80,6 @@
 	.cra_blocksize	=3D	CHKSUM_BLOCK_SIZE,
 	.cra_ctxsize	=3D	sizeof(struct chksum_ctx),
 	.cra_module	=3D	THIS_MODULE,
-	.cra_list	=3D	LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=3D	{
 		.digest =3D {
 			 .dia_digestsize=3D	CHKSUM_DIGEST_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/crypto_null.c linux-2.6.9-rc1-sys2/cry=
pto/crypto_null.c
--- linux-2.6.9-rc1/crypto/crypto_null.c	2004-06-16 07:19:22.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/crypto_null.c	2004-08-31 22:29:59.000000000=
 +0200
@@ -59,7 +59,6 @@
 	.cra_blocksize		=3D	NULL_BLOCK_SIZE,
 	.cra_ctxsize		=3D	0,
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D       LIST_HEAD_INIT(compress_null.cra_list),
 	.cra_u			=3D	{ .compress =3D {
 	.coa_compress 		=3D	null_compress,
 	.coa_decompress		=3D	null_decompress } }
@@ -71,7 +70,6 @@
 	.cra_blocksize		=3D	NULL_BLOCK_SIZE,
 	.cra_ctxsize		=3D	0,
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D       LIST_HEAD_INIT(digest_null.cra_list),=09
 	.cra_u			=3D	{ .digest =3D {
 	.dia_digestsize		=3D	NULL_DIGEST_SIZE,
 	.dia_init   		=3D	null_init,
@@ -85,7 +83,6 @@
 	.cra_blocksize		=3D	NULL_BLOCK_SIZE,
 	.cra_ctxsize		=3D	0,
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(cipher_null.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	NULL_KEY_SIZE,
 	.cia_max_keysize	=3D	NULL_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/deflate.c linux-2.6.9-rc1-sys2/crypto/=
deflate.c
--- linux-2.6.9-rc1/crypto/deflate.c	2004-08-28 15:33:46.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/deflate.c	2004-08-31 22:30:04.000000000 +02=
00
@@ -196,7 +196,6 @@
 	.cra_flags		=3D CRYPTO_ALG_TYPE_COMPRESS,
 	.cra_ctxsize		=3D sizeof(struct deflate_ctx),
 	.cra_module		=3D THIS_MODULE,
-	.cra_list		=3D LIST_HEAD_INIT(alg.cra_list),
 	.cra_u			=3D { .compress =3D {
 	.coa_init		=3D deflate_init,
 	.coa_exit		=3D deflate_exit,
diff -u -N -r linux-2.6.9-rc1/crypto/des.c linux-2.6.9-rc1-sys2/crypto/des.c
--- linux-2.6.9-rc1/crypto/des.c	2004-06-16 07:20:20.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/des.c	2004-08-31 22:30:16.000000000 +0200
@@ -1245,7 +1245,6 @@
 	.cra_blocksize		=3D	DES_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct des_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(des_alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	DES_KEY_SIZE,
 	.cia_max_keysize	=3D	DES_KEY_SIZE,
@@ -1260,7 +1259,6 @@
 	.cra_blocksize		=3D	DES3_EDE_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct des3_ede_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(des3_ede_alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	DES3_EDE_KEY_SIZE,
 	.cia_max_keysize	=3D	DES3_EDE_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/khazad.c linux-2.6.9-rc1-sys2/crypto/k=
hazad.c
--- linux-2.6.9-rc1/crypto/khazad.c	2004-08-28 15:33:46.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/khazad.c	2004-08-31 22:30:22.000000000 +0200
@@ -885,7 +885,6 @@
 	.cra_blocksize		=3D	KHAZAD_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof (struct khazad_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(khazad_alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	KHAZAD_KEY_SIZE,
 	.cia_max_keysize	=3D	KHAZAD_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/Makefile linux-2.6.9-rc1-sys2/crypto/M=
akefile
--- linux-2.6.9-rc1/crypto/Makefile	2004-08-28 15:33:46.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/Makefile	2004-08-31 22:21:01.000000000 +0200
@@ -3,9 +3,10 @@
 #
=20
 proc-crypto-$(CONFIG_PROC_FS) =3D proc.o
+sysfs-crypto-$(CONFIG_SYSFS) =3D sysfs.o
=20
 obj-$(CONFIG_CRYPTO) +=3D api.o scatterwalk.o cipher.o digest.o compress.o=
 \
-			$(proc-crypto-y)
+			$(proc-crypto-y) $(sysfs-crypto-y)
=20
 obj-$(CONFIG_CRYPTO_HMAC) +=3D hmac.o
 obj-$(CONFIG_CRYPTO_NULL) +=3D crypto_null.o
diff -u -N -r linux-2.6.9-rc1/crypto/md4.c linux-2.6.9-rc1-sys2/crypto/md4.c
--- linux-2.6.9-rc1/crypto/md4.c	2004-06-16 07:19:26.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/md4.c	2004-08-31 22:30:28.000000000 +0200
@@ -224,7 +224,6 @@
 	.cra_blocksize	=3D	MD4_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=3D	sizeof(struct md4_ctx),
 	.cra_module	=3D	THIS_MODULE,
-	.cra_list       =3D       LIST_HEAD_INIT(alg.cra_list),=09
 	.cra_u		=3D	{ .digest =3D {
 	.dia_digestsize	=3D	MD4_DIGEST_SIZE,
 	.dia_init   	=3D 	md4_init,
diff -u -N -r linux-2.6.9-rc1/crypto/md5.c linux-2.6.9-rc1-sys2/crypto/md5.c
--- linux-2.6.9-rc1/crypto/md5.c	2004-06-16 07:19:22.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/md5.c	2004-08-31 22:30:34.000000000 +0200
@@ -219,7 +219,6 @@
 	.cra_blocksize	=3D	MD5_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=3D	sizeof(struct md5_ctx),
 	.cra_module	=3D	THIS_MODULE,
-	.cra_list	=3D	LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=3D	{ .digest =3D {
 	.dia_digestsize	=3D	MD5_DIGEST_SIZE,
 	.dia_init   	=3D 	md5_init,
diff -u -N -r linux-2.6.9-rc1/crypto/michael_mic.c linux-2.6.9-rc1-sys2/cry=
pto/michael_mic.c
--- linux-2.6.9-rc1/crypto/michael_mic.c	2004-06-16 07:19:37.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/michael_mic.c	2004-08-31 22:30:39.000000000=
 +0200
@@ -163,7 +163,6 @@
 	.cra_blocksize	=3D 8,
 	.cra_ctxsize	=3D sizeof(struct michael_mic_ctx),
 	.cra_module	=3D THIS_MODULE,
-	.cra_list	=3D LIST_HEAD_INIT(michael_mic_alg.cra_list),
 	.cra_u		=3D { .digest =3D {
 	.dia_digestsize	=3D 8,
 	.dia_init	=3D michael_init,
diff -u -N -r linux-2.6.9-rc1/crypto/proc.c linux-2.6.9-rc1-sys2/crypto/pro=
c.c
--- linux-2.6.9-rc1/crypto/proc.c	2004-06-16 07:19:03.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/proc.c	2004-08-31 22:21:01.000000000 +0200
@@ -18,40 +18,39 @@
 #include <linux/seq_file.h>
 #include "internal.h"
=20
-extern struct list_head crypto_alg_list;
-extern struct rw_semaphore crypto_alg_sem;
+extern struct subsystem cryptoapi_subsys;
=20
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
 	struct list_head *v;
 	loff_t n =3D *pos;
=20
-	down_read(&crypto_alg_sem);
-	list_for_each(v, &crypto_alg_list)
+	down_read(&cryptoapi_subsys.rwsem);
+	list_for_each(v, &cryptoapi_subsys.kset.list)
 		if (!n--)
-			return list_entry(v, struct crypto_alg, cra_list);
+			return list_entry(v, struct kobject, entry);
 	return NULL;
 }
=20
 static void *c_next(struct seq_file *m, void *p, loff_t *pos)
 {
-	struct list_head *v =3D p;
-=09
+	struct list_head *e =3D &(((struct kobject*)p)->entry);
+
 	(*pos)++;
-	v =3D v->next;
-	return (v =3D=3D &crypto_alg_list) ?
-		NULL : list_entry(v, struct crypto_alg, cra_list);
+	e =3D e->next;
+	return (e =3D=3D &cryptoapi_subsys.kset.list) ?
+		NULL : list_entry(e, struct kobject, entry);
 }
=20
 static void c_stop(struct seq_file *m, void *p)
 {
-	up_read(&crypto_alg_sem);
+	up_read(&cryptoapi_subsys.rwsem);
 }
=20
 static int c_show(struct seq_file *m, void *p)
 {
-	struct crypto_alg *alg =3D (struct crypto_alg *)p;
-=09
+	struct crypto_alg *alg =3D container_of(p, struct crypto_alg, cra_obj);
+
 	seq_printf(m, "name         : %s\n", alg->cra_name);
 	seq_printf(m, "module       : %s\n", module_name(alg->cra_module));
 =09
diff -u -N -r linux-2.6.9-rc1/crypto/serpent.c linux-2.6.9-rc1-sys2/crypto/=
serpent.c
--- linux-2.6.9-rc1/crypto/serpent.c	2004-06-16 07:19:09.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/serpent.c	2004-08-31 22:30:46.000000000 +02=
00
@@ -479,7 +479,6 @@
 	.cra_blocksize		=3D	SERPENT_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct serpent_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(serpent_alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	SERPENT_MIN_KEY_SIZE,
 	.cia_max_keysize	=3D	SERPENT_MAX_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/sha1.c linux-2.6.9-rc1-sys2/crypto/sha=
1.c
--- linux-2.6.9-rc1/crypto/sha1.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/sha1.c	2004-08-31 22:30:52.000000000 +0200
@@ -183,7 +183,6 @@
 	.cra_blocksize	=3D	SHA1_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=3D	sizeof(struct sha1_ctx),
 	.cra_module	=3D	THIS_MODULE,
-	.cra_list       =3D       LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=3D	{ .digest =3D {
 	.dia_digestsize	=3D	SHA1_DIGEST_SIZE,
 	.dia_init   	=3D 	sha1_init,
diff -u -N -r linux-2.6.9-rc1/crypto/sha256.c linux-2.6.9-rc1-sys2/crypto/s=
ha256.c
--- linux-2.6.9-rc1/crypto/sha256.c	2004-06-16 07:19:13.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/sha256.c	2004-08-31 22:31:11.000000000 +0200
@@ -337,7 +337,6 @@
 	.cra_blocksize	=3D	SHA256_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=3D	sizeof(struct sha256_ctx),
 	.cra_module	=3D	THIS_MODULE,
-	.cra_list       =3D       LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=3D	{ .digest =3D {
 	.dia_digestsize	=3D	SHA256_DIGEST_SIZE,
 	.dia_init   	=3D 	sha256_init,
diff -u -N -r linux-2.6.9-rc1/crypto/sha512.c linux-2.6.9-rc1-sys2/crypto/s=
ha512.c
--- linux-2.6.9-rc1/crypto/sha512.c	2004-06-16 07:20:04.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/sha512.c	2004-08-31 22:31:00.000000000 +0200
@@ -324,7 +324,6 @@
         .cra_blocksize  =3D SHA512_HMAC_BLOCK_SIZE,
         .cra_ctxsize    =3D sizeof(struct sha512_ctx),
         .cra_module     =3D THIS_MODULE,
-        .cra_list       =3D LIST_HEAD_INIT(sha512.cra_list),
         .cra_u          =3D { .digest =3D {
                                 .dia_digestsize =3D SHA512_DIGEST_SIZE,
                                 .dia_init       =3D sha512_init,
@@ -339,7 +338,6 @@
         .cra_blocksize  =3D SHA384_HMAC_BLOCK_SIZE,
         .cra_ctxsize    =3D sizeof(struct sha512_ctx),
         .cra_module     =3D THIS_MODULE,
-        .cra_list       =3D LIST_HEAD_INIT(sha384.cra_list),
         .cra_u          =3D { .digest =3D {
                                 .dia_digestsize =3D SHA384_DIGEST_SIZE,
                                 .dia_init       =3D sha384_init,
diff -u -N -r linux-2.6.9-rc1/crypto/sysfs.c linux-2.6.9-rc1-sys2/crypto/sy=
sfs.c
--- linux-2.6.9-rc1/crypto/sysfs.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc1-sys2/crypto/sysfs.c	2004-08-31 22:21:01.000000000 +0200
@@ -0,0 +1,95 @@
+#include <linux/init.h>
+#include <linux/crypto.h>
+#include <linux/errno.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include "internal.h"
+
+struct cryptoapi_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct crypto_alg *, char *);
+};
+
+static ssize_t cryptoapi_show(struct kobject *kobj, struct attribute *attr=
, char *buffer);
+
+static ssize_t cryptoapi_show_name(struct crypto_alg *tmp, char *buffer);
+static ssize_t cryptoapi_show_blocksize(struct crypto_alg *tmp, char *buff=
er);
+static ssize_t cryptoapi_show_digestsize(struct crypto_alg *tmp, char *buf=
fer);
+static ssize_t cryptoapi_show_type(struct crypto_alg *tmp, char *buffer);
+static ssize_t cryptoapi_show_module(struct crypto_alg *tmp, char *buffer);
+static ssize_t cryptoapi_show_maxkeysize(struct crypto_alg *tmp, char *buf=
fer);
+static ssize_t cryptoapi_show_minkeysize(struct crypto_alg *tmp, char *buf=
fer);
+
+struct sysfs_ops cryptoapi_ops =3D {
+	.show =3D cryptoapi_show,
+	.store =3D NULL,
+};
+
+#define to_cryptoapi_attribute(X) container_of(X, struct cryptoapi_attribu=
te, attr)
+#define cryptoapi_attribute(X, Y) { .attr =3D {__stringify(X), NULL, 0444}=
, .show =3D Y }
+
+struct cryptoapi_attribute cryptoapi_attr_blocksize =3D cryptoapi_attribut=
e(blocksize, cryptoapi_show_blocksize);
+struct cryptoapi_attribute cryptoapi_attr_digestsize =3D cryptoapi_attribu=
te(digestsize, cryptoapi_show_digestsize);
+struct cryptoapi_attribute cryptoapi_attr_minkeysize =3D cryptoapi_attribu=
te(minkeysize, cryptoapi_show_minkeysize);
+struct cryptoapi_attribute cryptoapi_attr_maxkeysize =3D cryptoapi_attribu=
te(maxkeysize, cryptoapi_show_maxkeysize);
+struct cryptoapi_attribute cryptoapi_attr_name =3D cryptoapi_attribute(nam=
e, cryptoapi_show_name);
+struct cryptoapi_attribute cryptoapi_attr_module =3D cryptoapi_attribute(m=
odule, cryptoapi_show_module);
+struct cryptoapi_attribute cryptoapi_attr_type =3D cryptoapi_attribute(typ=
e, cryptoapi_show_type);
+
+struct attribute *cryptoapi_attributes[] =3D {
+	&cryptoapi_attr_name.attr,
+	&cryptoapi_attr_type.attr,
+	&cryptoapi_attr_module.attr,
+	NULL,
+};
+
+static ssize_t cryptoapi_show_blocksize(struct crypto_alg *tmp, char *buff=
er) {
+	return (snprintf(buffer, PAGE_SIZE, "%u\n", tmp->cra_blocksize)+1)*sizeof=
(char);
+}
+
+static ssize_t cryptoapi_show_digestsize(struct crypto_alg *tmp, char *buf=
fer) {
+	return (snprintf(buffer, PAGE_SIZE, "%u\n", tmp->cra_digest.dia_digestsiz=
e)+1)*sizeof(char);
+}
+
+static ssize_t cryptoapi_show_minkeysize(struct crypto_alg *tmp, char *buf=
fer) {
+	return (snprintf(buffer, PAGE_SIZE, "%u\n", tmp->cra_cipher.cia_min_keysi=
ze)+1)*sizeof(char);
+}
+
+static ssize_t cryptoapi_show_maxkeysize(struct crypto_alg *tmp, char *buf=
fer) {
+	return (snprintf(buffer, PAGE_SIZE, "%u\n", tmp->cra_cipher.cia_max_keysi=
ze)+1)*sizeof(char);
+}
+
+static ssize_t cryptoapi_show_name(struct crypto_alg *tmp, char *buffer) {
+	return (snprintf(buffer, PAGE_SIZE, "%s\n", tmp->cra_name)+1)*sizeof(char=
);
+}
+
+static ssize_t cryptoapi_show_module(struct crypto_alg *tmp, char *buffer)=
 {
+	return (snprintf(buffer, PAGE_SIZE, "%s\n", module_name(tmp->cra_module))=
+1)*sizeof(char);
+}
+
+static ssize_t cryptoapi_show_type(struct crypto_alg *tmp, char *buffer) {
+	switch(tmp->cra_flags & CRYPTO_ALG_TYPE_MASK) {
+	case CRYPTO_ALG_TYPE_CIPHER:
+		strncpy(buffer, "cipher\n", PAGE_SIZE);
+		break;
+	case CRYPTO_ALG_TYPE_DIGEST:
+		strncpy(buffer, "digest\n", PAGE_SIZE);
+		break;
+	case CRYPTO_ALG_TYPE_COMPRESS:
+		strncpy(buffer, "compression\n", PAGE_SIZE);
+		break;
+	default:
+		strncpy(buffer, "unknown\n", PAGE_SIZE);
+	}
+	return (strlen(buffer)+1)*sizeof(char);
+}
+
+static ssize_t cryptoapi_show(struct kobject *kobj, struct attribute *attr,
+		char *buffer) {
+	struct cryptoapi_attribute *ca_attr =3D to_cryptoapi_attribute(attr);
+
+	if(ca_attr->show)
+		return ca_attr->show(container_of(kobj, struct crypto_alg, cra_obj), buf=
fer);
+	return 0;
+}
diff -u -N -r linux-2.6.9-rc1/crypto/tea.c linux-2.6.9-rc1-sys2/crypto/tea.c
--- linux-2.6.9-rc1/crypto/tea.c	2004-08-28 15:33:46.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/tea.c	2004-08-31 22:31:23.000000000 +0200
@@ -191,7 +191,6 @@
 	.cra_blocksize		=3D	TEA_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof (struct tea_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(tea_alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	TEA_KEY_SIZE,
 	.cia_max_keysize	=3D	TEA_KEY_SIZE,
@@ -206,7 +205,6 @@
 	.cra_blocksize		=3D	XTEA_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof (struct xtea_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(xtea_alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	XTEA_KEY_SIZE,
 	.cia_max_keysize	=3D	XTEA_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/twofish.c linux-2.6.9-rc1-sys2/crypto/=
twofish.c
--- linux-2.6.9-rc1/crypto/twofish.c	2004-08-28 16:20:48.000000000 +0200
+++ linux-2.6.9-rc1-sys2/crypto/twofish.c	2004-08-31 22:31:32.000000000 +02=
00
@@ -876,7 +876,6 @@
 	.cra_blocksize      =3D   TF_BLOCK_SIZE,
 	.cra_ctxsize        =3D   sizeof(struct twofish_ctx),
 	.cra_module         =3D   THIS_MODULE,
-	.cra_list           =3D   LIST_HEAD_INIT(alg.cra_list),
 	.cra_u              =3D   { .cipher =3D {
 	.cia_min_keysize    =3D   TF_MIN_KEY_SIZE,
 	.cia_max_keysize    =3D   TF_MAX_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/include/linux/crypto.h linux-2.6.9-rc1-sys2/i=
nclude/linux/crypto.h
--- linux-2.6.9-rc1/include/linux/crypto.h	2004-06-16 07:19:03.000000000 +0=
200
+++ linux-2.6.9-rc1-sys2/include/linux/crypto.h	2004-08-31 22:31:49.0000000=
00 +0200
@@ -94,7 +94,7 @@
 #define cra_compress	cra_u.compress
=20
 struct crypto_alg {
-	struct list_head cra_list;
+	struct kobject cra_obj;
 	u32 cra_flags;
 	unsigned int cra_blocksize;
 	unsigned int cra_ctxsize;

--SLDf9lqlvOQaIe6s--

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBNYgjo1Xfh1pGf9oRAqJ1AJ9/1QPCmoUVUVOnEf0C2vwqcTJ8yACeIvoz
Y0isDG4UpYxJhTQe2yx7Qkc=
=rr2G
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
