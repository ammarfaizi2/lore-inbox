Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423178AbWF1FZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423178AbWF1FZJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423188AbWF1FYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:24:47 -0400
Received: from terminus.zytor.com ([192.83.249.54]:5326 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423162AbWF1FTP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:15 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 30/31] Remove in-kernel resume-from-disk invocation code
Date: Tue, 27 Jun 2006 22:17:30 -0700
Message-Id: <klibc.200606272217.30@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the part of resume from disk that have been replaced by
functionality in kinit.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 72226912c1128958df215fcfc10b91f4e27bfa79
tree d46fecb176127faa119520ff7b066d5e05a927d1
parent 15d00a4525e5127f0cb4ff31fae3c80c87d3212e
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:20 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:20 -0700

 kernel/power/disk.c |   45 ++++-----------------------------------------
 1 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index e13e740..a8115c3 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -22,8 +22,6 @@ #include <linux/pm.h>
 #include "power.h"
 
 
-static int noresume = 0;
-char resume_file[256] = CONFIG_PM_STD_PARTITION;
 dev_t swsusp_resume_device;
 
 /**
@@ -166,26 +164,13 @@ static int software_resume(void)
 
 	down(&pm_sem);
 	if (!swsusp_resume_device) {
-		if (!strlen(resume_file)) {
-			up(&pm_sem);
-			return -ENOENT;
-		}
-		swsusp_resume_device = name_to_dev_t(resume_file);
-		pr_debug("swsusp: Resume From Partition %s\n", resume_file);
-	} else {
-		pr_debug("swsusp: Resume From Partition %d:%d\n",
-			 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
-	}
-
-	if (noresume) {
-		/**
-		 * FIXME: If noresume is specified, we need to find the partition
-		 * and reset it back to normal swap space.
-		 */
-		up(&pm_sem);
+		pr_debug("swsusp: No device given!\n");
 		return 0;
 	}
 
+	pr_debug("swsusp: Resume From Partition %d:%d\n",
+		 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
+
 	pr_debug("PM: Checking swsusp image.\n");
 
 	if ((error = swsusp_check()))
@@ -228,8 +213,6 @@ static int software_resume(void)
 	return 0;
 }
 
-late_initcall(software_resume);
-
 
 static const char * const pm_disk_modes[] = {
 	[PM_DISK_FIRMWARE]	= "firmware",
@@ -333,7 +316,6 @@ static ssize_t resume_store(struct subsy
 	swsusp_resume_device = res;
 	up(&pm_sem);
 	printk("Attempting manual resume\n");
-	noresume = 0;
 	software_resume();
 	ret = n;
 out:
@@ -380,22 +362,3 @@ static int __init pm_disk_init(void)
 }
 
 core_initcall(pm_disk_init);
-
-
-static int __init resume_setup(char *str)
-{
-	if (noresume)
-		return 1;
-
-	strncpy( resume_file, str, 255 );
-	return 1;
-}
-
-static int __init noresume_setup(char *str)
-{
-	noresume = 1;
-	return 1;
-}
-
-__setup("noresume", noresume_setup);
-__setup("resume=", resume_setup);
