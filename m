Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUEXHAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUEXHAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUEXHAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:00:42 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:61128 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261244AbUEXG7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:59:54 -0400
Date: Mon, 24 May 2004 16:20:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, linuxppc64-dev@lists.linuxppc.org
Message-Id: <20040524162039.5f6ca3e0.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__24_May_2004_16_20_39_+1000_bK78V0fPCziix0_u"
Subject: [PATCH] dynamic addition of virtual disks on PPC64 iSeries
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__24_May_2004_16_20_39_+1000_bK78V0fPCziix0_u
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew, Linus,

This patch allows us to dynamically add virtual disks to an iSeries
partition. It works like this: after you have created the virtual disk
file on OS/400 and attached it to the Linux partition, you need to read
/sys/bus/vio/drivers/viodasd/probe.  This will do the probe and list any
new disks discovered.

This was the nicest way I could think of doing this as the interface to
the hypervisor is polled ...

Please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.6-bk7/drivers/block/viodasd.c 2.6.6-bk7.dyndasd/drivers/block/viodasd.c
--- 2.6.6-bk7/drivers/block/viodasd.c	2004-05-21 16:24:00.000000000 +1000
+++ 2.6.6-bk7.dyndasd/drivers/block/viodasd.c	2004-05-20 20:36:43.000000000 +1000
@@ -40,8 +40,12 @@
 #include <linux/string.h>
 #include <linux/dma-mapping.h>
 #include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
 
 #include <asm/uaccess.h>
+#include <asm/vio.h>
+#include <asm/page.h>		/* for PAGE_SIZE */
 #include <asm/iSeries/HvTypes.h>
 #include <asm/iSeries/HvLpEvent.h>
 #include <asm/iSeries/HvLpConfig.h>
@@ -456,7 +460,7 @@
  * Probe a single disk and fill in the viodasd_device structure
  * for it.
  */
-static void probe_disk(struct viodasd_device *d)
+static int probe_disk(struct viodasd_device *d)
 {
 	HvLpEvent_Rc hvrc;
 	struct viodasd_waitevent we;
@@ -480,14 +484,14 @@
 			0, 0, 0);
 	if (hvrc != 0) {
 		printk(VIOD_KERN_WARNING "bad rc on HV open %d\n", (int)hvrc);
-		return;
+		return 0;
 	}
 
 	wait_for_completion(&we.com);
 
 	if (we.rc != 0) {
 		if (flags != 0)
-			return;
+			return 0;
 		/* try again with read only flag set */
 		flags = vioblockflags_ro;
 		goto retry;
@@ -517,22 +521,15 @@
 	if (hvrc != 0) {
 		printk(VIOD_KERN_WARNING
 		       "bad rc sending event to OS/400 %d\n", (int)hvrc);
-		return;
+		return 0;
 	}
-	printk(VIOD_KERN_INFO "disk %d: %lu sectors (%lu MB) "
-			"CHS=%d/%d/%d sector size %d%s\n",
-			dev_no, (unsigned long)(d->size >> 9),
-			(unsigned long)(d->size >> 20),
-			(int)d->cylinders, (int)d->tracks,
-			(int)d->sectors, (int)d->bytes_per_sector,
-			d->read_only ? " (RO)" : "");
 	/* create the request queue for the disk */
 	spin_lock_init(&d->q_lock);
 	q = blk_init_queue(do_viodasd_request, &d->q_lock);
 	if (q == NULL) {
 		printk(VIOD_KERN_WARNING "cannot allocate queue for disk %d\n",
 				dev_no);
-		return;
+		return 0;
 	}
 	g = alloc_disk(1 << PARTITION_SHIFT);
 	if (g == NULL) {
@@ -540,7 +537,7 @@
 				"cannot allocate disk structure for disk %d\n",
 				dev_no);
 		blk_cleanup_queue(q);
-		return;
+		return 0;
 	}
 
 	d->disk = g;
@@ -563,8 +560,17 @@
 	g->private_data = d;
 	set_capacity(g, d->size >> 9);
 
+	printk(VIOD_KERN_INFO "disk %d: %lu sectors (%lu MB) "
+			"CHS=%d/%d/%d sector size %d%s\n",
+			dev_no, (unsigned long)(d->size >> 9),
+			(unsigned long)(d->size >> 20),
+			(int)d->cylinders, (int)d->tracks,
+			(int)d->sectors, (int)d->bytes_per_sector,
+			d->read_only ? " (RO)" : "");
+
 	/* register us in the global list */
 	add_disk(g);
+	return 1;
 }
 
 /* returns the total number of scatterlist elements converted */
@@ -725,6 +731,29 @@
 }
 
 /*
+ * Get the driver to reprobe for more disks.
+ */
+static ssize_t probe_disks(struct device_driver *drv, char *buf)
+{
+	ssize_t count = 0;
+	struct viodasd_device *d;
+
+	for (d = viodasd_devices; d < &viodasd_devices[MAX_DISKNO]; d++) {
+		if ((d->disk == NULL) && probe_disk(d)) {
+			count += scnprintf(&buf[count], PAGE_SIZE - count,
+					"%s\n", d->disk->disk_name);
+		}
+	}
+	return count;
+}
+
+static DRIVER_ATTR(probe, S_IRUSR, probe_disks, NULL)
+
+static struct vio_driver viodasd_driver = {
+	.name = "viodasd"
+};
+
+/*
  * Initialize the whole device driver.  Handle module and non-module
  * versions
  */
@@ -767,6 +796,9 @@
 	for (i = 0; i < MAX_DISKNO; i++)
 		probe_disk(&viodasd_devices[i]);
 
+	vio_register_driver(&viodasd_driver);	/* FIX ME - error checking */
+	driver_create_file(&viodasd_driver.driver, &driver_attr_probe);
+
 	return 0;
 }
 module_init(viodasd_init);
@@ -776,6 +808,9 @@
 	int i;
 	struct viodasd_device *d;
 
+	vio_unregister_driver(&viodasd_driver);
+	driver_remove_file(&viodasd_driver.driver, &driver_attr_probe);
+
         for (i = 0; i < MAX_DISKNO; i++) {
 		d = &viodasd_devices[i];
 		if (d->disk) {

--Signature=_Mon__24_May_2004_16_20_39_+1000_bK78V0fPCziix0_u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsZQ3FG47PeJeR58RAiSvAJ0QzR7tI80apUW6gWggE60XHIfUUQCgsw/T
xlnxWHgkRZbo92BpDBmzaz8=
=c17A
-----END PGP SIGNATURE-----

--Signature=_Mon__24_May_2004_16_20_39_+1000_bK78V0fPCziix0_u--
