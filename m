Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbVHJOrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbVHJOrm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbVHJOrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:47:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:24238 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965144AbVHJOrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:47:40 -0400
Date: Wed, 10 Aug 2005 09:45:16 -0500
From: serue@us.ibm.com
To: James Morris <jmorris@redhat.com>
Cc: serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Stacker - single-use static slots
Message-ID: <20050810144516.GA5796@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com> <Lynx.SEL.4.62.0507271535150.1844@thoron.boston.redhat.com> <20050803164516.GB13691@serge.austin.ibm.com> <Lynx.SEL.4.62.0508051154150.8981@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Lynx.SEL.4.62.0508051154150.8981@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Morris (jmorris@redhat.com):
> On Wed, 3 Aug 2005 serue@us.ibm.com wrote:
> 
> > The attached patch implements your idea on top of my previous patchset.
> > Following is performance data on a 16-way ppc.  dbench and tbench were
> > run 50 times, kernbench and reaim 10 times each;  results are mean +/-
> > 95% confidence half-interval.  The 'static slot' kernel had a single
> > static slot for selinux, plus the (unused in this case) shared struct
> > hlist_head security.
> 
> Can you also compare with no stacker at all (i.e. just SELinux with caps 
> as secondary module) ?

Attached is the patch taking into account Chris' comments.  More of
those annoying cache effects, I assume - 3 slots (the default)
outperforms two slots, even though only one slot is being used.  These
tests were run on a 16-way power4+ system.  I may try to re-run on some
x86 hardware, though each run will probably take 24 hours.

As usual, this reflects 50 runs of dbench and tbench, 10 of reaim and
10 of kernbench, with numbers representing mean +/- 95% confidence
half-interval.  Reaim plots # children vs max # jobs/min.  All tests
were on an ext2fs.

dbench (Throughput, larger is better):
2slots:    1459.680400 +/- 11.841823
3slots:    1460.549600 +/- 9.623773
nostacker: 1484.219200 +/- 11.900471

tbench (Throughput, larger is better):
2slots:    141.181200 +/- 2.982634
3slots:    143.333940 +/- 3.163371
nostacker: 143.884120 +/- 2.260252

kernbench (time, smaller is better):
2slots:    53.064000 +/- 0.150592
3slots:    52.959000 +/- 0.138074
nostacker: 52.618000 +/- 0.164646

reaim (number workers vs max jobs/min, larger is better):
2slots:

1 100542.857000 3296.286475
3 279771.426000 16148.439818
5 459000.002000 25175.800349
7 652800.000000 37679.689215
9 813085.712000 39555.434680
11 937671.432000 36259.148959
13 1093950.001000 49092.813099
15 1109250.000000 44057.652338

3slots:
1 102000.000000 0.000000
3 292885.713000 15105.482283
5 480857.144000 26914.062669
7 663000.000000 38456.671768
9 799971.426000 29666.576010
11 949692.861000 27194.361719
13 1093950.001000 49092.813099
15 1122000.000000 38456.671768

nostacker:
1 108120.000000 7049.224374
3 297257.142000 13185.145899
5 473571.430000 27469.050185
7 693600.000000 30765.337414
9 852428.570000 49444.293350
11 961714.290000 0.000000
13 1065535.715000 53564.650500
15 1147500.000000 0.000000

This patch is on top of the previous set of stacker patches.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 fs/compat.c                    |    4 
 fs/exec.c                      |    2 
 fs/inode.c                     |    3 
 include/linux/binfmts.h        |    2 
 include/linux/fs.h             |    8 
 include/linux/ipc.h            |    2 
 include/linux/msg.h            |    2 
 include/linux/sched.h          |    2 
 include/linux/security-stack.h |   14 
 include/linux/security.h       |   72 +++-
 include/net/sock.h             |    2 
 ipc/msg.c                      |    3 
 ipc/msgutil.c                  |    3 
 ipc/sem.c                      |    3 
 ipc/shm.c                      |    3 
 kernel/fork.c                  |    3 
 security/Kconfig               |   16 +
 security/cap_stack.c           |    4 
 security/capability.c          |    4 
 security/root_plug.c           |    4 
 security/seclvl.c              |   30 +-
 security/security.c            |  105 ++++++-
 security/selinux/hooks.c       |  607 ++++++++++++++++++++++++-----------------
 security/selinux/selinuxfs.c   |   17 -
 security/stacker.c             |   62 ++--
 25 files changed, 638 insertions(+), 339 deletions(-)

Index: linux-2.6.13-rc4/include/linux/security.h
===================================================================
--- linux-2.6.13-rc4.orig/include/linux/security.h	2005-08-01 20:00:51.000000000 -0500
+++ linux-2.6.13-rc4/include/linux/security.h	2005-08-06 21:29:30.000000000 -0500
@@ -34,6 +34,8 @@
 struct ctl_table;
 struct module;
 
+extern int sec_shared_slot;
+
 /*
  * structure to be embedded at top of each LSM's security
  * objects.
@@ -44,24 +46,61 @@ struct security_list {
 };
 
 
+static inline void *__get_value(void *head, int idx)
+{
+	void **p = head;
+	pr_debug("__get_value: %s (%d): head %lx p %lx idx %d returning %lx at %lx\n",
+		__FUNCTION__, __LINE__, (long)head, (long)p, idx, (long)p[idx], (long)&p[idx]);
+	return p[idx];
+}
+
+static inline void __set_value(void *head, int idx, void *v)
+{
+	void **p = head;
+	p[idx] = v;
+	pr_debug("%s (%d): hd %lx, p %lx, idx %d,"
+		"v %lx, p[idx] %lx at %lx\n",
+		__FUNCTION__, __LINE__, (long) (head),
+		(long) p, idx, (long) (v),
+		(long)p[idx], (long)&p[idx]);
+}
+
 /*
  * These #defines present more convenient interfaces to
  * LSMs for using the security{g,d,s}et_value functions.
  */
-#define security_get_value_type(head, id, type) ( { \
-	struct security_list *v = security_get_value((head), id); \
-	v ? hlist_entry(v, type, lsm_list) : NULL; } )
-
-#define security_set_value_type(head, id, value) \
-	security_set_value((head), id, &(value)->lsm_list);
-
-#define security_add_value_type(head, id, value) \
-	security_add_value((head), id, &(value)->lsm_list);
-
-#define security_del_value_type(head, id, type) ( { \
-	struct security_list *v; \
-	v = security_del_value((head), id); \
-	v ? hlist_entry(v, type, lsm_list) : NULL; } )
+#define security_get_value_type(head, id, type, idx) (idx < sec_shared_slot) ? \
+		(type *)__get_value((head), idx) \
+	: ({ \
+		struct security_list *v = security_get_value((head), id); \
+		v ? hlist_entry(v, type, lsm_list) : NULL; \
+	})
+
+#define security_set_value_type(head, id, value, idx) \
+	do { \
+		if (idx < sec_shared_slot) { \
+			__set_value((head), idx, (value)); \
+		} else { \
+			security_set_value((head), id, &(value)->lsm_list); \
+		} \
+	} while (0);
+
+#define security_add_value_type(head, id, value, idx) \
+	do { \
+		if (idx < sec_shared_slot) { \
+			__set_value((head), idx, (value)); \
+		} else { \
+			security_add_value((head), id, &(value)->lsm_list); \
+		} \
+	} while (0);
+
+#define security_del_value_type(head, id, type, idx) (idx < sec_shared_slot) ? \
+		(type *)__get_value((head), idx) \
+	: ( { \
+		struct security_list *v; \
+		v = security_del_value((head), id); \
+		v ? hlist_entry(v, type, lsm_list) : NULL; \
+	} )
 
 /* security_disown_value is really only to be used by stacker */
 extern void security_disown_value(struct hlist_head *);
