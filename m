Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVHOS3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVHOS3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVHOS3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:29:51 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14983 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964894AbVHOS3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:29:50 -0400
Date: Mon, 15 Aug 2005 11:29:44 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: eokerson@quicknet.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [-mm PATCH 31/32] telephony: fix-up schedule_timeout() usage
Message-ID: <20050815182944.GH2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Use schedule_timeout_uninterruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 drivers/telephony/ixj.c |   54 ++++++++++++++++--------------------------------
 1 files changed, 18 insertions(+), 36 deletions(-)

diff -urpN 2.6.13-rc5-mm1/drivers/telephony/ixj.c 2.6.13-rc5-mm1-dev/drivers/telephony/ixj.c
--- 2.6.13-rc5-mm1/drivers/telephony/ixj.c	2005-08-07 10:05:21.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/telephony/ixj.c	2005-08-10 14:29:41.000000000 -0700
@@ -2071,8 +2071,7 @@ static int ixj_ring(IXJ *j)
 				j->flags.ringing = 0;
 				return 1;
 			}
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_interruptible(1);
 			if (signal_pending(current))
 				break;
 		}
@@ -2086,8 +2085,7 @@ static int ixj_ring(IXJ *j)
 					return 1;
 				}
 			}
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_interruptible(1);
 			if (signal_pending(current))
 				break;
 		}
@@ -2153,10 +2151,8 @@ static int ixj_release(struct inode *ino
 	 *    Set up locks to ensure that only one process is talking to the DSP at a time.
 	 *    This is necessary to keep the DSP from locking up.
 	 */
-	while(test_and_set_bit(board, (void *)&j->busyflags) != 0) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
+	while(test_and_set_bit(board, (void *)&j->busyflags) != 0)
+		schedule_timeout_interruptible(1);
 	if (ixjdebug & 0x0002)
 		printk(KERN_INFO "Closing board %d\n", NUM(inode));
 
@@ -3286,14 +3282,10 @@ static void ixj_write_cidcw(IXJ *j)
 	ixj_play_tone(j, 23);
 
 	clear_bit(j->board, &j->busyflags);
-	while(j->tone_state) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
-	while(test_and_set_bit(j->board, (void *)&j->busyflags) != 0) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
+	while(j->tone_state)
+		schedule_timeout_interruptible(1);
+	while(test_and_set_bit(j->board, (void *)&j->busyflags) != 0)
+		schedule_timeout_interruptible(1);
 	if(ixjdebug & 0x0200) {
 		printk("IXJ cidcw phone%d first tone end at %ld\n", j->board, jiffies);
 	}
@@ -3313,14 +3305,10 @@ static void ixj_write_cidcw(IXJ *j)
 	ixj_play_tone(j, 24);
 
 	clear_bit(j->board, &j->busyflags);
-	while(j->tone_state) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
-	while(test_and_set_bit(j->board, (void *)&j->busyflags) != 0) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
+	while(j->tone_state)
+		schedule_timeout_interruptible(1);
+	while(test_and_set_bit(j->board, (void *)&j->busyflags) != 0)
+		schedule_timeout_interruptible(1);
 	if(ixjdebug & 0x0200) {
 		printk("IXJ cidcw phone%d sent second tone at %ld\n", j->board, jiffies);
 	}
@@ -3328,14 +3316,10 @@ static void ixj_write_cidcw(IXJ *j)
 	j->cidcw_wait = jiffies + ((50 * hertz) / 100);
 
 	clear_bit(j->board, &j->busyflags);
-	while(!j->flags.cidcw_ack && time_before(jiffies, j->cidcw_wait)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
-	while(test_and_set_bit(j->board, (void *)&j->busyflags) != 0) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
+	while(!j->flags.cidcw_ack && time_before(jiffies, j->cidcw_wait))
+		schedule_timeout_interruptible(1);
+	while(test_and_set_bit(j->board, (void *)&j->busyflags) != 0)
+		schedule_timeout_interruptible(1);
 	j->cidcw_wait = 0;
 	if(!j->flags.cidcw_ack) {
 		if(ixjdebug & 0x0200) {
@@ -6110,10 +6094,8 @@ static int ixj_ioctl(struct inode *inode
 	 *    Set up locks to ensure that only one process is talking to the DSP at a time.
 	 *    This is necessary to keep the DSP from locking up.
 	 */
-	while(test_and_set_bit(board, (void *)&j->busyflags) != 0) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
+	while(test_and_set_bit(board, (void *)&j->busyflags) != 0)
+		schedule_timeout_interruptible(1);
 	if (ixjdebug & 0x0040)
 		printk("phone%d ioctl, cmd: 0x%x, arg: 0x%lx\n", minor, cmd, arg);
 	if (minor >= IXJMAX) {
