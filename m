Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbWFUT0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbWFUT0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWFUT0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:26:18 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:41624 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932683AbWFUT0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:26:17 -0400
Date: Wed, 21 Jun 2006 15:26:14 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Eric Paris <eparis@redhat.com>, David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 3/3] SELinux: Add sockcreate node to procattr API
In-Reply-To: <Pine.LNX.4.64.0606211517170.11782@d.namei>
Message-ID: <Pine.LNX.4.64.0606211523110.11782@d.namei>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Paris <eparis@redhat.com>

Below is a patch to add a new /proc/self/attr/sockcreate node (similar to 
the fscreate and keycreate nodes). A process may write a context into this 
interface and all subsequent sockets created will be labeled with that 
context.  This is the same idea as the fscreate interface where a process 
can specify the label of a file about to be created.  At this time one 
envisioned user of this will be xinetd. It will be able to better label 
sockets for the actual services.  At this time all sockets take the label 
of the creating process, so all xinitd sockets would just be labeled the 
same.

I tested this by creating a tcp sender and listener.  The sender was able 
to write to this new proc file and then create sockets with the specified 
label.  I am able to be sure the new label was used since the avc denial 
messages kicked out by the kernel included both the new security 
permission setsockcreate and all the socket denials were for the new 
label, not the label of the running process.

This patch is targeted for inclusion in 2.6.18.

Please apply.

Signed-off-by: Eric Paris <eparis@redhat.com>
Signed-off-by: James Morris <jmorris@namei.org>


---

 fs/proc/base.c                               |    6 ++++++
 security/selinux/hooks.c                     |   22 +++++++++++++++++-----
 security/selinux/include/av_perm_to_string.h |    1 +
 security/selinux/include/av_permissions.h    |    1 +
 security/selinux/include/objsec.h            |    1 +
 5 files changed, 26 insertions(+), 5 deletions(-)


