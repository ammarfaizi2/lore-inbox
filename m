Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSJHXGG>; Tue, 8 Oct 2002 19:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSJHXGF>; Tue, 8 Oct 2002 19:06:05 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:44297 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261371AbSJHXEE>;
	Tue, 8 Oct 2002 19:04:04 -0400
Date: Tue, 8 Oct 2002 16:05:54 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [PATCH] LSM changes for 2.5.40
Message-ID: <20021008230553.GB11247@kroah.com>
References: <20021008230506.GA11247@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008230506.GA11247@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.704   -> 1.705  
#	 include/linux/ipc.h	1.1     -> 1.2    
#	           ipc/msg.c	1.6     -> 1.7    
#	include/linux/security.h	1.3     -> 1.4    
#	    security/dummy.c	1.6     -> 1.7    
#	security/capability.c	1.5     -> 1.6    
#	           ipc/sem.c	1.11    -> 1.12   
#	          ipc/util.c	1.5     -> 1.6    
#	           ipc/shm.c	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/08	sds@tislabs.com	1.705
# [PATCH] Base set of LSM hooks for SysV IPC
# 
# The patch below adds the base set of LSM hooks for System V IPC to the
# 2.5.41 kernel.  These hooks permit a security module to label
# semaphore sets, message queues, and shared memory segments and to
# perform security checks on these objects that parallel the existing
# IPC access checks.  Additional LSM hooks for labeling and controlling
# individual messages sent on a single message queue and for providing
# fine-grained distinctions among IPC operations will be submitted
# separately after this base set of LSM IPC hooks has been accepted.
# --------------------------------------------
#
diff -Nru a/include/linux/ipc.h b/include/linux/ipc.h
--- a/include/linux/ipc.h	Tue Oct  8 15:51:15 2002
+++ b/include/linux/ipc.h	Tue Oct  8 15:51:15 2002
@@ -63,6 +63,7 @@
 	gid_t		cgid;
 	mode_t		mode; 
 	unsigned long	seq;
+	void		*security;
 };
 
 #endif /* __KERNEL__ */
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Tue Oct  8 15:51:15 2002
+++ b/include/linux/security.h	Tue Oct  8 15:51:15 2002
@@ -572,6 +572,50 @@
  * 	is being reparented to the init task.
  *	@p contains the task_struct for the kernel thread.
  *
+ * Security hooks affecting all System V IPC operations.
+ *
+ * @ipc_permission:
+ *	Check permissions for access to IPC
+ *	@ipcp contains the kernel IPC permission structure
+ *	@flag contains the desired (requested) permission set
+ *	Return 0 if permission is granted.
+ *
+ * Security hooks for System V IPC Message Queues
+ *
+ * @msg_queue_alloc_security:
+ *	Allocate and attach a security structure to the
+ *	msq->q_perm.security field. The security field is initialized to
+ *	NULL when the structure is first created.
+ *	@msq contains the message queue structure to be modified.
+ *	Return 0 if operation was successful and permission is granted.
+ * @msg_queue_free_security:
+ *	Deallocate security structure for this message queue.
+ *	@msq contains the message queue structure to be modified.
+ *
+ * Security hooks for System V Shared Memory Segments
+ *
+ * @shm_alloc_security:
+ *	Allocate and attach a security structure to the shp->shm_perm.security
+ *	field.  The security field is initialized to NULL when the structure is
+ *	first created.
+ *	@shp contains the shared memory structure to be modified.
+ *	Return 0 if operation was successful and permission is granted.
+ * @shm_free_security:
+ *	Deallocate the security struct for this memory segment.
+ *	@shp contains the shared memory structure to be modified.
+ *
+ * Security hooks for System V Semaphores
+ *
+ * @sem_alloc_security:
+ *	Allocate and attach a security structure to the sma->sem_perm.security
+ *	field.  The security field is initialized to NULL when the structure is
+ *	first created.
+ *	@sma contains the semaphore structure
+ *	Return 0 if operation was successful and permission is granted.
+ * @sem_free_security:
+ *	deallocate security struct for this semaphore
+ *	@sma contains the semaphore structure.
+ *
  * @ptrace:
  *	Check permission before allowing the @parent process to trace the
  *	@child process.
@@ -785,6 +829,17 @@
 			   unsigned long arg5);
 	void (*task_kmod_set_label) (void);
 	void (*task_reparent_to_init) (struct task_struct * p);
