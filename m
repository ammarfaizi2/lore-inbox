Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSDOIpI>; Mon, 15 Apr 2002 04:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313114AbSDOIpH>; Mon, 15 Apr 2002 04:45:07 -0400
Received: from [195.63.194.11] ([195.63.194.11]:44041 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313113AbSDOIo6>; Mon, 15 Apr 2002 04:44:58 -0400
Message-ID: <3CBA8476.9070208@evision-ventures.com>
Date: Mon, 15 Apr 2002 09:42:46 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.8 IDE 34
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060204050005050107020104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060204050005050107020104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I'm *storgly* recommending this patch to everyoby who wan't
to try 2.5.8 and has to use hdparm for a reasonable setup
of his system

Mon Apr 15 01:27:53 CEST 2002 ide-clean-34

- Synchronize with 2.5.8.

- Eliminate the cdrom_log_sense() function.

- Pass a struct request to cdrom_analyze_sense_data() since this is the entity
   this function is working on. This shows nicely that this function is broken.

- Use CDROM_PACKET_SIZE where appropriate.

- Kill the obfuscating cmd_buf and cmd_len local variables from
   cdrom_transfer_packet_command(). This made it obvious that the parameters of
   this function where not adequate - to say the least. Fix this.

- Pass a packed command array directly to cdrom_queue_packed_command().  This
   is reducing the number of places where we have to deal with the c member of
   struct packet_command.

- Never pass NULL as sense to cdrom_lockdoor().

- Eliminate cdrom_do_block_pc().

- Eliminate the c member of struct packet_command. Pass them through struct
   request cmd member.

- Don't enable TCQ unconditionally if there is a TCQ queue depth defined.

- Fix small think in ide_cmd_ioctl() rewrite. (My appologies to everyone who
   has to use hdparm to setup his system...)

- Fix compilation without PCI support.


It's time for the next patch...

--------------060204050005050107020104
Content-Type: text/plain;
 name="ide-clean-34.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-34.diff"

diff -urN linux-2.5.8/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.8/drivers/ide/ide-cd.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ide-cd.c	Mon Apr 15 08:58:52 2002
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/ide-cd.c
- *
  * Copyright (C) 1994, 1995, 1996  scott snyder  <snyder@fnald0.fnal.gov>
  * Copyright (C) 1996-1998  Erik Andersen <andersee@debian.org>
  * Copyright (C) 1998-2000  Jens Axboe <axboe@suse.de>
@@ -13,9 +11,10 @@
  *
  * Suggestions are welcome. Patches that work are more welcome though. ;-)
  * For those wishing to work on this driver, please be sure you download
- * and comply with the latest Mt. Fuji (SFF8090 version 4) and ATAPI 
- * (SFF-8020i rev 2.6) standards. These documents can be obtained by 
+ * and comply with the latest Mt. Fuji (SFF8090 version 4) and ATAPI
+ * (SFF-8020i rev 2.6) standards. These documents can be obtained by
  * anonymous ftp from:
+ *
  * ftp://fission.dt.wdc.com/pub/standards/SFF_atapi/spec/SFF8020-r2.6/PS/8020r26.ps
  * ftp://ftp.avc-pioneer.com/Mtfuji4/Spec/Fuji4r10.pdf
  *
@@ -54,18 +53,18 @@
  *                       Aztech drives, which seem to have the same problem.
  * 2.04b May 30, 1995 -- Fix to match changes in ide.c version 3.16 -ml
  * 2.05  Jun  8, 1995 -- Don't attempt to retry after an illegal request
- *                        or data protect error.
+ *                       or data protect error.
  *                       Use HWIF and DEV_HWIF macros as in ide.c.
  *                       Always try to do a request_sense after
- *                        a failed command.
+ *                       a failed command.
  *                       Include an option to give textual descriptions
- *                        of ATAPI errors.
+ *                       of ATAPI errors.
  *                       Fix a bug in handling the sector cache which
- *                        showed up if the drive returned data in 512 byte
- *                        blocks (like Pioneer drives).  Thanks to
- *                        Richard Hirst <srh@gpt.co.uk> for diagnosing this.
+ *                       showed up if the drive returned data in 512 byte
+ *                       blocks (like Pioneer drives).  Thanks to
+ *                       Richard Hirst <srh@gpt.co.uk> for diagnosing this.
  *                       Properly supply the page number field in the
- *                        MODE_SELECT command.
+ *                       MODE_SELECT command.
  *                       PLAYAUDIO12 is broken on the Aztech; work around it.
  * 2.05x Aug 11, 1995 -- lots of data structure renaming/restructuring in ide.c
  *                       (my apologies to Scott, but now ide-cd.c is independent)
@@ -74,28 +73,28 @@
  *                       Use input_ide_data() and output_ide_data().
  *                       Add door locking.
  *                       Fix usage count leak in cdrom_open, which happened
- *                        when a read-write mount was attempted.
+ *                       when a read-write mount was attempted.
  *                       Try to load the disk on open.
  *                       Implement CDROMEJECT_SW ioctl (off by default).
  *                       Read total cdrom capacity during open.
  *                       Rearrange logic in cdrom_decode_status.  Issue
- *                        request sense commands for failed packet commands
- *                        from here instead of from cdrom_queue_packet_command.
- *                        Fix a race condition in retrieving error information.
+ *                       request sense commands for failed packet commands
+ *                       from here instead of from cdrom_queue_packet_command.
+ *                       Fix a race condition in retrieving error information.
  *                       Suppress printing normal unit attention errors and
- *                        some drive not ready errors.
+ *                       some drive not ready errors.
  *                       Implement CDROMVOLREAD ioctl.
  *                       Implement CDROMREADMODE1/2 ioctls.
  *                       Fix race condition in setting up interrupt handlers
- *                        when the `serialize' option is used.
+ *                       when the `serialize' option is used.
  * 3.01  Sep  2, 1995 -- Fix ordering of reenabling interrupts in
- *                        cdrom_queue_request.
+ *                       cdrom_queue_request.
  *                       Another try at using ide_[input,output]_data.
  * 3.02  Sep 16, 1995 -- Stick total disk capacity in partition table as well.
  *                       Make VERBOSE_IDE_CD_ERRORS dump failed command again.
  *                       Dump out more information for ILLEGAL REQUEST errs.
  *                       Fix handling of errors occurring before the
- *                        packet command is transferred.
+ *                       packet command is transferred.
  *                       Fix transfers with odd bytelengths.
  * 3.03  Oct 27, 1995 -- Some Creative drives have an id of just `CD'.
  *                       `DCI-2S10' drives are broken too.
@@ -103,17 +102,17 @@
  * 3.05  Dec  1, 1995 -- Changes to go with overhaul of ide.c and ide-tape.c
  * 3.06  Dec 16, 1995 -- Add support needed for partitions.
  *                       More workarounds for Vertos bugs (based on patches
- *                        from Holger Dietze <dietze@aix520.informatik.uni-leipzig.de>).
+ *                       from Holger Dietze <dietze@aix520.informatik.uni-leipzig.de>).
  *                       Try to eliminate byteorder assumptions.
  *                       Use atapi_cdrom_subchnl struct definition.
  *                       Add STANDARD_ATAPI compilation option.
  * 3.07  Jan 29, 1996 -- More twiddling for broken drives: Sony 55D,
- *                        Vertos 300.
+ *                       Vertos 300.
  *                       Add NO_DOOR_LOCKING configuration option.
  *                       Handle drive_cmd requests w/NULL args (for hdparm -t).
  *                       Work around sporadic Sony55e audio play problem.
  * 3.07a Feb 11, 1996 -- check drive->id for NULL before dereferencing, to fix
- *                        problem with "hde=cdrom" with no drive present.  -ml
+ *                       problem with "hde=cdrom" with no drive present.  -ml
  * 3.08  Mar  6, 1996 -- More Vertos workarounds.
  * 3.09  Apr  5, 1996 -- Add CDROMCLOSETRAY ioctl.
  *                       Switch to using MSF addressing for audio commands.
@@ -129,47 +128,47 @@
  * 3.14  May 29, 1996 -- Add work-around for Vertos 600.
  *                        (From Hennus Bergman <hennus@sky.ow.nl>.)
  * 3.15  July 2, 1996 -- Added support for Sanyo 3 CD changers
