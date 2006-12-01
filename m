Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936512AbWLAPVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936512AbWLAPVA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936511AbWLAPU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:20:59 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:33471 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S936457AbWLAPU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:20:58 -0500
Subject: Re: [RFC][PATCH] Pseudo-random number generator
From: Jan Glauber <jan.glauber@de.ibm.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061201133924.023289c4@localhost.localdomain>
References: <1164979155.5882.23.camel@bender>
	 <20061201133924.023289c4@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 16:20:46 +0100
Message-Id: <1164986446.5882.36.camel@bender>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 13:39 +0000, Alan wrote:
> > * merging the s390 PRNG with the random pool implementation
> > PRO: no new interface, random numbers can be read through /dev/urandom
> > CON: complex implementation, could only use traditional /dev/urandom algorithm
> >      or hardware-accelerated implementation
> 
> Also PRO: Can be verified by non-IBM people, high resistance if there is
> a flaw (accidental or US government 8)) in the 390 hardware.

No, the interesting stuff is done internally in the hardware, we cannot
see it with both implementations.

> > I've chosen the char driver since it allows the user to decide which pseudo-random
> > numbers he wants to use. That means there is a new interface for the s390
> > PRNG, called /dev/prandom.
> 
> And people can pipe this into the urandom layer if they wish.

Yes, a user can just symlink urandom to prandom and will have a faster
generator.

> > +/* copied from libica, use a non-zero initial parameter block */
> > +unsigned char parm_block[32] = {
> > +0x0F,0x2B,0x8E,0x63,0x8C,0x8E,0xD2,0x52,0x64,0xB7,0xA0,0x7B,0x75,0x28,0xB8,0xF4,
> > +0x75,0x5F,0xD2,0xA6,0x8D,0x97,0x11,0xFF,0x49,0xD8,0x23,0xF3,0x7E,0x21,0xEC,0xA0,
> > +};
> > +
> 
> Global variables called "p" and "parm_block". Plus parm_block appears to
> be const

Argh. I'll make them static.

> Also your register the misc device before allocating the buffer so it can
> be opened in theory before the alloc is done and crash.

Fixed. The misc_register is now done at the very end.

thanks,
Jan

---
 arch/s390/crypto/Makefile           |    1 
 arch/s390/crypto/crypt_s390.h       |    3 
 arch/s390/crypto/crypt_s390_query.c |    2 
 arch/s390/crypto/prng.c             |  203 ++++++++++++++++++++++++++++++++++++
 arch/s390/defconfig                 |    1 
 drivers/s390/Kconfig                |    7 +
 include/asm-s390/timex.h            |   12 ++
 7 files changed, 228 insertions(+), 1 deletion(-)

diff -urNp linux-2.5/arch/s390/crypto/Makefile linux-2.5_prng/arch/s390/crypto/Makefile
--- linux-2.5/arch/s390/crypto/Makefile	2006-12-01 15:40:54.000000000 +0100
+++ linux-2.5_prng/arch/s390/crypto/Makefile	2006-11-30 18:30:23.000000000 +0100
@@ -6,5 +6,6 @@ obj-$(CONFIG_CRYPTO_SHA1_S390) += sha1_s
 obj-$(CONFIG_CRYPTO_SHA256_S390) += sha256_s390.o
 obj-$(CONFIG_CRYPTO_DES_S390) += des_s390.o des_check_key.o
 obj-$(CONFIG_CRYPTO_AES_S390) += aes_s390.o
+obj-$(CONFIG_S390_PRNG) += prng.o
 
 obj-$(CONFIG_CRYPTO_TEST) += crypt_s390_query.o
diff -urNp linux-2.5/arch/s390/crypto/crypt_s390.h linux-2.5_prng/arch/s390/crypto/crypt_s390.h
--- linux-2.5/arch/s390/crypto/crypt_s390.h	2006-12-01 15:40:54.000000000 +0100
+++ linux-2.5_prng/arch/s390/crypto/crypt_s390.h	2006-12-01 15:38:00.000000000 +0100
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
diff -urNp linux-2.5/arch/s390/crypto/crypt_s390_query.c linux-2.5_prng/arch/s390/crypto/crypt_s390_query.c
--- linux-2.5/arch/s390/crypto/crypt_s390_query.c	2006-12-01 15:40:54.000000000 +0100
+++ linux-2.5_prng/arch/s390/crypto/crypt_s390_query.c	2006-12-01 15:37:27.000000000 +0100
@@ -54,6 +54,8 @@ static void query_available_functions(vo
 		crypt_s390_func_available(KMC_AES_192_ENCRYPT));
 	printk(KERN_INFO "KMC_AES_256: %d\n",
 		crypt_s390_func_available(KMC_AES_256_ENCRYPT));
