Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTBEQK0>; Wed, 5 Feb 2003 11:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbTBEQK0>; Wed, 5 Feb 2003 11:10:26 -0500
Received: from host194.steeleye.com ([66.206.164.34]:3082 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261530AbTBEQKY>; Wed, 5 Feb 2003 11:10:24 -0500
Subject: Re: [PATCH] Re: [CHECKER] 112 potential memory leaks in 2.5.48
From: James Bottomley <James.Bottomley@steeleye.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Andy Chou <acc@CS.Stanford.EDU>, mc@CS.Stanford.EDU,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <Pine.LNX.4.50L.0302050037460.32328-100000@imladris.surriel.com>
References: <20030205011353.GA17941@Xenon.Stanford.EDU>
	<Pine.LNX.4.50L.0302050037280.32328-100000@imladris.surriel.com> 
	<Pine.LNX.4.50L.0302050037460.32328-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 05 Feb 2003 10:19:48 -0600
Message-Id: <1044461995.1773.44.camel@mulgrave>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-04 at 20:42, Rik van Riel wrote:
> The patch below fixes the scsi request leak. I'm not sure
> how the bounce buffer thing is supposed to work (Christoph?
> James?) so I'm not touching that at the moment.

The patch below should fix all the bounce buffer problems (including the
stack allocation of a DMA region, the missing kfree and use of
virt_to_phys).

> Linus, could you please apply this patch (against today's
> bk tree) ?

I've captured both patches in the scsi-misc-2.5 BK tree.

James

===== ./sr_ioctl.c 1.28 vs edited =====
--- 1.28/drivers/scsi/sr_ioctl.c	Tue Feb  4 17:37:02 2003
+++ edited/./sr_ioctl.c	Wed Feb  5 10:18:19 2003
@@ -80,30 +80,16 @@
 	struct scsi_device *SDev;
         struct request *req;
 	int result, err = 0, retries = 0;
-	char *bounce_buffer;
 
 	SDev = cd->device;
 	SRpnt = scsi_allocate_request(SDev);
         if (!SRpnt) {
-                printk("Unable to allocate SCSI request in sr_do_ioctl");
+                printk(KERN_ERR "Unable to allocate SCSI request in sr_do_ioctl");
 		err = -ENOMEM;
 		goto out;
         }
 	SRpnt->sr_data_direction = cgc->data_direction;
 
-	/* use ISA DMA buffer if necessary */
-	SRpnt->sr_request->buffer = cgc->buffer;
-	if (cgc->buffer && SRpnt->sr_host->unchecked_isa_dma &&
-	    (virt_to_phys(cgc->buffer) + cgc->buflen - 1 > ISA_DMA_THRESHOLD)) {
-		bounce_buffer = (char *) kmalloc(cgc->buflen, GFP_DMA);
-		if (bounce_buffer == NULL) {
-			printk("SCSI DMA pool exhausted.");
-			err = -ENOMEM;
-			goto out_free;
-		}
-		memcpy(bounce_buffer, cgc->buffer, cgc->buflen);
-		cgc->buffer = bounce_buffer;
-	}
       retry:
 	if (!scsi_block_when_processing_errors(SDev)) {
 		err = -ENODEV;
@@ -276,11 +262,15 @@
 	return 0;
 }
 
+/* primitive to determine whether we need to have GFP_DMA set based on
+ * the status of the unchecked_isa_dma flag in the host structure */
+#define SR_GFP_DMA(cd) (((cd)->device->host->unchecked_isa_dma) ? GFP_DMA : 0)
+
 int sr_get_mcn(struct cdrom_device_info *cdi, struct cdrom_mcn *mcn)
 {
 	Scsi_CD *cd = cdi->handle;
 	struct cdrom_generic_command cgc;
-	char buffer[32];
+	char *buffer = kmalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
 	int result;
 
 	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
@@ -297,6 +287,7 @@
 	memcpy(mcn->medium_catalog_number, buffer + 9, 13);
 	mcn->medium_catalog_number[13] = 0;
 
+	kfree(buffer);
 	return result;
 }
 
@@ -338,7 +329,7 @@
 	Scsi_CD *cd = cdi->handle;
 	struct cdrom_generic_command cgc;
 	int result;
-	unsigned char buffer[32];
+	unsigned char *buffer = kmalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
 
 	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
 	cgc.timeout = IOCTL_TIMEOUT;
@@ -409,7 +400,7 @@
 	}
 
 	default:
-		return -EINVAL;
+		result = -EINVAL;
 	}
 
 #if 0
@@ -417,6 +408,7 @@
 		printk("DEBUG: sr_audio: result for ioctl %x: %x\n", cmd, result);
 #endif
 
+	kfree(buffer);
 	return result;
 }
 
@@ -528,7 +520,7 @@
 	if (!xa_test)
 		return 0;
 
-	raw_sector = (unsigned char *) kmalloc(2048, GFP_DMA | GFP_KERNEL);
+	raw_sector = (unsigned char *) kmalloc(2048, GFP_KERNEL | SR_GFP_DMA(cd));
 	if (!raw_sector)
 		return -ENOMEM;
 	if (0 == sr_read_sector(cd, cd->ms_offset + 16,


