Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264918AbUKBA4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbUKBA4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S387993AbUKBAzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:55:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13956 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S387506AbUKBAoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:44:46 -0500
Date: Mon, 1 Nov 2004 16:44:32 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org, <cova@ferrara.linux.it>, <cs@tequila.co.jp>
Subject: Test patch for ub and double registration
Message-ID: <20041101164432.3fa72b81@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here's a patch to fix the double kobject registration problem with the ub.
One little problem here is that I do not have a device which fails this
way, so I would like owners of such devices to give it a try.

The latest victim of this is Fabio Coatti. It should be noted that this
fix only (supposed to) prevents oopses on deregistration. If the device
doesn't work generally (for example, requires START STOP UNIT), it won't
help that.

Clemens' bug report wasn't clear enough. It may be this, may be something
else.

The flash key given on KS does the same, but we worked around that
particular units with Ben Herrenschmidt, so they are not good test cases
anymore.

-- Pete

diff -urp -X dontdiff linux-2.6.10-rc1/drivers/block/ub.c linux-2.6.10-rc1-ub/drivers/block/ub.c
--- linux-2.6.10-rc1/drivers/block/ub.c	2004-10-28 09:46:38.000000000 -0700
+++ linux-2.6.10-rc1-ub/drivers/block/ub.c	2004-11-01 12:35:10.000000000 -0800
@@ -188,7 +188,7 @@ struct ub_capacity {
  */
 
 #define SCMD_ST_HIST_SZ   8
-#define SCMD_TRACE_SZ    15	/* No more than 256 (trace_index) */
+#define SCMD_TRACE_SZ    63		/* Less than 4KB of 61-byte lines */
 
 struct ub_scsi_cmd_trace {
 	int hcur;
@@ -267,6 +267,7 @@ struct ub_dev {
 	int changed;			/* Media was changed */
 	int removable;
 	int readonly;
+	int first_open;			/* Kludge. See ub_bd_open. */
 	char name[8];
 	struct usb_device *dev;
 	struct usb_interface *intf;
@@ -959,9 +957,12 @@ static void ub_scsi_urb_compl(struct ub_
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
@@ -1428,6 +1424,26 @@ static int ub_bd_open(struct inode *inod
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
 
@@ -1467,6 +1483,8 @@ static int ub_bd_release(struct inode *i
 
 	spin_lock_irqsave(&ub_lock, flags);
 	--sc->openc;
+	if (sc->openc == 0)
+		sc->first_open = 0;
 	if (sc->openc == 0 && atomic_read(&sc->poison))
 		ub_cleanup(sc);
 	spin_unlock_irqrestore(&ub_lock, flags);

@@ -1919,6 +1933,8 @@ static int ub_probe(struct usb_interface
 	}
 
 	sc->removable = 1;		/* XXX Query this from the device */
+	sc->changed = 1;		/* ub_revalidate clears only */
+	sc->first_open = 1;
 
 	ub_revalidate(sc);
 	/* This is pretty much a long term P3 */
