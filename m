Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbUKDIJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUKDIJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 03:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUKDIJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 03:09:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40380 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262133AbUKDIJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 03:09:25 -0500
Date: Thu, 4 Nov 2004 00:08:40 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       <azarah@nosferatu.za.org>
Subject: Patch for ub in 2.6.10-rc1
Message-ID: <20041104000840.56412e6f@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a relatively small changeset, to address small nagging problems.
Andrew pointed me at the double registration specifically, so I had to do
something about it. At least now Fabio's box won't collapse if he configures
UB by mistake. Also, a few people complained that the help text was
misleading.

I have not done anything about the oops on disconnect which happens to
Martin Schlemmer. It's next. After that I can get to Peter Jones' CD
burning patch and doing resets.

- Fix double kobject registration and eventual oops on unplug if a device
  is not cooperating.
- Add a reference to usb-storage into the configuration help.
- Just upping timeouts fixes my ZIP drive.
- Max out the diag (trace) file size.
- Set capacity to zero in case the media is absent. It works in 2.4.10-rc1.
  Either Al fixed the block layer, or the whole thing was a bug in ub.c
  (and sd.c) and a big misunderstanding.

Signed-off-by: Pete Zaitcev

diff -urp -X dontdiff linux-2.6.10-rc1/drivers/block/Kconfig linux-2.6.10-rc1-ub/drivers/block/Kconfig
--- linux-2.6.10-rc1/drivers/block/Kconfig	2004-10-28 09:46:38.000000000 -0700
+++ linux-2.6.10-rc1-ub/drivers/block/Kconfig	2004-11-01 16:09:13.000000000 -0800
@@ -308,6 +308,8 @@ config BLK_DEV_UB
 	  This driver supports certain USB attached storage devices
 	  such as flash keys.
 
+	  Warning: Enabling this cripples the usb-storage driver.
+
 	  If unsure, say N.
 
 config BLK_DEV_RAM
diff -urp -X dontdiff linux-2.6.10-rc1/drivers/block/ub.c linux-2.6.10-rc1-ub/drivers/block/ub.c
--- linux-2.6.10-rc1/drivers/block/ub.c	2004-10-28 09:46:38.000000000 -0700
+++ linux-2.6.10-rc1-ub/drivers/block/ub.c	2004-11-02 23:59:07.000000000 -0800
@@ -8,13 +8,11 @@
  * and is not licensed separately. See file COPYING for details.
  *
  * TODO (sorted by decreasing priority)
- *  -- ZIP does "ub: resid 18 len 0 act 0" and whole transport quits (toggles?)
+ *  -- Do resets with usb_device_reset (needs a thread context, use khubd)
  *  -- set readonly flag for CDs, set removable flag for CF readers
  *  -- do inquiry and verify we got a disk and not a tape (for LUN mismatch)
  *  -- support pphaneuf's SDDR-75 with two LUNs (also broken capacity...)
  *  -- special case some senses, e.g. 3a/0 -> no media present, reduce retries
- *  -- do something about spin-down devices, they are extremely dangerous
- *     (ZIP is one. Needs spin-up command as well.)
  *  -- verify the 13 conditions and do bulk resets
  *  -- normal pool of commands instead of cmdv[]?
  *  -- kill last_pipe and simply do two-state clearing on both pipes
@@ -105,13 +103,11 @@ struct ub_dev;
 #define UB_MAX_SECTORS 64
 
 /*
- * A second ought to be enough for a 32K transfer (UB_MAX_SECTORS)
- * even if a webcam hogs the bus (famous last words).
- * Some CDs need a second to spin up though.
- * ZIP drive rejects commands when it's not spinning,
- * so it does not need long timeouts either.
+ * A second is more than enough for a 32K transfer (UB_MAX_SECTORS)
+ * even if a webcam hogs the bus, but some devices need time to spin up.
  */
 #define UB_URB_TIMEOUT	(HZ*2)
+#define UB_DATA_TIMEOUT	(HZ*5)	/* ZIP does spin-ups in the data phase */
 #define UB_CTRL_TIMEOUT	(HZ/2) /* 500ms ought to be enough to clear a stall */
 
 /*
@@ -188,7 +184,7 @@ struct ub_capacity {
  */
 
 #define SCMD_ST_HIST_SZ   8
