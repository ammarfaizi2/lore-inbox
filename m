Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWFNMGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWFNMGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWFNMGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:06:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:1754 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932280AbWFNMGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:06:53 -0400
Date: Wed, 14 Jun 2006 07:05:10 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: trond.myklebust@fys.uio.no, neilb@cse.unsw.edu.au,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kthread: convert lock to use kthread
Message-ID: <20060614120510.GB15061@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update lockd/clntlock.c to use kthread instead of a deprecated
kernel_thread.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 fs/lockd/clntlock.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

02ed734b2401bdebc92c4edaba5dbbd52ba091a7
diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index bce7444..4de7c59 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -14,6 +14,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
 #include <linux/smp_lock.h>
+#include <linux/kthread.h>
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
@@ -171,6 +172,8 @@ void nlmclnt_prepare_reclaim(struct nlm_
 void
 nlmclnt_recovery(struct nlm_host *host, u32 newstate)
 {
+	struct task_struct *tsk;
+
 	if (host->h_reclaiming++) {
 		if (host->h_nsmstate == newstate)
 			return;
@@ -179,7 +182,9 @@ nlmclnt_recovery(struct nlm_host *host, 
 		nlmclnt_prepare_reclaim(host, newstate);
 		nlm_get_host(host);
 		__module_get(THIS_MODULE);
-		if (kernel_thread(reclaimer, host, CLONE_KERNEL) < 0)
+		tsk = kthread_run(reclaimer, host,
+					"%s-reclaim", host->h_name);
+		if (IS_ERR(tsk))
 			module_put(THIS_MODULE);
 	}
 }
@@ -191,7 +196,6 @@ reclaimer(void *ptr)
 	struct nlm_wait	  *block;
 	struct file_lock *fl, *next;
 
-	daemonize("%s-reclaim", host->h_name);
 	allow_signal(SIGKILL);
 
 	/* This one ensures that our parent doesn't terminate while the
-- 
1.1.6
