Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVFTWUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVFTWUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVFTWIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:08:13 -0400
Received: from coderock.org ([193.77.147.115]:53400 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261671AbVFTVxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:53:54 -0400
Message-Id: <20050620215123.047100000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:23 +0200
From: domen@coderock.org
To: dmo@osdl.org
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 1/2] : block/DAC960: remove sleep_on*() usage
Content-Disposition: inline; filename=wait_event_int_timeout-drivers_block_DAC960.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use wait_event_interruptible_timeout() instead of the deprecated
interruptible_sleep_on_timeout(). The existing code is complicated in the
conditional and so is the new code. Also replace sleep_on_timeout() with direct
wait-queue usage. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 DAC960.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

Index: quilt/drivers/block/DAC960.c
===================================================================
--- quilt.orig/drivers/block/DAC960.c
+++ quilt/drivers/block/DAC960.c
@@ -41,6 +41,7 @@
 #include <linux/timer.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/wait.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include "DAC960.h"
@@ -6242,6 +6243,7 @@ static boolean DAC960_V2_TranslatePhysic
 static boolean DAC960_V2_ExecuteUserCommand(DAC960_Controller_T *Controller,
 					    unsigned char *UserCommand)
 {
+  DEFINE_WAIT(wait);
   DAC960_Command_T *Command;
   DAC960_V2_CommandMailbox_T *CommandMailbox;
   unsigned long flags;
@@ -6432,7 +6434,9 @@ static boolean DAC960_V2_ExecuteUserComm
 	  while (Controller->V2.NewControllerInformation->PhysicalScanActive)
 	    {
 	      DAC960_ExecuteCommand(Command);
-	      sleep_on_timeout(&Controller->CommandWaitQueue, HZ);
+	      prepare_to_wait(&Controller->CommandWaitQueue, &wait, TASK_UNINTERRUPTIBLE);
+	      schedule_timeout(HZ);
+	      finish_wait(&Controller->CommandWaitQueue, &wait);
 	    }
 	  DAC960_UserCritical("Discovery Completed\n", Controller);
  	}
@@ -7032,15 +7036,13 @@ static int DAC960_gam_ioctl(struct inode
 			   GetHealthStatus.HealthStatusBuffer,
 			   sizeof(DAC960_V2_HealthStatusBuffer_T)))
 		return -EFAULT;
-	while (Controller->V2.HealthStatusBuffer->StatusChangeCounter
-	       == HealthStatusBuffer.StatusChangeCounter &&
-	       Controller->V2.HealthStatusBuffer->NextEventSequenceNumber
-	       == HealthStatusBuffer.NextEventSequenceNumber)
-	  {
-	    interruptible_sleep_on_timeout(&Controller->HealthStatusWaitQueue,
-					   DAC960_MonitoringTimerInterval);
-	    if (signal_pending(current)) return -EINTR;
-	  }
+	wait_event_interruptible_timeout(Controller->HealthStatusWaitQueue,
+			(Controller->V2.HealthStatusBuffer->StatusChangeCounter
+			 != HealthStatusBuffer.StatusChangeCounter ||
+			 Controller->V2.HealthStatusBuffer->NextEventSequenceNumber
+			 != HealthStatusBuffer.NextEventSequenceNumber),
+			 DAC960_MonitoringTimerInterval);
+	if (signal_pending(current)) return -EINTR;
 	if (copy_to_user(GetHealthStatus.HealthStatusBuffer,
 			 Controller->V2.HealthStatusBuffer,
 			 sizeof(DAC960_V2_HealthStatusBuffer_T)))

--
