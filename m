Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKKETM>; Fri, 10 Nov 2000 23:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129105AbQKKESx>; Fri, 10 Nov 2000 23:18:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54796 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129076AbQKKESl>;
	Fri, 10 Nov 2000 23:18:41 -0500
Date: Sat, 11 Nov 2000 05:18:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Bernd Nottelmann <nottelm@uni-muenster.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.0-test10 during ripping an audio cd with cdda2wav
Message-ID: <20001111051829.A484@suse.de>
In-Reply-To: <00111022341900.16665@pt2037>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00111022341900.16665@pt2037>; from nottelm@uni-muenster.de on Fri, Nov 10, 2000 at 10:34:19PM +0100
X-OS: Linux 2.4.0-test11 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 10 2000, Bernd Nottelmann wrote:
> Hi,
> 
> I am not sure, if this is a reiserfs related issue, so I send this Oops 
> report both to the kernel mailing list and to the reiserfs people
> (kernel has been patched with reiserfs-3.6.18).
> 
> During ripping the last song from a cd (a long time song of 9.50 min)
> I was wondering about the time consumption of this process.
> After the cdda2wav process had been finished I found the following
> oops:
> 
> 
> ---------------------- starts here ---------------------- 
> ksymoops 2.3.5 on i686 2.4.0-test10.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.0-test10/ (default)
>      -m /usr/src/linux/System.map (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> kernel BUG at slab.c:1542!

[snip]

This looks like cdrom.c:mmc_ioctl, CDROMREADAUDIO, kmalloc'ing too
much memory, which triggers the BUG() in slab.c. I'm not quite sure
how this is happening though, unless cdda2wav sets a negative ra.nframes
(a quick browse on a version I have here shows it does not, maybe you
have a different version).

Is it reproducable? If so, could you try with this patch?

> (Maybe I should mention that the kernel has been compiled with
> gcc-2.95.2, but I think, it is not very important.)

Could be...

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cd-2.4.0-t11p2.diff"

diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.0-test11-pre2/drivers/cdrom/cdrom.c linux/drivers/cdrom/cdrom.c
--- /opt/kernel/linux-2.4.0-test11-pre2/drivers/cdrom/cdrom.c	Mon Oct 16 21:58:51 2000
+++ linux/drivers/cdrom/cdrom.c	Sat Nov 11 05:00:23 2000
@@ -224,11 +224,14 @@
   3.11 Jun 12, 2000 - Jens Axboe <axboe@suse.de>
   -- Fix bug in getting rpc phase 2 region info.
   -- Reinstate "correct" CDROMPLAYTRKIND
- 
+
+   3.12 Oct 18, 2000 - Jens Axboe <axboe@suse.de>
+  -- Use quiet bit on packet commands not known to work
+
 -------------------------------------------------------------------------*/
 
-#define REVISION "Revision: 3.11"
-#define VERSION "Id: cdrom.c 3.11 2000/06/12"
+#define REVISION "Revision: 3.12"
+#define VERSION "Id: cdrom.c 3.12 2000/10/18"
 
 /* I use an error-log mask to give fine grain control over the type of
    messages dumped to the system logs.  The available masks include: */
@@ -701,6 +704,21 @@
 	struct cdrom_device_ops *cdo = cdi->ops;
 	int length;
 
+	/*
+	 * Sanyo changer isn't spec compliant (doesn't use regular change
+	 * LOAD_UNLOAD command, and it doesn't implement the mech status
+	 * command below
+	 */
+	if (cdi->sanyo_slot) {
+		buf->hdr.nslots = 3;
+		buf->hdr.curslot = cdi->sanyo_slot == 3 ? 0 : cdi->sanyo_slot;
+		for (length = 0; length < 3; length++) {
+			buf->slots[length].disc_present = 1;
+			buf->slots[length].change = 0;
+		}
+		return 0;
+	}
+
 	length = sizeof(struct cdrom_mechstat_header) +
 		 cdi->capacity * sizeof(struct cdrom_slot);
 
@@ -767,9 +785,10 @@
 	/* The Sanyo 3 CD changer uses byte 7 of the 
 	GPCMD_TEST_UNIT_READY to command to switch CDs instead of
 	using the GPCMD_LOAD_UNLOAD opcode. */
-	if (cdi->sanyo_slot && slot) {
+	if (cdi->sanyo_slot && -1 < slot) {
 		cgc.cmd[0] = GPCMD_TEST_UNIT_READY;
 		cgc.cmd[7] = slot;
+		cgc.cmd[4] = cgc.cmd[8] = 0;
 		cdi->sanyo_slot = slot ? slot : 3;
 	}
 
@@ -953,6 +972,7 @@
 	cgc->buffer = (char *) buf;
 	cgc->buflen = len;
 	cgc->data_direction = type;
+	cgc->timeout = 5*HZ;
 }
 
 /* DVD handling */
@@ -1860,6 +1880,48 @@
 	return cdo->generic_packet(cdi, &cgc);
 }
 
