Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUBCQ7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 11:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUBCQ7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 11:59:35 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:18475 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S266025AbUBCQ61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 11:58:27 -0500
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, mpm@selenic.com
Subject: [PATCH 2.6.1] Add CRC32C chksums to crypto and lib routines
References: <Xine.LNX.4.44.0401191632001.2019-100000@thoron.boston.redhat.com>
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
Date: Tue, 03 Feb 2004 10:58:13 -0600
In-Reply-To: <Xine.LNX.4.44.0401191632001.2019-100000@thoron.boston.redhat.com> (James
 Morris's message of "Mon, 19 Jan 2004 16:33:12 -0500 (EST)")
Message-ID: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

On Mon, 19 Jan 2004, James Morris verbalised:
> On Mon, 19 Jan 2004, Clay Haapala wrote:
> 
>> In other email, Matt Mackall suggested a slightly different
>> integration with the kernel that would allow more general usage of
>> the CRC32C.  His suggestion was to put the implementation under
>> /lib, next to the crc32 routines, and make the crypto routine a
>> wrapper that calls it.  Selecting the CRYPTO_CRC32C module would
>> SELECT the lib CRC32C module, in other words.
>> 
>> The benefit of this would be to allow easy usage by other routines
>> (with no premption side-affects, a concern Matt has) while still
>> being there for routines that process scatterlist.  And the
>> table/code is still in one place.
>> 
>> Patch to follow in a day or two, after I can test it.
>> Implementation was simple.
> 
> Sounds good -- the inflate/deflate algorithms do this as well.
> 
> 
> - James

A long "day or two", but here's a patch that implements the CRC32C
under lib, and has the crypto implementation as a wrapper for it.  The
crypto module is "crc32c.ko", and the lib module is "libcrc32c.ko".

While further work could meld the lib/crc32 and lib/crc32c routines to
vary by only the polynomial, this patch keeps them entirely separate.
I added an optional bit-wise routine, though, which doesn't require
the table, though (set CRC32C_LE_BITS = 1). The bit-wise is slower on
x86, but I agree, Matt, that on some architectures it may rock.

If this patch looks good, I'd like it accepted so we can submit code
iSCSI driver code that makes use of it.  This may be a good time,
since the crypto SHA code is getting a little scrutiny right now.

Regards,
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
             Minnesota, a quite agreeable state.  Lately,
             Celsius and Fahrenheit have tended to agree.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=k3.patch
Content-Description: Patch adds CRC32C lib and crypto modules for generic use

diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/crypto/Kconfig linux/crypto/Kconfig
--- linux-2.6.1.orig/crypto/Kconfig	Fri Jan  9 01:00:03 2004
+++ linux/crypto/Kconfig	Fri Jan 30 10:45:42 2004
@@ -22,6 +22,16 @@
 	help
 	  These are 'Null' algorithms, used by IPsec, which do nothing.
 
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
 config CRYPTO_MD4
 	tristate "MD4 digest algorithm"
 	depends on CRYPTO
diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/crypto/Makefile linux/crypto/Makefile
--- linux-2.6.1.orig/crypto/Makefile	Fri Jan  9 01:00:04 2004
+++ linux/crypto/Makefile	Fri Jan 30 10:46:03 2004
@@ -4,11 +4,12 @@
 
 proc-crypto-$(CONFIG_PROC_FS) = proc.o
 
-obj-$(CONFIG_CRYPTO) += api.o cipher.o digest.o compress.o \
+obj-$(CONFIG_CRYPTO) += api.o cipher.o digest.o compress.o chksum.o \
 			$(proc-crypto-y)
 
 obj-$(CONFIG_CRYPTO_HMAC) += hmac.o
 obj-$(CONFIG_CRYPTO_NULL) += crypto_null.o
+obj-$(CONFIG_CRYPTO_CRC32C) += crc32c.o
 obj-$(CONFIG_CRYPTO_MD4) += md4.o
 obj-$(CONFIG_CRYPTO_MD5) += md5.o
 obj-$(CONFIG_CRYPTO_SHA1) += sha1.o
diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/crypto/api.c linux/crypto/api.c
--- linux-2.6.1.orig/crypto/api.c	Fri Jan  9 01:00:04 2004
+++ linux/crypto/api.c	Mon Jan 12 10:33:59 2004
@@ -68,6 +68,9 @@
 	case CRYPTO_ALG_TYPE_COMPRESS:
 		return crypto_init_compress_flags(tfm, flags);
 	
+	case CRYPTO_ALG_TYPE_CHKSUM:
+		return crypto_init_chksum_flags(tfm, flags);
+		
 	default:
 		break;
 	}
