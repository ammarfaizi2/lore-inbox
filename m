Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUJYLvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUJYLvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 07:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUJYLvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 07:51:09 -0400
Received: from smtp.publishnet.nl ([212.241.49.8]:56581 "EHLO smtp.pn.nl")
	by vger.kernel.org with ESMTP id S261763AbUJYLu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 07:50:57 -0400
From: "Nico Augustijn." <kernel@janestarz.com>
To: hvr@gnu.org, clemens@endorphin.org
Subject: Cryptoloop patch for builtin default passphrase
Date: Mon, 25 Oct 2004 13:54:31 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410251354.31226.kernel@janestarz.com>
X-Spam-Processed: smtp.pn.nl, Mon, 25 Oct 2004 13:55:18 +0200
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 212.241.49.61
X-Return-Path: kernel@janestarz.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: smtp.pn.nl, Mon, 25 Oct 2004 13:55:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My boss wanted to have the filesystem on which our proprietery software is 
installed to be encrypted to make copying more difficult. And it does just 
that. It's not impossible to hack into the system.

This here patch will make the kernel use a default passphrase (compiled into 
the kernel or cryptoloop.ko module) when you set up a cryptoloop device with:
losetup -e aes -p 0 /dev/loop0 /path/to/your/encrypted-filesystem </dev/null
The passphrase can of course be read from the bzImage with dd if=bzImage 
ibs=<compressed image offset> skip=1 | gunzip -c | strings - | less
But all that takes some searching. And the passphrase is also XOR-ed with the 
first 32 bytes of /dev/nvram. If it is compiled as a module, the passphrase 
is even easier to read.

The added configuration option depends on CONFIG_BLK_DEV_CRYPTOLOOP  and 
CONFIG_NVRAM.
The chances of breaking anything else when the option is not activated looks 
like exactly zero to me.
But I have been known to be wrong. From time to time.

The affected files are: drivers/block/Kconfig and drivers/block/cryptoloop.c
The kernel source version is linux-2.6.9 (vanilla).

Comments/improvements are welcome. My /dev/null device will be happy to 
process your flames.

Signed-off-by: Nico Augustijn <kernel@janestarz.com>

-- 
Please note: 
- Email address is a private one, not a corporate one.
- I am not a member of the linux-kernel email list, so all replies only sent 
to the list will not be received by yours truly.

----------------------- begin patch -----------------------
--- drivers/block/cryptoloop.c.org	2004-10-20 13:26:14.000000000 +0200
+++ drivers/block/cryptoloop.c	2004-10-25 11:16:56.000000000 +0200
@@ -26,6 +26,9 @@
 #include <linux/crypto.h>
 #include <linux/blkdev.h>
 #include <linux/loop.h>