+static int cdrom_do_cmd(struct cdrom_device_info *cdi,
+			struct cdrom_generic_command *cgc)
+{
+	struct request_sense *usense, sense;
+	unsigned char *ubuf;
+	int ret;
+
+	if (cgc->data_direction == CGC_DATA_UNKNOWN)
+		return -EINVAL;
+
+	if (cgc->buflen < 0 || cgc->buflen >= 131072)
+		return -EINVAL;
+
+	if ((ubuf = cgc->buffer)) {
+		cgc->buffer = kmalloc(cgc->buflen, GFP_KERNEL);
+		if (cgc->buffer == NULL)
+			return -ENOMEM;
+	}
+
+	usense = cgc->sense;
+	cgc->sense = &sense;
+	if (usense && !access_ok(VERIFY_WRITE, usense, sizeof(*usense)))
+		return -EFAULT;
+
+	if (cgc->data_direction == CGC_DATA_READ) {
+		if (!access_ok(VERIFY_READ, ubuf, cgc->buflen))
+			return -EFAULT;
+	} else if (cgc->data_direction == CGC_DATA_WRITE) {
+		if (copy_from_user(cgc->buffer, ubuf, cgc->buflen)) {
+			kfree(cgc->buffer);
+			return -EFAULT;
+		}
+	}
+
+	ret = cdi->ops->generic_packet(cdi, cgc);
+	__copy_to_user(usense, cgc->sense, sizeof(*usense));
+	if (!ret && cgc->data_direction == CGC_DATA_READ)
+		__copy_to_user(ubuf, cgc->buffer, cgc->buflen);
+	kfree(cgc->buffer);
+	return ret;
+}
+
 static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
 		     unsigned long arg)
 {		
@@ -1937,7 +1999,7 @@
 			return -EINVAL;
 
 		/* FIXME: we need upper bound checking, too!! */
-		if (lba < 0)
+		if (lba < 0 || ra.nframes <= 0)
 			return -EINVAL;
 
 		/* do max 8 frames at the time */
@@ -2117,52 +2179,11 @@
 		}
 
 	case CDROM_SEND_PACKET: {
-		__u8 *userbuf, copy = 0;
-		struct request_sense *sense;
 		if (!CDROM_CAN(CDC_GENERIC_PACKET))
 			return -ENOSYS;
 		cdinfo(CD_DO_IOCTL, "entering CDROM_SEND_PACKET\n"); 
 		IOCTL_IN(arg, struct cdrom_generic_command, cgc);
-		copy = !!cgc.buflen;
-		userbuf = cgc.buffer;
-		cgc.buffer = NULL;
-		sense = cgc.sense;
-		if (userbuf != NULL && copy) {
-			/* usually commands just copy data one way, i.e.
-			 * we send a buffer to the drive and the command
-			 * specifies whether the drive will read or
-			 * write to that buffer. usually the buffers
-			 * are very small, so we don't loose that much
-			 * by doing a redundant copy each time. */
-			if (!access_ok(VERIFY_WRITE, userbuf, cgc.buflen)) {
-				printk("can't get write perms\n");
-				return -EFAULT;
-			}
-			if (!access_ok(VERIFY_READ, userbuf, cgc.buflen)) {
-				printk("can't get read perms\n");
-				return -EFAULT;
-			}
-		}
-		/* reasonable limits */
-		if (cgc.buflen < 0 || cgc.buflen > 131072) {
-			printk("invalid size given\n");
-			return -EINVAL;
-		}
-		if (copy) {
-			cgc.buffer = kmalloc(cgc.buflen, GFP_KERNEL);
-			if (cgc.buffer == NULL)
-				return -ENOMEM;
-			__copy_from_user(cgc.buffer, userbuf, cgc.buflen);
-		}
-		ret = cdo->generic_packet(cdi, &cgc);
-		if (copy && !ret)
-			__copy_to_user(userbuf, cgc.buffer, cgc.buflen);
-		/* copy back sense data */
-		if (sense != NULL)
-			if (copy_to_user(sense, cgc.sense, sizeof(struct request_sense)))
-				ret = -EFAULT;
-		kfree(cgc.buffer);
-		return ret;
+		return cdrom_do_cmd(cdi, &cgc);
 		}
 	case CDROM_NEXT_WRITABLE: {
 		long next = 0;
@@ -2199,6 +2220,7 @@
 	cgc.cmd[4] = (track & 0xff00) >> 8;
 	cgc.cmd[5] = track & 0xff;
 	cgc.cmd[8] = 8;
+	cgc.quiet = 1;
 
 	if ((ret = cdo->generic_packet(cdi, &cgc)))
 		return ret;
@@ -2220,6 +2242,7 @@
 	init_cdrom_command(&cgc, di, sizeof(*di), CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_READ_DISC_INFO;
 	cgc.cmd[8] = cgc.buflen = 2;
+	cgc.quiet = 1;
 
 	if ((ret = cdo->generic_packet(cdi, &cgc)))
 		return ret;
@@ -2252,9 +2275,6 @@
 	if (!CDROM_CAN(CDC_GENERIC_PACKET))
 		goto use_toc;
 
-	if (!CDROM_CAN(CDC_CD_R | CDC_CD_RW | CDC_DVD_R | CDC_DVD_RAM))
-		goto use_toc;
-
 	if ((ret = cdrom_get_disc_info(dev, &di)))
 		goto use_toc;
 
@@ -2556,12 +2576,13 @@
 	{0}
 	};
 
+#ifdef CONFIG_PROC_FS
 /* Make sure that /proc/sys/dev is there */
 ctl_table cdrom_root_table[] = {
 	{CTL_DEV, "dev", NULL, 0, 0555, cdrom_cdrom_table},
 	{0}
 	};
-
+#endif /* CONFIG_PROC_FS */
 static struct ctl_table_header *cdrom_sysctl_header;
 
 static void cdrom_sysctl_register(void)
@@ -2572,9 +2593,8 @@
 		return;
 
 	cdrom_sysctl_header = register_sysctl_table(cdrom_root_table, 1);
-#ifdef CONFIG_PROC_FS
 	cdrom_root_table->child->de->owner = THIS_MODULE;
-#endif /* CONFIG_PROC_FS */
+
 	/* set the defaults */
 	cdrom_sysctl_settings.autoclose = autoclose;
 	cdrom_sysctl_settings.autoeject = autoeject;
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.0-test11-pre2/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- /opt/kernel/linux-2.4.0-test11-pre2/drivers/ide/ide-cd.c	Fri Oct 27 08:35:48 2000
+++ linux/drivers/ide/ide-cd.c	Sat Nov 11 04:40:06 2000
@@ -285,9 +285,13 @@
  * 4.58  May 1, 2000	- Clean up ACER50 stuff.
  *			- Fix small problem with ide_cdrom_capacity
  *
+ * 4.59  Aug 11, 2000	- Fix changer problem in cdrom_read_toc, we weren't
+ *			  correctly sensing a disc change.
+ *			- Rearranged some code
+ *
  *************************************************************************/
  
-#define IDECD_VERSION "4.58"
+#define IDECD_VERSION "4.59"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -324,41 +328,50 @@
 	info->nsectors_buffered = 0;
 }
 
