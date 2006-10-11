Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWJKJFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWJKJFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWJKJFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:05:17 -0400
Received: from havoc.gtf.org ([69.61.125.42]:21438 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965196AbWJKJFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:05:14 -0400
Date: Wed, 11 Oct 2006 05:05:14 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fixes
Message-ID: <20061011090514.GA24442@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/libata-core.c  |    6 +++++-
 drivers/ata/libata-scsi.c  |   46 +++++++++++++++++++++++++++++++++++++-------
 drivers/ata/pata_qdi.c     |    2 +-
 drivers/ata/sata_promise.c |    1 +
 4 files changed, 46 insertions(+), 9 deletions(-)

Alan Cox:
      libata: Don't believe bogus claims in the older PIO mode register

Eran Tromer:
      libata: return sense data in HDIO_DRIVE_CMD ioctl

Jeff Garzik:
      [libata] sata_promise: add PCI ID

Peter Korsgaard:
      pata-qdi: fix le32 in data_xfer

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 77138a3..83728a9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -870,7 +870,11 @@ static unsigned int ata_id_xfermask(cons
 		 * the PIO timing number for the maximum. Turn it into
 		 * a mask.
 		 */
-		pio_mask = (2 << (id[ATA_ID_OLD_PIO_MODES] & 0xFF)) - 1 ;
+		u8 mode = id[ATA_ID_OLD_PIO_MODES] & 0xFF;
+		if (mode < 5)	/* Valid PIO range */
+                	pio_mask = (2 << mode) - 1;
+		else
+			pio_mask = 1;
 
 		/* But wait.. there's more. Design your standards by
 		 * committee and you too can get a free iordy field to
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b0d0cc4..7af2a4b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -164,10 +164,10 @@ int ata_cmd_ioctl(struct scsi_device *sc
 {
 	int rc = 0;
 	u8 scsi_cmd[MAX_COMMAND_SIZE];
-	u8 args[4], *argbuf = NULL;
+	u8 args[4], *argbuf = NULL, *sensebuf = NULL;
 	int argsize = 0;
-	struct scsi_sense_hdr sshdr;
 	enum dma_data_direction data_dir;
+	int cmd_result;
 
 	if (arg == NULL)
 		return -EINVAL;
@@ -175,6 +175,10 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	if (copy_from_user(args, arg, sizeof(args)))
 		return -EFAULT;
 
+	sensebuf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_NOIO);
+	if (!sensebuf)
+		return -ENOMEM;
+
 	memset(scsi_cmd, 0, sizeof(scsi_cmd));
 
 	if (args[3]) {
@@ -191,7 +195,7 @@ int ata_cmd_ioctl(struct scsi_device *sc
 		data_dir = DMA_FROM_DEVICE;
 	} else {
 		scsi_cmd[1]  = (3 << 1); /* Non-data */
-		/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
+		scsi_cmd[2]  = 0x20;     /* cc but no off.line or data xfer */
 		data_dir = DMA_NONE;
 	}
 
@@ -210,18 +214,46 @@ int ata_cmd_ioctl(struct scsi_device *sc
 
 	/* Good values for timeout and retries?  Values below
 	   from scsi_ioctl_send_command() for default case... */
-	if (scsi_execute_req(scsidev, scsi_cmd, data_dir, argbuf, argsize,
-			     &sshdr, (10*HZ), 5)) {
+	cmd_result = scsi_execute(scsidev, scsi_cmd, data_dir, argbuf, argsize,
+	                          sensebuf, (10*HZ), 5, 0);
+
+	if (driver_byte(cmd_result) == DRIVER_SENSE) {/* sense data available */
+		u8 *desc = sensebuf + 8;
+		cmd_result &= ~(0xFF<<24); /* DRIVER_SENSE is not an error */
+
+		/* If we set cc then ATA pass-through will cause a
+		 * check condition even if no error. Filter that. */
+		if (cmd_result & SAM_STAT_CHECK_CONDITION) {
+			struct scsi_sense_hdr sshdr;
+			scsi_normalize_sense(sensebuf, SCSI_SENSE_BUFFERSIZE,
+			                      &sshdr);
+			if (sshdr.sense_key==0 &&
+			    sshdr.asc==0 && sshdr.ascq==0)
+				cmd_result &= ~SAM_STAT_CHECK_CONDITION;
+		}
+
+		/* Send userspace a few ATA registers (same as drivers/ide) */
+		if (sensebuf[0] == 0x72 &&     /* format is "descriptor" */
+		    desc[0] == 0x09 ) {        /* code is "ATA Descriptor" */
+			args[0] = desc[13];    /* status */
+			args[1] = desc[3];     /* error */
+			args[2] = desc[5];     /* sector count (0:7) */
+			if (copy_to_user(arg, args, sizeof(args)))
+				rc = -EFAULT;
+		}
+	}
+
+
+	if (cmd_result) {
 		rc = -EIO;
 		goto error;
 	}
 
-	/* Need code to retrieve data from check condition? */
-
 	if ((argbuf)
 	 && copy_to_user(arg + sizeof(args), argbuf, argsize))
 		rc = -EFAULT;
 error:
+	kfree(sensebuf);
 	kfree(argbuf);
 	return rc;
 }
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 7977f47..2c3cc0c 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -141,7 +141,7 @@ static void qdi_data_xfer(struct ata_dev
 				memcpy(&pad, buf + buflen - slop, slop);
 				outl(le32_to_cpu(pad), ap->ioaddr.data_addr);
 			} else {
-				pad = cpu_to_le16(inl(ap->ioaddr.data_addr));
+				pad = cpu_to_le32(inl(ap->ioaddr.data_addr));
 				memcpy(buf + buflen - slop, &pad, slop);
 			}
 		}
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 8bcdfa6..72eda51 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -260,6 +260,7 @@ static const struct pci_device_id pdc_at
 #if 0
 	{ PCI_VDEVICE(PROMISE, 0x3570), board_20771 },
 #endif
+	{ PCI_VDEVICE(PROMISE, 0x3577), board_20771 },
 
 	{ }	/* terminate list */
 };
