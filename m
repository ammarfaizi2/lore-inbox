Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWB1L3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWB1L3p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWB1L3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:29:45 -0500
Received: from mout2.freenet.de ([194.97.50.155]:59553 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932177AbWB1L3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:29:44 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: akpm@osdl.org
Subject: [PATCH] Generic hardware RNG support
Date: Tue, 28 Feb 2006 12:29:12 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Message-Id: <200602281229.12887.mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
Content-Type: multipart/signed;
  boundary="nextPart228231637.ODx8vXy5KF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart228231637.ODx8vXy5KF
Content-Type: multipart/mixed;
  boundary="Boundary-01=_IQDBE0qVmxlxrWs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_IQDBE0qVmxlxrWs
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Andrew, consider inclusion of the following patch into -mm
for further testing, please.

=2D--

This patch adds support for generic Hardware Random Number Generator
drivers. This makes the usage of the bcm43xx internal RNG through
/dev/hwrandom possible.

A patch against bcm43xx for your testing pleasure can be found at:
ftp://ftp.bu3sch.de/misc/bcm43xx-d80211-hwrng.patch


diff -urNX 2.6.16-rc4-mm2/Documentation/dontdiff 2.6.16-rc4-mm2.orig/driver=
s/char/hw_random.c 2.6.16-rc4-mm2/drivers/char/hw_random.c
=2D-- 2.6.16-rc4-mm2.orig/drivers/char/hw_random.c	2006-02-28 11:54:50.0000=
00000 +0100
+++ 2.6.16-rc4-mm2/drivers/char/hw_random.c	2006-02-28 12:07:56.000000000 +=
0100
@@ -18,6 +18,9 @@
 	Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
 	Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
=20
+	Added generic RNG API
+	Copyright 2006 Michael Buesch <mbuesch@freenet.de>
+
 	Please read Documentation/hw_random.txt for details on use.
=20
 	----------------------------------------------------------
@@ -27,11 +30,12 @@
  */
=20
=20
+#include <linux/hw_random.h>
+#include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/init.h>
=2D#include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/random.h>
@@ -49,13 +53,9 @@
 #include <asm/uaccess.h>
=20
=20
=2D/*
=2D * core module and version information
=2D */
=2D#define RNG_VERSION "1.0.0"
=2D#define RNG_MODULE_NAME "hw_random"
=2D#define RNG_DRIVER_NAME   RNG_MODULE_NAME " hardware driver " RNG_VERSION
=2D#define PFX RNG_MODULE_NAME ": "
+#define RNG_MODULE_NAME		"hw_random"
+#define RNG_DRIVER_NAME		RNG_MODULE_NAME " hardware driver"
+#define PFX RNG_MODULE_NAME	": "
=20
=20
 /*
@@ -83,36 +83,31 @@
 static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t s=
ize,
 				loff_t * offp);
=20
=2Dstatic int __init intel_init (struct pci_dev *dev);
=2Dstatic void intel_cleanup(void);
=2Dstatic unsigned int intel_data_present (void);
=2Dstatic u32 intel_data_read (void);
=2D
=2Dstatic int __init amd_init (struct pci_dev *dev);
=2Dstatic void amd_cleanup(void);
=2Dstatic unsigned int amd_data_present (void);
=2Dstatic u32 amd_data_read (void);
+static int __init intel_init (struct hwrng *rng);
+static void intel_cleanup(struct hwrng *rng);
+static unsigned int intel_data_present (struct hwrng *rng);
+static u32 intel_data_read (struct hwrng *rng);
+
+static int __init amd_init (struct hwrng *rng);
+static void amd_cleanup(struct hwrng *rng);
+static unsigned int amd_data_present (struct hwrng *rng);
+static u32 amd_data_read (struct hwrng *rng);
=20
 #ifdef __i386__
=2Dstatic int __init via_init(struct pci_dev *dev);
=2Dstatic void via_cleanup(void);
=2Dstatic unsigned int via_data_present (void);
=2Dstatic u32 via_data_read (void);
+static int __init via_init(struct hwrng *rng);
+static void via_cleanup(struct hwrng *rng);
+static unsigned int via_data_present (struct hwrng *rng);
+static u32 via_data_read (struct hwrng *rng);
 #endif
=20
=2Dstatic int __init geode_init(struct pci_dev *dev);
=2Dstatic void geode_cleanup(void);
=2Dstatic unsigned int geode_data_present (void);
=2Dstatic u32 geode_data_read (void);
=2D
=2Dstruct rng_operations {
=2D	int (*init) (struct pci_dev *dev);
=2D	void (*cleanup) (void);
=2D	unsigned int (*data_present) (void);
=2D	u32 (*data_read) (void);
=2D	unsigned int n_bytes; /* number of bytes per ->data_read */
=2D};
=2Dstatic struct rng_operations *rng_ops;
+static int __init geode_init(struct hwrng *rng);
+static void geode_cleanup(struct hwrng *rng);
+static unsigned int geode_data_present (struct hwrng *rng);
+static u32 geode_data_read (struct hwrng *rng);
+
+static struct hwrng *current_rng;
+static LIST_HEAD(rng_list);
+static DEFINE_MUTEX(rng_mutex);
=20
 static struct file_operations rng_chrdev_ops =3D {
 	.owner		=3D THIS_MODULE,
@@ -122,9 +117,9 @@
=20
=20
 static struct miscdevice rng_miscdev =3D {
=2D	RNG_MISCDEV_MINOR,
=2D	RNG_MODULE_NAME,
=2D	&rng_chrdev_ops,
+	.minor		=3D RNG_MISCDEV_MINOR,
+	.name		=3D RNG_MODULE_NAME,
+	.fops		=3D &rng_chrdev_ops,
 };
=20
 enum {
@@ -135,24 +130,41 @@
 	rng_hw_geode,
 };
=20
=2Dstatic struct rng_operations rng_vendor_ops[] =3D {
=2D	/* rng_hw_none */
=2D	{ },
=2D
=2D	/* rng_hw_intel */
=2D	{ intel_init, intel_cleanup, intel_data_present,
=2D	  intel_data_read, 1 },
=2D
=2D	/* rng_hw_amd */
=2D	{ amd_init, amd_cleanup, amd_data_present, amd_data_read, 4 },
=2D
+static struct hwrng rng_vendor_ops[] =3D {
+	{ /* rng_hw_none */
+	}, { /* rng_hw_intel */
+		.name		=3D "intel",
+		.init		=3D intel_init,
+		.cleanup	=3D intel_cleanup,
+		.data_present	=3D intel_data_present,
+		.data_read	=3D intel_data_read,
+		.n_bytes	=3D 1,
+	}, { /* rng_hw_amd */
+		.name		=3D "amd",
+		.init		=3D amd_init,
+		.cleanup	=3D amd_cleanup,
+		.data_present	=3D amd_data_present,
+		.data_read	=3D amd_data_read,
+		.n_bytes	=3D 4,
+	},
 #ifdef __i386__
=2D	/* rng_hw_via */
=2D	{ via_init, via_cleanup, via_data_present, via_data_read, 1 },
+	{ /* rng_hw_via */
+		.name		=3D "via",
+		.init		=3D via_init,
+		.cleanup	=3D via_cleanup,
+		.data_present	=3D via_data_present,
+		.data_read	=3D via_data_read,
+		.n_bytes	=3D 1,
+	},
 #endif
=2D
=2D	/* rng_hw_geode */
=2D	{ geode_init, geode_cleanup, geode_data_present, geode_data_read, 4 }
+	{ /* rng_hw_geode */
+		.name		=3D "geode",
+		.init		=3D geode_init,
+		.cleanup	=3D geode_cleanup,
+		.data_present	=3D geode_data_present,
+		.data_read	=3D geode_data_read,
+		.n_bytes	=3D 4,
+	},
 };
=20
 /*
@@ -204,39 +216,39 @@
 #define INTEL_RNG_ADDR				0xFFBC015F
 #define INTEL_RNG_ADDR_LEN			3
=20
=2D/* token to our ioremap'd RNG register area */
=2Dstatic void __iomem *rng_mem;
=2D
=2Dstatic inline u8 intel_hwstatus (void)
+static inline u8 intel_hwstatus (void __iomem *rng_mem)
 {
 	assert (rng_mem !=3D NULL);
 	return readb (rng_mem + INTEL_RNG_HW_STATUS);
 }
=20
=2Dstatic inline u8 intel_hwstatus_set (u8 hw_status)
+static inline u8 intel_hwstatus_set (void __iomem *rng_mem, u8 hw_status)
 {
 	assert (rng_mem !=3D NULL);
 	writeb (hw_status, rng_mem + INTEL_RNG_HW_STATUS);
=2D	return intel_hwstatus ();
+	return intel_hwstatus (rng_mem);
 }
=20
=2Dstatic unsigned int intel_data_present(void)
+static unsigned int intel_data_present(struct hwrng *rng)
 {
=2D	assert (rng_mem !=3D NULL);
+	void __iomem *rng_mem =3D (void __iomem *)rng->priv;
=20
+	assert (rng_mem !=3D NULL);
 	return (readb (rng_mem + INTEL_RNG_STATUS) & INTEL_RNG_DATA_PRESENT) ?
 		1 : 0;
 }
=20
=2Dstatic u32 intel_data_read(void)
+static u32 intel_data_read(struct hwrng *rng)
 {
=2D	assert (rng_mem !=3D NULL);
+	void __iomem *rng_mem =3D (void __iomem *)rng->priv;
=20
+	assert (rng_mem !=3D NULL);
 	return readb (rng_mem + INTEL_RNG_DATA);
 }
=20
=2Dstatic int __init intel_init (struct pci_dev *dev)
+static int __init intel_init(struct hwrng *rng)
 {
+	void __iomem *rng_mem;
 	int rc;
 	u8 hw_status;
=20
@@ -248,9 +260,10 @@
 		rc =3D -EBUSY;
 		goto err_out;
 	}
+	rng->priv =3D (unsigned long)rng_mem;
=20
 	/* Check for Intel 82802 */
=2D	hw_status =3D intel_hwstatus ();
+	hw_status =3D intel_hwstatus (rng_mem);
 	if ((hw_status & INTEL_RNG_PRESENT) =3D=3D 0) {
 		printk (KERN_ERR PFX "RNG not detected\n");
 		rc =3D -ENODEV;
@@ -259,7 +272,7 @@
=20
 	/* turn RNG h/w on, if it's off */
 	if ((hw_status & INTEL_RNG_ENABLED) =3D=3D 0)
=2D		hw_status =3D intel_hwstatus_set (hw_status | INTEL_RNG_ENABLED);
+		hw_status =3D intel_hwstatus_set (rng_mem, hw_status | INTEL_RNG_ENABLED=
);
 	if ((hw_status & INTEL_RNG_ENABLED) =3D=3D 0) {
 		printk (KERN_ERR PFX "cannot enable RNG, aborting\n");
 		rc =3D -EIO;
@@ -271,23 +284,22 @@
=20
 err_out_free_map:
 	iounmap (rng_mem);
=2D	rng_mem =3D NULL;
 err_out:
 	DPRINTK ("EXIT, returning %d\n", rc);
 	return rc;
 }
=20
=2Dstatic void intel_cleanup(void)
+static void intel_cleanup(struct hwrng *rng)
 {
+	void __iomem *rng_mem =3D (void __iomem *)rng->priv;
 	u8 hw_status;
=20
=2D	hw_status =3D intel_hwstatus ();
+	hw_status =3D intel_hwstatus (rng_mem);
 	if (hw_status & INTEL_RNG_ENABLED)
=2D		intel_hwstatus_set (hw_status & ~INTEL_RNG_ENABLED);
+		intel_hwstatus_set (rng_mem, hw_status & ~INTEL_RNG_ENABLED);
 	else
 		printk(KERN_WARNING PFX "unusual: RNG already disabled\n");
 	iounmap(rng_mem);
=2D	rng_mem =3D NULL;
 }
=20
 /***********************************************************************
@@ -296,22 +308,25 @@
  *
  */
=20
=2Dstatic u32 pmbase;			/* PMxx I/O base */
=2Dstatic struct pci_dev *amd_dev;
=2D
=2Dstatic unsigned int amd_data_present (void)
+static unsigned int amd_data_present (struct hwrng *rng)
 {
+	u32 pmbase =3D (u32)rng->priv;
+
       	return inl(pmbase + 0xF4) & 1;
 }
=20
=20
=2Dstatic u32 amd_data_read (void)
+static u32 amd_data_read (struct hwrng *rng)
 {
+	u32 pmbase =3D (u32)rng->priv;
+
 	return inl(pmbase + 0xF0);
 }
=20
=2Dstatic int __init amd_init (struct pci_dev *dev)
+static int __init amd_init(struct hwrng *rng)
 {
+	u32 pmbase;
+	struct pci_dev *dev =3D rng->dev;
 	int rc;
 	u8 rnen;
=20
@@ -327,6 +342,7 @@
 		rc =3D -EIO;
 		goto err_out;
 	}
+	rng->priv =3D (unsigned long)pmbase;
=20
 	pci_read_config_byte(dev, 0x40, &rnen);
 	rnen |=3D (1 << 7);	/* RNG on */
@@ -339,8 +355,6 @@
 	pr_info( PFX "AMD768 system management I/O registers at 0x%X.\n",
 			pmbase);
=20
=2D	amd_dev =3D dev;
=2D
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
=20
@@ -349,13 +363,13 @@
 	return rc;
 }
=20
=2Dstatic void amd_cleanup(void)
+static void amd_cleanup(struct hwrng *rng)
 {
 	u8 rnen;
=20
=2D	pci_read_config_byte(amd_dev, 0x40, &rnen);
+	pci_read_config_byte(rng->dev, 0x40, &rnen);
 	rnen &=3D ~(1 << 7);	/* RNG off */
=2D	pci_write_config_byte(amd_dev, 0x40, rnen);
+	pci_write_config_byte(rng->dev, 0x40, rnen);
=20
 	/* FIXME: twiddle pmio, also? */
 }
@@ -384,8 +398,6 @@
 	VIA_RNG_CHUNK_1_MASK	=3D 0xFF,
 };
=20
=2Dstatic u32 via_rng_datum;
=2D
 /*
  * Investigate using the 'rep' prefix to obtain 32 bits of random data
  * in one insn.  The upside is potentially better performance.  The
@@ -411,9 +423,10 @@
 	return eax_out;
 }
=20
=2Dstatic unsigned int via_data_present(void)
+static unsigned int via_data_present(struct hwrng *rng)
 {
 	u32 bytes_out;
+	u32 *via_rng_datum =3D (u32 *)(&rng->priv);
=20
 	/* We choose the recommended 1-byte-per-instruction RNG rate,
 	 * for greater randomness at the expense of speed.  Larger
@@ -427,20 +440,23 @@
 	 * A copy of MSR_VIA_RNG is placed in eax_out when xstore
 	 * completes.
 	 */
=2D	via_rng_datum =3D 0; /* paranoia, not really necessary */
=2D	bytes_out =3D xstore(&via_rng_datum, VIA_RNG_CHUNK_1) & VIA_XSTORE_CNT_=
MASK;
+
+	*via_rng_datum =3D 0; /* paranoia, not really necessary */
+	bytes_out =3D xstore(via_rng_datum, VIA_RNG_CHUNK_1) & VIA_XSTORE_CNT_MAS=
K;
 	if (bytes_out =3D=3D 0)
 		return 0;
=20
 	return 1;
 }