+static int cdrom_log_sense(ide_drive_t *drive, struct packet_command *pc,
+			   struct request_sense *sense)
+{
+	int log = 0;
+
+	if (sense == NULL || pc->quiet)
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
 
-	if (sense->error_code == 0x70 && sense->sense_key  == 0x02
-	 && ((sense->asc      == 0x3a && sense->ascq       == 0x00) ||
-	     (sense->asc      == 0x04 && sense->ascq       == 0x01)))
-	{
-		/*
-		 * Suppress the following errors:
-		 * "Medium not present", "in progress of becoming ready",
-		 * and "writing" to keep the noise level down to a dull roar.
-		 */
+	if (!cdrom_log_sense(drive, failed_command, sense))
 		return;
-	}
 
 	/*
 	 * If a read toc is executed for a CD-R or CD-RW medium where
@@ -590,7 +603,7 @@
 			cdrom_saw_media_change (drive);
 			/*printk("%s: media changed\n",drive->name);*/
 			return 0;
-		} else {
+		} else if (!pc->quiet) {
 			/* Otherwise, print an error. */
 			ide_dump_status(drive, "packet command error", stat);
 		}
@@ -726,26 +739,27 @@
    or there's data ready. */
 static ide_startstop_t cdrom_transfer_packet_command (ide_drive_t *drive,
                                           unsigned char *cmd_buf, int cmd_len,
-					  ide_handler_t *handler)
+					  ide_handler_t *handler,
+					  unsigned int timeout)
 {
+	ide_startstop_t startstop;
+
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
 		/* Here we should have been called after receiving an interrupt
 		   from the device.  DRQ should how be set. */
 		int stat_dum;
-		ide_startstop_t startstop;
 
 		/* Check for errors. */
 		if (cdrom_decode_status (&startstop, drive, DRQ_STAT, &stat_dum))
 			return startstop;
 	} else {
-		ide_startstop_t startstop;
 		/* Otherwise, we must wait for DRQ to get set. */
 		if (ide_wait_stat (&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READY))
 			return startstop;
 	}
 
 	/* Arm the interrupt handler. */
