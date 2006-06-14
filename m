Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWFNMHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWFNMHo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWFNMHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:07:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:52426 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932318AbWFNMHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:07:42 -0400
Date: Wed, 14 Jun 2006 07:05:59 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: urban@teststation.com, samba@samba.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kthread: convert smbiod
Message-ID: <20060614120559.GC15061@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update smbiod to use kthread instead of deprecated kernel_thread.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 fs/smbfs/smbiod.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

0d9bd631e1f02370126a88fd5af1675ebeede676
diff --git a/fs/smbfs/smbiod.c b/fs/smbfs/smbiod.c
index 481a97a..a737754 100644
--- a/fs/smbfs/smbiod.c
+++ b/fs/smbfs/smbiod.c
@@ -20,6 +20,7 @@
 #include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/net.h>
+#include <linux/kthread.h>
 #include <net/ip.h>
 
 #include <linux/smb_fs.h>
@@ -40,7 +41,7 @@ enum smbiod_state {
 };
 
 static enum smbiod_state smbiod_state = SMBIOD_DEAD;
-static pid_t smbiod_pid;
+static struct task_struct *smbiod_thread = NULL;
 static DECLARE_WAIT_QUEUE_HEAD(smbiod_wait);
 static LIST_HEAD(smb_servers);
 static DEFINE_SPINLOCK(servers_lock);
@@ -67,20 +68,29 @@ void smbiod_wake_up(void)
  */
 static int smbiod_start(void)
 {
-	pid_t pid;
+	struct task_struct *tsk;
+	int err = 0;
+
 	if (smbiod_state != SMBIOD_DEAD)
 		return 0;
 	smbiod_state = SMBIOD_STARTING;
 	__module_get(THIS_MODULE);
 	spin_unlock(&servers_lock);
-	pid = kernel_thread(smbiod, NULL, 0);
-	if (pid < 0)
+	tsk = kthread_run(smbiod, NULL, "smbiod");
+	if (IS_ERR(tsk)) {
+		err = PTR_ERR(tsk);
 		module_put(THIS_MODULE);
+	}
 
 	spin_lock(&servers_lock);
-	smbiod_state = pid < 0 ? SMBIOD_DEAD : SMBIOD_RUNNING;
-	smbiod_pid = pid;
-	return pid;
+	if (err < 0) {
+		smbiod_state = SMBIOD_DEAD;
+		smbiod_thread = NULL;
+	} else {
+		smbiod_state = SMBIOD_RUNNING;
+		smbiod_thread = tsk;
+	}
+	return err;
 }
 
 /*
@@ -290,8 +300,6 @@ out:
  */
 static int smbiod(void *unused)
 {
-	daemonize("smbiod");
-
 	allow_signal(SIGKILL);
 
 	VERBOSE("SMB Kernel thread starting (%d) ...\n", current->pid);
-- 
1.1.6
