Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268280AbUI2JiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268280AbUI2JiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 05:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268282AbUI2JiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 05:38:22 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:62985 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S268280AbUI2Jhi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 05:37:38 -0400
Date: Wed, 29 Sep 2004 11:37:32 +0200
From: Andreas Happe <andreashappe@flatline.ath.cx>
To: Michal Ludvig <michal@logix.cz>
Cc: James Morris <jmorris@redhat.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, Andreas Happe <crow@old-fsckful.ath.cx>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
Message-ID: <20040929093732.GC3969@final-judgement.ath.cx>
References: <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com> <20040901082819.GA2489@final-judgement.ath.cx> <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz> <20040907143509.GA30920@old-fsckful.ath.cx> <Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz> <20040910105502.GA4663@final-judgement.ath.cx> <20040927084149.GA3625@final-judgement.ath.cx> <Pine.LNX.4.53.0409271046280.12238@maxipes.logix.cz> <20040928123426.GA21069@final-judgement.ath.cx> <20040929093613.GB3969@final-judgement.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20040929093613.GB3969@final-judgement.ath.cx>
X-Request-PGP: subkeys.pgp.net
X-Hangover: none
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

*sigh*

	--Andreas

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.9-rc2-cryptoapi_preferences"

diff -u -r -N linux-2.6.8/crypto/api.c linux-sysfs/crypto/api.c
--- linux-2.6.8/crypto/api.c	2004-09-28 12:52:40.000000000 +0200
+++ linux-sysfs/crypto/api.c	2004-09-28 23:13:57.000000000 +0200
@@ -46,7 +46,7 @@
 
 struct crypto_alg *crypto_alg_lookup(const char *name)
 {
-	struct crypto_alg *q, *alg = NULL;
+	struct crypto_alg *q, *tmp=NULL, *alg = NULL;
 	struct class_device *dev;
 
 	if (!name)
@@ -56,9 +56,15 @@
 	
 	list_for_each_entry(dev, &(cryptoapi_class.children), node) {
 		if (!(strcmp(dev->class_id, name))) {
-			q = (struct crypto_alg *)class_get_devdata(dev);
-			if (crypto_alg_get(q))
-				alg = q;
+			alg = q = class_get_devdata(dev);
+
+			list_for_each_entry(tmp, &(q->cra_family), cra_family) {
+				if(tmp->cra_preference > alg->cra_preference)
+					alg = tmp;
+			}
+
+			if(!crypto_alg_get(alg))
+				alg = NULL;
 			break;
 		}
 	}
@@ -177,13 +183,23 @@
 {
 	int ret = 0;
 	struct class_device *dev;
+	struct crypto_alg *tmp;
+	struct list_head *insert_position=NULL;
 	
 	down_write(&crypto_alg_sem);
 	
+	INIT_LIST_HEAD(&(alg->cra_family));
+
 	list_for_each_entry(dev, &(cryptoapi_class.children), node) {
 		if (!(strcmp(dev->class_id, alg->cra_name))) {
-			ret = -EEXIST;
-			goto out;
+			tmp=class_get_devdata(dev);
+
+			insert_position = &(tmp->cra_family);
+			if(!(strcmp(module_name(tmp->cra_module),\
+				    module_name(alg->cra_module)))) {
+				ret = -EEXIST;
+				goto out;
+			}
 		}
 	}
 	
@@ -196,7 +212,12 @@
 	memset(dev, 0, sizeof(*dev));
 	dev->class = &cryptoapi_class;
 	dev->dev   = NULL;
+
+	/* TODO: what to do if alg->cra_name is already in use? */
 	strncpy(dev->class_id, alg->cra_name, BUS_ID_SIZE);
+
+	if(insert_position)
+		list_add(&(alg->cra_family), insert_position);
 	class_device_register(dev);
 
 #ifdef CONFIG_SYSFS
diff -u -r -N linux-2.6.8/crypto/Kconfig linux-sysfs/crypto/Kconfig
--- linux-2.6.8/crypto/Kconfig	2004-09-28 12:50:31.000000000 +0200
+++ linux-sysfs/crypto/Kconfig	2004-09-28 12:18:25.000000000 +0200
@@ -16,6 +16,15 @@
 	  HMAC: Keyed-Hashing for Message Authentication (RFC2104).
 	  This is required for IPSec.
 
+config CRYPTO_PROC
+	bool "Legacy /proc/crypto interface (OBSOLETE)"
+	depends on PROC_FS && CRYPTO
+	help
+	  Displays cipher specific information via /proc/crypto.
+	  Please use /sysfs/class/crypto instead.
+
+	  When in double say Y.
+
 config CRYPTO_NULL
 	tristate "Null algorithms"
 	depends on CRYPTO
diff -u -r -N linux-2.6.8/crypto/Makefile linux-sysfs/crypto/Makefile
--- linux-2.6.8/crypto/Makefile	2004-09-28 12:52:40.000000000 +0200
+++ linux-sysfs/crypto/Makefile	2004-09-28 12:14:14.000000000 +0200
@@ -2,7 +2,7 @@
 # Cryptographic API
 #
 
-proc-crypto-$(CONFIG_PROC_FS) = proc.o
+proc-crypto-$(CONFIG_CRYPTO_PROC) = proc.o
 sysfs-crypto-$(CONFIG_SYSFS) = sysfs.o
 
 obj-$(CONFIG_CRYPTO) += api.o scatterwalk.o cipher.o digest.o compress.o \
diff -u -r -N linux-2.6.8/crypto/sysfs.c linux-sysfs/crypto/sysfs.c
--- linux-2.6.8/crypto/sysfs.c	2004-09-28 12:52:40.000000000 +0200
+++ linux-sysfs/crypto/sysfs.c	2004-09-28 18:57:48.000000000 +0200
@@ -14,6 +14,7 @@
 	.release = cryptoapi_release,
 };
 
+/* TODO: add cryptoapi_set_preference  */
 static ssize_t cryptoapi_show_name(struct class_device *dev, char *buffer);
 static ssize_t cryptoapi_show_blocksize(struct class_device *dev, char *buffer);
 static ssize_t cryptoapi_show_digestsize(struct class_device *dev, char *buffer);
@@ -21,6 +22,7 @@
 static ssize_t cryptoapi_show_module(struct class_device *dev, char *buffer);
 static ssize_t cryptoapi_show_maxkeysize(struct class_device *dev, char *buffer);
 static ssize_t cryptoapi_show_minkeysize(struct class_device *dev, char *buffer);
+static ssize_t cryptoapi_show_preference(struct class_device *dev, char *buffer);
 
 CLASS_DEVICE_ATTR(blocksize, 0444, cryptoapi_show_blocksize, NULL);
 CLASS_DEVICE_ATTR(digestsize, 0444, cryptoapi_show_digestsize, NULL);
@@ -29,6 +31,7 @@
 CLASS_DEVICE_ATTR(name, 0444, cryptoapi_show_name, NULL);
 CLASS_DEVICE_ATTR(module, 0444, cryptoapi_show_module, NULL);
 CLASS_DEVICE_ATTR(type, 0444, cryptoapi_show_type, NULL);
+CLASS_DEVICE_ATTR(preference, 0444, cryptoapi_show_preference, NULL);
 
 void cryptoapi_release(struct class_device *class_dev) {
 	kfree(class_dev);
@@ -46,6 +49,7 @@
 cryptoapi_show(minkeysize, cipher.cia_min_keysize, %u\n);
 cryptoapi_show(maxkeysize, cipher.cia_max_keysize, %u\n);
 cryptoapi_show(name, name, %s\n);
+cryptoapi_show(preference, preference, %u\n);
 
 #undef cryptoapi_show
 
diff -u -r -N linux-2.6.8/crypto/whirlpool.c linux-sysfs/crypto/whirlpool.c
--- linux-2.6.8/crypto/whirlpool.c	2004-09-28 12:50:31.000000000 +0200
+++ linux-sysfs/crypto/whirlpool.c	2004-09-28 12:24:23.000000000 +0200
@@ -1106,7 +1106,6 @@
 	.cra_blocksize	=	WHIRLPOOL_BLOCK_SIZE,
 	.cra_ctxsize	=	sizeof(struct whirlpool_ctx),
 	.cra_module	=	THIS_MODULE,
-	.cra_list       =       LIST_HEAD_INIT(alg.cra_list),	
 	.cra_u		=	{ .digest = {
 	.dia_digestsize	=	WHIRLPOOL_DIGEST_SIZE,
 	.dia_init   	= 	whirlpool_init,
diff -u -r -N linux-2.6.8/include/linux/crypto.h linux-sysfs/include/linux/crypto.h
--- linux-2.6.8/include/linux/crypto.h	2004-09-28 12:52:40.000000000 +0200
+++ linux-sysfs/include/linux/crypto.h	2004-09-28 23:10:46.000000000 +0200
@@ -56,6 +56,10 @@
 #define CRYPTO_UNSPEC			0
 #define CRYPTO_MAX_ALG_NAME		64
 
+#define CRYPTO_PREF_GENERIC		0
+#define CRYPTO_PREF_OPTIMIZED		10
+#define CRYPTO_PREF_HARDWARE		20
+
 struct scatterlist;
 
 /*
@@ -97,6 +101,7 @@
 	u32 cra_flags;
 	unsigned int cra_blocksize;
 	unsigned int cra_ctxsize;
+	unsigned int cra_preference;
 	const char cra_name[CRYPTO_MAX_ALG_NAME];
 
 	union {
@@ -105,6 +110,7 @@
 		struct compress_alg compress;
 	} cra_u;
 	
+	struct list_head cra_family;
 	struct module *cra_module;
 };
 

--WIyZ46R2i8wDzkSu--
