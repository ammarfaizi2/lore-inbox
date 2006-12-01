Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161782AbWLAXsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161782AbWLAXsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967720AbWLAXsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:48:39 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:45273 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S967715AbWLAXsi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:48:38 -0500
Date: Sat, 2 Dec 2006 02:48:26 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] introduce put_pid_rcu() to fix unsafe put_pid(vc->vt_pid)
Message-ID: <20061201234826.GA9511@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile tested.

drivers/char/vt_ioctl.c changes vc->vt_pid doing

	put_pid(xchg(&vc->vt_pid, ...));

This is unsafe, put_pid() can actually free the memory while vc->vt_pid is
still used by kill_pid(vc->vt_pid).

Add a new helper, put_pid_rcu(), which frees "struct pid" via rcu callback
and convert vt_ioctl.c to use it.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

 include/linux/pid.h     |    2 ++
 kernel/pid.c            |   18 ++++++++++++++++++
 drivers/char/vt_ioctl.c |   22 ++++++++++++++++++----
 3 files changed, 38 insertions(+), 4 deletions(-)

--- 19-rc6/include/linux/pid.h~vt_pid	2006-10-22 18:24:02.000000000 +0400
+++ 19-rc6/include/linux/pid.h	2006-12-02 01:38:59.000000000 +0300
@@ -64,6 +64,8 @@ static inline struct pid *get_pid(struct
 }
 
 extern void FASTCALL(put_pid(struct pid *pid));
+extern void put_pid_rcu(struct pid *pid);
+
 extern struct task_struct *FASTCALL(pid_task(struct pid *pid, enum pid_type));
 extern struct task_struct *FASTCALL(get_pid_task(struct pid *pid,
 						enum pid_type));
--- 19-rc6/kernel/pid.c~vt_pid	2006-10-22 18:24:03.000000000 +0400
+++ 19-rc6/kernel/pid.c	2006-12-02 01:35:15.000000000 +0300
@@ -196,6 +196,24 @@ fastcall void free_pid(struct pid *pid)
 	call_rcu(&pid->rcu, delayed_put_pid);
 }
 
+static void delayed_free_pid(struct rcu_head *rhp)
+{
+	struct pid *pid = container_of(rhp, struct pid, rcu);
+	kmem_cache_free(pid_cachep, pid);
+}
+
+void put_pid_rcu(struct pid *pid)
+{
+	if (!pid)
+		return;
+	/*
+	 * ->count can't go to 0 unless delayed_put_pid() was already
+	 * called (RCU owns a reference), so we can re-use pid->rcu.
+	 */
+	if (atomic_dec_and_test(&pid->count))
+		call_rcu(&pid->rcu, delayed_free_pid);
+}
+
 struct pid *alloc_pid(void)
 {
 	struct pid *pid;
--- 19-rc6/drivers/char/vt_ioctl.c~vt_pid	2006-10-22 18:23:58.000000000 +0400
+++ 19-rc6/drivers/char/vt_ioctl.c	2006-12-02 02:44:48.000000000 +0300
@@ -358,6 +358,20 @@ do_unimap_ioctl(int cmd, struct unimapde
 	return 0;
 }
 
+static inline void set_vt_pid(struct vc_data *vc, struct pid *pid)
+{
+	put_pid_rcu(xchg(&vc->vt_pid, pid));
+}
+
+static int kill_vt_pid(struct vc_data *vc, int sig)
+{
+	int ret;
+	rcu_read_lock();
+	ret = kill_pid(rcu_dereference(vc->vt_pid), sig, 1);
+	rcu_read_unlock();
+	return ret;
+}
+
 /*
  * We handle the console-specific ioctl's here.  We allow the
  * capability to modify any console, not just the fg_console. 
@@ -672,7 +686,7 @@ int vt_ioctl(struct tty_struct *tty, str
 		vc->vt_mode = tmp;
 		/* the frsig is ignored, so we set it to 0 */
 		vc->vt_mode.frsig = 0;
-		put_pid(xchg(&vc->vt_pid, get_pid(task_pid(current))));
+		set_vt_pid(vc, get_pid(task_pid(current)));
 		/* no switch is required -- saw@shade.msu.ru */
 		vc->vt_newvt = -1;
 		release_console_sem();
@@ -1063,7 +1077,7 @@ void reset_vc(struct vc_data *vc)
 	vc->vt_mode.relsig = 0;
 	vc->vt_mode.acqsig = 0;
 	vc->vt_mode.frsig = 0;
-	put_pid(xchg(&vc->vt_pid, NULL));
+	set_vt_pid(vc, NULL);
 	vc->vt_newvt = -1;
 	if (!in_interrupt())    /* Via keyboard.c:SAK() - akpm */
 		reset_palette(vc);
@@ -1114,7 +1128,7 @@ static void complete_change_console(stru
 		 * tell us if the process has gone or something else
 		 * is awry
 		 */
-		if (kill_pid(vc->vt_pid, vc->vt_mode.acqsig, 1) != 0) {
+		if (kill_vt_pid(vc, vc->vt_mode.acqsig) != 0) {
 		/*
 		 * The controlling process has died, so we revert back to
 		 * normal operation. In this case, we'll also change back
@@ -1174,7 +1188,7 @@ void change_console(struct vc_data *new_
 		 * tell us if the process has gone or something else
 		 * is awry
 		 */
-		if (kill_pid(vc->vt_pid, vc->vt_mode.relsig, 1) == 0) {
+		if (kill_vt_pid(vc, vc->vt_mode.relsig) == 0) {
 			/*
 			 * It worked. Mark the vt to switch to and
 			 * return. The process needs to send us a

