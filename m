Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbVCDWMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVCDWMJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVCDWLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:11:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:5282 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263154AbVCDUyc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:32 -0500
Cc: nacc@us.ibm.com
Subject: [PATCH] w1/w1_therm: replace schedule_timeout() with msleep_interruptible()
In-Reply-To: <20050304203920.GB31644@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:39:42 -0800
Message-Id: <110996878287@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2080, 2005/03/02 16:58:20-08:00, nacc@us.ibm.com

[PATCH] w1/w1_therm: replace schedule_timeout() with msleep_interruptible()

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected. Changed tm to an int, as it now is in
terms of msecs, not jiffies.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1_therm.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)


diff -Nru a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c	2005-03-04 12:38:25 -08:00
+++ b/drivers/w1/w1_therm.c	2005-03-04 12:38:25 -08:00
@@ -26,6 +26,7 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/types.h>
+#include <linux/delay.h>
 
 #include "w1.h"
 #include "w1_io.h"
@@ -128,7 +129,7 @@
 		if (!w1_reset_bus (dev)) {
 			int count = 0;
 			u8 match[9] = {W1_MATCH_ROM, };
-			unsigned long tm;
+			unsigned int tm = 750;
 
 			memcpy(&match[1], (u64 *) & sl->reg_num, 8);
 			
@@ -136,11 +137,8 @@
 
 			w1_write_8(dev, W1_CONVERT_TEMP);
 
-			tm = jiffies + msecs_to_jiffies(750);
-			while(time_before(jiffies, tm)) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(tm-jiffies);
-
+			while (tm) {
+				tm = msleep_interruptible(tm);
 				if (signal_pending(current))
 					flush_signals(current);
 			}