- *                        from Ben Galliart <bgallia@luc.edu> with 
- *                        special help from Jeff Lightfoot 
- *                        <jeffml@pobox.com>
+ *                       from Ben Galliart <bgallia@luc.edu> with
+ *                       special help from Jeff Lightfoot
+ *                       <jeffml@pobox.com>
  * 3.15a July 9, 1996 -- Improved Sanyo 3 CD changer identification
  * 3.16  Jul 28, 1996 -- Fix from Gadi to reduce kernel stack usage for ioctl.
  * 3.17  Sep 17, 1996 -- Tweak audio reads for some drives.
  *                       Start changing CDROMLOADFROMSLOT to CDROM_SELECT_DISC.
  * 3.18  Oct 31, 1996 -- Added module and DMA support.
- *                       
- *                       
+ *
+ *
  * 4.00  Nov 5, 1996   -- New ide-cd maintainer,
- *                                 Erik B. Andersen <andersee@debian.org>
+ *                        Erik B. Andersen <andersee@debian.org>
  *                     -- Newer Creative drives don't always set the error
- *                          register correctly.  Make sure we see media changes
- *                          regardless.
+ *                        register correctly.  Make sure we see media changes
+ *                        regardless.
  *                     -- Integrate with generic cdrom driver.
  *                     -- CDROMGETSPINDOWN and CDROMSETSPINDOWN ioctls, based on
- *                          a patch from Ciro Cattuto <>.
+ *                        a patch from Ciro Cattuto <>.
  *                     -- Call set_device_ro.
  *                     -- Implement CDROMMECHANISMSTATUS and CDROMSLOTTABLE
- *                          ioctls, based on patch by Erik Andersen
+ *                        ioctls, based on patch by Erik Andersen
  *                     -- Add some probes of drive capability during setup.
  *
  * 4.01  Nov 11, 1996  -- Split into ide-cd.c and ide-cd.h
- *                     -- Removed CDROMMECHANISMSTATUS and CDROMSLOTTABLE 
- *                          ioctls in favor of a generalized approach 
- *                          using the generic cdrom driver.
+ *                     -- Removed CDROMMECHANISMSTATUS and CDROMSLOTTABLE
+ *                        ioctls in favor of a generalized approach
+ *                        using the generic cdrom driver.
  *                     -- Fully integrated with the 2.1.X kernel.
  *                     -- Other stuff that I forgot (lots of changes)
  *
  * 4.02  Dec 01, 1996  -- Applied patch from Gadi Oxman <gadio@netvision.net.il>
- *                          to fix the drive door locking problems.
+ *                        to fix the drive door locking problems.
  *
  * 4.03  Dec 04, 1996  -- Added DSC overlap support.
- * 4.04  Dec 29, 1996  -- Added CDROMREADRAW ioclt based on patch 
- *                          by Ales Makarov (xmakarov@sun.felk.cvut.cz)
+ * 4.04  Dec 29, 1996  -- Added CDROMREADRAW ioclt based on patch
+ *                        by Aleks Makarov (xmakarov@sun.felk.cvut.cz)
  *
  * 4.05  Nov 20, 1997  -- Modified to print more drive info on init
  *                        Minor other changes
  *                        Fix errors on CDROMSTOP (If you have a "Dolphin",
- *                          you must define IHAVEADOLPHIN)
+ *                        you must define IHAVEADOLPHIN)
  *                        Added identifier so new Sanyo CD-changer works
  *                        Better detection if door locking isn't supported
  *
@@ -178,40 +177,40 @@
  * 4.08  Dec 18, 1997  -- spew less noise when tray is empty
  *                     -- fix speed display for ACER 24X, 18X
  * 4.09  Jan 04, 1998  -- fix handling of the last block so we return
- *                         an end of file instead of an I/O error (Gadi)
+ *                        an end of file instead of an I/O error (Gadi)
  * 4.10  Jan 24, 1998  -- fixed a bug so now changers can change to a new
- *                         slot when there is no disc in the current slot.
+ *                        slot when there is no disc in the current slot.
  *                     -- Fixed a memory leak where info->changer_info was
- *                         malloc'ed but never free'd when closing the device.
+ *                        malloc'ed but never free'd when closing the device.
  *                     -- Cleaned up the global namespace a bit by making more
- *                         functions static that should already have been.
+ *                        functions static that should already have been.
  * 4.11  Mar 12, 1998  -- Added support for the CDROM_SELECT_SPEED ioctl
- *                         based on a patch for 2.0.33 by Jelle Foks 
- *                         <jelle@scintilla.utwente.nl>, a patch for 2.0.33
- *                         by Toni Giorgino <toni@pcape2.pi.infn.it>, the SCSI
- *                         version, and my own efforts.  -erik
+ *                        based on a patch for 2.0.33 by Jelle Foks
+ *                        <jelle@scintilla.utwente.nl>, a patch for 2.0.33
+ *                        by Toni Giorgino <toni@pcape2.pi.infn.it>, the SCSI
+ *                        version, and my own efforts.  -erik
  *                     -- Fixed a stupid bug which egcs was kind enough to
- *                         inform me of where "Illegal mode for this track"
- *                         was never returned due to a comparison on data
- *                         types of limited range.
- * 4.12  Mar 29, 1998  -- Fixed bug in CDROM_SELECT_SPEED so write speed is 
- *                         now set ionly for CD-R and CD-RW drives.  I had 
- *                         removed this support because it produced errors.
- *                         It produced errors _only_ for non-writers. duh.
+ *                        inform me of where "Illegal mode for this track"
+ *                        was never returned due to a comparison on data
+ *                        types of limited range.
+ * 4.12  Mar 29, 1998  -- Fixed bug in CDROM_SELECT_SPEED so write speed is
+ *                        now set ionly for CD-R and CD-RW drives.  I had
+ *                        removed this support because it produced errors.
+ *                        It produced errors _only_ for non-writers. duh.
  * 4.13  May 05, 1998  -- Suppress useless "in progress of becoming ready"
- *                         messages, since this is not an error.
+ *                        messages, since this is not an error.
  *                     -- Change error messages to be const
  *                     -- Remove a "\t" which looks ugly in the syslogs
  * 4.14  July 17, 1998 -- Change to pointing to .ps version of ATAPI spec
- *                         since the .pdf version doesn't seem to work...
+ *                        since the .pdf version doesn't seem to work...
  *                     -- Updated the TODO list to something more current.
  *
- * 4.15  Aug 25, 1998  -- Updated ide-cd.h to respect mechine endianess, 
- *                         patch thanks to "Eddie C. Dost" <ecd@skynet.be>
+ * 4.15  Aug 25, 1998  -- Updated ide-cd.h to respect mechine endianess,
+ *                        patch thanks to "Eddie C. Dost" <ecd@skynet.be>
  *
  * 4.50  Oct 19, 1998  -- New maintainers!
- *                         Jens Axboe <axboe@image.dk>
- *                         Chris Zwilling <chris@cloudnet.com>
+ *                        Jens Axboe <axboe@image.dk>
+ *                        Chris Zwilling <chris@cloudnet.com>
  *
  * 4.51  Dec 23, 1998  -- Jens Axboe <axboe@image.dk>
  *                      - ide_cdrom_reset enabled since the ide subsystem
@@ -224,17 +223,17 @@
  *                      - Detect DVD-ROM/RAM drives
  *
  * 4.53  Feb 22, 1999   - Include other model Samsung and one Goldstar
- *                         drive in transfer size limit.
+ *                        drive in transfer size limit.
  *                      - Fix the I/O error when doing eject without a medium
- *                         loaded on some drives.
+ *                        loaded on some drives.
  *                      - CDROMREADMODE2 is now implemented through
- *                         CDROMREADRAW, since many drives don't support
- *                         MODE2 (even though ATAPI 2.6 says they must).
+ *                        CDROMREADRAW, since many drives don't support
+ *                        MODE2 (even though ATAPI 2.6 says they must).
  *                      - Added ignore parameter to ide-cd (as a module), eg
