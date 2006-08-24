Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422662AbWHXVWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWHXVWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWHXVWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:22:53 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:45758 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030471AbWHXVWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:22:52 -0400
Date: Thu, 24 Aug 2006 16:22:42 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com
Subject: [PATCH 1/3] kthread: update s390 cmm driver to use kthread
Message-ID: <20060824212241.GB30007@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the s390 cooperative memory manager, which can be a module,
to use kthread rather than kernel_thread, whose EXPORT is deprecated.

This patch compiles and boots fine, but I don't know how to really
test the driver.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 arch/s390/mm/cmm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

7f73a7a8a72647c0bd08ba5c47e941ddf72badee
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index ceea51c..a4d463d 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/sysctl.h>
 #include <linux/ctype.h>
+#include <linux/kthread.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -126,7 +127,6 @@ cmm_thread(void *dummy)
 {
 	int rc;
 
-	daemonize("cmmthread");
 	while (1) {
 		rc = wait_event_interruptible(cmm_thread_wait,
 			(cmm_pages != cmm_pages_target ||
@@ -161,7 +161,7 @@ cmm_thread(void *dummy)
 static void
 cmm_start_thread(void)
 {
-	kernel_thread(cmm_thread, NULL, 0);
+	kthread_run(cmm_thread, NULL, "cmmthread");
 }
 
 static void
-- 
1.1.6
