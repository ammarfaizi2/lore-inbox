Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVGCVyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVGCVyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 17:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVGCVyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 17:54:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24995 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261547AbVGCVyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 17:54:02 -0400
Date: Sun, 3 Jul 2005 23:53:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [swsusp] Fix resume from initrd
Message-ID: <20050703215356.GA9761@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move device name resolution code around so that it is not called from
resume-from-initrd. name_to_dev_t may be unavailable at that point.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit b532d863c3fd0a6ee5def139cd1131a80b8c4a36
tree a781a55ce6af3b70a6e9232c548ebb8bda6e5011
parent 325107c7d4a5a28dee6eecce1ee8fa01753414c7
author <pavel@amd.(none)> Sun, 03 Jul 2005 23:53:24 +0200
committer <pavel@amd.(none)> Sun, 03 Jul 2005 23:53:24 +0200

 kernel/power/disk.c   |   10 ++++++++++
 kernel/power/swsusp.c |   10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -236,6 +236,16 @@ static int software_resume(void)
 {
 	int error;
 
+	if (!swsusp_resume_device) {
+		if (!strlen(resume_file))
+			return -ENOENT;
+		swsusp_resume_device = name_to_dev_t(resume_file);
+		pr_debug("swsusp: Resume From Partition %s\n", resume_file);
+	} else {
+		pr_debug("swsusp: Resume From Partition %d:%d\n",
+			 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
+	}
+
 	if (noresume) {
 		/**
 		 * FIXME: If noresume is specified, we need to find the partition
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -1495,16 +1495,6 @@ int swsusp_check(void)
 {
 	int error;
 
-	if (!swsusp_resume_device) {
-		if (!strlen(resume_file))
-			return -ENOENT;
-		swsusp_resume_device = name_to_dev_t(resume_file);
-		pr_debug("swsusp: Resume From Partition %s\n", resume_file);
-	} else {
-		pr_debug("swsusp: Resume From Partition %d:%d\n",
-			 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
-	}
-
 	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);

-- 
teflon -- maybe it is a trademark, but it should not be.