+#ifdef CONFIG_USE_CRYPTOLOOP_DEFAULTPASSPHRASE
+	#include <linux/nvram.h>
+#endif
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
@@ -46,6 +49,48 @@ cryptoloop_init(struct loop_device *lo, 
 	char *cmsp = cms;			/* c-m string pointer */
 	struct crypto_tfm *tfm = NULL;
 
+
+#ifdef CONFIG_USE_CRYPTOLOOP_DEFAULTPASSPHRASE
+#if (!defined(CONFIG_CRYPTOLOOP_DEFAULTPASSPHRASE))
+ #error Cannot build kernel with NULL or empty default passphrase
+#endif
+	int		n;
+	static struct	loop_info64 default_info;
+
+	/* Need a copy or we're gonna be writing to a read-only location. */
+	memcpy(&default_info, info, sizeof(struct loop_info64));
+
+	/* Test if all characters of the encryption key are zero.
+	 * This would indicate no key was given with 'losetup'. */
+	for (n = 0; n < info->lo_encrypt_key_size; n++)
+		if (info->lo_encrypt_key[n] != 0)
+			break;
+	/* If above loop was not broken, we can assume no key was given. */
+	if (n == info->lo_encrypt_key_size)
+	{
+		char	passphrase[] = CONFIG_CRYPTOLOOP_DEFAULTPASSPHRASE;
+		int	passphraselen;
+
+		/* Need this only for debugging purposes
+		printk(KERN_NOTICE "cryptoloop: Using default passphrase.\n"); */
+
+		passphraselen = strlen(passphrase);
+		/* Some bonehead might try an empty passphrase.
+		 * So then we just use the terminating null character. */
+		if (passphraselen == 0)
+			passphraselen = 1;
+
+		default_info.lo_encrypt_key_size = LO_KEY_SIZE;
+		for (n = 0; n < LO_KEY_SIZE; n++)
+			/* Read a byte from NVRAM, and XOR that with 'n'th char
+			 * of the default passphrase and make sure we don't try
+			 * to read beyond the end of the passphrase */
+			default_info.lo_encrypt_key[n] =
+				nvram_read_byte(n) ^ passphrase[n % passphraselen];
+
+	}
+#endif
+
 	/* encryption breaks for non sector aligned offsets */
 
 	if (info->lo_offset % LOOP_IV_SECTOR_SIZE)
@@ -63,9 +108,14 @@ cryptoloop_init(struct loop_device *lo, 
 	if (tfm == NULL)
 		return -EINVAL;
 
+#ifdef CONFIG_USE_CRYPTOLOOP_DEFAULTPASSPHRASE
+	err = tfm->crt_u.cipher.cit_setkey(tfm, default_info.lo_encrypt_key,
+					   default_info.lo_encrypt_key_size);
+#else
 	err = tfm->crt_u.cipher.cit_setkey(tfm, info->lo_encrypt_key,
 					   info->lo_encrypt_key_size);
-	
+#endif
+
 	if (err != 0)
 		goto out_free_tfm;
 
--- drivers/block/Kconfig.org	2004-10-20 13:27:13.000000000 +0200
+++ drivers/block/Kconfig	2004-10-25 12:23:34.000000000 +0200
@@ -265,6 +265,37 @@ config BLK_DEV_CRYPTOLOOP
 	  instead, which can be configured to be on-disk compatible with the
 	  cryptoloop device.
 
+config USE_CRYPTOLOOP_DEFAULTPASSPHRASE
+	bool "Use default passphrase for cryptoloop"
+	depends on BLK_DEV_CRYPTOLOOP && NVRAM
+	---help---
+	  *** CAUTION ***
+	  DO NOT USE UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!!
+	  
+	  If you are configuring your kernel to run on an unattended or
+	  embedded system, you can enter a default passphrase for your
+	  encrypted filesystems here.
+	  This makes it more difficult (but NOT impossible) to copy data
+	  from your encrypted filesystems.
+	  Since this option also reads data from your MB's nvram, 
+	  YOU SHOULD NEVER CHANGE YOUR CMOS SETTINGS WHEN USING THIS OPTION.
+	  Because CMOS settings are often written into the nvram.
+	  In order for this option to work you should also set CONFIG_NVRAM,
+	  the /dev/nvram driver in character devices.
+	  This will also make the filesystem usable only with the specific
+	  version of the MB with the specific nvram settings on which the
+	  filesystem was created.
+
+config CRYPTOLOOP_DEFAULTPASSPHRASE
+	string "Default cryptoloop passphrase"
+	depends on USE_CRYPTOLOOP_DEFAULTPASSPHRASE
+	---help---
+	  Enter your default passphrase for encrypted filesystems here.
+	  The minimum recommended length is 16 characters, the max is 32.
+	  Any characters beyond 32 will be ignored. 
+	  It is also recommended that you use a really garbled passphrase
+	  since it will be visible in the output of 'strings bzImage'.
+
 config BLK_DEV_NBD
 	tristate "Network block device support"
 	depends on NET
----------------------- end patch -----------------------


