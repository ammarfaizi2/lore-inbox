Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbUKDV7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbUKDV7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUKDV7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:59:01 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6865 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262448AbUKDV4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:56:40 -0500
Subject: Re: [RFC] [PATCH] [1/6] LSM Stacking: Replace LSM void* with arrays
From: Serge Hallyn <hallyn@cs.wm.edu>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1099609471.2096.10.camel@serge.austin.ibm.com>
References: <1099609471.2096.10.camel@serge.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1099609599.2096.13.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Nov 2004 17:06:44 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch replaced the LSM security fields on kernel
objects with an array of pointers, so that more than 1 LSM
can annotate information on kernel objects.

-serge

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-rc1-bk12-stack/fs/exec.c
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/fs/exec.c	2004-11-02
19:56:00.004087472 -0600
+++ linux-2.6.10-rc1-bk12-stack/fs/exec.c	2004-11-02 19:57:14.722728512
-0600
@@ -1164,8 +1164,7 @@
 			__free_page(page);
 	}
 
-	if (bprm->security)
-		security_bprm_free(bprm);
+	security_bprm_free(bprm);
 
 out_mm:
 	if (bprm->mm)
Index: linux-2.6.10-rc1-bk12-stack/fs/inode.c
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/fs/inode.c	2004-11-02
19:55:49.602668728 -0600
+++ linux-2.6.10-rc1-bk12-stack/fs/inode.c	2004-11-02 19:57:14.723728360
-0600
@@ -113,6 +113,7 @@
 
 	if (inode) {
 		struct address_space * const mapping = &inode->i_data;
+		int i;
 
 		inode->i_sb = sb;
 		inode->i_blkbits = sb->s_blocksize_bits;
@@ -134,7 +135,8 @@
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
 		inode->i_rdev = 0;
-		inode->i_security = NULL;
+		for (i=0; i<CONFIG_NUM_LSMS; i++)
+			inode->i_security[i] = NULL;
 		inode->dirtied_when = 0;
 		if (security_inode_alloc(inode)) {
 			if (inode->i_sb->s_op->destroy_inode)
Index: linux-2.6.10-rc1-bk12-stack/include/linux/binfmts.h
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/include/linux/binfmts.h	2004-10-18
16:54:30.000000000 -0500
+++ linux-2.6.10-rc1-bk12-stack/include/linux/binfmts.h	2004-11-02
19:57:14.737726232 -0600
@@ -29,7 +29,7 @@
 	struct file * file;
 	int e_uid, e_gid;
 	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
-	void *security;
+	void *security[CONFIG_NUM_LSMS];
 	int argc, envc;
 	char * filename;	/* Name of binary as seen by procps */
 	char * interp;		/* Name of the binary really executed. Most
Index: linux-2.6.10-rc1-bk12-stack/include/linux/fs.h
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/include/linux/fs.h	2004-11-02
19:56:00.579999920 -0600
+++ linux-2.6.10-rc1-bk12-stack/include/linux/fs.h	2004-11-02
19:57:14.739725928 -0600
@@ -479,7 +479,7 @@
 	unsigned int		i_flags;
 
 	atomic_t		i_writecount;
-	void			*i_security;
+	void			*i_security[CONFIG_NUM_LSMS];
 	union {
 		void		*generic_ip;
 	} u;
@@ -553,7 +553,7 @@
 	rwlock_t lock;          /* protects pid, uid, euid fields */
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
-	void *security;
+	void *security[CONFIG_NUM_LSMS];
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
 
@@ -589,7 +589,7 @@
 	struct file_ra_state	f_ra;
 
 	unsigned long		f_version;
-	void			*f_security;
+	void			*f_security[CONFIG_NUM_LSMS];
 
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
@@ -773,7 +773,7 @@
 	int			s_syncing;
 	int			s_need_sync_fs;
 	atomic_t		s_active;
-	void                    *s_security;
+	void                    *s_security[CONFIG_NUM_LSMS];
 	struct xattr_handler	**s_xattr;
 
 	struct list_head	s_dirty;	/* dirty inodes */
Index: linux-2.6.10-rc1-bk12-stack/include/linux/ipc.h
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/include/linux/ipc.h	2004-10-18
16:53:05.000000000 -0500
+++ linux-2.6.10-rc1-bk12-stack/include/linux/ipc.h	2004-11-02
19:57:14.745725016 -0600
@@ -65,7 +65,7 @@
 	gid_t		cgid;
 	mode_t		mode; 
 	unsigned long	seq;
-	void		*security;
+	void		*security[CONFIG_NUM_LSMS];
 };
 
 #endif /* __KERNEL__ */
Index: linux-2.6.10-rc1-bk12-stack/include/linux/msg.h
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/include/linux/msg.h	2004-10-18
16:54:31.000000000 -0500
+++ linux-2.6.10-rc1-bk12-stack/include/linux/msg.h	2004-11-02
19:57:14.745725016 -0600
@@ -70,7 +70,7 @@
 	long  m_type;          
 	int m_ts;           /* message text size */
 	struct msg_msgseg* next;
-	void *security;
+	void *security[CONFIG_NUM_LSMS];
 	/* the actual message follows immediately */
 };
 
