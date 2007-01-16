Return-Path: <linux-kernel-owner+w=401wt.eu-S932432AbXAPG2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbXAPG2x (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 01:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbXAPG2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 01:28:30 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:44270 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbXAPG1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 01:27:54 -0500
Message-Id: <20070116063030.761795000@bull.net>
References: <20070116061516.899460000@bull.net>
User-Agent: quilt/0.45-1
Date: Tue, 16 Jan 2007 07:15:22 +0100
From: Nadia.Derbey@bull.net
To: linux-kernel@vger.kernel.org
Cc: Nadia Derbey <Nadia.Derbey@bull.net>
Subject: [RFC][PATCH 6/6] automatic tuning applied to some kernel components
Content-Disposition: inline; filename=auto_tune_applied.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 06/06]


The following kernel components register a tunable structure and call the
auto-tuning routine:
  . file system
  . shared memory (per namespace)
  . semaphore (per namespace)
  . message queues (per namespace)


Signed-off-by: Nadia Derbey <Nadia.Derbey@bull.net>


---
 fs/file_table.c     |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/akt.h |    1 
 include/linux/ipc.h |    6 +++
 init/main.c         |    1 
 ipc/msg.c           |   19 ++++++++++++
 ipc/sem.c           |   41 ++++++++++++++++++++++++++
 ipc/shm.c           |   74 ++++++++++++++++++++++++++++++++++++++++++++---
 7 files changed, 218 insertions(+), 5 deletions(-)

Index: linux-2.6.20-rc4/fs/file_table.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/file_table.c	2007-01-15 13:08:14.000000000 +0100
+++ linux-2.6.20-rc4/fs/file_table.c	2007-01-15 15:44:39.000000000 +0100
@@ -21,6 +21,8 @@
 #include <linux/fsnotify.h>
 #include <linux/sysctl.h>
 #include <linux/percpu_counter.h>
+#include <linux/akt.h>
+#include <linux/akt_ops.h>
 
 #include <asm/atomic.h>
 
@@ -34,6 +36,71 @@ __cacheline_aligned_in_smp DEFINE_SPINLO
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
+#ifdef CONFIG_AKT
+
+static int get_nr_files(void);
+
+/********** automatic tuning **********/
+#define FILPTHRESH 80		/* threshold = 80% */
+
+/*
+ * FUNCTION:    This is the routine called to accomplish auto tuning for the
+ *              max_files tunable.
+ *
+ *              Upwards adjustment:
+ *                  Adjustment is needed if nr_files has reached
+ *                  (threshold / 100 * max_files)
+ *                  In that case, max_files is set to
+ *                  (tunable + max_files * (100 - threshold) / 100)
+ *
+ *              Downards adjustment:
+ *                   Adjustment is needed if nr_files has fallen under
+ *                   (threshold / 100 * max_files previous value)
+ *                   In that case max_files is set back to its previous value,
+ *                   i.e. to (max_files * 100 / (200 - threshold))
+ *
+ * PARAMETERS:  cmd: controls the adjustment direction (up / down)
+ *              params: pointer to the registered tunable structure
+ *
+ * EXECUTION ENVIRONMENT: This routine should be called with the
+ *                        params->tunable_lck lock held
+ *
+ * RETURN VALUE: 1 if tunable has been adjusted
+ *               0 else
+ */
+static inline int maxfiles_auto_tuning(int cmd, struct auto_tune *params)
+{
+	int thr = params->threshold;
+	int min = params->min.value.val_int;
+	int max = params->max.value.val_int;
+	int tun = files_stat.max_files;
+
+	if (cmd == AKT_UP) {
+		if (get_nr_files() >= tun * thr / 100 && tun < max) {
+			int new = tun * (200 - thr) / 100;
+
+			files_stat.max_files = min(max, new);
+			return 1;
+		} else
+			return 0;
+	}
+
+	if (get_nr_files() < tun * thr / (200 - thr) && tun > min) {
+		int new = tun * 100 / (200 - thr);
+
+		files_stat.max_files = max(min, new);
+		return 1;
+	} else
+		return 0;
+}
+
+#endif /* CONFIG_AKT */
+
+/* The maximum value will be known later on */
+DEFINE_TUNABLE(maxfiles_akt, FILPTHRESH, 0, 0, &files_stat.max_files,
+		&nr_files, int);
+
+
 static inline void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f =  container_of(head, struct file, f_u.fu_rcuhead);