diff -purN -X dontdiff linux-2.6.17-mm1.p/fs/proc/base.c linux-2.6.17-mm1.w/fs/proc/base.c
--- linux-2.6.17-mm1.p/fs/proc/base.c	2006-06-21 11:54:10.000000000 -0400
+++ linux-2.6.17-mm1.w/fs/proc/base.c	2006-06-21 12:51:28.000000000 -0400
@@ -133,6 +133,7 @@ enum pid_directory_inos {
 	PROC_TGID_ATTR_EXEC,
 	PROC_TGID_ATTR_FSCREATE,
 	PROC_TGID_ATTR_KEYCREATE,
+	PROC_TGID_ATTR_SOCKCREATE,
 #endif
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TGID_LOGINUID,
@@ -175,6 +176,7 @@ enum pid_directory_inos {
 	PROC_TID_ATTR_EXEC,
 	PROC_TID_ATTR_FSCREATE,
 	PROC_TID_ATTR_KEYCREATE,
+	PROC_TID_ATTR_SOCKCREATE,
 #endif
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TID_LOGINUID,
@@ -292,6 +294,7 @@ static struct pid_entry tgid_attr_stuff[
 	E(PROC_TGID_ATTR_EXEC,     "exec",     S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TGID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_SOCKCREATE, "sockcreate", S_IFREG|S_IRUGO|S_IWUGO),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_attr_stuff[] = {
@@ -300,6 +303,7 @@ static struct pid_entry tid_attr_stuff[]
 	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_SOCKCREATE, "sockcreate", S_IFREG|S_IRUGO|S_IWUGO),
 	{0,0,NULL,0}
 };
 #endif
@@ -1765,6 +1769,8 @@ static struct dentry *proc_pident_lookup
 		case PROC_TGID_ATTR_FSCREATE:
 		case PROC_TID_ATTR_KEYCREATE:
 		case PROC_TGID_ATTR_KEYCREATE:
+		case PROC_TID_ATTR_SOCKCREATE:
+		case PROC_TGID_ATTR_SOCKCREATE:
 			inode->i_fop = &proc_pid_attr_operations;
 			break;
 #endif
diff -purN -X dontdiff linux-2.6.17-mm1.p/security/selinux/hooks.c linux-2.6.17-mm1.w/security/selinux/hooks.c
--- linux-2.6.17-mm1.p/security/selinux/hooks.c	2006-06-21 12:42:51.000000000 -0400
+++ linux-2.6.17-mm1.w/security/selinux/hooks.c	2006-06-21 12:54:26.000000000 -0400
@@ -1532,8 +1532,9 @@ static int selinux_bprm_set_security(str
 	/* Default to the current task SID. */
 	bsec->sid = tsec->sid;
 
-	/* Reset create SID on execve. */
+	/* Reset create and sockcreate SID on execve. */
 	tsec->create_sid = 0;
+	tsec->sockcreate_sid = 0;
 
 	if (tsec->exec_sid) {
 		newsid = tsec->exec_sid;
@@ -2585,9 +2586,10 @@ static int selinux_task_alloc_security(s
 	tsec2->osid = tsec1->osid;
 	tsec2->sid = tsec1->sid;
 
-	/* Retain the exec and create SIDs across fork */
+	/* Retain the exec, create, and sock SIDs across fork */
 	tsec2->exec_sid = tsec1->exec_sid;
 	tsec2->create_sid = tsec1->create_sid;
+	tsec2->sockcreate_sid = tsec1->sockcreate_sid;
 
 	/* Retain ptracer SID across fork, if any.
 	   This will be reset by the ptrace hook upon any
@@ -2937,12 +2939,14 @@ static int selinux_socket_create(int fam
 {
 	int err = 0;
 	struct task_security_struct *tsec;
+	u32 newsid;
 
 	if (kern)
 		goto out;
 
 	tsec = current->security;
-	err = avc_has_perm(tsec->sid, tsec->sid,
+	newsid = tsec->sockcreate_sid ? : tsec->sid;
+	err = avc_has_perm(tsec->sid, newsid,
 			   socket_type_to_security_class(family, type,
 			   protocol), SOCKET__CREATE, NULL);
 
@@ -2955,12 +2959,14 @@ static void selinux_socket_post_create(s
 {
 	struct inode_security_struct *isec;
 	struct task_security_struct *tsec;
+	u32 newsid;
 
 	isec = SOCK_INODE(sock)->i_security;
 
 	tsec = current->security;
+	newsid = tsec->sockcreate_sid ? : tsec->sid;
 	isec->sclass = socket_type_to_security_class(family, type, protocol);
-	isec->sid = kern ? SECINITSID_KERNEL : tsec->sid;
+	isec->sid = kern ? SECINITSID_KERNEL : newsid;
 	isec->initialized = 1;
 
 	return;
@@ -4163,6 +4169,8 @@ static int selinux_getprocattr(struct ta
 		sid = tsec->create_sid;
 	else if (!strcmp(name, "keycreate"))
 		sid = tsec->keycreate_sid;
+	else if (!strcmp(name, "sockcreate"))
+		sid = tsec->sockcreate_sid;
 	else
 		return -EINVAL;
 
@@ -4197,6 +4205,8 @@ static int selinux_setprocattr(struct ta
 		error = task_has_perm(current, p, PROCESS__SETFSCREATE);
 	else if (!strcmp(name, "keycreate"))
 		error = task_has_perm(current, p, PROCESS__SETKEYCREATE);
+	else if (!strcmp(name, "sockcreate"))
+		error = task_has_perm(current, p, PROCESS__SETSOCKCREATE);
 	else if (!strcmp(name, "current"))
 		error = task_has_perm(current, p, PROCESS__SETCURRENT);
 	else
@@ -4231,7 +4241,9 @@ static int selinux_setprocattr(struct ta
 		if (error)
 			return error;
 		tsec->keycreate_sid = sid;
-	} else if (!strcmp(name, "current")) {
+	} else if (!strcmp(name, "sockcreate"))
+		tsec->sockcreate_sid = sid;
+	else if (!strcmp(name, "current")) {
 		struct av_decision avd;
 
 		if (sid == 0)
diff -purN -X dontdiff linux-2.6.17-mm1.p/security/selinux/include/av_permissions.h linux-2.6.17-mm1.w/security/selinux/include/av_permissions.h
--- linux-2.6.17-mm1.p/security/selinux/include/av_permissions.h	2006-06-21 11:54:12.000000000 -0400
+++ linux-2.6.17-mm1.w/security/selinux/include/av_permissions.h	2006-06-21 12:57:36.000000000 -0400
@@ -468,6 +468,7 @@
 #define PROCESS__EXECSTACK                        0x04000000UL
 #define PROCESS__EXECHEAP                         0x08000000UL
 #define PROCESS__SETKEYCREATE                     0x10000000UL
+#define PROCESS__SETSOCKCREATE                    0x20000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
diff -purN -X dontdiff linux-2.6.17-mm1.p/security/selinux/include/av_perm_to_string.h linux-2.6.17-mm1.w/security/selinux/include/av_perm_to_string.h
--- linux-2.6.17-mm1.p/security/selinux/include/av_perm_to_string.h	2006-06-21 11:54:12.000000000 -0400
+++ linux-2.6.17-mm1.w/security/selinux/include/av_perm_to_string.h	2006-06-21 12:58:58.000000000 -0400
@@ -73,6 +73,7 @@
    S_(SECCLASS_PROCESS, PROCESS__EXECSTACK, "execstack")
    S_(SECCLASS_PROCESS, PROCESS__EXECHEAP, "execheap")
    S_(SECCLASS_PROCESS, PROCESS__SETKEYCREATE, "setkeycreate")
+   S_(SECCLASS_PROCESS, PROCESS__SETSOCKCREATE, "setsockcreate")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
diff -purN -X dontdiff linux-2.6.17-mm1.p/security/selinux/include/objsec.h linux-2.6.17-mm1.w/security/selinux/include/objsec.h
--- linux-2.6.17-mm1.p/security/selinux/include/objsec.h	2006-06-21 11:54:12.000000000 -0400
+++ linux-2.6.17-mm1.w/security/selinux/include/objsec.h	2006-06-21 12:58:07.000000000 -0400
@@ -33,6 +33,7 @@ struct task_security_struct {
 	u32 exec_sid;        /* exec SID */
 	u32 create_sid;      /* fscreate SID */
 	u32 keycreate_sid;   /* keycreate SID */
+	u32 sockcreate_sid;  /* fscreate SID */
 	u32 ptrace_sid;      /* SID of ptrace parent */
 };
 
