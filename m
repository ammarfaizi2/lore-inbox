Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422810AbWA1Cuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWA1Cuc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWA1Cuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:50:32 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:46243 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1751380AbWA1Cu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:50:29 -0500
Message-ID: <43DADB24.306@samwel.tk>
Date: Sat, 28 Jan 2006 03:47:00 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Represent laptop_mode as jiffies internally
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Make that the internal value for /proc/sys/vm/laptop_mode
is stored as jiffies instead of seconds. Let the sysctl
interface do the conversions, instead of doing on-the-fly
conversions every time the value is used.

Add a description of the fact that laptop_mode doubles as a
flag and a timeout to the comment above the laptop_mode variable.


Signed-off-by: Bart Samwel <bart@samwel.tk>

--- linux-2.6.16-rc1.orig/kernel/sysctl.c	2006-01-28 02:09:32.000000000 +0100
+++ linux-2.6.16-rc1/kernel/sysctl.c	2006-01-28 02:13:10.000000000 +0100
@@ -823,9 +823,8 @@
  		.data		= &laptop_mode,
  		.maxlen		= sizeof(laptop_mode),
  		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-		.strategy	= &sysctl_intvec,
-		.extra1		= &zero,
+		.proc_handler	= &proc_dointvec_jiffies,
+		.strategy	= &sysctl_jiffies,
  	},
  	{
  		.ctl_name	= VM_BLOCK_DUMP,
--- linux-2.6.16-rc1.orig/mm/page-writeback.c	2006-01-28 01:47:24.000000000 +0100
+++ linux-2.6.16-rc1/mm/page-writeback.c	2006-01-28 02:11:52.000000000 +0100
@@ -88,7 +88,8 @@
  int block_dump;

  /*
- * Flag that puts the machine in "laptop mode".
+ * Flag that puts the machine in "laptop mode". Doubles as a timeout in jiffies:
+ * a full sync is triggered after this time elapses without any disk activity.
   */
  int laptop_mode;

@@ -467,7 +468,7 @@
   */
  void laptop_io_completion(void)
  {
-	mod_timer(&laptop_mode_wb_timer, jiffies + laptop_mode * HZ);
+	mod_timer(&laptop_mode_wb_timer, jiffies + laptop_mode);
  }

  /*
