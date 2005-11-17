Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVKQWgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVKQWgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVKQWgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:36:16 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:21683 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964921AbVKQWgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:36:15 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/3][Resend] swsusp: remove encryption
Date: Thu, 17 Nov 2005 23:27:32 +0100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200511172322.14735.rjw@sisk.pl>
In-Reply-To: <200511172322.14735.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511172327.32631.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the image encryption that is only used by swsusp instead
of zeroing the image after resume in order to prevent someone from
reading some confidential data from it in the future and it does not protect
the image from being read by an unauthorized person before resume.
The functionality it provides should really belong to the user space
and will possibly be reimplemented after the swap-handling functionality
of swsusp is moved to the user space.

The next two patches depend on this one.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>

 kernel/power/swsusp.c |  163 +-------------------------------------------------
 1 files changed, 4 insertions(+), 159 deletions(-)

Index: linux-2.6.15-rc1-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/kernel/power/swsusp.c	2005-11-17 22:50:43.000000000 +0100
+++ linux-2.6.15-rc1-mm1/kernel/power/swsusp.c	2005-11-17 22:51:52.000000000 +0100
@@ -30,9 +30,6 @@
  * Alex Badea <vampire@go.ro>:
  * Fixed runaway init
  *
- * Andreas Steinmetz <ast@domdv.de>:
- * Added encrypted suspend option
- *
  * More state savers are welcome. Especially for the scsi layer...
  *
  * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
@@ -67,10 +64,6 @@
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 
-#include <linux/random.h>
-#include <linux/crypto.h>
-#include <asm/scatterlist.h>
-
 #include "power.h"
 
 #ifdef CONFIG_HIGHMEM
@@ -81,10 +74,6 @@
 static int restore_highmem(void) { return 0; }
 #endif
 
-#define CIPHER "aes"
-#define MAXKEY 32
-#define MAXIV  32
-
 extern char resume_file[];
 
 /* Local variables that should not be affected by save */
