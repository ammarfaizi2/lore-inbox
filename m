Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbVIVHta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVIVHta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVIVHtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:49:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:61874 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751440AbVIVHsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:48:51 -0400
Date: Thu, 22 Sep 2005 00:48:29 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: [patch 09/18] ub: fix burning cds
Message-ID: <20050922074829.GJ15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ub-burn-cd-fix.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pete Zaitcev <zaitcev@redhat.com>

This patch fixes a few problems with ub and cleans up a couple of things:

 - Bump UB_MAX_REQ_SG, this allows to burn CDs
 - Drop initialization of urb.transfer_flags,
   now that URB_UNLINK_ASYNC is gone
 - Add forgotten processing of stalls at GetMaxLUN
 - Remove a few more P3-tagged printks whose time has come
 - Correct comment about ZIP-100

Signed-off-by: Pete Zaitcev <zaitcev@yahoo.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/block/ub.c |   53 +++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

--- scsi-2.6.orig/drivers/block/ub.c	2005-09-20 05:59:42.000000000 -0700
+++ scsi-2.6/drivers/block/ub.c	2005-09-21 17:29:36.000000000 -0700
@@ -172,7 +172,7 @@
  */
 struct ub_dev;
 
-#define UB_MAX_REQ_SG	4
+#define UB_MAX_REQ_SG	9	/* cdrecord requires 32KB and maybe a header */
 #define UB_MAX_SECTORS 64
 
 /*
@@ -387,7 +387,7 @@
 	struct bulk_cs_wrap work_bcs;
 	struct usb_ctrlrequest work_cr;
 
-	int sg_stat[UB_MAX_REQ_SG+1];
+	int sg_stat[6];
 	struct ub_scsi_trace tr;
 };
 
@@ -525,12 +525,13 @@
 	    "qlen %d qmax %d\n",
 	    sc->cmd_queue.qlen, sc->cmd_queue.qmax);
 	cnt += sprintf(page + cnt,
-	    "sg %d %d %d %d %d\n",
+	    "sg %d %d %d %d %d .. %d\n",
 	    sc->sg_stat[0],
 	    sc->sg_stat[1],
 	    sc->sg_stat[2],
 	    sc->sg_stat[3],
-	    sc->sg_stat[4]);
+	    sc->sg_stat[4],
+	    sc->sg_stat[5]);
 
 	list_for_each (p, &sc->luns) {
 		lun = list_entry(p, struct ub_lun, link);
@@ -835,7 +836,7 @@
 		return -1;
 	}
 	cmd->nsg = n_elem;
-	sc->sg_stat[n_elem]++;
+	sc->sg_stat[n_elem < 5 ? n_elem : 5]++;
 
 	/*
 	 * build the command
@@ -891,7 +892,7 @@
 		return -1;
 	}
 	cmd->nsg = n_elem;
-	sc->sg_stat[n_elem]++;
+	sc->sg_stat[n_elem < 5 ? n_elem : 5]++;
 
 	memcpy(&cmd->cdb, rq->cmd, rq->cmd_len);
 	cmd->cdb_len = rq->cmd_len;
@@ -1010,7 +1011,6 @@
 	sc->last_pipe = sc->send_bulk_pipe;
 	usb_fill_bulk_urb(&sc->work_urb, sc->dev, sc->send_bulk_pipe,
 	    bcb, US_BULK_CB_WRAP_LEN, ub_urb_complete, sc);
-	sc->work_urb.transfer_flags = 0;
 
 	/* Fill what we shouldn't be filling, because usb-storage did so. */
 	sc->work_urb.actual_length = 0;
@@ -1019,7 +1019,6 @@
 
 	if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
 		/* XXX Clear stalls */
-		printk("ub: cmd #%d start failed (%d)\n", cmd->tag, rc); /* P3 */
 		ub_complete(&sc->work_done);
 		return rc;
 	}
@@ -1190,11 +1189,9 @@
 			return;
 		}
 		if (urb->status != 0) {
-			printk("ub: cmd #%d cmd status (%d)\n", cmd->tag, urb->status); /* P3 */
 			goto Bad_End;
 		}
 		if (urb->actual_length != US_BULK_CB_WRAP_LEN) {
-			printk("ub: cmd #%d xferred %d\n", cmd->tag, urb->actual_length); /* P3 */
 			/* XXX Must do reset here to unconfuse the device */
 			goto Bad_End;
 		}
@@ -1395,14 +1392,12 @@
 	usb_fill_bulk_urb(&sc->work_urb, sc->dev, pipe,
 	    page_address(sg->page) + sg->offset, sg->length,
 	    ub_urb_complete, sc);
-	sc->work_urb.transfer_flags = 0;
 	sc->work_urb.actual_length = 0;
 	sc->work_urb.error_count = 0;
 	sc->work_urb.status = 0;
 
 	if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
 		/* XXX Clear stalls */
-		printk("ub: data #%d submit failed (%d)\n", cmd->tag, rc); /* P3 */
 		ub_complete(&sc->work_done);
 		ub_state_done(sc, cmd, rc);
 		return;
