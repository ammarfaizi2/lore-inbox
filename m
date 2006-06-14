Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWFNMIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWFNMIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWFNMIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:08:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:64206 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751285AbWFNMIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:08:50 -0400
Date: Wed, 14 Jun 2006 07:07:07 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: schwidefsky@de.ibm.com, linux390@de.ibm.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kthread: convert s390mach.c from kernel_thread
Message-ID: <20060614120707.GE15061@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert s390_collect_crw_info() in s390mach.c frombeing started
as a deprecated kernel_thread to a kthread.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 drivers/s390/s390mach.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

6708b02cfa48139f4ef915026bf62db0c6b5d395
diff --git a/drivers/s390/s390mach.c b/drivers/s390/s390mach.c
index f99e553..8dc7500 100644
--- a/drivers/s390/s390mach.c
+++ b/drivers/s390/s390mach.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/workqueue.h>
 #include <linux/time.h>
+#include <linux/kthread.h>
 
 #include <asm/lowcore.h>
 
@@ -56,8 +57,6 @@ s390_collect_crw_info(void *param)
 	unsigned int chain;
 
 	sem = (struct semaphore *)param;
-	/* Set a nice name. */
-	daemonize("kmcheck");
 repeat:
 	down_interruptible(sem);
 	slow = 0;
@@ -516,7 +515,7 @@ arch_initcall(machine_check_init);
 static int __init
 machine_check_crw_init (void)
 {
-	kernel_thread(s390_collect_crw_info, &m_sem, CLONE_FS|CLONE_FILES);
+	kthread_run(s390_collect_crw_info, &m_sem, "kmcheck");
 	ctl_set_bit(14, 28);	/* enable channel report MCH */
 	return 0;
 }
-- 
1.1.6