+	printk(KERN_INFO "KMC_PRNG: %d\n",
+		crypt_s390_func_available(KMC_PRNG));
 
 	/* query available KIMD functions */
 	printk(KERN_INFO "KIMD_QUERY: %d\n",
diff -urNp linux-2.5/arch/s390/crypto/prng.c linux-2.5_prng/arch/s390/crypto/prng.c
--- linux-2.5/arch/s390/crypto/prng.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5_prng/arch/s390/crypto/prng.c	2006-12-01 16:14:22.000000000 +0100
@@ -0,0 +1,203 @@
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
+static int prng_chunk_size = 32;
+module_param(prng_chunk_size, int, 0);
+MODULE_PARM_DESC(prng_chunk_size, "PRNG read chunk size in bytes");
+
+static int prng_entropy_limit = 4096;
+module_param(prng_entropy_limit, int, 0);
+MODULE_PARM_DESC(prng_entropy_limit, "PRNG add entropy after that much bytes were produced");
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
+		entropy[0] = get_clock();
+		entropy[1] = get_clock();
+		entropy[2] = get_clock();
+		entropy[3] = get_clock();
+		ret = crypt_s390_kmc(KMC_PRNG, parm_block, (char *)entropy,
+				     (char *)entropy, sizeof(entropy));
+		BUG_ON(ret < 0 || ret != sizeof(entropy));
+		memcpy(parm_block, entropy, sizeof(entropy));
+	}
+}
+
+static ssize_t prng_read(struct file *file, char __user *ubuf, size_t nbytes,
+			 loff_t *ppos)
+{
+	unsigned long long clock[2];
+	int chunk, n, x;
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
+			prng_add_entropy();
+
+		/*
+		 * It shouldn't weaken the quality of the random numbers
+		 * passing the full 16 bytes from STCKE to the generator.
+		 */
+		for (x=0; x < n/16; x+=2) {
+			get_clock_extended(&clock);
+			*(__u64 *)(p->buf + x*8) = clock[0];
+			*(__u64 *)(p->buf + x*8 + 88) = clock[1];
+		}
+		if (n % 16) {
+			get_clock_extended(&clock);
+			*(__u64 *)(p->buf + x*8) = clock[0];
+		}
+
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
+	int nbytes = 16;
+	char buf[nbytes];
+	int i = 0;
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
+	get_random_bytes(buf, 16);
+	while (nbytes >= 8) {
+		*((__u64 *)parm_block) ^= *((__u64 *)buf+i*8);
+		prng_add_entropy();
+		i += 8;
+		nbytes -= 8;
+	}
+	prng_add_entropy();
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
diff -urNp linux-2.5/arch/s390/defconfig linux-2.5_prng/arch/s390/defconfig
--- linux-2.5/arch/s390/defconfig	2006-12-01 15:40:55.000000000 +0100
+++ linux-2.5_prng/arch/s390/defconfig	2006-11-30 18:30:23.000000000 +0100
@@ -437,6 +437,7 @@ CONFIG_MONWRITER=m
 #
 CONFIG_ZCRYPT=m
 # CONFIG_ZCRYPT_MONOLITHIC is not set
+CONFIG_S390_PRNG=m
 
 #
 # Network device support
diff -urNp linux-2.5/drivers/s390/Kconfig linux-2.5_prng/drivers/s390/Kconfig
--- linux-2.5/drivers/s390/Kconfig	2006-12-01 15:40:55.000000000 +0100
+++ linux-2.5_prng/drivers/s390/Kconfig	2006-11-30 18:30:23.000000000 +0100
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
diff -urNp linux-2.5/include/asm-s390/timex.h linux-2.5_prng/include/asm-s390/timex.h
--- linux-2.5/include/asm-s390/timex.h	2006-12-01 15:40:55.000000000 +0100
+++ linux-2.5_prng/include/asm-s390/timex.h	2006-11-30 18:30:23.000000000 +0100
@@ -62,6 +62,18 @@ static inline unsigned long long get_clo
 	return clk;
 }
 
+static inline void get_clock_extended(void *dest)
+{
+	typedef struct { unsigned long long clk[2]; } clock_t;
+
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
+	asm volatile("stcke %0" : "=Q" (*((clock_t *)dest)) : : "cc");
+#else /* __GNUC__ */
+	asm volatile("stcke 0(%1)" : "=m" (*((clock_t *)dest))
+				   : "a" ((clock_t *)dest) : "cc");
+#endif /* __GNUC__ */
+}
+
 static inline cycles_t get_cycles(void)
 {
 	return (cycles_t) get_clock() >> 2;