-	ide_set_handler (drive, handler, WAIT_CMD, cdrom_timer_expiry);
+	ide_set_handler (drive, handler, timeout, cdrom_timer_expiry);
 
 	/* Send the command to the device. */
 	atapi_output_bytes (drive, cmd_buf, cmd_len);
@@ -1090,7 +1104,7 @@
 
 	/* Send the command to the drive and return. */
 	return cdrom_transfer_packet_command(drive, pc.c, sizeof(pc.c),
-					     &cdrom_read_intr);
+					     &cdrom_read_intr, WAIT_CMD);
 }
 
 
@@ -1111,7 +1125,13 @@
 
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
@@ -1133,7 +1153,7 @@
 	memset (&pc.c, 0, sizeof (pc.c));
 	pc.c[0] = GPCMD_SEEK;
 	put_unaligned(cpu_to_be32(frame), (unsigned int *) &pc.c[2]);
-	return cdrom_transfer_packet_command (drive, pc.c, sizeof (pc.c), &cdrom_seek_intr);
+	return cdrom_transfer_packet_command(drive, pc.c, sizeof(pc.c), &cdrom_seek_intr, WAIT_CMD);
 }
 
 static ide_startstop_t cdrom_start_seek (ide_drive_t *drive, unsigned int block)
@@ -1308,9 +1328,12 @@
 	struct request *rq = HWGROUP(drive)->rq;
 	struct packet_command *pc = (struct packet_command *)rq->buffer;
 
+	if (!pc->timeout)
+		pc->timeout = WAIT_CMD;
+
 	/* Send the command to the drive and return. */
-	return cdrom_transfer_packet_command (drive, pc->c,
-				       sizeof (pc->c), &cdrom_pc_intr);
+	return cdrom_transfer_packet_command(drive, pc->c, sizeof(pc->c),
+					     &cdrom_pc_intr, pc->timeout);
 }
 
 
@@ -1335,8 +1358,12 @@
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
@@ -1372,7 +1399,7 @@
 				/* The drive is in the process of loading
 				   a disk.  Retry, but wait a little to give
 				   the drive time to complete the load. */
-				cdrom_sleep (HZ);
+				cdrom_sleep(2 * HZ);
 			} else {
 				/* Otherwise, don't retry. */
 				retries = 0;
@@ -1841,9 +1868,9 @@
 	memset(&pc, 0, sizeof (pc));
 	pc.sense = &sense;
 
-	pc.c[0] = GPCMD_PLAY_AUDIO_10;
-	put_unaligned(cpu_to_be32(lba_start), (unsigned int *) &pc.c[2]);
-	put_unaligned(cpu_to_be16(lba_end - lba_start), (unsigned int *) &pc.c[7]);
+	pc.c[0] = GPCMD_PLAY_AUDIO_MSF;
+	lba_to_msf(lba_start, &pc.c[3], &pc.c[4], &pc.c[5]);
+	lba_to_msf(lba_end-1, &pc.c[6], &pc.c[7], &pc.c[8]);
 
 	return cdrom_queue_packet_command(drive, &pc);
 }
@@ -1886,6 +1913,11 @@
 	struct packet_command pc;
 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
 
+	if (cgc->timeout <= 0) {
+		printk("No timeout from %p, setting default\n", __builtin_return_address(0));
+		cgc->timeout = WAIT_CMD;
+	}
+
 	/* here we queue the commands from the uniform CD-ROM
 	   layer. the packet must be complete, as we do not
 	   touch it at all. */
@@ -1893,14 +1925,10 @@
 	memcpy(pc.c, cgc->cmd, CDROM_PACKET_SIZE);
 	pc.buffer = cgc->buffer;
 	pc.buflen = cgc->buflen;
