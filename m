Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUIIUJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUIIUJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUIIUGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:06:51 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:37082 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264954AbUIIUEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:04:30 -0400
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Roger Luethi <rl@hellgate.ch>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <20040909175342.GA27518@k3.hellgate.ch>
References: <20040908184130.GA12691@k3.hellgate.ch>
	 <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil>
	 <20040909172200.GX3106@holomorphy.com>
	 <20040909175342.GA27518@k3.hellgate.ch>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 16:01:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 13:53, Roger Luethi wrote:
> On Thu, 09 Sep 2004 10:22:00 -0700, William Lee Irwin III wrote:
> > On Thu, Sep 09, 2004 at 07:53:31AM -0400, Stephen Smalley wrote:
> > > They aren't world readable when using a security module like SELinux;
> > > they are then typically only accessible by processes in the same
> > > security domain, aside from processes in privileged domains. 
> > > security_task_to_inode() hook sets the security attributes on the
> > > /proc/pid inodes based on their security context, and then
> > > security_inode_permission() hook controls access to them.  So you need
> > > at least comparable controls.
> > 
> > Can you make a more specific suggestion regarding the controls to use?
> > It's a bit awkward for those highly unfamiliar with the subsystem to
> 
> For the same reason, I'm not comfortable with implementing SELinux type
> access controls myself. How about:
> 
> config NPROC
> 	depends on !SECURITY_SELINUX
> 
> Adding access control later won't be a problem for anyone who groks
> SELinux.

Well, it isn't that easy, or at least I don't think it is.  The problem
is that there is no way presently to convey the sender's security
credentials (beyond the existing uid, cap information), since the LSM
patches for adding security fields and hooks for managing skb security
fields were rejected.  The best we can do at present is pass along the
sender pid, uid, and cap, and the security module can look up the pid if
it chooses to get the security field (but is naturally subject to races
in that situation).

Most obvious place to hook would be nproc_ps_get_task; we could then
perform a check based on the sender's credentials and the target task's
credentials, and simply return NULL if permission is not granted for
that pair, thus skipping that task as if it didn't exist.  That requires
propagating the sender's credentials down to that function.

Untested patch below.

Index: linux-2.6/include/linux/security.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/include/linux/security.h,v
retrieving revision 1.37
diff -u -p -r1.37 security.h
--- linux-2.6/include/linux/security.h	16 Jun 2004 14:49:42 -0000	1.37
+++ linux-2.6/include/linux/security.h	9 Sep 2004 19:38:23 -0000
@@ -632,6 +632,13 @@ struct swap_info_struct;
  * 	security attributes, e.g. for /proc/pid inodes.
  *	@p contains the task_struct for the task.
  *	@inode contains the inode structure for the inode.
+ * @task_getstate:
+ * 	Check permission before getting the state of a task.
+ *      @pid contains the pid of the requesting process.
+ *	@p contains the task_struct for the target task.
+ *      @uid contains the uid of the requesting process.
+ *      @caps contains the capability set of the requesting process.
+ *      Return 0 if permission is granted.
  *
  * Security hooks for Netlink messaging.
  *
@@ -1153,6 +1160,7 @@ struct security_operations {
 			   unsigned long arg5);
 	void (*task_reparent_to_init) (struct task_struct * p);
 	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
+	int (*task_getstate)(pid_t pid, struct task_struct *p, uid_t uid, kernel_cap_t caps);
 
 	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
 
@@ -1756,6 +1764,11 @@ static inline void security_task_to_inod
 	security_ops->task_to_inode(p, inode);
 }
 
