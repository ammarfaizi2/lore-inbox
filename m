Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVKAT6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVKAT6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVKAT6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:58:42 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:6096 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751277AbVKAT6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:58:41 -0500
Date: Tue, 1 Nov 2005 11:58:58 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, oleg@tv-sign.ru
Subject: [PATCH] Fix SIGSTOP locking issue in -rt
Message-ID: <20051101195857.GA7098@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The following patch fixes a locking issue in -rt signals, where the
job-control signals drop sighand_lock momentarily during signal handling.
This interacts badly with the RCU-ification of unicast signal delivery.
The fix is simply to acquire tasklist_lock for job-control signals, since
these typically do not have stringent scalability or latency requirements.

These same changes would be useful in recent -mm.

Signed-off-by: <paulmck@us.ibm.com>

---

 signal.c |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -urpNa -X dontdiff linux-2.6.14-rc5-rt2-ckhandRCUfix/kernel/signal.c linux-2.6.14-rc5-rt2-SIGSTOP/kernel/signal.c
--- linux-2.6.14-rc5-rt2-ckhandRCUfix/kernel/signal.c	2005-10-31 22:28:45.000000000 -0800
+++ linux-2.6.14-rc5-rt2-SIGSTOP/kernel/signal.c	2005-11-01 09:32:29.000000000 -0800
@@ -1207,13 +1207,21 @@ int
 kill_proc_info(int sig, struct siginfo *info, pid_t pid)
 {
 	int error;
+	int acquired_tasklist_lock = 0;
 	struct task_struct *p;
 
 	rcu_read_lock();
+	if (unlikely(sig_kernel_stop(sig) || sig == SIGCONT)) {
+		read_lock(&tasklist_lock);
+		acquired_tasklist_lock = 1;
+	}
 	p = find_task_by_pid(pid);
 	error = -ESRCH;
 	if (p)
 		error = group_send_sig_info(sig, info, p);
+	if (unlikely(acquired_tasklist_lock)) {
+		read_unlock(&tasklist_lock);
+	}
 	rcu_read_unlock();
 	return error;
 }
