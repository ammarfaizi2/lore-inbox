Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291802AbSBNRzX>; Thu, 14 Feb 2002 12:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291806AbSBNRzG>; Thu, 14 Feb 2002 12:55:06 -0500
Received: from 216-42-72-167.ppp.netsville.net ([216.42.72.167]:48548 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S291802AbSBNRyK>; Thu, 14 Feb 2002 12:54:10 -0500
Date: Thu, 14 Feb 2002 12:53:57 -0500
From: Chris Mason <mason@suse.com>
To: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] write barriers for 2.4.x
Message-ID: <3489050000.1013709237@tiny>
In-Reply-To: <3398950000.1013702503@tiny>
In-Reply-To: <3045480000.1013637574@tiny> <m3vgd1ufbt.fsf@merlin.emma.line.org> <3398950000.1013702503@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, February 14, 2002 11:01:43 AM -0500 Chris Mason <mason@suse.com> wrote:
> 
> [ barrier support for sym53c8xx_2?]
> 
> I can only promise this compiles against 2.4.18-pre9, and looks right
> to me.  l-k and Jens brought into cc in hopes of a little verification.

Whoops, forgot the template change to tell the upper layer the device
supports ordered requests.

Here's a better patch, it includes equally untested BusLogic support
too.

--- barrier.1/drivers/scsi/BusLogic.c Wed, 05 Dec 2001 09:35:31 -0500 root (linux/z/b/7_BusLogic.c 1.2 644)
+++ barrier.1(w)/drivers/scsi/BusLogic.c Thu, 14 Feb 2002 12:38:05 -0500 root (linux/z/b/7_BusLogic.c 1.2 644)
@@ -3464,7 +3464,13 @@
     }
   if (TargetFlags->TaggedQueuingActive)
     {
-      BusLogic_QueueTag_T QueueTag = BusLogic_SimpleQueueTag;
+      BusLogic_QueueTag_T QueueTag;
+
+      if (Command->request.cmd_flags & RQ_WRITE_ORDERED)
+        QueueTag = BusLogic_OrderedQueueTag;
+      else      
+        QueueTag = BusLogic_SimpleQueueTag;
+
       /*
 	When using Tagged Queuing with Simple Queue Tags, it appears that disk
 	drive controllers do not guarantee that a queued command will not
Index: barrier.1/drivers/scsi/BusLogic.h
--- barrier.1/drivers/scsi/BusLogic.h Tue, 06 Nov 2001 15:47:39 -0500 root (linux/B/b/29_BusLogic.h 1.1 644)
+++ barrier.1(w)/drivers/scsi/BusLogic.h Thu, 14 Feb 2002 12:38:40 -0500 root (linux/B/b/29_BusLogic.h 1.1 644)
@@ -79,6 +79,7 @@
     bios_param:     BusLogic_BIOSDiskParameters,  /* BIOS Disk Parameters   */ \
     unchecked_isa_dma: 1,			  /* Default Initial Value  */ \
     max_sectors:    128,			  /* I/O queue len limit    */ \
+    can_order:      1,      			  /* can order tags         */ \
     use_clustering: ENABLE_CLUSTERING }		  /* Enable Clustering	    */
 
 
Index: barrier.1/drivers/scsi/sym53c8xx_2/sym_glue.c
--- barrier.1/drivers/scsi/sym53c8xx_2/sym_glue.c Thu, 13 Dec 2001 11:06:51 -0500 root (linux/H/d/36_sym_glue.c 1.2 644)
+++ barrier.1(w)/drivers/scsi/sym53c8xx_2/sym_glue.c Thu, 14 Feb 2002 10:43:01 -0500 root (linux/H/d/36_sym_glue.c 1.2 644)
@@ -729,7 +729,14 @@
 	 *  Select tagged/untagged.
 	 */
 	lp = sym_lp(np, tp, ccb->lun);
-	order = (lp && lp->s.reqtags) ? M_SIMPLE_TAG : 0;
+	if (lp && lp->s.reqtags) {
+		if (ccb->request.cmd_flags & RQ_WRITE_ORDERED)
+			order = M_ORDERED_TAG;
+		else
+			order = M_SIMPLE_TAG;
+	} else {
+		order = 0 ;
+	}
 
 	/*
 	 *  Queue the SCSI IO.
Index: barrier.1/drivers/scsi/sym53c8xx_2/sym53c8xx.h
--- barrier.1/drivers/scsi/sym53c8xx_2/sym53c8xx.h Thu, 13 Dec 2001 11:06:51 -0500 root (linux/I/d/17_sym53c8xx. 1.2 644)
+++ barrier.1(w)/drivers/scsi/sym53c8xx_2/sym53c8xx.h Thu, 14 Feb 2002 12:30:29 -0500 root (linux/I/d/17_sym53c8xx. 1.2 644)
@@ -119,6 +119,7 @@
 	this_id:		7,					\
 	sg_tablesize:		0,					\
 	cmd_per_lun:		0,					\
+	can_order:		1,					\
 	use_clustering:		DISABLE_CLUSTERING}
 
 #endif /* defined(HOSTS_C) || defined(MODULE) */ 

