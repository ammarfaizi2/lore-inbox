Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTGKSVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbTGKSVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:21:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15236
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264905AbTGKSAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:00:00 -0400
Date: Fri, 11 Jul 2003 19:13:48 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111813.h6BIDmOB017338@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix security leak and crash in esssolo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/esssolo1.c linux-2.5.75-ac1/sound/oss/esssolo1.c
--- linux-2.5.75/sound/oss/esssolo1.c	2003-07-10 21:05:26.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/esssolo1.c	2003-07-11 16:37:47.000000000 +0100
@@ -721,8 +721,8 @@
 	}
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strlcpy(info.id, "Solo1", sizeof(info.id));
-		strlcpy(info.name, "ESS Solo1", sizeof(info.name));
+		strncpy(info.id, "Solo1", sizeof(info.id));
+		strncpy(info.name, "ESS Solo1", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -730,8 +730,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strlcpy(info.id, "Solo1", sizeof(info.id));
-		strlcpy(info.name, "ESS Solo1", sizeof(info.name));
+		strncpy(info.id, "Solo1", sizeof(info.id));
+		strncpy(info.name, "ESS Solo1", sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
@@ -1972,12 +1972,8 @@
 				break;
 			if (signal_pending(current))
 				break;
-			if (file->f_flags & O_NONBLOCK) {
-				remove_wait_queue(&s->midi.owait, &wait);
-				set_current_state(TASK_RUNNING);
-				unlock_kernel();
-				return -EBUSY;
-			}
+			if (file->f_flags & O_NONBLOCK)
+				break;
 			tmo = (count * HZ) / 3100;
 			if (!schedule_timeout(tmo ? : 1) && tmo)
 				printk(KERN_DEBUG "solo1: midi timed out??\n");