+
+	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
+
+	int (*msg_queue_alloc_security) (struct msg_queue * msq);
+	void (*msg_queue_free_security) (struct msg_queue * msq);
+
+	int (*shm_alloc_security) (struct shmid_kernel * shp);
+	void (*shm_free_security) (struct shmid_kernel * shp);
+
+	int (*sem_alloc_security) (struct sem_array * sma);
+	void (*sem_free_security) (struct sem_array * sma);
 
 	/* allow module stacking */
 	int (*register_security) (const char *name,
diff -Nru a/ipc/msg.c b/ipc/msg.c
--- a/ipc/msg.c	Tue Oct  8 15:51:15 2002
+++ b/ipc/msg.c	Tue Oct  8 15:51:15 2002
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/list.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 #include "util.h"
 
@@ -89,6 +90,7 @@
 static int newque (key_t key, int msgflg)
 {
 	int id;
+	int retval;
 	struct msg_queue *msq;
 
 	msq  = (struct msg_queue *) kmalloc (sizeof (*msq), GFP_KERNEL);
@@ -98,8 +100,16 @@
 	msq->q_perm.mode = (msgflg & S_IRWXUGO);
 	msq->q_perm.key = key;
 
+	msq->q_perm.security = NULL;
+	retval = security_ops->msg_queue_alloc_security(msq);
+	if (retval) {
+		kfree(msq);
+		return retval;
+	}
+
 	id = ipc_addid(&msg_ids, &msq->q_perm, msg_ctlmni);
 	if(id == -1) {
+		security_ops->msg_queue_free_security(msq);
 		kfree(msq);
 		return -ENOSPC;
 	}
@@ -271,6 +281,7 @@
 		free_msg(msg);
 	}
 	atomic_sub(msq->q_cbytes, &msg_bytes);
+	security_ops->msg_queue_free_security(msq);
 	kfree(msq);
 }
 
diff -Nru a/ipc/sem.c b/ipc/sem.c
--- a/ipc/sem.c	Tue Oct  8 15:51:15 2002
+++ b/ipc/sem.c	Tue Oct  8 15:51:15 2002
@@ -63,6 +63,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 #include "util.h"
 
@@ -115,6 +116,7 @@
 static int newary (key_t key, int nsems, int semflg)
 {
 	int id;
+	int retval;
 	struct sem_array *sma;
 	int size;
 
@@ -133,8 +135,16 @@
 	sma->sem_perm.mode = (semflg & S_IRWXUGO);
 	sma->sem_perm.key = key;
 
+	sma->sem_perm.security = NULL;
+	retval = security_ops->sem_alloc_security(sma);
+	if (retval) {
+		ipc_free(sma, size);
+		return retval;
+	}
+
 	id = ipc_addid(&sem_ids, &sma->sem_perm, sc_semmni);
 	if(id == -1) {
+		security_ops->sem_free_security(sma);
 		ipc_free(sma, size);
 		return -ENOSPC;
 	}
@@ -417,6 +427,7 @@
 
 	used_sems -= sma->sem_nsems;
 	size = sizeof (*sma) + sma->sem_nsems * sizeof (struct sem);
+	security_ops->sem_free_security(sma);
 	ipc_free(sma, size);
 }
 
diff -Nru a/ipc/shm.c b/ipc/shm.c
--- a/ipc/shm.c	Tue Oct  8 15:51:15 2002
+++ b/ipc/shm.c	Tue Oct  8 15:51:15 2002
@@ -24,6 +24,7 @@
 #include <linux/mman.h>
 #include <linux/proc_fs.h>
 #include <linux/shmem_fs.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 #include "util.h"
@@ -115,6 +116,7 @@
 	shm_unlock(shp->id);
 	shmem_lock(shp->shm_file, 0);
 	fput (shp->shm_file);
+	security_ops->shm_free_security(shp);
 	kfree (shp);
 }
 
@@ -185,6 +187,13 @@
 	shp->shm_perm.key = key;
 	shp->shm_flags = (shmflg & S_IRWXUGO);
 
+	shp->shm_perm.security = NULL;
+	error = security_ops->shm_alloc_security(shp);
+	if (error) {
+		kfree(shp);
+		return error;
+	}
+
 	sprintf (name, "SYSV%08x", key);
 	file = shmem_file_setup(name, size, VM_ACCOUNT);
 	error = PTR_ERR(file);