-	cgc->stat = cdrom_queue_packet_command(drive, &pc);
-
-	/*
-	 * FIXME: copy sense, don't just assign pointer!!
-	 */
-	cgc->sense = pc.sense;
-
-	return cgc->stat;
+	pc.quiet = cgc->quiet;
+	pc.timeout = cgc->timeout;
+	pc.sense = cgc->sense;
+	return cgc->stat = cdrom_queue_packet_command(drive, &pc);
 }
 
 static
@@ -1956,6 +1984,7 @@
 {
 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
 	struct cdrom_info *info = drive->driver_data;
+	int stat;
 
 	switch (cmd) {
 	/*
@@ -1963,10 +1992,11 @@
 	 * atapi doesn't support it
 	 */
 	case CDROMPLAYTRKIND: {
-		int stat, lba_start, lba_end;
+		unsigned long lba_start, lba_end;
 		struct cdrom_ti *ti = (struct cdrom_ti *)arg;
 		struct atapi_toc_entry *first_toc, *last_toc;
 
+		printk("Play from track %d to %d\n", ti->cdti_trk0, ti->cdti_trk1);
 		stat = cdrom_get_toc_entry(drive, ti->cdti_trk0, &first_toc);
 		if (stat)
 			return stat;
@@ -1980,6 +2010,8 @@
 		lba_start = first_toc->addr.lba;
 		lba_end   = last_toc->addr.lba;
 
+		printk("lba %lu to lba %lu\n", lba_start, lba_end);
+
 		if (lba_end <= lba_start)
 			return -EINVAL;
 
@@ -1987,7 +2019,6 @@
 	}
 
 	case CDROMREADTOCHDR: {
-		int stat;
 		struct cdrom_tochdr *tochdr = (struct cdrom_tochdr *) arg;
 		struct atapi_toc *toc;
 
@@ -2003,7 +2034,6 @@
 	}
 
 	case CDROMREADTOCENTRY: {
-		int stat;
 		struct cdrom_tocentry *tocentry = (struct cdrom_tocentry*) arg;
 		struct atapi_toc_entry *toce;
 
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.0-test11-pre2/drivers/ide/ide-cd.h linux/drivers/ide/ide-cd.h
--- /opt/kernel/linux-2.4.0-test11-pre2/drivers/ide/ide-cd.h	Tue Oct 31 20:19:19 2000
+++ linux/drivers/ide/ide-cd.h	Sat Nov 11 04:38:30 2000
@@ -106,6 +106,7 @@
 	int buflen;
 	int stat;
 	int quiet;
+	int timeout;
 	struct request_sense *sense;
 	unsigned char c[12];
 };
@@ -628,7 +629,9 @@
 	  "Logical unit not ready - in progress [sic] of becoming ready" },
 	{ 0x020402, "Logical unit not ready - initializing command required" },
 	{ 0x020403, "Logical unit not ready - manual intervention required" },
-	{ 0x020404, "In process of becoming ready - writing" },
+	{ 0x020404, "Logical unit not ready - format in progress" },
+	{ 0x020407, "Logical unit not ready - operation in progress" },
+	{ 0x020408, "Logical unit not ready - long write in progress" },
 	{ 0x020600, "No reference position found (media may be upside down)" },
 	{ 0x023000, "Incompatible medium installed" },
 	{ 0x023a00, "Medium not present" },
@@ -678,7 +681,6 @@
 	{ 0x04b600, "Media load mechanism failed" },
 	{ 0x051a00, "Parameter list length error" },
 	{ 0x052000, "Invalid command operation code" },
-	{ 0x052c00, "Command sequence error" },
 	{ 0x052100, "Logical block address out of range" },
 	{ 0x052102, "Invalid address for write" },
 	{ 0x052400, "Invalid field in command packet" },
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.0-test11-pre2/drivers/scsi/constants.c linux/drivers/scsi/constants.c
--- /opt/kernel/linux-2.4.0-test11-pre2/drivers/scsi/constants.c	Tue Mar 14 07:15:03 2000
+++ linux/drivers/scsi/constants.c	Sat Nov 11 04:16:51 2000
@@ -776,7 +776,7 @@
 	    printk("%s%s: sns = %2x %2x\n", devclass,
 	      kdevname(dev), sense_buffer[0], sense_buffer[2]);
 	
-	printk("Non-extended sense class %d code 0x%0x ", sense_class, code);
+	printk("Non-extended sense class %d code 0x%0x\n", sense_class, code);
 	s = 4;
     }
     
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.0-test11-pre2/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- /opt/kernel/linux-2.4.0-test11-pre2/drivers/scsi/sr.c	Mon Oct 30 23:44:29 2000
+++ linux/drivers/scsi/sr.c	Sat Nov 11 04:27:53 2000
@@ -587,7 +587,7 @@
 	cmd[2] = 0x2a;
 	cmd[4] = 128;
 	cmd[3] = cmd[5] = 0;
