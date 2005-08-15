Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVHOWMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVHOWMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVHOWMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:12:36 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:63397 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S965003AbVHOWMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:12:35 -0400
Message-ID: <430112F6.3090906@dresco.co.uk>
Date: Mon, 15 Aug 2005 23:11:02 +0100
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jgarzik@pobox.com
Subject: Re: [patch] libata passthrough - return register data from HDIO_*
 commands
References: <42FE2FBA.3000605@dresco.co.uk>
In-Reply-To: <42FE2FBA.3000605@dresco.co.uk>
Content-Type: multipart/mixed;
 boundary="------------050108040801090608060504"
X-Hops: 1
X-Originating-Heisenberg-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050108040801090608060504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Here is a first attempt at a patch to return register data from the 
> libata passthrough HDIO ioctl handlers, I needed this as the ATA 
> 'unload immediate' command returns the success in the lbal register. 
> This patch applies on top of 2.6.12 and Jeffs 
> 2.6.12-git4-passthru1.patch. (Apologies, but Thunderbird appears to 
> have replaced the tabs with spaces).
>
> One oddity is that the sr_result field is correctly being set in 
> ata_gen_ata_desc_sense(), however the high word is different when 
> we're back in the ioctl hander. I've coded round this for now by only 
> checking the low word, but this needs more investigation.
>
> Jeff, could this functionality be incorporated into the pasthrough 
> patch when complete?


I'd failed to realise that scsi_finish_command() sets the high byte of 
the result field to DRIVER_SENSE when there is sense data. Patch updated 
to reflect this...

Haven't had any feedback on the patch itself - but this now does what I 
wanted it do to.  (I can't find a way to make Thunderbird retain tabs in 
the message body, so sending as an attachment).

Regards,
Jon.



______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
--------------050108040801090608060504
Content-Type: text/x-patch;
 name="passthrough_check_condition.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="passthrough_check_condition.patch"

--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -89,6 +89,7 @@
 	u8 args[4], *argbuf = NULL;
 	int argsize = 0;
 	struct scsi_request *sreq;
+	unsigned char *sb, *desc;
 
 	if (NULL == (void *)arg)
 		return -EINVAL;
@@ -100,6 +101,9 @@
 	if (!sreq)
 		return -EINTR;
 
+	sb = sreq->sr_sense_buffer;
+	desc = sb + 8;
+
 	memset(scsi_cmd, 0, sizeof(scsi_cmd));
 
 	if (args[3]) {
@@ -109,12 +113,12 @@
 			return -ENOMEM;
 
 		scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
-		scsi_cmd[2]  = 0x0e;     /* no off.line or cc, read from dev,
+		scsi_cmd[2]  = 0x2e;     /* no off.line, read from dev, request cc
 		                            block count in sector count field */
 		sreq->sr_data_direction = DMA_FROM_DEVICE;
 	} else {
 		scsi_cmd[1]  = (3 << 1); /* Non-data */
-		/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
+		scsi_cmd[2]  = 0x20;     /* no off.line or data xfer, request check condtion */
 		sreq->sr_data_direction = DMA_NONE;
 	}
 
@@ -135,16 +139,24 @@
 	   from scsi_ioctl_send_command() for default case... */
 	scsi_wait_req(sreq, scsi_cmd, argbuf, argsize, (10*HZ), 5);
 
-	if (sreq->sr_result) {
+	if (!sreq->sr_result == ((DRIVER_SENSE << 24) + SAM_STAT_CHECK_CONDITION)) {
 		rc = -EIO;
 		goto error;
 	}
 
-	/* Need code to retrieve data from check condition? */
+	/* Retrieve data from check condition */
+	args[1] = desc[3];
+	args[2] = desc[5];
+	args[3] = desc[7];
+	args[4] = desc[9];
+	args[5] = desc[11];
+	args[0] = desc[13];
 
 	if ((argbuf)
 	 && copy_to_user((void *)(arg + sizeof(args)), argbuf, argsize))
 		rc = -EFAULT;
+	if (copy_to_user(arg, args, sizeof(args)))
+		rc = -EFAULT;
 error:
 	scsi_release_request(sreq);
 
@@ -171,6 +183,7 @@
 	u8 scsi_cmd[MAX_COMMAND_SIZE];
 	u8 args[7];
 	struct scsi_request *sreq;
+	unsigned char *sb, *desc;
 
 	if (NULL == (void *)arg)
 		return -EINVAL;
@@ -181,7 +194,7 @@
 	memset(scsi_cmd, 0, sizeof(scsi_cmd));
 	scsi_cmd[0]  = ATA_16;
 	scsi_cmd[1]  = (3 << 1); /* Non-data */
-	/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
+	scsi_cmd[2]  = 0x20;     /* no off.line, or data xfer, request cc */
 	scsi_cmd[4]  = args[1];
 	scsi_cmd[6]  = args[2];
 	scsi_cmd[8]  = args[3];
@@ -195,18 +208,29 @@
 		goto error;
 	}
 
+	sb = sreq->sr_sense_buffer;
+	desc = sb + 8;
+
 	sreq->sr_data_direction = DMA_NONE;
 	/* Good values for timeout and retries?  Values below
 	   from scsi_ioctl_send_command() for default case... */
 	scsi_wait_req(sreq, scsi_cmd, NULL, 0, (10*HZ), 5);
 
-	if (sreq->sr_result) {
+	if (!sreq->sr_result == ((DRIVER_SENSE << 24) + SAM_STAT_CHECK_CONDITION)) {
 		rc = -EIO;
 		goto error;
 	}
 
-	/* Need code to retrieve data from check condition? */
+	/* Retrieve data from check condition */
+	args[1] = desc[3];
+	args[2] = desc[5];
+	args[3] = desc[7];
+	args[4] = desc[9];
+	args[5] = desc[11];
+	args[0] = desc[13];
 
+	if (copy_to_user(arg, args, sizeof(args)))
+		rc = -EFAULT;
 error:
 	scsi_release_request(sreq);
 	return rc;

--------------050108040801090608060504--
