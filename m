Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268004AbUJDQX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268004AbUJDQX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 12:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUJDQX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 12:23:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54421 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268004AbUJDQXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 12:23:22 -0400
Message-ID: <41617958.2020406@RedHat.com>
Date: Mon, 04 Oct 2004 12:24:56 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nfs@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] lockd 
Content-Type: multipart/mixed;
 boundary="------------040707060907060701080609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040707060907060701080609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hey Neil,

Attached is a patch that fixes some potential SMP races
in the lockd code that were identified by the SLEEP_ON_BKLCHECK
that was (at one time) in the -mm tree...

Signed-Off-By: Steve Dickson <SteveD@RedHat.com>



--------------040707060907060701080609
Content-Type: text/x-patch;
 name="linux-2.6.9-rc3-mm2-lockd-smprace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.9-rc3-mm2-lockd-smprace.patch"

--- 2.6.9-rc3-mm2/fs/lockd/clntlock.c.old	2004-10-04 09:32:20.404018000 -0400
+++ 2.6.9-rc3-mm2/fs/lockd/clntlock.c	2004-10-04 11:29:38.940621000 -0400
@@ -50,14 +50,19 @@ nlmclnt_block(struct nlm_host *host, str
 	struct nlm_wait	block, **head;
 	int		err;
 	u32		pstate;
+	wait_queue_t __wait;
 
 	block.b_host   = host;
 	block.b_lock   = fl;
-	init_waitqueue_head(&block.b_wait);
 	block.b_status = NLM_LCK_BLOCKED;
+	init_waitqueue_entry(&__wait, current);
+	init_waitqueue_head(&block.b_wait);
+	add_wait_queue(&block.b_wait, &__wait);
+
 	block.b_next   = nlm_blocked;
 	nlm_blocked    = &block;
 
+
 	/* Remember pseudo nsm state */
 	pstate = host->h_state;
 
@@ -69,7 +74,7 @@ nlmclnt_block(struct nlm_host *host, str
 	 * a 1 minute timeout would do. See the comment before
 	 * nlmclnt_lock for an explanation.
 	 */
-	sleep_on_timeout(&block.b_wait, 30*HZ);
+	schedule_timeout(30*HZ);
 
 	for (head = &nlm_blocked; *head; head = &(*head)->b_next) {
 		if (*head == &block) {
@@ -77,6 +82,7 @@ nlmclnt_block(struct nlm_host *host, str
 			break;
 		}
 	}
+	remove_wait_queue(&block.b_wait, &__wait);
 
 	if (!signalled()) {
 		*statp = block.b_status;
--- 2.6.9-rc3-mm2/fs/lockd/svc.c.old	2004-10-04 09:32:20.417019000 -0400
+++ 2.6.9-rc3-mm2/fs/lockd/svc.c	2004-10-04 11:27:54.868205000 -0400
@@ -278,6 +278,8 @@ void
 lockd_down(void)
 {
 	static int warned;
+	wait_queue_t __wait;
+	int retries=0;
 
 	down(&nlmsvc_sema);
 	if (nlmsvc_users) {
@@ -294,20 +296,33 @@ lockd_down(void)
 	warned = 0;
 
 	kill_proc(nlmsvc_pid, SIGKILL, 1);
+
+	init_waitqueue_entry(&__wait, current);
+	add_wait_queue(&lockd_exit,  &__wait);
+
 	/*
 	 * Wait for the lockd process to exit, but since we're holding
 	 * the lockd semaphore, we can't wait around forever ...
 	 */
 	clear_thread_flag(TIF_SIGPENDING);
-	interruptible_sleep_on_timeout(&lockd_exit, HZ);
-	if (nlmsvc_pid) {
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	while (nlmsvc_pid) {
+
+		schedule_timeout(HZ);
+		if (retries++ < 3)
+			continue;
+
 		printk(KERN_WARNING 
 			"lockd_down: lockd failed to exit, clearing pid\n");
 		nlmsvc_pid = 0;
 	}
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&lockd_exit,  &__wait);
+
 	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
+
 out:
 	up(&nlmsvc_sema);
 }

--------------040707060907060701080609--
