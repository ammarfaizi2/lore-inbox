Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264258AbUEXLuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUEXLuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 07:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUEXLuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 07:50:37 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:41180 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S264258AbUEXLub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 07:50:31 -0400
Date: Mon, 24 May 2004 21:50:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: akpm@osdl.org, torvalds@osdl.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic addition of virtual disks on PPC64 iSeries
Message-Id: <20040524215005.4d1d3c54.sfr@canb.auug.org.au>
In-Reply-To: <20040524202226.6b0acab6.sfr@canb.auug.org.au>
References: <20040524162039.5f6ca3e0.sfr@canb.auug.org.au>
	<20040523232920.2fb0640a.akpm@osdl.org>
	<20040524184126.11aeffd3.sfr@canb.auug.org.au>
	<20040524014901.04530a24.akpm@osdl.org>
	<20040524202226.6b0acab6.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__24_May_2004_21_50_05_+1000_030MB9dor+bEDMYp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__24_May_2004_21_50_05_+1000_030MB9dor+bEDMYp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew, Linus,

Second attempt.

This patch allows us to dynamically add virtual disks to an iSeries
partition. It works like this: after you have created the virtual disk
file on OS/400 and attached it to the Linux partition, you need to write
to /sys/bus/vio/drivers/viodasd/probe (it doesn't matter what you write). 
This will do the probe. It calls add_disk() for each new disk, so we get
hotplug events as a side effect.

This was the nicest way I could think of doing this as the interface to
the hypervisor is polled ...

Please apply.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.7-rc1/drivers/block/viodasd.c 2.6.7-rc1.dyndasd.1/drivers/block/viodasd.c
--- 2.6.7-rc1/drivers/block/viodasd.c	2004-05-24 16:29:46.000000000 +1000
+++ 2.6.7-rc1.dyndasd.1/drivers/block/viodasd.c	2004-05-24 21:17:24.000000000 +1000
@@ -40,8 +40,11 @@
 #include <linux/string.h>
 #include <linux/dma-mapping.h>
 #include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
 
 #include <asm/uaccess.h>
+#include <asm/vio.h>
 #include <asm/iSeries/HvTypes.h>
 #include <asm/iSeries/HvLpEvent.h>
 #include <asm/iSeries/HvLpConfig.h>
@@ -519,13 +522,6 @@
 		       "bad rc sending event to OS/400 %d\n", (int)hvrc);
 		return;
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
@@ -563,6 +559,14 @@
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
 }
@@ -725,6 +729,26 @@
 }
 
 /*
+ * Get the driver to reprobe for more disks.
+ */
+static ssize_t probe_disks(struct device_driver *drv, const char *buf,
+		size_t count)
+{
+	struct viodasd_device *d;
+
+	for (d = viodasd_devices; d < &viodasd_devices[MAX_DISKNO]; d++) {
+		if (d->disk == NULL)
+			probe_disk(d);
+	}
+	return count;
+}
+static DRIVER_ATTR(probe, S_IWUSR, NULL, probe_disks)
+
+static struct vio_driver viodasd_driver = {
+	.name = "viodasd"
+};
+
+/*
  * Initialize the whole device driver.  Handle module and non-module
  * versions
  */
@@ -767,6 +791,9 @@
 	for (i = 0; i < MAX_DISKNO; i++)
 		probe_disk(&viodasd_devices[i]);
 
+	vio_register_driver(&viodasd_driver);	/* FIX ME - error checking */
+	driver_create_file(&viodasd_driver.driver, &driver_attr_probe);
+
 	return 0;
 }
 module_init(viodasd_init);
@@ -776,6 +803,9 @@
 	int i;
 	struct viodasd_device *d;
 
+	driver_remove_file(&viodasd_driver.driver, &driver_attr_probe);
+	vio_unregister_driver(&viodasd_driver);
+
         for (i = 0; i < MAX_DISKNO; i++) {
 		d = &viodasd_devices[i];
 		if (d->disk) {

--Signature=_Mon__24_May_2004_21_50_05_+1000_030MB9dor+bEDMYp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAseFtFG47PeJeR58RAiSrAKDbuLHROn06HMfqT/18nLlBGO8WfQCfbSwp
2jzNR5Fi0EfpoRG05Ep/gM0=
=oe1Y
-----END PGP SIGNATURE-----

--Signature=_Mon__24_May_2004_21_50_05_+1000_030MB9dor+bEDMYp--
