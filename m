Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161268AbWG1UIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbWG1UIt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWG1UIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:08:48 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:46347 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161272AbWG1UIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:08:31 -0400
Date: Fri, 28 Jul 2006 16:08:12 -0400
From: nhorman@tuxdriver.com
Message-Id: <200607282008.k6SK8C0A009703@ra.tuxdriver.com>
To: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org,
       nhorman@tuxdriver.com, paulus@au.ibm.com
Subject: [KJ] audit return code handling for kernel_thread [10/11]
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


 drivers/macintosh/therm_pm72.c |    4 ++++
 1 file changed, 4 insertions(+)
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -1769,6 +1769,10 @@ static void start_control_loops(void)
 	init_completion(&ctrl_complete);
 
 	ctrl_task = kernel_thread(main_control_loop, NULL, SIGCHLD | CLONE_KERNEL);
+	if (ctrl_task < 0) {
+		printk(KERN_CRIT "could not start control thread\n");
+		ctrl_task = 0;
+	}
 }
 
 /*
