Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbUKHUup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbUKHUup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 15:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbUKHUup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:50:45 -0500
Received: from smtp.wp.pl ([212.77.101.160]:29857 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S261216AbUKHUuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:50:19 -0500
From: Zbigniew Szmek <zjedrzejewski-szmek@wp.pl>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] make crypto modular
Date: Mon, 8 Nov 2004 21:49:54 +0100
User-Agent: KMail/1.7.1
Cc: Zbigniew Szmek <zjedrzejewski-szmek@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411082149.54723.zjedrzejewski-szmek@wp.pl>
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO(Body=1 Fuz1=1 Fuz2=2) AS2=YES(1.000000) AS3=NO AS4=NO                         
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cryptoapi can be modular, so why not?
This patch does the following:
1. Change Kconfig option CRYPTO to tristate
2. Add __exit functions to crypto/api.c and crypto/proc.c
3. Change crypto/api.c:init_crypto() from void to int
4. Change crypto/Makefile to link hmac.o as part 
   of the new crypto.ko module. 
   
   hmac.c could be compiled as a seperate module, if not for the fact,
   that sizeof(struct digest_tfm) depends on CONFIG_CRYPTO_HMAC.
   Linking them together ensures that there is no mismatch. If the user
   compiles crypto.ko without HMAC, and then compiles another module
   with HMAC, (for example ah4.ko), it will correctly fail with
   "ah4: Unknown symbol crypto_hmac_init".

When CONFIG_CRYPTO=y the code generated should be identical,
apart from point 3. above. When CONFIG_CRYPTO=m 
size of crypto/crypto.ko is 15k.

The patch is against 2.6.10-rc1-mm1, applies cleanly to 2.6.10-rc1 and
to 2.6.7 with two offsets.

 Kconfig    |    2 +-
 Makefile   |    9 +++++----
 api.c      |   14 +++++++++++---
 hmac.c     |    5 +++--
 internal.h |    7 ++++---
 proc.c     |   15 +++++++++++++--
 6 files changed, 37 insertions(+), 15 deletions(-)


