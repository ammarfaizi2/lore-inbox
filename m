Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268347AbUIKWc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268347AbUIKWc0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 18:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268355AbUIKWbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 18:31:47 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:26378 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S268347AbUIKW2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 18:28:51 -0400
Date: Fri, 10 Sep 2004 12:55:02 +0200
From: Andreas Happe <andreashappe@flatline.ath.cx>
To: Michal Ludvig <michal@logix.cz>
Cc: Andreas Happe <crow@old-fsckful.ath.cx>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, James Morris <jmorris@redhat.com>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
Message-ID: <20040910105502.GA4663@final-judgement.ath.cx>
References: <20040831175449.GA2946@final-judgement.ath.cx> <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com> <20040901082819.GA2489@final-judgement.ath.cx> <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz> <20040907143509.GA30920@old-fsckful.ath.cx> <Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz>
X-Request-PGP: subkeys.pgp.net
X-Hangover: none
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Michal Ludvig <michal@logix.cz> [040910 12:44]:
>On Tue, 7 Sep 2004, Andreas Happe wrote:
>
>> On Mon, Sep 06, 2004 at 08:49:30PM +0200, Michal Ludvig wrote:
>> > On Wed, 1 Sep 2004, Andreas Happe wrote:
>> > > the attached patch creates a /sys/cryptoapi/<cipher-name>/ hierarchie
>>
>> BTW: the latest incarnation of the patch uses /sys/class/crypto/<cipher-name>.
>
>Where can I get the updated version?

it is attached. The changes to api.c are very small (it just uses the
class_device linked list instead of cra_list).

The only 'drawback' compared to the subsystem - based patch is that I've
got to traverse the list by hand and not by something like
"kset_find_obj".

	--Andreas

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.9-rc1-cryptoapi-sysfs-class-2"
Content-Transfer-Encoding: quoted-printable

