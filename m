Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131383AbQLVBEY>; Thu, 21 Dec 2000 20:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131496AbQLVBEN>; Thu, 21 Dec 2000 20:04:13 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:57356 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S131383AbQLVBEL>; Thu, 21 Dec 2000 20:04:11 -0500
Date: Fri, 22 Dec 2000 01:33:14 +0100
From: Kurt Garloff <garloff@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
        Willem Riede <osst@riede.org>
Subject: osst driver update 0.8.5->0.8.6.1
Message-ID: <20001222013314.H7400@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Willem Riede <osst@riede.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PpAOPzA3dXsRhoo+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PpAOPzA3dXsRhoo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alan,

thanks for merging the osst driver (a driver which support the OnStream
SC-x0, DI-x0 and USB30 tape drives) into the 2.2.19pre1 kernel.

I'd like to ask you to apply the attached patch on top of it, upgrading
the driver version from 0.8.5 to 0.8.6.1.
Changes:
* README.osst does not talk about compilation with supplied Makefiles 
  outside the kernel any more.
* Handle another corner case when recovering read errors.
* Try to graciously handle partial overwrites:
  - Warn when overwriting with an old Write Pass Counter
  - Update filemark counts etc.
* Prevent filemark list corruption by preventing to fsf past EOD.
* Error handling fixes for the polling mode (used on IDE).

Patch is against 2.2.19pre2.
Please apply!

Regards,
-- 
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--PpAOPzA3dXsRhoo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="osst-0861-2219p2.diff"

diff -uNr linux-2.2.19-pre2/drivers/scsi/README.osst linux-2.2.19p2.osst/drivers/scsi/README.osst
--- linux-2.2.19-pre2/drivers/scsi/README.osst	Fri Dec 22 01:04:29 2000
+++ linux-2.2.19p2.osst/drivers/scsi/README.osst	Thu Dec 21 23:59:41 2000
@@ -1,6 +1,6 @@
 README file for the osst driver
 ===============================
-(w) Kurt Garloff <garloff@suse.de> 10/2000
+(w) Kurt Garloff <garloff@suse.de> 11/2000
 
 This file describes the osst driver as of version 0.8.x/0.9.x, the released
 version of the osst driver.
@@ -34,8 +34,8 @@
 are character devices with major no 206 and minor numbers like the /dev/stX
 devices. If those are not present, you may create them by calling
 Makedevs.sh as root (see below).
-The driver started beig a copy of st and as such, the osst devices'
-behaviour looks very much the same as st to the userspace applications.
+The driver started being a copy of st and as such, the osst devices'
+behavior looks very much the same as st to the userspace applications.
 
 
 History
@@ -50,57 +50,9 @@
 
 Installation
 ------------
-There is an easy and a correct approach to install the osst driver
-(a) Without patching your kernel
-(b) Full integration into your kernel
-(c) The mainstream kernel does already include the osst driver
-
-While it is still possible to use possibility (a), i.e. to compile the osst
-driver as a module without patching your kernel, this is not recommended, as
-you then have only very limited possibility to take advantage of the possible
-coexistence of st and osst. This possibility will be removed later.
-Anyway here is a description of how installation works.
-
-Make sure you have a configured 2.2.1x Linux kernel in /usr/src/linux by
-installing the approriate packages from your distro or by fetching the 
-source tarball from ftp.kernel.org or mirror and unpacking it in /usr/src/
-If your kernel is not yet configure, get a reasonable config file by doing
-cd /usr/src/linux
-make oldconfig			# You may use make menuconfig if starting
-				# from scratch
-make dep
-
-(a) Without patching your kernel
-
-cd /path/to/onstream/driver/	# REPLACE THIS WITH THE REAL PATH
-make
-make install
-
-That's all. You will get a couple of warnings on compilation, which you may
-ignore. The osst.o module is now in your module directory ready for loading
-and the device nodes have been created.
-
-(b) Full integration into the kernel. You need to have a reasonable kernel
-    config, otherwise you may be unable to use your system, as the produced
-    kernel may not support your hardware! IF YOU NEVER COMPILED YOUR OWN
-    KERNEL BEFORE, DON'T PROCEED, UNLESS YOU SUCEEDED USING YOUR SELF-
-    COMPILED KERNELS.
-
-cd /usr/src/linux
-patch -p1 < /path/to/onstream/driver/osst-2X.diff	# USE REAL PATH! X = 2,3,4
-cp -p /path/to/onstream/driver/osst.? drivers/scsi/	# Install drv srcs
-cp -p /path/to/onstream/driver/osst_options.h drivers/scsi/
-
-(b) and (c)
-
-make oldconfig			# or menuconfig / xconfig if you prefer
-				# enable the OSST driver!
-make dep
-make bzlilo			# to recopmile your kernel and have it
-				# installed
-make modules			# to compile the kernel modules
-make modules_install		# to install your modules
-depmod -a			# append kernel version if necessary
+osst got integrated into the linux kernel. Select it during kernel
+configuration as module or compile statically into the kernel.
+Compile your kernel and install the modules.
 
 Now, your osst driver is inside the kernel or available as a module,
 depending on your choice during kernel config. You may still need to create
