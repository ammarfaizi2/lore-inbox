Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWAWUnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWAWUnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAWUnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:43:10 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:48564 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S964933AbWAWUnG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:43:06 -0500
Cc: dhowells@redhat.com, david@2gen.com
Subject: [PATCH 02/04] Add dsa crypto ops
In-Reply-To: <11380489522552@2gen.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 23 Jan 2006 21:42:32 +0100
Message-Id: <11380489523918@2gen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
X-SA-Score: -0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds dsa cryptographic operations. Since a dsa signature is always two
160-bit integer, I've modeled the dsa crypto as a hash algorithm.

Signed-off-by: David Härdeman <david@2gen.com>

--

Index: vanilla-kernel/crypto/Kconfig
===================================================================
--- vanilla-kernel.orig/crypto/Kconfig	2006-01-22 22:02:20.000000000 +0100
+++ vanilla-kernel/crypto/Kconfig	2006-01-22 22:08:27.000000000 +0100
@@ -342,6 +342,13 @@
 	  Multiprecision maths library from GnuPG. Used for some
 	  crypto algorithms.
 
+config CRYPTO_DSA
+	tristate "Digital Signature Algorithm (EXPERIMENTAL)"
+	depends on CRYPTO && CRYPTO_MPILIB && EXPERIMENTAL
+	help
+	  Digital Signature Algorithm is used in a number of applications
+	  such as ssh and gpg.
+
 config CRYPTO_TEST
 	tristate "Testing module"
 	depends on CRYPTO
Index: vanilla-kernel/crypto/Makefile
===================================================================
--- vanilla-kernel.orig/crypto/Makefile	2006-01-22 22:02:37.000000000 +0100
+++ vanilla-kernel/crypto/Makefile	2006-01-22 22:08:27.000000000 +0100
@@ -30,6 +30,7 @@
 obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.o
 obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 obj-$(CONFIG_CRYPTO_CRC32C) += crc32c.o
+obj-$(CONFIG_CRYPTO_DSA) += dsa.o
 obj-$(CONFIG_CRYPTO_MPILIB) += mpi/
 
 obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
