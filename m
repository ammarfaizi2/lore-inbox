Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbUB0No3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbUB0No3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:44:29 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:35077 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262854AbUB0NoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:44:25 -0500
Date: Fri, 27 Feb 2004 13:44:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
       akpm@osdl.org, linus@osdl.org, anton@samba.org, paulus@samba.org,
       axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-ID: <20040227134412.A301@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>, akpm@osdl.org,
	linus@osdl.org, anton@samba.org, paulus@samba.org, axboe@suse.de,
	piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20040123163504.36582570.sfr@canb.auug.org.au> <20040122221136.174550c3.akpm@osdl.org> <20040226172325.3a139f73.sfr@canb.auug.org.au> <20040226095156.GA25423@lst.de> <20040227120451.0e3c43bd.sfr@canb.auug.org.au> <20040227113202.A31176@infradead.org> <20040227225716.5b29c690.sfr@canb.auug.org.au> <20040227121300.B31544@infradead.org> <20040228002614.2b4ff994.sfr@canb.auug.org.au> <20040227133717.GA13381@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040227133717.GA13381@lst.de>; from hch@lst.de on Fri, Feb 27, 2004 at 02:37:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 02:37:17PM +0100, Christoph Hellwig wrote:
> Here's a totally untested patch to fix it up:

And a better one that makes viodasd_max_disks properly start at 0.


--- 1.1/drivers/block/viodasd.c	Fri Feb 27 06:25:15 2004
+++ edited/drivers/block/viodasd.c	Fri Feb 27 15:44:03 2004
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
@@ -483,7 +481,8 @@
 
 	if (we.rc != 0)
 		return;
-	viodasd_max_disk = we.max_disk;
+
+	viodasd_max_disk = min(we.max_disk - 1, MAX_DISKNO);
 
 	/* Send the close event to OS/400.  We DON'T expect a response */
 	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
@@ -744,27 +743,13 @@
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
+	for (i = 0; i < viodasd_max_disk; i++)
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
@@ -783,4 +768,5 @@
 	viopath_close(viopath_hostLp, viomajorsubtype_blockio, VIOMAXREQ + 2);
 }
 
+module_init(viodasd_init);
 module_exit(viodasd_exit);
