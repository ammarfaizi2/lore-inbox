Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUCVQ5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbUCVQ5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:57:12 -0500
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:3473 "EHLO
	rtp-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262113AbUCVQ4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:56:52 -0500
X-BrightmailFiltered: true
To: James Morris <jmorris@redhat.com>
Cc: Jouni Malinen <jkmaline@cc.hut.fi>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto/crc32c support
References: <Xine.LNX.4.44.0403211006190.16503-100000@thoron.boston.redhat.com>
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXl5ufMrp3a4OLr6ujO
 lXzChGmsblZzRzjF1+ErFRAz+KIaAAACVElEQVR4nG3TQW/aMBQAYC9IO88dguyWUomqt0DQ
 do7koO22SXFQb6uE7XIMKrFya+mhPk8D43+79+wMyrp3gnx59nvxMxmNEnIWycgH+U9E55CO
 rkZJ8hYipbXTdfcvQK/Xy6JF2zqI+qpbjZAszSDG2oXYp0FI5mOqbAeuDtLBdeuO8fNVxkzr
 E9jklKEgQWsppYYf9v4IE3i/4RiVRPneQTpoXSM8QA7un3QZQ2cl54wXIH7VDwEmrdOiZBgF
 V5BiLwLM4B3BS0ZpB24d4IvzW+QIc7/JIcAQIadF2eeUzn3FAa6xWFYUotjIRmLB7vEvCC4t
 VAugpTrC2FleLBm2wVnlAc7Dl2u5L1UozgWCjTxMW+vb4GVVFhWWFSCdKmgDMhaNFoxL3bSH
 rc/Irn1/RcWlh+UqNgHeNwishJ1L6LCpjdmGz76RmFGyuSwLgLUxJhyUlLA7fHMpeSGVPsFA
 wqtK4voI8RE+I3DsDpfamSNMpIBTKrF1yIpPMA0AzQPU5gSwCTyC/aEAtX4NM6gLM3CCziBT
 jRR+StQ/AA8a7AMuwxn0YAmcRKnVGwDRiOcw3uMWlajgAJsAPbw4OIpwrH3/vdq9B7hpl7GD
 w61A4PxwSqyH9J25gePnYdqhYjjZ5s6QCb3bwvOLJWPBFvCvWVDSthYmcff44IcacOUOt1Yv
 yGCF1+twuQtQCPjzZIaK/Lrx9+6b7TKEdXTwgz8R+uJv5K1jOcWMnO7NJ3v/QlprnzP1deUe
 8j4CpVE82MRj4j5SHGDnfvul8uGwjqNnpf4Ak4pzJDIy3lkAAAAASUVORK5CYII=