Index: linux-2.6.10-rc1-bk12-stack/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/include/linux/sched.h	2004-11-02
19:56:00.667986544 -0600
+++ linux-2.6.10-rc1-bk12-stack/include/linux/sched.h	2004-11-02
19:57:14.746724864 -0600
@@ -627,7 +627,7 @@
 	void *notifier_data;
 	sigset_t *notifier_mask;
 	
-	void *security;
+	void *security[CONFIG_NUM_LSMS];
 	struct audit_context *audit_context;
 
 /* Thread group tracking */
Index: linux-2.6.10-rc1-bk12-stack/include/net/sock.h
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/include/net/sock.h	2004-11-02
19:56:00.764971800 -0600
+++ linux-2.6.10-rc1-bk12-stack/include/net/sock.h	2004-11-02
19:57:14.747724712 -0600
@@ -254,7 +254,7 @@
 	__u32			sk_sndmsg_off;
 	struct sk_buff		*sk_send_head;
 	int			sk_write_pending;
-	void			*sk_security;
+	void			*sk_security[CONFIG_NUM_LSMS];
 	__u8			sk_queue_shrunk;
 	/* three bytes hole, try to pack */
 	void			(*sk_state_change)(struct sock *sk);
Index: linux-2.6.10-rc1-bk12-stack/ipc/msg.c
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/ipc/msg.c	2004-11-02
19:56:00.805965568 -0600
+++ linux-2.6.10-rc1-bk12-stack/ipc/msg.c	2004-11-02 19:57:14.747724712
-0600
@@ -90,6 +90,7 @@
 	int id;
 	int retval;
 	struct msg_queue *msq;
+	int i;
 
 	msq  = ipc_rcu_alloc(sizeof(*msq));
 	if (!msq) 
@@ -98,7 +99,9 @@
 	msq->q_perm.mode = (msgflg & S_IRWXUGO);
 	msq->q_perm.key = key;
 