- *                         	insmod ide-cd ignore='hda hdb'
- *                         Useful when using ide-cd in conjunction with
- *                         ide-scsi. TODO: non-modular way of doing the
- *                         same.
+ *			  insmod ide-cd ignore='hda hdb'
+ *                        Useful when using ide-cd in conjunction with
+ *                        ide-scsi. TODO: non-modular way of doing the
+ *                        same.
  *
  * 4.54  Aug 5, 1999	- Support for MMC2 class commands through the generic
  *			  packet interface to cdrom.c.
@@ -270,7 +269,7 @@
  *			- Mode sense and mode select moved to the
  *			  Uniform layer.
  *			- Fixed a problem with WPI CDS-32X drive - it
- *			  failed the capabilities 
+ *			  failed the capabilities
  *
  * 4.57  Apr 7, 2000	- Fixed sense reporting.
  *			- Fixed possible oops in ide_cdrom_get_last_session()
@@ -293,7 +292,7 @@
  *			  Michael D Johnson <johnsom@orst.edu>
  *
  *************************************************************************/
- 
+
 #define IDECD_VERSION "4.59"
 
 #include <linux/config.h>
@@ -326,63 +325,68 @@
 static void cdrom_saw_media_change (ide_drive_t *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
-	
+
 	CDROM_STATE_FLAGS (drive)->media_changed = 1;
 	CDROM_STATE_FLAGS (drive)->toc_valid = 0;
 	info->nsectors_buffered = 0;
 }
 
-static int cdrom_log_sense(ide_drive_t *drive, struct packet_command *pc,
-			   struct request_sense *sense)
+static
+void cdrom_analyze_sense_data(ide_drive_t *drive, struct request *rq)
 {
 	int log = 0;
+	/* FIXME --mdcki */
+	struct packet_command *pc = (struct packet_command *) rq->special;
+	struct packet_command *failed_command = (struct packet_command *) pc->sense;
+	struct request_sense *sense = (struct request_sense *) (pc->buffer - rq->cmd[4]);
+	unsigned char fail_cmd;
 
-	if (sense == NULL || pc == NULL || pc->quiet)
-		return 0;
+	if (sense == NULL || failed_command == NULL || failed_command->quiet)
+		return;
 
+	fail_cmd = rq->cmd[0];
+
+	/* Check whatever this error should be logged:
+	 */
 	switch (sense->sense_key) {
-		case NO_SENSE: case RECOVERED_ERROR:
+		case NO_SENSE:
+		case RECOVERED_ERROR:
 			break;
+
 		case NOT_READY:
-			/*
-			 * don't care about tray state messages for
-			 * e.g. capacity commands or in-progress or
-			 * becoming ready
+
+			/* Don't care about tray state messages for e.g.
+			 * capacity commands or in-progress or becoming ready.
 			 */
 			if (sense->asc == 0x3a || sense->asc == 0x04)
 				break;
 			log = 1;
 			break;
+
 		case UNIT_ATTENTION:
-			/*
-			 * Make good and sure we've seen this potential media
+
+			/* Make good and sure we've seen this potential media
 			 * change. Some drives (i.e. Creative) fail to present
 			 * the correct sense key in the error register.
 			 */
 			cdrom_saw_media_change(drive);
 			break;
+
 		default:
 			log = 1;
 			break;
 	}
-	return log;
-}
-
-static
-void cdrom_analyze_sense_data(ide_drive_t *drive,
-			      struct packet_command *failed_command,
-			      struct request_sense *sense)
-{
 
-	if (!cdrom_log_sense(drive, failed_command, sense))
+	if (!log)
 		return;
 
 	/*
-	 * If a read toc is executed for a CD-R or CD-RW medium where
-	 * the first toc has not been recorded yet, it will fail with
-	 * 05/24/00 (which is a confusing error)
+	 * If a read toc is executed for a CD-R or CD-RW medium where the first
+	 * toc has not been recorded yet, it will fail with 05/24/00 (which is
+	 * a confusing error).
 	 */
-	if (failed_command && failed_command->c[0] == GPCMD_READ_TOC_PMA_ATIP)
+
+	if (fail_cmd == GPCMD_READ_TOC_PMA_ATIP)
 		if (sense->sense_key == 0x05 && sense->asc == 0x24)
 			return;
 
@@ -445,28 +449,26 @@
 		printk("  %s -- (asc=0x%02x, ascq=0x%02x)\n",
 			s, sense->asc, sense->ascq);
 
-		if (failed_command != NULL) {
+		{
 
 			int lo=0, mid, hi= ARY_LEN (packet_command_texts);
 			s = NULL;
 
 			while (hi > lo) {
 				mid = (lo + hi) / 2;
-				if (packet_command_texts[mid].packet_command ==
-				    failed_command->c[0]) {
+				if (packet_command_texts[mid].packet_command == fail_cmd) {
 					s = packet_command_texts[mid].text;
 					break;
 				}
-				if (packet_command_texts[mid].packet_command >
-				    failed_command->c[0])
+				if (packet_command_texts[mid].packet_command > fail_cmd)
 					hi = mid;
 				else
 					lo = mid+1;
 			}
 
 			printk ("  The failed \"%s\" packet command was: \n  \"", s);
-			for (i=0; i<sizeof (failed_command->c); i++)
-				printk ("%02x ", failed_command->c[i]);
+			for (i=0; i < CDROM_PACKET_SIZE; i++)
+				printk ("%02x ", rq->cmd[i]);
 			printk ("\"\n");
 		}
 
@@ -495,7 +497,7 @@
 		}
 	}
 
-#else /* not VERBOSE_IDE_CD_ERRORS */
+#else
 
 	/* Suppress printing unit attention and `in progress of becoming ready'
 	   errors when we're not being verbose. */
@@ -509,7 +511,7 @@
 		drive->name,
 		sense->error_code, sense->sense_key,
 		sense->asc, sense->ascq);
-#endif /* not VERBOSE_IDE_CD_ERRORS */
+#endif
 }
 
 static void cdrom_queue_request_sense(ide_drive_t *drive,
@@ -525,16 +527,20 @@
 		sense = &info->sense_data;
 
 	memset(pc, 0, sizeof(struct packet_command));
-	pc->c[0] = GPCMD_REQUEST_SENSE;
-	pc->c[4] = pc->buflen = 18;
-	pc->buffer = (char *) sense;
+	pc->buffer = (void *) sense;
+	pc->buflen = 18;
 	pc->sense = (struct request_sense *) failed_command;
 
 	/* stuff the sense request in front of our current request */
 	rq = &info->request_sense_request;
+	rq->cmd[0] = GPCMD_REQUEST_SENSE;
+	rq->cmd[4] = pc->buflen;
 	ide_init_drive_cmd(rq);
 	rq->flags = REQ_SENSE;
+
+	/* FIXME --mdcki */
 	rq->special = (char *) pc;
+
 	rq->waiting = wait;
 	ide_do_drive_cmd(drive, rq, ide_preempt);
 }
@@ -544,16 +550,13 @@
 {
 	struct request *rq = HWGROUP(drive)->rq;
 
-	if ((rq->flags & REQ_SENSE) && uptodate) {
-		struct packet_command *pc = (struct packet_command *) rq->special;
-		cdrom_analyze_sense_data(drive,
-			(struct packet_command *) pc->sense,
-			(struct request_sense *) (pc->buffer - pc->c[4]));
-	}
+	if ((rq->flags & REQ_SENSE) && uptodate)
+		cdrom_analyze_sense_data(drive, rq);
 
 	if ((rq->flags & REQ_CMD) && !rq->current_nr_sectors)
 		uptodate = 1;
 
+	/* FIXME --mdcki */
 	HWGROUP(drive)->rq->special = NULL;
 	ide_end_request(drive, uptodate);
 }
@@ -567,7 +570,7 @@
 	struct request *rq = HWGROUP(drive)->rq;
 	int stat, err, sense_key;
 	struct packet_command *pc;
-	
+
 	/* Check for errors. */
 	stat = GET_STAT();
 	*stat_ret = stat;
@@ -590,6 +593,7 @@
 		   from the drive (probably while trying
 		   to recover from a former error).  Just give up. */
 
+		/* FIXME --mdcki */
 		pc = (struct packet_command *) rq->special;
 		pc->stat = 1;
 		cdrom_end_request(drive, 1);
