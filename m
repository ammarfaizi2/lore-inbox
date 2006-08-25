Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWHYHZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWHYHZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWHYHZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:25:31 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51650 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751168AbWHYHZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:25:30 -0400
Message-ID: <44EEA5E5.6000509@fr.ibm.com>
Date: Fri, 25 Aug 2006 09:25:25 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Neil Brown <neilb@suse.de>, nfs@lists.sourceforge.net
Subject: kthread: update lockd to use kthread
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert lockd to use kthread rather than kernel_thread, which is deprecated.

Not sure how to test it.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Neil Brown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net

---
 fs/lockd/clntlock.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: 2.6.18-rc4-mm2/fs/lockd/clntlock.c
===================================================================
--- 2.6.18-rc4-mm2.orig/fs/lockd/clntlock.c
+++ 2.6.18-rc4-mm2/fs/lockd/clntlock.c
@@ -14,6 +14,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
 #include <linux/smp_lock.h>
+#include <linux/kthread.h>

 #define NLMDBG_FACILITY		NLMDBG_CLIENT

@@ -181,9 +182,12 @@ nlmclnt_recovery(struct nlm_host *host,
 		return;
 	host->h_nsmstate = newstate;
 	if (!host->h_reclaiming++) {
+		struct task_struct* task;
+
 		nlm_get_host(host);
 		__module_get(THIS_MODULE);
-		if (kernel_thread(reclaimer, host, CLONE_KERNEL) < 0)
+		task = kthread_run(reclaimer, host, "%s-reclaim", host->h_name);
+		if (IS_ERR(task))
 			module_put(THIS_MODULE);
 	}
 }
@@ -196,7 +200,6 @@ reclaimer(void *ptr)
 	struct file_lock *fl, *next;
 	u32 nsmstate;

-	daemonize("%s-reclaim", host->h_name);
 	allow_signal(SIGKILL);

 	/* This one ensures that our parent doesn't terminate while the

