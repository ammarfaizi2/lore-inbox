Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVFHXxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVFHXxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVFHXxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:53:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:23486 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261584AbVFHXw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:52:56 -0400
Date: Wed, 8 Jun 2005 18:57:35 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>
Subject: [patch 2/11] lsm stacking: replace void* security with hlist
Message-ID: <20050608235735.GB27314@serge.austin.ibm.com>
References: <20050608235505.GA27298@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608235505.GA27298@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kernel object ->security void*'s with hlists.  This will permit
multiple LSMs to each store information under one kernel object.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 fs/compat.c             |    4 ++--
 fs/exec.c               |    4 ++--
 fs/inode.c              |    2 +-
 include/linux/binfmts.h |    2 +-
 include/linux/fs.h      |    8 ++++----
 include/linux/ipc.h     |    3 ++-
 include/linux/msg.h     |    2 +-
 include/linux/sched.h   |    2 +-
 include/net/sock.h      |    2 +-
 ipc/msg.c               |    2 +-
 ipc/msgutil.c           |    2 +-
 ipc/sem.c               |    2 +-
 ipc/shm.c               |    2 +-
 kernel/fork.c           |    2 +-
 14 files changed, 20 insertions(+), 19 deletions(-)

Index: linux-2.6.12-rc6/fs/compat.c
===================================================================
--- linux-2.6.12-rc6.orig/fs/compat.c
+++ linux-2.6.12-rc6/fs/compat.c
@@ -1519,6 +1519,7 @@ int compat_do_execve(char * filename,
 	bprm->file = file;
 	bprm->filename = filename;
 	bprm->interp = filename;
+	INIT_HLIST_HEAD(&bprm->security);
 	bprm->mm = mm_alloc();
 	retval = -ENOMEM;
 	if (!bprm->mm)
@@ -1575,8 +1576,7 @@ out:
 			__free_page(page);
 	}
 
-	if (bprm->security)
-		security_bprm_free(bprm);
+	security_bprm_free(bprm);
 
 out_mm:
 	if (bprm->mm)
Index: linux-2.6.12-rc6/fs/exec.c
===================================================================
--- linux-2.6.12-rc6.orig/fs/exec.c
+++ linux-2.6.12-rc6/fs/exec.c
@@ -1152,6 +1152,7 @@ int do_execve(char * filename,
 	bprm->file = file;
 	bprm->filename = filename;
 	bprm->interp = filename;
+	INIT_HLIST_HEAD(&bprm->security);
 	bprm->mm = mm_alloc();
 	retval = -ENOMEM;
 	if (!bprm->mm)
@@ -1210,8 +1211,7 @@ out:
 			__free_page(page);
 	}
 
-	if (bprm->security)
-		security_bprm_free(bprm);
+	security_bprm_free(bprm);
 
 out_mm:
 	if (bprm->mm)
