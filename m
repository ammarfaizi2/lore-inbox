Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbTLOSqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTLOSqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:46:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:32956 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264258AbTLOSqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:46:18 -0500
Date: Mon, 15 Dec 2003 10:46:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Toad <toad@amphibian.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11,
 reading an apparently duff DVD-R
In-Reply-To: <20031215135802.GA4332@amphibian.dyndns.org>
Message-ID: <Pine.LNX.4.58.0312151043480.1631@home.osdl.org>
References: <20031215135802.GA4332@amphibian.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Toad wrote:
>
> ide-scsi: reset called for 133

Ok, I can't trigger an IDE reset even with a bad CDROM, so I'm kind of out
of luck on testing this. Can you try out the following silly patch, and
report what it says?

The old ide-scsi reset function is just terminally broken, there's no way
it can work. This patch _might_ make it work, but is more likely to just
print out what it's trying to do.

		Linus

----
--- 1.34/drivers/scsi/ide-scsi.c	Tue Dec  2 19:03:55 2003
+++ edited/drivers/scsi/ide-scsi.c	Mon Dec 15 10:17:52 2003
@@ -882,35 +882,26 @@
 	return FAILED;
 }

-static int idescsi_reset (Scsi_Cmnd *cmd)
+static int idescsi_device_reset(Scsi_Cmnd *cmd)
+{
+	printk("IDE device reset requested\n");
+	return FAILED;
+}
+
+static int idescsi_bus_reset(Scsi_Cmnd *cmd)
 {
-	unsigned long flags;
-	struct request *req;
 	idescsi_scsi_t *idescsi = scsihost_to_idescsi(cmd->device->host);
 	ide_drive_t *drive = idescsi->drive;

-	printk (KERN_ERR "ide-scsi: reset called for %lu\n", cmd->serial_number);
-	/* first null the handler for the drive and let any process
-	 * doing IO (on another CPU) run to (partial) completion
-	 * the lock prevents processing new requests */
-	spin_lock_irqsave(&ide_lock, flags);
-	while (HWGROUP(drive)->handler) {
-		HWGROUP(drive)->handler = NULL;
-		schedule_timeout(1);
-	}
-	/* now nuke the drive queue */
-	while ((req = elv_next_request(drive->queue))) {
-		blkdev_dequeue_request(req);
-		end_that_request_last(req);
-	}
-	/* FIXME - this will probably leak memory */
-	HWGROUP(drive)->rq = NULL;
-	if (drive_to_idescsi(drive))
-		drive_to_idescsi(drive)->pc = NULL;
-	spin_unlock_irqrestore(&ide_lock, flags);
-	/* finally, reset the drive (and its partner on the bus...) */
-	ide_do_reset (drive);
+	printk("IDE bus reset requested\n");
+	ide_do_reset(drive);
 	return SUCCESS;
+}
+
+static int idescsi_host_reset(Scsi_Cmnd *cmd)
+{
+	printk("IDE host reset requested\n");
+	return FAILED;
 }

 static int idescsi_bios(struct scsi_device *sdev, struct block_device *bdev,
@@ -935,7 +926,9 @@
 	.ioctl			= idescsi_ioctl,
 	.queuecommand		= idescsi_queue,
 	.eh_abort_handler	= idescsi_abort,
-	.eh_device_reset_handler = idescsi_reset,
+	.eh_device_reset_handler = idescsi_device_reset,
+	.eh_bus_reset_handler	= idescsi_bus_reset,
+	.eh_host_reset_handler	= idescsi_host_reset,
 	.bios_param		= idescsi_bios,
 	.can_queue		= 40,
 	.this_id		= -1,
