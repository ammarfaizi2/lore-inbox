Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVHBL0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVHBL0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVHBL0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:26:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4523 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261505AbVHBL0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:26:02 -0400
Date: Tue, 2 Aug 2005 13:25:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, shaohua.li@intel.com
Subject: swsusp: add locking to software_resume
Message-ID: <20050802112551.GA2542@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaohua Li <shaohua.li@intel.com>

It is trying to protect swsusp_resume_device and software_resume()
from two users banging it from userspace at the same time.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit c1d6e115ea6f797563fe6873de25892cb16a309e
tree 53b5eead95da859baf820be52a62b2ddab007c29
parent 86fa9d8a44c633603139b427c160ed1cdd41c6ce
author <pavel@Elf.(none)> Tue, 02 Aug 2005 13:19:38 +0200
committer <pavel@Elf.(none)> Tue, 02 Aug 2005 13:19:38 +0200

 kernel/power/disk.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -233,9 +233,12 @@ static int software_resume(void)
 {
 	int error;
 
+	down(&pm_sem);
 	if (!swsusp_resume_device) {
-		if (!strlen(resume_file))
+		if (!strlen(resume_file)) {
+			up(&pm_sem);
 			return -ENOENT;
+		}
 		swsusp_resume_device = name_to_dev_t(resume_file);
 		pr_debug("swsusp: Resume From Partition %s\n", resume_file);
 	} else {
@@ -248,6 +251,7 @@ static int software_resume(void)
 		 * FIXME: If noresume is specified, we need to find the partition
 		 * and reset it back to normal swap space.
 		 */
+		up(&pm_sem);
 		return 0;
 	}
 
@@ -284,6 +288,8 @@ static int software_resume(void)
  Cleanup:
 	unprepare_processes();
  Done:
+	/* For success case, the suspend path will release the lock */
+	up(&pm_sem);
 	pr_debug("PM: Resume from disk failed.\n");
 	return 0;
 }
@@ -390,7 +396,9 @@ static ssize_t resume_store(struct subsy
 	if (sscanf(buf, "%u:%u", &maj, &min) == 2) {
 		res = MKDEV(maj,min);
 		if (maj == MAJOR(res) && min == MINOR(res)) {
+			down(&pm_sem);
 			swsusp_resume_device = res;
+			up(&pm_sem);
 			printk("Attempting manual resume\n");
 			noresume = 0;
 			software_resume();

-- 
teflon -- maybe it is a trademark, but it should not be.
