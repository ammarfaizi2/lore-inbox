Return-Path: <linux-kernel-owner+w=401wt.eu-S1751041AbXAPOIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbXAPOIp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 09:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXAPOIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 09:08:45 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:59352 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbXAPOIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 09:08:43 -0500
Subject: Re: [RFC][PATCH] Pseudo-random number generator
From: Jan Glauber <jan.glauber@de.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1165324047.6337.39.camel@bender>
References: <1164979155.5882.23.camel@bender>
	 <200612041615.kB4GF7lx031249@turing-police.cc.vt.edu>
	 <1165324047.6337.39.camel@bender>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 15:07:51 +0100
Message-Id: <1168956471.5484.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 14:07 +0100, Jan Glauber wrote:
> Yes, if an attacker knows the initial clock value a brute-force attack
> would be feasible to predict the output. But I don't know if the
> hardware completely relies on the clock values or if there is any
> internal state which is not visible by an attacker. I will try to find
> out more details...

OK, after some research I got a new proposal. What the hardware does 
internally is just a Triple-DES operation with 3 different keys.

That means with my old implementation the input for a TDES operation is
the buffer full of timestamps. If an attacker can guess the first timestamp
he knows the entire input, since the timestamp loop indeed produces 
timestamps with a constant offset. Therefore I'd like to replace the
timestamp loop with only a single timestamp, which has the following
advantages:

- it is as safe as the loop (since the additional timestamps contain very
  low entropy)
- its faster, since we don't have to overwrite the entire buffer
- the one timestamp still guarantees unique, non-repeating output values

Even if an attacker knows the input buffer for the next operation
(known-plaintext attack) it turns out that currently this attack is not
feasible against TDES. Therefore, as long as the key is not compromised
there is no way to guess the next output from the generator.

Jan

--
 arch/s390/crypto/Makefile           |    1 
 arch/s390/crypto/crypt_s390.h       |    3 
 arch/s390/crypto/crypt_s390_query.c |    2 
 arch/s390/crypto/prng.c             |  209 ++++++++++++++++++++++++++++++++++++
 arch/s390/defconfig                 |    1 
 drivers/s390/Kconfig                |    7 +
 6 files changed, 222 insertions(+), 1 deletion(-)

diff -urNp linux-2.6.orig/arch/s390/crypto/Makefile linux-2.6/arch/s390/crypto/Makefile
--- linux-2.6.orig/arch/s390/crypto/Makefile	2006-11-17 10:26:35.000000000 +0100
+++ linux-2.6/arch/s390/crypto/Makefile	2007-01-16 13:03:12.000000000 +0100
@@ -6,5 +6,6 @@ obj-$(CONFIG_CRYPTO_SHA1_S390) += sha1_s
 obj-$(CONFIG_CRYPTO_SHA256_S390) += sha256_s390.o
 obj-$(CONFIG_CRYPTO_DES_S390) += des_s390.o des_check_key.o
 obj-$(CONFIG_CRYPTO_AES_S390) += aes_s390.o
+obj-$(CONFIG_S390_PRNG) += prng.o
 
 obj-$(CONFIG_CRYPTO_TEST) += crypt_s390_query.o
diff -urNp linux-2.6.orig/arch/s390/crypto/crypt_s390.h linux-2.6/arch/s390/crypto/crypt_s390.h
--- linux-2.6.orig/arch/s390/crypto/crypt_s390.h	2006-11-17 10:26:35.000000000 +0100
+++ linux-2.6/arch/s390/crypto/crypt_s390.h	2007-01-16 13:03:12.000000000 +0100
@@ -68,6 +68,7 @@ enum crypt_s390_kmc_func {
 	KMC_AES_192_DECRYPT  = CRYPT_S390_KMC | 0x13 | 0x80,
 	KMC_AES_256_ENCRYPT  = CRYPT_S390_KMC | 0x14,
 	KMC_AES_256_DECRYPT  = CRYPT_S390_KMC | 0x14 | 0x80,
+	KMC_PRNG	     = CRYPT_S390_KMC | 0x43,
 };
 
 /* function codes for KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST)
@@ -147,7 +148,7 @@ crypt_s390_km(long func, void* param, u8
  * @param src: address of source memory area
  * @param src_len: length of src operand in bytes
  * @returns < zero for failure, 0 for the query func, number of processed bytes
- * 	for encryption/decryption funcs
+ *	for encryption/decryption funcs
  */
 static inline int
 crypt_s390_kmc(long func, void* param, u8* dest, const u8* src, long src_len)