@@ -598,6 +602,8 @@
 	} else if (rq->flags & (REQ_PC | REQ_BLOCK_PC)) {
 		/* All other functions, except for READ. */
 		struct completion *wait = NULL;
+
+		/* FIXME --mdcki */
 		pc = (struct packet_command *) rq->special;
 
 		/* Check for tray open. */
@@ -612,15 +618,14 @@
 			/* Otherwise, print an error. */
 			ide_dump_status(drive, "packet command error", stat);
 		}
-		
+
 		/* Set the error flag and complete the request.
-		   Then, if we have a CHECK CONDITION status,
-		   queue a request sense command.  We must be careful,
-		   though: we don't want the thread in
-		   cdrom_queue_packet_command to wake up until
-		   the request sense has completed.  We do this
-		   by transferring the semaphore from the packet
-		   command request to the request sense request. */
+		   Then, if we have a CHECK CONDITION status, queue a request
+		   sense command.  We must be careful, though: we don't want
+		   the thread in cdrom_queue_packet_command to wake up until
+		   the request sense has completed.  We do this by transferring
+		   the semaphore from the packet command request to the request
+		   sense request. */
 
 		if ((stat & ERR_STAT) != 0) {
 			wait = rq->waiting;
@@ -756,22 +761,15 @@
 	}
 }
 
-/* Send a packet command to DRIVE described by CMD_BUF and CMD_LEN.
-   The device registers must have already been prepared
-   by cdrom_start_packet_command.
-   HANDLER is the interrupt handler to call when the command completes
-   or there's data ready. */
 /*
- * changed 5 parameters to 3 for dvd-ram
- * struct packet_command *pc; now packet_command_t *pc;
+ * Send a packet command cmd to the drive.  The device registers must have
+ * already been prepared by cdrom_start_packet_command.  "handler" is the
+ * interrupt handler to call when the command completes or there's data ready.
  */
 static ide_startstop_t cdrom_transfer_packet_command (ide_drive_t *drive,
-					  struct packet_command *pc,
-					  ide_handler_t *handler)
+		unsigned char *cmd, unsigned long timeout,
+		ide_handler_t *handler)
 {
-	unsigned char *cmd_buf	= pc->c;
-	int cmd_len		= sizeof(pc->c);
-	unsigned int timeout	= pc->timeout;
 	ide_startstop_t startstop;
 
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
@@ -780,20 +778,21 @@
 		int stat_dum;
 
 		/* Check for errors. */
-		if (cdrom_decode_status (&startstop, drive, DRQ_STAT, &stat_dum))
+		if (cdrom_decode_status(&startstop, drive, DRQ_STAT, &stat_dum))
 			return startstop;
 	} else {
 		/* Otherwise, we must wait for DRQ to get set. */
-		if (ide_wait_stat (&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READY))
+		if (ide_wait_stat(&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READY))
 			return startstop;
 	}
 
 	/* Arm the interrupt handler. */
 	BUG_ON(HWGROUP(drive)->handler);
-	ide_set_handler (drive, handler, timeout, cdrom_timer_expiry);
+	ide_set_handler(drive, handler, timeout, cdrom_timer_expiry);
 
 	/* Send the command to the device. */
-	atapi_output_bytes (drive, cmd_buf, cmd_len);
+	atapi_output_bytes(drive, cmd, CDROM_PACKET_SIZE);
+
 	return ide_started;
 }
 
@@ -889,7 +888,7 @@
 /*
  * Interrupt routine.  Called when a read request has completed.
  */
