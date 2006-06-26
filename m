Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWFZA6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWFZA6K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWFZA6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:10 -0400
Received: from terminus.zytor.com ([192.83.249.54]:2703 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932451AbWFZA6J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:09 -0400
Date: Sun, 25 Jun 2006 17:57:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 03/43] Remove parts moved to kinit
Message-Id: <klibc.200606251757.03@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 79d8875c392c6eaf4b9537625c57690a02eab411
tree 024822bc058f19761a001d4026dc5b9bb2f940b2
parent a2faf9b56a04fc16ef2a8a8e42e91601cae1dc75
author H. Peter Anvin <hpa@zytor.com> Thu, 30 Mar 2006 11:35:15 -0800
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:45:43 -0700

 kernel/power/disk.c |   45 ++++-----------------------------------------
 1 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 81d4d98..b886784 100644
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
 
 static char * pm_disk_modes[] = {
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