@@ -2022,9 +2061,10 @@ static inline int security_netlink_recv(
 
 /* prototypes */
 extern int security_init	(void);
-extern int register_security	(struct security_operations *ops);
+extern int register_security	(struct security_operations *ops, int *idx);
 extern int unregister_security	(struct security_operations *ops);
-extern int mod_reg_security	(const char *name, struct security_operations *ops);
+extern int mod_reg_security	(const char *name,
+			struct security_operations *ops, int *idx);
 extern int mod_unreg_security	(const char *name, struct security_operations *ops);
 extern struct dentry *securityfs_create_file(const char *name, mode_t mode,
 					     struct dentry *parent, void *data,
Index: linux-2.6.13-rc4/security/Kconfig
===================================================================
--- linux-2.6.13-rc4.orig/security/Kconfig	2005-08-01 20:00:51.000000000 -0500
+++ linux-2.6.13-rc4/security/Kconfig	2005-08-05 16:49:51.000000000 -0500
@@ -112,5 +112,21 @@ config SECURITY_STACKER
 	help
 	  Stack multiple LSMs.
 
+config SECURITY_STACKER_NUMFIELDS
+	int "Number of security fields to reserve"
+	depends on SECURITY_STACKER
+	default 3
+	help
+	  This option reserves extra space in each kernel object
+	  for security information.  This may speed up modules which
+	  make a lot of use of these fields, as these accesses can
+	  be lock-free.  However each kernel object requires one
+	  extra byte for each field reserved her, which can slow
+	  the system down.
+
+	  The actual number of static slots will be 1 greater than
+	  this number, and this number must always be at least 1.
+	  That one will be the shared slot for all LSMs to share.
+
 endmenu
 
Index: linux-2.6.13-rc4/fs/inode.c
===================================================================
--- linux-2.6.13-rc4.orig/fs/inode.c	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/fs/inode.c	2005-08-06 01:48:43.000000000 -0500
@@ -133,7 +133,8 @@ static struct inode *alloc_inode(struct 
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
 		inode->i_rdev = 0;
-		INIT_HLIST_HEAD(&inode->i_security);
+		memset(&inode->i_security, 0, (sec_shared_slot)*sizeof(void *));
+		INIT_HLIST_HEAD((struct hlist_head *)&(inode->i_security[sec_shared_slot]));
 		inode->dirtied_when = 0;
 		if (security_inode_alloc(inode)) {
 			if (inode->i_sb->s_op->destroy_inode)
Index: linux-2.6.13-rc4/include/linux/binfmts.h
===================================================================
--- linux-2.6.13-rc4.orig/include/linux/binfmts.h	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/include/linux/binfmts.h	2005-08-05 16:59:15.000000000 -0500
@@ -29,7 +29,7 @@ struct linux_binprm{
 	struct file * file;
 	int e_uid, e_gid;
 	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
-	struct hlist_head security;
+	void * security[CONFIG_SECURITY_STACKER_NUMFIELDS];
 	int argc, envc;
 	char * filename;	/* Name of binary as seen by procps */
 	char * interp;		/* Name of the binary really executed. Most
Index: linux-2.6.13-rc4/include/linux/fs.h
===================================================================
--- linux-2.6.13-rc4.orig/include/linux/fs.h	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/include/linux/fs.h	2005-08-05 16:59:37.000000000 -0500
@@ -485,7 +485,7 @@ struct inode {
 	unsigned int		i_flags;
 
 	atomic_t		i_writecount;
-	struct hlist_head	i_security;
+	void			*i_security[CONFIG_SECURITY_STACKER_NUMFIELDS];
 	union {
 		void		*generic_ip;
 	} u;
@@ -559,7 +559,7 @@ struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
-	struct hlist_head security;
+	void * security[CONFIG_SECURITY_STACKER_NUMFIELDS];
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
 
@@ -596,7 +596,7 @@ struct file {
 
 	size_t			f_maxcount;
 	unsigned long		f_version;
-	struct hlist_head	f_security;
+	void 			*f_security[CONFIG_SECURITY_STACKER_NUMFIELDS];
 
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
@@ -785,7 +785,7 @@ struct super_block {
 	int			s_syncing;
 	int			s_need_sync_fs;
 	atomic_t		s_active;
- 	struct hlist_head	s_security;
+	void			*s_security[CONFIG_SECURITY_STACKER_NUMFIELDS];
 	struct xattr_handler	**s_xattr;
 
 	struct list_head	s_inodes;	/* all inodes */
Index: linux-2.6.13-rc4/include/linux/ipc.h
===================================================================
--- linux-2.6.13-rc4.orig/include/linux/ipc.h	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/include/linux/ipc.h	2005-08-05 16:59:43.000000000 -0500
@@ -66,7 +66,7 @@ struct kern_ipc_perm
 	gid_t		cgid;
 	mode_t		mode; 
 	unsigned long	seq;
-	struct hlist_head security;
+	void		*security[CONFIG_SECURITY_STACKER_NUMFIELDS];
 };
 
 #endif /* __KERNEL__ */
Index: linux-2.6.13-rc4/include/linux/msg.h
===================================================================
--- linux-2.6.13-rc4.orig/include/linux/msg.h	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/include/linux/msg.h	2005-08-05 16:59:47.000000000 -0500
@@ -70,7 +70,7 @@ struct msg_msg {
 	long  m_type;          
 	int m_ts;           /* message text size */
 	struct msg_msgseg* next;
-	struct hlist_head security;
+	void * security[CONFIG_SECURITY_STACKER_NUMFIELDS];
 	/* the actual message follows immediately */
 };
 
Index: linux-2.6.13-rc4/include/linux/sched.h
===================================================================
--- linux-2.6.13-rc4.orig/include/linux/sched.h	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/include/linux/sched.h	2005-08-05 16:59:52.000000000 -0500
@@ -721,7 +721,7 @@ struct task_struct {
 	void *notifier_data;
 	sigset_t *notifier_mask;
 	
-	struct hlist_head security;
+	void *security[CONFIG_SECURITY_STACKER_NUMFIELDS];
 	struct audit_context *audit_context;
 	seccomp_t seccomp;
 
Index: linux-2.6.13-rc4/include/net/sock.h
===================================================================
--- linux-2.6.13-rc4.orig/include/net/sock.h	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/include/net/sock.h	2005-08-05 17:00:01.000000000 -0500
@@ -240,7 +240,7 @@ struct sock {
 	struct sk_buff		*sk_send_head;
 	__u32			sk_sndmsg_off;
 	int			sk_write_pending;
-	struct hlist_head	sk_security;
+	void			*sk_security[CONFIG_SECURITY_STACKER_NUMFIELDS];
 	void			(*sk_state_change)(struct sock *sk);
 	void			(*sk_data_ready)(struct sock *sk, int bytes);
 	void			(*sk_write_space)(struct sock *sk);
Index: linux-2.6.13-rc4/ipc/msg.c
===================================================================
--- linux-2.6.13-rc4.orig/ipc/msg.c	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/ipc/msg.c	2005-08-06 01:44:19.000000000 -0500
@@ -99,7 +99,8 @@ static int newque (key_t key, int msgflg
 	msq->q_perm.mode = (msgflg & S_IRWXUGO);
 	msq->q_perm.key = key;
 
-	INIT_HLIST_HEAD(&msq->q_perm.security);
+	memset(&msq->q_perm.security, 0, (sec_shared_slot)*sizeof(void *));
+	INIT_HLIST_HEAD((struct hlist_head *)&(msq->q_perm.security[sec_shared_slot]));
 	retval = security_msg_queue_alloc(msq);
 	if (retval) {
 		ipc_rcu_putref(msq);
Index: linux-2.6.13-rc4/ipc/msgutil.c
===================================================================
--- linux-2.6.13-rc4.orig/ipc/msgutil.c	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/ipc/msgutil.c	2005-08-06 01:44:23.000000000 -0500
@@ -41,7 +41,8 @@ struct msg_msg *load_msg(const void __us
 		return ERR_PTR(-ENOMEM);
 
 	msg->next = NULL;
-	INIT_HLIST_HEAD(&msg->security);
+	memset(&msg->security, 0, (sec_shared_slot)*sizeof(void *));
+	INIT_HLIST_HEAD((struct hlist_head *)&(msg->security[sec_shared_slot]));
 
 	if (copy_from_user(msg + 1, src, alen)) {
 		err = -EFAULT;
Index: linux-2.6.13-rc4/ipc/sem.c
===================================================================
--- linux-2.6.13-rc4.orig/ipc/sem.c	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/ipc/sem.c	2005-08-06 01:44:26.000000000 -0500
@@ -178,7 +178,8 @@ static int newary (key_t key, int nsems,
 	sma->sem_perm.mode = (semflg & S_IRWXUGO);
 	sma->sem_perm.key = key;
 
-	INIT_HLIST_HEAD(&sma->sem_perm.security);
+	memset(&sma->sem_perm.security, 0, (sec_shared_slot)*sizeof(void *));
+	INIT_HLIST_HEAD((struct hlist_head *)&(sma->sem_perm.security[sec_shared_slot]));
 	retval = security_sem_alloc(sma);
 	if (retval) {
 		ipc_rcu_putref(sma);
Index: linux-2.6.13-rc4/ipc/shm.c
===================================================================
--- linux-2.6.13-rc4.orig/ipc/shm.c	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/ipc/shm.c	2005-08-06 01:44:28.000000000 -0500
@@ -199,7 +199,8 @@ static int newseg (key_t key, int shmflg
 	shp->shm_flags = (shmflg & S_IRWXUGO);
 	shp->mlock_user = NULL;
 
-	INIT_HLIST_HEAD(&shp->shm_perm.security);
+	memset(&shp->shm_perm.security, 0, (sec_shared_slot)*sizeof(void *));
+	INIT_HLIST_HEAD((struct hlist_head *)&(shp->shm_perm.security[sec_shared_slot]));
 	error = security_shm_alloc(shp);
 	if (error) {
 		ipc_rcu_putref(shp);
Index: linux-2.6.13-rc4/kernel/fork.c
===================================================================
--- linux-2.6.13-rc4.orig/kernel/fork.c	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/kernel/fork.c	2005-08-06 01:44:30.000000000 -0500
@@ -941,7 +941,8 @@ static task_t *copy_process(unsigned lon
 
 	p->lock_depth = -1;		/* -1 = no lock */
 	do_posix_clock_monotonic_gettime(&p->start_time);
-	INIT_HLIST_HEAD(&p->security);
+	memset(&p->security, 0, (sec_shared_slot)*sizeof(void *));
+	INIT_HLIST_HEAD((struct hlist_head *)&(p->security[sec_shared_slot]));
 	p->io_context = NULL;
 	p->io_wait = NULL;
 	p->audit_context = NULL;
Index: linux-2.6.13-rc4/security/security.c
===================================================================
--- linux-2.6.13-rc4.orig/security/security.c	2005-08-01 20:00:51.000000000 -0500
+++ linux-2.6.13-rc4/security/security.c	2005-08-06 21:33:50.000000000 -0500
@@ -20,12 +20,22 @@
 
 #define SECURITY_FRAMEWORK_VERSION	"1.0.0"
 
+int sec_numslots = CONFIG_SECURITY_STACKER_NUMFIELDS;
+int sec_shared_slot;
+EXPORT_SYMBOL_GPL(sec_shared_slot);
+
+static struct security_operations
+	*security_field_owners[CONFIG_SECURITY_STACKER_NUMFIELDS];
+
 fastcall struct security_list *
-security_get_value(struct hlist_head *head, int security_id)
+security_get_value(void **sec, int security_id)
 {
 	struct security_list *e, *ret = NULL;
+	struct hlist_head *head;
 	struct hlist_node *tmp;
 
+	head = (struct hlist_head *) &(sec[sec_shared_slot]);
+
 	rcu_read_lock();
 	for (tmp = head->first; tmp;
 			 tmp = rcu_dereference(tmp->next)) {
@@ -46,15 +56,18 @@ out:
  * no locking as it is naturally serialized.
  */
 fastcall void
-security_set_value(struct hlist_head *head, int security_id,
+security_set_value(void **sec, int security_id,
 	struct security_list *obj_node)
 {
+	struct hlist_head *head;
 
+	head = (struct hlist_head *) &(sec[sec_shared_slot]);
 	obj_node->security_id = security_id;
 	hlist_add_head(&obj_node->list, head);
 }
 
 static DEFINE_SPINLOCK(stacker_value_spinlock);
+static DEFINE_SPINLOCK(security_field_spinlock);
 
 /*
  * Used outside of security_*_alloc hooks, so we need to
@@ -62,10 +75,12 @@ static DEFINE_SPINLOCK(stacker_value_spi
  * spinlock for now.
  */
 fastcall void
-security_add_value(struct hlist_head *head, int security_id,
+security_add_value(void **sec, int security_id,
 	struct security_list *obj_node)
 {
+	struct hlist_head *head;
 
+	head = (struct hlist_head *) &(sec[sec_shared_slot]);
 	spin_lock(&stacker_value_spinlock);
 	obj_node->security_id = security_id;
 	hlist_add_head_rcu(&obj_node->list, head);
@@ -86,9 +101,13 @@ security_add_value(struct hlist_head *he
  * XXX TODO - switch this to take a type, and deref
  * obj->lsm_list.list here.
  */
-int security_unlink_value(struct hlist_node *n)
+int security_unlink_value(struct hlist_node *n, int idx)
 {
 	int ret = 0;
+
+	if (idx == sec_shared_slot)
+		return 0;
+
 	spin_lock(&stacker_value_spinlock);
 	if (n->pprev == LIST_POISON2) {
 		ret = 1;
@@ -119,9 +138,10 @@ out:
 void security_disown_value(struct hlist_head *h)
 {
 	spin_lock(&stacker_value_spinlock);
-	if (h->first)
+	if (h->first) {
 		h->first->pprev = LIST_POISON2;
-	h->first = NULL;
+		h->first = NULL;
+	}
 	spin_unlock(&stacker_value_spinlock);
 }
 
@@ -129,11 +149,14 @@ int lsm_unloading;
 
 /* No locking needed: only called during object_destroy */
 fastcall struct security_list *
-security_del_value(struct hlist_head *head, int security_id)
+security_del_value(void **sec, int security_id)
 {
 	struct security_list *e;
 	struct hlist_node *tmp;
 	char d = 0;
+	struct hlist_head *head;
+
+	head = (struct hlist_head *) &(sec[sec_shared_slot]);
 
 	if (lsm_unloading) {
 		d = 1;
@@ -205,6 +228,7 @@ int __init security_init(void)
 		return -EIO;
 	}
 
+	sec_shared_slot = sec_numslots - 1;
 	security_ops = &dummy_security_ops;
 	do_security_initcalls();
 
@@ -223,7 +247,7 @@ int __init security_init(void)
  * If there is already a security module registered with the kernel,
  * an error will be returned.  Otherwise 0 is returned on success.
  */
-int register_security(struct security_operations *ops)
+int register_security(struct security_operations *ops, int *idx)
 {
 	if (security_ops != &dummy_security_ops)
 		return -EAGAIN;
@@ -234,6 +258,21 @@ int register_security(struct security_op
 		return -EINVAL;
 	}
 
+	spin_lock(&security_field_spinlock);
+	if (idx && *idx) {
+		int i;
+
+		for (i=0; i<sec_shared_slot; i++) {
+			if (security_field_owners[i] == NULL) {
+				security_field_owners[i] = ops;
+				break;
+			}
+		}
+
+		*idx = i;
+	}
+	spin_unlock(&security_field_spinlock);
+
 	security_ops = ops;
 
 	return 0;
@@ -252,6 +291,8 @@ int register_security(struct security_op
  */
 int unregister_security(struct security_operations *ops)
 {
+	int i;
+
 	if (ops != security_ops) {
 		printk(KERN_INFO "%s: trying to unregister "
 		       "a security_opts structure that is not "
@@ -261,6 +302,15 @@ int unregister_security(struct security_
 
 	security_ops = &dummy_security_ops;
 
+	spin_lock(&security_field_spinlock);
+	for (i=0; i<sec_shared_slot; i++) {
+		if (security_field_owners[i] == ops) {
+			security_field_owners[i] = NULL;
+			break;
+		}
+	}
+	spin_unlock(&security_field_spinlock);
+
 	return 0;
 }
 
@@ -276,8 +326,11 @@ int unregister_security(struct security_
  * The return value depends on the currently loaded security module, with 0 as
  * success.
  */
-int mod_reg_security(const char *name, struct security_operations *ops)
+int mod_reg_security(const char *name, struct security_operations *ops,
+			int *idx)
 {
+	int ret = 0;
+
 	if (!ops) {
 		printk(KERN_INFO "%s received NULL security operations",
 						       __FUNCTION__);
@@ -290,7 +343,28 @@ int mod_reg_security(const char *name, s
 		return -EINVAL;
 	}
 
-	return security_ops->register_security(name, ops);
+	ret = security_ops->register_security(name, ops);
+
+	if (ret < 0)
+		goto out;
+
+	spin_lock(&security_field_spinlock);
+	if (idx && *idx) {
+		int i;
+
+		for (i=0; i<sec_shared_slot; i++) {
+			if (security_field_owners[i] == NULL) {
+				security_field_owners[i] = ops;
+				break;
+			}
+		}
+
+		*idx = i;
+	}
+	spin_unlock(&security_field_spinlock);
+
+out:
+	return ret;
 }
 
 /**
@@ -308,12 +382,23 @@ int mod_reg_security(const char *name, s
  */
 int mod_unreg_security(const char *name, struct security_operations *ops)
 {
+	int i;
+
 	if (ops == security_ops) {
 		printk(KERN_INFO "%s invalid attempt to unregister "
 		       " primary security ops.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
+	spin_lock(&security_field_spinlock);
+	for (i=0; i<sec_shared_slot; i++) {
+		if (security_field_owners[i] == ops) {
+			security_field_owners[i] = NULL;
+			break;
+		}
+	}
+	spin_unlock(&security_field_spinlock);
+
 	return security_ops->unregister_security(name, ops);
 }
 
Index: linux-2.6.13-rc4/security/selinux/hooks.c
===================================================================
--- linux-2.6.13-rc4.orig/security/selinux/hooks.c	2005-08-01 20:00:51.000000000 -0500
+++ linux-2.6.13-rc4/security/selinux/hooks.c	2005-08-05 22:06:22.000000000 -0500
@@ -78,6 +78,8 @@
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
 
+int selinux_secidx;
+
 extern unsigned int policydb_loaded_version;
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
 
@@ -123,7 +125,8 @@ static int task_alloc_security(struct ta
 	memset(tsec, 0, sizeof(struct task_security_struct));
 	tsec->task = task;
 	tsec->osid = tsec->sid = tsec->ptrace_sid = SECINITSID_UNLABELED;
-	security_set_value_type(&task->security, SELINUX_LSM_ID, tsec);
+	security_set_value_type(task->security, SELINUX_LSM_ID, tsec,
+		selinux_secidx);
 
 	return 0;
 }
@@ -132,8 +135,9 @@ static void task_free_security(struct ta
 {
 	struct task_security_struct *tsec;
 	
-	tsec = security_del_value_type(&task->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_del_value_type(task->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+			selinux_secidx);
 
 	kfree(tsec);
 }
@@ -143,8 +147,9 @@ static int inode_alloc_security(struct i
 	struct task_security_struct *tsec;
 	struct inode_security_struct *isec;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 	isec = kmalloc(sizeof(struct inode_security_struct), GFP_KERNEL);
 	if (!isec)
 		return -ENOMEM;
@@ -159,7 +164,8 @@ static int inode_alloc_security(struct i
 		isec->task_sid = tsec->sid;
 	else
 		isec->task_sid = SECINITSID_UNLABELED;
-	security_set_value_type(&inode->i_security, SELINUX_LSM_ID, isec);
+	security_set_value_type(inode->i_security, SELINUX_LSM_ID, isec,
+		selinux_secidx);
 
 	return 0;
 }
@@ -169,13 +175,15 @@ static void inode_free_security(struct i
 	struct inode_security_struct *isec;
 	struct superblock_security_struct *sbsec;
 
-	isec = security_del_value_type(&inode->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	isec = security_del_value_type(inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+			selinux_secidx);
 	if (!isec)
 		return;
 
-	sbsec = security_get_value_type(&inode->i_sb->s_security,
-		SELINUX_LSM_ID, struct superblock_security_struct);
+	sbsec = security_get_value_type(inode->i_sb->s_security,
+		SELINUX_LSM_ID, struct superblock_security_struct,
+		selinux_secidx);
 
 	spin_lock(&sbsec->isec_lock);
 	if (!list_empty(&isec->list))
@@ -190,8 +198,9 @@ static int file_alloc_security(struct fi
 	struct task_security_struct *tsec;
 	struct file_security_struct *fsec;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 	fsec = kmalloc(sizeof(struct file_security_struct), GFP_ATOMIC);
 	if (!fsec)
 		return -ENOMEM;
@@ -205,7 +214,8 @@ static int file_alloc_security(struct fi
 		fsec->sid = SECINITSID_UNLABELED;
 		fsec->fown_sid = SECINITSID_UNLABELED;
 	}
-	security_set_value_type(&file->f_security, SELINUX_LSM_ID, fsec);
+	security_set_value_type(file->f_security, SELINUX_LSM_ID, fsec,
+		selinux_secidx);
 
 	return 0;
 }
@@ -214,8 +224,9 @@ static void file_free_security(struct fi
 {
 	struct file_security_struct *fsec;
 
-	fsec = security_del_value_type(&file->f_security, SELINUX_LSM_ID,
-		struct file_security_struct);
+	fsec = security_del_value_type(file->f_security, SELINUX_LSM_ID,
+		struct file_security_struct,
+			selinux_secidx);
 
 	kfree(fsec);
 }
@@ -236,7 +247,8 @@ static int superblock_alloc_security(str
 	sbsec->sb = sb;
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
-	security_set_value_type(&sb->s_security, SELINUX_LSM_ID, sbsec);
+	security_set_value_type(sb->s_security, SELINUX_LSM_ID, sbsec,
+		selinux_secidx);
 
 	return 0;
 }
@@ -245,8 +257,8 @@ static void superblock_free_security(str
 {
 	struct superblock_security_struct *sbsec;
 
-	sbsec = security_del_value_type(&sb->s_security, SELINUX_LSM_ID,
-		struct superblock_security_struct);
+	sbsec = security_del_value_type(sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct, selinux_secidx);
 	if (!sbsec)
 		return;
 
@@ -273,7 +285,8 @@ static int sk_alloc_security(struct sock
 	memset(ssec, 0, sizeof(*ssec));
 	ssec->sk = sk;
 	ssec->peer_sid = SECINITSID_UNLABELED;
-	security_set_value_type(&sk->sk_security, SELINUX_LSM_ID, ssec);
+	security_set_value_type(sk->sk_security, SELINUX_LSM_ID, ssec,
+		selinux_secidx);
 
 	return 0;
 }
@@ -285,8 +298,8 @@ static void sk_free_security(struct sock
 	if (sk->sk_family != PF_UNIX)
 		return;
 
-	ssec = security_del_value_type(&sk->sk_security, SELINUX_LSM_ID,
-		struct sk_security_struct);
+	ssec = security_del_value_type(sk->sk_security, SELINUX_LSM_ID,
+		struct sk_security_struct, selinux_secidx);
 
 	kfree(ssec);
 }
@@ -337,10 +350,12 @@ static int try_context_mount(struct supe
 	struct task_security_struct *tsec;
 	struct superblock_security_struct *sbsec;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	sbsec = security_get_value_type(&sb->s_security, SELINUX_LSM_ID,
-		struct superblock_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	sbsec = security_get_value_type(sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct,
+		selinux_secidx);
 
 	if (!data)
 		goto out;
@@ -511,8 +526,9 @@ static int superblock_doinit(struct supe
 	struct inode *inode = root->d_inode;
 	int rc = 0;
 
-	sbsec = security_get_value_type(&sb->s_security, SELINUX_LSM_ID,
-		struct superblock_security_struct);
+	sbsec = security_get_value_type(sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct,
+		selinux_secidx);
 
 	down(&sbsec->sem);
 	if (sbsec->initialized)
@@ -747,8 +763,9 @@ static int inode_doinit_with_dentry(stru
 	int rc = 0;
 	int hold_sem = 0;
 
-	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	isec = security_get_value_type(inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
 
 	if (isec->initialized)
 		goto out;
@@ -758,8 +775,9 @@ static int inode_doinit_with_dentry(stru
 	if (isec->initialized)
 		goto out;
 
-	sbsec = security_get_value_type(&inode->i_sb->s_security,
-		SELINUX_LSM_ID, struct superblock_security_struct);
+	sbsec = security_get_value_type(inode->i_sb->s_security,
+		SELINUX_LSM_ID, struct superblock_security_struct,
+		selinux_secidx);
 	if (!sbsec->initialized) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
@@ -934,10 +952,12 @@ static int task_has_perm(struct task_str
 {
 	struct task_security_struct *tsec1, *tsec2;
 
-	tsec1 = security_get_value_type(&tsk1->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	tsec2 = security_get_value_type(&tsk2->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec1 = security_get_value_type(tsk1->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	tsec2 = security_get_value_type(tsk2->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 	return avc_has_perm(tsec1->sid, tsec2->sid,
 			    SECCLASS_PROCESS, perms, NULL);
 }
@@ -949,8 +969,9 @@ static int task_has_capability(struct ta
 	struct task_security_struct *tsec;
 	struct avc_audit_data ad;
 
-	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad,CAP);
 	ad.tsk = tsk;
@@ -966,8 +987,9 @@ static int task_has_system(struct task_s
 {
 	struct task_security_struct *tsec;
 
-	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 
 	return avc_has_perm(tsec->sid, SECINITSID_KERNEL,
 			    SECCLASS_SYSTEM, perms, NULL);
@@ -985,10 +1007,12 @@ static int inode_has_perm(struct task_st
 	struct inode_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	tsec = security_get_value_type(tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
 
 	if (!adp) {
 		adp = &ad;
@@ -1035,10 +1059,12 @@ static inline int file_has_perm(struct t
 	struct avc_audit_data ad;
 	int rc;
 
-	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	fsec = security_get_value_type(&file->f_security, SELINUX_LSM_ID,
-		struct file_security_struct);
+	tsec = security_get_value_type(tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	fsec = security_get_value_type(file->f_security, SELINUX_LSM_ID,
+		struct file_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.mnt = mnt;
@@ -1072,12 +1098,15 @@ static int may_create(struct inode *dir,
 	struct avc_audit_data ad;
 	int rc;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	dsec = security_get_value_type(&dir->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
-	sbsec = security_get_value_type(&dir->i_sb->s_security, SELINUX_LSM_ID,
-		struct superblock_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	dsec = security_get_value_type(dir->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
+	sbsec = security_get_value_type(dir->i_sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
@@ -1122,12 +1151,15 @@ static int may_link(struct inode *dir,
 	u32 av;
 	int rc;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	dsec = security_get_value_type(&dir->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
-	isec = security_get_value_type(&dentry->d_inode->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	dsec = security_get_value_type(dir->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(dentry->d_inode->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
@@ -1169,15 +1201,19 @@ static inline int may_rename(struct inod
 	int old_is_dir, new_is_dir;
 	int rc;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	old_dsec = security_get_value_type(&old_dir->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
-	old_isec = security_get_value_type(&old_dentry->d_inode->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	old_dsec = security_get_value_type(old_dir->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
+	old_isec = security_get_value_type(old_dentry->d_inode->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
 	old_is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
-	new_dsec = security_get_value_type(&new_dir->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	new_dsec = security_get_value_type(new_dir->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 
@@ -1205,8 +1241,9 @@ static inline int may_rename(struct inod
 	if (rc)
 		return rc;
 	if (new_dentry->d_inode) {
-		new_isec = security_get_value_type(&new_dentry->d_inode->i_security,
-			SELINUX_LSM_ID, struct inode_security_struct);
+		new_isec = security_get_value_type(new_dentry->d_inode->i_security,
+			SELINUX_LSM_ID, struct inode_security_struct,
+			selinux_secidx);
 		new_is_dir = S_ISDIR(new_dentry->d_inode->i_mode);
 		rc = avc_has_perm(tsec->sid, new_isec->sid,
 				  new_isec->sclass,
@@ -1227,10 +1264,12 @@ static int superblock_has_perm(struct ta
 	struct task_security_struct *tsec;
 	struct superblock_security_struct *sbsec;
 
-	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	sbsec = security_get_value_type(&sb->s_security, SELINUX_LSM_ID,
-		struct superblock_security_struct);
+	tsec = security_get_value_type(tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	sbsec = security_get_value_type(sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct,
+		selinux_secidx);
 	return avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			    perms, ad);
 }
@@ -1286,10 +1325,12 @@ static int inode_security_set_sid(struct
 	struct inode_security_struct *isec;
 	struct superblock_security_struct *sbsec;
 
-	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
-	sbsec = security_get_value_type(&inode->i_sb->s_security,
-		SELINUX_LSM_ID, struct superblock_security_struct);
+	isec = security_get_value_type(inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
+	sbsec = security_get_value_type(inode->i_sb->s_security,
+		SELINUX_LSM_ID, struct superblock_security_struct,
+		selinux_secidx);
 
 	if (!sbsec->initialized) {
 		/* Defer initialization to selinux_complete_init. */
@@ -1318,12 +1359,15 @@ static int post_create(struct inode *dir
 	unsigned int len;
 	int rc;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	dsec = security_get_value_type(&dir->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
-	sbsec = security_get_value_type(&dir->i_sb->s_security, SELINUX_LSM_ID,
-		struct superblock_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	dsec = security_get_value_type(dir->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
+	sbsec = security_get_value_type(dir->i_sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct,
+		selinux_secidx);
 
 	inode = dentry->d_inode;
 	if (!inode) {
@@ -1394,10 +1438,12 @@ static int selinux_ptrace(struct task_st
 	struct task_security_struct *csec;
 	int rc;
 
-	psec = security_get_value_type(&parent->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	csec = security_get_value_type(&child->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	psec = security_get_value_type(parent->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	csec = security_get_value_type(child->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 
 	rc = task_has_perm(parent, child, PROCESS__PTRACE);
 	/* Save the SID of the tracing process for later use in apply_creds. */
@@ -1431,8 +1477,9 @@ static int selinux_sysctl(ctl_table *tab
 	u32 tsid;
 	int rc;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 
 	rc = selinux_proc_get_sid(table->de, (op == 001) ?
 	                          SECCLASS_DIR : SECCLASS_FILE, &tsid);
@@ -1537,7 +1584,8 @@ static int selinux_bprm_alloc_security(s
 	bsec->sid = SECINITSID_UNLABELED;
 	bsec->set = 0;
 
-	security_set_value_type(&bprm->security, SELINUX_LSM_ID, bsec);
+	security_set_value_type(bprm->security, SELINUX_LSM_ID, bsec,
+		selinux_secidx);
 	return 0;
 }
 
@@ -1551,16 +1599,19 @@ static int selinux_bprm_set_security(str
 	struct avc_audit_data ad;
 	int rc;
 
-	bsec = security_get_value_type(&bprm->security, SELINUX_LSM_ID,
-		struct bprm_security_struct);
+	bsec = security_get_value_type(bprm->security, SELINUX_LSM_ID,
+		struct bprm_security_struct,
+		selinux_secidx);
 
 	if (bsec->set)
 		return 0;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
 
 	/* Default to the current task SID. */
 	bsec->sid = tsec->sid;
@@ -1620,8 +1671,9 @@ static int selinux_bprm_secureexec (stru
 	struct task_security_struct *tsec;
 	int atsecure = 0;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 	if (tsec->osid != tsec->sid) {
 		/* Enable secure mode for SIDs transitions unless
 		   the noatsecure permission is granted between
@@ -1638,8 +1690,8 @@ static void selinux_bprm_free_security(s
 {
  	struct bprm_security_struct *bsec;
 
- 	bsec = security_del_value_type(&bprm->security, SELINUX_LSM_ID,
- 			struct bprm_security_struct);
+ 	bsec = security_del_value_type(bprm->security, SELINUX_LSM_ID,
+ 			struct bprm_security_struct, selinux_secidx);
 	kfree(bsec);
 }
 
@@ -1735,10 +1787,12 @@ static void selinux_bprm_apply_creds(str
 	u32 sid;
 	int rc;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	bsec = security_get_value_type(&bprm->security, SELINUX_LSM_ID,
-		struct bprm_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	bsec = security_get_value_type(bprm->security, SELINUX_LSM_ID,
+		struct bprm_security_struct,
+		selinux_secidx);
 	sid = bsec->sid;
 
 	tsec->osid = tsec->sid;
@@ -1781,10 +1835,12 @@ static void selinux_bprm_post_apply_cred
 	struct bprm_security_struct *bsec;
 	int rc, i;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	bsec = security_get_value_type(&bprm->security, SELINUX_LSM_ID,
-		struct bprm_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	bsec = security_get_value_type(bprm->security, SELINUX_LSM_ID,
+		struct bprm_security_struct,
+		selinux_secidx);
 
 	if (bsec->unsafe) {
 		force_sig_specific(SIGKILL, current);
@@ -2121,8 +2177,9 @@ static int selinux_inode_setxattr(struct
 		return dentry_has_perm(current, NULL, dentry, FILE__SETATTR);
 	}
 
-	sbsec = security_get_value_type(&inode->i_sb->s_security,
-		SELINUX_LSM_ID, struct superblock_security_struct);
+	sbsec = security_get_value_type(inode->i_sb->s_security,
+		SELINUX_LSM_ID, struct superblock_security_struct,
+		selinux_secidx);
 	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
 		return -EOPNOTSUPP;
 
@@ -2132,10 +2189,12 @@ static int selinux_inode_setxattr(struct
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 	ad.u.fs.dentry = dentry;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
 	rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
 			  FILE__RELABELFROM, &ad);
 	if (rc)
@@ -2170,8 +2229,9 @@ static void selinux_inode_post_setxattr(
 	u32 newsid;
 	int rc;
 
-	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	isec = security_get_value_type(inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
 
 	if (strcmp(name, XATTR_NAME_SELINUX)) {
 		/* Not an attribute we recognize, so nothing to do. */
@@ -2194,8 +2254,9 @@ static int selinux_inode_getxattr (struc
 	struct inode *inode = dentry->d_inode;
 	struct superblock_security_struct *sbsec;
 	
-	sbsec = security_get_value_type(&inode->i_sb->s_security,
-		SELINUX_LSM_ID, struct superblock_security_struct);
+	sbsec = security_get_value_type(inode->i_sb->s_security,
+		SELINUX_LSM_ID, struct superblock_security_struct,
+		selinux_secidx);
 
 	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
 		return -EOPNOTSUPP;
@@ -2242,8 +2303,9 @@ static int selinux_inode_getsecurity(str
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
-	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	isec = security_get_value_type(inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
 
 	rc = security_sid_to_context(isec->sid, &context, &len);
 	if (rc)
@@ -2272,8 +2334,9 @@ static int selinux_inode_setsecurity(str
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
-	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	isec = security_get_value_type(inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
 
 	if (!value || !size)
 		return -EACCES;
@@ -2511,10 +2574,12 @@ static int selinux_file_set_fowner(struc
 	struct task_security_struct *tsec;
 	struct file_security_struct *fsec;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	fsec = security_get_value_type(&file->f_security, SELINUX_LSM_ID,
-		struct file_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	fsec = security_get_value_type(file->f_security, SELINUX_LSM_ID,
+		struct file_security_struct,
+		selinux_secidx);
 	fsec->fown_sid = tsec->sid;
 
 	return 0;
@@ -2531,10 +2596,12 @@ static int selinux_file_send_sigiotask(s
 	/* struct fown_struct is never outside the context of a struct file */
         file = (struct file *)((long)fown - offsetof(struct file,f_owner));
 
-	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	fsec = security_get_value_type(&file->f_security, SELINUX_LSM_ID,
-		struct file_security_struct);
+	tsec = security_get_value_type(tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	fsec = security_get_value_type(file->f_security, SELINUX_LSM_ID,
+		struct file_security_struct,
+		selinux_secidx);
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -2562,14 +2629,16 @@ static int selinux_task_alloc_security(s
 	struct task_security_struct *tsec1, *tsec2;
 	int rc;
 
-	tsec1 = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec1 = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 
 	rc = task_alloc_security(tsk);
 	if (rc)
 		return rc;
-	tsec2 = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec2 = security_get_value_type(tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 
 	tsec2->osid = tsec1->osid;
 	tsec2->sid = tsec1->sid;
@@ -2698,8 +2767,9 @@ static void selinux_task_reparent_to_ini
 {
   	struct task_security_struct *tsec;
 
-	tsec = security_get_value_type(&p->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(p->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 	tsec->osid = tsec->sid;
 	tsec->sid = SECINITSID_KERNEL;
 	return;
@@ -2711,10 +2781,12 @@ static void selinux_task_to_inode(struct
 	struct task_security_struct *tsec;
 	struct inode_security_struct *isec;
 
-	tsec = security_get_value_type(&p->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	tsec = security_get_value_type(p->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
 
 	isec->sid = tsec->sid;
 	isec->initialized = 1;
@@ -2882,10 +2954,12 @@ static int socket_has_perm(struct task_s
 	struct avc_audit_data ad;
 	int err = 0;
 
-	tsec = security_get_value_type(&task->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&SOCK_INODE(sock)->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	tsec = security_get_value_type(task->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
 
 	if (isec->sid == SECINITSID_KERNEL)
 		goto out;
@@ -2907,8 +2981,9 @@ static int selinux_socket_create(int fam
 	if (kern)
 		goto out;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 	err = avc_has_perm(tsec->sid, tsec->sid,
 			   socket_type_to_security_class(family, type,
 			   protocol), SOCKET__CREATE, NULL);
@@ -2923,11 +2998,13 @@ static void selinux_socket_post_create(s
 	struct inode_security_struct *isec;
 	struct task_security_struct *tsec;
 
-	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
-
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	isec = security_get_value_type(SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
+
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 	isec->sclass = socket_type_to_security_class(family, type, protocol);
 	isec->sid = kern ? SECINITSID_KERNEL : tsec->sid;
 	isec->initialized = 1;
@@ -2965,10 +3042,12 @@ static int selinux_socket_bind(struct so
 		struct sock *sk = sock->sk;
 		u32 sid, node_perm, addrlen;
 
-		tsec = security_get_value_type(&current->security,
-			SELINUX_LSM_ID, struct task_security_struct);
-		isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
-			SELINUX_LSM_ID, struct inode_security_struct);
+		tsec = security_get_value_type(current->security,
+			SELINUX_LSM_ID, struct task_security_struct,
+			selinux_secidx);
+		isec = security_get_value_type(SOCK_INODE(sock)->i_security,
+			SELINUX_LSM_ID, struct inode_security_struct,
+			selinux_secidx);
 
 		if (family == PF_INET) {
 			addr4 = (struct sockaddr_in *)address;
@@ -3046,8 +3125,9 @@ static int selinux_socket_connect(struct
 	/*
 	 * If a TCP socket, check name_connect permission for the port.
 	 */
-	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
+	isec = security_get_value_type(SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
 	if (isec->sclass == SECCLASS_TCP_SOCKET) {
 		struct sock *sk = sock->sk;
 		struct avc_audit_data ad;
@@ -3101,11 +3181,13 @@ static int selinux_socket_accept(struct 
 	if (err)
 		return err;
 
-	newisec = security_get_value_type(&SOCK_INODE(newsock)->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
-
-	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
+	newisec = security_get_value_type(SOCK_INODE(newsock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
+
+	isec = security_get_value_type(SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
 	newisec->sclass = isec->sclass;
 	newisec->sid = isec->sid;
 	newisec->initialized = 1;
@@ -3161,10 +3243,12 @@ static int selinux_socket_unix_stream_co
 	struct avc_audit_data ad;
 	int err;
 
-	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
-	other_isec = security_get_value_type(&SOCK_INODE(other)->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
+	isec = security_get_value_type(SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
+	other_isec = security_get_value_type(SOCK_INODE(other)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad,NET);
 	ad.u.net.sk = other->sk;
@@ -3176,13 +3260,15 @@ static int selinux_socket_unix_stream_co
 		return err;
 
 	/* connecting socket */
-	ssec = security_get_value_type(&sock->sk->sk_security, SELINUX_LSM_ID,
-		struct sk_security_struct);
+	ssec = security_get_value_type(sock->sk->sk_security, SELINUX_LSM_ID,
+		struct sk_security_struct,
+		selinux_secidx);
 	ssec->peer_sid = other_isec->sid;
 	
 	/* server child socket */
-	ssec = security_get_value_type(&newsk->sk_security, SELINUX_LSM_ID,
-		struct sk_security_struct);
+	ssec = security_get_value_type(newsk->sk_security, SELINUX_LSM_ID,
+		struct sk_security_struct,
+		selinux_secidx);
 	ssec->peer_sid = isec->sid;
 	
 	return 0;
@@ -3196,10 +3282,12 @@ static int selinux_socket_unix_may_send(
 	struct avc_audit_data ad;
 	int err;
 
-	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
-	other_isec = security_get_value_type(&SOCK_INODE(other)->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
+	isec = security_get_value_type(SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
+	other_isec = security_get_value_type(SOCK_INODE(other)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad,NET);
 	ad.u.net.sk = other->sk;
@@ -3239,8 +3327,9 @@ static int selinux_socket_sock_rcv_skb(s
  		inode = SOCK_INODE(sock);
  		if (inode) {
  			struct inode_security_struct *isec;
-			isec = security_get_value_type(&inode->i_security,
-				SELINUX_LSM_ID, struct inode_security_struct);
+			isec = security_get_value_type(inode->i_security,
+				SELINUX_LSM_ID, struct inode_security_struct,
+				selinux_secidx);
  			sock_sid = isec->sid;
  			sock_class = isec->sclass;
  		}
@@ -3323,15 +3412,17 @@ static int selinux_socket_getpeersec(str
 	struct sk_security_struct *ssec;
 	struct inode_security_struct *isec;
 
-	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
+	isec = security_get_value_type(SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
 	if (isec->sclass != SECCLASS_UNIX_STREAM_SOCKET) {
 		err = -ENOPROTOOPT;
 		goto out;
 	}
 
-	ssec = security_get_value_type(&sock->sk->sk_security, SELINUX_LSM_ID,
-		struct sk_security_struct);
+	ssec = security_get_value_type(sock->sk->sk_security, SELINUX_LSM_ID,
+		struct sk_security_struct,
+		selinux_secidx);
 	
 	err = security_sid_to_context(ssec->peer_sid, &scontext, &scontext_len);
 	if (err)
@@ -3372,8 +3463,9 @@ static int selinux_nlmsg_perm(struct soc
 	struct socket *sock = sk->sk_socket;
 	struct inode_security_struct *isec;
 	
-	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
-		SELINUX_LSM_ID, struct inode_security_struct);
+	isec = security_get_value_type(SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct,
+		selinux_secidx);
 	
 	if (skb->len < NLMSG_SPACE(0)) {
 		err = -EINVAL;
@@ -3439,8 +3531,9 @@ static unsigned int selinux_ip_postroute
 	if (err)
 		goto out;
 
-	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
-		struct inode_security_struct);
+	isec = security_get_value_type(inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct,
+		selinux_secidx);
 	
 	switch (isec->sclass) {
 	case SECCLASS_UDP_SOCKET:
@@ -3546,8 +3639,9 @@ static int selinux_netlink_send(struct s
 	struct av_decision avd;
 	int err = 0;
 
-	tsec = security_get_value_type(&current->security,
-		SELINUX_LSM_ID, struct task_security_struct);
+	tsec = security_get_value_type(current->security,
+		SELINUX_LSM_ID, struct task_security_struct,
+		selinux_secidx);
 
 	avd.allowed = 0;
 	avc_has_perm_noaudit(tsec->sid, tsec->sid,
@@ -3567,8 +3661,9 @@ static int ipc_alloc_security(struct tas
 	struct task_security_struct *tsec;
 	struct ipc_security_struct *isec;
 
-	tsec = security_get_value_type(&task->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(task->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 
 	isec = kmalloc(sizeof(struct ipc_security_struct), GFP_KERNEL);
 	if (!isec)
@@ -3582,7 +3677,8 @@ static int ipc_alloc_security(struct tas
 	} else {
 		isec->sid = SECINITSID_UNLABELED;
 	}
-	security_set_value_type(&perm->security, SELINUX_LSM_ID, isec);
+	security_set_value_type(perm->security, SELINUX_LSM_ID, isec,
+		selinux_secidx);
 
 	return 0;
 }
@@ -3591,8 +3687,8 @@ static void ipc_free_security(struct ker
 {
 	struct ipc_security_struct *isec;
 	
-	isec = security_del_value_type(&perm->security, SELINUX_LSM_ID,
-		struct ipc_security_struct);
+	isec = security_del_value_type(perm->security, SELINUX_LSM_ID,
+		struct ipc_security_struct, selinux_secidx);
 
 	kfree(isec);
 }
@@ -3608,7 +3704,8 @@ static int msg_msg_alloc_security(struct
 	memset(msec, 0, sizeof(struct msg_security_struct));
 	msec->msg = msg;
 	msec->sid = SECINITSID_UNLABELED;
-	security_set_value_type(&msg->security, SELINUX_LSM_ID, msec);
+	security_set_value_type(msg->security, SELINUX_LSM_ID, msec,
+		selinux_secidx);
 
 	return 0;
 }
@@ -3617,8 +3714,9 @@ static void msg_msg_free_security(struct
 {
 	struct msg_security_struct *msec;
 	
-	msec = security_del_value_type(&msg->security, SELINUX_LSM_ID,
-		struct msg_security_struct);
+	msec = security_del_value_type(msg->security, SELINUX_LSM_ID,
+		struct msg_security_struct,
+			selinux_secidx);
 
 	kfree(msec);
 }
@@ -3630,10 +3728,12 @@ static int ipc_has_perm(struct kern_ipc_
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&ipc_perms->security, SELINUX_LSM_ID,
-		struct ipc_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(ipc_perms->security, SELINUX_LSM_ID,
+		struct ipc_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = ipc_perms->key;
@@ -3663,10 +3763,12 @@ static int selinux_msg_queue_alloc_secur
 	if (rc)
 		return rc;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&msq->q_perm.security, SELINUX_LSM_ID,
-		struct ipc_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(msq->q_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = msq->q_perm.key;
@@ -3691,10 +3793,12 @@ static int selinux_msg_queue_associate(s
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&msq->q_perm.security, SELINUX_LSM_ID,
-		struct ipc_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(msq->q_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = msq->q_perm.key;
@@ -3739,12 +3843,15 @@ static int selinux_msg_queue_msgsnd(stru
 	struct avc_audit_data ad;
 	int rc;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&msq->q_perm.security, SELINUX_LSM_ID,
-		struct ipc_security_struct);
-	msec = security_get_value_type(&msg->security, SELINUX_LSM_ID,
-		struct msg_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(msq->q_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct,
+		selinux_secidx);
+	msec = security_get_value_type(msg->security, SELINUX_LSM_ID,
+		struct msg_security_struct,
+		selinux_secidx);
 
 	/*
 	 * First time through, need to assign label to the message
@@ -3790,12 +3897,15 @@ static int selinux_msg_queue_msgrcv(stru
 	struct avc_audit_data ad;
 	int rc;
 
-	tsec = security_get_value_type(&target->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&msq->q_perm.security, SELINUX_LSM_ID,
-		struct ipc_security_struct);
-	msec = security_get_value_type(&msg->security, SELINUX_LSM_ID,
-		struct msg_security_struct);
+	tsec = security_get_value_type(target->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(msq->q_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct,
+		selinux_secidx);
+	msec = security_get_value_type(msg->security, SELINUX_LSM_ID,
+		struct msg_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = msq->q_perm.key;
@@ -3820,10 +3930,12 @@ static int selinux_shm_alloc_security(st
 	if (rc)
 		return rc;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&shp->shm_perm.security, SELINUX_LSM_ID,
-		struct ipc_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(shp->shm_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = shp->shm_perm.key;
@@ -3848,10 +3960,12 @@ static int selinux_shm_associate(struct 
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&shp->shm_perm.security, SELINUX_LSM_ID,
-		struct ipc_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(shp->shm_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = shp->shm_perm.key;
@@ -3918,10 +4032,12 @@ static int selinux_sem_alloc_security(st
 	if (rc)
 		return rc;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&sma->sem_perm.security, SELINUX_LSM_ID,
-		struct ipc_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(sma->sem_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = sma->sem_perm.key;
@@ -3946,10 +4062,12 @@ static int selinux_sem_associate(struct 
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
-	isec = security_get_value_type(&sma->sem_perm.security, SELINUX_LSM_ID,
-		struct ipc_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
+	isec = security_get_value_type(sma->sem_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct,
+		selinux_secidx);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = sma->sem_perm.key;
@@ -4063,8 +4181,9 @@ static int selinux_getprocattr(struct ta
 	if (!size)
 		return -ERANGE;
 
-	tsec = security_get_value_type(&p->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(p->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 
 	if (!strcmp(name, "current"))
 		sid = tsec->sid;
@@ -4139,8 +4258,9 @@ static int selinux_setprocattr(struct ta
 	   operation.  See selinux_bprm_set_security for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
-	tsec = security_get_value_type(&p->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(p->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 	if (!strcmp(name, "exec"))
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
@@ -4358,14 +4478,16 @@ static __init int selinux_init(void)
 	/* Set the security state for the initial task. */
 	if (task_alloc_security(current))
 		panic("SELinux:  Failed to initialize initial task.\n");
-	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
-		struct task_security_struct);
+	tsec = security_get_value_type(current->security, SELINUX_LSM_ID,
+		struct task_security_struct,
+		selinux_secidx);
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
 
 	avc_init();
 
-	if (register_security (&selinux_ops)) {
-		if (mod_reg_security( MY_NAME, &selinux_ops)) {
+	selinux_secidx = 1;
+	if (register_security (&selinux_ops, &selinux_secidx)) {
+		if (mod_reg_security( MY_NAME, &selinux_ops, &selinux_secidx)) {
 			printk(KERN_ERR "%s: Failed to register with primary LSM.\n",
 				__FUNCTION__);
 			panic("SELinux: Unable to register with kernel.\n");
@@ -4375,6 +4497,7 @@ static __init int selinux_init(void)
 		}
 		secondary = 1;
 	}
+	printk(KERN_NOTICE "got selinux_secidx %d\n", selinux_secidx);
 
 	if (selinux_enforcing) {
 		printk(KERN_INFO "SELinux:  Starting in enforcing mode\n");
Index: linux-2.6.13-rc4/security/selinux/selinuxfs.c
===================================================================
--- linux-2.6.13-rc4.orig/security/selinux/selinuxfs.c	2005-08-01 20:00:51.000000000 -0500
+++ linux-2.6.13-rc4/security/selinux/selinuxfs.c	2005-08-05 22:00:36.000000000 -0500
@@ -35,6 +35,8 @@
 #include "objsec.h"
 #include "conditional.h"
 
+extern int selinux_secidx;
+
 unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
 
 static int __init checkreqprot_setup(char *str)
@@ -60,8 +62,9 @@ static int task_has_security(struct task
 {
 	struct task_security_struct *tsec;
 
-	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
-			struct task_security_struct);
+	tsec = security_get_value_type(tsk->security, SELINUX_LSM_ID,
+			struct task_security_struct,
+			selinux_secidx);
 	if (!tsec)
 		return -EACCES;
 
@@ -984,8 +987,9 @@ static int sel_make_bools(void)
 			ret = -ENAMETOOLONG;
 			goto err;
 		}
-		isec = security_get_value_type(&inode->i_security,
-				SELINUX_LSM_ID, struct inode_security_struct);
+		isec = security_get_value_type(inode->i_security,
+				SELINUX_LSM_ID, struct inode_security_struct,
+				selinux_secidx);
 		if ((ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid)))
 			goto err;
 		isec->sid = sid;
@@ -1270,8 +1274,9 @@ static int sel_fill_super(struct super_b
 	inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
 	if (!inode)
 		goto out;
-	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
-			struct inode_security_struct);
+	isec = security_get_value_type(inode->i_security, SELINUX_LSM_ID,
+			struct inode_security_struct,
+			selinux_secidx);
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
 	isec->initialized = 1;
Index: linux-2.6.13-rc4/security/seclvl.c
===================================================================
--- linux-2.6.13-rc4.orig/security/seclvl.c	2005-08-01 20:00:51.000000000 -0500
+++ linux-2.6.13-rc4/security/seclvl.c	2005-08-05 22:00:00.000000000 -0500
@@ -38,6 +38,8 @@
 #define SHA1_DIGEST_SIZE 20
 #define SECLVL_LSM_ID 0xF45
 
+static int seclvl_secidx;
+
 /**
  * Module parameter that defines the initial secure level.
  *
@@ -505,8 +507,8 @@ static void seclvl_inode_free(struct ino
 {
 	struct seclvl_i_sec *isec;
 
-	isec = security_del_value_type(&inode->i_security, SECLVL_LSM_ID,
-				struct seclvl_i_sec);
+	isec = security_del_value_type(inode->i_security, SECLVL_LSM_ID,
+				struct seclvl_i_sec, seclvl_secidx);
 	if (isec) {
 		spin_lock(&seclvl_ichain_lock);
 		list_del(&isec->chain);
@@ -545,8 +547,9 @@ static void seclvl_bd_release(struct ino
 	struct seclvl_i_sec *isec;
 
 	if (inode && S_ISBLK(inode->i_mode)) {
-		isec = security_get_value_type(&inode->i_security,
-				SECLVL_LSM_ID, struct seclvl_i_sec);
+		isec = security_get_value_type(inode->i_security,
+				SECLVL_LSM_ID, struct seclvl_i_sec,
+				seclvl_secidx);
 		if (!isec)
 			return;
 		spin_lock(&isec->spinlock);
@@ -573,13 +576,13 @@ seclvl_inode_get_or_alloc(struct inode *
 {
 	struct seclvl_i_sec *isec;
 
-	isec = security_get_value_type(&inode->i_security,
-			SECLVL_LSM_ID, struct seclvl_i_sec);
+	isec = security_get_value_type(inode->i_security,
+			SECLVL_LSM_ID, struct seclvl_i_sec, seclvl_secidx);
 	if (isec)
 		return isec;
 	spin_lock(&seclvl_ichain_lock);
-	isec = security_get_value_type(&inode->i_security,
-			SECLVL_LSM_ID, struct seclvl_i_sec);
+	isec = security_get_value_type(inode->i_security,
+			SECLVL_LSM_ID, struct seclvl_i_sec, seclvl_secidx);
 	if (isec)
 		goto out;
 	isec = kmalloc(sizeof(struct seclvl_i_sec), GFP_KERNEL);
@@ -588,7 +591,8 @@ seclvl_inode_get_or_alloc(struct inode *
 	spin_lock_init(&isec->spinlock);
 	INIT_LIST_HEAD(&isec->chain);
 	list_add(&isec->chain, &seclvl_ichain);
-	security_add_value_type(&inode->i_security, SECLVL_LSM_ID, isec);
+	security_add_value_type(inode->i_security, SECLVL_LSM_ID, isec,
+				seclvl_secidx);
 
 out:
 	spin_unlock(&seclvl_ichain_lock);
@@ -781,12 +785,13 @@ static int __init seclvl_init(void)
 		goto exit;
 	}
 	/* register ourselves with the security framework */
-	if (register_security(&seclvl_ops)) {
+	seclvl_secidx = 1;  /* yes we want to use a security field */
+	if (register_security(&seclvl_ops, &seclvl_secidx)) {
 		seclvl_printk(0, KERN_ERR,
 			      "seclvl: Failure registering with the "
 			      "kernel.\n");
 		/* try registering with primary module */
-		rc = mod_reg_security(MY_NAME, &seclvl_ops);
+		rc = mod_reg_security(MY_NAME, &seclvl_ops, &seclvl_secidx);
 		if (rc) {
 			seclvl_printk(0, KERN_ERR, "seclvl: Failure "
 				      "registering with primary security "
@@ -795,6 +800,7 @@ static int __init seclvl_init(void)
 		}		/* if primary module registered */
 		secondary = 1;
 	}			/* if we registered ourselves with the security framework */
+	printk(KERN_NOTICE "got seclvl_secidx %d\n", seclvl_secidx);
 	if ((rc = doSysfsRegistrations())) {
 		seclvl_printk(0, KERN_ERR, "Error registering with sysfs\n");
 		goto exit;
@@ -821,7 +827,7 @@ static void free_ichain(void)
 	struct seclvl_i_sec *isec, *n;
 
 	list_for_each_entry_safe(isec, n, &seclvl_ichain, chain) {
-		security_unlink_value(&isec->lsm_list.list);
+		security_unlink_value(&isec->lsm_list.list, seclvl_secidx);
 	}
 
 	synchronize_rcu();
Index: linux-2.6.13-rc4/security/capability.c
===================================================================
--- linux-2.6.13-rc4.orig/security/capability.c	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/security/capability.c	2005-08-01 21:02:39.000000000 -0500
@@ -66,9 +66,9 @@ static int __init capability_init (void)
 		return 0;
 	}
 	/* register ourselves with the security framework */
-	if (register_security (&capability_ops)) {
+	if (register_security (&capability_ops, NULL)) {
 		/* try registering with primary module */
-		if (mod_reg_security (MY_NAME, &capability_ops)) {
+		if (mod_reg_security (MY_NAME, &capability_ops, NULL)) {
 			printk (KERN_INFO "Failure registering capabilities "
 				"with primary security module.\n");
 			return -EINVAL;
Index: linux-2.6.13-rc4/security/root_plug.c
===================================================================
--- linux-2.6.13-rc4.orig/security/root_plug.c	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/security/root_plug.c	2005-08-01 21:02:39.000000000 -0500
@@ -104,11 +104,11 @@ static struct security_operations rootpl
 static int __init rootplug_init (void)
 {
 	/* register ourselves with the security framework */
-	if (register_security (&rootplug_security_ops)) {
+	if (register_security (&rootplug_security_ops, NULL)) {
 		printk (KERN_INFO 
 			"Failure registering Root Plug module with the kernel\n");
 		/* try registering with primary module */
-		if (mod_reg_security (MY_NAME, &rootplug_security_ops)) {
+		if (mod_reg_security (MY_NAME, &rootplug_security_ops, NULL)) {
 			printk (KERN_INFO "Failure registering Root Plug "
 				" module with primary security module.\n");
 			return -EINVAL;
Index: linux-2.6.13-rc4/security/cap_stack.c
===================================================================
--- linux-2.6.13-rc4.orig/security/cap_stack.c	2005-08-01 20:00:51.000000000 -0500
+++ linux-2.6.13-rc4/security/cap_stack.c	2005-08-01 21:02:39.000000000 -0500
@@ -62,9 +62,9 @@ static int __init capability_init (void)
 		return 0;
 	}
 	/* register ourselves with the security framework */
-	if (register_security (&capability_ops)) {
+	if (register_security (&capability_ops, NULL)) {
 		/* try registering with primary module */
-		if (mod_reg_security (MY_NAME, &capability_ops)) {
+		if (mod_reg_security (MY_NAME, &capability_ops, NULL)) {
 			printk (KERN_INFO "Failure registering capabilities "
 				"with primary security module.\n");
 			return -EINVAL;
Index: linux-2.6.13-rc4/security/stacker.c
===================================================================
--- linux-2.6.13-rc4.orig/security/stacker.c	2005-08-01 20:00:51.000000000 -0500
+++ linux-2.6.13-rc4/security/stacker.c	2005-08-06 21:28:05.000000000 -0500
@@ -314,9 +314,11 @@ static int stacker_bprm_alloc_security (
 
 static void stacker_bprm_free_security (struct linux_binprm *bprm)
 {
+	struct hlist_head *h;
 	FREE_ALL(bprm_free_security,bprm_free_security(bprm));
-	if (unlikely(!hlist_empty(&bprm->security)))
-		security_disown_value(&bprm->security);
+	h = (struct hlist_head *)&bprm->security[sec_shared_slot];
+	if (unlikely(!hlist_empty(h)))
+		security_disown_value(h);
 }
 
 static void stacker_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
@@ -351,9 +353,11 @@ static int stacker_sb_alloc_security (st
 
 static void stacker_sb_free_security (struct super_block *sb)
 {
+	struct hlist_head *h;
 	FREE_ALL(sb_free_security,sb_free_security(sb));
-	if (unlikely(!hlist_empty(&sb->s_security)))
-		security_disown_value(&sb->s_security);
+	h = (struct hlist_head *)&sb->s_security[sec_shared_slot];
+	if (unlikely(!hlist_empty(h)))
+		security_disown_value(h);
 }
 
 static int stacker_sb_copy_data (struct file_system_type *type,
@@ -432,9 +436,11 @@ static int stacker_inode_alloc_security 
 
 static void stacker_inode_free_security (struct inode *inode)
 {
+	struct hlist_head *h;
 	FREE_ALL(inode_free_security,inode_free_security(inode));
-	if (unlikely(!hlist_empty(&inode->i_security)))
-		security_disown_value(&inode->i_security);
+	h = (struct hlist_head *)&inode->i_security[sec_shared_slot];
+	if (unlikely(!hlist_empty(h)))
+		security_disown_value(h);
 }
 
 static int stacker_inode_create (struct inode *inode, struct dentry *dentry,
@@ -684,9 +690,11 @@ static int stacker_file_alloc_security (
 
 static void stacker_file_free_security (struct file *file)
 {
+	struct hlist_head *h;
 	FREE_ALL(file_free_security,file_free_security(file));
-	if (unlikely(!hlist_empty(&file->f_security)))
-		security_disown_value(&file->f_security);
+	h = (struct hlist_head *)&file->f_security[sec_shared_slot];
+	if (unlikely(!hlist_empty(h)))
+		security_disown_value(h);
 }
 
 static int stacker_file_ioctl (struct file *file, unsigned int command,
@@ -746,9 +754,11 @@ static int stacker_task_alloc_security (
 
 static void stacker_task_free_security (struct task_struct *p)
 {
+	struct hlist_head *h;
 	FREE_ALL(task_free_security,task_free_security(p));
-	if (unlikely(!hlist_empty(&p->security)))
-		security_disown_value(&p->security);
+	h = (struct hlist_head *)&p->security[sec_shared_slot];
+	if (unlikely(!hlist_empty(h)))
+		security_disown_value(h);
 }
 
 static int stacker_task_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
@@ -945,9 +955,11 @@ static int stacker_sk_alloc_security(str
 
 static void stacker_sk_free_security (struct sock *sk)
 {
+	struct hlist_head *h;
 	FREE_ALL(sk_free_security,sk_free_security(sk));
-	if (unlikely(!hlist_empty(&sk->sk_security)))
-		security_disown_value(&sk->sk_security);
+	h = (struct hlist_head *)&sk->sk_security[sec_shared_slot];
+	if (unlikely(!hlist_empty(h)))
+		security_disown_value(h);
 }
 
 #endif
@@ -964,9 +976,11 @@ static int stacker_msg_msg_alloc_securit
 
 static void stacker_msg_msg_free_security (struct msg_msg *msg)
 {
+	struct hlist_head *h;
 	FREE_ALL(msg_msg_free_security,msg_msg_free_security(msg));
-	if (unlikely(!hlist_empty(&msg->security)))
-		security_disown_value(&msg->security);
+	h = (struct hlist_head *)&msg->security[sec_shared_slot];
+	if (unlikely(!hlist_empty(h)))
+		security_disown_value(h);
 }
 
 static int stacker_msg_queue_alloc_security (struct msg_queue *msq)
@@ -976,9 +990,11 @@ static int stacker_msg_queue_alloc_secur
 
 static void stacker_msg_queue_free_security (struct msg_queue *msq)
 {
+	struct hlist_head *h;
 	FREE_ALL(msg_queue_free_security,msg_queue_free_security(msq));
-	if (unlikely(!hlist_empty(&msq->q_perm.security)))
-		security_disown_value(&msq->q_perm.security);
+	h = (struct hlist_head *)&msq->q_perm.security[sec_shared_slot];
+	if (unlikely(!hlist_empty(h)))
+		security_disown_value(h);
 }
 
 static int stacker_msg_queue_associate (struct msg_queue *msq, int msqflg)
@@ -1011,9 +1027,11 @@ static int stacker_shm_alloc_security (s
 
 static void stacker_shm_free_security (struct shmid_kernel *shp)
 {
+	struct hlist_head *h;
 	FREE_ALL(shm_free_security,shm_free_security(shp));
-	if (unlikely(!hlist_empty(&shp->shm_perm.security)))
-		security_disown_value(&shp->shm_perm.security);
+	h = (struct hlist_head *)&shp->shm_perm.security[sec_shared_slot];
+	if (unlikely(!hlist_empty(h)))
+		security_disown_value(h);
 }
 
 static int stacker_shm_associate (struct shmid_kernel *shp, int shmflg)
@@ -1039,9 +1057,11 @@ static int stacker_sem_alloc_security (s
 
 static void stacker_sem_free_security (struct sem_array *sma)
 {
+	struct hlist_head *h;
 	FREE_ALL(sem_free_security,sem_free_security(sma));
-	if (unlikely(!hlist_empty(&sma->sem_perm.security)))
-		security_disown_value(&sma->sem_perm.security);
+	h = (struct hlist_head *)&sma->sem_perm.security[sec_shared_slot];
+	if (unlikely(!hlist_empty(h)))
+		security_disown_value(h);
 }
 
 static int stacker_sem_associate (struct sem_array *sma, int semflg)
@@ -1629,7 +1649,7 @@ static int __init stacker_init (void)
 	INIT_LIST_HEAD(&default_module.lsm_list);
 	list_add_tail(&default_module.lsm_list, &stacked_modules);
 
-	if (register_security (&stacker_ops)) {
+	if (register_security (&stacker_ops, NULL)) {
 		/*
 		 * stacking stacker is just a stupid idea, so don't ask
 		 * the current module to load us.
Index: linux-2.6.13-rc4/include/linux/security-stack.h
===================================================================
--- linux-2.6.13-rc4.orig/include/linux/security-stack.h	2005-08-01 20:00:51.000000000 -0500
+++ linux-2.6.13-rc4/include/linux/security-stack.h	2005-08-05 22:08:41.000000000 -0500
@@ -10,16 +10,12 @@
  */
 
 extern fastcall struct security_list *security_get_value(
-			struct hlist_head *head,
-			int security_id);
+			void **sec, int security_id);
 
 extern fastcall struct security_list *security_set_value(
-			struct hlist_head *head,
-			int security_id, struct security_list *obj_node);
+			void **sec, int security_id, struct security_list *obj_node);
 extern fastcall struct security_list *security_add_value(
-			struct hlist_head *head,
-			int security_id, struct security_list *obj_node);
-extern int security_unlink_value(struct hlist_node *n);
+			void **sec, int security_id, struct security_list *obj_node);
+extern int security_unlink_value(struct hlist_node *n, int idx);
 extern fastcall struct security_list *security_del_value(
-			struct hlist_head *head,
-			int security_id);
+			void **sec, int security_id);
Index: linux-2.6.13-rc4/fs/compat.c
===================================================================
--- linux-2.6.13-rc4.orig/fs/compat.c	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/fs/compat.c	2005-08-06 01:43:55.000000000 -0500
@@ -51,6 +51,8 @@
 #include <asm/mmu_context.h>
 #include <asm/ioctls.h>
 
+extern int sec_shared_slot;
+
 /*
  * Not all architectures have sys_utime, so implement this in terms
  * of sys_utimes.
@@ -1523,7 +1525,7 @@ int compat_do_execve(char * filename,
 	bprm->file = file;
 	bprm->filename = filename;
 	bprm->interp = filename;
-	INIT_HLIST_HEAD(&bprm->security);
+	INIT_HLIST_HEAD((struct hlist_head *)&(bprm->security[sec_shared_slot]));
 	bprm->mm = mm_alloc();
 	retval = -ENOMEM;
 	if (!bprm->mm)
Index: linux-2.6.13-rc4/fs/exec.c
===================================================================
--- linux-2.6.13-rc4.orig/fs/exec.c	2005-08-01 20:00:50.000000000 -0500
+++ linux-2.6.13-rc4/fs/exec.c	2005-08-06 01:44:02.000000000 -0500
@@ -1166,7 +1166,7 @@ int do_execve(char * filename,
 	bprm->file = file;
 	bprm->filename = filename;
 	bprm->interp = filename;
-	INIT_HLIST_HEAD(&bprm->security);
+	INIT_HLIST_HEAD((struct hlist_head *)&(bprm->security[sec_shared_slot]));
 	bprm->mm = mm_alloc();
 	retval = -ENOMEM;
 	if (!bprm->mm)