=20
=2Dstatic u32 via_data_read(void)
+static u32 via_data_read(struct hwrng *rng)
 {
+	u32 via_rng_datum =3D (u32)rng->priv;
+
 	return via_rng_datum;
 }
=20
=2Dstatic int __init via_init(struct pci_dev *dev)
+static int __init via_init(struct hwrng *rng)
 {
 	u32 lo, hi, old_lo;
=20
@@ -472,7 +488,7 @@
 	return 0;
 }
=20
=2Dstatic void via_cleanup(void)
+static void via_cleanup(struct hwrng *rng)
 {
 	/* do nothing */
 }
@@ -484,13 +500,12 @@
  *
  */
=20
=2Dstatic void __iomem *geode_rng_base =3D NULL;
=2D
 #define GEODE_RNG_DATA_REG   0x50
 #define GEODE_RNG_STATUS_REG 0x54
=20
=2Dstatic u32 geode_data_read(void)
+static u32 geode_data_read(struct hwrng *rng)
 {
+	void __iomem *geode_rng_base =3D (void __iomem *)rng->priv;
 	u32 val;
=20
 	assert(geode_rng_base !=3D NULL);
@@ -498,8 +513,9 @@
 	return val;
 }
=20
=2Dstatic unsigned int geode_data_present(void)
+static unsigned int geode_data_present(struct hwrng *rng)
 {
+	void __iomem *geode_rng_base =3D (void __iomem *)rng->priv;
 	u32 val;
=20
 	assert(geode_rng_base !=3D NULL);
@@ -507,14 +523,18 @@
 	return val;
 }
