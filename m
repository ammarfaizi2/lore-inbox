Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbUB0Nhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbUB0Nhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:37:54 -0500
Received: from verein.lst.de ([212.34.189.10]:33992 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262857AbUB0Nhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:37:38 -0500
Date: Fri, 27 Feb 2004 14:37:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: akpm@osdl.org, linus@osdl.org, anton@samba.org, paulus@samba.org,
       axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-ID: <20040227133717.GA13381@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>, akpm@osdl.org,
	linus@osdl.org, anton@samba.org, paulus@samba.org, axboe@suse.de,
	piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20040123163504.36582570.sfr@canb.auug.org.au> <20040122221136.174550c3.akpm@osdl.org> <20040226172325.3a139f73.sfr@canb.auug.org.au> <20040226095156.GA25423@lst.de> <20040227120451.0e3c43bd.sfr@canb.auug.org.au> <20040227113202.A31176@infradead.org> <20040227225716.5b29c690.sfr@canb.auug.org.au> <20040227121300.B31544@infradead.org> <20040228002614.2b4ff994.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040228002614.2b4ff994.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 12:26:14AM +1100, Stephen Rothwell wrote:
> It is the highest index of all the configured disks. Did you read my
> previous email?  If disks 1 2 4 and 7 are configured, the
> open_data.max_disk will be 7. If the admin thena adds disk 23, the next
> time we probe (by calling the HV open interface) the returned max_disk
> will be 23.
> 
> I do not apologise for braindead interfaces in code I didn't write ...
> In this case I just have to use it.

You don't need to apologize.  It's braindead and I don't really care
who messed it up.  But again even with this the logic isn't good.

Here's a totally untested patch to fix it up:

--- 1.1/drivers/block/viodasd.c	Fri Feb 27 06:25:15 2004
+++ edited/drivers/block/viodasd.c	Fri Feb 27 15:37:06 2004
@@ -70,7 +70,7 @@
 	MAX_DISK_NAME = sizeof(((struct gendisk *)0)->disk_name)
 };
 
-static int		viodasd_max_disk;
+static int		viodasd_max_disk = 1; /* probe at least one disk */
 static spinlock_t	viodasd_spinlock = SPIN_LOCK_UNLOCKED;
 
 #define VIOMAXREQ		16
@@ -209,7 +209,6 @@
 				(int)we.rc, we.sub_result, err->msg);
 		return -EIO;
 	}
-	viodasd_max_disk = we.max_disk;
 
 	return 0;
 }
@@ -451,10 +450,9 @@
 }
 
 /*
- * Probe a single disk and fill in the viodasd_device structure
- * for it.
+ * Probe a single disk and fill in the viodasd_device structure for it.
  */
-static void probe_disk(struct viodasd_device *d)
+static void __init probe_disk(struct viodasd_device *d)
 {
 	HvLpEvent_Rc hvrc;
 	struct viodasd_waitevent we;
@@ -483,6 +481,14 @@
 
 	if (we.rc != 0)
 		return;
+
+	if (we.max_disk > (MAX_DISKNO - 1)) {
+		printk(VIOD_KERN_INFO
+			"Only examining the first %d of %d disks connected\n",
+			MAX_DISKNO, we.max_disk + 1);
+		we.max_disk = MAX_DISKNO - 1;
+	}
+
 	viodasd_max_disk = we.max_disk;
 
 	/* Send the close event to OS/400.  We DON'T expect a response */
@@ -744,27 +750,13 @@
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
+	/* probe_disk updates viodasd_max_disk */
+	for (i = 0; i <= viodasd_max_disk; i++)
 		probe_disk(&viodasd_devices[i]);
-	}
-
-	if (viodasd_max_disk > (MAX_DISKNO - 1))
-		printk(VIOD_KERN_INFO
-			"Only examining the first %d of %d disks connected\n",
-			MAX_DISKNO, viodasd_max_disk + 1);
-
 	return 0;
 }
-module_init(viodasd_init);
 
-void viodasd_exit(void)
+static void __exit viodasd_exit(void)
 {
 	int i;
 	struct viodasd_device *d;
@@ -783,4 +775,5 @@
 	viopath_close(viopath_hostLp, viomajorsubtype_blockio, VIOMAXREQ + 2);
 }
 
+module_init(viodasd_init);
 module_exit(viodasd_exit);
