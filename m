Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129579AbQKJQVV>; Fri, 10 Nov 2000 11:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129608AbQKJQVK>; Fri, 10 Nov 2000 11:21:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11785 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129579AbQKJQVF>;
	Fri, 10 Nov 2000 11:21:05 -0500
Date: Fri, 10 Nov 2000 17:20:51 +0100
From: Jens Axboe <axboe@suse.de>
To: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.2.18pre17 OOPS Report] Linux' musical taste (ide-cdrom / autofs related) (Repost)
Message-ID: <20001110172051.D2266@suse.de>
In-Reply-To: <8uh4ro$1dv$1@forge.tanstaafl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8uh4ro$1dv$1@forge.tanstaafl.de>; from hps@tanstaafl.de on Fri, Nov 10, 2000 at 03:39:36PM +0000
X-OS: Linux 2.2.17-2GB-SMP i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 10 2000, Henning P. Schmiedehausen wrote:
[snip]
> Running 2.2.18pre17 completely modular built + 20001027 IDE patch from
> kernel.org + Andreas' 2.2.18pre17aa1 patch + some more but I think not
> related patches. Complete Kernel SRPMS and RPMS on request. :-)

> The Mitsumi CDROM is used only for listening to music. There is still
> an entry in my automount table for /mnt/misc mounting /dev/hdd to
> /mnt/misc/cdrom1 if I ever desire to.
> 
> % cat /etc/auto.misc
> [...]
> cdrom1          -fstype=iso9660,ro      :/dev/hdd

[snip cdrom_analyze_sense oops]

Could you try with this patch? It's against 2.2.18-pre21, but will
probably apply cleanly to your current kernel.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs

--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cd-2.2.18-pre21.diff"

--- /opt/kernel/linux-2.2.17.SuSE/drivers/block/ide-cd.c	Fri Oct 27 12:22:01 2000
+++ drivers/block/ide-cd.c	Fri Nov 10 17:16:14 2000
@@ -324,41 +325,50 @@
 	info->nsectors_buffered = 0;
 }
 