diff -u -N -r linux-2.6.9-rc1/arch/i386/crypto/aes.c linux-2.6.9-rc1-class/=
arch/i386/crypto/aes.c
--- linux-2.6.9-rc1/arch/i386/crypto/aes.c	2004-08-28 15:33:41.000000000 +0=
200
+++ linux-2.6.9-rc1-class/arch/i386/crypto/aes.c	2004-09-06 14:49:20.000000=
000 +0200
@@ -488,7 +488,6 @@
 	.cra_blocksize		=3D	AES_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct aes_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(aes_alg.cra_list),
 	.cra_u			=3D	{
 		.cipher =3D {
 			.cia_min_keysize	=3D	AES_MIN_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/aes.c linux-2.6.9-rc1-class/crypto/aes=
=2Ec
--- linux-2.6.9-rc1/crypto/aes.c	2004-08-28 16:20:48.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/aes.c	2004-09-06 14:49:35.000000000 +0200
@@ -437,7 +437,6 @@
 	.cra_blocksize		=3D	AES_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct aes_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(aes_alg.cra_list),
 	.cra_u			=3D	{
 		.cipher =3D {
 			.cia_min_keysize	=3D	AES_MIN_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/api.c linux-2.6.9-rc1-class/crypto/api=
=2Ec
--- linux-2.6.9-rc1/crypto/api.c	2004-09-06 16:30:33.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/api.c	2004-09-06 23:35:59.000000000 +0200
@@ -18,10 +18,21 @@
 #include <linux/errno.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
+#include <linux/device.h>
 #include "internal.h"
=20
-LIST_HEAD(crypto_alg_list);
 DECLARE_RWSEM(crypto_alg_sem);
+extern struct class cryptoapi_class;
+
+#ifdef CONFIG_SYSFS
+extern struct class_device_attribute class_device_attr_name;
+extern struct class_device_attribute class_device_attr_module;
+extern struct class_device_attribute class_device_attr_type;
+extern struct class_device_attribute class_device_attr_blocksize;
+extern struct class_device_attribute class_device_attr_digestsize;
+extern struct class_device_attribute class_device_attr_minkeysize;
+extern struct class_device_attribute class_device_attr_maxkeysize;
+#endif
=20
 static inline int crypto_alg_get(struct crypto_alg *alg)
 {
@@ -36,14 +47,16 @@
 struct crypto_alg *crypto_alg_lookup(const char *name)
 {
 	struct crypto_alg *q, *alg =3D NULL;
+	struct class_device *dev;
=20
 	if (!name)
 		return NULL;
 =09
 	down_read(&crypto_alg_sem);
 =09
-	list_for_each_entry(q, &crypto_alg_list, cra_list) {
-		if (!(strcmp(q->cra_name, name))) {
+	list_for_each_entry(dev, &(cryptoapi_class.children), node) {
+		if (!(strcmp(dev->class_id, name))) {
+			q =3D (struct crypto_alg *)class_get_devdata(dev);
 			if (crypto_alg_get(q))
 				alg =3D q;
 			break;
@@ -163,19 +176,47 @@
 int crypto_register_alg(struct crypto_alg *alg)
 {
 	int ret =3D 0;
-	struct crypto_alg *q;
+	struct class_device *dev;
 =09
 	down_write(&crypto_alg_sem);
 =09
-	list_for_each_entry(q, &crypto_alg_list, cra_list) {
-		if (!(strcmp(q->cra_name, alg->cra_name))) {
+	list_for_each_entry(dev, &(cryptoapi_class.children), node) {
+		if (!(strcmp(dev->class_id, alg->cra_name))) {
 			ret =3D -EEXIST;
 			goto out;
 		}
 	}
 =09
-	list_add_tail(&alg->cra_list, &crypto_alg_list);
-out:=09
+	dev =3D (struct class_device*)kmalloc(sizeof(struct class_device), GFP_KE=
RNEL);
+	if(!dev) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+=09
+	memset(dev, 0, sizeof(*dev));
+	dev->class =3D &cryptoapi_class;
+	dev->dev   =3D NULL;
+	strncpy(dev->class_id, alg->cra_name, BUS_ID_SIZE);
+	class_device_register(dev);
+
+#ifdef CONFIG_SYSFS
+	class_set_devdata(dev, alg);
+	WARN_ON(class_device_create_file(dev, &class_device_attr_name));
+	WARN_ON(class_device_create_file(dev, &class_device_attr_module));
+	WARN_ON(class_device_create_file(dev, &class_device_attr_type));
+
+	switch(alg->cra_flags & CRYPTO_ALG_TYPE_MASK) {
+	case CRYPTO_ALG_TYPE_CIPHER:
+		WARN_ON(class_device_create_file(dev, &class_device_attr_blocksize));
+		WARN_ON(class_device_create_file(dev, &class_device_attr_minkeysize));
+		WARN_ON(class_device_create_file(dev, &class_device_attr_maxkeysize));
+		break;
+	case CRYPTO_ALG_TYPE_DIGEST:
+		WARN_ON(class_device_create_file(dev, &class_device_attr_digestsize));
+		break;
+	}
+#endif
+out:
 	up_write(&crypto_alg_sem);
 	return ret;
 }
@@ -184,13 +225,15 @@
 {
 	int ret =3D -ENOENT;
 	struct crypto_alg *q;
+	struct class_device *dev;
 =09
 	BUG_ON(!alg->cra_module);
 =09
 	down_write(&crypto_alg_sem);
-	list_for_each_entry(q, &crypto_alg_list, cra_list) {
+	list_for_each_entry(dev, &(cryptoapi_class.children), node) {
+		q =3D class_get_devdata(dev);
 		if (alg =3D=3D q) {
-			list_del(&alg->cra_list);
+			class_device_unregister(dev);
 			ret =3D 0;
 			goto out;
 		}
@@ -216,6 +259,7 @@
 static int __init init_crypto(void)
 {
 	printk(KERN_INFO "Initializing Cryptographic API\n");
+	class_register(&cryptoapi_class);
 	crypto_init_proc();
 	return 0;
 }
diff -u -N -r linux-2.6.9-rc1/crypto/arc4.c linux-2.6.9-rc1-class/crypto/ar=
c4.c
--- linux-2.6.9-rc1/crypto/arc4.c	2004-08-28 16:20:48.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/arc4.c	2004-09-06 14:49:35.000000000 +0200
@@ -75,7 +75,6 @@
 	.cra_blocksize		=3D	ARC4_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct arc4_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(arc4_alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	ARC4_MIN_KEY_SIZE,
 	.cia_max_keysize	=3D	ARC4_MAX_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/blowfish.c linux-2.6.9-rc1-class/crypt=
o/blowfish.c
--- linux-2.6.9-rc1/crypto/blowfish.c	2004-08-28 16:20:48.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/blowfish.c	2004-09-06 14:49:35.000000000 +=
0200
@@ -452,7 +452,6 @@
 	.cra_blocksize		=3D	BF_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct bf_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	BF_MIN_KEY_SIZE,
 	.cia_max_keysize	=3D	BF_MAX_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/cast5.c linux-2.6.9-rc1-class/crypto/c=
ast5.c
--- linux-2.6.9-rc1/crypto/cast5.c	2004-06-16 07:19:29.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/cast5.c	2004-09-06 14:49:35.000000000 +0200
@@ -821,7 +821,6 @@
 	.cra_blocksize 	=3D CAST5_BLOCK_SIZE,
 	.cra_ctxsize 	=3D sizeof(struct cast5_ctx),
 	.cra_module 	=3D THIS_MODULE,
-	.cra_list 	=3D LIST_HEAD_INIT(alg.cra_list),
 	.cra_u 		=3D {
 		.cipher =3D {
 			.cia_min_keysize =3D CAST5_MIN_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/cast6.c linux-2.6.9-rc1-class/crypto/c=
ast6.c
--- linux-2.6.9-rc1/crypto/cast6.c	2004-06-16 07:19:01.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/cast6.c	2004-09-06 14:49:35.000000000 +0200
@@ -534,7 +534,6 @@
 	.cra_blocksize =3D CAST6_BLOCK_SIZE,
 	.cra_ctxsize =3D sizeof(struct cast6_ctx),
 	.cra_module =3D THIS_MODULE,
-	.cra_list =3D LIST_HEAD_INIT(alg.cra_list),
 	.cra_u =3D {
 		  .cipher =3D {
 			     .cia_min_keysize =3D CAST6_MIN_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/crc32c.c linux-2.6.9-rc1-class/crypto/=
crc32c.c
--- linux-2.6.9-rc1/crypto/crc32c.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/crc32c.c	2004-09-06 14:49:35.000000000 +02=
00
@@ -80,7 +80,6 @@
 	.cra_blocksize	=3D	CHKSUM_BLOCK_SIZE,
 	.cra_ctxsize	=3D	sizeof(struct chksum_ctx),
 	.cra_module	=3D	THIS_MODULE,
-	.cra_list	=3D	LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=3D	{
 		.digest =3D {
 			 .dia_digestsize=3D	CHKSUM_DIGEST_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/crypto_null.c linux-2.6.9-rc1-class/cr=
ypto/crypto_null.c
--- linux-2.6.9-rc1/crypto/crypto_null.c	2004-06-16 07:19:22.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/crypto_null.c	2004-09-06 14:49:35.00000000=
0 +0200
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
diff -u -N -r linux-2.6.9-rc1/crypto/deflate.c linux-2.6.9-rc1-class/crypto=
/deflate.c
--- linux-2.6.9-rc1/crypto/deflate.c	2004-08-28 15:33:46.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/deflate.c	2004-09-06 14:49:35.000000000 +0=
200
@@ -196,7 +196,6 @@
 	.cra_flags		=3D CRYPTO_ALG_TYPE_COMPRESS,
 	.cra_ctxsize		=3D sizeof(struct deflate_ctx),
 	.cra_module		=3D THIS_MODULE,
-	.cra_list		=3D LIST_HEAD_INIT(alg.cra_list),
 	.cra_u			=3D { .compress =3D {
 	.coa_init		=3D deflate_init,
 	.coa_exit		=3D deflate_exit,
diff -u -N -r linux-2.6.9-rc1/crypto/des.c linux-2.6.9-rc1-class/crypto/des=
=2Ec
--- linux-2.6.9-rc1/crypto/des.c	2004-06-16 07:20:20.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/des.c	2004-09-06 14:49:35.000000000 +0200
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
diff -u -N -r linux-2.6.9-rc1/crypto/khazad.c linux-2.6.9-rc1-class/crypto/=
khazad.c
--- linux-2.6.9-rc1/crypto/khazad.c	2004-08-28 15:33:46.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/khazad.c	2004-09-06 14:49:35.000000000 +02=
00
@@ -885,7 +885,6 @@
 	.cra_blocksize		=3D	KHAZAD_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof (struct khazad_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(khazad_alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	KHAZAD_KEY_SIZE,
 	.cia_max_keysize	=3D	KHAZAD_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/Makefile linux-2.6.9-rc1-class/crypto/=
Makefile
--- linux-2.6.9-rc1/crypto/Makefile	2004-08-28 15:33:46.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/Makefile	2004-09-06 14:49:35.000000000 +02=
00
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
diff -u -N -r linux-2.6.9-rc1/crypto/md4.c linux-2.6.9-rc1-class/crypto/md4=
=2Ec
--- linux-2.6.9-rc1/crypto/md4.c	2004-06-16 07:19:26.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/md4.c	2004-09-06 14:49:35.000000000 +0200
@@ -224,7 +224,6 @@
 	.cra_blocksize	=3D	MD4_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=3D	sizeof(struct md4_ctx),
 	.cra_module	=3D	THIS_MODULE,
-	.cra_list       =3D       LIST_HEAD_INIT(alg.cra_list),=09
 	.cra_u		=3D	{ .digest =3D {
 	.dia_digestsize	=3D	MD4_DIGEST_SIZE,
 	.dia_init   	=3D 	md4_init,
diff -u -N -r linux-2.6.9-rc1/crypto/md5.c linux-2.6.9-rc1-class/crypto/md5=
=2Ec
--- linux-2.6.9-rc1/crypto/md5.c	2004-06-16 07:19:22.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/md5.c	2004-09-06 14:49:35.000000000 +0200
@@ -219,7 +219,6 @@
 	.cra_blocksize	=3D	MD5_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=3D	sizeof(struct md5_ctx),
 	.cra_module	=3D	THIS_MODULE,
-	.cra_list	=3D	LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=3D	{ .digest =3D {
 	.dia_digestsize	=3D	MD5_DIGEST_SIZE,
 	.dia_init   	=3D 	md5_init,
diff -u -N -r linux-2.6.9-rc1/crypto/michael_mic.c linux-2.6.9-rc1-class/cr=
ypto/michael_mic.c
--- linux-2.6.9-rc1/crypto/michael_mic.c	2004-06-16 07:19:37.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/michael_mic.c	2004-09-06 14:49:35.00000000=
0 +0200
@@ -163,7 +163,6 @@
 	.cra_blocksize	=3D 8,
 	.cra_ctxsize	=3D sizeof(struct michael_mic_ctx),
 	.cra_module	=3D THIS_MODULE,
-	.cra_list	=3D LIST_HEAD_INIT(michael_mic_alg.cra_list),
 	.cra_u		=3D { .digest =3D {
 	.dia_digestsize	=3D 8,
 	.dia_init	=3D michael_init,
diff -u -N -r linux-2.6.9-rc1/crypto/proc.c linux-2.6.9-rc1-class/crypto/pr=
oc.c
--- linux-2.6.9-rc1/crypto/proc.c	2004-06-16 07:19:03.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/proc.c	2004-09-06 16:57:40.000000000 +0200
@@ -16,9 +16,10 @@
 #include <linux/rwsem.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/device.h>
 #include "internal.h"
=20
-extern struct list_head crypto_alg_list;
+extern struct class cryptoapi_class;
 extern struct rw_semaphore crypto_alg_sem;
=20
 static void *c_start(struct seq_file *m, loff_t *pos)
@@ -27,20 +28,20 @@
 	loff_t n =3D *pos;
=20
 	down_read(&crypto_alg_sem);
-	list_for_each(v, &crypto_alg_list)
+	list_for_each(v, &cryptoapi_class.children)
 		if (!n--)
-			return list_entry(v, struct crypto_alg, cra_list);
+			return list_entry(v, struct class_device, node);
 	return NULL;
 }
=20
 static void *c_next(struct seq_file *m, void *p, loff_t *pos)
 {
-	struct list_head *v =3D p;
-=09
+	struct list_head *e =3D &(((struct class_device*)p)->node);
+
 	(*pos)++;
-	v =3D v->next;
-	return (v =3D=3D &crypto_alg_list) ?
-		NULL : list_entry(v, struct crypto_alg, cra_list);
+	e =3D e->next;
+	return (e =3D=3D &(cryptoapi_class.children)) ?
+		NULL : list_entry(e, struct class_device, node);
 }
=20
 static void c_stop(struct seq_file *m, void *p)
@@ -50,8 +51,8 @@
=20
 static int c_show(struct seq_file *m, void *p)
 {
-	struct crypto_alg *alg =3D (struct crypto_alg *)p;
-=09
+	struct crypto_alg *alg =3D (struct crypt_alg*)class_get_devdata((struct c=
lass_device*)p);
+
 	seq_printf(m, "name         : %s\n", alg->cra_name);
 	seq_printf(m, "module       : %s\n", module_name(alg->cra_module));
 =09
diff -u -N -r linux-2.6.9-rc1/crypto/serpent.c linux-2.6.9-rc1-class/crypto=
/serpent.c
--- linux-2.6.9-rc1/crypto/serpent.c	2004-06-16 07:19:09.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/serpent.c	2004-09-06 14:49:35.000000000 +0=
200
@@ -479,7 +479,6 @@
 	.cra_blocksize		=3D	SERPENT_BLOCK_SIZE,
 	.cra_ctxsize		=3D	sizeof(struct serpent_ctx),
 	.cra_module		=3D	THIS_MODULE,
-	.cra_list		=3D	LIST_HEAD_INIT(serpent_alg.cra_list),
 	.cra_u			=3D	{ .cipher =3D {
 	.cia_min_keysize	=3D	SERPENT_MIN_KEY_SIZE,
 	.cia_max_keysize	=3D	SERPENT_MAX_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/crypto/sha1.c linux-2.6.9-rc1-class/crypto/sh=
a1.c
--- linux-2.6.9-rc1/crypto/sha1.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/sha1.c	2004-09-06 14:49:35.000000000 +0200
@@ -183,7 +183,6 @@
 	.cra_blocksize	=3D	SHA1_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=3D	sizeof(struct sha1_ctx),
 	.cra_module	=3D	THIS_MODULE,
-	.cra_list       =3D       LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=3D	{ .digest =3D {
 	.dia_digestsize	=3D	SHA1_DIGEST_SIZE,
 	.dia_init   	=3D 	sha1_init,
diff -u -N -r linux-2.6.9-rc1/crypto/sha256.c linux-2.6.9-rc1-class/crypto/=
sha256.c
--- linux-2.6.9-rc1/crypto/sha256.c	2004-06-16 07:19:13.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/sha256.c	2004-09-06 14:49:35.000000000 +02=
00
@@ -337,7 +337,6 @@
 	.cra_blocksize	=3D	SHA256_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=3D	sizeof(struct sha256_ctx),
 	.cra_module	=3D	THIS_MODULE,
-	.cra_list       =3D       LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=3D	{ .digest =3D {
 	.dia_digestsize	=3D	SHA256_DIGEST_SIZE,
 	.dia_init   	=3D 	sha256_init,
diff -u -N -r linux-2.6.9-rc1/crypto/sha512.c linux-2.6.9-rc1-class/crypto/=
sha512.c
--- linux-2.6.9-rc1/crypto/sha512.c	2004-06-16 07:20:04.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/sha512.c	2004-09-06 14:49:35.000000000 +02=
00
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
diff -u -N -r linux-2.6.9-rc1/crypto/sysfs.c linux-2.6.9-rc1-class/crypto/s=
ysfs.c
--- linux-2.6.9-rc1/crypto/sysfs.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc1-class/crypto/sysfs.c	2004-09-06 23:42:00.000000000 +0200
@@ -0,0 +1,75 @@
+#include <linux/init.h>
+#include <linux/crypto.h>
+#include <linux/errno.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include "internal.h"
+
+void cryptoapi_release(struct class_device *class_dev);
+
+struct class cryptoapi_class =3D {
+	.name =3D "crypto",
+	.release =3D cryptoapi_release,
+};
+
+static ssize_t cryptoapi_show_name(struct class_device *dev, char *buffer);
+static ssize_t cryptoapi_show_blocksize(struct class_device *dev, char *bu=
ffer);
+static ssize_t cryptoapi_show_digestsize(struct class_device *dev, char *b=
uffer);
+static ssize_t cryptoapi_show_type(struct class_device *dev, char *buffer);
+static ssize_t cryptoapi_show_module(struct class_device *dev, char *buffe=
r);
+static ssize_t cryptoapi_show_maxkeysize(struct class_device *dev, char *b=
uffer);
+static ssize_t cryptoapi_show_minkeysize(struct class_device *dev, char *b=
uffer);
+
+CLASS_DEVICE_ATTR(blocksize, 0444, cryptoapi_show_blocksize, NULL);
+CLASS_DEVICE_ATTR(digestsize, 0444, cryptoapi_show_digestsize, NULL);
+CLASS_DEVICE_ATTR(minkeysize, 0444, cryptoapi_show_minkeysize, NULL);
+CLASS_DEVICE_ATTR(maxkeysize, 0444, cryptoapi_show_maxkeysize, NULL);
+CLASS_DEVICE_ATTR(name, 0444, cryptoapi_show_name, NULL);
+CLASS_DEVICE_ATTR(module, 0444, cryptoapi_show_module, NULL);
+CLASS_DEVICE_ATTR(type, 0444, cryptoapi_show_type, NULL);
+
+void cryptoapi_release(struct class_device *class_dev) {
+	kfree(class_dev);
+}
+
+#define cryptoapi_show(_name, _attr, _format) \
+	static ssize_t cryptoapi_show_##_name(struct class_device *dev, char *buf=
fer) { \
+		BUG_ON(dev=3D=3DNULL); \
+		return (snprintf(buffer, PAGE_SIZE, __stringify(_format), \
+				((struct crypto_alg*)class_get_devdata(dev))->cra_##_attr)+1)*sizeof(c=
har); \
+	}
+
+cryptoapi_show(blocksize, blocksize, %u\n);
+cryptoapi_show(digestsize, digest.dia_digestsize, %u\n);
+cryptoapi_show(minkeysize, cipher.cia_min_keysize, %u\n);
+cryptoapi_show(maxkeysize, cipher.cia_max_keysize, %u\n);
+cryptoapi_show(name, name, %s\n);
+
+#undef cryptoapi_show
+
+static ssize_t cryptoapi_show_module(struct class_device *dev, char *buffe=
r) {
+	BUG_ON(dev=3D=3DNULL);
+	return (snprintf(buffer, PAGE_SIZE, "%s\n",
+			module_name(((struct crypto_alg*)class_get_devdata(dev))->cra_module))+=
1)*sizeof(char);
+}
+
+static ssize_t cryptoapi_show_type(struct class_device *dev, char *buffer)=
 {
+	struct crypto_alg *tmp =3D class_get_devdata(dev);
+=09
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
diff -u -N -r linux-2.6.9-rc1/crypto/tea.c linux-2.6.9-rc1-class/crypto/tea=
=2Ec
--- linux-2.6.9-rc1/crypto/tea.c	2004-08-28 15:33:46.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/tea.c	2004-09-06 14:49:35.000000000 +0200
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
diff -u -N -r linux-2.6.9-rc1/crypto/twofish.c linux-2.6.9-rc1-class/crypto=
/twofish.c
--- linux-2.6.9-rc1/crypto/twofish.c	2004-08-28 16:20:48.000000000 +0200
+++ linux-2.6.9-rc1-class/crypto/twofish.c	2004-09-06 14:49:35.000000000 +0=
200
@@ -876,7 +876,6 @@
 	.cra_blocksize      =3D   TF_BLOCK_SIZE,
 	.cra_ctxsize        =3D   sizeof(struct twofish_ctx),
 	.cra_module         =3D   THIS_MODULE,
-	.cra_list           =3D   LIST_HEAD_INIT(alg.cra_list),
 	.cra_u              =3D   { .cipher =3D {
 	.cia_min_keysize    =3D   TF_MIN_KEY_SIZE,
 	.cia_max_keysize    =3D   TF_MAX_KEY_SIZE,
diff -u -N -r linux-2.6.9-rc1/include/linux/crypto.h linux-2.6.9-rc1-class/=
include/linux/crypto.h
--- linux-2.6.9-rc1/include/linux/crypto.h	2004-06-16 07:19:03.000000000 +0=
200
+++ linux-2.6.9-rc1-class/include/linux/crypto.h	2004-09-06 18:01:06.000000=
000 +0200
@@ -94,7 +94,6 @@
 #define cra_compress	cra_u.compress
=20
 struct crypto_alg {
-	struct list_head cra_list;
 	u32 cra_flags;
 	unsigned int cra_blocksize;
 	unsigned int cra_ctxsize;

--RnlQjJ0d97Da+TV1--

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBQYgGo1Xfh1pGf9oRApdlAJ0ZBXymIDnFWeuOwaGbyFjKB4dwhQCdHj06
R19f7I7NJG7V1PbaGM3/gss=
=ansM
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
