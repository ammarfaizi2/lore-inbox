Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265007AbUFRGy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbUFRGy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 02:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265008AbUFRGy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 02:54:56 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:1175 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S265007AbUFRGyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 02:54:51 -0400
Date: Fri, 18 Jun 2004 16:54:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, linuxppc64-dev@lists.linuxppc.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PPC64 iSeries viodasd proc file
Message-Id: <20040618165436.193d5d35.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__18_Jun_2004_16_54_36_+1000_NPUOMer6.Z/jI2=b"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__18_Jun_2004_16_54_36_+1000_NPUOMer6.Z/jI2=b
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch adds a proc file for viodasd so to make it
easier to enumerate the available disks.  It is in a
(somewhat) strange format to try for a simple level of
compatability with the old viodasd code (that was in a
couple of vendor's kernels).

Please apply (and for Linus' tree as well).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.7/drivers/block/viodasd.c 2.6.7.viodasd.1/drivers/block/viodasd.c
--- 2.6.7/drivers/block/viodasd.c	2004-06-16 22:15:21.000000000 +1000
+++ 2.6.7.viodasd.1/drivers/block/viodasd.c	2004-06-18 16:00:33.000000000 +1000
@@ -42,6 +42,8 @@
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 
 #include <asm/uaccess.h>
 #include <asm/vio.h>
@@ -171,6 +173,34 @@
 } viodasd_devices[MAX_DISKNO];
 
 /*
+ * Proc file so that disks may be identified.  It looks like
+ * this in order to be (somewhat) compatible with the old code
+ * which just dumped statistics for each disk.
+ */
+static int viodasd_proc_show(struct seq_file *m, void *v)
+{
+	int i;
+
+	seq_printf(m, "viod %d possible devices\n", MAX_DISKNO);
+	for (i = 0; i < MAX_DISKNO; i++)
+		if (viodasd_devices[i].disk != NULL)
+			seq_printf(m, "DISK %2.2d:\n", i);
+	return 0;
+}
+
+static int viodasd_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, viodasd_proc_show, NULL);
+}
+
+static struct file_operations viodasd_proc_operations = {
+	.open		= viodasd_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+/*
  * External open entry point.
  */
 static int viodasd_open(struct inode *ino, struct file *fil)
@@ -755,6 +785,7 @@
 static int __init viodasd_init(void)
 {
 	int i;
+	struct proc_dir_entry *e;
 
 	/* Try to open to our host lp */
 	if (viopath_hostLp == HvLpIndexInvalid)
@@ -794,6 +825,12 @@
 	vio_register_driver(&viodasd_driver);	/* FIX ME - error checking */
 	driver_create_file(&viodasd_driver.driver, &driver_attr_probe);
 
+	e = create_proc_entry("iSeries/viodasd", S_IFREG|S_IRUGO, NULL);
+	if (e) {
+		e->owner = THIS_MODULE;
+		e->proc_fops = &viodasd_proc_operations;
+	}
+
 	return 0;
 }
 module_init(viodasd_init);
@@ -806,6 +843,7 @@
 	driver_remove_file(&viodasd_driver.driver, &driver_attr_probe);
 	vio_unregister_driver(&viodasd_driver);
 
+	remove_proc_entry("iSeries/viodasd", NULL);
         for (i = 0; i < MAX_DISKNO; i++) {
 		d = &viodasd_devices[i];
 		if (d->disk) {

--Signature=_Fri__18_Jun_2004_16_54_36_+1000_NPUOMer6.Z/jI2=b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0pG2FG47PeJeR58RApuUAKCvJ9DHap6Ncdmdb7rIQnJrRKY94ACgxtpD
yf8oZy7gzJ7LI/nsfOpk2ks=
=DOgc
-----END PGP SIGNATURE-----

--Signature=_Fri__18_Jun_2004_16_54_36_+1000_NPUOMer6.Z/jI2=b--