Index: linux-2.6.12-rc6/fs/inode.c
===================================================================
--- linux-2.6.12-rc6.orig/fs/inode.c
+++ linux-2.6.12-rc6/fs/inode.c
@@ -132,7 +132,7 @@ static struct inode *alloc_inode(struct 
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
 		inode->i_rdev = 0;
-		inode->i_security = NULL;
+		INIT_HLIST_HEAD(&inode->i_security);
 		inode->dirtied_when = 0;
 		if (security_inode_alloc(inode)) {
 			if (inode->i_sb->s_op->destroy_inode)
Index: linux-2.6.12-rc6/include/linux/binfmts.h
===================================================================
--- linux-2.6.12-rc6.orig/include/linux/binfmts.h
+++ linux-2.6.12-rc6/include/linux/binfmts.h
@@ -29,7 +29,7 @@ struct linux_binprm{
 	struct file * file;
 	int e_uid, e_gid;
 	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
-	void *security;
+	struct hlist_head security;
 	int argc, envc;
 	char * filename;	/* Name of binary as seen by procps */
 	char * interp;		/* Name of the binary really executed. Most
Index: linux-2.6.12-rc6/include/linux/fs.h
===================================================================
--- linux-2.6.12-rc6.orig/include/linux/fs.h
+++ linux-2.6.12-rc6/include/linux/fs.h
@@ -477,7 +477,7 @@ struct inode {
 	unsigned int		i_flags;
 
 	atomic_t		i_writecount;
-	void			*i_security;
+	struct hlist_head	i_security;
 	union {
 		void		*generic_ip;
 	} u;
@@ -551,7 +551,7 @@ struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
-	void *security;
+	struct hlist_head security;
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
 
@@ -589,7 +589,7 @@ struct file {
 
 	size_t			f_maxcount;
 	unsigned long		f_version;
-	void			*f_security;
+	struct hlist_head	f_security;
 
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
@@ -775,7 +775,7 @@ struct super_block {
 	int			s_syncing;
 	int			s_need_sync_fs;
 	atomic_t		s_active;
-	void                    *s_security;
+ 	struct hlist_head	s_security;
 	struct xattr_handler	**s_xattr;
 
 	struct list_head	s_inodes;	/* all inodes */
Index: linux-2.6.12-rc6/include/linux/ipc.h
===================================================================
--- linux-2.6.12-rc6.orig/include/linux/ipc.h
+++ linux-2.6.12-rc6/include/linux/ipc.h
@@ -2,6 +2,7 @@
 #define _LINUX_IPC_H
 
 #include <linux/types.h>
+#include <linux/list.h>
 
 #define IPC_PRIVATE ((__kernel_key_t) 0)  
 
@@ -65,7 +66,7 @@ struct kern_ipc_perm
 	gid_t		cgid;
 	mode_t		mode; 
 	unsigned long	seq;
-	void		*security;
+	struct hlist_head security;
 };
 
 #endif /* __KERNEL__ */
Index: linux-2.6.12-rc6/include/linux/msg.h
===================================================================
--- linux-2.6.12-rc6.orig/include/linux/msg.h
+++ linux-2.6.12-rc6/include/linux/msg.h
@@ -70,7 +70,7 @@ struct msg_msg {
 	long  m_type;          
 	int m_ts;           /* message text size */
 	struct msg_msgseg* next;
-	void *security;
+	struct hlist_head security;
 	/* the actual message follows immediately */
 };
 
Index: linux-2.6.12-rc6/include/linux/sched.h
===================================================================
--- linux-2.6.12-rc6.orig/include/linux/sched.h
+++ linux-2.6.12-rc6/include/linux/sched.h
@@ -690,7 +690,7 @@ struct task_struct {
 	void *notifier_data;
 	sigset_t *notifier_mask;
 	
-	void *security;
+	struct hlist_head security;
 	struct audit_context *audit_context;
 	seccomp_t seccomp;
 
Index: linux-2.6.12-rc6/include/net/sock.h
===================================================================
--- linux-2.6.12-rc6.orig/include/net/sock.h
+++ linux-2.6.12-rc6/include/net/sock.h
@@ -240,7 +240,7 @@ struct sock {
 	struct sk_buff		*sk_send_head;
 	__u32			sk_sndmsg_off;
 	int			sk_write_pending;
-	void			*sk_security;
+	struct hlist_head	sk_security;
 	void			(*sk_state_change)(struct sock *sk);
 	void			(*sk_data_ready)(struct sock *sk, int bytes);
 	void			(*sk_write_space)(struct sock *sk);
Index: linux-2.6.12-rc6/ipc/msg.c
===================================================================
--- linux-2.6.12-rc6.orig/ipc/msg.c
+++ linux-2.6.12-rc6/ipc/msg.c
@@ -99,7 +99,7 @@ static int newque (key_t key, int msgflg
 	msq->q_perm.mode = (msgflg & S_IRWXUGO);
 	msq->q_perm.key = key;
 
-	msq->q_perm.security = NULL;
+	INIT_HLIST_HEAD(&msq->q_perm.security);
 	retval = security_msg_queue_alloc(msq);
 	if (retval) {
 		ipc_rcu_putref(msq);
Index: linux-2.6.12-rc6/ipc/msgutil.c
===================================================================
--- linux-2.6.12-rc6.orig/ipc/msgutil.c
+++ linux-2.6.12-rc6/ipc/msgutil.c
@@ -41,7 +41,7 @@ struct msg_msg *load_msg(const void __us
 		return ERR_PTR(-ENOMEM);
 
 	msg->next = NULL;
-	msg->security = NULL;
+	INIT_HLIST_HEAD(&msg->security);
 
 	if (copy_from_user(msg + 1, src, alen)) {
 		err = -EFAULT;
Index: linux-2.6.12-rc6/ipc/sem.c
===================================================================
--- linux-2.6.12-rc6.orig/ipc/sem.c
+++ linux-2.6.12-rc6/ipc/sem.c
@@ -178,7 +178,7 @@ static int newary (key_t key, int nsems,
 	sma->sem_perm.mode = (semflg & S_IRWXUGO);
 	sma->sem_perm.key = key;
 
-	sma->sem_perm.security = NULL;
+	INIT_HLIST_HEAD(&sma->sem_perm.security);
 	retval = security_sem_alloc(sma);
 	if (retval) {
 		ipc_rcu_putref(sma);
Index: linux-2.6.12-rc6/ipc/shm.c
===================================================================
--- linux-2.6.12-rc6.orig/ipc/shm.c
+++ linux-2.6.12-rc6/ipc/shm.c
@@ -199,7 +199,7 @@ static int newseg (key_t key, int shmflg
 	shp->shm_flags = (shmflg & S_IRWXUGO);
 	shp->mlock_user = NULL;
 
-	shp->shm_perm.security = NULL;
+	INIT_HLIST_HEAD(&shp->shm_perm.security);
 	error = security_shm_alloc(shp);
 	if (error) {
 		ipc_rcu_putref(shp);
Index: linux-2.6.12-rc6/kernel/fork.c
===================================================================
--- linux-2.6.12-rc6.orig/kernel/fork.c
+++ linux-2.6.12-rc6/kernel/fork.c
@@ -936,7 +936,7 @@ static task_t *copy_process(unsigned lon
 
 	p->lock_depth = -1;		/* -1 = no lock */
 	do_posix_clock_monotonic_gettime(&p->start_time);
-	p->security = NULL;
+	INIT_HLIST_HEAD(&p->security);
 	p->io_context = NULL;
 	p->io_wait = NULL;
 	p->audit_context = NULL;
