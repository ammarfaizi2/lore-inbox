Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVK3VTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVK3VTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVK3VTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:19:04 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:58323 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750746AbVK3VTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:19:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=DqzlYcEG6o5pwPF10FhKkoNYu3vFciw9AV3AoW9wudVD0e2kG14nWegyPO6Tc5WuRrq6ZjnfpXukme+bewRuWdtHkTVwcgCMSKHdiCuPOvD2cb1mxFwDWk/DD1q/1UGX9muerdqt72Ms7sihRcLzhu80Ls9DuFsBZHG/R7V1OgU=
Date: Thu, 1 Dec 2005 00:33:47 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Bristow <paul@paulbristow.net>, Dave Olien <dmo@osdl.org>,
       linux-kernel@vger.kernel.org,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [PATCH] drivers/block/*: use time_after() and friends
Message-ID: <20051130213347.GA12551@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>

They deal with wrapping correctly and are nicer to read.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/block/DAC960.c |   17 +++++++++--------
 drivers/block/floppy.c |    9 +++++----
 2 files changed, 14 insertions(+), 12 deletions(-)

--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -41,6 +41,7 @@
 #include <linux/timer.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include "DAC960.h"
@@ -3664,8 +3665,8 @@ static void DAC960_V1_ProcessCompletedCo
 	      (NewEnquiry->EventLogSequenceNumber !=
 	       OldEnquiry->EventLogSequenceNumber) ||
 	      Controller->MonitoringTimerCount == 0 ||
-	      (jiffies - Controller->SecondaryMonitoringTime
-	       >= DAC960_SecondaryMonitoringInterval))
+	      time_after_eq(jiffies, Controller->SecondaryMonitoringTime
+	       + DAC960_SecondaryMonitoringInterval))
 	    {
 	      Controller->V1.NeedLogicalDriveInformation = true;
 	      Controller->V1.NewEventLogSequenceNumber =
@@ -5650,8 +5651,8 @@ static void DAC960_MonitoringTimerFuncti
       unsigned int StatusChangeCounter =
 	Controller->V2.HealthStatusBuffer->StatusChangeCounter;
       boolean ForceMonitoringCommand = false;
-      if (jiffies - Controller->SecondaryMonitoringTime
-	  > DAC960_SecondaryMonitoringInterval)
+      if (time_after(jiffies, Controller->SecondaryMonitoringTime
+	  + DAC960_SecondaryMonitoringInterval))
 	{
 	  int LogicalDriveNumber;
 	  for (LogicalDriveNumber = 0;
@@ -5679,8 +5680,8 @@ static void DAC960_MonitoringTimerFuncti
 	   ControllerInfo->ConsistencyChecksActive +
 	   ControllerInfo->RebuildsActive +
 	   ControllerInfo->OnlineExpansionsActive == 0 ||
-	   jiffies - Controller->PrimaryMonitoringTime
-	   < DAC960_MonitoringTimerInterval) &&
+	   time_before(jiffies, Controller->PrimaryMonitoringTime
+	   + DAC960_MonitoringTimerInterval)) &&
 	  !ForceMonitoringCommand)
 	{
 	  Controller->MonitoringTimer.expires =
@@ -5817,8 +5818,8 @@ static void DAC960_Message(DAC960_Messag
       Controller->ProgressBufferLength = Length;
       if (Controller->EphemeralProgressMessage)
 	{
-	  if (jiffies - Controller->LastProgressReportTime
-	      >= DAC960_ProgressReportingInterval)
+	  if (time_after_eq(jiffies, Controller->LastProgressReportTime
+	      + DAC960_ProgressReportingInterval))
 	    {
 	      printk("%sDAC960#%d: %s", DAC960_MessageLevelMap[MessageLevel],
 		     Controller->ControllerNumber, Buffer);
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -179,6 +179,7 @@ static int print_unex = 1;
 #include <linux/devfs_fs_kernel.h>
 #include <linux/platform_device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
+#include <linux/jiffies.h>
 
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
@@ -736,7 +737,7 @@ static int disk_change(int drive)
 {
 	int fdc = FDC(drive);
 #ifdef FLOPPY_SANITY_CHECK
-	if (jiffies - UDRS->select_date < UDP->select_delay)
+	if (time_before(jiffies, UDRS->select_date + UDP->select_delay))
 		DPRINT("WARNING disk change called early\n");
 	if (!(FDCS->dor & (0x10 << UNIT(drive))) ||
 	    (FDCS->dor & 3) != UNIT(drive) || fdc != FDC(drive)) {
@@ -1064,7 +1065,7 @@ static int fd_wait_for_completion(unsign
 		return 1;
 	}
 
-	if ((signed)(jiffies - delay) < 0) {
+	if (time_before(jiffies, delay)) {
 		del_timer(&fd_timer);
 		fd_timer.function = function;
 		fd_timer.expires = delay;
@@ -1524,7 +1525,7 @@ static void setup_rw_floppy(void)
 		 * again just before spinup completion. Beware that
 		 * after scandrives, we must again wait for selection.
 		 */
-		if ((signed)(ready_date - jiffies) > DP->select_delay) {
+		if (time_after(ready_date, jiffies + DP->select_delay)) {
 			ready_date -= DP->select_delay;
 			function = (timeout_fn) floppy_start;
 		} else
@@ -3812,7 +3813,7 @@ static int check_floppy_change(struct ge
 	if (UTESTF(FD_DISK_CHANGED) || UTESTF(FD_VERIFY))
 		return 1;
 
-	if (UDP->checkfreq < (int)(jiffies - UDRS->last_checked)) {
+	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
 		if (floppy_grab_irq_and_dma()) {
 			return 1;
 		}

