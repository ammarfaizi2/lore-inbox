Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVDKQS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVDKQS2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVDKQRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:17:44 -0400
Received: from hermes.domdv.de ([193.102.202.1]:20755 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261835AbVDKQLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:11:14 -0400
Message-ID: <425AA19F.6040802@domdv.de>
Date: Mon, 11 Apr 2005 18:11:11 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <4259B474.4040407@domdv.de> <20050411110822.GA10401@elf.ucw.cz>
In-Reply-To: <20050411110822.GA10401@elf.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060405020803000201020008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060405020803000201020008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Was it really neccessary to include "union u"? I don't like its name,

Here comes the patch with this reverted. I'm now using casts when
'abusing' the space for encryption. Furthermore the iv set up in the tfm
is used instead of the local copy.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------060405020803000201020008
Content-Type: text/plain;
 name="swsusp-encrypt-core.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-encrypt-core.diff"

--- linux-2.6.11.2/kernel/power/swsusp.c.ast	2005-04-10 14:08:55.000000000 +0200
+++ linux-2.6.11.2/kernel/power/swsusp.c	2005-04-11 18:05:58.000000000 +0200
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
 
@@ -104,7 +117,9 @@
 #define SWSUSP_SIG	"S1SUSPEND"
 
 static struct swsusp_header {
-	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
+	char reserved[PAGE_SIZE - 20 - MAXKEY - MAXIV - sizeof(swp_entry_t)];
+	u8 key[MAXKEY];
+	u8 iv[MAXIV];
 	swp_entry_t swsusp_info;
 	char	orig_sig[10];
 	char	sig[10];
@@ -112,6 +127,11 @@
 
 static struct swsusp_info swsusp_info;
 
+#ifdef CONFIG_SWSUSP_ENCRYPT
+static u8 key[MAXKEY];
+static u8 iv[MAXIV];
+#endif
+
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
@@ -130,6 +150,52 @@
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
@@ -141,6 +207,10 @@
 	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
 		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
 		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
+#ifdef CONFIG_SWSUSP_ENCRYPT
+		memcpy(swsusp_header.key, key, MAXKEY);
+		memcpy(swsusp_header.iv, iv, MAXIV);
+#endif
 		swsusp_header.swsusp_info = prev;
 		error = rw_swap_page_sync(WRITE, 
 					  swp_entry(root_swap, 0),
@@ -294,6 +364,19 @@
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
+	dst.page   = virt_to_page((void *)&swsusp_header);
+	dst.offset = 0;
+	dst.length = PAGE_SIZE;
+#endif
 
 	if (!mod)
 		mod = 1;
@@ -302,10 +385,21 @@
 	for (i = 0; i < nr_copy_pages && !error; i++) {
 		if (!(i%mod))
 			printk( "\b\b\b\b%3d%%", i / mod );
+#ifdef CONFIG_SWSUSP_ENCRYPT
+		src.page = virt_to_page((pagedir_nosave+i)->address);
+		error = crypto_cipher_encrypt(tfm, &dst, &src, PAGE_SIZE);
+		if (!error)
+			error = write_page((unsigned long)&swsusp_header,
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
 
@@ -404,6 +498,10 @@
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
@@ -1124,6 +1222,12 @@
 	if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
 		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
 
+#ifdef CONFIG_SWSUSP_ENCRYPT
+		memcpy(key, swsusp_header.key, MAXKEY);
+		memcpy(iv, swsusp_header.iv, MAXIV);
+		memset(swsusp_header.key, 0, MAXKEY);
+		memset(swsusp_header.iv, 0, MAXIV);
+#endif
 		/*
 		 * Reset swap signature now.
 		 */
@@ -1150,6 +1254,18 @@
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
@@ -1163,8 +1279,18 @@
 			printk( "\b\b\b\b%3d%%", i / mod );
 		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
+#ifdef CONFIG_SWSUSP_ENCRYPT
+		if (!error) {
+			src.page = dst.page = virt_to_page((void *)p->address);
+			error = crypto_cipher_decrypt(tfm, &dst, &src,
+							PAGE_SIZE);
+		}
+#endif
 	}
 	printk(" %d done.\n",i);
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	crypto_free_tfm(tfm);
+#endif
 	return error;
 
 }
@@ -1233,6 +1359,11 @@
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

--------------060405020803000201020008--
