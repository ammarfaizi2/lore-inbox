Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWI0QRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWI0QRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWI0QRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:17:18 -0400
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:30950 "EHLO
	lucian.tromer.org") by vger.kernel.org with ESMTP id S1751169AbWI0QRP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:17:15 -0400
Message-ID: <451AA16F.1080704@tromer.org>
Date: Wed, 27 Sep 2006 19:06:07 +0300
From: Eran Tromer <eran@tromer.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Mark Lord <mlord@pobox.com>
Subject: [patch] libata: return sense data in HDIO_DRIVE_CMD ioctl
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the HDIO_DRIVE_CMD ioctl in libata (ATA command pass through)
return a few ATA registers to userspace, following the same convention
as the drivers/ide implementation of the same ioctl. This is needed to
support ATA commands like CHECK POWER MODE, which return information
in nsectors.

This fixes "hdparm -C" on SATA drives.

Forcing the sense data read via the cc flag causes spurious check
conditions, so we filter these out (following the
ATA command pass-through specification T10/04-262r7).

Signed-off-by: Eran Tromer <eran@tromer.org>
---

Applies to git/jgarzik/libata-dev.git master and git/torvalds/linux-2.6.git
master. To apply to 2.6.18, change drivers/ata/ to drivers/scsi/.

On 2006-08-29 05:39, Tejun Heo wrote to linux-ide@vger.kernel.org:
>> 2) hdparm -C for all 4 drives always shows "drive state is:  standby"
>>    even when I'm certain that the drives are active.
>
> hdparm -C says the same thing for my drive.  I think it's safe to
> ignore.  Hmmm... it needs to be tracked down.  Maybe some problem in
> HDIO ioctl implementation in libata.

Yes, and fixed by this patch.


drivers/ata/libata-scsi.c |   46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
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
+	if ((cmd_result>>24) == DRIVER_SENSE) {   /* sense data available */
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