diff -urNp linux-2.6.orig/arch/s390/crypto/crypt_s390_query.c linux-2.6/arch/s390/crypto/crypt_s390_query.c
--- linux-2.6.orig/arch/s390/crypto/crypt_s390_query.c	2006-11-17 10:26:35.000000000 +0100
+++ linux-2.6/arch/s390/crypto/crypt_s390_query.c	2007-01-16 13:03:12.000000000 +0100
@@ -54,6 +54,8 @@ static void query_available_functions(vo
 		crypt_s390_func_available(KMC_AES_192_ENCRYPT));
 	printk(KERN_INFO "KMC_AES_256: %d\n",
 		crypt_s390_func_available(KMC_AES_256_ENCRYPT));
+	printk(KERN_INFO "KMC_PRNG: %d\n",
+		crypt_s390_func_available(KMC_PRNG));
 
 	/* query available KIMD functions */
 	printk(KERN_INFO "KIMD_QUERY: %d\n",
diff -urNp linux-2.6.orig/arch/s390/crypto/prng.c linux-2.6/arch/s390/crypto/prng.c
--- linux-2.6.orig/arch/s390/crypto/prng.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6/arch/s390/crypto/prng.c	2007-01-16 13:04:45.000000000 +0100
@@ -0,0 +1,209 @@
+/*
+ * Copyright 2006 IBM Corporation
+ * Author(s): Jan Glauber <jan.glauber@de.ibm.com>
+ * Driver for the s390 pseudo random number generator
+ */
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/random.h>
+#include <asm/debug.h>
+#include <asm/uaccess.h>
+
+#include "crypt_s390.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jan Glauber <jan.glauber@de.ibm.com>");
+MODULE_DESCRIPTION("s390 PRNG interface");
+
+static int prng_chunk_size = 256;
+module_param(prng_chunk_size, int, 0);
+MODULE_PARM_DESC(prng_chunk_size, "PRNG read chunk size in bytes");
+
+static int prng_entropy_limit = 4096;
+module_param(prng_entropy_limit, int, 0);
+MODULE_PARM_DESC(prng_entropy_limit,
+	"PRNG add entropy after that much bytes were produced");
+
+/*
+ * Any one who considers arithmetical methods of producing random digits is,
+ * of course, in a state of sin. -- John von Neumann
+ */
+
+struct s390_prng_data {
+	unsigned long count; /* how many bytes were produced */
+	char *buf;
+};
+
+static struct s390_prng_data *p;
+
+/* copied from libica, use a non-zero initial parameter block */
+static unsigned char parm_block[32] = {
+0x0F,0x2B,0x8E,0x63,0x8C,0x8E,0xD2,0x52,0x64,0xB7,0xA0,0x7B,0x75,0x28,0xB8,0xF4,
+0x75,0x5F,0xD2,0xA6,0x8D,0x97,0x11,0xFF,0x49,0xD8,0x23,0xF3,0x7E,0x21,0xEC,0xA0,
+};
+
+static int prng_open(struct inode *inode, struct file *file)
+{
+	return nonseekable_open(inode, file);
+}
+
+static void prng_add_entropy(void)
+{
+	__u64 entropy[4];
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < 16; i++) {
+		ret = crypt_s390_kmc(KMC_PRNG, parm_block, (char *)entropy,
+				     (char *)entropy, sizeof(entropy));
+		BUG_ON(ret < 0 || ret != sizeof(entropy));
+		memcpy(parm_block, entropy, sizeof(entropy));
+	}
+}
+
+static void prng_seed(int nbytes)
+{
+	char buf[nbytes];
+	int i = 0;
+
+	get_random_bytes(buf, nbytes);
+
+	/* Add the entropy */
+	while (nbytes >= 8) {
+		*((__u64 *)parm_block) ^= *((__u64 *)buf+i*8);
+		prng_add_entropy();
+		i += 8;
+		nbytes -= 8;
+	}
+	prng_add_entropy();
+}
+
+static ssize_t prng_read(struct file *file, char __user *ubuf, size_t nbytes,
+			 loff_t *ppos)
+{
+	int chunk, n;
+	int ret = 0;
+	int tmp;
+
+	/* nbytes can be arbitrary long, we spilt it into chunks */
+	while (nbytes) {
+		/* same as in extract_entropy_user in random.c */
+		if (need_resched()) {
+			if (signal_pending(current)) {
+				if (ret == 0)
+					ret = -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}
+
+		/*
+		 * we lose some random bytes if an attacker issues
+		 * reads < 8 bytes, but we don't care
+		 */
+		chunk = min_t(int, nbytes, prng_chunk_size);
+
+		/* PRNG only likes multiples of 8 bytes */
+		n = (chunk + 7) & -8;
+
+		if (p->count > prng_entropy_limit)
+			prng_seed(8);
+
+		/* if the CPU supports PRNG stckf is present too */
+		asm volatile(".insn	s,0xb27c0000,%0"
+			     : "=m" (*((unsigned long long *)p->buf)) : : "cc");
+
+		/*
+		 * Beside the STCKF the input for the TDES-EDE is the output
+		 * of the last operation. We differ here from X9.17 since we
+		 * only store one timestamp into the buffer. Padding the whole
+		 * buffer with timestamps does not improve security, since
+		 * successive stckf have nearly constant offsets.
+		 * If an attacker knows the first timestamp it would be
+		 * trivial to guess the additional values. One timestamp
+		 * is therefore enough and still guarantees unique input values.
+		 *
+		 * Note: you can still get strict X9.17 conformity by setting
+		 * prng_chunk_size to 8 bytes.
+		 */
+		tmp = crypt_s390_kmc(KMC_PRNG, parm_block, p->buf, p->buf, n);
+		BUG_ON((tmp < 0) || (tmp != n));
+
+		p->count += n;
+
+		if (copy_to_user(ubuf, p->buf, chunk))
+			return -EFAULT;
+
+		nbytes -= chunk;
+		ret += chunk;
+		ubuf += chunk;
+	}
+	return ret;
+}
+
+static struct file_operations prng_fops = {
+	.owner		= THIS_MODULE,
+	.open		= &prng_open,
+	.release	= NULL,
+	.read		= &prng_read,
+};
+
+static struct miscdevice prng_dev = {
+	.name	= "prandom",
+	.minor	= MISC_DYNAMIC_MINOR,
+	.fops	= &prng_fops,
+};
+
+static int __init prng_init(void)
+{
+	int ret;
+
+	/* check if the CPU has a PRNG */
+	if (!crypt_s390_func_available(KMC_PRNG))
+		return -ENOTSUPP;
+
+	p = kmalloc(sizeof(struct s390_prng_data), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	p->count = 0;
+
+	p->buf = kmalloc(prng_chunk_size, GFP_KERNEL);
+	if (!p->buf) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	/* initialize the PRNG, add 128 bits of entropy */
+	prng_seed(16);
+
+	ret = misc_register(&prng_dev);
+	if (ret) {
+		printk(KERN_WARNING
+		       "s390 PRNG driver not loaded. Could not register misc device.\n");
+		goto out_buf;
+	}
+	return 0;
+
+out_buf:
+	kfree(p->buf);
+out_free:
+	kfree(p);
+	return ret;
+}
+
+static void __exit prng_exit(void)
+{
+	/* wipe me */
+	memset(p->buf, 0, prng_chunk_size);
+	kfree(p->buf);
+	kfree(p);
+
+	misc_deregister(&prng_dev);
+}
+
+module_init(prng_init);
+module_exit(prng_exit);
diff -urNp linux-2.6.orig/arch/s390/defconfig linux-2.6/arch/s390/defconfig
--- linux-2.6.orig/arch/s390/defconfig	2007-01-12 09:50:41.000000000 +0100
+++ linux-2.6/arch/s390/defconfig	2007-01-16 13:03:12.000000000 +0100
@@ -459,6 +459,7 @@ CONFIG_MONWRITER=m
 #
 CONFIG_ZCRYPT=m
 # CONFIG_ZCRYPT_MONOLITHIC is not set
+CONFIG_S390_PRNG=m
 
 #
 # Network device support
diff -urNp linux-2.6.orig/drivers/s390/Kconfig linux-2.6/drivers/s390/Kconfig
--- linux-2.6.orig/drivers/s390/Kconfig	2006-11-17 10:26:36.000000000 +0100
+++ linux-2.6/drivers/s390/Kconfig	2007-01-16 13:03:12.000000000 +0100
@@ -244,4 +244,11 @@ config ZCRYPT_MONOLITHIC
 	  that contains all parts of the crypto device driver (ap bus,
 	  request router and all the card drivers).
 
+config S390_PRNG
+	tristate "Support for pseudo random number generator device driver"
+	help
+	  Select this option if you want to use the s390 pseudo random number generator.
+	  The PRNG is part of the cryptograhic processor functions and produces
+	  ANSI X9.17 conform numbers. The PRNG is usable via the char device /dev/prandom.
+
 endmenu