@@ -213,6 +222,7 @@
 no_id:
 	fput(file);
 no_file:
+	security_ops->shm_free_security(shp);
 	kfree(shp);
 	return error;
 }
diff -Nru a/ipc/util.c b/ipc/util.c
--- a/ipc/util.c	Tue Oct  8 15:51:15 2002
+++ b/ipc/util.c	Tue Oct  8 15:51:15 2002
@@ -19,6 +19,7 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/highuid.h>
+#include <linux/security.h>
 
 #if defined(CONFIG_SYSVIPC)
 
@@ -263,7 +264,7 @@
 	    !capable(CAP_IPC_OWNER))
 		return -1;
 
-	return 0;
+	return security_ops->ipc_permission(ipcp, flag);
 }
 
 /*
diff -Nru a/security/capability.c b/security/capability.c
--- a/security/capability.c	Tue Oct  8 15:51:15 2002
+++ b/security/capability.c	Tue Oct  8 15:51:15 2002
@@ -679,6 +679,41 @@
 	return;
 }
 
+static int cap_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
+{
+	return 0;
+}
+
+static int cap_msg_queue_alloc_security (struct msg_queue *msq)
+{
+	return 0;
+}
+
+static void cap_msg_queue_free_security (struct msg_queue *msq)
+{
+	return;
+}
+
+static int cap_shm_alloc_security (struct shmid_kernel *shp)
+{
+	return 0;
+}
+
+static void cap_shm_free_security (struct shmid_kernel *shp)
+{
+	return;
+}
+
+static int cap_sem_alloc_security (struct sem_array *sma)
+{
+	return 0;
+}
+
+static void cap_sem_free_security (struct sem_array *sma)
+{
+	return;
+}
+
 static int cap_register (const char *name, struct security_operations *ops)
 {
 	return -EINVAL;
@@ -781,6 +816,17 @@
 	.task_prctl =			cap_task_prctl,
 	.task_kmod_set_label =		cap_task_kmod_set_label,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
+
+	.ipc_permission =		cap_ipc_permission,
+
+	.msg_queue_alloc_security =	cap_msg_queue_alloc_security,
+	.msg_queue_free_security =	cap_msg_queue_free_security,
+	
+	.shm_alloc_security =		cap_shm_alloc_security,
+	.shm_free_security =		cap_shm_free_security,
+	
+	.sem_alloc_security =		cap_sem_alloc_security,
+	.sem_free_security =		cap_sem_free_security,
 
 	.register_security =		cap_register,
 	.unregister_security =		cap_unregister,
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Tue Oct  8 15:51:15 2002
+++ b/security/dummy.c	Tue Oct  8 15:51:15 2002
@@ -493,6 +493,42 @@
 	return;
 }
 
+static int dummy_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
+{
+	return 0;
+}
+
+
+static int dummy_msg_queue_alloc_security (struct msg_queue *msq)
+{
+	return 0;
+}
+
+static void dummy_msg_queue_free_security (struct msg_queue *msq)
+{
+	return;
+}
+
+static int dummy_shm_alloc_security (struct shmid_kernel *shp)
+{
+	return 0;
+}
+
+static void dummy_shm_free_security (struct shmid_kernel *shp)
+{
+	return;
+}
+
+static int dummy_sem_alloc_security (struct sem_array *sma)
+{
+	return 0;
+}
+
+static void dummy_sem_free_security (struct sem_array *sma)
+{
+	return;
+}
+
 static int dummy_register (const char *name, struct security_operations *ops)
 {
 	return -EINVAL;
@@ -595,6 +631,17 @@
 	.task_prctl =			dummy_task_prctl,
 	.task_kmod_set_label =		dummy_task_kmod_set_label,
 	.task_reparent_to_init =	dummy_task_reparent_to_init,
+
+	.ipc_permission =		dummy_ipc_permission,
+	
+	.msg_queue_alloc_security =	dummy_msg_queue_alloc_security,
+	.msg_queue_free_security =	dummy_msg_queue_free_security,
+	
+	.shm_alloc_security =		dummy_shm_alloc_security,
+	.shm_free_security =		dummy_shm_free_security,
+	
+	.sem_alloc_security =		dummy_sem_alloc_security,
+	.sem_free_security =		dummy_sem_free_security,
 
 	.register_security =		dummy_register,
 	.unregister_security =		dummy_unregister,
