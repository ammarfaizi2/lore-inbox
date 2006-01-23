Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWAWUnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWAWUnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWAWUnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:43:14 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:49588 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S964941AbWAWUnI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:43:08 -0500
Cc: dhowells@redhat.com, david@2gen.com
Subject: [PATCH 04/04] Add dsa key type
In-Reply-To: <1138048952965@2gen.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 23 Jan 2006 21:42:32 +0100
Message-Id: <11380489522073@2gen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
X-SA-Score: -0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds the dsa in-kernel key type.

Signed-off-by: David H�rdeman <david@2gen.com>

--

Index: vanilla-kernel/security/Kconfig
===================================================================
--- vanilla-kernel.orig/security/Kconfig	2006-01-17 22:49:50.000000000 +0100
+++ vanilla-kernel/security/Kconfig	2006-01-23 18:45:29.000000000 +0100
@@ -21,6 +21,14 @@
 
 	  If you are unsure as to whether this is required, answer N.
 
+config KEYS_DSA_KEYS
+	tristate "Support DSA keys (EXPERIMENTAL)"
+	depends on KEYS && EXPERIMENTAL
+	select CRYPTO_MPILIB
+	select CRYPTO_DSA
+	help
+	  This option provides support for retaining DSA keys in the kernel.
+
 config KEYS_DEBUG_PROC_KEYS
 	bool "Enable the /proc/keys file by which all keys may be viewed"
 	depends on KEYS
Index: vanilla-kernel/security/keys/Makefile
===================================================================
--- vanilla-kernel.orig/security/keys/Makefile	2006-01-15 18:22:51.000000000 +0100
+++ vanilla-kernel/security/keys/Makefile	2006-01-23 18:46:00.000000000 +0100
@@ -13,4 +13,5 @@
 	user_defined.o
 
 obj-$(CONFIG_KEYS_COMPAT) += compat.o
+obj-$(CONFIG_KEYS_DSA_KEYS) += dsa_key.o
 obj-$(CONFIG_PROC_FS) += proc.o