@@ -1442,7 +1437,6 @@
 	sc->last_pipe = sc->recv_bulk_pipe;
 	usb_fill_bulk_urb(&sc->work_urb, sc->dev, sc->recv_bulk_pipe,
 	    &sc->work_bcs, US_BULK_CS_WRAP_LEN, ub_urb_complete, sc);
-	sc->work_urb.transfer_flags = 0;
 	sc->work_urb.actual_length = 0;
 	sc->work_urb.error_count = 0;
 	sc->work_urb.status = 0;
@@ -1563,7 +1557,6 @@
 
 	usb_fill_control_urb(&sc->work_urb, sc->dev, sc->send_ctrl_pipe,
 	    (unsigned char*) cr, NULL, 0, ub_urb_complete, sc);
-	sc->work_urb.transfer_flags = 0;
 	sc->work_urb.actual_length = 0;
 	sc->work_urb.error_count = 0;
 	sc->work_urb.status = 0;
@@ -2000,17 +1993,16 @@
 
 	usb_fill_control_urb(&sc->work_urb, sc->dev, sc->recv_ctrl_pipe,
 	    (unsigned char*) cr, p, 1, ub_probe_urb_complete, &compl);
-	sc->work_urb.transfer_flags = 0;
 	sc->work_urb.actual_length = 0;
 	sc->work_urb.error_count = 0;
 	sc->work_urb.status = 0;
 
 	if ((rc = usb_submit_urb(&sc->work_urb, GFP_KERNEL)) != 0) {
 		if (rc == -EPIPE) {
-			printk("%s: Stall at GetMaxLUN, using 1 LUN\n",
+			printk("%s: Stall submitting GetMaxLUN, using 1 LUN\n",
 			     sc->name); /* P3 */
 		} else {
-			printk(KERN_WARNING
+			printk(KERN_NOTICE
 			     "%s: Unable to submit GetMaxLUN (%d)\n",
 			     sc->name, rc);
 		}
@@ -2028,6 +2020,18 @@
 	del_timer_sync(&timer);
 	usb_kill_urb(&sc->work_urb);
 
+	if ((rc = sc->work_urb.status) < 0) {
+		if (rc == -EPIPE) {
+			printk("%s: Stall at GetMaxLUN, using 1 LUN\n",
+			     sc->name); /* P3 */
+		} else {
+			printk(KERN_NOTICE
+			     "%s: Error at GetMaxLUN (%d)\n",
+			     sc->name, rc);
+		}
+		goto err_io;
+	}
+
 	if (sc->work_urb.actual_length != 1) {
 		printk("%s: GetMaxLUN returned %d bytes\n", sc->name,
 		    sc->work_urb.actual_length); /* P3 */
@@ -2048,6 +2052,7 @@
 	kfree(p);
 	return nluns;
 
+err_io:
 err_submit:
 	kfree(p);
 err_alloc:
@@ -2080,7 +2085,6 @@
 
 	usb_fill_control_urb(&sc->work_urb, sc->dev, sc->send_ctrl_pipe,
 	    (unsigned char*) cr, NULL, 0, ub_probe_urb_complete, &compl);
-	sc->work_urb.transfer_flags = 0;
 	sc->work_urb.actual_length = 0;
 	sc->work_urb.error_count = 0;
 	sc->work_urb.status = 0;
@@ -2241,10 +2245,10 @@
 	for (i = 0; i < 3; i++) {
 		if ((rc = ub_sync_getmaxlun(sc)) < 0) {
 			/* 
-			 * Some devices (i.e. Iomega Zip100) need this --
-			 * apparently the bulk pipes get STALLed when the
-			 * GetMaxLUN request is processed.
-			 * XXX I have a ZIP-100, verify it does this.
+			 * This segment is taken from usb-storage. They say
+			 * that ZIP-100 needs this, but my own ZIP-100 works
+			 * fine without this.
+			 * Still, it does not seem to hurt anything.
 			 */
 			if (rc == -EPIPE) {
 				ub_probe_clear_stall(sc, sc->recv_bulk_pipe);
@@ -2313,7 +2317,7 @@
 	disk->first_minor = lun->id * UB_MINORS_PER_MAJOR;
 	disk->fops = &ub_bd_fops;
 	disk->private_data = lun;
-	disk->driverfs_dev = &sc->intf->dev;	/* XXX Many to one ok? */
+	disk->driverfs_dev = &sc->intf->dev;
 
 	rc = -ENOMEM;
 	if ((q = blk_init_queue(ub_request_fn, &sc->lock)) == NULL)
@@ -2466,9 +2470,6 @@
 {
 	int rc;
 
-	/* P3 */ printk("ub: sizeof ub_scsi_cmd %zu ub_dev %zu ub_lun %zu\n",
-			sizeof(struct ub_scsi_cmd), sizeof(struct ub_dev), sizeof(struct ub_lun));
-
 	if ((rc = register_blkdev(UB_MAJOR, DRV_NAME)) != 0)
 		goto err_regblkdev;
 	devfs_mk_dir(DEVFS_NAME);

--
