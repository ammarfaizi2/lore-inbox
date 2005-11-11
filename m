Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVKKWjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVKKWjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 17:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVKKWjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 17:39:40 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:37819 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751285AbVKKWjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 17:39:14 -0500
Subject: Re: [GIT PATCH] final pre -rc pieces of SCSI for 2.6.14
From: Mike Christie <michaelc@cs.wisc.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051111222341.GA20077@infradead.org>
References: <1131745742.3505.47.camel@mulgrave>
	 <20051111222341.GA20077@infradead.org>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 16:38:53 -0600
Message-Id: <1131748733.15249.1.camel@max>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 22:23 +0000, Christoph Hellwig wrote:
> On Fri, Nov 11, 2005 at 03:49:01PM -0600, James Bottomley wrote:
> >   o remove scsi_wait_req
> 
> This requires '[PATCH] kill libata scsi_wait_req usage (make libata compile in
> scsi-misc)' from Mike, because libata started to use this function in mainline
> about the same time it was removed in scsi-misc.


My previous patch needed to included scsi_eh.h. Someone sent a patch in
-mm to d othis. Here is my patch plus the scsi_eh.h include patch rolled
into one if you need it.

rm scsi_wait_req() usage.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>


diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index bb30fcd..b101f8e 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -38,6 +38,7 @@
 #include <linux/spinlock.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_eh.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_request.h>
 #include <linux/libata.h>
@@ -147,7 +148,8 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	u8 scsi_cmd[MAX_COMMAND_SIZE];
 	u8 args[4], *argbuf = NULL;
 	int argsize = 0;
-	struct scsi_request *sreq;
+	struct scsi_sense_hdr sshdr;
+	enum dma_data_direction data_dir;
 
 	if (NULL == (void *)arg)
 		return -EINVAL;
@@ -155,10 +157,6 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	if (copy_from_user(args, arg, sizeof(args)))
 		return -EFAULT;
 
-	sreq = scsi_allocate_request(scsidev, GFP_KERNEL);
-	if (!sreq)
-		return -EINTR;
-
 	memset(scsi_cmd, 0, sizeof(scsi_cmd));
 
 	if (args[3]) {
@@ -172,11 +170,11 @@ int ata_cmd_ioctl(struct scsi_device *sc
 		scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
 		scsi_cmd[2]  = 0x0e;     /* no off.line or cc, read from dev,
 		                            block count in sector count field */
-		sreq->sr_data_direction = DMA_FROM_DEVICE;
+		data_dir = DMA_FROM_DEVICE;
 	} else {
 		scsi_cmd[1]  = (3 << 1); /* Non-data */
 		/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
-		sreq->sr_data_direction = DMA_NONE;
+		data_dir = DMA_NONE;
 	}
 
 	scsi_cmd[0] = ATA_16;
@@ -194,9 +192,8 @@ int ata_cmd_ioctl(struct scsi_device *sc
 
 	/* Good values for timeout and retries?  Values below
 	   from scsi_ioctl_send_command() for default case... */
-	scsi_wait_req(sreq, scsi_cmd, argbuf, argsize, (10*HZ), 5);
-
-	if (sreq->sr_result) {
+	if (scsi_execute_req(scsidev, scsi_cmd, data_dir, argbuf, argsize,
+			     &sshdr, (10*HZ), 5)) {
 		rc = -EIO;
 		goto error;
 	}
@@ -207,8 +204,6 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	 && copy_to_user((void *)(arg + sizeof(args)), argbuf, argsize))
 		rc = -EFAULT;
 error:
-	scsi_release_request(sreq);
-
 	if (argbuf)
 		kfree(argbuf);
 
@@ -231,7 +226,7 @@ int ata_task_ioctl(struct scsi_device *s
 	int rc = 0;
 	u8 scsi_cmd[MAX_COMMAND_SIZE];
 	u8 args[7];
-	struct scsi_request *sreq;
+	struct scsi_sense_hdr sshdr;
 
 	if (NULL == (void *)arg)
 		return -EINVAL;
@@ -250,26 +245,13 @@ int ata_task_ioctl(struct scsi_device *s
 	scsi_cmd[12] = args[5];
 	scsi_cmd[14] = args[0];
 
-	sreq = scsi_allocate_request(scsidev, GFP_KERNEL);
-	if (!sreq) {
-		rc = -EINTR;
-		goto error;
-	}
-
-	sreq->sr_data_direction = DMA_NONE;
 	/* Good values for timeout and retries?  Values below
-	   from scsi_ioctl_send_command() for default case... */
-	scsi_wait_req(sreq, scsi_cmd, NULL, 0, (10*HZ), 5);
-
-	if (sreq->sr_result) {
+	   from scsi_ioctl_send_command() for default case... */	
+	if (scsi_execute_req(scsidev, scsi_cmd, DMA_NONE, NULL, 0, &sshdr,
+			     (10*HZ), 5))
 		rc = -EIO;
-		goto error;
-	}
 
 	/* Need code to retrieve data from check condition? */
-
-error:
-	scsi_release_request(sreq);
 	return rc;
 }
 