@@ -102,8 +91,7 @@
 #define SWSUSP_SIG	"S1SUSPEND"
 
 static struct swsusp_header {
-	char reserved[PAGE_SIZE - 20 - MAXKEY - MAXIV - sizeof(swp_entry_t)];
-	u8 key_iv[MAXKEY+MAXIV];
+	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
 	swp_entry_t swsusp_info;
 	char	orig_sig[10];
 	char	sig[10];
@@ -123,131 +111,6 @@
 static unsigned short swapfile_used[MAX_SWAPFILES];
 static unsigned short root_swap;
 
-static int write_page(unsigned long addr, swp_entry_t *loc);
-static int bio_read_page(pgoff_t page_off, void *page);
-
-static u8 key_iv[MAXKEY+MAXIV];
-
-#ifdef CONFIG_SWSUSP_ENCRYPT
-
-static int crypto_init(int mode, void **mem)
-{
-	int error = 0;
-	int len;
-	char *modemsg;
-	struct crypto_tfm *tfm;
-
-	modemsg = mode ? "suspend not possible" : "resume not possible";
-
-	tfm = crypto_alloc_tfm(CIPHER, CRYPTO_TFM_MODE_CBC);
-	if(!tfm) {
-		printk(KERN_ERR "swsusp: no tfm, %s\n", modemsg);
-		error = -EINVAL;
-		goto out;
-	}
-
-	if(MAXKEY < crypto_tfm_alg_min_keysize(tfm)) {
-		printk(KERN_ERR "swsusp: key buffer too small, %s\n", modemsg);
-		error = -ENOKEY;
-		goto fail;
-	}
-
-	if (mode)
-		get_random_bytes(key_iv, MAXKEY+MAXIV);
-
-	len = crypto_tfm_alg_max_keysize(tfm);
-	if (len > MAXKEY)
-		len = MAXKEY;
-
-	if (crypto_cipher_setkey(tfm, key_iv, len)) {
-		printk(KERN_ERR "swsusp: key setup failure, %s\n", modemsg);
-		error = -EKEYREJECTED;
-		goto fail;
-	}
-
-	len = crypto_tfm_alg_ivsize(tfm);
-
-	if (MAXIV < len) {
-		printk(KERN_ERR "swsusp: iv buffer too small, %s\n", modemsg);
-		error = -EOVERFLOW;
-		goto fail;
-	}
-
-	crypto_cipher_set_iv(tfm, key_iv+MAXKEY, len);
-
-	*mem=(void *)tfm;
-
-	goto out;
-
-fail:	crypto_free_tfm(tfm);
-out:	return error;
-}
-
-static __inline__ void crypto_exit(void *mem)
-{
-	crypto_free_tfm((struct crypto_tfm *)mem);
-}
-
-static __inline__ int crypto_write(struct pbe *p, void *mem)
-{
-	int error = 0;
-	struct scatterlist src, dst;
-
-	src.page   = virt_to_page(p->address);
-	src.offset = 0;
-	src.length = PAGE_SIZE;
-	dst.page   = virt_to_page((void *)&swsusp_header);
-	dst.offset = 0;
-	dst.length = PAGE_SIZE;
-
-	error = crypto_cipher_encrypt((struct crypto_tfm *)mem, &dst, &src,
-					PAGE_SIZE);
-
-	if (!error)
-		error = write_page((unsigned long)&swsusp_header,
-				&(p->swap_address));
-	return error;
-}
-
-static __inline__ int crypto_read(struct pbe *p, void *mem)
-{
-	int error = 0;
-	struct scatterlist src, dst;
-
-	error = bio_read_page(swp_offset(p->swap_address), (void *)p->address);
-	if (!error) {
-		src.offset = 0;
-		src.length = PAGE_SIZE;
-		dst.offset = 0;
-		dst.length = PAGE_SIZE;
-		src.page = dst.page = virt_to_page((void *)p->address);
-
-		error = crypto_cipher_decrypt((struct crypto_tfm *)mem, &dst,
-						&src, PAGE_SIZE);
-	}
-	return error;
-}
-#else
-static __inline__ int crypto_init(int mode, void *mem)
-{
-	return 0;
-}
-
-static __inline__ void crypto_exit(void *mem)
-{
-}
-
-static __inline__ int crypto_write(struct pbe *p, void *mem)
-{
-	return write_page(p->address, &(p->swap_address));
-}
-
-static __inline__ int crypto_read(struct pbe *p, void *mem)
-{
-	return bio_read_page(swp_offset(p->swap_address), (void *)p->address);
-}
-#endif
-
 static int mark_swapfiles(swp_entry_t prev)
 {
 	int error;
@@ -259,7 +122,6 @@
 	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
 		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
 		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
-		memcpy(swsusp_header.key_iv, key_iv, MAXKEY+MAXIV);
 		swsusp_header.swsusp_info = prev;
 		error = rw_swap_page_sync(WRITE,
 					  swp_entry(root_swap, 0),
@@ -405,10 +267,6 @@
 	int error = 0, i = 0;
 	unsigned int mod = nr_copy_pages / 100;
 	struct pbe *p;
-	void *tfm;
-
-	if ((error = crypto_init(1, &tfm)))
-		return error;
 
 	if (!mod)
 		mod = 1;
@@ -417,14 +275,11 @@
 	for_each_pbe (p, pagedir_nosave) {
 		if (!(i%mod))
 			printk( "\b\b\b\b%3d%%", i / mod );
-		if ((error = crypto_write(p, tfm))) {
-			crypto_exit(tfm);
+		if ((error = write_page(p->address, &p->swap_address)))
 			return error;
-		}
 		i++;
 	}
 	printk("\b\b\b\bdone\n");
-	crypto_exit(tfm);
 	return error;
 }
 
@@ -550,7 +405,6 @@
 	if ((error = close_swap()))
 		goto FreePagedir;
  Done:
-	memset(key_iv, 0, MAXKEY+MAXIV);
 	return error;
  FreePagedir:
 	free_pagedir_entries();
@@ -812,8 +666,6 @@
 		return error;
 	if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
 		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
-		memcpy(key_iv, swsusp_header.key_iv, MAXKEY+MAXIV);
-		memset(swsusp_header.key_iv, 0, MAXKEY+MAXIV);
 
 		/*
 		 * Reset swap signature now.
@@ -840,10 +692,6 @@
 	int error = 0;
 	int i = 0;
 	int mod = swsusp_info.image_pages / 100;
-	void *tfm;
-
-	if ((error = crypto_init(0, &tfm)))
-		return error;
 
 	if (!mod)
 		mod = 1;
@@ -855,15 +703,13 @@
 		if (!(i % mod))
 			printk("\b\b\b\b%3d%%", i / mod);
 
-		if ((error = crypto_read(p, tfm))) {
-			crypto_exit(tfm);
+		if ((error = bio_read_page(swp_offset(p->swap_address),
+						(void *)p->address)))
 			return error;
-		}
 
 		i++;
 	}
 	printk("\b\b\b\bdone\n");
-	crypto_exit(tfm);
 	return error;
 }
 
@@ -986,7 +832,6 @@
 
 	error = read_suspend_image();
 	blkdev_put(resume_bdev);
-	memset(key_iv, 0, MAXKEY+MAXIV);
 
 	if (!error)
 		pr_debug("swsusp: Reading resume file was successful\n");


