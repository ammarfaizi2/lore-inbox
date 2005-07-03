Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVGCVgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVGCVgW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 17:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVGCVgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 17:36:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9921 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261546AbVGCVfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 17:35:23 -0400
Date: Sun, 3 Jul 2005 23:35:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: ast@domdv.de
Subject: [swsusp] encrypt suspend data for easy wiping
Message-ID: <20050703213519.GA6750@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Steinmetz <ast@domdv.de>

To prevent data gathering from swap after resume you can encrypt the
suspend image with a temporary key that is deleted on resume. Note
that the temporary key is stored unencrypted on disk while the system
is suspended... still it means that saved data are wiped from disk
during resume by simply overwritting the key.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit b61ea835309d0fb87cf1c7a2d83d5832ae8eb116
tree 17bfb260d69819d29e84e481382aa090f0a15969
parent d676c816f71e27761f419d399ad6be728c97a4a9
author <pavel@amd.(none)> Sun, 03 Jul 2005 23:34:20 +0200
committer <pavel@amd.(none)> Sun, 03 Jul 2005 23:34:20 +0200

 Documentation/power/swsusp.txt |    7 ++
 kernel/power/Kconfig           |   12 +++
 kernel/power/main.c            |    5 +
 kernel/power/swsusp.c          |  148 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 168 insertions(+), 4 deletions(-)

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -30,6 +30,13 @@ echo shutdown > /sys/power/disk; echo di
 echo platform > /sys/power/disk; echo disk > /sys/power/state
 
 
+Encrypted suspend image:
+------------------------
+If you want to store your suspend image encrypted with a temporary
+key to prevent data gathering after resume you must compile
+crypto and the aes algorithm into the kernel - modules won't work
+as they cannot be loaded at resume time.
+
 
 Article about goals and implementation of Software Suspend for Linux
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -76,3 +76,15 @@ config SUSPEND_SMP
 	bool
 	depends on HOTPLUG_CPU && X86 && PM
 	default y
+
+config SWSUSP_ENCRYPT
+	bool "Encrypt suspend image"
+	depends on SOFTWARE_SUSPEND && CRYPTO=y && (CRYPTO_AES=y || CRYPTO_AES_586=y)
+	default ""
+	---help---
+	  To prevent data gathering from swap after resume you can encrypt
+	  the suspend image with a temporary key that is deleted on
+	  resume.
+
+	  Note that the temporary key is stored unencrypted on disk while the
+	  system is suspended.
diff --git a/kernel/power/main.c b/kernel/power/main.c
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -129,11 +129,12 @@ static void suspend_finish(suspend_state
 
 
 
-static char * pm_states[] = {
+static char * pm_states[PM_SUSPEND_MAX] = {
 	[PM_SUSPEND_STANDBY]	= "standby",
 	[PM_SUSPEND_MEM]	= "mem",
+#ifdef CONFIG_SOFTWARE_SUSPEND
 	[PM_SUSPEND_DISK]	= "disk",
-	NULL,
+#endif
 };
 
 
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
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
 	for_each_pbe (p, pagedir_nosave) {
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
@@ -1213,12 +1319,18 @@ static int check_sig(void)
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
 		error = bio_write_page(0, &swsusp_header);
 	} else { 
-		printk(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
+		printk(KERN_INFO "swsusp: Suspend partition does not contain suspend image.\n");
 		return -EINVAL;
 	}
 	if (!error)
@@ -1239,6 +1351,18 @@ static int data_read(struct pbe *pblist)
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
@@ -1252,12 +1376,27 @@ static int data_read(struct pbe *pblist)
 
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
 
@@ -1398,6 +1537,11 @@ int swsusp_read(void)
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

-- 
teflon -- maybe it is a trademark, but it should not be.
