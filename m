Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265082AbUF1Qm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbUF1Qm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUF1QmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:42:16 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:17827 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S265075AbUF1Ql1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:41:27 -0400
Date: Tue, 29 Jun 2004 02:41:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, boutcher@us.ibm.com,
       katzj@redhat.com, ipseries-list@redhat.com,
       linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] 5/5 PPC64 - viotape integration
Message-Id: <20040629024126.4eabe1d2.sfr@canb.auug.org.au>
In-Reply-To: <20040629023956.3f2dab50.sfr@canb.auug.org.au>
References: <20040629022806.4fda7605.sfr@canb.auug.org.au>
	<20040629023327.5a48b499.sfr@canb.auug.org.au>
	<20040629023509.295d70dc.sfr@canb.auug.org.au>
	<20040629023825.01a629de.sfr@canb.auug.org.au>
	<20040629023956.3f2dab50.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__29_Jun_2004_02_41_27_+1000_pks9DdvYI0=oNBz1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__29_Jun_2004_02_41_27_+1000_pks9DdvYI0=oNBz1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.7-bk9.base.sysvio.4/arch/ppc64/kernel/vio.c 2.6.7-bk9.base.sysvio.5/arch/ppc64/kernel/vio.c
--- 2.6.7-bk9.base.sysvio.4/arch/ppc64/kernel/vio.c	2004-06-29 01:48:10.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.5/arch/ppc64/kernel/vio.c	2004-06-29 01:56:56.000000000 +1000
@@ -237,6 +237,8 @@
 		vio_register_device_iseries("viodasd", i);
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALCDROMS; i++)
 		vio_register_device_iseries("viocd", i);
+	for (i = 0; i < HVMAXARCHITECTEDVIRTUALTAPES; i++)
+		vio_register_device_iseries("viotape", i);
 }
 #endif
 
diff -ruN 2.6.7-bk9.base.sysvio.4/drivers/char/viotape.c 2.6.7-bk9.base.sysvio.5/drivers/char/viotape.c
--- 2.6.7-bk9.base.sysvio.4/drivers/char/viotape.c	2004-05-10 15:31:09.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.5/drivers/char/viotape.c	2004-06-20 01:17:34.000000000 +1000
@@ -53,6 +53,7 @@
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
+#include <asm/vio.h>
 #include <asm/iSeries/vio.h>
 #include <asm/iSeries/HvLpEvent.h>
 #include <asm/iSeries/HvCallEvent.h>
@@ -216,7 +217,7 @@
 };
 
 /* Maximum number of tapes we support */
-#define VIOTAPE_MAX_TAPE	8
+#define VIOTAPE_MAX_TAPE	HVMAXARCHITECTEDVIRTUALTAPES
 #define MAX_PARTITIONS		4
 
 /* defines for current tape state */
@@ -238,6 +239,8 @@
 
 static struct class_simple *tape_class;
 
+static struct device *tape_device[VIOTAPE_MAX_TAPE];
+
 /*
  * maintain the current state of each tape (and partition)
  * so that we know when to write EOF marks.
@@ -262,6 +265,7 @@
 	int			rc;
 	int			non_blocking;
 	struct completion	com;
+	struct device		*dev;
 	struct op_struct	*next;
 };
 
@@ -459,7 +463,8 @@
 		down(&reqSem);
 
 	/* Allocate a DMA buffer */
