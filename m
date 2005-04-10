Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVDJXfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVDJXfW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVDJXVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:21:32 -0400
Received: from hermes.domdv.de ([193.102.202.1]:8 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261637AbVDJXTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:19:21 -0400
Message-ID: <4259B474.4040407@domdv.de>
Date: Mon, 11 Apr 2005 01:19:16 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH encrypted swsusp 1/3] core functionality
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080106080804010702050607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080106080804010702050607
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

The following patch adds the core functionality for the encrypted
suspend image.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de



--------------080106080804010702050607
Content-Type: text/plain;
 name="swsusp-encrypt-core.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-encrypt-core.diff"

--- linux-2.6.11.2/kernel/power/swsusp.c.ast	2005-04-10 14:08:55.000000000 +0200
+++ linux-2.6.11.2/kernel/power/swsusp.c	2005-04-11 00:50:45.000000000 +0200
@@ -31,6 +31,9 @@
  * Alex Badea <vampire@go.ro>:
  * Fixed runaway init
  *
+ * Andreas Steinmetz <ast@domdv.de>:
+ * Added encrypted suspend option
+ *
  * More state savers are welcome. Especially for the scsi layer...
  *
  * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
@@ -72,6 +75,16 @@
 
 #include "power.h"
 
+#ifdef CONFIG_SWSUSP_ENCRYPT
+#include <linux/random.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+#endif
+
+#define CIPHER "aes"
+#define MAXKEY 32
+#define MAXIV  32
+
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
 
@@ -103,15 +116,27 @@
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
-static struct swsusp_header {
-	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
+struct swsusp_header {
+	char reserved[PAGE_SIZE - 20 - MAXKEY - MAXIV - sizeof(swp_entry_t)];
+	u8 key[MAXKEY];
+	u8 iv[MAXIV];
 	swp_entry_t swsusp_info;
 	char	orig_sig[10];
 	char	sig[10];
-} __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
+} __attribute__((packed, aligned(PAGE_SIZE)));
+
+static union {
+	struct swsusp_header __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
+	u8 buffer[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
+} __attribute__((packed, aligned(PAGE_SIZE))) u;
 
 static struct swsusp_info swsusp_info;
 
+#ifdef CONFIG_SWSUSP_ENCRYPT
+static u8 key[MAXKEY];
+static u8 iv[MAXIV];
+#endif
+
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
@@ -130,22 +155,72 @@
 static unsigned short swapfile_used[MAX_SWAPFILES];
 static unsigned short root_swap;
 
+#ifdef CONFIG_SWSUSP_ENCRYPT
+static struct crypto_tfm *crypto_init(int mode)
+{
+	struct crypto_tfm *tfm;
+	int len;
+
+	tfm = crypto_alloc_tfm(CIPHER, CRYPTO_TFM_MODE_CBC);
+	if(!tfm) {
+		printk(KERN_ERR "swsusp: no tfm, suspend not possible\n");
+		return NULL;
+	}
+
+	if(sizeof(key) < crypto_tfm_alg_min_keysize(tfm)) {
+		printk("swsusp: key buffer too small, suspend not possible\n");
+		crypto_free_tfm(tfm);
+		return NULL;
+	}
+
+	if (sizeof(iv) < crypto_tfm_alg_ivsize(tfm)) {
+		printk("swsusp: iv buffer too small, suspend not possible\n");
+		crypto_free_tfm(tfm);
+		return NULL;
+	}
+
+	if (mode) {
+		get_random_bytes(key, MAXKEY);
+		get_random_bytes(iv, MAXIV);
+	}
+
+	len = crypto_tfm_alg_max_keysize(tfm);
+	if (len > sizeof(key))
+		len = sizeof(key);
+
+	if (crypto_cipher_setkey(tfm, key, len)) {
+		printk(KERN_ERR "swsusp: key setup failure, suspend not possible\n");
+		crypto_free_tfm(tfm);
+		return NULL;
+	}
+
+	len = crypto_tfm_alg_blocksize(tfm);
+	crypto_cipher_set_iv(tfm, iv, len);
+
+	return tfm;
+}
+#endif
+
 static int mark_swapfiles(swp_entry_t prev)
 {
 	int error;
 
 	rw_swap_page_sync(READ, 
 			  swp_entry(root_swap, 0),
-			  virt_to_page((unsigned long)&swsusp_header));
-	if (!memcmp("SWAP-SPACE",swsusp_header.sig, 10) ||
-	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
-		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
-		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
-		swsusp_header.swsusp_info = prev;
+			  virt_to_page((unsigned long)&u.swsusp_header));
+	if (!memcmp("SWAP-SPACE",u.swsusp_header.sig, 10) ||
+	    !memcmp("SWAPSPACE2",u.swsusp_header.sig, 10)) {
+		memcpy(u.swsusp_header.orig_sig,u.swsusp_header.sig, 10);
+		memcpy(u.swsusp_header.sig,SWSUSP_SIG, 10);
+#ifdef CONFIG_SWSUSP_ENCRYPT
+		memcpy(u.swsusp_header.key, key, MAXKEY);
+		memcpy(u.swsusp_header.iv, iv, MAXIV);
+#endif
+		u.swsusp_header.swsusp_info = prev;
 		error = rw_swap_page_sync(WRITE, 
 					  swp_entry(root_swap, 0),
 					  virt_to_page((unsigned long)
-						       &swsusp_header));
+						       &u.swsusp_header));
 	} else {
 		pr_debug("swsusp: Partition is not swap space.\n");
 		error = -ENODEV;
@@ -294,6 +369,19 @@
 	int error = 0;
 	int i;
 	unsigned int mod = nr_copy_pages / 100;
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	struct crypto_tfm *tfm;
+	struct scatterlist src, dst;
+
+	if (!(tfm = crypto_init(1)))
+		return -EINVAL;
+
+	src.offset = 0;
+	src.length = PAGE_SIZE;
+	dst.page   = virt_to_page(u.buffer);
+	dst.offset = 0;
+	dst.length = PAGE_SIZE;
+#endif
 
 	if (!mod)
 		mod = 1;
@@ -302,10 +390,22 @@
 	for (i = 0; i < nr_copy_pages && !error; i++) {
 		if (!(i%mod))
 			printk( "\b\b\b\b%3d%%", i / mod );
+#ifdef CONFIG_SWSUSP_ENCRYPT
+		src.page = virt_to_page((pagedir_nosave+i)->address);
+		error = crypto_cipher_encrypt_iv(tfm, &dst, &src,
+						PAGE_SIZE, iv);
+		if (!error)
+			error = write_page((unsigned long)u.buffer,
+					  &((pagedir_nosave+i)->swap_address));
+#else
 		error = write_page((pagedir_nosave+i)->address,
 					  &((pagedir_nosave+i)->swap_address));
+#endif
 	}
 	printk("\b\b\b\bdone\n");
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	crypto_free_tfm(tfm);
+#endif
 	return error;
 }
 
