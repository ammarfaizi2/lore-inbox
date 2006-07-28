Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbWG1UHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbWG1UHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWG1UHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:07:31 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:33803 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161262AbWG1UHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:07:30 -0400
Date: Fri, 28 Jul 2006 16:07:05 -0400
From: nhorman@tuxdriver.com
Message-Id: <200607282007.k6SK75MK009573@ra.tuxdriver.com>
To: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org,
       nhorman@tuxdriver.com, paulus@au.ibm.com
Subject: [KJ] audit return code handling for kernel_thread [1/11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Audit/Cleanup of kernel_thread calls, specifically checking of return codes.
    Problems seemed to fall into 3 main categories:
    
    1) callers of kernel_thread were inconsistent about meaning of a zero return
    code.  Some callers considered a zero return code to mean success, others took
    it to mean failure.  a zero return code, while not actually possible in the
    current implementation, should be considered a success (pid 0 is/should be
    valid). fixed all callers to treat zero return as success
    
    2) caller of kernel_thread saved return code of kernel_thread for later use
    without ever checking its value.  Callers who did this tended to assume a
    non-zero return was success, and would often wait for a completion queue to be
    woken up, implying that an error (negative return code) from kernel_thread could
    lead to deadlock.  Repaired by checking return code at call time, and setting
    saved return code to zero in the event of an error.
    
    3) callers of kernel_thread never bothered to check the return code at all.
    This can lead to seemingly unrelated errors later in execution.  Fixed by
    checking return code at call time and printing a warning message on failure.

Regards
Neil
    
Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 drivers/macintosh/adb.c        |    4 ++++
 1 file changed, 4 insertions(+)
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -270,6 +270,10 @@ static void
 __adb_probe_task(void *data)
 {
 	adb_probe_task_pid = kernel_thread(adb_probe_task, NULL, SIGCHLD | CLONE_KERNEL);
+	if (adb_probe_task_pid < 0) {
+		printk(KERN_WARNING "Could not start adb probe task\n");
+		adb_probe_task_pid = 0;
+	}
 }
 
 static DECLARE_WORK(adb_reset_work, __adb_probe_task, NULL);
