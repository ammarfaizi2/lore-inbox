Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVDLNXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVDLNXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVDLNVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:21:43 -0400
Received: from hermes.domdv.de ([193.102.202.1]:26632 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262454AbVDLNRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 09:17:35 -0400
Message-ID: <425BCA6E.8030408@domdv.de>
Date: Tue, 12 Apr 2005 15:17:34 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <4259B474.4040407@domdv.de> <20050411110822.GA10401@elf.ucw.cz> <425AA19F.6040802@domdv.de> <200504112257.39708.rjw@sisk.pl>
In-Reply-To: <200504112257.39708.rjw@sisk.pl>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040701050001060100070508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040701050001060100070508
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Here comes the next incarnation, this time against 2.6.12rc2.
Unfortunately only compile tested as 2.6.12rc2 happily oopses away
(vanilla from kernel.org, oops already sent to lkml).

Please let me know if you want any further changes.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------040701050001060100070508
Content-Type: text/plain;
 name="swsusp-encrypt-core.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-encrypt-core.diff"

--- linux-2.6.12-rc2/kernel/power/swsusp.c.ast	2005-04-12 13:20:41.000000000 +0200
+++ linux-2.6.12-rc2/kernel/power/swsusp.c	2005-04-12 14:20:41.000000000 +0200
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
 
@@ -102,7 +115,9 @@ static suspend_pagedir_t *pagedir_save;
 #define SWSUSP_SIG	"S1SUSPEND"
 
 static struct swsusp_header {
-	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
+	char reserved[PAGE_SIZE - 20 - MAXKEY - MAXIV - sizeof(swp_entry_t)];
+	u8 key[MAXKEY];
+	u8 iv[MAXIV];
 	swp_entry_t swsusp_info;
 	char	orig_sig[10];
 	char	sig[10];
@@ -110,6 +125,11 @@ static struct swsusp_header {
 
 static struct swsusp_info swsusp_info;
 
+#ifdef CONFIG_SWSUSP_ENCRYPT
+static u8 key[MAXKEY];
+static u8 iv[MAXIV];
+#endif
+
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
@@ -128,6 +148,60 @@ static struct swsusp_info swsusp_info;
 static unsigned short swapfile_used[MAX_SWAPFILES];
 static unsigned short root_swap;
 
+#ifdef CONFIG_SWSUSP_ENCRYPT
+static int crypto_init(int mode, struct crypto_tfm **tfm)
+{
+	char *modemsg;
+	int len;
+	int error = 0;
+
+	modemsg = mode ? "suspend not possible" : "resume not possible";
+
+	*tfm = crypto_alloc_tfm(CIPHER, CRYPTO_TFM_MODE_CBC);
+	if(!*tfm) {
+		printk(KERN_ERR "swsusp: no tfm, %s\n", modemsg);
+		error = -EINVAL;
+		goto out;
+	}
+
+	if(sizeof(key) < crypto_tfm_alg_min_keysize(*tfm)) {
+		printk(KERN_ERR "swsusp: key buffer too small, %s\n", modemsg);
+		error = -ENOKEY;
+		goto fail;
+	}
+
+	if (mode) {
+		get_random_bytes(key, MAXKEY);
+		get_random_bytes(iv, MAXIV);
+	}
+
+	len = crypto_tfm_alg_max_keysize(*tfm);
+	if (len > sizeof(key))
+		len = sizeof(key);
+
+	if (crypto_cipher_setkey(*tfm, key, len)) {
+		printk(KERN_ERR "swsusp: key setup failure, %s\n", modemsg);
+		error = -EKEYREJECTED;
+		goto fail;
+	}
+
+	len = crypto_tfm_alg_ivsize(*tfm);
+
+	if (sizeof(iv) < len) {
+		printk(KERN_ERR "swsusp: iv buffer too small, %s\n", modemsg);
+		error = -EOVERFLOW;
+		goto fail;
+	}
+
+	crypto_cipher_set_iv(*tfm, iv, len);
+
+	goto out;
+
+fail:	crypto_free_tfm(*tfm);
+out:	return error;
+}
+#endif
+
 static int mark_swapfiles(swp_entry_t prev)
 {
 	int error;
@@ -139,6 +213,10 @@ static int mark_swapfiles(swp_entry_t pr
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
@@ -285,6 +363,19 @@ static int data_write(void)
 	int error = 0, i = 0;
 	unsigned int mod = nr_copy_pages / 100;
 	struct pbe *p;
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	struct crypto_tfm *tfm;
+	struct scatterlist src, dst;
+
+	if ((error = crypto_init(1, &tfm)))
+		return error;
+
+	src.offset = 0;
+	src.length = PAGE_SIZE;
+	dst.page   = virt_to_page((void *)&swsusp_header);
+	dst.offset = 0;
+	dst.length = PAGE_SIZE;
+#endif
 
 	if (!mod)
 		mod = 1;
@@ -293,11 +384,22 @@ static int data_write(void)
 	for_each_pbe(p, pagedir_nosave) {
 		if (!(i%mod))
 			printk( "\b\b\b\b%3d%%", i / mod );
+#ifdef CONFIG_SWSUSP_ENCRYPT
+		src.page = virt_to_page(p->address);
+		error = crypto_cipher_encrypt(tfm, &dst, &src, PAGE_SIZE);
+		if (!error)
+			error = write_page((unsigned long)&swsusp_header,
+					&(p->swap_address));
+#else
 		if ((error = write_page(p->address, &(p->swap_address))))
 			return error;
+#endif
 		i++;
 	}
 	printk("\b\b\b\bdone\n");
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	crypto_free_tfm(tfm);
+#endif
 	return error;
 }
 
@@ -399,6 +501,10 @@ static int write_suspend_image(void)
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
@@ -1226,6 +1332,12 @@ static int check_sig(void)
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
@@ -1252,6 +1364,18 @@ static int data_read(struct pbe *pblist)
 	int error = 0;
 	int i = 0;
 	int mod = swsusp_info.image_pages / 100;
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	struct crypto_tfm *tfm;
+	struct scatterlist src, dst;
+
+	if ((error = crypto_init(0, &tfm)))
+		return error;
+
+	src.offset = 0;
+	src.length = PAGE_SIZE;
+	dst.offset = 0;
+	dst.length = PAGE_SIZE;
+#endif
 
 	if (!mod)
 		mod = 1;
@@ -1265,12 +1389,27 @@ static int data_read(struct pbe *pblist)
 
 		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
+#ifdef CONFIG_SWSUSP_ENCRYPT
+		if (!error) {
+			src.page = dst.page = virt_to_page((void *)p->address);
+			error = crypto_cipher_decrypt(tfm, &dst, &src,
+							PAGE_SIZE);
+		}
+		if (error) {
+			crypto_free_tfm(tfm);
+			return error;
+		}
+#else
 		if (error)
 			return error;
+#endif
 
 		i++;
 	}
 	printk("\b\b\b\bdone\n");
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	crypto_free_tfm(tfm);
+#endif
 	return error;
 }
 
@@ -1411,6 +1550,11 @@ int swsusp_read(void)
 	error = read_suspend_image();
 	blkdev_put(resume_bdev);
 
+#ifdef CONFIG_SWSUSP_ENCRYPT
+	memset(key, 0, MAXKEY);
+	memset(iv, 0, MAXIV);
+#endif
+
 	if (!error)
 		pr_debug("swsusp: Reading resume file was successful\n");
 	else

--------------040701050001060100070508--
