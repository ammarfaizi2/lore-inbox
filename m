Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWA2Hha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWA2Hha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWA2Hh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:37:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34527 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750955AbWA2Hfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:35:47 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: [PATCH 5/5] file: Modify struct fown_struct to contain a tref
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>
	<m1hd7na44b.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5iba3xf.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xsza3p4.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 00:35:09 -0700
In-Reply-To: <m18xsza3p4.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Sun, 29 Jan 2006 00:33:27 -0700")
Message-ID: <m14q3na3ma.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


File handles can be requested to send sigio and sigurg
to processes.  This code modifies the code to track
those processes making the interface safe from pid
wrap around issues.

It's not a big deal deal but since it is easy to track
the proceses we might as well.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/fcntl.c         |   45 ++++++++++++++++++++++++---------------------
 fs/file_table.c    |    1 +
 include/linux/fs.h |    1 +
 net/socket.c       |    5 ++++-
 4 files changed, 30 insertions(+), 22 deletions(-)

4c0475dcf7c47c1590c5d7dd06c28a457ebabe33
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 5f96786..af1b02a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -251,8 +251,17 @@ static int setfl(int fd, struct file * f
 static void f_modown(struct file *filp, unsigned long pid,
                      uid_t uid, uid_t euid, int force)
 {
+
+	enum pid_type type;
+	int who = pid;
+	type = PIDTYPE_PID;
+	if (who < 0) {
+		type = PIDTYPE_PGID;
+		who = -who;
+	}
 	write_lock_irq(&filp->f_owner.lock);
 	if (force || !filp->f_owner.pid) {
+		tref_set(&filp->f_owner.tref, tref_get_by_pid(who, type));
 		filp->f_owner.pid = pid;
 		filp->f_owner.uid = uid;
 		filp->f_owner.euid = euid;
@@ -317,7 +326,9 @@ static long do_fcntl(int fd, unsigned in
 		 * current syscall conventions, the only way
 		 * to fix this will be in libc.
 		 */
-		err = filp->f_owner.pid;
+		err = 0;
+		if (filp->f_owner.tref->task)
+			err = filp->f_owner.pid;
 		force_successful_syscall_return();
 		break;
 	case F_SETOWN:
@@ -469,6 +480,7 @@ static void send_sigio_to_task(struct ta
 void send_sigio(struct fown_struct *fown, int fd, int band)
 {
 	struct task_struct *p;
+	enum pid_type type;
 	int pid;
 	
 	read_lock(&fown->lock);
@@ -477,16 +489,11 @@ void send_sigio(struct fown_struct *fown
 		goto out_unlock_fown;
 	
 	read_lock(&tasklist_lock);
-	if (pid > 0) {
-		p = find_task_by_pid(pid);
-		if (p) {
-			send_sigio_to_task(p, fown, fd, band);
-		}
-	} else {
-		do_each_task_pid(-pid, PIDTYPE_PGID, p) {
-			send_sigio_to_task(p, fown, fd, band);
-		} while_each_task_pid(-pid, PIDTYPE_PGID, p);
-	}
+	type = fown->tref->type;
+	p = fown->tref->task;
+	do_each_task(p, type) {
+		send_sigio_to_task(p, fown, fd, band);
+	} while_each_task(p, type);
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
 	read_unlock(&fown->lock);
@@ -503,6 +510,7 @@ int send_sigurg(struct fown_struct *fown
 {
 	struct task_struct *p;
 	int pid, ret = 0;
+	enum pid_type type;
 	
 	read_lock(&fown->lock);
 	pid = fown->pid;
@@ -512,16 +520,11 @@ int send_sigurg(struct fown_struct *fown
 	ret = 1;
 	
 	read_lock(&tasklist_lock);
-	if (pid > 0) {
-		p = find_task_by_pid(pid);
-		if (p) {
-			send_sigurg_to_task(p, fown);
-		}
-	} else {
-		do_each_task_pid(-pid, PIDTYPE_PGID, p) {
-			send_sigurg_to_task(p, fown);
-		} while_each_task_pid(-pid, PIDTYPE_PGID, p);
-	}
+	type = fown->tref->type;
+	p = fown->tref->task;
+	do_each_task(p, type) {
+		send_sigurg_to_task(p, fown);
+	} while_each_task(p, type);
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
 	read_unlock(&fown->lock);
diff --git a/fs/file_table.c b/fs/file_table.c
index 768b581..fb70a30 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -97,6 +97,7 @@ struct file *get_empty_filp(void)
 	rwlock_init(&f->f_owner.lock);
 	/* f->f_version: 0 */
 	INIT_LIST_HEAD(&f->f_u.fu_list);
+	f->f_owner.tref = &init_tref;
 	return f;
 
 over:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 84bb449..35449c2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -587,6 +587,7 @@ extern struct block_device *I_BDEV(struc
 
 struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
+	struct task_ref *tref;	/* Reference to the task/process group */
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
 	void *security;
diff --git a/net/socket.c b/net/socket.c
index b38a263..4294a77 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -855,7 +855,10 @@ static long sock_ioctl(struct file *file
 			break;
 		case FIOGETOWN:
 		case SIOCGPGRP:
-			err = put_user(sock->file->f_owner.pid, (int __user *)argp);
+			pid = 0;
+			if (sock->file->f_owner.tref->task)
+				pid = sock->file->f_owner.pid;
+			err = put_user(pid, (int __user *)argp);
 			break;
 		case SIOCGIFBR:
 		case SIOCSIFBR:
-- 
1.1.5.g3480