=20
=2Dstatic void geode_cleanup(void)
+static void geode_cleanup(struct hwrng *rng)
 {
+	void __iomem *geode_rng_base =3D (void __iomem *)rng->priv;
+
 	iounmap(geode_rng_base);
   	geode_rng_base =3D NULL;
 }
=20
=2Dstatic int geode_init(struct pci_dev *dev)
+static int geode_init(struct hwrng *rng)
 {
+	void __iomem *geode_rng_base;
+	struct pci_dev *dev =3D rng->dev;
 	unsigned long rng_base =3D pci_resource_start(dev, 0);
=20
 	if (rng_base =3D=3D 0)
@@ -526,6 +546,7 @@
 		printk(KERN_ERR PFX "Cannot ioremap RNG memory\n");
 		return -EBUSY;
 	}
+	rng->priv =3D (unsigned long)geode_rng_base;
=20
 	return 0;
 }
@@ -543,7 +564,6 @@
 		return -EINVAL;
 	if (filp->f_mode & FMODE_WRITE)
 		return -EINVAL;
=2D
 	return 0;
 }
=20
@@ -551,21 +571,26 @@
 static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t s=
ize,
 				loff_t * offp)
 {
=2D	static DEFINE_SPINLOCK(rng_lock);
 	unsigned int have_data;
 	u32 data =3D 0;
 	ssize_t ret =3D 0;
+	int err;
=20
 	while (size) {
=2D		spin_lock(&rng_lock);
=2D
+		err =3D mutex_lock_interruptible(&rng_mutex);
+		if (err)
+			return err;
+		if (!current_rng) {
+			mutex_unlock(&rng_mutex);
+			return -ENODEV;
+		}
 		have_data =3D 0;
=2D		if (rng_ops->data_present()) {
=2D			data =3D rng_ops->data_read();
=2D			have_data =3D rng_ops->n_bytes;
+		if (current_rng->data_present =3D=3D NULL ||
+		    current_rng->data_present(current_rng)) {
+			data =3D current_rng->data_read(current_rng);
+			have_data =3D current_rng->n_bytes;
 		}
=2D
=2D		spin_unlock (&rng_lock);
+		mutex_unlock(&rng_mutex);
=20
 		while (have_data && size) {
 			if (put_user((u8)data, buf++)) {
@@ -593,38 +618,186 @@
 }
=20
=20
+static ssize_t hwrng_attr_current_store(struct class_device *class,
+					const char *buf, size_t len)
+{
+	int err =3D -ENODEV;
+	struct hwrng *rng;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	err =3D mutex_lock_interruptible(&rng_mutex);
+	if (err)
+		return err;
+	err =3D -ENODEV;
+	list_for_each_entry(rng, &rng_list, list) {
+		if (strncmp(rng->name, buf, len) =3D=3D 0) {
+			if (rng->init) {
+				err =3D rng->init(rng);
+				if (err)
+					break;
+			}
+			if (current_rng && current_rng->cleanup)
+				current_rng->cleanup(current_rng);
+			current_rng =3D rng;
+			err =3D 0;
+			break;
+		}
+	}
+	mutex_unlock(&rng_mutex);
=20
=2D/*
=2D * rng_init_one - look for and attempt to init a single RNG
=2D */
=2Dstatic int __init rng_init_one (struct pci_dev *dev)
+	return err ? err : len;
+}
+
+static ssize_t hwrng_attr_current_show(struct class_device *class,
+				       char *buf)
 {
=2D	int rc;
+	int err;
+	ssize_t ret;
+	const char *name;
=20
=2D	DPRINTK ("ENTER\n");
+	err =3D mutex_lock_interruptible(&rng_mutex);
+	if (err)
+		return err;
+	if (current_rng)
+		name =3D current_rng->name;
+	else
+		name =3D "none";
+	ret =3D sprintf(buf, "%s\n", name);
+	mutex_unlock(&rng_mutex);
=20
=2D	assert(rng_ops !=3D NULL);
+	return ret;
+}
=20
=2D	rc =3D rng_ops->init(dev);
=2D	if (rc)
=2D		goto err_out;
+static ssize_t hwrng_attr_available_show(struct class_device *class,
+					 char *buf)
+{
+	int err;
+	ssize_t ret =3D 0;
+	struct hwrng *rng;
=20
=2D	rc =3D misc_register (&rng_miscdev);
=2D	if (rc) {
=2D		printk (KERN_ERR PFX "misc device register failed\n");
=2D		goto err_out_cleanup_hw;
+	err =3D mutex_lock_interruptible(&rng_mutex);
+	if (err)
+		return err;
+	buf[0] =3D '\0';
+	list_for_each_entry(rng, &rng_list, list) {
+		ret +=3D strlen(rng->name);
+		strcat(buf, rng->name);
+		ret +=3D 1;
+		strcat(buf, " ");
 	}
+	strcat(buf, "\n");
+	ret +=3D 1;
+	mutex_unlock(&rng_mutex);
=20
=2D	DPRINTK ("EXIT, returning 0\n");
=2D	return 0;
+	return ret;
+}
=20
=2Derr_out_cleanup_hw:
=2D	rng_ops->cleanup();
=2Derr_out:
=2D	DPRINTK ("EXIT, returning %d\n", rc);
=2D	return rc;
+static CLASS_DEVICE_ATTR(rng_current, S_IRUGO | S_IWUSR,
+			 hwrng_attr_current_show,
+			 hwrng_attr_current_store);
+static CLASS_DEVICE_ATTR(rng_available, S_IRUGO,
+			 hwrng_attr_available_show,
+			 NULL);
+
+
+static void unregister_miscdev(void)
+{
+	class_device_remove_file(rng_miscdev.class,
+				 &class_device_attr_rng_available);
+	class_device_remove_file(rng_miscdev.class,
+				 &class_device_attr_rng_current);
+	misc_deregister(&rng_miscdev);
+}
+
+static int register_miscdev(void)
+{
+	int err;
+
+	err =3D misc_register(&rng_miscdev);
+	if (err)
+		goto out;
+	err =3D class_device_create_file(rng_miscdev.class,
+				       &class_device_attr_rng_current);
+	if (err)
+		goto err_misc_dereg;
+	err =3D class_device_create_file(rng_miscdev.class,
+				       &class_device_attr_rng_available);
+	if (err)
+		goto err_remove_current;
+out:
+	return err;
+
+err_remove_current:
+	class_device_remove_file(rng_miscdev.class,
+				 &class_device_attr_rng_current);
+err_misc_dereg:
+	misc_deregister(&rng_miscdev);
+	goto out;
+}
+
+int hwrng_register(struct hwrng *rng)
+{
+	int must_register_misc;
+	int err;
+	struct hwrng *old_current;
+
+	if (rng->name =3D=3D NULL)
+		return -EINVAL;
+	if (rng->data_read =3D=3D NULL)
+		return -EINVAL;
+	if (rng->n_bytes < 1 || rng->n_bytes > sizeof(u32))
+		return -EINVAL;
+
+	mutex_lock(&rng_mutex);
+	must_register_misc =3D (current_rng =3D=3D NULL);
+	old_current =3D current_rng;
+	if (!current_rng) {
+		if (rng->init) {
+			err =3D rng->init(rng);
+			if (err) {
+				mutex_unlock(&rng_mutex);
+				return err;
+			}
+		}
+		current_rng =3D rng;
+	}
+	INIT_LIST_HEAD(&rng->list);
+	list_add_tail(&rng->list, &rng_list);
+	err =3D 0;
+	if (must_register_misc) {
+		err =3D register_miscdev();
+		if (err) {
+			if (rng->cleanup)
+				rng->cleanup(rng);
+			list_del(&rng->list);
+			current_rng =3D old_current;
+		}
+	}
+
+	mutex_unlock(&rng_mutex);
+
+	return err;
 }
+EXPORT_SYMBOL_GPL(hwrng_register);
=20
+void hwrng_unregister(struct hwrng *rng)
+{
+	mutex_lock(&rng_mutex);
+	list_del(&rng->list);
+	if (current_rng =3D=3D rng) {
+		if (rng->cleanup)
+			rng->cleanup(rng);
+		if (list_empty(&rng_list))
+			current_rng =3D NULL;
+		else
+			current_rng =3D list_entry(rng_list.prev, struct hwrng, list);
+	}
+	if (list_empty(&rng_list))
+		unregister_miscdev();
+	mutex_unlock(&rng_mutex);
+}
+EXPORT_SYMBOL_GPL(hwrng_unregister);
=20
=20
 MODULE_AUTHOR("The Linux Kernel team");
@@ -637,7 +810,7 @@
  */
 static int __init rng_init (void)
 {
=2D	int rc;
+	int err;
 	struct pci_dev *pdev =3D NULL;
 	const struct pci_device_id *ent;
=20
@@ -647,28 +820,30 @@
 	for_each_pci_dev(pdev) {
 		ent =3D pci_match_id(rng_pci_tbl, pdev);
 		if (ent) {
=2D			rng_ops =3D &rng_vendor_ops[ent->driver_data];
=2D			goto match;
+			err =3D hwrng_register(&rng_vendor_ops[ent->driver_data]);
+			if (err) {
+				printk(KERN_ERR PFX "Could not register Intel, "
+						    "AMD or Geode RNG\n");
+				return err;
+			}
+			goto out;
 		}
 	}
=20
 #ifdef __i386__
 	/* Probe for VIA RNG */
 	if (cpu_has_xstore) {
=2D		rng_ops =3D &rng_vendor_ops[rng_hw_via];
=2D		pdev =3D NULL;
=2D		goto match;
+		err =3D hwrng_register(&rng_vendor_ops[rng_hw_via]);
+		if (err) {
+			printk(KERN_ERR PFX "Could not register VIA RNG\n");
+			return err;
+		}
+		goto out;
 	}
 #endif
=20
=2D	DPRINTK ("EXIT, returning -ENODEV\n");
=2D	return -ENODEV;
=2D
=2Dmatch:
=2D	rc =3D rng_init_one (pdev);
=2D	if (rc)
=2D		return rc;
=2D
+	DPRINTK ("no device found\n");
+out:
 	pr_info( RNG_DRIVER_NAME " loaded\n");
=20
 	DPRINTK ("EXIT, returning 0\n");
@@ -683,10 +858,8 @@
 {
 	DPRINTK ("ENTER\n");
=20
=2D	misc_deregister (&rng_miscdev);
=2D
=2D	if (rng_ops->cleanup)
=2D		rng_ops->cleanup();
+	if (current_rng)
+		hwrng_unregister(current_rng);
=20
 	DPRINTK ("EXIT\n");
 }
diff -urNX 2.6.16-rc4-mm2/Documentation/dontdiff 2.6.16-rc4-mm2.orig/driver=
s/char/Kconfig 2.6.16-rc4-mm2/drivers/char/Kconfig
=2D-- 2.6.16-rc4-mm2.orig/drivers/char/Kconfig	2006-02-28 11:54:48.00000000=
0 +0100
+++ 2.6.16-rc4-mm2/drivers/char/Kconfig	2006-02-28 11:55:34.000000000 +0100
@@ -653,8 +653,8 @@
 	  If you're not sure, say N.
=20
 config HW_RANDOM
=2D	tristate "Intel/AMD/VIA HW Random Number Generator support"
=2D	depends on (X86 || IA64) && PCI
+	tristate "Intel/AMD/VIA/Generic HW Random Number Generator support"
+	depends on PCI
 	---help---
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on Intel i8xx-based motherboards,
diff -urNX 2.6.16-rc4-mm2/Documentation/dontdiff 2.6.16-rc4-mm2.orig/includ=
e/linux/hw_random.h 2.6.16-rc4-mm2/include/linux/hw_random.h
=2D-- 2.6.16-rc4-mm2.orig/include/linux/hw_random.h	1970-01-01 01:00:00.000=
000000 +0100
+++ 2.6.16-rc4-mm2/include/linux/hw_random.h	2006-02-28 11:55:34.000000000 =
+0100
@@ -0,0 +1,48 @@
+/*
+	Hardware Random Number Generator
+
+	Please read Documentation/hw_random.txt for details on use.
+
+	----------------------------------------------------------
+	This software may be used and distributed according to the terms
+        of the GNU General Public License, incorporated herein by referenc=
e.
+
+ */
+
+#ifndef LINUX_HWRANDOM_H_
+#define LINUX_HWRANDOM_H_
+
+#include <linux/types.h>
+#include <linux/list.h>
+
+struct pci_dev;
+
+struct hwrng {
+	/** Unique name. */
+	const char *name;
+	/** Pointer to the PCI device (can be NULL). */
+	struct pci_dev *dev;
+
+	/** Initialization callback. */
+	int (*init) (struct hwrng *rng);
+	/** Cleanup callback. */
+	void (*cleanup) (struct hwrng *rng);
+	/** Is the RNG able to provide data now? */
+	unsigned int (*data_present) (struct hwrng *rng);
+	/** Read data from the RNG device. */
+	u32 (*data_read) (struct hwrng *rng);
+	/** Number of bytes read per data_read() call.
+	  * This must be > 0 and < sizeof(u32).
+	  */
+	unsigned int n_bytes;
+	/** Private data, for use by the RNG driver. */
+	unsigned long priv;
+
+	/* internal. */
+	struct list_head list;
+};
+
+extern int hwrng_register(struct hwrng *rng);
+extern void hwrng_unregister(struct hwrng *rng);
+
+#endif /* LINUX_HWRANDOM_H_ */

=2D-=20
Greetings Michael.

--Boundary-01=_IQDBE0qVmxlxrWs
Content-Type: application/x-bzip2;
  name="hw_random-generic_2.6.16-rc4-mm2.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="hw_random-generic_2.6.16-rc4-mm2.patch.bz2"

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

--Boundary-01=_IQDBE0qVmxlxrWs--

--nextPart228231637.ODx8vXy5KF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEBDQIlb09HEdWDKgRAhJmAJ4w/VxmwlbNHs9isSiC7XGuMo07rACgsxGP
y1p+zwUeSJuZeLPlkG+jgzU=
=z/Yt
-----END PGP SIGNATURE-----

--nextPart228231637.ODx8vXy5KF--
