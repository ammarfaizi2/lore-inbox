Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbQKLDBp>; Sat, 11 Nov 2000 22:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbQKLDBg>; Sat, 11 Nov 2000 22:01:36 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:55814 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129466AbQKLDBX>; Sat, 11 Nov 2000 22:01:23 -0500
Date: Sat, 11 Nov 2000 21:55:35 -0500
Message-Id: <200011120255.eAC2tZI19943@risacher.yi.org>
From: Daniel R Risacher <magnus@alum.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CDROMPLAYTRKIND translation in sr_ioctl.c for idescsi 
Reply-to: magnus@alum.mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:

Many audio-cdrom-playing programs don't work correctly with ATAPI
CDROM drives under ide-scsi translation, because ATAPI doesn't support
the PLAYAUDIO_TI command. The ide-cd driver handles this by
transforming CDROMPLAYTRKIND ioctls into something that the ATAPI
drive will understand, but this mechanism is bypassed when using
ide-scsi translation.

This patch creates a new kernel option,
CONFIG_SCSI_IDESCSI_WORKAROUND, that is available whenever ide-scsi
translation is enabled. Enabling this new option includes a
tranlation mechanism into the SCSI CDROM (sr) driver similar to the
mechanism in the ide-cd driver.

Hopefully this will make life much easier for those of us who use
ide-scsi for CDROM drives. It is essentially the same thing as the
patch I posted for 2.2.12 on 19 Oct 1999, but updated for 2.4.0-test9.
This probably isn't the most elegant solution, but maybe it'll help
some people out until Jens figures out something better.

Daniel Risacher


--- linux/Documentation/Configure.help.old	Fri Sep 22 20:11:37 2000
+++ linux/Documentation/Configure.help	Sat Nov 11 19:02:05 2000
@@ -588,6 +588,20 @@
 
   If unsure, say N.
 
+IDE-SCSI workaround 
+CONFIG_SCSI_IDESCSI_WORKAROUND
+
+  This will enable the SCSI CDROM driver to work around a limitation of
+  the ATAPI specification.  The ATAPI spec does not support the
+  play-track-index command, which means that many programs that play
+  audio CD's will not work correctly when using SCSI emulation.  
+
+  With this option, the SCSI CDROM driver translates play-track-index
+  commands into play-minute-second-frame commands, in a way similar to
+  the IDE CDROM driver.
+
+  If unsure, say Y.
+
 CMD640 chipset bugfix/support
 CONFIG_BLK_DEV_CMD640
   The CMD-Technologies CMD640 IDE chip is used on many common 486 and
--- linux/drivers/ide/Config.in.old	Sat Nov 11 21:35:01 2000
+++ linux/drivers/ide/Config.in	Sat Nov 11 19:56:31 2000
@@ -31,6 +31,9 @@
    dep_tristate '  Include IDE/ATAPI TAPE support' CONFIG_BLK_DEV_IDETAPE $CONFIG_BLK_DEV_IDE
    dep_tristate '  Include IDE/ATAPI FLOPPY support' CONFIG_BLK_DEV_IDEFLOPPY $CONFIG_BLK_DEV_IDE
    dep_tristate '  SCSI emulation support' CONFIG_BLK_DEV_IDESCSI $CONFIG_BLK_DEV_IDE $CONFIG_SCSI
+  if [ "$CONFIG_BLK_DEV_IDESCSI" != "n" ]; then
+    bool '     Enable IDE-SCSI workaround in SCSI CDROM driver' CONFIG_SCSI_IDESCSI_WORKAROUND
+  fi
 
    comment 'IDE chipset support/bugfixes'
    if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
--- linux/drivers/scsi/sr_ioctl.c.old	Sat Nov 11 19:48:17 2000
+++ linux/drivers/scsi/sr_ioctl.c	Sat Nov 11 21:25:46 2000
@@ -1,3 +1,4 @@
+#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -30,6 +31,53 @@
 /* In fact, it is very slow if it has to spin up first */
 #define IOCTL_TIMEOUT 30*HZ
 
+#ifdef CONFIG_SCSI_IDESCSI_WORKAROUND
+/* ATAPI drives don't have a SCMD_PLAYAUDIO_TI command.  When these drives
+   are emulating a SCSI device via the idescsi module, they need to have
+   CDROMPLAYTRKIND commands translated into CDROMPLAYMSF commands for them */
+
+static int
+sr_fake_playtrkind(struct cdrom_device_info *cdi, unsigned int cmd, void* arg)
+{
+    struct cdrom_ti* ti = (struct cdrom_ti*)arg;
+    u_char sr_cmd[10];
+    struct cdrom_tocentry trk0_te, trk1_te;
+    int ntracks;
+    struct cdrom_tochdr tochdr;
+    sr_audio_ioctl(cdi, CDROMREADTOCHDR, &tochdr);
+    ntracks = tochdr.cdth_trk1 - tochdr.cdth_trk0 + 1;
+
+    if (ti->cdti_trk1 == ntracks) 
+        ti->cdti_trk1 = CDROM_LEADOUT;
+    else 
+        ti->cdti_trk1 ++;
+
+    trk0_te.cdte_track = ti->cdti_trk0;
+    trk0_te.cdte_format = CDROM_MSF;
+    trk1_te.cdte_track = ti->cdti_trk1;
+    trk1_te.cdte_format = CDROM_MSF;
+
+    sr_audio_ioctl(cdi, CDROMREADTOCENTRY, &trk0_te);
+    sr_audio_ioctl(cdi, CDROMREADTOCENTRY, &trk1_te);
+
+    sr_cmd[0] = GPCMD_PLAY_AUDIO_MSF;
+    sr_cmd[3] = trk0_te.cdte_addr.msf.minute;
+    sr_cmd[4] = trk0_te.cdte_addr.msf.second;
+    sr_cmd[5] = trk0_te.cdte_addr.msf.frame;
+    sr_cmd[6] = trk1_te.cdte_addr.msf.minute;
+    sr_cmd[7] = trk1_te.cdte_addr.msf.second;
+    sr_cmd[8] = trk1_te.cdte_addr.msf.frame;
+    printk ("Playing MSF %d %d %d to %d %d %d\n",
+            sr_cmd[3],
+            sr_cmd[4],
+            sr_cmd[5],
+            sr_cmd[6],
+            sr_cmd[7],
+            sr_cmd[8]);
+    return sr_do_ioctl(MINOR(cdi->dev), sr_cmd, NULL, 0, 0, SCSI_DATA_NONE);
+}
+#endif
+
 /* We do our own retries because we want to know what the specific
    error code is.  Normally the UNIT_ATTENTION code will automatically
    clear after one error */
@@ -332,6 +380,9 @@
 		}
 
 	case CDROMPLAYTRKIND: {
+#ifdef CONFIG_SCSI_IDESCSI_WORKAROUND
+		result = sr_fake_playtrkind(cdi, cmd, arg);
+#else
 		struct cdrom_ti* ti = (struct cdrom_ti*)arg;
 
 		sr_cmd[0] = GPCMD_PLAYAUDIO_TI;
@@ -342,9 +393,9 @@
 		sr_cmd[8] = ti->cdti_ind1;
 
 		result = sr_do_ioctl(target, sr_cmd, NULL, 255, 0, SCSI_DATA_NONE);
+#endif
 		break;
 	}
 	default:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
