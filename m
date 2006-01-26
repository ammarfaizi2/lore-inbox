Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWAZDwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWAZDwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWAZDtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:41 -0500
Received: from [202.53.187.9] ([202.53.187.9]:18667 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932233AbWAZDtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:15 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 07/23] [Suspend2] Add which-to-thaw parameter to thaw_processes() calls.
Date: Thu, 26 Jan 2006 13:45:42 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034541.3178.35678.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Modify the existing invocations of thaw_processes so that they use the new
parameter specifying which processes (kernel only or all) to thaw.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/disk.c |    5 +++--
 kernel/power/main.c |    7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index e24446f..4fb8af1 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/syscalls.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
@@ -106,7 +107,7 @@ static int prepare_processes(void)
 	if (!(error = swsusp_shrink_memory()))
 		return 0;
 thaw:
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
 	enable_nonboot_cpus();
 	pm_restore_console();
 	return error;
@@ -115,7 +116,7 @@ thaw:
 static void unprepare_processes(void)
 {
 	platform_finish();
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
 	enable_nonboot_cpus();
 	pm_restore_console();
 }
diff --git a/kernel/power/main.c b/kernel/power/main.c
index d253f3a..6f854e4 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/delay.h>
@@ -95,7 +96,7 @@ static int suspend_prepare(suspend_state
 	if (pm_ops->finish)
 		pm_ops->finish(state);
  Thaw:
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
  Enable_cpu:
 	enable_nonboot_cpus();
 	pm_restore_console();
@@ -103,7 +104,7 @@ static int suspend_prepare(suspend_state
 }
 
 
-static int suspend_enter(suspend_state_t state)
+int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
 	unsigned long flags;
@@ -135,7 +136,7 @@ static void suspend_finish(suspend_state
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
 	enable_nonboot_cpus();
 	pm_restore_console();
 }

--
Nigel Cunningham		nigel at suspend2 dot net