@@ -113,7 +65,7 @@
 recognized.
 
 If you want to have the module autoloaded on access to /dev/osst, you may
-add somethind like
+add something like
 alias char-major-206 osst
 to your /etc/modules.conf (old name: conf.modules).
 
@@ -122,6 +74,9 @@
 to make programs assuming a default name of /dev/tape more convenient to
 use.
 
+The device nodes for osst have to be created. Use the Makedevs.sh script
+attached to this file.
+
 
 Using it
 --------
@@ -131,7 +86,11 @@
 symlink trick. The IOCTLs to control tape operation are also mostly
 supported and you may try the mt (or mt_st) program to jump between
 filemarks, eject the tape, ...
-There's one limitation: You need to use a blocksize of 32kB.
+
+There's one limitation: You need to use a block size of 32kB.
+
+(This limitation is worked on and will be fixed in version 0.8.7 of
+ this driver.)
 
 If you just want to get started with standard software, here is an example
 for creating and restoring a full backup:
@@ -141,11 +100,11 @@
 buffer -s 32k -m 8M -B -t -i /dev/osst0 | tar xvf - -C /
 
 The buffer command has been used to buffer the data before it goes to the
-tape (or the filesystem) in order to smooth out the data stream and prevent
+tape (or the file system) in order to smooth out the data stream and prevent
 the tape from needing to stop and rewind. The OnStream does have an internal
 buffer and a variable speed which help this, but especially on writing, the
 buffering still proves useful in most cases. It also pads the data to
