Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280984AbRLLP41>; Wed, 12 Dec 2001 10:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280975AbRLLP4S>; Wed, 12 Dec 2001 10:56:18 -0500
Received: from adsl-64-109-89-110.dsl.chcgil.ameritech.net ([64.109.89.110]:22095
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S280971AbRLLP4C>; Wed, 12 Dec 2001 10:56:02 -0500
Message-Id: <200112121555.fBCFts102280@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 53c700 compile fixes for 2.5.1-preX
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-386015440"
Date: Wed, 12 Dec 2001 10:55:54 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-386015440
Content-Type: text/plain; charset=us-ascii

The attached now makes the 53c700 driver and it's dependents compile and run 
in 2.5.1-preX.

James Bottomley


--==_Exmh_-386015440
Content-Type: text/plain ; name="53c700-2.5.1-pre8.diff"; charset=us-ascii
Content-Description: 53c700-2.5.1-pre8.diff
Content-Disposition: attachment; filename="53c700-2.5.1-pre8.diff"

Index: drivers/scsi/53c700.c
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.5/drivers/scsi/53c700.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 53c700.c
--- drivers/scsi/53c700.c	9 Dec 2001 18:21:22 -0000	1.1.1.2
+++ drivers/scsi/53c700.c	12 Dec 2001 15:52:14 -0000
@@ -310,7 +310,6 @@
 	hostdata->pScript = pScript;
 	NCR_700_dma_cache_wback((unsigned long)script, sizeof(SCRIPT));
 	hostdata->state = NCR_700_HOST_FREE;
-	spin_lock_init(&hostdata->lock);
 	hostdata->cmd = NULL;
 	host->max_id = 7;
 	host->max_lun = NCR_700_MAX_LUNS;
@@ -1410,17 +1409,18 @@
 		(struct NCR_700_command_slot *)SCp->host_scribble;
 	struct NCR_700_Host_Parameters *hostdata =
 		(struct NCR_700_Host_Parameters *)SCp->host->hostdata[0];
-	unsigned long flags;
 	__u16 count = 1;	/* for IDENTIFY message */
 	
-	save_flags(flags);
-	cli();
+	/* Routine must be protected against interruption while we
+	 * tamper with the SCSI hardware.  Since this lock is also an 
+	 * IRQ one, we can rely on interrupts being disabled as well */
+	ASSERT_LOCK(&SCp->host->host_lock, 1);
+
 	if(hostdata->state != NCR_700_HOST_FREE) {
 		/* keep this inside the lock to close the race window where
 		 * the running command finishes on another CPU while we don't
 		 * change the state to queued on this one */
 		slot->state = NCR_700_SLOT_QUEUED;
-		restore_flags(flags);
 
 		DEBUG(("scsi%d: host busy, queueing command %p, slot %p\n",
 		       SCp->host->host_no, slot->cmnd, slot));
@@ -1488,12 +1488,6 @@
 	NCR_700_writel(slot->temp, SCp->host, TEMP_REG);
 	NCR_700_writel(slot->resume_offset, SCp->host, DSP_REG);
 
-	/* allow interrupts here so that if we're selected we can take
-	 * a selection interrupt.  The script start may not be
-	 * effective in this case, but the selection interrupt will
-	 * save our command in that case */
-	restore_flags(flags);
-
 	return 1;
 }
 
@@ -1519,7 +1513,7 @@
 	 * of locking in queuecommand: 1) io_request_lock then 2)
 	 * hostdata->lock would be the reverse of taking it in this
 	 * routine */
-	spin_lock_irqsave(&io_request_lock, flags);
+	spin_lock_irqsave(&host->host_lock, flags);
 	if((istat = NCR_700_readb(host, ISTAT_REG))
 	      & (SCSI_INT_PENDING | DMA_INT_PENDING)) {
 		__u32 dsps;
@@ -1764,7 +1758,7 @@
 		}
 	}
  out_unlock:
-	spin_unlock_irqrestore(&io_request_lock, flags);
+	spin_unlock_irqrestore(&host->host_lock, flags);
 }
 
 /* FIXME: Need to put some proc information in and plumb it
Index: drivers/scsi/53c700.h
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.5/drivers/scsi/53c700.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 53c700.h
--- drivers/scsi/53c700.h	9 Dec 2001 17:08:58 -0000	1.1.1.1
+++ drivers/scsi/53c700.h	12 Dec 2001 15:52:14 -0000
@@ -234,10 +234,6 @@
 	__u32	*script;		/* pointer to script location */
 	__u32	pScript;		/* physical mem addr of script */
 
-	/* This will be the host lock.  Unfortunately, we can't use it
-	 * at the moment because of the necessity of holding the
-	 * io_request_lock */
-	spinlock_t lock;
 	enum NCR_700_Host_State state; /* protected by state lock */
 	Scsi_Cmnd *cmd;
 	/* Note: pScript contains the single consistent block of

--==_Exmh_-386015440--


