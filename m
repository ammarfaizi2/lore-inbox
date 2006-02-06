Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWBFT5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWBFT5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWBFT5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:57:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1664 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932346AbWBFT5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:57:18 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
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
Subject: [RFC][PATCH 12/20] fcntl: Update fcntl to work with pspaces.
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:54:37 -0700
In-Reply-To: <m1hd7cl0yp.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:51:58 -0700")
Message-ID: <m1d5i0l0ua.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/fcntl.c         |   25 ++++++++++++++++---------
 include/linux/fs.h |    1 +
 2 files changed, 17 insertions(+), 9 deletions(-)

34f261442c7ac3c160830b86aefd5b15df68de9d
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 5f96786..0a41df8 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -18,6 +18,7 @@
 #include <linux/ptrace.h>
 #include <linux/signal.h>
 #include <linux/rcupdate.h>
+#include <linux/pspace.h>
 
 #include <asm/poll.h>
 #include <asm/siginfo.h>
@@ -248,11 +249,14 @@ static int setfl(int fd, struct file * f
 	return error;
 }
 
-static void f_modown(struct file *filp, unsigned long pid,
+static void f_modown(struct file *filp, struct pspace *pspace, unsigned long pid,
                      uid_t uid, uid_t euid, int force)
 {
 	write_lock_irq(&filp->f_owner.lock);
 	if (force || !filp->f_owner.pid) {
+		put_pspace(filp->f_owner.pspace);
+		get_pspace(pspace);
+		filp->f_owner.pspace = pspace;
 		filp->f_owner.pid = pid;
 		filp->f_owner.uid = uid;
 		filp->f_owner.euid = euid;
@@ -268,7 +272,7 @@ int f_setown(struct file *filp, unsigned
 	if (err)
 		return err;
 
-	f_modown(filp, arg, current->uid, current->euid, force);
+	f_modown(filp, current->pspace, arg, current->uid, current->euid, force);
 	return 0;
 }
 
@@ -276,7 +280,7 @@ EXPORT_SYMBOL(f_setown);
 
 void f_delown(struct file *filp)
 {
-	f_modown(filp, 0, 0, 0, 1);
+	f_modown(filp, NULL, 0, 0, 0, 1);
 }
 
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
@@ -318,6 +322,9 @@ static long do_fcntl(int fd, unsigned in
 		 * to fix this will be in libc.
 		 */
 		err = filp->f_owner.pid;
+		/* Don't return an owner in a different pspace */
+		if (filp->f_owner.pspace != current->pspace)
+			err = 0;
 		force_successful_syscall_return();
 		break;
 	case F_SETOWN:
@@ -478,14 +485,14 @@ void send_sigio(struct fown_struct *fown
 	
 	read_lock(&tasklist_lock);
 	if (pid > 0) {
-		p = find_task_by_pid(pid);
+		p = find_task_by_pid(fown->pspace, pid);
 		if (p) {
 			send_sigio_to_task(p, fown, fd, band);
 		}
 	} else {
-		do_each_task_pid(-pid, PIDTYPE_PGID, p) {
+		do_each_task_pid(fown->pspace, -pid, PIDTYPE_PGID, p) {
 			send_sigio_to_task(p, fown, fd, band);
-		} while_each_task_pid(-pid, PIDTYPE_PGID, p);
+		} while_each_task_pid(fown->pspace, -pid, PIDTYPE_PGID, p);
 	}
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
@@ -513,14 +520,14 @@ int send_sigurg(struct fown_struct *fown
 	
 	read_lock(&tasklist_lock);
 	if (pid > 0) {
-		p = find_task_by_pid(pid);
+		p = find_task_by_pid(fown->pspace, pid);
 		if (p) {
 			send_sigurg_to_task(p, fown);
 		}
 	} else {
-		do_each_task_pid(-pid, PIDTYPE_PGID, p) {
+		do_each_task_pid(fown->pspace, -pid, PIDTYPE_PGID, p) {
 			send_sigurg_to_task(p, fown);
-		} while_each_task_pid(-pid, PIDTYPE_PGID, p);
+		} while_each_task_pid(fown->pspace, -pid, PIDTYPE_PGID, p);
 	}
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e059da9..cabb1b6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -589,6 +589,7 @@ extern struct block_device *I_BDEV(struc
 
 struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
+	struct pspace *pspace;	/* process space of owner pid */
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
 	void *security;
-- 
1.1.5.g3480

