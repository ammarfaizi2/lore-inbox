Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVGaLKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVGaLKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVGaLKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:10:41 -0400
Received: from coderock.org ([193.77.147.115]:37828 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261658AbVGaLKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:10:38 -0400
Message-Id: <20050731111039.202166000@homer>
Date: Sun, 31 Jul 2005 13:10:39 +0200
From: domen@coderock.org
To: dmo@osdl.org
Cc: linux-kernel@vger.kernel.org,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>, domen@coderock.org
Subject: [patch 1/1] drivers/block/DAC960.c : Use of time_after(), time_after_eq() and time_before() macros
Content-Disposition: inline; filename=time_after-drivers_block_DAC960
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>




Use of time_after(), time_after_eq() and time_before() macros, define at
linux/jiffies.h, which deal with wrapping correctly and are nicer to read.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 DAC960.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

Index: quilt/drivers/block/DAC960.c
===================================================================
--- quilt.orig/drivers/block/DAC960.c
+++ quilt/drivers/block/DAC960.c
@@ -42,6 +42,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/wait.h>
+#include <linux/jiffies.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include "DAC960.h"
@@ -3674,8 +3675,8 @@ static void DAC960_V1_ProcessCompletedCo
 	      (NewEnquiry->EventLogSequenceNumber !=
 	       OldEnquiry->EventLogSequenceNumber) ||
 	      Controller->MonitoringTimerCount == 0 ||
-	      (jiffies - Controller->SecondaryMonitoringTime
-	       >= DAC960_SecondaryMonitoringInterval))
+	      (time_after_eq(jiffies, Controller->SecondaryMonitoringTime
+	       + DAC960_SecondaryMonitoringInterval)))
 	    {
 	      Controller->V1.NeedLogicalDriveInformation = true;
 	      Controller->V1.NewEventLogSequenceNumber =
@@ -5660,8 +5661,8 @@ static void DAC960_MonitoringTimerFuncti
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
@@ -5689,8 +5690,8 @@ static void DAC960_MonitoringTimerFuncti
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
@@ -5827,8 +5828,8 @@ static void DAC960_Message(DAC960_Messag
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

--