@@ -88,6 +91,9 @@
 	case CRYPTO_ALG_TYPE_COMPRESS:
 		return crypto_init_compress_ops(tfm);
 	
+	case CRYPTO_ALG_TYPE_CHKSUM:
+		return crypto_init_chksum_ops(tfm);
+		
 	default:
 		break;
 	}
@@ -111,6 +117,10 @@
 		crypto_exit_compress_ops(tfm);
 		break;
 	
+	case CRYPTO_ALG_TYPE_CHKSUM:
+		crypto_exit_chksum_ops(tfm);
+		break;
+		
 	default:
 		BUG();
 		
diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/crypto/chksum.c linux/crypto/chksum.c
--- linux-2.6.1.orig/crypto/chksum.c	Wed Dec 31 18:00:00 1969
+++ linux/crypto/chksum.c	Mon Jan 12 10:33:59 2004
@@ -0,0 +1,89 @@
+/*
+ * Cryptographic API.
+ *
+ * Chksum/CRC operations.
+ *
+ * Copyright (c) 2003 Clay Haapala (chaapala@cisco.com)
+ *   cribbed from digest code (c) by James Morris <jmorris@intercode.com.au>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option) 
+ * any later version.
+ *
+ */
+#include <linux/crypto.h>
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/highmem.h>
+#include <asm/scatterlist.h>
+#include "internal.h"
+
+static void init(struct crypto_tfm *tfm)
+{
+	tfm->__crt_alg->cra_chksum.cha_init(crypto_tfm_ctx(tfm));
+}
+
+static void setseed(struct crypto_tfm *tfm, const u32 seed)
+{
+	tfm->__crt_alg->cra_chksum.cha_setseed(crypto_tfm_ctx(tfm), seed);
+}
+
+static void update(struct crypto_tfm *tfm,
+                   struct scatterlist *sg, unsigned int nsg)
+{
+	unsigned int i;
+	
+	for (i = 0; i < nsg; i++) {
+		char *p = crypto_kmap(sg[i].page, 0) + sg[i].offset;
+		tfm->__crt_alg->cra_chksum.cha_update(crypto_tfm_ctx(tfm),
+		                                      p, sg[i].length);
+		crypto_kunmap(p, 0);
+		crypto_yield(tfm);
+	}
+}
+
+static void final(struct crypto_tfm *tfm, u32 *out)
+{
+	tfm->__crt_alg->cra_chksum.cha_final(crypto_tfm_ctx(tfm), out);
+}
+
+static void digest(struct crypto_tfm *tfm,
+                   struct scatterlist *sg, unsigned int nsg, u32 *out)
+{
+	unsigned int i;
+
+	tfm->crt_chksum.cht_init(tfm);
+		
+	for (i = 0; i < nsg; i++) {
+		char *p = crypto_kmap(sg[i].page, 0) + sg[i].offset;
+		tfm->__crt_alg->cra_chksum.cha_update(crypto_tfm_ctx(tfm),
+		                                      p, sg[i].length);
+		crypto_kunmap(p, 0);
+		crypto_yield(tfm);
+	}
+	crypto_chksum_final(tfm, out);
+}
+
+int crypto_init_chksum_flags(struct crypto_tfm *tfm, u32 flags)
+{
+	return flags ? -EINVAL : 0;
+}
+
+int crypto_init_chksum_ops(struct crypto_tfm *tfm)
+{
+	struct chksum_tfm *ops = &tfm->crt_chksum;
+	
+	ops->cht_init	= init;
+	ops->cht_setseed = setseed;
+	ops->cht_update	= update;
+	ops->cht_final	= final;
+	ops->cht_digest	= digest;
+
+	return 0;
+}
+
+void crypto_exit_chksum_ops(struct crypto_tfm *tfm)
+{
+	return;
+}
diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/crypto/crc32c.c linux/crypto/crc32c.c
--- linux-2.6.1.orig/crypto/crc32c.c	Wed Dec 31 18:00:00 1969
+++ linux/crypto/crc32c.c	Fri Jan 16 14:27:35 2004
@@ -0,0 +1,103 @@
+/* 
+ * Cryptographic API.
+ *
+ * CRC32C chksum
+ *
+ * This file is a wrapper to invoke the lib/crc32c routines.
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
+#define CHKSUM_DIGEST_SIZE	32
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
+static void chksum_setseed(void *ctx, const u32 seed)
+{
+	struct chksum_ctx *mctx = ctx;
+
+	mctx->crc = __cpu_to_le32(seed);
+}
+
+static void chksum_update(void *ctx, u8 const *data, size_t length)
+{
+	struct chksum_ctx *mctx = ctx;
+	u32 mcrc;
+
+	mcrc = crc32c(mctx->crc, data, length);
+
+	mctx->crc = mcrc;
+}
+
+static void chksum_final(void *ctx, u32 *out)
+{
+	struct chksum_ctx *mctx = ctx;
+	u32 mcrc = (mctx->crc ^ ~(u32)0);
+	
+	*out = __le32_to_cpu(mcrc);
+}
+
+static struct crypto_alg alg = {
+	.cra_name	=	"crc32c",
+	.cra_flags	=	CRYPTO_ALG_TYPE_CHKSUM,
+	.cra_blocksize	=	CHKSUM_BLOCK_SIZE,
+	.cra_ctxsize	=	sizeof(struct chksum_ctx),
+	.cra_module	=	THIS_MODULE,
+	.cra_list	=	LIST_HEAD_INIT(alg.cra_list),
+	.cra_u		=	{
+		.chksum = {
+			 .cha_digestsize=	CHKSUM_DIGEST_SIZE,
+			 .cha_init   	= 	chksum_init,
+			 .cha_setseed	=	chksum_setseed,
+			 .cha_update 	=	chksum_update,
+			 .cha_final  	=	chksum_final
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
+MODULE_LICENSE("GPL and additional rights");
diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/crypto/internal.h linux/crypto/internal.h
--- linux-2.6.1.orig/crypto/internal.h	Fri Jan  9 00:59:04 2004
+++ linux/crypto/internal.h	Mon Jan 12 10:33:59 2004
@@ -79,14 +79,17 @@
 int crypto_init_digest_flags(struct crypto_tfm *tfm, u32 flags);
 int crypto_init_cipher_flags(struct crypto_tfm *tfm, u32 flags);
 int crypto_init_compress_flags(struct crypto_tfm *tfm, u32 flags);
+int crypto_init_chksum_flags(struct crypto_tfm *tfm, u32 flags);
 
 int crypto_init_digest_ops(struct crypto_tfm *tfm);
 int crypto_init_cipher_ops(struct crypto_tfm *tfm);
 int crypto_init_compress_ops(struct crypto_tfm *tfm);
+int crypto_init_chksum_ops(struct crypto_tfm *tfm);
 
 void crypto_exit_digest_ops(struct crypto_tfm *tfm);
 void crypto_exit_cipher_ops(struct crypto_tfm *tfm);
 void crypto_exit_compress_ops(struct crypto_tfm *tfm);
+void crypto_exit_chksum_ops(struct crypto_tfm *tfm);
 
 #endif	/* _CRYPTO_INTERNAL_H */
 
diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/crypto/tcrypt.c linux/crypto/tcrypt.c
--- linux-2.6.1.orig/crypto/tcrypt.c	Fri Jan  9 00:59:56 2004
+++ linux/crypto/tcrypt.c	Wed Jan 14 11:43:12 2004
@@ -61,7 +61,7 @@
 static char *check[] = {
 	"des", "md5", "des3_ede", "rot13", "sha1", "sha256", "blowfish",
 	"twofish", "serpent", "sha384", "sha512", "md4", "aes", "cast6", 
-	"deflate", NULL
+	"deflate", "crc32c", NULL
 };
 
 static void
@@ -492,6 +492,102 @@
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
+	char *fmtdata = "testing crc32c initted to %08x: %s\n";
+#define SEEDTESTVAL 0xedcba987
+
+	printk("\ntesting crc32c\n");
+
+	tfm = crypto_alloc_tfm("crc32c", 0);
+	if (tfm == NULL) {
+		printk("failed to load transform for crc32c\n");
+		return;
+	}
+	
+	crypto_chksum_init(tfm);
+	crypto_chksum_final(tfm, &crc);
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
+	crypto_chksum_setseed(tfm, SEEDTESTVAL);
+	crypto_chksum_final(tfm, &crc);
+	printk("testing crc32c setseed returns %08x : %s\n", crc, (crc == (SEEDTESTVAL ^ ~(u32)0)) ?
+	       "pass" : "ERROR");
+	
+	printk("testing crc32c using update/final:\n");
+
+	pass = 1;		    /* assume all is well */
+	
+	for (i = 0; i < NUMVEC; i++) {
+		crypto_chksum_setseed(tfm, ~(u32)0);
+		crypto_chksum_update(tfm, &sg[i], 1);
+		crypto_chksum_final(tfm, &crc);
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
+		crypto_chksum_setseed(tfm, (crc ^ ~(u32)0));
+		crypto_chksum_update(tfm, &sg[i], 1);
+		crypto_chksum_final(tfm, &crc);
+	}
+	if (crc == tot_vec_results) {
+		printk(" %08x:OK", crc);
+	} else {
+		printk(" %08x:BAD, wanted %08x\n", crc, tot_vec_results);
+		pass = 0;
+	}
+
+	printk("\ntesting crc32c using digest:\n");
+	crypto_chksum_setseed(tfm, ~(u32)0);
+	crypto_chksum_digest(tfm, sg, NUMVEC, &crc);
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
@@ -558,7 +654,8 @@
 
 		test_hash("sha384", sha384_tv_template, SHA384_TEST_VECTORS);
 		test_hash("sha512", sha512_tv_template, SHA512_TEST_VECTORS);