-	rc = sr_do_ioctl(i, cmd, buffer, 128, 1, SCSI_DATA_READ);
+	rc = sr_do_ioctl(i, cmd, buffer, 128, 1, SCSI_DATA_READ, NULL);
 
 	if (-EINVAL == rc) {
 		/* failed, drive has'nt this mode page */
@@ -655,53 +655,12 @@
  */
 static int sr_packet(struct cdrom_device_info *cdi, struct cdrom_generic_command *cgc)
 {
-	Scsi_Request *SRpnt;
 	Scsi_Device *device = scsi_CDs[MINOR(cdi->dev)].device;
-	unsigned char *buffer = cgc->buffer;
-	int buflen;
 
-	/* get the device */
-	SRpnt = scsi_allocate_request(device);
-	if (SRpnt == NULL)
-		return -ENODEV;	/* this just doesn't seem right /axboe */
-
-	/* use buffer for ISA DMA */
-	buflen = (cgc->buflen + 511) & ~511;
-	if (cgc->buffer && SRpnt->sr_host->unchecked_isa_dma &&
-	    (virt_to_phys(cgc->buffer) + cgc->buflen - 1 > ISA_DMA_THRESHOLD)) {
-		buffer = scsi_malloc(buflen);
-		if (buffer == NULL) {
-			printk("sr: SCSI DMA pool exhausted.");
-			return -ENOMEM;
-		}
-		memcpy(buffer, cgc->buffer, cgc->buflen);
-	}
 	/* set the LUN */
 	cgc->cmd[1] |= device->lun << 5;
 
-	/* do the locking and issue the command */
-	SRpnt->sr_request.rq_dev = cdi->dev;
-	/* scsi_wait_req sets the command length */
-	SRpnt->sr_cmd_len = 0;
-
-	SRpnt->sr_data_direction = cgc->data_direction;
-	scsi_wait_req(SRpnt, (void *) cgc->cmd, (void *) buffer, cgc->buflen,
-		      SR_TIMEOUT, MAX_RETRIES);
-
-	if ((cgc->stat = SRpnt->sr_result))
-		cgc->sense = (struct request_sense *) SRpnt->sr_sense_buffer;
-
-	/* release */
-	SRpnt->sr_request.rq_dev = MKDEV(0, 0);
-	scsi_release_request(SRpnt);
-	SRpnt = NULL;
-
-	/* write DMA buffer back if used */
-	if (buffer && (buffer != cgc->buffer)) {
-		memcpy(cgc->buffer, buffer, cgc->buflen);
-		scsi_free(buffer, buflen);
-	}
-
+	cgc->stat = sr_do_ioctl(MINOR(cdi->dev), cgc->cmd, cgc->buffer, cgc->buflen, cgc->quiet, cgc->data_direction, cgc->sense);
 
 	return cgc->stat;
 }
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.0-test11-pre2/drivers/scsi/sr.h linux/drivers/scsi/sr.h
--- /opt/kernel/linux-2.4.0-test11-pre2/drivers/scsi/sr.h	Thu Feb 17 05:21:45 2000
+++ linux/drivers/scsi/sr.h	Sat Nov 11 04:29:12 2000
@@ -36,7 +36,7 @@
 
 extern Scsi_CD *scsi_CDs;
 
-int sr_do_ioctl(int, unsigned char *, void *, unsigned, int, int);
+int sr_do_ioctl(int, unsigned char *, void *, unsigned, int, int, struct request_sense *);
 
 int sr_lock_door(struct cdrom_device_info *, int);
 int sr_tray_move(struct cdrom_device_info *, int);
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.0-test11-pre2/drivers/scsi/sr_ioctl.c linux/drivers/scsi/sr_ioctl.c
--- /opt/kernel/linux-2.4.0-test11-pre2/drivers/scsi/sr_ioctl.c	Sat Nov 11 04:55:05 2000
+++ linux/drivers/scsi/sr_ioctl.c	Sat Nov 11 04:41:38 2000
@@ -34,7 +34,7 @@
    error code is.  Normally the UNIT_ATTENTION code will automatically
    clear after one error */
 
-int sr_do_ioctl(int target, unsigned char *sr_cmd, void *buffer, unsigned buflength, int quiet, int readwrite)
+int sr_do_ioctl(int target, unsigned char *sr_cmd, void *buffer, unsigned buflength, int quiet, int readwrite, struct request_sense *sense)
 {
 	Scsi_Request *SRpnt;
 	Scsi_Device *SDev;
@@ -132,7 +132,10 @@
 			err = -EIO;
 		}
 	}