Date: Mon, 22 Mar 2004 10:56:45 -0600
In-Reply-To: <Xine.LNX.4.44.0403211006190.16503-100000@thoron.boston.redhat.com> (James
 Morris's message of "Sun, 21 Mar 2004 10:08:04 -0500 (EST)")
Message-ID: <yqujlllslt0y.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch agains 2.6.4 kernel code implements the CRC32C checksum/crc
algorithm as an additional type of digest.  The implementation is a
wrapper for routines found under lib/libcrc32c, available in another
patch.

This crypto patch requires the digest setkey() interface implemented
by Jouni Malinen <jkmaline@cc.hut.fi>, and supercedes an earlier patch
that implemented chksum as an additional CRYPTO_ALG_TYPE.

The immediate customer of these routines is the linux-iscsi driver,
currently in review.  Please see the linux-iscsi project on
SourceForge for details.

-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
     Of course the drugs advertised in all those emails are safe.
		      Show me the dead spammers!
			      (Please!)

diff -urN linux-2.6.4.orig/crypto/crc32c.c linux/crypto/crc32c.c
--- linux-2.6.4.orig/crypto/crc32c.c	1969-12-31 18:00:00.000000000 -0600
+++ linux/crypto/crc32c.c	2004-03-18 16:09:05.000000000 -0600
@@ -0,0 +1,110 @@
+/* 
+ * Cryptographic API.
+ *
+ * CRC32C chksum
+ *
+ * This module file is a wrapper to invoke the lib/crc32c routines.
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
+#include <linux/crc32c.h>
+#include <asm/byteorder.h>
+
+#define CHKSUM_BLOCK_SIZE	32
+#define CHKSUM_DIGEST_SIZE	4
+
+struct chksum_ctx {
+	u32 crc;
+};
+
+/*
+ * Steps through buffer one byte at at time, calculates reflected 
+ * crc using table.
+ */
+
+static void chksum_init(void *ctx)
+{
+	struct chksum_ctx *mctx = ctx;
+
+	mctx->crc = ~(u32)0;			/* common usage */
+}
+
+/*
+ * Setting the seed allows arbitrary accumulators and flexible XOR policy
+ * If your algorithm starts with ~0, then XOR with ~0 before you set
+ * the seed.
+ */
+static int chksum_setkey(void *ctx, const u8 *key, unsigned int keylen,
+	                  u32 *flags)
+{
+	struct chksum_ctx *mctx = ctx;
+
+	if (keylen != sizeof(mctx->crc)) {
+		if (flags)
+			*flags = CRYPTO_TFM_RES_BAD_KEY_LEN;
+		return -EINVAL;
+	}
+	mctx->crc = __cpu_to_le32(*(u32 *)key);
+	return 0;
+}
+
+static void chksum_update(void *ctx, const u8 *data, size_t length)
+{
+	struct chksum_ctx *mctx = ctx;
+	u32 mcrc;
+
+	mcrc = crc32c(mctx->crc, data, length);
+
+	mctx->crc = mcrc;
+}
+
+static void chksum_final(void *ctx, u8 *out)
+{
+	struct chksum_ctx *mctx = ctx;
+	u32 mcrc = (mctx->crc ^ ~(u32)0);
+	
+	*(u32 *)out = __le32_to_cpu(mcrc);
+}
+
+static struct crypto_alg alg = {
+	.cra_name	=	"crc32c",
+	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize	=	CHKSUM_BLOCK_SIZE,
+	.cra_ctxsize	=	sizeof(struct chksum_ctx),
+	.cra_module	=	THIS_MODULE,
+	.cra_list	=	LIST_HEAD_INIT(alg.cra_list),
+	.cra_u		=	{
+		.digest = {
+			 .dia_digestsize=	CHKSUM_DIGEST_SIZE,
+			 .dia_setkey	=	chksum_setkey,
+			 .dia_init   	= 	chksum_init,
+			 .dia_update 	=	chksum_update,
+			 .dia_final  	=	chksum_final
+		 }
+	}
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
+MODULE_AUTHOR("Clay Haapala <chaapala@cisco.com>");
+MODULE_DESCRIPTION("CRC32c (Castagnoli) calculations wrapper for lib/crc32c");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.4.orig/crypto/Kconfig linux/crypto/Kconfig
--- linux-2.6.4.orig/crypto/Kconfig	2004-03-17 15:23:06.000000000 -0600
+++ linux/crypto/Kconfig	2004-03-18 15:24:57.000000000 -0600
@@ -170,6 +170,16 @@
 	  should not be used for other purposes because of the weakness
 	  of the algorithm.
 
+config CRYPTO_CRC32C
+	tristate "CRC32c CRC algorithm"
+	depends on CRYPTO
+	select LIBCRC32C
+	help
+	  Castagnoli, et al Cyclic Redundancy-Check Algorithm.  Used
+	  by iSCSI for header and data digests and by others.
+	  See Castagnoli93.  This implementation uses lib/libcrc32c.
+          Module will be crc32c.
+
 config CRYPTO_TEST
 	tristate "Testing module"
 	depends on CRYPTO
diff -urN linux-2.6.4.orig/crypto/Makefile linux/crypto/Makefile
--- linux-2.6.4.orig/crypto/Makefile	2004-03-17 15:23:06.000000000 -0600
+++ linux/crypto/Makefile	2004-03-18 15:44:54.000000000 -0600
@@ -24,5 +24,6 @@
 obj-$(CONFIG_CRYPTO_ARC4) += arc4.o
 obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.o
 obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
+obj-$(CONFIG_CRYPTO_CRC32C) += crc32c.o
 
 obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
diff -urN linux-2.6.4.orig/crypto/tcrypt.c linux/crypto/tcrypt.c
--- linux-2.6.4.orig/crypto/tcrypt.c	2004-03-17 15:23:06.000000000 -0600
+++ linux/crypto/tcrypt.c	2004-03-18 16:36:41.000000000 -0600
@@ -61,7 +61,7 @@
 static char *check[] = {
 	"des", "md5", "des3_ede", "rot13", "sha1", "sha256", "blowfish",
 	"twofish", "serpent", "sha384", "sha512", "md4", "aes", "cast6", 
-	"arc4", "michael_mic", "deflate", NULL
+	"arc4", "michael_mic", "deflate", "crc32c", NULL
 };
 
 static void
@@ -496,6 +496,107 @@
 }
 
 static void
+test_crc32c(void)
+{
+#define NUMVEC 6
+#define VECSIZE 40
+
+	int i, j, pass;
+	u32 crc;
+	u8 b, test_vec[NUMVEC][VECSIZE];
+	static u32 vec_results[NUMVEC] = {
+		0x0e2c157f, 0xe980ebf6, 0xde74bded,
+		0xd579c862, 0xba979ad0, 0x2b29d913
+	};
+	static u32 tot_vec_results = 0x24c5d375;
+	
+	struct scatterlist sg[NUMVEC];
+	struct crypto_tfm *tfm;
+	char *fmtdata = "testing crc32c initialized to %08x: %s\n";
+#define SEEDTESTVAL 0xedcba987
+	u32 seed;
+
+	printk("\ntesting crc32c\n");
+
+	tfm = crypto_alloc_tfm("crc32c", 0);
+	if (tfm == NULL) {
+		printk("failed to load transform for crc32c\n");
+		return;
+	}
+	
+	crypto_digest_init(tfm);
+	crypto_digest_final(tfm, (u8*)&crc);
+	printk(fmtdata, crc, (crc == 0) ? "pass" : "ERROR");
+	
+	/*
+	 * stuff test_vec with known values, simple incrementing
+	 * byte values.
+	 */
+	b = 0;
+	for (i = 0; i < NUMVEC; i++) {
+		for (j = 0; j < VECSIZE; j++) 
+			test_vec[i][j] = ++b;
+		sg[i].page = virt_to_page(test_vec[i]);
+		sg[i].offset = offset_in_page(test_vec[i]);
+		sg[i].length = VECSIZE;
+	}
+
+	seed = SEEDTESTVAL;
+	(void)crypto_digest_setkey(tfm, (const u8*)&seed, sizeof(u32));
+	crypto_digest_final(tfm, (u8*)&crc);
+	printk("testing crc32c setkey returns %08x : %s\n", crc, (crc == (SEEDTESTVAL ^ ~(u32)0)) ?
+	       "pass" : "ERROR");
+	
+	printk("testing crc32c using update/final:\n");
+
+	pass = 1;		    /* assume all is well */
+	
+	for (i = 0; i < NUMVEC; i++) {
+		seed = ~(u32)0;
+		(void)crypto_digest_setkey(tfm, (const u8*)&seed, sizeof(u32));
+		crypto_digest_update(tfm, &sg[i], 1);
+		crypto_digest_final(tfm, (u8*)&crc);
+		if (crc == vec_results[i]) {
+			printk(" %08x:OK", crc);
+		} else {
+			printk(" %08x:BAD, wanted %08x\n", crc, vec_results[i]);
+			pass = 0;
+		}
+	}
+
+	printk("\ntesting crc32c using incremental accumulator:\n");
+	crc = 0;
+	for (i = 0; i < NUMVEC; i++) {
+		seed = (crc ^ ~(u32)0);
+		(void)crypto_digest_setkey(tfm, (const u8*)&seed, sizeof(u32));
+		crypto_digest_update(tfm, &sg[i], 1);
+		crypto_digest_final(tfm, (u8*)&crc);
+	}
+	if (crc == tot_vec_results) {
+		printk(" %08x:OK", crc);
+	} else {
+		printk(" %08x:BAD, wanted %08x\n", crc, tot_vec_results);
+		pass = 0;
+	}
+
+	printk("\ntesting crc32c using digest:\n");
+	seed = ~(u32)0;
+	(void)crypto_digest_setkey(tfm, (const u8*)&seed, sizeof(u32));
+	crypto_digest_digest(tfm, sg, NUMVEC, (u8*)&crc);
+	if (crc == tot_vec_results) {
+		printk(" %08x:OK", crc);
+	} else {
+		printk(" %08x:BAD, wanted %08x\n", crc, tot_vec_results);
+		pass = 0;
+	}
+	
+	printk("\n%s\n", pass ? "pass" : "ERROR");
+
+	crypto_free_tfm(tfm);
+	printk("crc32c test complete\n");
+}
+
+static void
 test_available(void)
 {
 	char **name = check;
@@ -566,7 +667,8 @@
 
 		test_hash("sha384", sha384_tv_template, SHA384_TEST_VECTORS);
 		test_hash("sha512", sha512_tv_template, SHA512_TEST_VECTORS);
-		test_deflate();		
+		test_deflate();
+		test_crc32c();
 #ifdef CONFIG_CRYPTO_HMAC
 		test_hmac("md5", hmac_md5_tv_template, HMAC_MD5_TEST_VECTORS);
 		test_hmac("sha1", hmac_sha1_tv_template, HMAC_SHA1_TEST_VECTORS);		
@@ -657,6 +759,10 @@
 		test_hash("michael_mic", michael_mic_tv_template, MICHAEL_MIC_TEST_VECTORS);
 		break;
 
+	case 18:
+		test_crc32c();
+		break;
+
 #ifdef CONFIG_CRYPTO_HMAC
 	case 100:
 		test_hmac("md5", hmac_md5_tv_template, HMAC_MD5_TEST_VECTORS);