Index: vanilla-kernel/security/keys/dsa_key.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ vanilla-kernel/security/keys/dsa_key.c	2006-01-23 18:46:00.000000000 +0100
@@ -0,0 +1,372 @@
+/* dsa_key.c: DSA key
+ *
+ * Copyright (C) 2005 David H�rdeman (david@2gen.com). All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/seq_file.h>
+#include <linux/err.h>
+#include <asm/uaccess.h>
+#include <linux/mpi.h>
+#include <linux/dsa.h>
+#include <linux/random.h>
+#include <linux/mm.h>
+#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
+#include <linux/crypto.h>
+#include <keys/user-type.h>
+#include "internal.h"
+
+static int dsa_instantiate(struct key *key, const void *data, size_t datalen);
+static int dsa_update(struct key *key, const void *data, size_t datalen);
+static void dsa_destroy(struct key *key);
+static long dsa_read(const struct key *key, 
+		     char __user *buffer, size_t buflen);
+static long dsa_encrypt(const struct key *key,
+			char __user *_data, size_t dlen,
+			char __user *_result, size_t rlen);
+
+static struct key_type key_type_dsa = {
+	.name		= "dsa",
+	.instantiate	= dsa_instantiate,
+	.update		= dsa_update,
+	.destroy	= dsa_destroy,
+	.read		= dsa_read,
+	.encrypt	= dsa_encrypt,
+	.match		= user_match,
+	.describe	= user_describe,
+};
+
+/****************
+ * Signs a chunk of data using key.
+ * Returns: signature.
+ */
+static char *
+sign(const struct key_payload_dsa *skey, 
+     const void *data, size_t datalen, unsigned int *rlen)
+{
+	struct crypto_tfm *tfm;
+	char *ret = NULL;
+	u8 *sig;
+	unsigned int sigsize;
+	int i;
+	struct scatterlist sg[1];
+
+	dprintk("dsa: entering sign\n");
+	tfm = crypto_alloc_tfm("dsa", 0);
+	if (!tfm)
+		goto out;
+
+	sigsize = crypto_tfm_alg_digestsize(tfm);
+	sig = kmalloc(sigsize, GFP_KERNEL);
+	if (!sig)
+		goto out_tfm;
+
+	crypto_digest_init(tfm);
+	i = crypto_digest_setkey(tfm, (const u8 *)skey, sizeof(skey));
+	if (i) {
+		printk("dsa: crypto_digest_setkey failed with error %i\n", i);
+		goto out_sig;
+	}
+
+	sg_init_one(sg, (u8 *)data, datalen);
+	crypto_digest_update(tfm, sg, 1);
+	crypto_digest_final(tfm, sig);
+	ret = sig;
+	*rlen = sigsize;
+	goto out_tfm;
+
+out_sig:
+	kfree(sig);
+out_tfm:
+	crypto_free_tfm(tfm);
+out:
+	return ret;
+}
+
+/****************
+ * Test whether the secret key is valid.
+ * Returns: if this is a valid key.
+ */
+static int check_secret_key(struct key_payload_dsa *skey)
+{
+	int rc;
+	MPI y;
+
+	/* y = g^x mod p */
+	dprintk("dsa: In check secret\n");
+	y = mpi_alloc(mpi_get_nlimbs(skey->part[DSA_PART_Y]));
+	rc = mpi_powm(y, skey->part[DSA_PART_G], skey->part[DSA_PART_X], skey->part[DSA_PART_P]);
+	rc = !mpi_cmp(y, skey->part[DSA_PART_Y]);
+
+	mpi_free(y);
+	return rc;
+}
+
+/*****************************************************************************/
+/*
+ * create a dsa key payload
+ */
+static int dsa_create_payload(struct key_payload_dsa **payload, struct key *key, 
+			      const void *data, size_t datalen)
+{
+	int ret, i;
+	unsigned int remain, read;
+	const unsigned char *ptr;
+
+	dprintk("dsa: entering dsa_create_payload\n");
+
+	ret = -EINVAL;
+	if (datalen <= 0 || datalen > 32767 || !data)
+		goto out1;
+
+	ret = -ENOMEM;
+	*payload = kmalloc(sizeof(struct key_payload_dsa), GFP_KERNEL);
+	if (!(*payload))
+		goto out1;
+
+	ret = key_payload_reserve(key, datalen);
+	if (ret < 0)
+		goto out2;
+
+	/* read each mpi number from buffer */
+	remain = read = (unsigned int)datalen;
+	ptr = data;
+	ret = 0;
+	for (i = 0; i < DSA_PARTS; i++) {
+		dprintk("dsa: in loop %i, remain is %u\n", i, remain);
+		(*payload)->part[i] = mpi_read_from_buffer(ptr, &read);
+		if (!((*payload)->part[i]))
+			ret = -EINVAL;
+		ptr += read;
+		remain -= read;
+		read = remain;
+		dprintk("dsa: end loop\n");
+	}
+
+	if (ret < 0)
+		goto out3;
+
+	/* check validity */
+	ret = -EINVAL;
+	if(check_secret_key(*payload)) {
+		ret = 0;
+		dprintk("dsa: valid\n");
+		goto out1;
+	}
+
+out3:
+	printk("dsa: attempt to add invalid key\n");
+	for (i = 0; i < DSA_PARTS; i++)
+		mpi_free((*payload)->part[i]);
+out2:
+	kfree(*payload);
+out1:
+	return ret;
+
+} /* end dsa_instantiate() */
+
+/*****************************************************************************/
+/*
+ * instantiate a dsa key
+ */
+static int dsa_instantiate(struct key *key, const void *data, size_t datalen)
+{
+	struct key_payload_dsa *dsa_key;
+	int ret;
+
+	dprintk("dsa: entering dsa_instantiate\n");
+	ret = dsa_create_payload(&dsa_key, key, data, datalen);
+	if (ret == 0)
+		key->payload.data = dsa_key;
+
+	return ret;
+
+} /* end dsa_instantiate() */
+
+/*****************************************************************************/
+/*
+ * update a user defined key
+ */
+static int dsa_update(struct key *key, const void *data, size_t datalen)
+{
+	struct key_payload_dsa *new_payload;
+	int ret;
+
+	dprintk("dsa: entering dsa_update\n");
+	ret = dsa_create_payload(&new_payload, key, data, datalen);
+	if (ret == 0) {
+		dprintk("dsa: dsa_create_payload success\n");
+		/* this destroys the old payload, not the entire key */
+		dsa_destroy(key);
+		key->payload.data = new_payload;
+		key->expiry = 0;
+	}
+	
+	return ret;
+
+} /* end dsa_update() */
+
+/*****************************************************************************/
+/*
+ * dispose of the key payload
+ */
+static void dsa_destroy(struct key *key)
+{
+	struct key_payload_dsa *dsa_key;
+	int i;
+
+	dprintk("dsa: entering dsa_destroy\n");
+	dsa_key = key->payload.data;
+	if (dsa_key) {
+		for (i = 0; i < DSA_PARTS; i++)
+			mpi_free(dsa_key->part[i]);
+		kfree(dsa_key);
+	}
+
+} /* end dsa_destroy() */
+
+/*****************************************************************************/
+/*
+ * read the key data
+ */
+static long dsa_read(const struct key *key, char __user *buffer, size_t buflen)
+{
+	unsigned char *xbuffer[DSA_PUBLIC_PARTS];
+	unsigned nbytes[DSA_PUBLIC_PARTS];
+	unsigned nbits[DSA_PUBLIC_PARTS];
+	struct key_payload_dsa *dsa_key;
+	int i;
+	char *result, *tmp;
+	size_t reslen;
+	long ret;
+
+	dprintk("dsa: entering dsa_read\n");
+	ret = -EINVAL;
+	dsa_key = (struct key_payload_dsa *)key->payload.data;
+	if (!dsa_key)
+		goto out1;
+
+	/* 4 x 2 bytes to store mpi sizes */
+	reslen = 8;
+	memset(xbuffer, 0, sizeof(xbuffer));
+	ret = -ENOMEM;
+
+	for (i = 0; i < DSA_PUBLIC_PARTS; i++) {
+		xbuffer[i] = mpi_get_buffer(dsa_key->part[i], &nbytes[i], NULL);
+		if (!xbuffer[i]) {
+			dprintk("dsa: failed to get buffer\n");
+			goto out2;
+		}
+		reslen += nbytes[i];
+		nbits[i] = mpi_get_nbits(dsa_key->part[i]);
+	}
+
+	result = kmalloc(reslen, GFP_KERNEL);
+	if (!result)
+		goto out2;
+
+	tmp = result;
+	for (i = 0; i < DSA_PUBLIC_PARTS; i++) {
+		dprintk("dsa: checking part %i\n", i);
+		dprintk("dsa: nbytes is %i, nbits is %i, topbyte is %2hx, botbyte is %2hx\n",
+			nbytes[i], nbits[i], ((nbits[i] >> 8) & 0xff), ((nbits[i]) & 0xff));
+		MPI_WSIZE(tmp, nbits[i]);
+		memcpy(tmp, xbuffer[i], nbytes[i]);
+		tmp += nbytes[i];
+	}
+
+	ret = -EFAULT;
+	if (copy_to_user(buffer, result, min(reslen, buflen)) == 0)
+		ret = reslen;
+
+	memset(result, 0, reslen);
+	kfree(result);
+	
+out2:
+	for (i = 0; i < DSA_PUBLIC_PARTS; i++) {
+		memset(xbuffer[i], 0, nbytes[i]);
+		kfree(xbuffer[i]);
+	}
+out1:
+	dprintk("dsa: leving dsa_read\n");
+	return ret;
+
+} /* end dsa_read() */
+
+/*****************************************************************************/
+/*
+ * encrypt data using a key
+ */
+static long dsa_encrypt(const struct key *key,
+		     char __user *data, size_t dlen,
+		     char __user *result, size_t rlen)
+{
+	char *signature;
+	char *inbuf;
+	long ret;
+	size_t siglen = 0;
+
+	dprintk("dsa: entering dsa_encrypt\n");
+	ret = -ENOMEM;
+	inbuf = kmalloc(dlen, GFP_KERNEL);
+	if (!inbuf)
+		goto out1;
+
+	ret = -EFAULT;
+	/* pull the data to sign into kernel space */
+	if (copy_from_user(inbuf, data, dlen))
+		goto out2;
+
+	/* sign it */
+	signature = sign((struct key_payload_dsa *)key->payload.data,
+			 inbuf, dlen, &siglen);
+	if (!signature)
+		goto out2;
+
+	/* push the result to userspace */
+	if(copy_to_user(result, signature, min(rlen, siglen)) == 0)
+		ret = siglen;
+
+	memset(signature, 0, siglen);
+	kfree(signature);
+out2:
+	memset(inbuf, 0, dlen);
+	kfree(inbuf);
+out1:
+	return ret;
+} /* end dsa_encrypt() */
+
+static int __init dsa_init(void)
+{
+	int ret;
+
+	ret = register_key_type(&key_type_dsa);
+	if (ret < 0)
+		printk("dsa_key: failed to register key type\n");
+	else
+		printk("dsa_key: new key type registered\n");
+
+	return ret;
+}
+
+static void __exit dsa_exit (void)
+{
+	printk("dsa_key: unregistering key type\n");
+	unregister_key_type(&key_type_dsa);
+}
+
+module_init(dsa_init);
+module_exit(dsa_exit);
+
+MODULE_AUTHOR("David H�rdeman");
+MODULE_DESCRIPTION("DSA key support");
+MODULE_LICENSE("GPL");

