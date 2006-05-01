Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWEAKb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWEAKb2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWEAKau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:30:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:7816 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751335AbWEAKaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:30:24 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] Rework of IPC auditing
Message-Id: <E1FaVfb-00053n-ME@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:30:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Grubb <sgrubb@redhat.com>
Date: Sun Apr 2 17:07:33 2006 -0400

1) The audit_ipc_perms() function has been split into two different
functions:
        - audit_ipc_obj()
        - audit_ipc_set_perm()

There's a key shift here...  The audit_ipc_obj() collects the uid, gid,
mode, and SElinux context label of the current ipc object.  This
audit_ipc_obj() hook is now found in several places.  Most notably, it
is hooked in ipcperms(), which is called in various places around the
ipc code permforming a MAC check.  Additionally there are several places
where *checkid() is used to validate that an operation is being
performed on a valid object while not necessarily having a nearby
ipcperms() call.  In these locations, audit_ipc_obj() is called to
ensure that the information is captured by the audit system.

The audit_set_new_perm() function is called any time the permissions on
the ipc object changes.  In this case, the NEW permissions are recorded
(and note that an audit_ipc_obj() call exists just a few lines before
each instance).

2) Support for an AUDIT_IPC_SET_PERM audit message type.  This allows
for separate auxiliary audit records for normal operations on an IPC
object and permissions changes.  Note that the same struct
audit_aux_data_ipcctl is used and populated, however there are separate
audit_log_format statements based on the type of the message.  Finally,
the AUDIT_IPC block of code in audit_free_aux() was extended to handle
aux messages of this new type.  No more mem leaks I hope ;-)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/linux/audit.h |    7 +++++-
 ipc/msg.c             |   11 +++++++++-
 ipc/sem.c             |   11 +++++++++-
 ipc/shm.c             |   19 +++++++++++++++--
 ipc/util.c            |    7 +++++-
 kernel/auditsc.c      |   54 ++++++++++++++++++++++++++++++++++++++++++++++---
 6 files changed, 98 insertions(+), 11 deletions(-)

073115d6b29c7910feaa08241c6484637f5ca958
diff --git a/include/linux/audit.h b/include/linux/audit.h
index d5c4082..b74c148 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -83,6 +83,7 @@ #define AUDIT_SOCKETCALL	1304	/* sys_soc
 #define AUDIT_CONFIG_CHANGE	1305	/* Audit system configuration change */
 #define AUDIT_SOCKADDR		1306	/* sockaddr copied as syscall arg */
 #define AUDIT_CWD		1307	/* Current working directory */
+#define AUDIT_IPC_SET_PERM	1311	/* IPC new permissions record type */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
@@ -319,7 +320,8 @@ extern void auditsc_get_stamp(struct aud
 			      struct timespec *t, unsigned int *serial);
 extern int  audit_set_loginuid(struct task_struct *task, uid_t loginuid);
 extern uid_t audit_get_loginuid(struct audit_context *ctx);
-extern int audit_ipc_perms(unsigned long qbytes, uid_t uid, gid_t gid, mode_t mode, struct kern_ipc_perm *ipcp);
+extern int audit_ipc_obj(struct kern_ipc_perm *ipcp);
+extern int audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, mode_t mode, struct kern_ipc_perm *ipcp);
 extern int audit_socketcall(int nargs, unsigned long *args);
 extern int audit_sockaddr(int len, void *addr);
 extern int audit_avc_path(struct dentry *dentry, struct vfsmount *mnt);
@@ -338,7 +340,8 @@ #define audit_inode(n,i,f) do { ; } whil
 #define audit_inode_child(d,i,p) do { ; } while (0)
 #define auditsc_get_stamp(c,t,s) do { BUG(); } while (0)
 #define audit_get_loginuid(c) ({ -1; })
-#define audit_ipc_perms(q,u,g,m,i) ({ 0; })
+#define audit_ipc_obj(i) ({ 0; })
+#define audit_ipc_set_perm(q,u,g,m,i) ({ 0; })
 #define audit_socketcall(n,a) ({ 0; })
 #define audit_sockaddr(len, addr) ({ 0; })
 #define audit_avc_path(dentry, mnt) ({ 0; })
diff --git a/ipc/msg.c b/ipc/msg.c
index 48a7f17..7d1340c 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -13,6 +13,9 @@
  * mostly rewritten, threaded and wake-one semantics added
  * MSGMAX limit removed, sysctl's added
  * (c) 1999 Manfred Spraul <manfred@colorfullife.com>
+ *
+ * support for audit of ipc object properties and permission changes
+ * Dustin Kirkland <dustin.kirkland@us.ibm.com>
  */
 
 #include <linux/capability.h>
