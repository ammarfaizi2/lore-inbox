Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSFHVoS>; Sat, 8 Jun 2002 17:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSFHVoR>; Sat, 8 Jun 2002 17:44:17 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:28341 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317457AbSFHVoP>;
	Sat, 8 Jun 2002 17:44:15 -0400
Date: Sat, 8 Jun 2002 23:58:45 +1000
From: Anton Blanchard <anton@samba.org>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020608135845.GC4671@krispykreme>
In-Reply-To: <52vg8ta4ki.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The problem that caused crashes on cache-incoherent architectures (my
> specific system uses a PPC 440GP but this should apply in general) was
> the following.  The USB stack was doing PCI DMA into buffers that were
> allocated on the stack, which causes stack corruption: on the PPC
> 440GP, pci_map_single() with PCI_DMA_FROMDEVICE just invalidates the
> cache for the region being mapped.  However, if a buffer is smaller
> than a cache line, then two bad things can happen.

Yes, DMAing to the stack is definitely a bug, thats mentioned in
Documentation/DMA-mapping.txt. We used to vmalloc our kernel stacks
on ppc64 and that picked up all sorts of DMA violations.

I just checked 2.5 and noticed the scsi code is _still_ DMAing to the
stack! Maybe it would be worth having a debug option for x86 where
it uses vmalloc for kernel stack allocation :)

Anyway attached is a patch from Todd Inglett that I updated for 2.5.

Anton

===== drivers/scsi/scsi_scan.c 1.13 vs edited =====
--- 1.13/drivers/scsi/scsi_scan.c	Fri May 31 11:17:30 2002
+++ edited/drivers/scsi/scsi_scan.c	Sun Jun  9 07:28:25 2002
@@ -368,7 +368,6 @@
 	unsigned int dev;
 	unsigned int lun;
 	unsigned char *scsi_result;
-	unsigned char scsi_result0[256];
 	Scsi_Device *SDpnt;
 	Scsi_Device *SDtail;
 
@@ -390,9 +389,7 @@
 		 */
 		scsi_initialize_queue(SDpnt, shpnt);
 		SDpnt->request_queue.queuedata = (void *) SDpnt;
-		/* Make sure we have something that is valid for DMA purposes */
-		scsi_result = ((!shpnt->unchecked_isa_dma)
-			       ? &scsi_result0[0] : kmalloc(512, GFP_DMA));
+		scsi_result = kmalloc(512, GFP_DMA);
 	}
 
 	if (scsi_result == NULL) {
@@ -532,10 +529,9 @@
 		kfree((char *) SDpnt);
 	}
 
-	/* If we allocated a buffer so we could do DMA, free it now */
-	if (scsi_result != &scsi_result0[0] && scsi_result != NULL) {
-		kfree(scsi_result);
-	} {
+	kfree(scsi_result);
+
+	{
 		Scsi_Device *sdev;
 		Scsi_Cmnd *scmd;
 
===== drivers/scsi/sr_ioctl.c 1.13 vs edited =====
--- 1.13/drivers/scsi/sr_ioctl.c	Thu May 23 23:18:39 2002
+++ edited/drivers/scsi/sr_ioctl.c	Sun Jun  9 07:30:15 2002
@@ -344,7 +344,12 @@
 	Scsi_CD *SCp = cdi->handle;
 	u_char sr_cmd[10];
 	int result, target = minor(cdi->dev);
-	unsigned char buffer[32];
+	unsigned char *buffer = kmalloc(512, GFP_DMA);
+
+	if (buffer == NULL) {
+		printk("SCSI DMA pool exhausted.");
+		return -ENOMEM;
+	}
 
 	memset(sr_cmd, 0, sizeof(sr_cmd));
 
@@ -417,6 +422,7 @@
 		return -EINVAL;
 	}
 
+	kfree(buffer);
 #if 0
 	if (result)
 		printk("DEBUG: sr_audio: result for ioctl %x: %x\n", cmd, result);
