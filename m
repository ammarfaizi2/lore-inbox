Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVCEWxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVCEWxS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVCEWwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:52:34 -0500
Received: from coderock.org ([193.77.147.115]:62885 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261323AbVCEWnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:49 -0500
Subject: [patch 13/15] : block/DAC960: remove sleep_on*() usage
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:43:24 +0100
Message-Id: <20050305224324.5BA431EE1E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jan 25, 2005 at 02:11:07PM -0800, Nishanth Aravamudan wrote:
> Hi,
> 
> > 
> Description: Use wait_event_interruptible_timeout() instead of the deprecated
> interruptible_sleep_on_timeout(). The existing code is complicated in the
> conditional and so is the new code. Patch is compile-tested.

The following patch should be considered instead, as it removes completely
callers of sleep_on*().

Thanks,
Nish

Use wait_event_interruptible_timeout() instead of the deprecated
interruptible_sleep_on_timeout(). The existing code is complicated in the
conditional and so is the new code. Also replace sleep_on_timeout() with direct
wait-queue usage. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/DAC960.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff -puN drivers/block/DAC960.c~wait_event_int_timeout-drivers_block_DAC960 drivers/block/DAC960.c
--- kj/drivers/block/DAC960.c~wait_event_int_timeout-drivers_block_DAC960	2005-03-05 16:11:57.000000000 +0100
+++ kj-domen/drivers/block/DAC960.c	2005-03-05 16:11:57.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/timer.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/wait.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include "DAC960.h"
@@ -6127,6 +6128,7 @@ static boolean DAC960_V2_TranslatePhysic
 static boolean DAC960_V2_ExecuteUserCommand(DAC960_Controller_T *Controller,
 					    unsigned char *UserCommand)
 {
+  DEFINE_WAIT(wait);
   DAC960_Command_T *Command;
   DAC960_V2_CommandMailbox_T *CommandMailbox;
   unsigned long flags;
@@ -6317,7 +6319,9 @@ static boolean DAC960_V2_ExecuteUserComm
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
@@ -6917,15 +6921,13 @@ static int DAC960_gam_ioctl(struct inode
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
_
