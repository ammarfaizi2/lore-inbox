Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319353AbSH2VvJ>; Thu, 29 Aug 2002 17:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319370AbSH2VvC>; Thu, 29 Aug 2002 17:51:02 -0400
Received: from smtpout.mac.com ([204.179.120.88]:26359 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319353AbSH2Vtm>;
	Thu, 29 Aug 2002 17:49:42 -0400
Message-Id: <200208292154.g7TLs5ZH003520@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 6/41 sound/oss/pss.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/pss.c	Fri Aug  9 23:57:46 2002
+++ linux-2.5-cli-oss/sound/oss/pss.c	Wed Aug 14 23:22:40 2002
@@ -60,6 +60,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
 
 #include "sound_config.h"
 #include "sound_firmware.h"
@@ -142,6 +143,7 @@
   
 static pss_confdata pss_data;
 static pss_confdata *devc = &pss_data;
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 
 static int      pss_initialized = 0;
 static int      nonstandard_microcode = 0;
@@ -838,18 +840,17 @@
 				return -EFAULT;
 			}
 			data = (unsigned short *)(mbuf->data);
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock, flags);
 			for (i = 0; i < mbuf->len; i++) {
 				if (!pss_put_dspword(devc, *data++)) {
-					restore_flags(flags);
+					spin_unlock_irqrestore(&lock,flags);
 					mbuf->len = i;	/* feed back number of WORDs sent */
 					err = copy_to_user(arg, mbuf, sizeof(copr_msg));
 					vfree(mbuf);
 					return err ? -EFAULT : -EIO;
 				}
 			}
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
 			vfree(mbuf);
 			return 0;
 
@@ -859,8 +860,7 @@
 			if (mbuf == NULL)
 				return -ENOSPC;
 			data = (unsigned short *)mbuf->data;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock, flags);
 			for (i = 0; i < sizeof(mbuf->data)/sizeof(unsigned short); i++) {
 				mbuf->len = i;	/* feed back number of WORDs read */
 				if (!pss_get_dspword(devc, data++)) {
@@ -869,7 +869,7 @@
 					break;
 				}
 			}
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
 			if (copy_to_user(arg, mbuf, sizeof(copr_msg)))
 				err = -EFAULT;
 			vfree(mbuf);
@@ -878,22 +878,21 @@
 		case SNDCTL_COPR_RDATA:
 			if (copy_from_user(&dbuf, arg, sizeof(dbuf)))
 				return -EFAULT;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock, flags);
 			if (!pss_put_dspword(devc, 0x00d0)) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			if (!pss_put_dspword(devc, (unsigned short)(dbuf.parm1 & 0xffff))) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			if (!pss_get_dspword(devc, &tmp)) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			dbuf.parm1 = tmp;
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
 			if (copy_to_user(arg, &dbuf, sizeof(dbuf)))
 				return -EFAULT;
 			return 0;
@@ -901,74 +900,71 @@
 		case SNDCTL_COPR_WDATA:
 			if (copy_from_user(&dbuf, arg, sizeof(dbuf)))
 				return -EFAULT;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock, flags);
 			if (!pss_put_dspword(devc, 0x00d1)) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			if (!pss_put_dspword(devc, (unsigned short) (dbuf.parm1 & 0xffff))) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			tmp = (unsigned int)dbuf.parm2 & 0xffff;
 			if (!pss_put_dspword(devc, tmp)) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
 			return 0;
 		
 		case SNDCTL_COPR_WCODE:
 			if (copy_from_user(&dbuf, arg, sizeof(dbuf)))
 				return -EFAULT;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock, flags);
 			if (!pss_put_dspword(devc, 0x00d3)) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			if (!pss_put_dspword(devc, (unsigned short)(dbuf.parm1 & 0xffff))) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			tmp = (unsigned int)dbuf.parm2 & 0x00ff;
 			if (!pss_put_dspword(devc, tmp)) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			tmp = ((unsigned int)dbuf.parm2 >> 8) & 0xffff;
 			if (!pss_put_dspword(devc, tmp)) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
 			return 0;
 		
 		case SNDCTL_COPR_RCODE:
 			if (copy_from_user(&dbuf, arg, sizeof(dbuf)))
 				return -EFAULT;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock, flags);
 			if (!pss_put_dspword(devc, 0x00d2)) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			if (!pss_put_dspword(devc, (unsigned short)(dbuf.parm1 & 0xffff))) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			if (!pss_get_dspword(devc, &tmp)) { /* Read MSB */
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			dbuf.parm1 = tmp << 8;
 			if (!pss_get_dspword(devc, &tmp)) { /* Read LSB */
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
 				return -EIO;
 			}
 			dbuf.parm1 |= tmp & 0x00ff;
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
 			if (copy_to_user(arg, &dbuf, sizeof(dbuf)))
 				return -EFAULT;
 			return 0;