-	msq->q_perm.security = NULL;
+	for (i=0; i<CONFIG_NUM_LSMS; i++)
+		msq->q_perm.security[i] = NULL;
+
 	retval = security_msg_queue_alloc(msq);
 	if (retval) {
 		ipc_rcu_putref(msq);
Index: linux-2.6.10-rc1-bk12-stack/ipc/msgutil.c
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/ipc/msgutil.c	2004-10-18
16:54:07.000000000 -0500
+++ linux-2.6.10-rc1-bk12-stack/ipc/msgutil.c	2004-11-02
19:57:14.757723192 -0600
@@ -31,6 +31,7 @@
 	struct msg_msgseg **pseg;
 	int err;
 	int alen;
+	int i;
 
 	alen = len;
 	if (alen > DATALEN_MSG)
@@ -41,7 +42,8 @@
 		return ERR_PTR(-ENOMEM);
 
 	msg->next = NULL;
-	msg->security = NULL;
+	for (i=0; i<CONFIG_NUM_LSMS; i++)
+		msg->security[i] = NULL;
 
 	if (copy_from_user(msg + 1, src, alen)) {
 		err = -EFAULT;
Index: linux-2.6.10-rc1-bk12-stack/ipc/sem.c
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/ipc/sem.c	2004-11-02
19:56:00.805965568 -0600
+++ linux-2.6.10-rc1-bk12-stack/ipc/sem.c	2004-11-02 19:57:14.758723040
-0600
@@ -161,6 +161,7 @@
 	int retval;
 	struct sem_array *sma;
 	int size;
+	int i;
 
 	if (!nsems)
 		return -EINVAL;
@@ -177,7 +178,9 @@
 	sma->sem_perm.mode = (semflg & S_IRWXUGO);
 	sma->sem_perm.key = key;
 
-	sma->sem_perm.security = NULL;
+	for (i=0; i<CONFIG_NUM_LSMS; i++)
+		sma->sem_perm.security[i] = NULL;
+
 	retval = security_sem_alloc(sma);
 	if (retval) {
 		ipc_rcu_putref(sma);
Index: linux-2.6.10-rc1-bk12-stack/ipc/shm.c
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/ipc/shm.c	2004-11-02
19:55:51.451387680 -0600
+++ linux-2.6.10-rc1-bk12-stack/ipc/shm.c	2004-11-02 19:57:14.758723040
-0600
@@ -181,6 +181,7 @@
 	struct file * file;
 	char name[13];
 	int id;
+	int i;
 
 	if (size < SHMMIN || size > shm_ctlmax)
 		return -EINVAL;
@@ -196,7 +197,9 @@
 	shp->shm_flags = (shmflg & S_IRWXUGO);
 	shp->mlock_user = NULL;
 
-	shp->shm_perm.security = NULL;
+	for (i=0; i<CONFIG_NUM_LSMS; i++)
+		shp->shm_perm.security[i] = NULL;
+
 	error = security_shm_alloc(shp);
 	if (error) {
 		ipc_rcu_putref(shp);
Index: linux-2.6.10-rc1-bk12-stack/kernel/fork.c
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/kernel/fork.c	2004-11-02
19:56:00.815964048 -0600
+++ linux-2.6.10-rc1-bk12-stack/kernel/fork.c	2004-11-02
19:57:14.759722888 -0600
@@ -789,6 +789,7 @@
 {
 	int retval;
 	struct task_struct *p = NULL;
+	int i;
 
 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
 		return ERR_PTR(-EINVAL);
@@ -871,7 +872,8 @@
 	p->utime = p->stime = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
 	do_posix_clock_monotonic_gettime(&p->start_time);
-	p->security = NULL;
+	for (i=0; i<CONFIG_NUM_LSMS; i++)
+		p->security[i] = NULL;
 	p->io_context = NULL;
 	p->io_wait = NULL;
 	p->audit_context = NULL;
Index: linux-2.6.10-rc1-bk12-stack/security/Kconfig
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/security/Kconfig	2004-11-02
19:55:53.582063768 -0600
+++ linux-2.6.10-rc1-bk12-stack/security/Kconfig	2004-11-02
19:57:14.759722888 -0600
@@ -44,6 +44,17 @@
 
 	  If you are unsure how to answer this question, answer N.
 
+config NUM_LSMS
+	int "Number of security pointers to allocate"
+	depends on SECURITY
+	default "4"
+	help
+	  Each LSM which annotates information with kernel objects
+	  must have its own annotation entry.  This option specifies
+	  the number of required entries.  It is safe to enter the
+	  number of LSM's which you will load.
+
+
 config SECURITY_NETWORK
 	bool "Socket and Networking Security Hooks"
 	depends on SECURITY


