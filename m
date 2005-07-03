Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVGCWEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVGCWEq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 18:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVGCWEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 18:04:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27117 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261548AbVGCWEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 18:04:41 -0400
Date: Sun, 3 Jul 2005 23:56:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] swsusp: fix error handling
Message-ID: <20050703215651.GA10766@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error handling and whitespace in swsusp.c. swsusp_free() was
called when there was nothing allocating, leading to oops.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 674f73c9711fdc86c9c60adfefd5f88b32691edf
tree 5a28fb2543e0d012022c82dc7028991abd860c71
parent b532d863c3fd0a6ee5def139cd1131a80b8c4a36
author <pavel@amd.(none)> Sun, 03 Jul 2005 23:56:16 +0200
committer <pavel@amd.(none)> Sun, 03 Jul 2005 23:56:16 +0200

 kernel/power/swsusp.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -975,13 +975,6 @@ extern asmlinkage int swsusp_arch_resume
 
 asmlinkage int swsusp_save(void)
 {
-	int error = 0;
-
-	if ((error = swsusp_swap_check())) {
-		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
-				"swapon -a!\n");
-		return error;
-	}
 	return suspend_prepare_image();
 }
 
@@ -998,14 +991,20 @@ int swsusp_suspend(void)
 	 * at resume time, and evil weirdness ensues.
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
-		printk(KERN_ERR "Some devices failed to power down, aborting suspend\n");
 		local_irq_enable();
-		swsusp_free();
 		return error;
 	}
+
+	if ((error = swsusp_swap_check())) {
+		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
+				"swapon -a!\n");
+		local_irq_enable();
+		return error;
+	}
+
 	save_processor_state();
 	if ((error = swsusp_arch_suspend()))
-		swsusp_free();
+		printk("Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
@@ -1272,9 +1271,9 @@ static int bio_write_page(pgoff_t page_o
 static const char * sanity_check(void)
 {
 	dump_info();
-	if(swsusp_info.version_code != LINUX_VERSION_CODE)
+	if (swsusp_info.version_code != LINUX_VERSION_CODE)
 		return "kernel version";
-	if(swsusp_info.num_physpages != num_physpages)
+	if (swsusp_info.num_physpages != num_physpages)
 		return "memory size";
 	if (strcmp(swsusp_info.uts.sysname,system_utsname.sysname))
 		return "system type";

-- 
teflon -- maybe it is a trademark, but it should not be.