Index: vanilla-kernel/crypto/dsa.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ vanilla-kernel/crypto/dsa.c	2006-01-22 22:08:11.000000000 +0100
@@ -0,0 +1,230 @@
+/*
+ * DSA Digital Signature Algorithm (FIPS-186).
+ *
+ * Copyright (c) 2005 David Härdeman <david@2gen.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/crypto.h>
+#include <linux/mpi.h>
+#include <linux/dsa.h>
+#include <linux/random.h>
+#include "../security/keys/internal.h"
+#include <linux/mm.h>
+#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
+
+
+/****************
+ * Generate a random secret exponent k less than q
+ */
+static MPI
+gen_k(MPI q)
+{
+	MPI k = mpi_alloc(mpi_get_nlimbs(q));
+	unsigned int nbits = mpi_get_nbits(q);
+	unsigned int nbytes = (nbits + 7)/8;
+	char *rndbuf = NULL;
+
+	dprintk("dsa: choosing a random k\n");
+
+	while(1) {
+		if (!rndbuf) {
+			rndbuf = kmalloc(nbytes, GFP_KERNEL);
+			if (!rndbuf) {
+				printk("dsa: failed to create buffer\n");
+				return NULL;
+			}
+			get_random_bytes(rndbuf, nbytes);
+		} else {
+			/* change only some of the higher bits */
+			get_random_bytes(rndbuf, min(nbytes, (unsigned int)4));
+		}
+
+		mpi_set_buffer(k, rndbuf, nbytes, 0);
+		if(mpi_test_bit( k, nbits - 1)) {
+			mpi_set_highbit(k, nbits - 1);
+		} else {
+			mpi_set_highbit(k, nbits - 1);
+			mpi_clear_bit(k, nbits - 1);
+		}
+
+		/* check: k < q */
+		if(!(mpi_cmp(k, q) < 0))
+			continue;
+
+		/* check: k > 0 */
+		if(!(mpi_cmp_ui(k, 0) > 0))
+			continue;
+
+		/* okay */
+		break;
+	}
+
+	kfree(rndbuf);
+	return k;
+}
+
+static void
+sign_hash(MPI r, MPI s, MPI hash, struct key_payload_dsa *skey)
+{
+	MPI k, kinv, tmp;
+
+	/* select a random k with 0 < k < q */
+	k = gen_k(skey->part[DSA_PART_Q]);
+	if (!k) {
+		printk("dsa: failed to create buffer\n");
+		return;
+	}
+
+	/* r = (g^k mod p) mod q */
+	mpi_powm(r, skey->part[DSA_PART_G], k, skey->part[DSA_PART_P]);
+	mpi_fdiv_r(r, r, skey->part[DSA_PART_Q]);
+
+	/* kinv = k^(-1) mod q */
+	kinv = mpi_alloc(mpi_get_nlimbs(k));
+	mpi_invm(kinv, k, skey->part[DSA_PART_Q]);
+
+	/* s = (kinv * ( hash + x * r)) mod q */
+	tmp = mpi_alloc(mpi_get_nlimbs(skey->part[DSA_PART_P]));
+	mpi_mul(tmp, skey->part[DSA_PART_X], r);
+	mpi_add(tmp, tmp, hash);
+	mpi_mulm(s , kinv, tmp, skey->part[DSA_PART_Q]);
+
+	mpi_free(k);
+	mpi_free(kinv);
+	mpi_free(tmp);
+}
+
+struct dsa_ctx {
+	struct crypto_tfm *sha1;
+	struct key_payload_dsa *key;
+};
+
+static int dsa_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+{
+	struct dsa_ctx *dctx = ctx;
+
+	if (keylen != sizeof(struct key_payload_dsa *)) {
+		printk("Invalid key size in dsa_setkey\n");
+		return -EINVAL;
+	}
+
+	dctx->key = (struct key_payload_dsa *)key;
+	return 0;
+}
+
+static void dsa_init(void *ctx)
+{
+	struct dsa_ctx *dctx = ctx;
+
+	dctx->key = NULL;
+	dctx->sha1 = crypto_alloc_tfm("sha1", 0);
+	if (!dctx->sha1)
+		printk("dsa_init: failed to allocate sha1 tfm\n");
+	else
+		crypto_digest_init(dctx->sha1);
+}
+
+static void dsa_update(void *ctx, const u8 *data, unsigned int dlen)
+{
+	struct scatterlist sg[1];
+	struct dsa_ctx *dctx = ctx;
+
+	if (!dctx->sha1)
+		return;
+
+	sg_init_one(sg, (u8 *)data, dlen);
+	crypto_digest_update(dctx->sha1, sg, 1);
+}
+
+static void dsa_final(void *ctx, u8 *out)
+{
+	struct dsa_ctx *dctx = ctx;
+	unsigned int dsize = crypto_tfm_alg_digestsize(dctx->sha1);
+	u8 buffer[dsize];
+	MPI hash, r, s;
+	u8 *outp = out;
+	unsigned int rbytes, rbits, sbytes, sbits;
+	char *rbuf, *sbuf;
+
+	if (!dctx->sha1)
+		return;
+
+	crypto_digest_final(dctx->sha1, buffer);
+	crypto_free_tfm(dctx->sha1);
+	dctx->sha1 = NULL;
+
+	hash = mpi_alloc(1);
+	r = mpi_alloc(1);
+	s = mpi_alloc(1);
+	if (!hash || !r || !s) {
+		printk("dsa_final: failed to allocate mpis\n");
+		goto out1;
+	}
+
+	mpi_set_buffer(hash, buffer, dsize, 0);
+	sign_hash(r, s, hash, dctx->key);
+	rbuf = mpi_get_buffer(r, &rbytes, NULL);
+	sbuf = mpi_get_buffer(s, &sbytes, NULL);
+	if (!rbuf || !sbuf) {
+		printk("dsa_final: failed to allocate buffers\n");
+		goto out2;
+	}
+
+	rbits = mpi_get_nbits(r);
+	MPI_WSIZE(outp, rbits);
+	memcpy(outp, rbuf, rbytes);
+	outp += rbytes;
+
+	sbits = mpi_get_nbits(s);
+	MPI_WSIZE(outp, sbits);
+	memcpy(outp, sbuf, sbytes);
+
+out2:
+	kfree(rbuf);
+	kfree(sbuf);
+out1:
+	mpi_free(hash);
+	mpi_free(r);
+	mpi_free(s);
+}
+
+static struct crypto_alg alg = {
+	.cra_name	=	"dsa",
+	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize	=	DSA_HMAC_BLOCK_SIZE,
+	.cra_ctxsize	=	sizeof(struct dsa_ctx),
+	.cra_module	=	THIS_MODULE,
+	.cra_list	=	LIST_HEAD_INIT(alg.cra_list),
+	.cra_u		=	{ .digest = {
+	.dia_digestsize	=	DSA_DIGEST_SIZE,
+	.dia_init   	= 	dsa_init,
+	.dia_update 	=	dsa_update,
+	.dia_final  	=	dsa_final,
+	.dia_setkey  	=	dsa_setkey } }
+};
+
+static int __init init(void)
+{
+	return crypto_register_alg(&alg);
+}
+
+static void __exit fini(void)
+{
+	crypto_unregister_alg(&alg);
+}
+
+module_init(init);
+module_exit(fini);
+
+MODULE_AUTHOR("David Härdeman");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DSA Digital Signature Algorithm");
Index: vanilla-kernel/include/linux/dsa.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ vanilla-kernel/include/linux/dsa.h	2006-01-22 22:07:58.000000000 +0100
@@ -0,0 +1,39 @@
+/* dsa.h: digital signature architecture
+ *
+ * Copyright (C) 2005 David Härdeman (david@2gen.com).
+ * All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_DSA_H
+#define _LINUX_DSA_H
+#ifdef __KERNEL__
+
+#include <linux/mpi.h>
+
+#define DSA_DIGEST_SIZE         44
+#define DSA_HMAC_BLOCK_SIZE     64
+#define DSA_PART_P              0
+#define DSA_PART_Q              1
+#define DSA_PART_G              2
+#define DSA_PART_Y              3
+#define DSA_PART_X              4
+#define DSA_PARTS               5
+#define DSA_PUBLIC_PARTS        4
+
+struct key_payload_dsa {
+    MPI part[DSA_PARTS]; /* p,q,g,y,x */
+};
+
+#if 0
+#define dprintk(x...) printk(x)
+#else
+#define dprintk(x...) do { } while(0)
+#endif
+
+#endif
+#endif