-guarantees the blocksize of 32k. (Otherwise you may pass the -b64 option to
+guarantees the block size of 32k. (Otherwise you may pass the -b64 option to
 tar.)
 Expect something like 1.8MB/s for the SC-x0 drives and 0.9MB/s for the DI-30.
 The USB drive will give you about 0.7MB/s.
@@ -164,9 +123,9 @@
 http://sourceforge.net/cvs/?group_id=3581
 
 Note that the ide-tape driver as of 1.16f uses a slightly outdated on-tape
-format and therefore is not compeletely interoperable with osst tapes.
+format and therefore is not completely interoperable with osst tapes.
 
-The ADR-x0 line is fully SCSI-2 compliant and is spported by st, not osst.
+The ADR-x0 line is fully SCSI-2 compliant and is supported by st, not osst.
 The on-tape format is supposed to be compatible with the one used by osst.
 
 
@@ -183,7 +142,7 @@
 to see whether the problem is already known and solved. Otherwise, please
 report it to the mailing list. Your feedback is welcome. (This holds also
 for reports of successful usage, of course.) 
-In case of trouble, please do always provide the following infos:
+In case of trouble, please do always provide the following info:
 * driver and kernel version used (see syslog)
 * driver messages (syslog)
 * SCSI config and OnStream Firmware (/proc/scsi/scsi)
@@ -201,7 +160,7 @@
 Check the web pages for more info about the current developments.
 
 
-Acknowledgements
+Acknowledgments
 ----------------
 The driver has been started by making a copy of Kai Makisara's st driver.
 Most of the development has been done by Willem Riede. The presence of the
@@ -229,7 +188,7 @@
 #!/bin/sh
 # Script to create OnStream SC-x0 device nodes (major 206)
 # Usage: Makedevs.sh [nos [path to dev]]
-# $Id: README.osst,v 1.5.6.1 2000/10/10 13:45:37 garloff Exp $
+# $Id: README.osst.kernel,v 1.1.2.2 2000/12/20 14:08:38 garloff Exp $
 major=206
 nrs=4
 dir=/dev
diff -uNr linux-2.2.19-pre2/drivers/scsi/osst.c linux-2.2.19p2.osst/drivers/scsi/osst.c
--- linux-2.2.19-pre2/drivers/scsi/osst.c	Fri Dec 22 01:04:29 2000
+++ linux-2.2.19p2.osst/drivers/scsi/osst.c	Fri Dec 15 21:36:12 2000
@@ -16,14 +16,14 @@
   Copyright 1992 - 2000 Kai Makisara
 		 email Kai.Makisara@metla.fi
 
-  $Header: /home/cvsroot/Driver/osst.c,v 1.28.2.7 2000/10/05 00:45:52 riede Exp $
+  $Header: /home/cvsroot/Driver/osst.c,v 1.28.2.12.2.1 2000/12/15 20:36:12 garloff Exp $
 
   Last modified: Wed Feb  2 22:04:05 2000 by makisara@kai.makisara.local
   Some small formal changes - aeb, 950809
 */
 
-static const char * cvsid = "$Id: osst.c,v 1.28.2.7 2000/10/05 00:45:52 riede Exp $";
-const char * osst_version = "0.8.5";
+static const char * cvsid = "$Id: osst.c,v 1.28.2.12.2.1 2000/12/15 20:36:12 garloff Exp $";
+const char * osst_version = "0.8.6.1";
 
 /* The "failure to reconnect" firmware bug */
 #define OSST_FW_NEED_POLL_MIN 10602 /*(107A)*/
@@ -283,7 +283,8 @@
 {
   unsigned long flags;
   unsigned char *bp;
-
+//static int inject = 0; /* FIXME - take out inject occasional read errors */
+//static int repeat = 0;
   spin_lock_irqsave(&io_request_lock, flags);
   if (SCpnt == NULL)
     if ((SCpnt = scsi_allocate_device(NULL, STp->device, 1)) == NULL) {
@@ -316,6 +317,12 @@
       down(SCpnt->request.sem);
 
       (STp->buffer)->last_result_fatal = osst_chk_result(SCpnt);
+//if ((STp->buffer)->last_result_fatal == 0 &&
+//    cmd[0] == READ_6 && cmd[4] && ( /* (++ inject % 83) == 29  || */
+//     (STp->first_frame_position == 240 /* or STp->read_error_frame to fail again on the block calculated above */ && ++repeat < 3))) {
+//	printk(OSST_DEB_MSG "osst%d: injecting read error\n", TAPE_NR(STp->devt));
+//	STp->buffer->last_result_fatal = 1; /* FIXME - take out inject occasional read errors */
+//}
   }
 
   return SCpnt;
@@ -506,14 +513,16 @@
                 STps->eof = ST_FM_HIT;
 
 		i = ntohl(aux->filemark_cnt);
-		if (STp->header_cache != NULL && i < OS_FM_TAB_MAX &&
-		    STp->first_frame_position - 1 != ntohl(STp->header_cache->dat_fm_tab.fm_tab_ent[i])) {
+		if (STp->header_cache != NULL && i < OS_FM_TAB_MAX && (i > STp->filemark_cnt ||
+		    STp->first_frame_position - 1 != ntohl(STp->header_cache->dat_fm_tab.fm_tab_ent[i]))) {
 #if 1 //DEBUG
 			printk(OSST_DEB_MSG "osst%i: %s filemark %d at frame %d\n", dev,
 				  STp->header_cache->dat_fm_tab.fm_tab_ent[i] == 0?"Learned":"Corrected",
 				  i, STp->first_frame_position - 1);
 #endif
 			STp->header_cache->dat_fm_tab.fm_tab_ent[i] = htonl(STp->first_frame_position - 1);
+			if (i >= STp->filemark_cnt)
+				 STp->filemark_cnt = i+1;
 		}
         }
         if (aux->frame_type == OS_FRAME_TYPE_EOD) {
@@ -623,7 +632,32 @@
 	STp->ps[STp->partition].rw = ST_IDLE;
 	return (result);
 }
+/*
+static int osst_buffer_stats[64];
+
+static void osst_build_stats(OS_Scsi_Tape * STp, Scsi_Cmnd ** aSCpnt)
+{
+	unsigned int i;
+
+	osst_get_frame_position (STp, aSCpnt);
+	i = STp->cur_frames > 63 ? 63 : STp->cur_frames;
+	osst_buffer_stats[i]++;
+}
 
+static void osst_report_stats()
+{
+	unsigned int i;
+
+	for (i=0; i<64; i+=8) {
+		printk(OSST_DEB_MSG "osst buffer stats %2d: %5d %5d %5d %5d %5d %5d %5d %5d\n", i,
+			osst_buffer_stats[i  ], osst_buffer_stats[i+1],
+		       	osst_buffer_stats[i+2], osst_buffer_stats[i+3], 
+			osst_buffer_stats[i+4], osst_buffer_stats[i+5],
+		       	osst_buffer_stats[i+6], osst_buffer_stats[i+7]);
+	}
+
+}
+*/
 #define OSST_POLL_PER_SEC 10
 static int osst_wait_frame(OS_Scsi_Tape * STp, Scsi_Cmnd ** aSCpnt, int curr, int minlast, int to)
 {
@@ -632,7 +666,7 @@
 #if DEBUG
 	char    notyetprinted = 1;
 #endif
-	if (STp->ps[STp->partition].rw != ST_READING)
+	if (minlast >= 0 && STp->ps[STp->partition].rw != ST_READING)
 		printk(KERN_ERR "osst%i: waiting for frame without having initialized read!\n", dev);
 
 	while (time_before (jiffies, startwait + to*HZ))
@@ -640,7 +674,8 @@
 		int result;
 		result = osst_get_frame_position (STp, aSCpnt);
 		if (result == -EIO)
-			result = osst_write_error_recovery(STp, aSCpnt, 0);
+			if ((result = osst_write_error_recovery(STp, aSCpnt, 0)) == 0)
+				return 0;	/* successfull recovery leaves drive ready for frame */
 		if (result < 0) break;
 		if (STp->first_frame_position == curr &&
 		    ((minlast < 0 &&
@@ -715,6 +750,10 @@
 
 	if ((STp->buffer)->last_result_fatal) {
 	    retval = 1;
+	    if (STp->read_error_frame == 0) {
+		STp->read_error_frame = STp->first_frame_position;
+		printk(OSST_DEB_MSG "osst: recording read error at %d\n", STp->read_error_frame);/*FIXME*/
+	    }
 #if DEBUG
 	    if (debugging)
 	        printk(OSST_DEB_MSG "osst%d: Sense: %2x %2x %2x %2x %2x %2x %2x %2x\n",
@@ -786,6 +825,8 @@
 	ST_partstat * STps  = &(STp->ps[STp->partition]);
 	int           dev   = TAPE_NR(STp->devt);
         int           cnt   = 0,
+		      bad   = 0,
+		      past  = 0,
 		      x,
 		      position;
 
@@ -793,9 +834,17 @@
          * Search and wait for the next logical tape block
          */
         while (1) {
-                if (cnt++ > 200) {
+                if (cnt++ > 400) {
                         printk(KERN_WARNING "osst%d: Couldn't find logical block %d, aborting\n",
 					    dev, logical_blk_num);
+			if (STp->read_error_frame) {
+				osst_set_frame_position(STp, aSCpnt, STp->read_error_frame, 0);
+#if 1 //DEBUG
+                        	printk(OSST_DEB_MSG "osst%d: Repositioning tape to bad block %d\n",
+						 dev, STp->read_error_frame);
+#endif
+				STp->read_error_frame = 0;
+			}
                         return (-EIO);
                 }
 #if DEBUG
@@ -808,12 +857,16 @@
                         position = osst_get_frame_position(STp, aSCpnt);
 			if (position >= 0xbae && position < 0xbb8)
 				position = 0xbb8;
+			else if (position > STp->eod_frame_ppos || ++bad == 10) {
+printk(OSST_DEB_MSG "osst%d: start again from pos %d, eod %d, bad %d\n", dev, position, STp->eod_frame_ppos, bad); /*FIXME*/
+				position = STp->read_error_frame - 1;
+			}
 			else {
 				position += 39;
-                        	cnt += 30;
+                        	cnt += 20;
 			}
-#if DEBUG
-                        printk(OSST_DEB_MSG "osst%d: Blank block detected, positioning tape to block %d\n",
+#if 1 //DEBUG
+                        printk(OSST_DEB_MSG "osst%d: Bad block detected, positioning tape to block %d\n",
 					 dev, position);
 #endif
                         osst_set_frame_position(STp, aSCpnt, position, 0);
@@ -829,18 +882,28 @@
 					  dev, x, logical_blk_num);
 #endif
 				STp->header_ok = 0;
+				STp->read_error_frame = 0;
 				return (-EIO);
 			}
                         if (x > logical_blk_num) {
-#if DEBUG
+				if (++past > 3) {
+					/* positioning backwards did not bring us to the desired block */
+					position = STp->read_error_frame - 1;
+				}
+				else
+			        	position = osst_get_frame_position(STp, aSCpnt)
+					         + logical_blk_num - x - 1;
+#if 1 //DEBUG
                                 printk(OSST_DEB_MSG
 				       "osst%d: Found logical block %d while looking for %d: back up %d\n",
-						dev, x, logical_blk_num, x - logical_blk_num + 1);
+						dev, x, logical_blk_num,
+					       	STp->first_frame_position - position);
 #endif
-			        position = osst_get_frame_position(STp, aSCpnt);
-                        	osst_set_frame_position(STp, aSCpnt, position + logical_blk_num - x - 1, 0);
+                        	osst_set_frame_position(STp, aSCpnt, position, 0);
                         	cnt += 10;
                         }
+			else
+				past = 0;
                 }
                 if (osst_get_frame_position(STp, aSCpnt) == 0xbaf) {
 #if DEBUG
@@ -862,6 +925,7 @@
 		printk(OSST_DEB_MSG "osst%i: Exit get logical block (%d=>%d) from OnStream tape with code %d\n",							 dev, logical_blk_num, STp->logical_blk_num, STps->eof);
 #endif
 	STp->fast_open = FALSE;
+	STp->read_error_frame = 0;
         return (STps->eof);
 }
 
@@ -920,7 +984,7 @@
 	STp->logical_blk_in_buffer = 0;
 	STps->drv_file  = htonl(STp->buffer->aux->filemark_cnt);
 	STps->drv_block = -1;
-	STps->eof       = ST_NOEOF;
+	STps->eof       = ST_NOEOF; /* FIXME test for eod */
 	return 0;
 }
 
@@ -1097,7 +1161,7 @@
 			     (SCpnt->sense_buffer[5] <<  8) |
 			      SCpnt->sense_buffer[6]        ) - new_block;
 			p = &buffer[i * OS_DATA_SIZE];
-#if 1 //DEBUG
+#if DEBUG
 			printk(OSST_DEB_MSG "osst%d: Additional write error at %d\n", dev, new_block+i);
 #endif
 			osst_get_frame_position(STp, aSCpnt);
@@ -1132,7 +1196,7 @@
 #endif
 			if (block < 2990 && block+skip+STp->cur_frames+pending >= 2990)
 				block = 3000-skip;
-#if 1 //DEBUG
+#if DEBUG
 			printk(OSST_DEB_MSG "osst%d: Position to frame %d, re-write from lblk %d\n",
 					  dev, block+skip, STp->logical_blk_num-STp->cur_frames-pending);
 #endif
@@ -1141,7 +1205,7 @@
 			attempts--;
 		}
 		if (osst_get_frame_position(STp, aSCpnt) < 0) {		/* additional write error */
-#if 1 //DEBUG
+#if DEBUG
 			printk(OSST_DEB_MSG "osst%d: Addl error, host %d, tape %d, buffer %d\n",
 					  dev, STp->first_frame_position,
 					  STp->last_frame_position, STp->cur_frames);
@@ -1156,7 +1220,7 @@
 			cmd[0] = WRITE_6;
 			cmd[1] = 1;
 			cmd[4] = 1;
-#if 1 //DEBUG
+#if DEBUG
 			printk(OSST_DEB_MSG "osst%d: About to write pending lblk %d at frame %d\n",
 					  dev, STp->logical_blk_num-1, STp->first_frame_position);
 #endif
@@ -1221,7 +1285,7 @@
 	if ((SCpnt->sense_buffer[ 2] & 0x0f) != 3
 	  || SCpnt->sense_buffer[12]         != 12
 	  || SCpnt->sense_buffer[13]         != 0) {
-#if 1 //DEBUG
+#if DEBUG
 		printk(OSST_DEB_MSG "osst%d: Write error recovery cannot handle %02x:%02x:%02x\n",
 			dev, SCpnt->sense_buffer[ 2], SCpnt->sense_buffer[12], SCpnt->sense_buffer[13]);
 #endif
@@ -1233,11 +1297,11 @@
 		 SCpnt->sense_buffer[6];
 	skip  =  SCpnt->sense_buffer[9];
  
-#if 1 //DEBUG
+#if DEBUG
 	printk(OSST_DEB_MSG "osst%d: Detected physical bad block at %u, advised to skip %d\n", dev, block, skip);
 #endif
 	osst_get_frame_position(STp, aSCpnt);
-#if 1 //DEBUG
+#if DEBUG
 	printk(OSST_DEB_MSG "osst%d: reported frame positions: host = %d, tape = %d\n",
 			dev, STp->first_frame_position, STp->last_frame_position);
 #endif
@@ -1266,7 +1330,7 @@
 		osst_set_frame_position(STp, aSCpnt, block + STp->cur_frames + pending, 0);
 	}
 	osst_get_frame_position(STp, aSCpnt);
-#if 1 //DEBUG
+#if DEBUG
 	printk(KERN_ERR "osst%d: Positioning complete, cur_frames %d, pos %d, tape pos %d\n", 
 			dev, STp->cur_frames, STp->first_frame_position, STp->last_frame_position);
 	printk(OSST_DEB_MSG "osst%d: next logical block to write: %d\n", dev, STp->logical_blk_num);
@@ -1389,6 +1453,13 @@
 #if DEBUG
 			printk(OSST_DEB_MSG "osst%i: space_fwd: EOD reached\n", dev);
 #endif
+			if (STp->first_frame_position > STp->eod_frame_ppos+1) {
+#if DEBUG
+				printk(OSST_DEB_MSG "osst%i: EOD position corrected (%d=>%d)\n",
+					       	dev, STp->eod_frame_ppos, STp->first_frame_position-1);
+#endif
+				STp->eod_frame_ppos = STp->first_frame_position-1;
+			}
 			return (-EIO);
 		}
 		if (cnt == mt_count)
@@ -1457,6 +1528,12 @@
 						 dev, next_mark_ppos);
 				return (-EIO);
 			}
+			if (ntohl(STp->buffer->aux->filemark_cnt) != cnt + mt_count) {
+				printk(KERN_INFO "osst%i: Expected to find marker %d at block %d, not %d\n",
+						 dev, cnt+mt_count, next_mark_ppos,
+						 ntohl(STp->buffer->aux->filemark_cnt));
+				return (-EIO);
+			}
 		}
 	} else {
 		/*
@@ -1634,6 +1711,7 @@
 	STp->dirty = 1;
 	result  = osst_flush_write_buffer(STp, aSCpnt, 0);
 	result |= osst_flush_drive_buffer(STp, aSCpnt);
+//printk(OSST_DEB_MSG "osst%d: Finished writing file\n",TAPE_NR(STp->devt));
 	STp->last_mark_ppos = this_mark_ppos;
 	if (STp->header_cache != NULL && STp->filemark_cnt < OS_FM_TAB_MAX) 
 		STp->header_cache->dat_fm_tab.fm_tab_ent[STp->filemark_cnt] = htonl(this_mark_ppos);
@@ -2032,7 +2110,7 @@
 #endif
 	osst_set_frame_position(STp, aSCpnt, frame_position - 1, 0);
 	if (osst_get_logical_blk(STp, aSCpnt, -1, 0) < 0) {
-#if 1 //DEBUG
+#if DEBUG
 		printk(OSST_DEB_MSG "osst%i: Couldn't get logical blk num in verify_position\n", dev);
 #endif
 		return (-EIO);
@@ -2327,10 +2405,14 @@
     else {
 
       if (result == -EIO) {	/* re-read position */
+	unsigned char mysense[16];
+	memcpy (mysense, SCpnt->sense_buffer, 16);
 	memset (scmd, 0, MAX_COMMAND_SIZE);
 	scmd[0] = READ_POSITION;
 	STp->buffer->b_data = mybuf; STp->buffer->buffer_size = 24;
 	SCpnt = osst_do_scsi(SCpnt, STp, scmd, 20, STp->timeout, MAX_READY_RETRIES, TRUE);
+	if (!STp->buffer->last_result_fatal)
+	   memcpy (SCpnt->sense_buffer, mysense, 16);
       }
       STp->first_frame_position = ((STp->buffer)->b_data[4] << 24)
 				+ ((STp->buffer)->b_data[5] << 16)
