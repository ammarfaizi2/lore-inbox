Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVGQPgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVGQPgx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 11:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVGQPgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 11:36:53 -0400
Received: from hermes.domdv.de ([193.102.202.1]:22798 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261220AbVGQPgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 11:36:52 -0400
Message-ID: <42DA7B12.7030307@domdv.de>
Date: Sun, 17 Jul 2005 17:36:50 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [swsusp] encrypt suspend data for easy wiping
References: <20050703213519.GA6750@elf.ucw.cz> <20050706020251.2ba175cc.akpm@osdl.org>
In-Reply-To: <20050706020251.2ba175cc.akpm@osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060908050304040109060009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060908050304040109060009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> 
>>To prevent data gathering from swap after resume you can encrypt the
>>suspend image with a temporary key that is deleted on resume. Note
>>that the temporary key is stored unencrypted on disk while the system
>>is suspended... still it means that saved data are wiped from disk
>>during resume by simply overwritting the key.
> 
[snip]
> err, no.  Please find a way to reduce the ifdeffery.

Andrew,
the attached patches are acked by Pavel and signed off by me. They apply
against 2.6.13-rc3 as well as 2.6.13-rc3-mm1 (with offsets) and are
tested against both kernels. Please consider for inclusion (Pavel
suggested that I could ask).

Note:
For 64 bit systems to work you need the following crypto fix for both
kernels stated above:
http://marc.theaimsgroup.com/?l=linux-kernel&m=112160294820624&w=2
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------060908050304040109060009
Content-Type: text/plain;
 name="swsusp-encrypt-config.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-encrypt-config.diff"

--- linux-2.6.13-rc3.orig/kernel/power/Kconfig	2005-07-17 16:03:26.000000000 +0200
+++ linux-2.6.13-rc3/kernel/power/Kconfig	2005-07-17 10:40:48.000000000 +0200
@@ -72,6 +72,18 @@
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
+config SWSUSP_ENCRYPT
+	bool "Encrypt suspend image"
+	depends on SOFTWARE_SUSPEND && CRYPTO=y && (CRYPTO_AES=y || CRYPTO_AES_586=y || CRYPTO_AES_X86_64=y)
+	default ""
+	---help---
+	  To prevent data gathering from swap after resume you can encrypt
+	  the suspend image with a temporary key that is deleted on
+	  resume.
+
+	  Note that the temporary key is stored unencrypted on disk while the
+	  system is suspended.
+
 config SUSPEND_SMP
 	bool
 	depends on HOTPLUG_CPU && X86 && PM

--------------060908050304040109060009
Content-Type: text/plain;
 name="swsusp-encrypt-core.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-encrypt-core.diff"

--- linux-2.6.13-rc3.orig/kernel/power/swsusp.c	2005-07-17 16:03:26.000000000 +0200
+++ linux-2.6.13-rc3/kernel/power/swsusp.c	2005-07-17 16:09:09.000000000 +0200
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
@@ -71,8 +74,16 @@
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 
+#include <linux/random.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+
 #include "power.h"
 
+#define CIPHER "aes"
+#define MAXKEY 32
+#define MAXIV  32
+
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
 
@@ -103,7 +114,8 @@
 #define SWSUSP_SIG	"S1SUSPEND"
 
 static struct swsusp_header {
-	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
+	char reserved[PAGE_SIZE - 20 - MAXKEY - MAXIV - sizeof(swp_entry_t)];
+	u8 key_iv[MAXKEY+MAXIV];
 	swp_entry_t swsusp_info;
 	char	orig_sig[10];
 	char	sig[10];
@@ -129,6 +141,131 @@
 static unsigned short swapfile_used[MAX_SWAPFILES];
 static unsigned short root_swap;
 
+static int write_page(unsigned long addr, swp_entry_t * loc);
+static int bio_read_page(pgoff_t page_off, void * page);
+
+static u8 key_iv[MAXKEY+MAXIV];
+
+#ifdef CONFIG_SWSUSP_ENCRYPT
+
+static int crypto_init(int mode, void **mem)
+{
+	int error = 0;
+	int len;
+	char *modemsg;
+	struct crypto_tfm *tfm;
+
+	modemsg = mode ? "suspend not possible" : "resume not possible";
+
+	tfm = crypto_alloc_tfm(CIPHER, CRYPTO_TFM_MODE_CBC);
+	if(!tfm) {
+		printk(KERN_ERR "swsusp: no tfm, %s\n", modemsg);
+		error = -EINVAL;
+		goto out;
+	}
+
+	if(MAXKEY < crypto_tfm_alg_min_keysize(tfm)) {
+		printk(KERN_ERR "swsusp: key buffer too small, %s\n", modemsg);
+		error = -ENOKEY;
+		goto fail;
+	}
+
+	if (mode)
+		get_random_bytes(key_iv, MAXKEY+MAXIV);
+
+	len = crypto_tfm_alg_max_keysize(tfm);
+	if (len > MAXKEY)
+		len = MAXKEY;
+
+	if (crypto_cipher_setkey(tfm, key_iv, len)) {
+		printk(KERN_ERR "swsusp: key setup failure, %s\n", modemsg);
+		error = -EKEYREJECTED;
+		goto fail;
+	}
+
+	len = crypto_tfm_alg_ivsize(tfm);
+
+	if (MAXIV < len) {
+		printk(KERN_ERR "swsusp: iv buffer too small, %s\n", modemsg);
+		error = -EOVERFLOW;
+		goto fail;
+	}
+
+	crypto_cipher_set_iv(tfm, key_iv+MAXKEY, len);
+
+	*mem=(void *)tfm;
+
+	goto out;
+
+fail:	crypto_free_tfm(tfm);
+out:	return error;
+}
+
+static __inline__ void crypto_exit(void *mem)
+{
+	crypto_free_tfm((struct crypto_tfm *)mem);
+}
+
+static __inline__ int crypto_write(struct pbe *p, void *mem)
+{
+	int error = 0;
+	struct scatterlist src, dst;
+
+	src.page   = virt_to_page(p->address);
+	src.offset = 0;
+	src.length = PAGE_SIZE;
+	dst.page   = virt_to_page((void *)&swsusp_header);
+	dst.offset = 0;
+	dst.length = PAGE_SIZE;
+
+	error = crypto_cipher_encrypt((struct crypto_tfm *)mem, &dst, &src,
+					PAGE_SIZE);
+
+	if (!error)
+		error = write_page((unsigned long)&swsusp_header,
+				&(p->swap_address));
+	return error;
+}
+
+static __inline__ int crypto_read(struct pbe *p, void *mem)
+{
+	int error = 0;
+	struct scatterlist src, dst;
+
+	error = bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+	if (!error) {
+		src.offset = 0;
+		src.length = PAGE_SIZE;
+		dst.offset = 0;
+		dst.length = PAGE_SIZE;
+		src.page = dst.page = virt_to_page((void *)p->address);
+
+		error = crypto_cipher_decrypt((struct crypto_tfm *)mem, &dst,
+						&src, PAGE_SIZE);
+	}
+	return error;
+}
+#else
+static __inline__ int crypto_init(int mode, void *mem)
+{
+	return 0;
+}
+
+static __inline__ void crypto_exit(void *mem)
+{
+}
+
+static __inline__ int crypto_write(struct pbe *p, void *mem)
+{
+	return write_page(p->address, &(p->swap_address));
+}
+
+static __inline__ int crypto_read(struct pbe *p, void *mem)
+{
+	return bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+}
+#endif
+
 static int mark_swapfiles(swp_entry_t prev)
 {
 	int error;
@@ -140,6 +277,7 @@
 	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
 		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
 		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
+		memcpy(swsusp_header.key_iv, key_iv, MAXKEY+MAXIV);
 		swsusp_header.swsusp_info = prev;
 		error = rw_swap_page_sync(WRITE,
 					  swp_entry(root_swap, 0),
@@ -286,6 +424,10 @@
 	int error = 0, i = 0;
 	unsigned int mod = nr_copy_pages / 100;
 	struct pbe *p;
+	void *tfm;
+
+	if ((error = crypto_init(1, &tfm)))
+		return error;
 
 	if (!mod)
 		mod = 1;
@@ -294,11 +436,14 @@
 	for_each_pbe (p, pagedir_nosave) {
 		if (!(i%mod))
 			printk( "\b\b\b\b%3d%%", i / mod );
-		if ((error = write_page(p->address, &(p->swap_address))))
+		if ((error = crypto_write(p, tfm))) {
+			crypto_exit(tfm);
 			return error;
+		}
 		i++;
 	}
 	printk("\b\b\b\bdone\n");
+	crypto_exit(tfm);
 	return error;
 }
 
@@ -400,6 +545,7 @@
 	if ((error = close_swap()))
 		goto FreePagedir;
  Done:
+	memset(key_iv, 0, MAXKEY+MAXIV);
 	return error;
  FreePagedir:
 	free_pagedir_entries();
@@ -1212,6 +1358,8 @@
 		return error;
 	if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
 		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
+		memcpy(key_iv, swsusp_header.key_iv, MAXKEY+MAXIV);
+		memset(swsusp_header.key_iv, 0, MAXKEY+MAXIV);
 
 		/*
 		 * Reset swap signature now.
@@ -1239,6 +1387,10 @@
 	int error = 0;
 	int i = 0;
 	int mod = swsusp_info.image_pages / 100;
+	void *tfm;
+
+	if ((error = crypto_init(0, &tfm)))
+		return error;
 
 	if (!mod)
 		mod = 1;
@@ -1250,14 +1402,15 @@
 		if (!(i % mod))
 			printk("\b\b\b\b%3d%%", i / mod);
 
-		error = bio_read_page(swp_offset(p->swap_address),
-				  (void *)p->address);
-		if (error)
+		if ((error = crypto_read(p, tfm))) {
+			crypto_exit(tfm);
 			return error;
+		}
 
 		i++;
 	}
 	printk("\b\b\b\bdone\n");
+	crypto_exit(tfm);
 	return error;
 }
 
@@ -1385,6 +1538,7 @@
 
 	error = read_suspend_image();
 	blkdev_put(resume_bdev);
+	memset(key_iv, 0, MAXKEY+MAXIV);
 
 	if (!error)
 		pr_debug("swsusp: Reading resume file was successful\n");

--------------060908050304040109060009--