+static inline int security_task_getstate(pid_t pid, struct task_struct *p, uid_t uid, kernel_cap_t caps)
+{
+	return security_ops->task_getstate(pid, p, uid, caps);
+}
+
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
 {
@@ -2389,6 +2402,11 @@ static inline void security_task_reparen
 static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
+static inline int security_task_getstate(pid_t pid, struct task_struct *p, uid_t uid, kernel_cap_t caps)
+{
+	return 0;
+}
+
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
 {
Index: linux-2.6/security/dummy.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/dummy.c,v
retrieving revision 1.34
diff -u -p -r1.34 dummy.c
--- linux-2.6/security/dummy.c	16 Jun 2004 14:49:42 -0000	1.34
+++ linux-2.6/security/dummy.c	9 Sep 2004 19:39:01 -0000
@@ -619,6 +619,12 @@ static void dummy_task_reparent_to_init 
 static void dummy_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
+
+static int dummy_task_getstate(pid_t pid, struct task_struct *p, uid_t uid, kernel_cap_t caps)
+{
+	return 0;
+}
+
 static int dummy_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
 {
 	return 0;
@@ -979,6 +985,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_prctl);
 	set_to_dummy_if_null(ops, task_reparent_to_init);
  	set_to_dummy_if_null(ops, task_to_inode);
+ 	set_to_dummy_if_null(ops, task_getstate);
 	set_to_dummy_if_null(ops, ipc_permission);
 	set_to_dummy_if_null(ops, msg_msg_alloc_security);
 	set_to_dummy_if_null(ops, msg_msg_free_security);

--- linux-2.6/kernel/nproc.c.orig	2004-09-09 15:51:25.727833776 -0400
+++ linux-2.6/kernel/nproc.c	2004-09-09 15:30:19.171379624 -0400
@@ -296,7 +296,7 @@ out:
 /*
  * Find task for given pid, grab task lock (caller must unlock).
  */
-static task_t *nproc_ps_get_task(int pid)
+static task_t *nproc_ps_get_task(struct nlmsghdr *nlh, int pid, uid_t uid, kernel_cap_t caps)
 {
 	task_t *tsk;
 
@@ -305,13 +305,17 @@ static task_t *nproc_ps_get_task(int pid
 	if (tsk)
 		get_task_struct(tsk);
 	read_unlock(&tasklist_lock);
+	if (tsk && security_task_getstate(nlh->nlmsg_pid, tsk, uid, caps)) {
+		put_task_struct(tsk);
+		return NULL;
+	}
 	return tsk;
 }
 
 /*
  * Iterate over a list of PIDs.
  */
-static int nproc_ps_select_pid(struct nlmsghdr *nlh, u32 *fdata, u32 len, u32 left, u32 *sdata)
+static int nproc_ps_select_pid(struct nlmsghdr *nlh, u32 *fdata, u32 len, u32 left, u32 *sdata, uid_t uid, kernel_cap_t caps)
 {
 	int i;
 	int err = 0;
@@ -335,7 +339,7 @@ static int nproc_ps_select_pid(struct nl
 
 	for (i = 0; i < tcnt; i++) {
 		task_t *tsk;
-		tsk = nproc_ps_get_task(pids[i]);
+		tsk = nproc_ps_get_task(nlh, pids[i], uid, caps);
 		if (!tsk)
 			continue;
 		err = nproc_pid_msg(nlh, fdata, len, tsk);
@@ -357,7 +361,7 @@ err_inval:
 /*
  * Iterate over all PIDs.
  */
-static int nproc_ps_select_all(struct nlmsghdr *nlh, u32 *fdata, u32 len)
+static int nproc_ps_select_all(struct nlmsghdr *nlh, u32 *fdata, u32 len, uid_t uid, kernel_cap_t caps)
 {
 	void *map;
 	int offset, i;
@@ -378,7 +382,7 @@ static int nproc_ps_select_all(struct nl
 			if (offset >= BITS_PER_PAGE)
 				break;
 			pid = offset + i * BITS_PER_PAGE;
-			tsk = nproc_ps_get_task(pid);
+			tsk = nproc_ps_get_task(nlh, pid, uid, caps);
 			if (!tsk)
 				continue;
 			err = nproc_pid_msg(nlh, fdata, len, tsk);
@@ -467,7 +471,7 @@ err_inval:
  * Call the chosen process selector. Adding additional selectors
  * (e.g. select by uid) is easy, but is there a need?
  */
-static int nproc_get_ps(struct nlmsghdr *nlh, uid_t uid)
+static int nproc_get_ps(struct nlmsghdr *nlh, uid_t uid, kernel_cap_t caps)
 {
 	int err;
 	u32 len;
@@ -490,11 +494,11 @@ static int nproc_get_ps(struct nlmsghdr 
 		case NPROC_SELECT_ALL:
 			if (left)
 				pwarn("%d bytes left.\n", left);
-			err = nproc_ps_select_all(nlh, data, len);
+			err = nproc_ps_select_all(nlh, data, len, uid, caps);
 			break;
 		case NPROC_SELECT_PID:
 			err = nproc_ps_select_pid(nlh, data, len,
-					left, sdata + 1);
+					left, sdata + 1, uid, caps);
 			break;
 		default:
 			pwarn("Unknown selection method %#x.\n", *sdata);
@@ -787,7 +791,7 @@ static __inline__ int nproc_process_msg(
 			err = nproc_get_global(nlh);
 			break;
 		case NPROC_GET_PS:
-			err = nproc_get_ps(nlh, uid);
+			err = nproc_get_ps(nlh, uid, caps);
 			break;
 		default:
 			pwarn("Unknown msg type %#x.\n", nlh->nlmsg_type);


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