-#define SCMD_TRACE_SZ    15	/* No more than 256 (trace_index) */
+#define SCMD_TRACE_SZ    63		/* Less than 4KB of 61-byte lines */
 
 struct ub_scsi_cmd_trace {
 	int hcur;
@@ -267,6 +263,7 @@ struct ub_dev {
 	int changed;			/* Media was changed */
 	int removable;
 	int readonly;
+	int first_open;			/* Kludge. See ub_bd_open. */
 	char name[8];
 	struct usb_device *dev;
 	struct usb_interface *intf;
@@ -888,9 +885,6 @@ static void ub_scsi_urb_compl(struct ub_
 	int pipe;
 	int rc;
 
-/* P3 */ /** printk("ub: urb status %d pipe 0x%08x len %d act %d\n",
- urb->status, urb->pipe, urb->transfer_buffer_length, urb->actual_length); **/
-
 	if (atomic_read(&sc->poison)) {
 		/* A little too simplistic, I feel... */
 		goto Bad_End;
@@ -959,9 +953,12 @@ static void ub_scsi_urb_compl(struct ub_
 			ub_cmdtr_state(sc, cmd);
 			return;
 		}
-		if (urb->status != 0)
+		if (urb->status != 0) {
+			printk("ub: cmd #%d cmd status (%d)\n", cmd->tag, urb->status); /* P3 */
 			goto Bad_End;
+		}
 		if (urb->actual_length != US_BULK_CB_WRAP_LEN) {
+			printk("ub: cmd #%d xferred %d\n", cmd->tag, urb->actual_length); /* P3 */
 			/* XXX Must do reset here to unconfuse the device */
 			goto Bad_End;
 		}
@@ -993,7 +990,7 @@ static void ub_scsi_urb_compl(struct ub_
 			return;
 		}
 
-		sc->work_timer.expires = jiffies + UB_URB_TIMEOUT;
+		sc->work_timer.expires = jiffies + UB_DATA_TIMEOUT;
 		add_timer(&sc->work_timer);
 
 		cmd->state = UB_CMDST_DATA;
@@ -1379,12 +1376,7 @@ static void ub_revalidate(struct ub_dev 
 
 	sc->readonly = 0;	/* XXX Query this from the device */
 
-	/*
-	 * XXX sd.c sets capacity to zero in such case. However, it doesn't
-	 * work for us. In case of zero capacity, block layer refuses to
-	 * have the /dev/uba opened (why?) Set capacity to some random value.
-	 */
-	sc->capacity.nsec = 50;
+	sc->capacity.nsec = 0;
 	sc->capacity.bsize = 512;
 	sc->capacity.bshift = 0;
 
@@ -1399,7 +1391,7 @@ static void ub_revalidate(struct ub_dev 
 		 * We keep this because sd.c has retries for capacity.
 		 */
 		if (ub_sync_read_cap(sc, &sc->capacity) != 0) {
-			sc->capacity.nsec = 100;
+			sc->capacity.nsec = 0;
 			sc->capacity.bsize = 512;
 			sc->capacity.bshift = 0;
 		}
@@ -1428,6 +1420,26 @@ static int ub_bd_open(struct inode *inod
 	sc->openc++;
 	spin_unlock_irqrestore(&ub_lock, flags);
 
+	/*
+	 * This is a workaround for a specific problem in our block layer.
+	 * In 2.6.9, register_disk duplicates the code from rescan_partitions.
+	 * However, if we do add_disk with a device which persistently reports
+	 * a changed media, add_disk calls register_disk, which does do_open,
+	 * which will call rescan_paritions for changed media. After that,
+	 * register_disk attempts to do it all again and causes double kobject
+	 * registration and a eventually an oops on module removal.
+	 *
+	 * The bottom line is, Al Viro says that we should not allow
+	 * bdev->bd_invalidated to be set when doing add_disk no matter what.
+	 */
+	if (sc->first_open) {
+		if (sc->changed) {
+			sc->first_open = 0;
+			rc = -ENOMEDIUM;
+			goto err_open;
+		}
+	}
+
 	if (sc->removable || sc->readonly)
 		check_disk_change(inode->i_bdev);
 
@@ -1467,6 +1479,8 @@ static int ub_bd_release(struct inode *i
 
 	spin_lock_irqsave(&ub_lock, flags);
 	--sc->openc;
+	if (sc->openc == 0)
+		sc->first_open = 0;
 	if (sc->openc == 0 && atomic_read(&sc->poison))
 		ub_cleanup(sc);
 	spin_unlock_irqrestore(&ub_lock, flags);
@@ -1559,13 +1573,9 @@ static int ub_bd_media_changed(struct ge
 	 */
 	if (ub_sync_tur(sc) != 0) {
 		sc->changed = 1;
-		/* P3 */ printk("%s: made changed\n", sc->name);
 		return 1;
 	}
 
-	/* The sd.c clears this before returning (one-shot flag). Why? */
-	/* P3 */ printk("%s: %s changed\n", sc->name,
-	    sc->changed? "is": "was not");
 	return sc->changed;
 }
 
@@ -1919,6 +1929,8 @@ static int ub_probe(struct usb_interface
 	}
 
 	sc->removable = 1;		/* XXX Query this from the device */
+	sc->changed = 1;		/* ub_revalidate clears only */
+	sc->first_open = 1;
 
 	ub_revalidate(sc);
 	/* This is pretty much a long term P3 */

-- Pete

