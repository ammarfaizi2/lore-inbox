Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293458AbSCVIiJ>; Fri, 22 Mar 2002 03:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293452AbSCVIiA>; Fri, 22 Mar 2002 03:38:00 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60292 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293448AbSCVIhq>; Fri, 22 Mar 2002 03:37:46 -0500
Date: Fri, 22 Mar 2002 03:37:41 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2 questions about SCSI initialization
Message-ID: <20020322033741.A8052@devserv.devel.redhat.com>
In-Reply-To: <20020321000553.A6704@devserv.devel.redhat.com> <3C99E6C7.34F05AE7@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 21 Mar 2002 08:57:27 -0500
> From: Douglas Gilbert <dougg@torque.net>

> There has long been a preference in the scsi subsystem
> for using its own memory management ( scsi_malloc() )
> or the most conservative mm calls. GFP_ATOMIC may well
> be overkill in scsi_build_commandblocks(). However it
> might be wise to check that the calling context is indeed
> user_space since this can be called from all subsystems 
> that have a scsi pseudo device driver (e.g. ide-scsi, 
> usb-storage, 1394/sbp2, ...).

OK, I did the legwork, and it seems that Doug is right.
Unfortunately, this means that, in pinhead's words, I should be
ashamed to post the fix to a public mailing list. Let's do it
this way: if Alan or Marcelo pick it - good. Real oops, real fix,
everyone's happy. Otherwise, I'll ship it with Red Hat kernel under
my own responsibility [I do not promise a hara-kiri if it blows up,
but they will point fingers at me at meetings]

About the second point - we know the module count check is bogus,
but if the attached band aid gets accepted, it may stay.

-- Pete

--- linux-2.4.19-pre2/drivers/scsi/scsi.c	Mon Mar 11 09:20:48 2002
+++ linux-2.4.19-pre2-p3/drivers/scsi/scsi.c	Thu Mar 21 23:31:35 2002
@@ -106,6 +106,12 @@
 				COMMAND_SIZE(SCpnt->cmnd[0]) : SCpnt->cmd_len)
 
 /*
+ * This code cannot be detangled, so we resort to band-aid.
+ * See also gfp_any().
+ */
+#define GFP_ANY()	(in_interrupt()? GFP_ATOMIC: GFP_KERNEL)
+
+/*
  * Data declarations.
  */
 unsigned long scsi_pid;
@@ -1483,12 +1489,16 @@
 	SDpnt->device_queue = NULL;
 
 	for (j = 0; j < SDpnt->queue_depth; j++) {
+		spin_unlock_irqrestore(&device_request_lock, flags);
+
 		SCpnt = (Scsi_Cmnd *)
 		    kmalloc(sizeof(Scsi_Cmnd),
-				     GFP_ATOMIC |
+				GFP_ANY() |
 				(host->unchecked_isa_dma ? GFP_DMA : 0));
-		if (NULL == SCpnt)
+		if (NULL == SCpnt) {
+			spin_lock_irqsave(&device_request_lock, flags);
 			break;	/* If not, the next line will oops ... */
+		}
 		memset(SCpnt, 0, sizeof(Scsi_Cmnd));
 		SCpnt->host = host;
 		SCpnt->device = SDpnt;
@@ -1506,10 +1516,12 @@
 		SCpnt->serial_number = 0;
 		SCpnt->serial_number_at_timeout = 0;
 		SCpnt->host_scribble = NULL;
-		SCpnt->next = SDpnt->device_queue;
-		SDpnt->device_queue = SCpnt;
 		SCpnt->state = SCSI_STATE_UNUSED;
 		SCpnt->owner = SCSI_OWNER_NOBODY;
+
+		spin_lock_irqsave(&device_request_lock, flags);
+		SCpnt->next = SDpnt->device_queue;
+		SDpnt->device_queue = SCpnt;
 	}
 	if (j < SDpnt->queue_depth) {	/* low on space (D.Gilbert 990424) */
 		printk(KERN_WARNING "scsi_build_commandblocks: want=%d, space for=%d blocks\n",
