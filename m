Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSFNVXm>; Fri, 14 Jun 2002 17:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSFNVXl>; Fri, 14 Jun 2002 17:23:41 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:55048 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S314458AbSFNVXj>;
	Fri, 14 Jun 2002 17:23:39 -0400
Date: Fri, 14 Jun 2002 23:27:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com, eokerson@quicknet.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kill warnings in telephony drivers
Message-ID: <20020614232726.A31109@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Annoying warnings in telephony driver killed.
Compiles - but not tested on HW.
Patch is against 2.5.21.

	Sam


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="telephony-warnings.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.456   -> 1.457  
#	drivers/telephony/ixj.c	1.15    -> 1.16   
#	drivers/telephony/ixj.h	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/14	sam@mars.ravnborg.org	1.457
# Kill warnings related to usage of xxx_bit operations.
# Kill warnings related to kdev_t.
# Two warnings remains that occur due to rcsid defined in header files, 
# but utilised only by a single .c file.
# --------------------------------------------
#
diff -Nru a/drivers/telephony/ixj.c b/drivers/telephony/ixj.c
--- a/drivers/telephony/ixj.c	Fri Jun 14 23:22:26 2002
+++ b/drivers/telephony/ixj.c	Fri Jun 14 23:22:26 2002
@@ -274,8 +274,7 @@
 
 #include "ixj.h"
 
-#define TYPE(dev) (MINOR(dev) >> 4)
-#define NUM(dev) (MINOR(dev) & 0xf)
+#define NUM(dev) (minor(dev) & 0xf)
 
 static int ixjdebug;
 static int hertz = HZ;
@@ -800,24 +799,24 @@
 		ixj_DownloadG729 = regfunc;
 		for (cnt = 0; cnt < IXJMAX; cnt++) {
 			IXJ *j = get_ixj(cnt);
-			while(test_and_set_bit(cnt, (void *)&j->busyflags) != 0) {
+			while(test_and_set_bit(cnt, j->busyflags) != 0) {
 				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(1);
 			}
 			ixj_DownloadG729(j, 0L);
-			clear_bit(cnt, &j->busyflags);
+			clear_bit(cnt, j->busyflags);
 		}
 		break;
 	case TS85LOADER:
 		ixj_DownloadTS85 = regfunc;
 		for (cnt = 0; cnt < IXJMAX; cnt++) {
 			IXJ *j = get_ixj(cnt);
-			while(test_and_set_bit(cnt, (void *)&j->busyflags) != 0) {
+			while(test_and_set_bit(cnt, j->busyflags) != 0) {
 				set_current_state(TASK_INTERRUPTIBLE);
 				schedule_timeout(1);
 			}
 			ixj_DownloadTS85(j, 0L);
-			clear_bit(cnt, &j->busyflags);
+			clear_bit(cnt, j->busyflags);
 		}
 		break;
 	case PRE_READ:
@@ -1258,7 +1257,7 @@
 	IXJ *j = (IXJ *)ptr;
 	board = j->board;
 
-	if (j->DSPbase && atomic_read(&j->DSPWrite) == 0 && test_and_set_bit(board, (void *)&j->busyflags) == 0) {
+	if (j->DSPbase && atomic_read(&j->DSPWrite) == 0 && test_and_set_bit(board, j->busyflags) == 0) {
 		ixj_perfmon(j->timerchecks);
 		j->hookstate = ixj_hookstate(j);
 		if (j->tone_state) {
@@ -1269,7 +1268,7 @@
 					j->ex.bits.hookstate = 1;
 					ixj_kill_fasync(j, SIG_HOOKSTATE, POLL_IN);
 				}
-				clear_bit(board, &j->busyflags);
+				clear_bit(board, j->busyflags);
 				ixj_add_timer(j);
 				return;
 			}
@@ -1281,14 +1280,14 @@
 				if (j->tone_state == 1) {
 					ixj_play_tone(j, j->tone_index);
 					if (j->dsp.low == 0x20) {
-						clear_bit(board, &j->busyflags);
+						clear_bit(board, j->busyflags);
 						ixj_add_timer(j);
 						return;
 					}
 				} else {
 					ixj_play_tone(j, 0);
 					if (j->dsp.low == 0x20) {
-						clear_bit(board, &j->busyflags);
+						clear_bit(board, j->busyflags);
 						ixj_add_timer(j);
 						return;
 					}
@@ -1301,7 +1300,7 @@
 				if (j->flags.busytone) {
 					ixj_busytone(j);
 					if (j->dsp.low == 0x20) {
-						clear_bit(board, &j->busyflags);
+						clear_bit(board, j->busyflags);
 						ixj_add_timer(j);
 						return;
 					}
@@ -1309,7 +1308,7 @@
 				if (j->flags.ringback) {
 					ixj_ringback(j);
 					if (j->dsp.low == 0x20) {
-						clear_bit(board, &j->busyflags);
+						clear_bit(board, j->busyflags);
 						ixj_add_timer(j);
 						return;
 					}
@@ -1433,7 +1432,7 @@
 					}
 					j->flags.cidring = 0;
 				}
-				clear_bit(board, &j->busyflags);
+				clear_bit(board, j->busyflags);
 				ixj_add_timer(j);
 				return;
 			} else {
@@ -1462,7 +1461,7 @@
 							j->flags.cidring = 1;
 					}
 				}
-				clear_bit(board, &j->busyflags);
+				clear_bit(board, j->busyflags);
 				ixj_add_timer(j);
 				return;
 			}
@@ -1498,7 +1497,7 @@
 		if (j->ex.bytes) {
 			wake_up_interruptible(&j->poll_q);	/* Wake any blocked selects */
 		}
-		clear_bit(board, &j->busyflags);
+		clear_bit(board, j->busyflags);
 	}
 	ixj_add_timer(j);
 }
