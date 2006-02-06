Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWBFUFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWBFUFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWBFUFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:05:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35200 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932356AbWBFUEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:04:53 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: <linux-kernel@vger.kernel.org>, <vserver@list.linux-vserver.org>,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [PATCH 16/20] nfs: Don't use pids to track the lockd server
 process.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
	<m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd7cl0yp.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5i0l0ua.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xsol0p9.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q3cl0mk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zml4jlzk.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:02:09 -0700
In-Reply-To: <m1zml4jlzk.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 13:00:47 -0700")
Message-ID: <m1vevsjlxa.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/lockd/svc.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

8879803b195822f0a4e6f1b05297f5ffe3f62ad1
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 71a30b4..e5c1d5c 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -45,7 +45,7 @@ EXPORT_SYMBOL(nlmsvc_ops);
 
 static DECLARE_MUTEX(nlmsvc_sema);
 static unsigned int		nlmsvc_users;
-static pid_t			nlmsvc_pid;
+static struct task_struct *	nlmsvc_task;
 int				nlmsvc_grace_period;
 unsigned long			nlmsvc_timeout;
 
@@ -111,7 +111,8 @@ lockd(struct svc_rqst *rqstp)
 	/*
 	 * Let our maker know we're running.
 	 */
-	nlmsvc_pid = current->pid;
+	get_task_struct(current);
+	nlmsvc_task = current;
 	up(&lockd_start);
 
 	daemonize("lockd");
@@ -135,7 +136,7 @@ lockd(struct svc_rqst *rqstp)
 	 * NFS mount or NFS daemon has gone away, and we've been sent a
 	 * signal, or else another process has taken over our job.
 	 */
-	while ((nlmsvc_users || !signalled()) && nlmsvc_pid == current->pid) {
+	while ((nlmsvc_users || !signalled()) && nlmsvc_task == current) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
 
 		if (signalled()) {
@@ -184,11 +185,12 @@ lockd(struct svc_rqst *rqstp)
 	 * Check whether there's a new lockd process before
 	 * shutting down the hosts and clearing the slot.
 	 */
-	if (!nlmsvc_pid || current->pid == nlmsvc_pid) {
+	if (!nlmsvc_task || current == nlmsvc_task) {
 		if (nlmsvc_ops)
 			nlmsvc_invalidate_all();
 		nlm_shutdown_hosts();
-		nlmsvc_pid = 0;
+		put_task_struct(nlmsvc_task);
+		nlmsvc_task = NULL;
 	} else
 		printk(KERN_DEBUG
 			"lockd: new process, skipping host shutdown\n");
@@ -224,7 +226,7 @@ lockd_up(void)
 	/*
 	 * Check whether we're already up and running.
 	 */
-	if (nlmsvc_pid)
+	if (nlmsvc_task)
 		goto out;
 
 	/*
@@ -290,26 +292,27 @@ lockd_down(void)
 		if (--nlmsvc_users)
 			goto out;
 	} else
-		printk(KERN_WARNING "lockd_down: no users! pid=%d\n", nlmsvc_pid);
+		printk(KERN_WARNING "lockd_down: no users! pid=%d\n", nlmsvc_task->pid);
 
-	if (!nlmsvc_pid) {
+	if (!nlmsvc_task) {
 		if (warned++ == 0)
 			printk(KERN_WARNING "lockd_down: no lockd running.\n"); 
 		goto out;
 	}
 	warned = 0;
 
-	kill_proc(nlmsvc_pid, SIGKILL, 1);
+	send_group_sig_info(SIGKILL, SEND_SIG_PRIV, nlmsvc_task);
 	/*
 	 * Wait for the lockd process to exit, but since we're holding
 	 * the lockd semaphore, we can't wait around forever ...
 	 */
 	clear_thread_flag(TIF_SIGPENDING);
 	interruptible_sleep_on_timeout(&lockd_exit, HZ);
-	if (nlmsvc_pid) {
+	if (nlmsvc_task) {
 		printk(KERN_WARNING 
 			"lockd_down: lockd failed to exit, clearing pid\n");
-		nlmsvc_pid = 0;
+		put_task_struct(nlmsvc_task);
+		nlmsvc_task = NULL;
 	}
 	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending();
-- 
1.1.5.g3480

