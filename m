Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUCAEhx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 23:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbUCAEhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 23:37:53 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:6057 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261867AbUCAEhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 23:37:50 -0500
Date: Mon, 1 Mar 2004 15:37:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] PPC64 iSeries virtual disk update
Message-Id: <20040301153734.4cc3742e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__1_Mar_2004_15_37_34_+1100_AoPC16C+n4cfklRL"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__1_Mar_2004_15_37_34_+1100_AoPC16C+n4cfklRL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Linus,

This patch (hopefully) addresses concerns Christoph Hellwig had with
the virtual disk probing code.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.4-rc1.boottime/drivers/block/viodasd.c 2.6.4-rc1.boottime.dasd/drivers/block/viodasd.c
--- 2.6.4-rc1.boottime/drivers/block/viodasd.c	2004-03-01 01:17:20.000000000 +1100
+++ 2.6.4-rc1.boottime.dasd/drivers/block/viodasd.c	2004-03-01 14:53:50.000000000 +1100
@@ -70,7 +70,6 @@
 	MAX_DISK_NAME = sizeof(((struct gendisk *)0)->disk_name)
 };
 
-static int		viodasd_max_disk;
 static spinlock_t	viodasd_spinlock = SPIN_LOCK_UNLOCKED;
 
 #define VIOMAXREQ		16
@@ -209,7 +208,6 @@
 				(int)we.rc, we.sub_result, err->msg);
 		return -EIO;
 	}
-	viodasd_max_disk = we.max_disk;
 
 	return 0;
 }
@@ -483,7 +481,17 @@
 
 	if (we.rc != 0)
 		return;
-	viodasd_max_disk = we.max_disk;
+	if (we.max_disk > (MAX_DISKNO - 1)) {
+		static int warned;
+
+		if (warned == 0) {
+			warned++;
+			printk(VIOD_KERN_INFO
+				"Only examining the first %d "
+				"of %d disks connected\n",
+				MAX_DISKNO, we.max_disk + 1);
+		}
+	}
 
 	/* Send the close event to OS/400.  We DON'T expect a response */
 	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
@@ -744,21 +752,8 @@
 	/* Initialize our request handler */
 	vio_setHandler(viomajorsubtype_blockio, handle_block_event);
 
-	viodasd_max_disk = MAX_DISKNO - 1;
-	for (i = 0; (i <= viodasd_max_disk) && (i < MAX_DISKNO); i++) {
-		/*
-		 * Note that probe_disk has side effects:
-		 *  a) it updates the size of the disk
-		 *  b) it updates viodasd_max_disk
-		 *  c) it registers the disk if it has not done so already
-		 */
+	for (i = 0; i < MAX_DISKNO; i++)
 		probe_disk(&viodasd_devices[i]);
-	}
-
-	if (viodasd_max_disk > (MAX_DISKNO - 1))
-		printk(VIOD_KERN_INFO
-			"Only examining the first %d of %d disks connected\n",
-			MAX_DISKNO, viodasd_max_disk + 1);
 
 	return 0;
 }

--Signature=_Mon__1_Mar_2004_15_37_34_+1100_AoPC16C+n4cfklRL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAQr4OFG47PeJeR58RAuz4AKDaHqliqHmDbZYo2OSYvkQPIHlTGQCfSL29
XbhhaO3Qo3l5LxBijKVcr4k=
=Ul5n
-----END PGP SIGNATURE-----

--Signature=_Mon__1_Mar_2004_15_37_34_+1100_AoPC16C+n4cfklRL--
