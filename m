Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbUCRXT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263297AbUCRXTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:19:43 -0500
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:31322 "EHLO
	rtp-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S263274AbUCRXFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:05:53 -0500
X-BrightmailFiltered: true
To: James Morris <jmorris@redhat.com>
Cc: Jouni Malinen <jkmaline@cc.hut.fi>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
References: <Xine.LNX.4.44.0403111513260.3693-100000@thoron.boston.redhat.com>
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
Date: Thu, 18 Mar 2004 17:05:44 -0600
In-Reply-To: <Xine.LNX.4.44.0403111513260.3693-100000@thoron.boston.redhat.com> (James
 Morris's message of "Thu, 11 Mar 2004 15:14:36 -0500 (EST)")
Message-ID: <yqujr7vpiwmv.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, James Morris outgrape:
> On Thu, 11 Mar 2004, Clay Haapala wrote:
> 
>> OK, so I should recode CRC32C to be a variation of digest that
>> employs a setkey() handler, right?  Should be no problem.
> 
> Give it a try and see.
> 
>> Can I get to a reasonable development environment by starting with
>> 2.6.3, and adding the patch you just sent?  Or, do I need the
>> Michael MIC patch, as well?
> 
> Yes, please apply the first two patches first.
> 
> 
> - James

I've redone the crypto crc32c implementation to make use of Jouni's
setkey() digest api.  So now crypto crc32c checksums are just another
type of digest, rather than a new CRYPTO_ALG type.

This implementation is still a wrapper for the actual computation
routine in lib/libcrc32c, per previous requests.  The patch below
includes the code under lib and crypto.  It requires Jouni's previous
patches to be applied, and was tested on 2.6.4 kernel source.

Let me know how it looks, especially if I should add further tests in
tcrypt.

Regards,
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
+	  See Castagnoli93.  This implementation uses lib/crc32c.
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
diff -urN linux-2.6.4.orig/include/linux/crc32c.h linux/include/linux/crc32c.h
--- linux-2.6.4.orig/include/linux/crc32c.h	1969-12-31 18:00:00.000000000 -0600
+++ linux/include/linux/crc32c.h	2004-03-18 15:34:18.000000000 -0600
@@ -0,0 +1,11 @@
+#ifndef _LINUX_CRC32C_H
+#define _LINUX_CRC32C_H
+
+#include <linux/types.h>
+
+extern u32 crc32c_le(u32 crc, unsigned char const *address, size_t length);
+extern u32 crc32c_be(u32 crc, unsigned char const *address, size_t length);
+
+#define crc32c(seed, data, length)  crc32c_le(seed, (unsigned char const *)data, length)
+
+#endif	/* _LINUX_CRC32C_H */
diff -urN linux-2.6.4.orig/lib/Kconfig linux/lib/Kconfig
--- linux-2.6.4.orig/lib/Kconfig	2004-03-10 20:55:33.000000000 -0600
+++ linux/lib/Kconfig	2004-03-18 16:28:42.000000000 -0600
@@ -12,6 +12,15 @@
 	  kernel tree does. Such modules that use library CRC32 functions
 	  require M here.
 
+config LIBCRC32C
+	tristate "CRC32c (Castagnoli, et al) Cyclic Redundancy-Check"
+	help
+	  This option is provided for the case where no in-kernel-tree
+	  modules require CRC32c functions, but a module built outside the
+	  kernel tree does. Such modules that use library CRC32c functions
+	  require M here.  See Castagnoli93.
+	  Module will be libcrc32c.
+
 #
 # compression support is select'ed if needed
 #
diff -urN linux-2.6.4.orig/lib/libcrc32c.c linux/lib/libcrc32c.c
--- linux-2.6.4.orig/lib/libcrc32c.c	1969-12-31 18:00:00.000000000 -0600
+++ linux/lib/libcrc32c.c	2004-03-18 16:27:54.000000000 -0600
@@ -0,0 +1,205 @@
+/* 
+ * CRC32C
+ *@Article{castagnoli-crc,
+ * author =       { Guy Castagnoli and Stefan Braeuer and Martin Herrman},
+ * title =        {{Optimization of Cyclic Redundancy-Check Codes with 24
+ *                 and 32 Parity Bits}},
+ * journal =      IEEE Transactions on Communication,
+ * year =         {1993},
+ * volume =       {41},
+ * number =       {6},
+ * pages =        {},
+ * month =        {June},
+ *}
+ * Used by the iSCSI driver, possibly others, and derived from the
+ * the iscsi-crc.c module of the linux-iscsi driver at
+ * http://linux-iscsi.sourceforge.net.
+ *
+ * Following the example of lib/crc32, this function is intended to be
+ * flexible and useful for all users.  Modules that currently have their
+ * own crc32c, but hopefully may be able to use this one are:
+ *  net/sctp (please add all your doco to here if you change to
+ *            use this one!)
+ *  <endoflist>
+ *
+ * Copyright (c) 2003 Cisco Systems, Inc.
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option) 
+ * any later version.
+ *
+ */
+#include <linux/crc32c.h>
+#include <linux/module.h>
+#include <asm/byteorder.h>
+
+MODULE_AUTHOR("Clay Haapala <chaapala@cisco.com>");
+MODULE_DESCRIPTION("CRC32c (Castagnoli) calculations");
+MODULE_LICENSE("GPL");
+
+#if __GNUC__ >= 3	/* 2.x has "attribute", but only 3.0 has "pure */
+#define attribute(x) __attribute__(x)
+#else
+#define attribute(x)
+#endif
+
+#define CRC32C_POLY_BE 0x1EDC6F41
+#define CRC32C_POLY_LE 0x82F63B78
+
+#ifndef CRC_LE_BITS 
+# define CRC_LE_BITS 8
+#endif
+
+
+/*
+ * Haven't generated a big-endian table yet, but the bit-wise version
+ * should at least work.
+ */
+#if defined CRC_BE_BITS && CRC_BE_BITS != 1
+#undef CRC_BE_BITS
+#endif
+#ifndef CRC_BE_BITS
+# define CRC_BE_BITS 1
+#endif
+
+EXPORT_SYMBOL(crc32c_le);
+
+#if CRC_LE_BITS == 1
+/*
+ * Compute things bit-wise, as done in crc32.c.  We could share the tight 
+ * loop below with crc32 and vary the POLY if we don't find value in terms
+ * of space and maintainability in keeping the two modules separate.
+ */
+u32 attribute((pure))
+crc32c_le(u32 crc, unsigned char const *p, size_t len)
+{
+	int i;
+	while (len--) {
+		crc ^= *p++;
+		for (i = 0; i < 8; i++)
+			crc = (crc >> 1) ^ ((crc & 1) ? CRC32C_POLY_LE : 0);
+	}
+	return crc;
+}
+#else
+
+/*
+ * This is the CRC-32C table
+ * Generated with:
+ * width = 32 bits
+ * poly = 0x1EDC6F41
+ * reflect input bytes = true
+ * reflect output bytes = true
+ */
+
+static u32 crc32c_table[256] = {
+	0x00000000L, 0xF26B8303L, 0xE13B70F7L, 0x1350F3F4L,
+	0xC79A971FL, 0x35F1141CL, 0x26A1E7E8L, 0xD4CA64EBL,
+	0x8AD958CFL, 0x78B2DBCCL, 0x6BE22838L, 0x9989AB3BL,
+	0x4D43CFD0L, 0xBF284CD3L, 0xAC78BF27L, 0x5E133C24L,
+	0x105EC76FL, 0xE235446CL, 0xF165B798L, 0x030E349BL,
+	0xD7C45070L, 0x25AFD373L, 0x36FF2087L, 0xC494A384L,
+	0x9A879FA0L, 0x68EC1CA3L, 0x7BBCEF57L, 0x89D76C54L,
+	0x5D1D08BFL, 0xAF768BBCL, 0xBC267848L, 0x4E4DFB4BL,
+	0x20BD8EDEL, 0xD2D60DDDL, 0xC186FE29L, 0x33ED7D2AL,
+	0xE72719C1L, 0x154C9AC2L, 0x061C6936L, 0xF477EA35L,
+	0xAA64D611L, 0x580F5512L, 0x4B5FA6E6L, 0xB93425E5L,
+	0x6DFE410EL, 0x9F95C20DL, 0x8CC531F9L, 0x7EAEB2FAL,
+	0x30E349B1L, 0xC288CAB2L, 0xD1D83946L, 0x23B3BA45L,
+	0xF779DEAEL, 0x05125DADL, 0x1642AE59L, 0xE4292D5AL,
+	0xBA3A117EL, 0x4851927DL, 0x5B016189L, 0xA96AE28AL,
+	0x7DA08661L, 0x8FCB0562L, 0x9C9BF696L, 0x6EF07595L,
+	0x417B1DBCL, 0xB3109EBFL, 0xA0406D4BL, 0x522BEE48L,
+	0x86E18AA3L, 0x748A09A0L, 0x67DAFA54L, 0x95B17957L,
+	0xCBA24573L, 0x39C9C670L, 0x2A993584L, 0xD8F2B687L,
+	0x0C38D26CL, 0xFE53516FL, 0xED03A29BL, 0x1F682198L,
+	0x5125DAD3L, 0xA34E59D0L, 0xB01EAA24L, 0x42752927L,
+	0x96BF4DCCL, 0x64D4CECFL, 0x77843D3BL, 0x85EFBE38L,
+	0xDBFC821CL, 0x2997011FL, 0x3AC7F2EBL, 0xC8AC71E8L,
+	0x1C661503L, 0xEE0D9600L, 0xFD5D65F4L, 0x0F36E6F7L,
+	0x61C69362L, 0x93AD1061L, 0x80FDE395L, 0x72966096L,
+	0xA65C047DL, 0x5437877EL, 0x4767748AL, 0xB50CF789L,
+	0xEB1FCBADL, 0x197448AEL, 0x0A24BB5AL, 0xF84F3859L,
+	0x2C855CB2L, 0xDEEEDFB1L, 0xCDBE2C45L, 0x3FD5AF46L,
+	0x7198540DL, 0x83F3D70EL, 0x90A324FAL, 0x62C8A7F9L,
+	0xB602C312L, 0x44694011L, 0x5739B3E5L, 0xA55230E6L,
+	0xFB410CC2L, 0x092A8FC1L, 0x1A7A7C35L, 0xE811FF36L,
+	0x3CDB9BDDL, 0xCEB018DEL, 0xDDE0EB2AL, 0x2F8B6829L,
+	0x82F63B78L, 0x709DB87BL, 0x63CD4B8FL, 0x91A6C88CL,
+	0x456CAC67L, 0xB7072F64L, 0xA457DC90L, 0x563C5F93L,
+	0x082F63B7L, 0xFA44E0B4L, 0xE9141340L, 0x1B7F9043L,
+	0xCFB5F4A8L, 0x3DDE77ABL, 0x2E8E845FL, 0xDCE5075CL,
+	0x92A8FC17L, 0x60C37F14L, 0x73938CE0L, 0x81F80FE3L,
+	0x55326B08L, 0xA759E80BL, 0xB4091BFFL, 0x466298FCL,
+	0x1871A4D8L, 0xEA1A27DBL, 0xF94AD42FL, 0x0B21572CL,
+	0xDFEB33C7L, 0x2D80B0C4L, 0x3ED04330L, 0xCCBBC033L,
+	0xA24BB5A6L, 0x502036A5L, 0x4370C551L, 0xB11B4652L,
+	0x65D122B9L, 0x97BAA1BAL, 0x84EA524EL, 0x7681D14DL,
+	0x2892ED69L, 0xDAF96E6AL, 0xC9A99D9EL, 0x3BC21E9DL,
+	0xEF087A76L, 0x1D63F975L, 0x0E330A81L, 0xFC588982L,
+	0xB21572C9L, 0x407EF1CAL, 0x532E023EL, 0xA145813DL,
+	0x758FE5D6L, 0x87E466D5L, 0x94B49521L, 0x66DF1622L,
+	0x38CC2A06L, 0xCAA7A905L, 0xD9F75AF1L, 0x2B9CD9F2L,
+	0xFF56BD19L, 0x0D3D3E1AL, 0x1E6DCDEEL, 0xEC064EEDL,
+	0xC38D26C4L, 0x31E6A5C7L, 0x22B65633L, 0xD0DDD530L,
+	0x0417B1DBL, 0xF67C32D8L, 0xE52CC12CL, 0x1747422FL,
+	0x49547E0BL, 0xBB3FFD08L, 0xA86F0EFCL, 0x5A048DFFL,
+	0x8ECEE914L, 0x7CA56A17L, 0x6FF599E3L, 0x9D9E1AE0L,
+	0xD3D3E1ABL, 0x21B862A8L, 0x32E8915CL, 0xC083125FL,
+	0x144976B4L, 0xE622F5B7L, 0xF5720643L, 0x07198540L,
+	0x590AB964L, 0xAB613A67L, 0xB831C993L, 0x4A5A4A90L,
+	0x9E902E7BL, 0x6CFBAD78L, 0x7FAB5E8CL, 0x8DC0DD8FL,
+	0xE330A81AL, 0x115B2B19L, 0x020BD8EDL, 0xF0605BEEL,
+	0x24AA3F05L, 0xD6C1BC06L, 0xC5914FF2L, 0x37FACCF1L,
+	0x69E9F0D5L, 0x9B8273D6L, 0x88D28022L, 0x7AB90321L,
+	0xAE7367CAL, 0x5C18E4C9L, 0x4F48173DL, 0xBD23943EL,
+	0xF36E6F75L, 0x0105EC76L, 0x12551F82L, 0xE03E9C81L,
+	0x34F4F86AL, 0xC69F7B69L, 0xD5CF889DL, 0x27A40B9EL,
+	0x79B737BAL, 0x8BDCB4B9L, 0x988C474DL, 0x6AE7C44EL,
+	0xBE2DA0A5L, 0x4C4623A6L, 0x5F16D052L, 0xAD7D5351L
+};
+
+/*
+ * Steps through buffer one byte at at time, calculates reflected 
+ * crc using table.
+ */
+
+u32 attribute((pure))
+crc32c_le(u32 seed, unsigned char const *data, size_t length)
+{
+	u32 crc = __cpu_to_le32(seed);
+	
+	while (length--)
+		crc =
+		    crc32c_table[(crc ^ *data++) & 0xFFL] ^ (crc >> 8);
+
+	return __le32_to_cpu(crc);
+}
+
+#endif	/* CRC_LE_BITS == 8 */
+
+/*EXPORT_SYMBOL(crc32c_be);*/
+
+#if CRC_BE_BITS == 1
+u32 attribute((pure))
+crc32_be(u32 crc, unsigned char const *p, size_t len)
+{
+	int i;
+	while (len--) {
+		crc ^= *p++ << 24;
+		for (i = 0; i < 8; i++)
+			crc =
+			    (crc << 1) ^ ((crc & 0x80000000) ? CRC32C_POLY_BE :
+					  0);
+	}
+	return crc;
+}
+#endif
+
+/*
+ * Unit test
+ *
+ * A small unit test suite is implemented as part of the crypto suite.
+ * Select CRYPTO_CRC32C and use the tcrypt module to run the tests.
+ */
diff -urN linux-2.6.4.orig/lib/Makefile linux/lib/Makefile
--- linux-2.6.4.orig/lib/Makefile	2004-03-10 20:55:21.000000000 -0600
+++ linux/lib/Makefile	2004-03-18 15:59:55.000000000 -0600
@@ -16,6 +16,7 @@
 endif
 
 obj-$(CONFIG_CRC32)	+= crc32.o
+obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