-	op->buffer = dma_alloc_coherent(iSeries_vio_dev, count, &op->dmaaddr,
+	op->dev = tape_device[devi.devno];
+	op->buffer = dma_alloc_coherent(op->dev, count, &op->dmaaddr,
 			GFP_ATOMIC);
 
 	if (op->buffer == NULL) {
@@ -509,7 +514,7 @@
 	}
 
 free_dma:
-	dma_free_coherent(iSeries_vio_dev, count, op->buffer, op->dmaaddr);
+	dma_free_coherent(op->dev, count, op->buffer, op->dmaaddr);
 up_sem:
 	up(&reqSem);
 free_op:
@@ -550,7 +555,8 @@
 	chg_state(devi.devno, VIOT_READING, file);
 
 	/* Allocate a DMA buffer */
-	op->buffer = dma_alloc_coherent(iSeries_vio_dev, count, &op->dmaaddr,
+	op->dev = tape_device[devi.devno];
+	op->buffer = dma_alloc_coherent(op->dev, count, &op->dmaaddr,
 			GFP_ATOMIC);
 	if (op->buffer == NULL) {
 		ret = -EFAULT;
@@ -588,7 +594,7 @@
 	}
 
 free_dma:
-	dma_free_coherent(iSeries_vio_dev, count, op->buffer, op->dmaaddr);
+	dma_free_coherent(op->dev, count, op->buffer, op->dmaaddr);
 up_sem:
 	up(&reqSem);
 free_op:
@@ -910,7 +916,7 @@
 		break;
 	case viotapewrite:
 		if (op->non_blocking) {
-			dma_free_coherent(iSeries_vio_dev, op->count,
+			dma_free_coherent(op->dev, op->count,
 					op->buffer, op->dmaaddr);
 			free_op_struct(op);
 			up(&reqSem);
@@ -936,12 +942,70 @@
 	}
 }
 
+static int viotape_probe(struct vio_dev *vdev, const struct vio_device_id *id)
+{
+	char tapename[32];
+	int i = vdev->unit_address;
+	int j;
+
+	if (i >= viotape_numdev)
+		return -ENODEV;
+
+	tape_device[i] = &vdev->dev;
+
+	state[i].cur_part = 0;
+	for (j = 0; j < MAX_PARTITIONS; ++j)
+		state[i].part_stat_rwi[j] = VIOT_IDLE;
+	class_simple_device_add(tape_class, MKDEV(VIOTAPE_MAJOR, i), NULL,
+			"iseries!vt%d", i);
+	class_simple_device_add(tape_class, MKDEV(VIOTAPE_MAJOR, i | 0x80),
+			NULL, "iseries!nvt%d", i);
+	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i), S_IFCHR | S_IRUSR | S_IWUSR,
+			"iseries/vt%d", i);
+	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i | 0x80),
+			S_IFCHR | S_IRUSR | S_IWUSR, "iseries/nvt%d", i);
+	sprintf(tapename, "iseries/vt%d", i);
+	state[i].dev_handle = devfs_register_tape(tapename);
+	printk(VIOTAPE_KERN_INFO "tape %s is iSeries "
+			"resource %10.10s type %4.4s, model %3.3s\n",
+			tapename, viotape_unitinfo[i].rsrcname,
+			viotape_unitinfo[i].type, viotape_unitinfo[i].model);
+	return 0;
+}
+
+static int viotape_remove(struct vio_dev *vdev)
+{
+	int i = vdev->unit_address;
+
+	devfs_remove("iseries/nvt%d", i);
+	devfs_remove("iseries/vt%d", i);
+	devfs_unregister_tape(state[i].dev_handle);
+	class_simple_device_remove(MKDEV(VIOTAPE_MAJOR, i | 0x80));
+	class_simple_device_remove(MKDEV(VIOTAPE_MAJOR, i));
+	return 0;
+}
+
+/**
+ * viotape_device_table: Used by vio.c to match devices that we 
+ * support.
+ */
+static struct vio_device_id viotape_device_table[] __devinitdata = {
+	{ "viotape", "" },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(vio, viotape_device_table);
+static struct vio_driver viotape_driver = {
+	.name = "viotape",
+	.id_table = viotape_device_table,
+	.probe = viotape_probe,
+	.remove = viotape_remove
+};
+
 
 int __init viotap_init(void)
 {
 	int ret;
-	char tapename[32];
-	int i;
 	struct proc_dir_entry *e;
 
 	op_struct_list = NULL;
@@ -993,31 +1057,9 @@
 		goto unreg_class;
 	}
 
-	for (i = 0; i < viotape_numdev; i++) {
-		int j;
-
-		state[i].cur_part = 0;
-		for (j = 0; j < MAX_PARTITIONS; ++j)
-			state[i].part_stat_rwi[j] = VIOT_IDLE;
-		class_simple_device_add(tape_class, MKDEV(VIOTAPE_MAJOR, i),
-				NULL, "iseries!vt%d", i);
-		class_simple_device_add(tape_class,
-				MKDEV(VIOTAPE_MAJOR, i | 0x80),
-				NULL, "iseries!nvt%d", i);
-		devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i),
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				"iseries/vt%d", i);
-		devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i | 0x80),
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				"iseries/nvt%d", i);
-		sprintf(tapename, "iseries/vt%d", i);
-		state[i].dev_handle = devfs_register_tape(tapename);
-		printk(VIOTAPE_KERN_INFO "tape %s is iSeries "
-				"resource %10.10s type %4.4s, model %3.3s\n",
-				tapename, viotape_unitinfo[i].rsrcname,
-				viotape_unitinfo[i].type,
-				viotape_unitinfo[i].model);
-	}
+	ret = vio_register_driver(&viotape_driver);
+	if (ret)
+		goto unreg_class;
 
 	e = create_proc_entry("iSeries/viotape", S_IFREG|S_IRUGO, NULL);
 	if (e) {
@@ -1064,17 +1106,10 @@
 /* Cleanup */
 static void __exit viotap_exit(void)
 {
-	int i, ret;
+	int ret;
 
 	remove_proc_entry("iSeries/viotape", NULL);
-
-	for (i = 0; i < viotape_numdev; ++i) {
-		devfs_remove("iseries/nvt%d", i);
-		devfs_remove("iseries/vt%d", i);
-		devfs_unregister_tape(state[i].dev_handle);
-		class_simple_device_remove(MKDEV(VIOTAPE_MAJOR, i | 0x80));
-		class_simple_device_remove(MKDEV(VIOTAPE_MAJOR, i));
-	}
+	vio_unregister_driver(&viotape_driver);
 	class_simple_destroy(tape_class);
 	ret = unregister_chrdev(VIOTAPE_MAJOR, "viotape");
 	if (ret < 0)
diff -ruN 2.6.7-bk9.base.sysvio.4/include/asm-ppc64/iSeries/HvTypes.h 2.6.7-bk9.base.sysvio.5/include/asm-ppc64/iSeries/HvTypes.h
--- 2.6.7-bk9.base.sysvio.4/include/asm-ppc64/iSeries/HvTypes.h	2004-06-29 01:49:33.000000000 +1000
+++ 2.6.7-bk9.base.sysvio.5/include/asm-ppc64/iSeries/HvTypes.h	2004-06-19 17:59:21.000000000 +1000
@@ -68,6 +68,7 @@
 #define HVMAXARCHITECTEDVIRTUALLANS 16
 #define HVMAXARCHITECTEDVIRTUALDISKS 32
 #define HVMAXARCHITECTEDVIRTUALCDROMS 8
+#define HVMAXARCHITECTEDVIRTUALTAPES 8
 #define HVCHUNKSIZE 256 * 1024
 #define HVPAGESIZE 4 * 1024
 #define HVLPMINMEGSPRIMARY 256

--Signature=_Tue__29_Jun_2004_02_41_27_+1000_pks9DdvYI0=oNBz1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4Eo34CJfqux9a+8RAv4BAJ9c1hLnxriCgT7jzDaYANT0+qYiowCeNnks
g7FgnouzvjTbp67l0OHE9lQ=
=K7d0
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Jun_2004_02_41_27_+1000_pks9DdvYI0=oNBz1--