-static ide_startstop_t cdrom_read_intr (ide_drive_t *drive)
+static ide_startstop_t cdrom_read_intr(ide_drive_t *drive)
 {
 	int stat;
 	int ireason, len, sectors_to_transfer, nskip;
@@ -908,7 +907,7 @@
 
 	if (cdrom_decode_status (&startstop, drive, 0, &stat))
 		return startstop;
- 
+
 	if (dma) {
 		if (!dma_error) {
 			__ide_end_request(drive, 1, rq->nr_sectors);
@@ -1071,14 +1070,12 @@
 }
 
 /*
- * Routine to send a read packet command to the drive.
- * This is usually called directly from cdrom_start_read.
- * However, for drq_interrupt devices, it is called from an interrupt
- * when the drive is ready to accept the command.
+ * Routine to send a read packet command to the drive.  This is usually called
+ * directly from cdrom_start_read.  However, for drq_interrupt devices, it is
+ * called from an interrupt when the drive is ready to accept the command.
  */
-static ide_startstop_t cdrom_start_read_continuation (ide_drive_t *drive)
+static ide_startstop_t cdrom_start_read_continuation(ide_drive_t *drive)
 {
-	struct packet_command pc;
 	struct request *rq = HWGROUP(drive)->rq;
 	int nsect, sector, nframes, frame, nskip;
 
@@ -1117,15 +1114,11 @@
 
 	/* Largest number of frames was can transfer at once is 64k-1. For
 	   some drives we need to limit this even more. */
-	nframes = MIN (nframes, (CDROM_CONFIG_FLAGS (drive)->limit_nframes) ?
+	nframes = MIN(nframes, (CDROM_CONFIG_FLAGS (drive)->limit_nframes) ?
 		(65534 / CD_FRAMESIZE) : 65535);
 
-	/* Set up the command */
-	memcpy(pc.c, rq->cmd, sizeof(pc.c));
-	pc.timeout = WAIT_CMD;
-
 	/* Send the command to the drive and return. */
-	return cdrom_transfer_packet_command(drive, &pc, &cdrom_read_intr);
+	return cdrom_transfer_packet_command(drive, rq->cmd, WAIT_CMD, &cdrom_read_intr);
 }
 
 
@@ -1161,7 +1154,7 @@
 
 static ide_startstop_t cdrom_start_seek_continuation (ide_drive_t *drive)
 {
-	struct packet_command pc;
+	unsigned char cmd[CDROM_PACKET_SIZE];
 	struct request *rq = HWGROUP(drive)->rq;
 	int sector, frame, nskip;
 
@@ -1172,11 +1165,10 @@
 	frame = sector / SECTORS_PER_FRAME;
 
 	memset(rq->cmd, 0, sizeof(rq->cmd));
-	pc.c[0] = GPCMD_SEEK;
-	put_unaligned(cpu_to_be32(frame), (unsigned int *) &pc.c[2]);
+	cmd[0] = GPCMD_SEEK;
+	put_unaligned(cpu_to_be32(frame), (unsigned int *) &cmd[2]);
 
-	pc.timeout = WAIT_CMD;
-	return cdrom_transfer_packet_command(drive, &pc, &cdrom_seek_intr);
+	return cdrom_transfer_packet_command(drive, cmd, WAIT_CMD, &cdrom_seek_intr);
 }
 
 static ide_startstop_t cdrom_start_seek (ide_drive_t *drive, unsigned int block)
@@ -1243,15 +1235,13 @@
  * Execute all other packet commands.
  */
 
-/* Forward declarations. */
-static int cdrom_lockdoor(ide_drive_t *drive, int lockflag,
-			  struct request_sense *sense);
-
 /* Interrupt routine for packet command completion. */
 static ide_startstop_t cdrom_pc_intr (ide_drive_t *drive)
 {
 	int ireason, len, stat, thislen;
 	struct request *rq = HWGROUP(drive)->rq;
+
+	/* FIXME --mdcki */
 	struct packet_command *pc = (struct packet_command *) rq->special;
 	ide_startstop_t startstop;
 
@@ -1268,7 +1258,7 @@
 	if ((stat & DRQ_STAT) == 0) {
 		/* Some of the trailing request sense fields are optional, and
 		   some drives don't send them.  Sigh. */
-		if (pc->c[0] == GPCMD_REQUEST_SENSE &&
+		if (rq->cmd[0] == GPCMD_REQUEST_SENSE &&
 		    pc->buflen > 0 &&
 		    pc->buflen <= 5) {
 			while (pc->buflen > 0) {
@@ -1346,24 +1336,29 @@
 	return ide_started;
 }
 
-
-static ide_startstop_t cdrom_do_pc_continuation (ide_drive_t *drive)
+static ide_startstop_t cdrom_do_pc_continuation(ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
+	unsigned long timeout;
+
+	/* FIXME --mdcki */
 	struct packet_command *pc = (struct packet_command *) rq->special;
 
-	if (!pc->timeout)
-		pc->timeout = WAIT_CMD;
+	if (pc->timeout)
+		timeout = pc->timeout;
+	else
+		timeout = WAIT_CMD;
 
 	/* Send the command to the drive and return. */
-	return cdrom_transfer_packet_command(drive, pc, &cdrom_pc_intr);
+	return cdrom_transfer_packet_command(drive, rq->cmd, timeout, &cdrom_pc_intr);
 }
 
-
 static ide_startstop_t cdrom_do_packet_command (ide_drive_t *drive)
 {
 	int len;
 	struct request *rq = HWGROUP(drive)->rq;
+
+	/* FIXME --mdcki */
 	struct packet_command *pc = (struct packet_command *) rq->special;
 	struct cdrom_info *info = drive->driver_data;
 
@@ -1391,23 +1386,28 @@
 }
 
 static
-int cdrom_queue_packet_command(ide_drive_t *drive, struct packet_command *pc)
+int cdrom_queue_packet_command(ide_drive_t *drive, unsigned char *cmd, struct packet_command *pc)
 {
 	struct request_sense sense;
-	struct request req;
+	struct request rq;
 	int retries = 10;
 
+	memcpy(rq.cmd, cmd, CDROM_PACKET_SIZE);
+
 	if (pc->sense == NULL)
 		pc->sense = &sense;
 
 	/* Start of retry loop. */
 	do {
-		ide_init_drive_cmd (&req);
-		req.flags = REQ_PC;
-		req.special = (char *) pc;
-		if (ide_do_drive_cmd (drive, &req, ide_wait)) {
+		ide_init_drive_cmd(&rq);
+
+		rq.flags = REQ_PC;
+
+		/* FIXME --mdcki */
+		rq.special = (void *) pc;
+		if (ide_do_drive_cmd(drive, &rq, ide_wait)) {
 			printk("%s: do_drive_cmd returned stat=%02x,err=%02x\n",
-				drive->name, req.buffer[0], req.buffer[1]);
+				drive->name, rq.buffer[0], rq.buffer[1]);
 			/* FIXME: we should probably abort/retry or something */
 		}
 		if (pc->stat != 0) {
@@ -1493,7 +1493,7 @@
 		printk("ide-cd: write_intr decode_status bad\n");
 		return startstop;
 	}
- 
+
 	/*
 	 * using dma, transfer is complete now
 	 */
@@ -1573,20 +1573,9 @@
 
 static ide_startstop_t cdrom_start_write_cont(ide_drive_t *drive)
 {
-	struct packet_command pc;	/* packet_command_t pc; */
 	struct request *rq = HWGROUP(drive)->rq;
-	unsigned nframes, frame;
-
-	nframes = rq->nr_sectors >> 2;
-	frame = rq->sector >> 2;
-
-	memcpy(pc.c, rq->cmd, sizeof(pc.c));
-#if 0	/* the immediate bit */
-	pc.c[1] = 1 << 3;
-#endif
-	pc.timeout = 2 * WAIT_CMD;
 
-	return cdrom_transfer_packet_command(drive, &pc, cdrom_write_intr);
+	return cdrom_transfer_packet_command(drive, rq->cmd, 2 * WAIT_CMD, cdrom_write_intr);
 }
 
 static ide_startstop_t cdrom_start_write(ide_drive_t *drive, struct request *rq)
@@ -1620,34 +1609,13 @@
 	return cdrom_start_packet_command(drive, 32768, cdrom_start_write_cont);
 }
 
-/*
- * just wrap this around cdrom_do_packet_command
- */
-static ide_startstop_t cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
-{
-	struct packet_command pc;
-	ide_startstop_t startstop;
-
-	memset(&pc, 0, sizeof(pc));
-	memcpy(pc.c, rq->cmd, sizeof(pc.c));
-	pc.quiet = 1;
-	pc.timeout = 60 * HZ;
-	rq->special = (char *) &pc;
-
-	startstop = cdrom_do_packet_command(drive);
-	if (pc.stat)
-		rq->errors++;
-
-	return startstop;
-}
-
 #define IDE_LARGE_SEEK(b1,b2,t)	(((b1) > (b2) + (t)) || ((b2) > (b1) + (t)))
 
 /****************************************************************************
  * cdrom driver request routine.
  */
 static ide_startstop_t
-ide_do_rw_cdrom (ide_drive_t *drive, struct request *rq, unsigned long block)
+ide_do_rw_cdrom(ide_drive_t *drive, struct request *rq, unsigned long block)
 {
 	ide_startstop_t action;
 	struct cdrom_info *info = drive->driver_data;
@@ -1679,18 +1647,31 @@
 	} else if (rq->flags & (REQ_PC | REQ_SENSE)) {
 		return cdrom_do_packet_command(drive);
 	} else if (rq->flags & REQ_SPECIAL) {
-
 		/*
-		 * FIXME: Kill REQ_SEPCIAL and replace it will command commands
-		 * queued at the request queue instead as suggested (abd
-		 * rightly so) by Linus.
+		 * FIXME: Kill REQ_SEPCIAL and replace it with commands queued
+		 * at the request queue instead as suggested by Linus.
 		 *
 		 * right now this can only be a reset...
 		 */
-		cdrom_end_request(drive, 1); return ide_stopped;
 
+		cdrom_end_request(drive, 1);
+		return ide_stopped;
 	} else if (rq->flags & REQ_BLOCK_PC) {
-		return cdrom_do_block_pc(drive, rq);
+		struct packet_command pc;
+		ide_startstop_t startstop;
+
+		memset(&pc, 0, sizeof(pc));
+		pc.quiet = 1;
+		pc.timeout = 60 * HZ;
+
+		/* FIXME --mdcki */
+		rq->special = (char *) &pc;
+
+		startstop = cdrom_do_packet_command(drive);
+		if (pc.stat)
+			++rq->errors;
+
+		return startstop;
 	}
 
 	blk_dump_rq_flags(rq, "ide-cd bad flags");
@@ -1755,6 +1736,7 @@
 
 static int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
 {
+	unsigned char cmd[CDROM_PACKET_SIZE];
 	struct packet_command pc;
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
@@ -1762,16 +1744,16 @@
 	memset(&pc, 0, sizeof(pc));
 	pc.sense = sense;
 
-	pc.c[0] = GPCMD_TEST_UNIT_READY;
+	cmd[0] = GPCMD_TEST_UNIT_READY;
 
-#if ! STANDARD_ATAPI
-        /* the Sanyo 3 CD changer uses byte 7 of TEST_UNIT_READY to 
+#if !STANDARD_ATAPI
+        /* the Sanyo 3 CD changer uses byte 7 of TEST_UNIT_READY to
            switch CDs instead of supporting the LOAD_UNLOAD opcode   */
 
-        pc.c[7] = cdi->sanyo_slot % 3;
-#endif /* not STANDARD_ATAPI */
+        cmd[7] = cdi->sanyo_slot % 3;
+#endif
 
-	return cdrom_queue_packet_command(drive, &pc);
+	return cdrom_queue_packet_command(drive, cmd, &pc);
 }
 
 
@@ -1779,22 +1761,20 @@
 static int
 cdrom_lockdoor(ide_drive_t *drive, int lockflag, struct request_sense *sense)
 {
-	struct request_sense my_sense;
 	struct packet_command pc;
 	int stat;
 
-	if (sense == NULL)
-		sense = &my_sense;
-
 	/* If the drive cannot lock the door, just pretend. */
 	if (CDROM_CONFIG_FLAGS(drive)->no_doorlock) {
 		stat = 0;
 	} else {
+		unsigned char cmd[CDROM_PACKET_SIZE];
+
 		memset(&pc, 0, sizeof(pc));
 		pc.sense = sense;
-		pc.c[0] = GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
-		pc.c[4] = lockflag ? 1 : 0;
-		stat = cdrom_queue_packet_command (drive, &pc);
+		cmd[0] = GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
+		cmd[4] = lockflag ? 1 : 0;
+		stat = cdrom_queue_packet_command(drive, cmd, &pc);
 	}
 
 	/* If we got an illegal field error, the drive
@@ -1807,7 +1787,7 @@
 		CDROM_CONFIG_FLAGS (drive)->no_doorlock = 1;
 		stat = 0;
 	}
-	
+
 	/* no medium, that's alright. */
 	if (stat != 0 && sense->sense_key == NOT_READY && sense->asc == 0x3a)
 		stat = 0;
@@ -1825,10 +1805,11 @@
 		       struct request_sense *sense)
 {
 	struct packet_command pc;
+	unsigned char cmd[CDROM_PACKET_SIZE];
 
 	if (CDROM_CONFIG_FLAGS(drive)->no_eject && !ejectflag)
 		return -EDRIVE_CANT_DO_THIS;
-	
+
 	/* reload fails on some drives, if the tray is locked */
 	if (CDROM_STATE_FLAGS(drive)->door_locked && ejectflag)
 		return 0;
@@ -1836,9 +1817,9 @@
 	memset(&pc, 0, sizeof (pc));
 	pc.sense = sense;
 
-	pc.c[0] = GPCMD_START_STOP_UNIT;
-	pc.c[4] = 0x02 + (ejectflag != 0);
-	return cdrom_queue_packet_command (drive, &pc);
+	cmd[0] = GPCMD_START_STOP_UNIT;
+	cmd[4] = 0x02 + (ejectflag != 0);
+	return cdrom_queue_packet_command(drive, cmd, &pc);
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
@@ -1850,16 +1831,16 @@
 	} capbuf;
 
 	int stat;
+	unsigned char cmd[CDROM_PACKET_SIZE];
 	struct packet_command pc;
 
 	memset(&pc, 0, sizeof(pc));
 	pc.sense = sense;
 
-	pc.c[0] = GPCMD_READ_CDVD_CAPACITY;
+	cmd[0] = GPCMD_READ_CDVD_CAPACITY;
 	pc.buffer = (char *)&capbuf;
 	pc.buflen = sizeof(capbuf);
-
-	stat = cdrom_queue_packet_command(drive, &pc);
+	stat = cdrom_queue_packet_command(drive, cmd, &pc);
 	if (stat == 0)
 		*capacity = 1 + be32_to_cpu(capbuf.lba);
 
@@ -1870,6 +1851,7 @@
 				int format, char *buf, int buflen,
 				struct request_sense *sense)
 {
+	unsigned char cmd[CDROM_PACKET_SIZE];
 	struct packet_command pc;
 
 	memset(&pc, 0, sizeof(pc));
@@ -1878,16 +1860,16 @@
 	pc.buffer =  buf;
 	pc.buflen = buflen;
 	pc.quiet = 1;
-	pc.c[0] = GPCMD_READ_TOC_PMA_ATIP;
-	pc.c[6] = trackno;
-	pc.c[7] = (buflen >> 8);
-	pc.c[8] = (buflen & 0xff);
-	pc.c[9] = (format << 6);
 
+	cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
 	if (msf_flag)
-		pc.c[1] = 2;
+		cmd[1] = 2;
+	cmd[6] = trackno;
+	cmd[7] = (buflen >> 8);
+	cmd[8] = (buflen & 0xff);
+	cmd[9] = (format << 6);
 
-	return cdrom_queue_packet_command (drive, &pc);
+	return cdrom_queue_packet_command(drive, cmd, &pc);
 }
 
 
@@ -1916,7 +1898,7 @@
 
 	/* Check to see if the existing data is still valid.
 	   If it is, just return. */
-	(void) cdrom_check_status(drive, sense);
+	cdrom_check_status(drive, sense);
 
 	if (CDROM_STATE_FLAGS(drive)->toc_valid)
 		return 0;
@@ -2049,6 +2031,7 @@
 static int cdrom_read_subchannel(ide_drive_t *drive, int format, char *buf,
 				 int buflen, struct request_sense *sense)
 {
+	unsigned char cmd[CDROM_PACKET_SIZE];
 	struct packet_command pc;
 
 	memset(&pc, 0, sizeof(pc));
@@ -2056,13 +2039,14 @@
 
 	pc.buffer = buf;
 	pc.buflen = buflen;
-	pc.c[0] = GPCMD_READ_SUBCHANNEL;
-	pc.c[1] = 2;     /* MSF addressing */
-	pc.c[2] = 0x40;  /* request subQ data */
-	pc.c[3] = format;
-	pc.c[7] = (buflen >> 8);
-	pc.c[8] = (buflen & 0xff);
-	return cdrom_queue_packet_command(drive, &pc);
+	cmd[0] = GPCMD_READ_SUBCHANNEL;
+	cmd[1] = 2;     /* MSF addressing */
+	cmd[2] = 0x40;  /* request subQ data */
+	cmd[3] = format;
+	cmd[7] = (buflen >> 8);
+	cmd[8] = (buflen & 0xff);
+
+	return cdrom_queue_packet_command(drive, cmd, &pc);
 }
 
 /* ATAPI cdrom drives are free to select the speed you request or any slower
@@ -2070,6 +2054,7 @@
 static int cdrom_select_speed(ide_drive_t *drive, int speed,
 			      struct request_sense *sense)
 {
+	unsigned char cmd[CDROM_PACKET_SIZE];
 	struct packet_command pc;
 	memset(&pc, 0, sizeof(pc));
 	pc.sense = sense;
@@ -2079,36 +2064,37 @@
 	else
 		speed *= 177;   /* Nx to kbytes/s */
 
-	pc.c[0] = GPCMD_SET_SPEED;
+	cmd[0] = GPCMD_SET_SPEED;
 	/* Read Drive speed in kbytes/second MSB */
-	pc.c[2] = (speed >> 8) & 0xff;	
+	cmd[2] = (speed >> 8) & 0xff;
 	/* Read Drive speed in kbytes/second LSB */
-	pc.c[3] = speed & 0xff;
+	cmd[3] = speed & 0xff;
 	if (CDROM_CONFIG_FLAGS(drive)->cd_r ||
 	    CDROM_CONFIG_FLAGS(drive)->cd_rw ||
 	    CDROM_CONFIG_FLAGS(drive)->dvd_r) {
 		/* Write Drive speed in kbytes/second MSB */
-		pc.c[4] = (speed >> 8) & 0xff;
+		cmd[4] = (speed >> 8) & 0xff;
 		/* Write Drive speed in kbytes/second LSB */
-		pc.c[5] = speed & 0xff;
+		cmd[5] = speed & 0xff;
        }
 
-	return cdrom_queue_packet_command(drive, &pc);
+	return cdrom_queue_packet_command(drive, cmd, &pc);
 }
 
 static int cdrom_play_audio(ide_drive_t *drive, int lba_start, int lba_end)
 {
 	struct request_sense sense;
+	unsigned char cmd[CDROM_PACKET_SIZE];
 	struct packet_command pc;
 
 	memset(&pc, 0, sizeof (pc));
 	pc.sense = &sense;
 
-	pc.c[0] = GPCMD_PLAY_AUDIO_MSF;
-	lba_to_msf(lba_start, &pc.c[3], &pc.c[4], &pc.c[5]);
-	lba_to_msf(lba_end-1, &pc.c[6], &pc.c[7], &pc.c[8]);
+	cmd[0] = GPCMD_PLAY_AUDIO_MSF;
+	lba_to_msf(lba_start, &cmd[3], &cmd[4], &cmd[5]);
+	lba_to_msf(lba_end-1, &cmd[6], &cmd[7], &cmd[8]);
 
-	return cdrom_queue_packet_command(drive, &pc);
+	return cdrom_queue_packet_command(drive, cmd, &pc);
 }
 
 static int cdrom_get_toc_entry(ide_drive_t *drive, int track,
@@ -2152,15 +2138,15 @@
 	   layer. the packet must be complete, as we do not
 	   touch it at all. */
 	memset(&pc, 0, sizeof(pc));
-	memcpy(pc.c, cgc->cmd, CDROM_PACKET_SIZE);
 	pc.buffer = cgc->buffer;
 	pc.buflen = cgc->buflen;
 	pc.quiet = cgc->quiet;
 	pc.timeout = cgc->timeout;
 	pc.sense = cgc->sense;
-	cgc->stat = cdrom_queue_packet_command(drive, &pc);
+	cgc->stat = cdrom_queue_packet_command(drive, cgc->cmd, &pc);
 	if (!cgc->stat)
 		cgc->buflen -= pc.buflen;
+
 	return cgc->stat;
 }
 
@@ -2177,34 +2163,34 @@
 
 	/* These will be moved into the Uniform layer shortly... */
 	switch (cmd) {
- 	case CDROMSETSPINDOWN: {
- 		char spindown;
- 
- 		if (copy_from_user(&spindown, (void *) arg, sizeof(char)))
+	case CDROMSETSPINDOWN: {
+		char spindown;
+
+		if (copy_from_user(&spindown, (void *) arg, sizeof(char)))
 			return -EFAULT;
- 
+
                 if ((stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CDROM_PAGE, 0)))
 			return stat;
 
- 		buffer[11] = (buffer[11] & 0xf0) | (spindown & 0x0f);
+		buffer[11] = (buffer[11] & 0xf0) | (spindown & 0x0f);
+
+		return cdrom_mode_select(cdi, &cgc);
+	}
+
+	case CDROMGETSPINDOWN: {
+		char spindown;
 
- 		return cdrom_mode_select(cdi, &cgc);
- 	} 
- 
- 	case CDROMGETSPINDOWN: {
- 		char spindown;
- 
                 if ((stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CDROM_PAGE, 0)))
 			return stat;
- 
- 		spindown = buffer[11] & 0x0f;
- 
+
+		spindown = buffer[11] & 0x0f;
+
 		if (copy_to_user((void *) arg, &spindown, sizeof (char)))
 			return -EFAULT;
- 
- 		return 0;
- 	}
-  
+
+		return 0;
+	}
+
 	default:
 		return -EINVAL;
 	}
@@ -2214,7 +2200,6 @@
 static
 int ide_cdrom_audio_ioctl (struct cdrom_device_info *cdi,
 			   unsigned int cmd, void *arg)
-			   
 {
 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
 	struct cdrom_info *info = drive->driver_data;
@@ -2306,31 +2291,34 @@
 	 * lock it again.
 	 */
 	if (CDROM_STATE_FLAGS(drive)->door_locked)
-		(void) cdrom_lockdoor(drive, 1, &sense);
+		cdrom_lockdoor(drive, 1, &sense);
 
 	return ret;
 }
 
 
 static
-int ide_cdrom_tray_move (struct cdrom_device_info *cdi, int position)
+int ide_cdrom_tray_move(struct cdrom_device_info *cdi, int position)
 {
 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
 	struct request_sense sense;
 
 	if (position) {
 		int stat = cdrom_lockdoor(drive, 0, &sense);
-		if (stat) return stat;
+		if (stat)
+			return stat;
 	}
 
 	return cdrom_eject(drive, !position, &sense);
 }
 
 static
-int ide_cdrom_lock_door (struct cdrom_device_info *cdi, int lock)
+int ide_cdrom_lock_door(struct cdrom_device_info *cdi, int lock)
 {
 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
-	return cdrom_lockdoor(drive, lock, NULL);
+	struct request_sense sense;
+
+	return cdrom_lockdoor(drive, lock, &sense);
 }
 
 static
@@ -2433,9 +2421,9 @@
 {
 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
 	int retval;
-	
+
 	if (slot_nr == CDSL_CURRENT) {
-		(void) cdrom_check_status(drive, NULL);
+		cdrom_check_status(drive, NULL);
 		retval = CDROM_STATE_FLAGS (drive)->media_changed;
 		CDROM_STATE_FLAGS (drive)->media_changed = 0;
 		return retval;
@@ -2502,7 +2490,7 @@
 	*(int *)&devinfo->capacity = nslots;
 	devinfo->handle = (void *) drive;
 	strcpy(devinfo->name, drive->name);
-	
+
 	/* set capability mask to match the probe. */
 	if (!CDROM_CONFIG_FLAGS (drive)->cd_r)
 		devinfo->mask |= CDC_CD_R;
@@ -2578,8 +2566,8 @@
 	int nslots = 1;
 
 	if (CDROM_CONFIG_FLAGS (drive)->nec260) {
-		CDROM_CONFIG_FLAGS (drive)->no_eject = 0;                       
-		CDROM_CONFIG_FLAGS (drive)->audio_play = 1;       
+		CDROM_CONFIG_FLAGS (drive)->no_eject = 0;
+		CDROM_CONFIG_FLAGS (drive)->audio_play = 1;
 		return nslots;
 	}
 
@@ -2632,14 +2620,14 @@
 
 	/* The ACER/AOpen 24X cdrom has the speed fields byte-swapped */
 	if (drive->id && !drive->id->model[0] && !strncmp(drive->id->fw_rev, "241N", 4)) {
-		CDROM_STATE_FLAGS (drive)->current_speed  = 
+		CDROM_STATE_FLAGS (drive)->current_speed  =
 			(((unsigned int)cap.curspeed) + (176/2)) / 176;
-		CDROM_CONFIG_FLAGS (drive)->max_speed = 
+		CDROM_CONFIG_FLAGS (drive)->max_speed =
 			(((unsigned int)cap.maxspeed) + (176/2)) / 176;
 	} else {
-		CDROM_STATE_FLAGS (drive)->current_speed  = 
+		CDROM_STATE_FLAGS (drive)->current_speed  =
 			(ntohs(cap.curspeed) + (176/2)) / 176;
-		CDROM_CONFIG_FLAGS (drive)->max_speed = 
+		CDROM_CONFIG_FLAGS (drive)->max_speed =
 			(ntohs(cap.maxspeed) + (176/2)) / 176;
 	}
 
@@ -2651,19 +2639,19 @@
 	printk(" %s", CDROM_CONFIG_FLAGS(drive)->dvd ? "DVD-ROM" : "CD-ROM");
 
 	if (CDROM_CONFIG_FLAGS (drive)->dvd_r|CDROM_CONFIG_FLAGS (drive)->dvd_ram)
-        	printk (" DVD%s%s", 
-        	(CDROM_CONFIG_FLAGS (drive)->dvd_r)? "-R" : "", 
-        	(CDROM_CONFIG_FLAGS (drive)->dvd_ram)? "-RAM" : "");
-
-        if (CDROM_CONFIG_FLAGS (drive)->cd_r|CDROM_CONFIG_FLAGS (drive)->cd_rw) 
-        	printk (" CD%s%s", 
-        	(CDROM_CONFIG_FLAGS (drive)->cd_r)? "-R" : "", 
-        	(CDROM_CONFIG_FLAGS (drive)->cd_rw)? "/RW" : "");
-
-        if (CDROM_CONFIG_FLAGS (drive)->is_changer) 
-        	printk (" changer w/%d slots", nslots);
-        else 	
-        	printk (" drive");
+		printk (" DVD%s%s",
+		(CDROM_CONFIG_FLAGS (drive)->dvd_r)? "-R" : "",
+		(CDROM_CONFIG_FLAGS (drive)->dvd_ram)? "-RAM" : "");
+
+        if (CDROM_CONFIG_FLAGS (drive)->cd_r|CDROM_CONFIG_FLAGS (drive)->cd_rw)
+		printk (" CD%s%s",
+		(CDROM_CONFIG_FLAGS (drive)->cd_r)? "-R" : "",
+		(CDROM_CONFIG_FLAGS (drive)->cd_rw)? "/RW" : "");
+
+        if (CDROM_CONFIG_FLAGS (drive)->is_changer)
+		printk (" changer w/%d slots", nslots);
+        else
+		printk (" drive");
 
 	printk (", %dkB Cache", be16_to_cpu(cap.buffer_size));
 
@@ -2678,7 +2666,8 @@
 
 static void ide_cdrom_add_settings(ide_drive_t *drive)
 {
-	ide_add_setting(drive,	"dsc_overlap",		SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 1,	1, &drive->dsc_overlap, NULL);
+	ide_add_setting(drive, "dsc_overlap",
+			SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 1,	1, &drive->dsc_overlap, NULL);
 }
 
 static
@@ -2728,7 +2717,7 @@
 	CDROM_CONFIG_FLAGS (drive)->supp_disc_present = 0;
 	CDROM_CONFIG_FLAGS (drive)->audio_play = 0;
 	CDROM_CONFIG_FLAGS (drive)->close_tray = 1;
-	
+
 	/* limit transfer size per interrupt. */
 	CDROM_CONFIG_FLAGS (drive)->limit_nframes = 0;
 	if (drive->id != NULL) {
@@ -2763,16 +2752,12 @@
 			CDROM_CONFIG_FLAGS (drive)->tocaddr_as_bcd = 1;
 			CDROM_CONFIG_FLAGS (drive)->playmsf_as_bcd = 1;
 			CDROM_CONFIG_FLAGS (drive)->subchan_as_bcd = 1;
-		}
-
-		else if (strcmp (drive->id->model, "V006E0DS") == 0 &&
+		} else if (strcmp (drive->id->model, "V006E0DS") == 0 &&
 		    drive->id->fw_rev[4] == '1' &&
 		    drive->id->fw_rev[6] <= '2') {
 			/* Vertos 600 ESD. */
 			CDROM_CONFIG_FLAGS (drive)->toctracks_as_bcd = 1;
-		}
-
-		else if (strcmp (drive->id->model,
+		} else if (strcmp (drive->id->model,
 				 "NEC CD-ROM DRIVE:260") == 0 &&
 			 strncmp (drive->id->fw_rev, "1.01", 4) == 0) { /* FIXME */
 			/* Old NEC260 (not R).
@@ -2782,9 +2767,7 @@
 			CDROM_CONFIG_FLAGS (drive)->playmsf_as_bcd = 1;
 			CDROM_CONFIG_FLAGS (drive)->subchan_as_bcd = 1;
 			CDROM_CONFIG_FLAGS (drive)->nec260         = 1;
-		}
-
-		else if (strcmp (drive->id->model, "WEARNES CDD-120") == 0 &&
+		} else if (strcmp (drive->id->model, "WEARNES CDD-120") == 0 &&
 			 strncmp (drive->id->fw_rev, "A1.1", 4) == 0) { /* FIXME */
 			/* Wearnes */
 			CDROM_CONFIG_FLAGS (drive)->playmsf_as_bcd = 1;
@@ -2989,7 +2972,7 @@
 			kfree (info);
 			continue;
 		}
-		memset (info, 0, sizeof (struct cdrom_info));
+		memset(info, 0, sizeof (struct cdrom_info));
 		drive->driver_data = info;
 
 		MOD_INC_USE_COUNT;
diff -urN linux-2.5.8/drivers/ide/ide-cd.h linux/drivers/ide/ide-cd.h
--- linux-2.5.8/drivers/ide/ide-cd.h	Mon Mar 18 21:37:18 2002
+++ linux/drivers/ide/ide-cd.h	Mon Apr 15 09:11:15 2002
@@ -15,7 +15,7 @@
    memory, though. */
 
 #ifndef VERBOSE_IDE_CD_ERRORS
-#define VERBOSE_IDE_CD_ERRORS 1
+# define VERBOSE_IDE_CD_ERRORS 1
 #endif
 
 
@@ -24,7 +24,7 @@
    this will give you a slightly smaller kernel. */
 
 #ifndef STANDARD_ATAPI
-#define STANDARD_ATAPI 0
+# define STANDARD_ATAPI 0
 #endif
 
 
@@ -32,14 +32,14 @@
    This is apparently needed for supermount. */
 
 #ifndef NO_DOOR_LOCKING
-#define NO_DOOR_LOCKING 0
+# define NO_DOOR_LOCKING 0
 #endif
 
 /************************************************************************/
 
-#define SECTOR_BITS 		9
+#define SECTOR_BITS		9
 #ifndef SECTOR_SIZE
-#define SECTOR_SIZE		(1 << SECTOR_BITS)
+# define SECTOR_SIZE		(1 << SECTOR_BITS)
 #endif
 #define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_BITS)
 #define SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
@@ -50,12 +50,6 @@
 
 #define MIN(a,b) ((a) < (b) ? (a) : (b))
 
-/* special command codes for strategy routine. */
-#define PACKET_COMMAND        4315
-#define REQUEST_SENSE_COMMAND 4316
-#define RESET_DRIVE_COMMAND   4317
-
-
 /* Configuration flags.  These describe the capabilities of the drive.
    They generally do not change after initialization, unless we learn
    more about the drive from stuff failing. */
@@ -90,7 +84,6 @@
 };
 #define CDROM_CONFIG_FLAGS(drive) (&(((struct cdrom_info *)(drive->driver_data))->config_flags))
 
- 
 /* State flags.  These give information about the current state of the
    drive, and will change during normal operation. */
 struct ide_cd_state_flags {
@@ -111,24 +104,23 @@
 	int quiet;
 	int timeout;
 	struct request_sense *sense;
-	unsigned char c[12];
 };
 
 /* Structure of a MSF cdrom address. */
 struct atapi_msf {
-	byte reserved;
-	byte minute;
-	byte second;
-	byte frame;
-};
+	u8 __reserved;
+	u8 minute;
+	u8 second;
+	u8 frame;
+} __attribute__((packed));
 
 /* Space to hold the disk TOC. */
 #define MAX_TRACKS 99
 struct atapi_toc_header {
-	unsigned short toc_length;
-	byte first_track;
-	byte last_track;
-};
+	u16 toc_length;
+	u8 first_track;
+	u8 last_track;
+} __attribute__((packed));
 
 struct atapi_toc_entry {
 	byte reserved1;
@@ -162,17 +154,17 @@
 /* This structure is annoyingly close to, but not identical with,
    the cdrom_subchnl structure from cdrom.h. */
 struct atapi_cdrom_subchnl {
- 	u_char  acdsc_reserved;
- 	u_char  acdsc_audiostatus;
- 	u_short acdsc_length;
-	u_char  acdsc_format;
+	u8	acdsc_reserved;
+	u8	acdsc_audiostatus;
+	u16	acdsc_length;
+	u8	acdsc_format;
 
 #if defined(__BIG_ENDIAN_BITFIELD)
-	u_char  acdsc_ctrl:     4;
-	u_char  acdsc_adr:      4;
+	u8	acdsc_ctrl:     4;
+	u8	acdsc_adr:      4;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-	u_char  acdsc_adr:	4;
-	u_char  acdsc_ctrl:	4;
+	u8	acdsc_adr:	4;
+	u8	acdsc_ctrl:	4;
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
diff -urN linux-2.5.8/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.8/drivers/ide/ide-taskfile.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ide-taskfile.c	Mon Apr 15 10:01:31 2002
@@ -980,7 +980,7 @@
 
 	/* FIXME: Do we really have to zero out the buffer?
 	 */
-	memset(argbuf, 0, 4 + SECTOR_WORDS * 4 * vals[3]);
+	memset(argbuf, 4, SECTOR_WORDS * 4 * vals[3]);
 	ide_init_drive_cmd(&rq);
 	rq.buffer = argbuf;
 	memcpy(argbuf, vals, 4);
diff -urN linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8/drivers/ide/ide.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ide.c	Mon Apr 15 10:17:15 2002
@@ -2701,7 +2701,11 @@
 
 void ide_teardown_commandlist(ide_drive_t *drive)
 {
-	struct pci_dev *pdev= drive->channel->pci_dev;
+#ifdef CONFIG_BLK_DEV_IDEPCI
+	struct pci_dev *pdev = drive->channel->pci_dev;
+#else
+	struct pci_dev *pdev = NULL;
+#endif
 	struct list_head *entry;
 
 	list_for_each(entry, &drive->free_req) {
@@ -2716,7 +2720,11 @@
 
 int ide_build_commandlist(ide_drive_t *drive)
 {
-	struct pci_dev *pdev= drive->channel->pci_dev;
+#ifdef CONFIG_BLK_DEV_IDEPCI
+	struct pci_dev *pdev = drive->channel->pci_dev;
+#else
+	struct pci_dev *pdev = NULL;
+#endif
 	struct ata_request *ar;
 	ide_tag_info_t *tcq;
 	int i, err;
@@ -2764,9 +2772,9 @@
 	if (i) {
 		drive->queue_depth = i;
 		if (i >= 1) {
-			drive->using_tcq = 1;
 			drive->tcq->queued = 0;
 			drive->tcq->active_tag = -1;
+
 			return 0;
 		}
 

--------------060204050005050107020104--