@@ -2478,7 +2560,7 @@
     /* TODO: Error handling! */
     if (STp->poll)
 	result = osst_wait_frame (STp, aSCpnt, STp->first_frame_position, -50, 120);
-
+//osst_build_stats(STp, aSCpnt);
     memset(cmd, 0, MAX_COMMAND_SIZE);
     cmd[0] = WRITE_6;
     cmd[1] = 1;
@@ -2682,7 +2764,9 @@
       STps->rw = ST_IDLE;
     }
     else if (STps->rw != ST_WRITING) {
-      if (!STp->header_ok || (STps->drv_file == 0 && STps->drv_block == 0)) {
+      /* Are we totally rewriting this tape? */
+      if (!STp->header_ok || STp->first_frame_position == STp->first_data_ppos ||
+		            (STps->drv_file == 0 && STps->drv_block == 0)) {
 	STp->wrt_pass_cntr++;
 #if DEBUG
 	printk(OSST_DEB_MSG "osst%d: Allocating next write pass counter: %d\n",
@@ -2690,11 +2774,39 @@
 #endif
 	osst_reset_header(STp, &SCpnt);
 	STps->drv_file = STps->drv_block = STp->logical_blk_num = 0;
-      } else if (STp->fast_open && osst_verify_position(STp, &SCpnt)) {
-	if (SCpnt) scsi_release_command(SCpnt);
-	return (-EIO);
+      }
+      /* Do we know where we'll be writing on the tape? */
+      else {
+	if ((STp->fast_open && osst_verify_position(STp, &SCpnt)) ||
+		STps->drv_file < 0 || STps->drv_block < 0) {
+	  if (STp->first_frame_position == STp->eod_frame_ppos) {
+	    STps->drv_file = STp->filemark_cnt;
+	    STps->drv_block = 0;
+	  }
+	  else {
+	    /* We have no idea where the tape is positioned - give up */
+#if DEBUG
+	    printk(OSST_DEB_MSG "osst%d: Cannot write at indeterminate position.\n", dev);
+#endif
+	    if (SCpnt) scsi_release_command(SCpnt);
+	    return (-EIO);
+	  }
+	}	  
+	if (STps->drv_file > 0 && STps->drv_file < STp->filemark_cnt) {
+	  STp->filemark_cnt = STps->drv_file;
+	  STp->last_mark_ppos = ntohl(STp->header_cache->dat_fm_tab.fm_tab_ent[STp->filemark_cnt-1]);
+	  printk(KERN_WARNING "osst%d: Overwriting file %d with old write pass counter %d\n",
+		      dev, STps->drv_file, STp->wrt_pass_cntr);
+	  printk(KERN_WARNING "osst%d: may lead to stale data being accepted on reading back!\n",
+		      dev);
+#if DEBUG
+	  printk(OSST_DEB_MSG "osst%d: resetting filemark count to %d and last mark ppos to %d\n",
+		dev, STp->filemark_cnt, STp->last_mark_ppos);
+#endif
+	}
       }
       STp->fast_open = FALSE;
+//printk(OSST_DEB_MSG "osst%d: Starting write next file\n",dev);
     }
     if (!STp->header_ok) {
 #if DEBUG
@@ -2761,7 +2873,7 @@
     if (STp->poll)
 	retval = osst_wait_frame (STp, &SCpnt, STp->first_frame_position, -50, 60);
     /* TODO: Check for an error ! */
-	
+//osst_build_stats(STp, &SCpnt);	
     memset(cmd, 0, MAX_COMMAND_SIZE);
     cmd[0] = WRITE_6;
     cmd[1] = 1;
@@ -3063,16 +3175,16 @@
     /* Change the eof state if no data from tape or buffer */
     if (total == 0) {
 	if (STps->eof == ST_FM_HIT) {
-	    STps->eof = ST_FM;
+	    STps->eof = (STp->first_frame_position >= STp->eod_frame_ppos)?ST_EOD:ST_FM;
 	    STps->drv_block = 0;
 	    if (STps->drv_file >= 0)
 		STps->drv_file++;
 	}
 	else if (STps->eof == ST_EOD_1) {
 	    STps->eof = ST_EOD_2;
-	    STps->drv_block = 0;
-	    if (STps->drv_file >= 0)
+	    if (STps->drv_block > 0 && STps->drv_file >= 0)
 		STps->drv_file++;
+	    STps->drv_block = 0;
 	}
 	else if (STps->eof == ST_EOD_2)
 	    STps->eof = ST_EOD;
@@ -3269,7 +3381,7 @@
    unsigned char cmd[MAX_COMMAND_SIZE];
    Scsi_Cmnd * SCpnt = *aSCpnt;
    ST_partstat * STps;
-   int fileno, blkno, at_sm, undone, datalen;
+   int fileno, blkno, at_sm, datalen;
    int logical_blk_num;
    int dev = TAPE_NR(STp->devt);
 
@@ -3460,10 +3572,17 @@
 	   printk(OSST_DEB_MSG "osst%d: Spacing to end of recorded medium.\n", dev);
 #endif
 	osst_set_frame_position(STp, &SCpnt, STp->eod_frame_ppos, 0);
-	if (osst_get_logical_blk(STp, &SCpnt, -1, 0) < 0)
-	   return (-EIO);
-	if (STp->buffer->aux->frame_type != OS_FRAME_TYPE_EOD)
-	   return (-EIO);
+	if (osst_get_logical_blk(STp, &SCpnt, -1, 0) < 0) {
+	   ioctl_result = -EIO;
+	   goto os_bypass;
+	}
+	if (STp->buffer->aux->frame_type != OS_FRAME_TYPE_EOD) {
+#if DEBUG
+	   printk(OSST_DEB_MSG "osst%d: No EOD frame found where expected.\n", dev);
+#endif
+     	   ioctl_result = -EIO;
+	   goto os_bypass;
+	}
 	ioctl_result = osst_set_frame_position(STp, &SCpnt, STp->eod_frame_ppos, 0);
 	logical_blk_num = STp->logical_blk_num;
 	fileno          = STp->filemark_cnt;
@@ -3571,7 +3690,7 @@
       if (cmd_in == MTEOM)
          STps->eof = ST_EOD;
       else if (cmd_in == MTFSF)
-         STps->eof = ST_FM;
+	 STps->eof = (STp->first_frame_position >= STp->eod_frame_ppos)?ST_EOD:ST_FM;
       else if (chg_eof)
          STps->eof = ST_NOEOF;
 
@@ -3592,80 +3711,33 @@
             ioctl_result = 0;
       }
 
+   } else if (cmd_in == MTBSF || cmd_in == MTBSFM ) {
+      if (osst_position_tape_and_confirm(STp, &SCpnt, STp->first_data_ppos) < 0)
+	  STps->drv_file = STps->drv_block = -1;
+      else
+	  STps->drv_file = STps->drv_block = 0;
+      STps->eof = ST_NOEOF;
+   } else if (cmd_in == MTFSF || cmd_in == MTFSFM) {
+      if (osst_position_tape_and_confirm(STp, &SCpnt, STp->eod_frame_ppos) < 0)
+	  STps->drv_file = STps->drv_block = -1;
+      else {
+	  STps->drv_file  = STp->filemark_cnt;
+	  STps->drv_block = 0;
+      }
+      STps->eof = ST_EOD;
+   } else if (cmd_in == MTBSR || cmd_in == MTFSR || cmd_in == MTWEOF || cmd_in == MTEOM) {
+      STps->drv_file = STps->drv_block = (-1);
+      STps->eof = ST_NOEOF;
+      STp->header_ok = 0;
+   } else if (cmd_in == MTERASE) {
+      STp->header_ok = 0;
    } else if (SCpnt) {  /* SCSI command was not completely successful. */
       if (SCpnt->sense_buffer[2] & 0x40) {
-         if (cmd_in != MTBSF && cmd_in != MTBSFM &&
-	    cmd_in != MTBSR && cmd_in != MTBSS)
-	    STps->eof = ST_EOM_OK;
+	 STps->eof = ST_EOM_OK;
 	 STps->drv_block = 0;
       }
-
-      undone = (
-	  (SCpnt->sense_buffer[3] << 24) +
-	  (SCpnt->sense_buffer[4] << 16) +
-	  (SCpnt->sense_buffer[5] << 8) +
-	  SCpnt->sense_buffer[6] );
-      if (cmd_in == MTWEOF &&
-	 (SCpnt->sense_buffer[0] & 0x70) == 0x70 &&
-	 (SCpnt->sense_buffer[2] & 0x4f) == 0x40 &&
-	 ((SCpnt->sense_buffer[0] & 0x80) == 0 || undone == 0)) {
-	    ioctl_result = 0;  /* EOF written succesfully at EOM */
-	    if (fileno >= 0)
-		fileno++;
-	    STps->drv_file = fileno;
-	    STps->eof = ST_NOEOF;
-      }
-      else if ( (cmd_in == MTFSF) || (cmd_in == MTFSFM) ) {
-         if (fileno >= 0)
-	    STps->drv_file = fileno - undone ;
-	 else
-	    STps->drv_file = fileno;
-       STps->drv_block = 0;
-       STps->eof = ST_NOEOF;
-     }
-     else if ( (cmd_in == MTBSF) || (cmd_in == MTBSFM) ) {
-       if (fileno >= 0)
-         STps->drv_file = fileno + undone ;
-       else
-	 STps->drv_file = fileno;
-       STps->drv_block = 0;
-       STps->eof = ST_NOEOF;
-     }
-     else if (cmd_in == MTFSR) {
-       if (SCpnt->sense_buffer[2] & 0x80) { /* Hit filemark */
-	 if (STps->drv_file >= 0)
-	   STps->drv_file++;
-	 STps->drv_block = 0;
-	 STps->eof = ST_FM;
-       }
-       else {
-	 if (blkno >= undone)
-	   STps->drv_block = blkno - undone;
-	 else
-	   STps->drv_block = (-1);
-	 STps->eof = ST_NOEOF;
-       }
-     }
-     else if (cmd_in == MTBSR) {
-       if (SCpnt->sense_buffer[2] & 0x80) { /* Hit filemark */
-	 STps->drv_file--;
-	 STps->drv_block = (-1);
-       }
-       else {
-	 if (blkno >= 0)
-	   STps->drv_block = blkno + undone;
-	 else
-	   STps->drv_block = (-1);
-       }
-       STps->eof = ST_NOEOF;
-     }
-     else if (cmd_in == MTEOM) {
-       STps->drv_file = (-1);
-       STps->drv_block = (-1);
-       STps->eof = ST_EOD;
-     }
-     else if (chg_eof)
-       STps->eof = ST_NOEOF;
+      if (chg_eof)
+         STps->eof = ST_NOEOF;
 
       if ((SCpnt->sense_buffer[2] & 0x0f) == BLANK_CHECK)
 	 STps->eof = ST_EOD;
@@ -4104,7 +4176,7 @@
       if (STps->drv_file >= 0)
 	STps->drv_file++ ;
       STps->drv_block = 0;
-
+//osst_report_stats();
       result = osst_write_eod(STp, &SCpnt);
       osst_write_header(STp, &SCpnt, !(STp->rew_at_close));
 
diff -uNr linux-2.2.19-pre2/drivers/scsi/osst.h linux-2.2.19p2.osst/drivers/scsi/osst.h
--- linux-2.2.19-pre2/drivers/scsi/osst.h	Fri Dec 22 01:04:29 2000
+++ linux-2.2.19p2.osst/drivers/scsi/osst.h	Fri Dec 15 21:28:11 2000
@@ -1,5 +1,5 @@
 /*
- *	$Header: /home/cvsroot/Driver/osst.h,v 1.5.2.1 2000/09/24 14:26:02 riede Exp $
+ *	$Header: /home/cvsroot/Driver/osst.h,v 1.5.2.2 2000/10/08 03:07:33 riede Exp $
  */
 
 #include <linux/config.h>
@@ -489,6 +489,7 @@
   int      eod_frame_ppos;
   int      eod_frame_lfa;
   int      write_type;				/* used in write error recovery */
+  int      read_error_frame;			/* used in read error recovery */
   unsigned long cmd_start_time;
   unsigned long max_cmd_time;
 

--PpAOPzA3dXsRhoo+--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
