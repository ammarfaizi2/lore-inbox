Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264809AbTGKSpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbTGKSV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:21:57 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13700
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264891AbTGKR7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:59:10 -0400
Date: Fri, 11 Jul 2003 19:12:56 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111812.h6BICuJj017326@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix security leaks and a crash in es1370
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/es1370.c linux-2.5.75-ac1/sound/oss/es1370.c
--- linux-2.5.75/sound/oss/es1370.c	2003-07-10 21:15:34.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/es1370.c	2003-07-11 17:10:35.000000000 +0100
@@ -889,8 +889,8 @@
 	}
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strlcpy(info.id, "ES1370", sizeof(info.id));
-		strlcpy(info.name, "Ensoniq ES1370", sizeof(info.name));
+		strncpy(info.id, "ES1370", sizeof(info.id));
+		strncpy(info.name, "Ensoniq ES1370", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -898,8 +898,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strlcpy(info.id, "ES1370", sizeof(info.id));
-		strlcpy(info.name, "Ensoniq ES1370", sizeof(info.name));
+		strncpy(info.id, "ES1370", sizeof(info.id));
+		strncpy(info.name, "Ensoniq ES1370", sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
@@ -2484,12 +2484,8 @@
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
 				DBG(printk(KERN_DEBUG "es1370: midi timed out??\n");)