@@ -447,6 +450,11 @@ asmlinkage long sys_msgctl (int msqid, i
 	if (msg_checkid(msq,msqid))
 		goto out_unlock_up;
 	ipcp = &msq->q_perm;
+
+	err = audit_ipc_obj(ipcp);
+	if (err)
+		goto out_unlock_up;
+
 	err = -EPERM;
 	if (current->euid != ipcp->cuid && 
 	    current->euid != ipcp->uid && !capable(CAP_SYS_ADMIN))
@@ -460,7 +468,8 @@ asmlinkage long sys_msgctl (int msqid, i
 	switch (cmd) {
 	case IPC_SET:
 	{
-		if ((err = audit_ipc_perms(setbuf.qbytes, setbuf.uid, setbuf.gid, setbuf.mode, ipcp)))
+		err = audit_ipc_set_perm(setbuf.qbytes, setbuf.uid, setbuf.gid, setbuf.mode, ipcp);
+		if (err)
 			goto out_unlock_up;
 
 		err = -EPERM;
diff --git a/ipc/sem.c b/ipc/sem.c
index 642659c..7919f8e 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -61,6 +61,9 @@
  * (c) 2001 Red Hat Inc <alan@redhat.com>
  * Lockless wakeup
  * (c) 2003 Manfred Spraul <manfred@colorfullife.com>
+ *
+ * support for audit of ipc object properties and permission changes
+ * Dustin Kirkland <dustin.kirkland@us.ibm.com>
  */
 
 #include <linux/config.h>
@@ -820,6 +823,11 @@ static int semctl_down(int semid, int se
 		goto out_unlock;
 	}	
 	ipcp = &sma->sem_perm;
+
+	err = audit_ipc_obj(ipcp);
+	if (err)
+		goto out_unlock;
+
 	if (current->euid != ipcp->cuid && 
 	    current->euid != ipcp->uid && !capable(CAP_SYS_ADMIN)) {
 	    	err=-EPERM;
@@ -836,7 +844,8 @@ static int semctl_down(int semid, int se
 		err = 0;
 		break;
 	case IPC_SET:
-		if ((err = audit_ipc_perms(0, setbuf.uid, setbuf.gid, setbuf.mode, ipcp)))
+		err = audit_ipc_set_perm(0, setbuf.uid, setbuf.gid, setbuf.mode, ipcp);
+		if (err)
 			goto out_unlock;
 		ipcp->uid = setbuf.uid;
 		ipcp->gid = setbuf.gid;
diff --git a/ipc/shm.c b/ipc/shm.c
index 1c2faf6..8098968 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -13,6 +13,8 @@
  * Shared /dev/zero support, Kanoj Sarcar <kanoj@sgi.com>
  * Move the mm functionality over to mm/shmem.c, Christoph Rohland <cr@sap.com>
  *
+ * support for audit of ipc object properties and permission changes
+ * Dustin Kirkland <dustin.kirkland@us.ibm.com>
  */
 
 #include <linux/config.h>
@@ -542,6 +544,10 @@ asmlinkage long sys_shmctl (int shmid, i
 		if(err)
 			goto out_unlock;
 
+		err = audit_ipc_obj(&(shp->shm_perm));
+		if (err)
+			goto out_unlock;
+
 		if (!capable(CAP_IPC_LOCK)) {
 			err = -EPERM;
 			if (current->euid != shp->shm_perm.uid &&
@@ -594,6 +600,10 @@ asmlinkage long sys_shmctl (int shmid, i
 		if(err)
 			goto out_unlock_up;
 
+		err = audit_ipc_obj(&(shp->shm_perm));
+		if (err)
+			goto out_unlock_up;
+
 		if (current->euid != shp->shm_perm.uid &&
 		    current->euid != shp->shm_perm.cuid && 
 		    !capable(CAP_SYS_ADMIN)) {
@@ -627,12 +637,15 @@ asmlinkage long sys_shmctl (int shmid, i
 		err=-EINVAL;
 		if(shp==NULL)
 			goto out_up;
-		if ((err = audit_ipc_perms(0, setbuf.uid, setbuf.gid,
-					setbuf.mode, &(shp->shm_perm))))
-			goto out_unlock_up;
 		err = shm_checkid(shp,shmid);
 		if(err)
 			goto out_unlock_up;
+		err = audit_ipc_obj(&(shp->shm_perm));
+		if (err)
+			goto out_unlock_up;
+		err = audit_ipc_set_perm(0, setbuf.uid, setbuf.gid, setbuf.mode, &(shp->shm_perm));
+		if (err)
+			goto out_unlock_up;
 		err=-EPERM;
 		if (current->euid != shp->shm_perm.uid &&
 		    current->euid != shp->shm_perm.cuid && 
diff --git a/ipc/util.c b/ipc/util.c
index b3dcfad..8193299 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -10,6 +10,8 @@
  *	      Manfred Spraul <manfred@colorfullife.com>
  * Oct 2002 - One lock per IPC id. RCU ipc_free for lock-free grow_ary().
  *            Mingming Cao <cmm@us.ibm.com>
+ * Mar 2006 - support for audit of ipc object properties
+ *            Dustin Kirkland <dustin.kirkland@us.ibm.com>
  */
 
 #include <linux/config.h>
@@ -27,6 +29,7 @@ #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
+#include <linux/audit.h>
 
 #include <asm/unistd.h>
 
@@ -464,8 +467,10 @@ void ipc_rcu_putref(void *ptr)
  
 int ipcperms (struct kern_ipc_perm *ipcp, short flag)
 {	/* flag will most probably be 0 or S_...UGO from <linux/stat.h> */
-	int requested_mode, granted_mode;
+	int requested_mode, granted_mode, err;
 
+	if (unlikely((err = audit_ipc_obj(ipcp))))
+		return err;
 	requested_mode = (flag >> 6) | (flag >> 3) | flag;
 	granted_mode = ipcp->mode;
 	if (current->euid == ipcp->cuid || current->euid == ipcp->uid)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d94e040..a300736 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -646,6 +646,25 @@ static void audit_log_exit(struct audit_
 			}
 			break; }
 
+		case AUDIT_IPC_SET_PERM: {
+			struct audit_aux_data_ipcctl *axi = (void *)aux;
+			audit_log_format(ab,
+				" new qbytes=%lx new iuid=%u new igid=%u new mode=%x",
+				axi->qbytes, axi->uid, axi->gid, axi->mode);
+			if (axi->osid != 0) {
+				char *ctx = NULL;
+				u32 len;
+				if (selinux_ctxid_to_string(
+						axi->osid, &ctx, &len)) {
+					audit_log_format(ab, " osid=%u",
+							axi->osid);
+					call_panic = 1;
+				} else
+					audit_log_format(ab, " obj=%s", ctx);
+				kfree(ctx);
+			}
+			break; }
+
 		case AUDIT_SOCKETCALL: {
 			int i;
 			struct audit_aux_data_socketcall *axs = (void *)aux;
@@ -1148,7 +1167,36 @@ uid_t audit_get_loginuid(struct audit_co
 }
 
 /**
- * audit_ipc_perms - record audit data for ipc
+ * audit_ipc_obj - record audit data for ipc object
+ * @ipcp: ipc permissions
+ *
+ * Returns 0 for success or NULL context or < 0 on error.
+ */
+int audit_ipc_obj(struct kern_ipc_perm *ipcp)
+{
+	struct audit_aux_data_ipcctl *ax;
+	struct audit_context *context = current->audit_context;
+
+	if (likely(!context))
+		return 0;
+
+	ax = kmalloc(sizeof(*ax), GFP_ATOMIC);
+	if (!ax)
+		return -ENOMEM;
+
+	ax->uid = ipcp->uid;
+	ax->gid = ipcp->gid;
+	ax->mode = ipcp->mode;
+	selinux_get_ipc_sid(ipcp, &ax->osid);
+
+	ax->d.type = AUDIT_IPC;
+	ax->d.next = context->aux;
+	context->aux = (void *)ax;
+	return 0;
+}
+
+/**
+ * audit_ipc_set_perm - record audit data for new ipc permissions
  * @qbytes: msgq bytes
  * @uid: msgq user id
  * @gid: msgq group id
@@ -1156,7 +1204,7 @@ uid_t audit_get_loginuid(struct audit_co
  *
  * Returns 0 for success or NULL context or < 0 on error.
  */
-int audit_ipc_perms(unsigned long qbytes, uid_t uid, gid_t gid, mode_t mode, struct kern_ipc_perm *ipcp)
+int audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, mode_t mode, struct kern_ipc_perm *ipcp)
 {
 	struct audit_aux_data_ipcctl *ax;
 	struct audit_context *context = current->audit_context;
@@ -1174,7 +1222,7 @@ int audit_ipc_perms(unsigned long qbytes
 	ax->mode = mode;
 	selinux_get_ipc_sid(ipcp, &ax->osid);
 
-	ax->d.type = AUDIT_IPC;
+	ax->d.type = AUDIT_IPC_SET_PERM;
 	ax->d.next = context->aux;
 	context->aux = (void *)ax;
 	return 0;
-- 
1.3.0.g0080f

