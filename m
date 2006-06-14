Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWFNOI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWFNOI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWFNOI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:08:59 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:16688 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964976AbWFNOI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:08:57 -0400
Date: Wed, 14 Jun 2006 16:08:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, serue@us.ibm.com
Subject: [patch 24/24] s390: kthread conversion.
Message-ID: <20060614140859.GY9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge E. Hallyn <serue@us.ibm.com>

[S390] kthread conversion.

Convert s390_collect_crw_info() in s390mach.c from being started
as a deprecated kernel_thread to a kthread.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/s390mach.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/s390mach.c linux-2.6-patched/drivers/s390/s390mach.c
--- linux-2.6/drivers/s390/s390mach.c	2006-06-14 14:29:19.000000000 +0200
+++ linux-2.6-patched/drivers/s390/s390mach.c	2006-06-14 14:30:05.000000000 +0200
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