@@ -44,6 +111,8 @@ static inline void file_free(struct file
 {
 	percpu_counter_dec(&nr_files);
 	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
+
+	activate_auto_tuning(AKT_DOWN, &maxfiles_akt);
 }
 
 /*
@@ -91,6 +160,8 @@ struct file *get_empty_filp(void)
 	static int old_max;
 	struct file * f;
 
+	activate_auto_tuning(AKT_UP, &maxfiles_akt);
+
 	/*
 	 * Privileged users can go above max_files
 	 */
@@ -299,6 +370,16 @@ void __init files_init(unsigned long mem
 	files_stat.max_files = n; 
 	if (files_stat.max_files < NR_FILE)
 		files_stat.max_files = NR_FILE;
+
+	set_tunable_min_max(maxfiles_akt, n, n * 2, int);
+	set_autotuning_routine(&maxfiles_akt, maxfiles_auto_tuning);
+
 	files_defer_init();
 	percpu_counter_init(&nr_files, 0);
 } 
+
+void __init files_late_init(void)
+{
+	if (register_tunable(&maxfiles_akt))
+		printk(KERN_WARNING "Failed registering tunable file-max\n");
+}
Index: linux-2.6.20-rc4/include/linux/akt.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/akt.h	2007-01-15 15:31:44.000000000 +0100
+++ linux-2.6.20-rc4/include/linux/akt.h	2007-01-15 15:45:29.000000000 +0100
@@ -295,5 +295,6 @@ static inline void init_auto_tuning(void
 #endif	/* CONFIG_AKT */
 
 extern void fork_late_init(void);
+extern void files_late_init(void);
 
 #endif /* AKT_H */
Index: linux-2.6.20-rc4/init/main.c
===================================================================
--- linux-2.6.20-rc4.orig/init/main.c	2007-01-15 15:09:27.000000000 +0100
+++ linux-2.6.20-rc4/init/main.c	2007-01-15 15:46:09.000000000 +0100
@@ -616,6 +616,7 @@ asmlinkage void __init start_kernel(void
 	page_writeback_init();
 	init_auto_tuning();
 	fork_late_init();
+	files_late_init();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
Index: linux-2.6.20-rc4/ipc/msg.c
===================================================================
--- linux-2.6.20-rc4.orig/ipc/msg.c	2007-01-15 13:08:15.000000000 +0100
+++ linux-2.6.20-rc4/ipc/msg.c	2007-01-15 15:48:16.000000000 +0100
@@ -36,6 +36,8 @@
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
 #include <linux/nsproxy.h>
+#include <linux/akt.h>
+#include <linux/akt_ops.h>
 
 #include <asm/current.h>
 #include <asm/uaccess.h>
@@ -94,6 +96,11 @@ static void __ipc_init __msg_init_ns(str
 	ns->msg_ctlmnb = MSGMNB;
 	ns->msg_ctlmni = MSGMNI;
 	ipc_init_ids(ids, ns->msg_ctlmni);
+
+#define MSGTHRESH 80
+
+	init_tunable_ipcns(ns, msgmni_akt, MSGTHRESH, MSGMNI, IPCMNI,
+		&ns->msg_ctlmni, &ids->in_use, int);
 }
 
 #ifdef CONFIG_IPC_NS
@@ -133,6 +140,10 @@ void msg_exit_ns(struct ipc_namespace *n
 void __init msg_init(void)
 {
 	__msg_init_ns(&init_ipc_ns, &init_msg_ids);
+
+	if (register_tunable(&init_ipc_ns.msgmni_akt))
+		printk(KERN_WARNING " Failed registering tunable msgmni\n");
+
 	ipc_init_proc_interface("sysvipc/msg",
 				"       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n",
 				IPC_MSG_IDS, sysvipc_msg_proc_show);
@@ -262,6 +273,8 @@ asmlinkage long sys_msgget(key_t key, in
 
 	ns = current->nsproxy->ipc_ns;
 	
+	activate_auto_tuning(AKT_UP, &ns->msgmni_akt);
+
 	mutex_lock(&msg_ids(ns).mutex);
 	if (key == IPC_PRIVATE) 
 		ret = newque(ns, key, msgflg);
@@ -391,6 +404,7 @@ asmlinkage long sys_msgctl(int msqid, in
 	struct msg_queue *msq;
 	int err, version;
 	struct ipc_namespace *ns;
+	int destroyed = 0;
 
 	if (msqid < 0 || cmd < 0)
 		return -EINVAL;
@@ -555,11 +569,16 @@ asmlinkage long sys_msgctl(int msqid, in
 	}
 	case IPC_RMID:
 		freeque(ns, msq, msqid);
+		destroyed = 1;
 		break;
 	}
 	err = 0;
 out_up:
 	mutex_unlock(&msg_ids(ns).mutex);
+
+	if (destroyed)
+		activate_auto_tuning(AKT_DOWN, &ns->msgmni_akt);
+
 	return err;
 out_unlock_up:
 	msg_unlock(msq);
Index: linux-2.6.20-rc4/ipc/shm.c
===================================================================
--- linux-2.6.20-rc4.orig/ipc/shm.c	2007-01-15 13:08:15.000000000 +0100
+++ linux-2.6.20-rc4/ipc/shm.c	2007-01-15 15:49:00.000000000 +0100
@@ -37,6 +37,8 @@
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
 #include <linux/nsproxy.h>
+#include <linux/akt.h>
+#include <linux/akt_ops.h>
 
 #include <asm/uaccess.h>
 
@@ -75,17 +77,27 @@ static void __ipc_init __shm_init_ns(str
 	ns->shm_ctlmni = SHMMNI;
 	ns->shm_tot = 0;
 	ipc_init_ids(ids, 1);
+
+#define SHMTHRESH 80
+	init_tunable_ipcns(ns, shmmni_akt, SHMTHRESH, SHMMNI, IPCMNI,
+		&ns->shm_ctlmni, &ids->in_use, int);
+	init_tunable_ipcns(ns, shmall_akt, SHMTHRESH, SHMALL,
+		SHMMAX / PAGE_SIZE * (IPCMNI / 16), &ns->shm_ctlall,
+		&ns->shm_tot, size_t);
 }
 
-static void do_shm_rmid(struct ipc_namespace *ns, struct shmid_kernel *shp)
+static int do_shm_rmid(struct ipc_namespace *ns, struct shmid_kernel *shp)
 {
 	if (shp->shm_nattch){
 		shp->shm_perm.mode |= SHM_DEST;
 		/* Do not find it any more */
 		shp->shm_perm.key = IPC_PRIVATE;
 		shm_unlock(shp);
-	} else
+		return 0;
+	} else {
 		shm_destroy(ns, shp);
+		return 1;
+	}
 }
 
 #ifdef CONFIG_IPC_NS
@@ -125,6 +137,13 @@ void shm_exit_ns(struct ipc_namespace *n
 void __init shm_init (void)
 {
 	__shm_init_ns(&init_ipc_ns, &init_shm_ids);
+
+	if (register_tunable(&init_ipc_ns.shmmni_akt))
+		printk(KERN_WARNING "Failed registering tunable shmmni\n");
+
+	if (register_tunable(&init_ipc_ns.shmall_akt))
+		printk(KERN_WARNING "Failed registering tunable shmall\n");
+
 	ipc_init_proc_interface("sysvipc/shm",
 				"       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime\n",
 				IPC_SHM_IDS, sysvipc_shm_proc_show);
@@ -206,6 +225,7 @@ static void shm_close (struct vm_area_st
 	int id = file->f_path.dentry->d_inode->i_ino;
 	struct shmid_kernel *shp;
 	struct ipc_namespace *ns;
+	int destroyed = 0;
 
 	ns = shm_file_ns(file);
 
@@ -217,11 +237,27 @@ static void shm_close (struct vm_area_st
 	shp->shm_dtim = get_seconds();
 	shp->shm_nattch--;
 	if(shp->shm_nattch == 0 &&
-	   shp->shm_perm.mode & SHM_DEST)
+	   shp->shm_perm.mode & SHM_DEST) {
 		shm_destroy(ns, shp);
-	else
+		destroyed = 1;
+	} else
 		shm_unlock(shp);
 	mutex_unlock(&shm_ids(ns).mutex);
+
+	if (destroyed) {
+		int rc;
+
+		rc = activate_auto_tuning(AKT_DOWN, &ns->shmmni_akt);
+		if (rc)
+			/*
+			 * shm_ctlmni has been adjusted == > change
+			 * shm_ctlall value
+			 */
+			ns->shm_ctlall = ns->shm_ctlmax / PAGE_SIZE *
+				(ns->shm_ctlmni / 16);
+
+		activate_auto_tuning(AKT_DOWN, &ns->shmall_akt);
+	}
 }
 
 static int shm_mmap(struct file * file, struct vm_area_struct * vma)
@@ -355,9 +391,20 @@ asmlinkage long sys_shmget (key_t key, s
 	struct shmid_kernel *shp;
 	int err, id = 0;
 	struct ipc_namespace *ns;
+	int rc;
 
 	ns = current->nsproxy->ipc_ns;
 
+	rc = activate_auto_tuning(AKT_UP, &ns->shmmni_akt);
+	if (rc)
+		/*
+		 * shm_ctlmni has been adjusted == > change shm_ctlall value
+		 */
+		ns->shm_ctlall = ns->shm_ctlmax / PAGE_SIZE
+				* (ns->shm_ctlmni / 16);
+
+	activate_auto_tuning(AKT_UP, &ns->shmall_akt);
+
 	mutex_lock(&shm_ids(ns).mutex);
 	if (key == IPC_PRIVATE) {
 		err = newseg(ns, key, shmflg, size);
@@ -516,6 +563,7 @@ asmlinkage long sys_shmctl (int shmid, i
 	struct shmid_kernel *shp;
 	int err, version;
 	struct ipc_namespace *ns;
+	int destroyed;
 
 	if (cmd < 0 || shmid < 0) {
 		err = -EINVAL;
@@ -701,8 +749,24 @@ asmlinkage long sys_shmctl (int shmid, i
 		if (err)
 			goto out_unlock_up;
 
-		do_shm_rmid(ns, shp);
+		destroyed = do_shm_rmid(ns, shp);
 		mutex_unlock(&shm_ids(ns).mutex);
+
+		if (destroyed) {
+			int rc;
+
+			rc = activate_auto_tuning(AKT_DOWN, &ns->shmmni_akt);
+			if (rc)
+				/*
+				 * shm_ctlmni has been adjusted == > change
+				 * shm_ctlall value
+				 */
+				ns->shm_ctlall = ns->shm_ctlmax / PAGE_SIZE *
+					(ns->shm_ctlmni / 16);
+
+			activate_auto_tuning(AKT_DOWN, &ns->shmall_akt);
+		}
+
 		goto out;
 	}
 
Index: linux-2.6.20-rc4/ipc/sem.c
===================================================================
--- linux-2.6.20-rc4.orig/ipc/sem.c	2007-01-15 13:08:15.000000000 +0100
+++ linux-2.6.20-rc4/ipc/sem.c	2007-01-15 15:49:41.000000000 +0100
@@ -83,6 +83,8 @@
 #include <linux/seq_file.h>
 #include <linux/mutex.h>
 #include <linux/nsproxy.h>
+#include <linux/akt.h>
+#include <linux/akt_ops.h>
 
 #include <asm/uaccess.h>
 #include "util.h"
@@ -131,6 +133,12 @@ static void __ipc_init __sem_init_ns(str
 	ns->sc_semmni = SEMMNI;
 	ns->used_sems = 0;
 	ipc_init_ids(ids, ns->sc_semmni);
+
+#define SEMTHRESH 80
+	init_tunable_ipcns(ns, semmni_akt, SEMTHRESH, SEMMNI, IPCMNI,
+		&(ns->sc_semmni), &ids->in_use, int);
+	init_tunable_ipcns(ns, semmns_akt, SEMTHRESH, SEMMNS,
+		IPCMNI * SEMMSL, &(ns->sc_semmns), &ns->used_sems, int);
 }
 
 #ifdef CONFIG_IPC_NS
@@ -170,6 +178,13 @@ void sem_exit_ns(struct ipc_namespace *n
 void __init sem_init (void)
 {
 	__sem_init_ns(&init_ipc_ns, &init_sem_ids);
+
+	if (register_tunable(&init_ipc_ns.semmni_akt))
+		printk(KERN_WARNING "Failed registering tunable semmni\n");
+
+	if (register_tunable(&init_ipc_ns.semmns_akt))
+		printk(KERN_WARNING "Failed registering tunable semmns\n");
+
 	ipc_init_proc_interface("sysvipc/sem",
 				"       key      semid perms      nsems   uid   gid  cuid  cgid      otime      ctime\n",
 				IPC_SEM_IDS, sysvipc_sem_proc_show);
@@ -263,11 +278,22 @@ asmlinkage long sys_semget (key_t key, i
 	int id, err = -EINVAL;
 	struct sem_array *sma;
 	struct ipc_namespace *ns;
+	int rc;
 
 	ns = current->nsproxy->ipc_ns;
 
 	if (nsems < 0 || nsems > ns->sc_semmsl)
 		return -EINVAL;
+
+	rc = activate_auto_tuning(AKT_UP, &ns->semmni_akt);
+	if (rc)
+		/*
+		 * sc_semmni has been adjusted == > change sc_semmns value
+		 */
+		ns->sc_semmns = ns->sc_semmni * ns->sc_semmsl;
+
+	activate_auto_tuning(AKT_UP, &ns->semmns_akt);
+
 	mutex_lock(&sem_ids(ns).mutex);
 	
 	if (key == IPC_PRIVATE) {
@@ -899,6 +925,21 @@ static int semctl_down(struct ipc_namesp
 	case IPC_RMID:
 		freeary(ns, sma, semid);
 		err = 0;
+
+		{
+			int rc;
+
+			rc = activate_auto_tuning(AKT_DOWN, &ns->semmni_akt);
+			if (rc)
+				/*
+				 * sc_semmni has been adjusted ==>
+				 * change sc_semmns value
+				 */
+				ns->sc_semmns = ns->sc_semmni * ns->sc_semmsl;
+
+			activate_auto_tuning(AKT_DOWN, &ns->semmns_akt);
+		}
+
 		break;
 	case IPC_SET:
 		ipcp->uid = setbuf.uid;
Index: linux-2.6.20-rc4/include/linux/ipc.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/ipc.h	2007-01-15 13:08:15.000000000 +0100
+++ linux-2.6.20-rc4/include/linux/ipc.h	2007-01-15 15:52:19.000000000 +0100
@@ -52,6 +52,7 @@ struct ipc_perm
 #ifdef __KERNEL__
 
 #include <linux/kref.h>
+#include <linux/akt.h>
 
 #define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
 
@@ -77,15 +78,20 @@ struct ipc_namespace {
 
 	int		sem_ctls[4];
 	int		used_sems;
+	DECLARE_TUNABLE(semmni_akt);
+	DECLARE_TUNABLE(semmns_akt);
 
 	int		msg_ctlmax;
 	int		msg_ctlmnb;
 	int		msg_ctlmni;
+	DECLARE_TUNABLE(msgmni_akt);
 
 	size_t		shm_ctlmax;
 	size_t		shm_ctlall;
 	int		shm_ctlmni;
 	int		shm_tot;
+	DECLARE_TUNABLE(shmmni_akt);
+	DECLARE_TUNABLE(shmall_akt);
 };
 
 extern struct ipc_namespace init_ipc_ns;

--