+static int cdrom_log_sense(ide_drive_t *drive, struct packet_command *pc,
+			   struct request_sense *sense)
+{
+	int log = 0;
+
+	if (sense == NULL)
+		return 0;
+
+	switch (sense->sense_key) {
+		case NO_SENSE: case RECOVERED_ERROR:
+			break;
+		case NOT_READY:
+			/*
+			 * don't care about tray state messages for
+			 * e.g. capacity commands or in-progress or
+			 * becoming ready
+			 */
+			if (sense->asc == 0x3a || sense->asc == 0x04)
+				break;
+			log = 1;
+			break;
+		case UNIT_ATTENTION:
+			/*
+			 * Make good and sure we've seen this potential media
+			 * change. Some drives (i.e. Creative) fail to present
+			 * the correct sense key in the error register.
+			 */
+			cdrom_saw_media_change(drive);
+			break;
+		default:
+			log = 1;
+			break;
+	}
+	return log;
+}
 
 static
 void cdrom_analyze_sense_data(ide_drive_t *drive,
 			      struct packet_command *failed_command,
 			      struct request_sense *sense)
 {
-	if (sense->sense_key == NOT_READY ||
-	    sense->sense_key == UNIT_ATTENTION) {
-		/* Make good and sure we've seen this potential media change.
-		   Some drives (i.e. Creative) fail to present the correct
-		   sense key in the error register. */
-		cdrom_saw_media_change (drive);
-
-
-		/* Don't print not ready or unit attention errors for
-		   READ_SUBCHANNEL.  Workman (and probably other programs)
-		   uses this command to poll the drive, and we don't want
-		   to fill the syslog with useless errors. */
-		if (failed_command &&
-		    (failed_command->c[0] == GPCMD_READ_SUBCHANNEL ||
-		     failed_command->c[0] == GPCMD_TEST_UNIT_READY))
-			return;
-	}
-
-	if (sense->error_code == 0x70 && sense->sense_key  == 0x02
-	 && ((sense->asc      == 0x3a && sense->ascq       == 0x00) ||
-	     (sense->asc      == 0x04 && sense->ascq       == 0x01)))
-	{
-		/*
-		 * Suppress the following errors:
-		 * "Medium not present", "in progress of becoming ready",
-		 * and "writing" to keep the noise level down to a dull roar.
-		 */
+
+	if (!cdrom_log_sense(drive, failed_command, sense))
 		return;
-	}
 
 #if VERBOSE_IDE_CD_ERRORS
 	{
@@ -1105,7 +1115,13 @@
 
 	if (retry && jiffies - info->start_seek > IDECD_SEEK_TIMER) {
 		if (--retry == 0) {
+			/*
+			 * this condition is far too common, to bother
+			 * users about it
+			 */
+#if 0
 			printk("%s: disabled DSC seek overlap\n", drive->name);
+#endif
 			drive->dsc_overlap = 0;
 		}
 	}
@@ -1329,8 +1345,12 @@
 static
 void cdrom_sleep (int time)
 {
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(time);
+	int sleep = time;
+
+	do {
+		set_current_state(TASK_INTERRUPTIBLE);
+		sleep = schedule_timeout(sleep);
+	} while (sleep);
 }
 
 static
@@ -1848,6 +1868,9 @@
 	struct cdrom_info *info = drive->driver_data;
 	struct atapi_toc *toc = info->toc;
 	int ntracks;
+
+	if (!CDROM_STATE_FLAGS(drive)->toc_valid)
+		return -EINVAL;
 
 	/* Check validity of requested track number. */
 	ntracks = toc->hdr.last_track - toc->hdr.first_track + 1;
--- /opt/kernel/linux-2.2.17.SuSE/drivers/scsi/sr.c	Fri Oct 27 12:21:44 2000
+++ drivers/scsi/sr.c	Fri Nov 10 14:25:16 2000
@@ -1034,65 +1034,14 @@
  */
 static int sr_packet(struct cdrom_device_info *cdi, struct cdrom_generic_command *cgc)
 {
-	Scsi_Cmnd *SCpnt;
 	Scsi_Device *device = scsi_CDs[MINOR(cdi->dev)].device;
-	unsigned char *buffer = cgc->buffer;
-	unsigned long flags;
-	int buflen;
-	int stat;
-
-	/* get the device */
-	SCpnt = scsi_allocate_device(NULL, device, 1);
-	if (SCpnt == NULL)
-		return -ENODEV;	/* this just doesn't seem right /axboe */
-
-	/* use buffer for ISA DMA */
-	buflen = (cgc->buflen + 511) & ~511;
-	if (cgc->buffer && SCpnt->host->unchecked_isa_dma &&
-    	   (virt_to_phys(cgc->buffer) + cgc->buflen - 1 > ISA_DMA_THRESHOLD)) {
-		spin_lock_irq(&io_request_lock);
-		buffer = scsi_malloc(buflen);
-		spin_unlock_irq(&io_request_lock);
-		if (buffer == NULL) {
-			printk("sr: SCSI DMA pool exhausted.");
-			return -ENOMEM;
-		}
-		memcpy(buffer, cgc->buffer, cgc->buflen);
-	}
 
 	/* set the LUN */
 	cgc->cmd[1] |= device->lun << 5;
 
-	/* do the locking and issue the command */
-	SCpnt->request.rq_dev = cdi->dev;
-	/* scsi_do_cmd sets the command length */
-	SCpnt->cmd_len = 0;
-
-	{
-		struct semaphore sem = MUTEX_LOCKED;
-		SCpnt->request.sem = &sem;
-		spin_lock_irqsave(&io_request_lock, flags);
-		scsi_do_cmd(SCpnt, (void *)cgc->cmd, (void *) buffer,
-				 cgc->buflen, sr_init_done,  SR_TIMEOUT,
-				 MAX_RETRIES);
-		spin_unlock_irqrestore(&io_request_lock, flags);
-		down(&sem);
-	}
-
-	stat = SCpnt->result;
-
-	/* release */
-	SCpnt->request.rq_dev = MKDEV(0, 0);
-	scsi_release_command(SCpnt);
-	SCpnt = NULL;
-
-	/* write DMA buffer back if used */
-	if (buffer && (buffer != cgc->buffer)) {
-		memcpy(cgc->buffer, buffer, cgc->buflen);
-		scsi_free(buffer, buflen);
-	}
+	cgc->stat = sr_do_ioctl(MINOR(cdi->dev), cgc->cmd, cgc->buffer, cgc->buflen, 1);
 
-	return stat;
+	return cgc->stat;
 }
 
 static int sr_registered = 0;
--- /opt/kernel/linux-2.2.17.SuSE/drivers/scsi/sr_ioctl.c	Fri Oct 27 12:21:31 2000
+++ drivers/scsi/sr_ioctl.c	Fri Nov 10 14:08:50 2000
@@ -77,6 +77,8 @@
 	buffer = bounce_buffer;
     }
 
+    SCpnt->cmd_len = 0;
+
 retry:
     if( !scsi_block_when_processing_errors(SDev) )
         return -ENODEV;
@@ -158,9 +160,8 @@
             err = -EIO;
 	}
     }
-   
+
     spin_lock_irqsave(&io_request_lock, flags);
-    result = SCpnt->result;
     /* Wake up a process waiting for device*/
     wake_up(&SCpnt->device->device_wait);
     scsi_release_command(SCpnt);
--- /opt/kernel/linux-2.2.17.SuSE/drivers/scsi/constants.c	Mon Aug  9 21:04:40 1999
+++ drivers/scsi/constants.c	Fri Nov 10 14:19:22 2000
@@ -501,7 +501,7 @@
 	    printk("%s%s: sns = %2x %2x\n", devclass,
 	      kdevname(SCpnt->request.rq_dev), sense_buffer[0], sense_buffer[2]);
 	
-	printk("Non-extended sense class %d code 0x%0x ", sense_class, code);
+	printk("Non-extended sense class %d code 0x%0x\n", sense_class, code);
 	s = 4;
     }
     

--tsOsTdHNUZQcU9Ye--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