diff -rupN 2610rc1mm1.um/crypto.modular/api.c 2610rc1mm1.um/crypto/api.c
--- 2610rc1mm1.um/crypto.modular/api.c	2004-11-07 18:41:35.000000000 +0100
+++ 2610rc1mm1.um/crypto/api.c	2004-11-08 12:01:21.000000000 +0100
@@ -220,11 +220,19 @@ int crypto_alg_available(const char *nam
 static int __init init_crypto(void)
 {
 	printk(KERN_INFO "Initializing Cryptographic API\n");
-	crypto_init_proc();
-	return 0;
+	return crypto_init_proc();
 }
 
-__initcall(init_crypto);
+static void __exit fini_crypto(void)
+{
+	printk(KERN_INFO "Destroying Cryptographic API\n");
+	crypto_fini_proc();
+}
+
+module_init(init_crypto);
+module_exit(fini_crypto);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cryptographic API");
 
 EXPORT_SYMBOL_GPL(crypto_register_alg);
 EXPORT_SYMBOL_GPL(crypto_unregister_alg);
diff -rupN 2610rc1mm1.um/crypto.modular/hmac.c 2610rc1mm1.um/crypto/hmac.c
--- 2610rc1mm1.um/crypto.modular/hmac.c	2004-11-07 18:41:35.000000000 +0100
+++ 2610rc1mm1.um/crypto/hmac.c	2004-11-08 11:56:54.000000000 +0100
@@ -49,8 +49,7 @@ int crypto_alloc_hmac_block(struct crypt
 
 void crypto_free_hmac_block(struct crypto_tfm *tfm)
 {
-	if (tfm->crt_digest.dit_hmac_block)
-		kfree(tfm->crt_digest.dit_hmac_block);
+	kfree(tfm->crt_digest.dit_hmac_block);
 }
 
 void crypto_hmac_init(struct crypto_tfm *tfm, u8 *key, unsigned int *keylen)
@@ -132,3 +131,5 @@ EXPORT_SYMBOL_GPL(crypto_hmac_update);
 EXPORT_SYMBOL_GPL(crypto_hmac_final);
 EXPORT_SYMBOL_GPL(crypto_hmac);
 
+EXPORT_SYMBOL_GPL(crypto_alloc_hmac_block);
+EXPORT_SYMBOL_GPL(crypto_free_hmac_block);
diff -rupN 2610rc1mm1.um/crypto.modular/internal.h 2610rc1mm1.um/crypto/internal.h
--- 2610rc1mm1.um/crypto.modular/internal.h	2004-11-07 18:41:35.000000000 +0100
+++ 2610rc1mm1.um/crypto/internal.h	2004-11-08 11:58:13.000000000 +0100
@@ -70,10 +70,11 @@ static inline void crypto_free_hmac_bloc
 #endif
 
 #ifdef CONFIG_PROC_FS
-void __init crypto_init_proc(void);
+int __init crypto_init_proc(void);
+void __exit crypto_fini_proc(void);
 #else
-static inline void crypto_init_proc(void)
-{ }
+static inline int crypto_init_proc(void){ }
+static inline void crypto_fini_proc(void){ }
 #endif
 
 int crypto_init_digest_flags(struct crypto_tfm *tfm, u32 flags);
diff -rupN 2610rc1mm1.um/crypto.modular/Kconfig 2610rc1mm1.um/crypto/Kconfig
--- 2610rc1mm1.um/crypto.modular/Kconfig	2004-11-07 18:41:35.000000000 +0100
+++ 2610rc1mm1.um/crypto/Kconfig	2004-11-08 11:05:35.000000000 +0100
@@ -5,7 +5,7 @@
 menu "Cryptographic options"
 
 config CRYPTO
-	bool "Cryptographic API"
+	tristate "Cryptographic API"
 	help
 	  This option provides the core Cryptographic API.
 
diff -rupN 2610rc1mm1.um/crypto.modular/Makefile 2610rc1mm1.um/crypto/Makefile
--- 2610rc1mm1.um/crypto.modular/Makefile	2004-11-07 18:41:35.000000000 +0100
+++ 2610rc1mm1.um/crypto/Makefile	2004-11-08 11:44:52.000000000 +0100
@@ -2,12 +2,13 @@
 # Cryptographic API
 #
 
-proc-crypto-$(CONFIG_PROC_FS) = proc.o
+obj-$(CONFIG_CRYPTO) += crypto.o
 
-obj-$(CONFIG_CRYPTO) += api.o scatterwalk.o cipher.o digest.o compress.o \
-			$(proc-crypto-y)
+crypto-objs = $(crypto-objs-y)
+crypto-objs-y = api.o scatterwalk.o cipher.o digest.o compress.o
+crypto-objs-$(CONFIG_PROC_FS) += proc.o
+crypto-objs-$(CONFIG_CRYPTO_HMAC) += hmac.o
 
-obj-$(CONFIG_CRYPTO_HMAC) += hmac.o
 obj-$(CONFIG_CRYPTO_NULL) += crypto_null.o
 obj-$(CONFIG_CRYPTO_MD4) += md4.o
 obj-$(CONFIG_CRYPTO_MD5) += md5.o
diff -rupN 2610rc1mm1.um/crypto.modular/proc.c 2610rc1mm1.um/crypto/proc.c
--- 2610rc1mm1.um/crypto.modular/proc.c	2004-11-07 18:41:35.000000000 +0100
+++ 2610rc1mm1.um/crypto/proc.c	2004-11-08 12:51:59.000000000 +0100
@@ -102,11 +102,22 @@ static struct file_operations proc_crypt
 	.release	= seq_release
 };
 
-void __init crypto_init_proc(void)
+int __init crypto_init_proc(void)
 {
 	struct proc_dir_entry *proc;
+	int ret = 0;
 	
 	proc = create_proc_entry("crypto", 0, NULL);
-	if (proc)
+	if (proc) {
 		proc->proc_fops = &proc_crypto_ops;
+	} else {
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+
+void __exit crypto_fini_proc(void)
+{
+	remove_proc_entry("crypto", &proc_root);
 }

Signed-off-by: Zbigniew Szmek <zjedrzejewski-szmek@wp.pl>
