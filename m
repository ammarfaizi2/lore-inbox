Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWBFUIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWBFUIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWBFUIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:08:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48768 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932362AbWBFUIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:08:22 -0500
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
Subject: [RFC][PATCH 18/20] posix-mqueue: Make mqueues work with pspspaces
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
	<m1vevsjlxa.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r76gjlua.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:05:34 -0700
In-Reply-To: <m1r76gjlua.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 13:03:57 -0700")
Message-ID: <m1mzh4jlrl.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 ipc/mqueue.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

04e0f90a315df40b07d316c884a28c58eed4de33
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 59302fc..5c71ae0 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -25,6 +25,7 @@
 #include <linux/netlink.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
+#include <linux/pspace.h>
 #include <net/sock.h>
 #include "util.h"
 
@@ -69,6 +70,7 @@ struct mqueue_inode_info {
 	struct mq_attr attr;
 
 	struct sigevent notify;
+	struct pspace *notify_pspace;
 	pid_t notify_owner;
 	struct user_struct *user;	/* user who created, for accounting */
 	struct sock *notify_sock;
@@ -131,6 +133,7 @@ static struct inode *mqueue_get_inode(st
 			INIT_LIST_HEAD(&info->e_wait_q[0].list);
 			INIT_LIST_HEAD(&info->e_wait_q[1].list);
 			info->messages = NULL;
+			info->notify_pspace = NULL;
 			info->notify_owner = 0;
 			info->qsize = 0;
 			info->user = NULL;	/* set when all is ok */
@@ -250,6 +253,9 @@ static void mqueue_delete_inode(struct i
 	kfree(info->messages);
 	spin_unlock(&info->lock);
 
+	put_pspace(info->notify_pspace);
+	info->notify_pspace = NULL;
+
 	clear_inode(inode);
 
 	mq_bytes = (info->attr.mq_maxmsg * sizeof(struct msg_msg *) +
@@ -360,7 +366,8 @@ static int mqueue_flush_file(struct file
 	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
 
 	spin_lock(&info->lock);
-	if (current->tgid == info->notify_owner)
+	if ((current->tgid == info->notify_owner) &&
+	    (current->pspace == info->notify_pspace))
 		remove_notification(info);
 
 	spin_unlock(&info->lock);
@@ -516,7 +523,8 @@ static void __do_notify(struct mqueue_in
 			sig_i.si_uid = current->uid;
 
 			kill_proc_info(info->notify.sigev_signo,
-				       &sig_i, info->notify_owner);
+				       &sig_i, 
+				       info->notify_pspace, info->notify_owner);
 			break;
 		case SIGEV_THREAD:
 			set_cookie(info->notify_cookie, NOTIFY_WOKENUP);
@@ -525,7 +533,9 @@ static void __do_notify(struct mqueue_in
 			break;
 		}
 		/* after notification unregisters process */
+		put_pspace(info->notify_pspace);
 		info->notify_owner = 0;
+		info->notify_pspace = NULL;
 	}
 	wake_up(&info->wait_q);
 }
@@ -568,6 +578,8 @@ static void remove_notification(struct m
 		set_cookie(info->notify_cookie, NOTIFY_REMOVED);
 		netlink_sendskb(info->notify_sock, info->notify_cookie, 0);
 	}
+	put_pspace(info->notify_pspace);
+	info->notify_pspace = NULL;
 	info->notify_owner = 0;
 }
 
@@ -1042,7 +1054,8 @@ retry:
 	ret = 0;
 	spin_lock(&info->lock);
 	if (u_notification == NULL) {
-		if (info->notify_owner == current->tgid) {
+		if ((info->notify_owner == current->tgid) &&
+		    (info->notify_pspace == current->pspace)) {
 			remove_notification(info);
 			inode->i_atime = inode->i_ctime = CURRENT_TIME;
 		}
@@ -1066,7 +1079,9 @@ retry:
 			info->notify.sigev_notify = SIGEV_SIGNAL;
 			break;
 		}
+		info->notify_pspace = current->pspace;
 		info->notify_owner = current->tgid;
+		get_pspace(info->notify_pspace);
 		inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	}
 	spin_unlock(&info->lock);
-- 
1.1.5.g3480