@@ -2269,7 +2268,7 @@
 	 *    Set up locks to ensure that only one process is talking to the DSP at a time.
 	 *    This is necessary to keep the DSP from locking up.
 	 */
-	while(test_and_set_bit(board, (void *)&j->busyflags) != 0) {
+	while(test_and_set_bit(board, j->busyflags) != 0) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
@@ -2461,7 +2460,7 @@
 	j->ex_sig.bits.f3 = j->ex_sig.bits.fc0 = j->ex_sig.bits.fc1 = j->ex_sig.bits.fc2 = j->ex_sig.bits.fc3 = 1;
 
 	file_p->private_data = NULL;
-	clear_bit(board, &j->busyflags);
+	clear_bit(board, j->busyflags);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -3396,12 +3395,12 @@
 	}
 	ixj_play_tone(j, 23);
 
-	clear_bit(j->board, &j->busyflags);
+	clear_bit(j->board, j->busyflags);
 	while(j->tone_state) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
-	while(test_and_set_bit(j->board, (void *)&j->busyflags) != 0) {
+	while(test_and_set_bit(j->board, j->busyflags) != 0) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
@@ -3423,12 +3422,12 @@
 	}
 	ixj_play_tone(j, 24);
 
-	clear_bit(j->board, &j->busyflags);
+	clear_bit(j->board, j->busyflags);
 	while(j->tone_state) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
-	while(test_and_set_bit(j->board, (void *)&j->busyflags) != 0) {
+	while(test_and_set_bit(j->board, j->busyflags) != 0) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
@@ -3438,12 +3437,12 @@
 
 	j->cidcw_wait = jiffies + ((50 * hertz) / 100);
 
-	clear_bit(j->board, &j->busyflags);
+	clear_bit(j->board, j->busyflags);
 	while(!j->flags.cidcw_ack && time_before(jiffies, j->cidcw_wait)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
-	while(test_and_set_bit(j->board, (void *)&j->busyflags) != 0) {
+	while(test_and_set_bit(j->board, j->busyflags) != 0) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
@@ -6202,7 +6201,7 @@
 	IXJ_FILTER_RAW jfr;
 
 	unsigned int raise, mant;
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor_no = minor(inode->i_rdev);
 	int board = NUM(inode->i_rdev);
 
 	IXJ *j = get_ixj(NUM(inode->i_rdev));
@@ -6213,14 +6212,14 @@
 	 *    Set up locks to ensure that only one process is talking to the DSP at a time.
 	 *    This is necessary to keep the DSP from locking up.
 	 */
-	while(test_and_set_bit(board, (void *)&j->busyflags) != 0) {
+	while(test_and_set_bit(board, j->busyflags) != 0) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 	if (ixjdebug & 0x0040)
-		printk("phone%d ioctl, cmd: 0x%x, arg: 0x%lx\n", minor, cmd, arg);
-	if (minor >= IXJMAX) {
-		clear_bit(board, &j->busyflags);
+		printk("phone%d ioctl, cmd: 0x%x, arg: 0x%lx\n", minor_no, cmd, arg);
+	if (minor_no >= IXJMAX) {
+		clear_bit(board, j->busyflags);
 		return -ENODEV;
 	}
 	/*
@@ -6746,8 +6745,8 @@
 		break;
 	}
 	if (ixjdebug & 0x0040)
-		printk("phone%d ioctl end, cmd: 0x%x, arg: 0x%lx\n", minor, cmd, arg);
-	clear_bit(board, &j->busyflags);
+		printk("phone%d ioctl end, cmd: 0x%x, arg: 0x%lx\n", minor_no, cmd, arg);
+	clear_bit(board, j->busyflags);
 	return retval;
 }
 
diff -Nru a/drivers/telephony/ixj.h b/drivers/telephony/ixj.h
--- a/drivers/telephony/ixj.h	Fri Jun 14 23:22:26 2002
+++ b/drivers/telephony/ixj.h	Fri Jun 14 23:22:26 2002
@@ -1199,7 +1199,7 @@
 	unsigned char cid_play_flag;
 	char play_mode;
 	IXJ_FLAGS flags;
-	unsigned int busyflags;
+	bitmap_member(busyflags, IXJMAX);
 	unsigned int rec_frame_size;
 	unsigned int play_frame_size;
 	unsigned int cid_play_frame_size;

--Q68bSM7Ycu6FN28Q--