@@ -404,6 +504,10 @@
 	if ((error = close_swap()))
 		goto FreePagedir;
  Done:
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	memset(key, 0, MAXKEY);
+	memset(iv, 0, MAXIV);
+#endif
 	return error;
  FreePagedir:
 	free_pagedir_entries();
@@ -1101,7 +1205,7 @@
 	const char * reason = NULL;
 	int error;
 
-	if ((error = bio_read_page(swp_offset(swsusp_header.swsusp_info), &swsusp_info)))
+	if ((error = bio_read_page(swp_offset(u.swsusp_header.swsusp_info), &swsusp_info)))
 		return error;
 
  	/* Is this same machine? */
@@ -1118,16 +1222,21 @@
 {
 	int error;
 
-	memset(&swsusp_header, 0, sizeof(swsusp_header));
-	if ((error = bio_read_page(0, &swsusp_header)))
+	memset(&u.swsusp_header, 0, sizeof(u.swsusp_header));
+	if ((error = bio_read_page(0, &u.swsusp_header)))
 		return error;
-	if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
-		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
-
+	if (!memcmp(SWSUSP_SIG, u.swsusp_header.sig, 10)) {
+		memcpy(u.swsusp_header.sig, u.swsusp_header.orig_sig, 10);
+#ifdef CONFIG_SWSUSP_ENCRYPT
+		memcpy(key, u.swsusp_header.key, MAXKEY);
+		memcpy(iv, u.swsusp_header.iv, MAXIV);
+		memset(u.swsusp_header.key, 0, MAXKEY);
+		memset(u.swsusp_header.iv, 0, MAXIV);
+#endif
 		/*
 		 * Reset swap signature now.
 		 */
-		error = bio_write_page(0, &swsusp_header);
+		error = bio_write_page(0, &u.swsusp_header);
 	} else { 
 		pr_debug(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
 		return -EINVAL;
@@ -1150,6 +1259,18 @@
 	int error;
 	int i;
 	int mod = nr_copy_pages / 100;
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	struct crypto_tfm *tfm;
+	struct scatterlist src, dst;
+
+	if (!(tfm = crypto_init(0)))
+		return -EINVAL;
+
+	src.offset = 0;
+	src.length = PAGE_SIZE;
+	dst.offset = 0;
+	dst.length = PAGE_SIZE;
+#endif
 
 	if (!mod)
 		mod = 1;
@@ -1163,8 +1284,18 @@
 			printk( "\b\b\b\b%3d%%", i / mod );
 		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
+#ifdef CONFIG_SWSUSP_ENCRYPT
+		if (!error) {
+			src.page = dst.page = virt_to_page((void *)p->address);
+			error = crypto_cipher_decrypt_iv(tfm, &dst, &src,
+							PAGE_SIZE, iv);
+		}
+#endif
 	}
 	printk(" %d done.\n",i);
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	crypto_free_tfm(tfm);
+#endif
 	return error;
 
 }
@@ -1233,6 +1364,11 @@
 	} else
 		error = PTR_ERR(resume_bdev);
 
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	memset(key, 0, MAXKEY);
+	memset(iv, 0, MAXIV);
+#endif
+
 	if (!error)
 		pr_debug("Reading resume file was successful\n");
 	else


--------------080106080804010702050607--