-	result = SRpnt->sr_result;
+
+	if (sense)
+		memcpy(sense, SRpnt->sr_sense_buffer, sizeof(*sense));
+
 	/* Wake up a process waiting for device */
 	scsi_release_request(SRpnt);
 	SRpnt = NULL;
@@ -149,7 +152,7 @@
 	sr_cmd[0] = GPCMD_TEST_UNIT_READY;
 	sr_cmd[1] = ((scsi_CDs[minor].device->lun) << 5);
 	sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
-	return sr_do_ioctl(minor, sr_cmd, NULL, 0, 1, SCSI_DATA_NONE);
+	return sr_do_ioctl(minor, sr_cmd, NULL, 0, 1, SCSI_DATA_NONE, NULL);
 }
 
 int sr_tray_move(struct cdrom_device_info *cdi, int pos)
@@ -161,7 +164,7 @@
 	sr_cmd[2] = sr_cmd[3] = sr_cmd[5] = 0;
 	sr_cmd[4] = (pos == 0) ? 0x03 /* close */ : 0x02 /* eject */ ;
 
-	return sr_do_ioctl(MINOR(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE);
+	return sr_do_ioctl(MINOR(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
 }
 
 int sr_lock_door(struct cdrom_device_info *cdi, int lock)
@@ -238,7 +241,7 @@
 	sr_cmd[8] = 24;
 	sr_cmd[9] = 0;
 
-	result = sr_do_ioctl(MINOR(cdi->dev), sr_cmd, buffer, 24, 0, SCSI_DATA_READ);
+	result = sr_do_ioctl(MINOR(cdi->dev), sr_cmd, buffer, 24, 0, SCSI_DATA_READ, NULL);
 
 	memcpy(mcn->medium_catalog_number, buffer + 9, 13);
 	mcn->medium_catalog_number[13] = 0;
@@ -267,7 +270,7 @@
 	sr_cmd[2] = (speed >> 8) & 0xff;	/* MSB for speed (in kbytes/sec) */
 	sr_cmd[3] = speed & 0xff;	/* LSB */
 
-	if (sr_do_ioctl(MINOR(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE))
+	if (sr_do_ioctl(MINOR(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL))
 		return -EIO;
 	return 0;
 }
@@ -296,7 +299,7 @@
 			sr_cmd[2] = sr_cmd[3] = sr_cmd[4] = sr_cmd[5] = 0;
 			sr_cmd[8] = 12;		/* LSB of length */
 
-			result = sr_do_ioctl(target, sr_cmd, buffer, 12, 1, SCSI_DATA_READ);
+			result = sr_do_ioctl(target, sr_cmd, buffer, 12, 1, SCSI_DATA_READ, NULL);
 
 			tochdr->cdth_trk0 = buffer[2];
 			tochdr->cdth_trk1 = buffer[3];
@@ -315,7 +318,7 @@
 			sr_cmd[6] = tocentry->cdte_track;
 			sr_cmd[8] = 12;		/* LSB of length */
 
-			result = sr_do_ioctl(target, sr_cmd, buffer, 12, 0, SCSI_DATA_READ);
+			result = sr_do_ioctl(target, sr_cmd, buffer, 12, 0, SCSI_DATA_READ, NULL);
 
 			tocentry->cdte_ctrl = buffer[5] & 0xf;
 			tocentry->cdte_adr = buffer[5] >> 4;
@@ -341,7 +344,7 @@
 		sr_cmd[7] = ti->cdti_trk1;
 		sr_cmd[8] = ti->cdti_ind1;
 
-		result = sr_do_ioctl(target, sr_cmd, NULL, 255, 0, SCSI_DATA_NONE);
+		result = sr_do_ioctl(target, sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
 		break;
 	}
 
@@ -402,7 +405,7 @@
 		cmd[9] = 0x10;
 		break;
 	}
-	return sr_do_ioctl(minor, cmd, dest, blksize, 0, SCSI_DATA_READ);
+	return sr_do_ioctl(minor, cmd, dest, blksize, 0, SCSI_DATA_READ, NULL);
 }
 
 /*
@@ -440,7 +443,7 @@
 	cmd[4] = (unsigned char) (lba >> 8) & 0xff;
 	cmd[5] = (unsigned char) lba & 0xff;
 	cmd[8] = 1;
-	rc = sr_do_ioctl(minor, cmd, dest, blksize, 0, SCSI_DATA_READ);
+	rc = sr_do_ioctl(minor, cmd, dest, blksize, 0, SCSI_DATA_READ, NULL);
 
 	return rc;
 }
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.0-test11-pre2/drivers/scsi/sr_vendor.c linux/drivers/scsi/sr_vendor.c
--- /opt/kernel/linux-2.4.0-test11-pre2/drivers/scsi/sr_vendor.c	Thu Feb 17 05:21:45 2000
+++ linux/drivers/scsi/sr_vendor.c	Sat Nov 11 04:28:19 2000
@@ -132,7 +132,7 @@
 	modesel->density = density;
 	modesel->block_length_med = (blocklength >> 8) & 0xff;
 	modesel->block_length_lo = blocklength & 0xff;
-	if (0 == (rc = sr_do_ioctl(minor, cmd, buffer, sizeof(*modesel), 0, SCSI_DATA_WRITE))) {
+	if (0 == (rc = sr_do_ioctl(minor, cmd, buffer, sizeof(*modesel), 0, SCSI_DATA_WRITE, NULL))) {
 		scsi_CDs[minor].device->sector_size = blocklength;
 	}
 #ifdef DEBUG
@@ -176,7 +176,7 @@
 		cmd[1] = (scsi_CDs[minor].device->lun << 5);
 		cmd[8] = 12;
 		cmd[9] = 0x40;
-		rc = sr_do_ioctl(minor, cmd, buffer, 12, 1, SCSI_DATA_READ);
+		rc = sr_do_ioctl(minor, cmd, buffer, 12, 1, SCSI_DATA_READ, NULL);
 		if (rc != 0)
 			break;
 		if ((buffer[0] << 8) + buffer[1] < 0x0a) {
@@ -200,7 +200,7 @@
 			cmd[0] = 0xde;
 			cmd[1] = (scsi_CDs[minor].device->lun << 5) | 0x03;
 			cmd[2] = 0xb0;
-			rc = sr_do_ioctl(minor, cmd, buffer, 0x16, 1, SCSI_DATA_READ);
+			rc = sr_do_ioctl(minor, cmd, buffer, 0x16, 1, SCSI_DATA_READ, NULL);
 			if (rc != 0)
 				break;
 			if (buffer[14] != 0 && buffer[14] != 0xb0) {
@@ -224,7 +224,7 @@
 			memset(cmd, 0, MAX_COMMAND_SIZE);
 			cmd[0] = 0xc7;
 			cmd[1] = (scsi_CDs[minor].device->lun << 5) | 3;
-			rc = sr_do_ioctl(minor, cmd, buffer, 4, 1, SCSI_DATA_READ);
+			rc = sr_do_ioctl(minor, cmd, buffer, 4, 1, SCSI_DATA_READ, NULL);
 			if (rc == -EINVAL) {
 				printk(KERN_INFO "sr%d: Hmm, seems the drive "
 				       "doesn't support multisession CD's\n", minor);
@@ -249,7 +249,7 @@
 		cmd[1] = (scsi_CDs[minor].device->lun << 5);
 		cmd[8] = 0x04;
 		cmd[9] = 0x40;
-		rc = sr_do_ioctl(minor, cmd, buffer, 0x04, 1, SCSI_DATA_READ);
+		rc = sr_do_ioctl(minor, cmd, buffer, 0x04, 1, SCSI_DATA_READ, NULL);
 		if (rc != 0) {
 			break;
 		}
@@ -263,7 +263,7 @@
 		cmd[6] = rc & 0x7f;	/* number of last session */
 		cmd[8] = 0x0c;
 		cmd[9] = 0x40;
-		rc = sr_do_ioctl(minor, cmd, buffer, 12, 1, SCSI_DATA_READ);
+		rc = sr_do_ioctl(minor, cmd, buffer, 12, 1, SCSI_DATA_READ, NULL);
 		if (rc != 0) {
 			break;
 		}
diff -ur --exclude-from /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.0-test11-pre2/include/linux/cdrom.h linux/include/linux/cdrom.h
--- /opt/kernel/linux-2.4.0-test11-pre2/include/linux/cdrom.h	Tue Oct 31 20:18:07 2000
+++ linux/include/linux/cdrom.h	Sat Nov 11 04:30:14 2000
@@ -280,7 +280,9 @@
 	int			stat;
 	struct request_sense	*sense;
 	unsigned char		data_direction;
-	void			*reserved[3];
+	int			quiet;
+	int			timeout;
+	void			*reserved[1];
 };
 
 

--rwEMma7ioTxnRzrJ--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