-		test_deflate();		
+		test_deflate();
+		test_crc32c();
 #ifdef CONFIG_CRYPTO_HMAC
 		test_hmac("md5", hmac_md5_tv_template, HMAC_MD5_TEST_VECTORS);
 		test_hmac("sha1", hmac_sha1_tv_template, HMAC_SHA1_TEST_VECTORS);		
@@ -638,6 +735,10 @@
 		test_cipher ("cast6", MODE_ECB, DECRYPT, cast6_dec_tv_template, CAST6_DEC_TEST_VECTORS);
 		break;
 
+	case 16:
+		test_crc32c();
+		break;
+
 #ifdef CONFIG_CRYPTO_HMAC
 	case 100:
 		test_hmac("md5", hmac_md5_tv_template, HMAC_MD5_TEST_VECTORS);
diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/lib/Kconfig linux/lib/Kconfig
--- linux-2.6.1.orig/lib/Kconfig	Fri Jan  9 00:59:44 2004
+++ linux/lib/Kconfig	Fri Jan 30 10:46:38 2004
@@ -12,6 +12,14 @@
 	  kernel tree does. Such modules that use library CRC32 functions
 	  require M here.
 
+config LIBCRC32C
+	tristate "CRC32c (Castagnoli, et al) Cyclic Redundancy-Check"
+	help
+	  This option is provided for the case where no in-kernel-tree
+	  modules require CRC32c functions, but a module built outside the
+	  kernel tree does. Such modules that use library CRC32c functions
+	  require M here.  See Castagnoli93.
+
 #
 # compression support is select'ed if needed
 #
diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/lib/Makefile linux/lib/Makefile
--- linux-2.6.1.orig/lib/Makefile	Fri Jan  9 00:59:06 2004
+++ linux/lib/Makefile	Fri Jan 30 10:46:58 2004
@@ -15,6 +15,7 @@
 endif
 
 obj-$(CONFIG_CRC32)	+= crc32.o
+obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/lib/libcrc32c.c linux/lib/libcrc32c.c
--- linux-2.6.1.orig/lib/libcrc32c.c	Wed Dec 31 18:00:00 1969
+++ linux/lib/libcrc32c.c	Mon Feb  2 17:00:07 2004
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
+MODULE_LICENSE("GPL and additional rights");
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
+#ifdef CRC_BE_BITS
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
diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/include/linux/crc32c.h linux/include/linux/crc32c.h
--- linux-2.6.1.orig/include/linux/crc32c.h	Wed Dec 31 18:00:00 1969
+++ linux/include/linux/crc32c.h	Mon Feb  2 16:33:20 2004
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
diff -urN --exclude '*.ko' --exclude '*.mod.*' --exclude '*~' --exclude '*.o*' --exclude '.*' --exclude '*.cmd' --exclude drivers linux-2.6.1.orig/include/linux/crypto.h linux/include/linux/crypto.h
--- linux-2.6.1.orig/include/linux/crypto.h	Fri Jan  9 00:59:19 2004
+++ linux/include/linux/crypto.h	Wed Jan 14 11:26:39 2004
@@ -30,7 +30,7 @@
 #define CRYPTO_ALG_TYPE_CIPHER		0x00000001
 #define CRYPTO_ALG_TYPE_DIGEST		0x00000002
 #define CRYPTO_ALG_TYPE_COMPRESS	0x00000004
-
+#define CRYPTO_ALG_TYPE_CHKSUM		0x00000008
 /*
  * Transform masks and values (for crt_flags).
  */
@@ -87,9 +87,18 @@
 	                      u8 *dst, unsigned int *dlen);
 };
 
+struct chksum_alg {
+	unsigned int cha_digestsize;
+	void (*cha_init)(void *ctx);
+	void (*cha_setseed)(void *ctx, const u32 seed);
+	void (*cha_update)(void *ctx, const u8 *data, unsigned int len);
+	void (*cha_final)(void *ctx, u32 *out);
+};
+
 #define cra_cipher	cra_u.cipher
 #define cra_digest	cra_u.digest
 #define cra_compress	cra_u.compress
+#define cra_chksum    cra_u.chksum
 
 struct crypto_alg {
 	struct list_head cra_list;
@@ -102,6 +111,7 @@
 		struct cipher_alg cipher;
 		struct digest_alg digest;
 		struct compress_alg compress;
+		struct chksum_alg chksum;
 	} cra_u;
 	
 	struct module *cra_module;
@@ -171,9 +181,23 @@
 	                      u8 *dst, unsigned int *dlen);
 };
 
+/*
+ * Setting the seed allows arbitrary accumulators and flexible XOR policy
+ */
+struct chksum_tfm {
+	void (*cht_init)(struct crypto_tfm *tfm); /* inits to ~0 */
+	void (*cht_setseed)(struct crypto_tfm *tfm, const u32 seed);
+	void (*cht_update)(struct crypto_tfm *tfm,
+			   struct scatterlist *sg, unsigned int nsg);
+	void (*cht_final)(struct crypto_tfm *tfm, u32 *out);
+	void (*cht_digest)(struct crypto_tfm *tfm, struct scatterlist *sg,
+			   unsigned int nsg, u32 *out);
+};
+
 #define crt_cipher	crt_u.cipher
 #define crt_digest	crt_u.digest
 #define crt_compress	crt_u.compress
+#define crt_chksum  crt_u.chksum
 
 struct crypto_tfm {
 
@@ -183,6 +207,7 @@
 		struct cipher_tfm cipher;
 		struct digest_tfm digest;
 		struct compress_tfm compress;
+		struct chksum_tfm chksum;
 	} crt_u;
 	
 	struct crypto_alg *__crt_alg;
@@ -357,6 +382,49 @@
 	return tfm->crt_compress.cot_decompress(tfm, src, slen, dst, dlen);
 }
 
+static inline void crypto_chksum_init(struct crypto_tfm *tfm)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CHKSUM);
+	tfm->crt_chksum.cht_init(tfm);
+}
+
+/*
+ * If your algorithm normally inits with ~0, then you
+ * must XOR your seed with ~0 before calling setseed().
+ */
+static inline void crypto_chksum_setseed(struct crypto_tfm *tfm,
+					 const u32 seed)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CHKSUM);
+	tfm->crt_chksum.cht_setseed(tfm, seed);
+}
+
+static inline void crypto_chksum_update(struct crypto_tfm *tfm,
+					struct scatterlist *sg,
+					unsigned int nsg)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CHKSUM);
+	tfm->crt_chksum.cht_update(tfm, sg, nsg);
+}
+
+/*
+ * This function will XOR the results with ~0, so take that into
+ * account.
+ */
+static inline void c
--=-=-=--
