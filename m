Return-Path: <linux-kernel-owner+w=401wt.eu-S1754593AbWLRVEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbWLRVEA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 16:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbWLRVEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 16:04:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42048 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754589AbWLRVD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 16:03:59 -0500
Message-ID: <458702D9.6080800@redhat.com>
Date: Mon, 18 Dec 2006 15:06:33 -0600
From: David Milburn <dmilburn@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jgarzik@pobox.com
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libata-scsi: ata_task_ioctl should return ATA registers from
 sense data
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

User applications using the HDIO_DRIVE_TASK ioctl through libata
expect specific ATA registers to be returned to userspace. Verified
that ata_task_ioctl correctly returns register values to the
smartctl application.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a4790be..1966294 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -273,8 +273,8 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
  {
         int rc = 0;
         u8 scsi_cmd[MAX_COMMAND_SIZE];
-       u8 args[7];
-       struct scsi_sense_hdr sshdr;
+       u8 args[7], *sensebuf = NULL;
+       int cmd_result;

         if (arg == NULL)
                 return -EINVAL;
@@ -282,10 +282,14 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
         if (copy_from_user(args, arg, sizeof(args)))
                 return -EFAULT;

+       sensebuf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_NOIO);
+       if (!sensebuf)
+               return -ENOMEM;
+
         memset(scsi_cmd, 0, sizeof(scsi_cmd));
         scsi_cmd[0]  = ATA_16;
         scsi_cmd[1]  = (3 << 1); /* Non-data */
-       /* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
+       scsi_cmd[2]  = 0x20;     /* cc but no off.line or data xfer */
         scsi_cmd[4]  = args[1];
         scsi_cmd[6]  = args[2];
         scsi_cmd[8]  = args[3];
@@ -295,11 +299,46 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)

         /* Good values for timeout and retries?  Values below
            from scsi_ioctl_send_command() for default case... */
-       if (scsi_execute_req(scsidev, scsi_cmd, DMA_NONE, NULL, 0, &sshdr,
-                            (10*HZ), 5))
+       cmd_result = scsi_execute(scsidev, scsi_cmd, DMA_NONE, NULL, 0,
+                                 sensebuf, (10*HZ), 5, 0);
+
+       if (driver_byte(cmd_result) == DRIVER_SENSE) {/* sense data available */
+               u8 *desc = sensebuf + 8;
+               cmd_result &= ~(0xFF<<24); /* DRIVER_SENSE is not an error */
+
+               /* If we set cc then ATA pass-through will cause a
+                * check condition even if no error. Filter that. */
+               if (cmd_result & SAM_STAT_CHECK_CONDITION) {
+                       struct scsi_sense_hdr sshdr;
+                       scsi_normalize_sense(sensebuf, SCSI_SENSE_BUFFERSIZE,
+                                            &sshdr);
+                       if (sshdr.sense_key==0 &&
+                           sshdr.asc==0 && sshdr.ascq==0)
+                               cmd_result &= ~SAM_STAT_CHECK_CONDITION;
+               }
+
+               /* Send userspace ATA registers */
+               if (sensebuf[0] == 0x72 &&     /* format is "descriptor" */
+                   desc[0] == 0x09) {         /* code is "ATA Descriptor" */
+                       args[0] = desc[13];    /* status */
+                       args[1] = desc[3];     /* error */
+                       args[2] = desc[5];     /* sector count (0:7) */
+                       args[3] = desc[7];     /* lbal */
+                       args[4] = desc[9];     /* lbam */
+                       args[5] = desc[11];    /* lbah */
+                       args[6] = desc[12];    /* select */
+                       if (copy_to_user(arg, args, sizeof(args)))
+                               rc = -EFAULT;
+               }
+       }
+
+       if (cmd_result) {
                 rc = -EIO;
+               goto error;
+       }

-       /* Need code to retrieve data from check condition? */
+ error:
+       kfree(sensebuf);
         return rc;
  }
