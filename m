Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWFTRiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWFTRiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWFTRiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:38:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15314 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750720AbWFTRhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:37:53 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 6/6] Keys: Add a way to store the appropriate context for newly-created keys [try #3]
Date: Tue, 20 Jun 2006 18:37:49 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Message-Id: <20060620173748.5034.70750.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
References: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Add a /proc/<pid>/attr/keycreate entry that stores the appropriate
context for newly-created keys.  Modify the selinux_key_alloc
hook to make use of the new entry.  Update the flask headers to
include a new "setkeycreate" permission for processes.  Update the
flask headers to include a new "create" permission for keys.  Use
the create permission to restrict which SIDs each task can assign
to newly-created keys.  Add a new parameter to the security hook
"security_key_alloc" to indicate whether it is being invoked by
the kernel, or from userspace.  If it is being invoked by the
kernel, the security hook should never fail.  Update the
documentation to reflect these changes.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>
Signed-off-by: James Morris <jmorris@namei.org>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/keys.txt                       |   27 ++++++++++++--------
 fs/proc/base.c                               |    6 ++++
 security/selinux/hooks.c                     |   35 ++++++++++++++++++++++----
 security/selinux/include/av_perm_to_string.h |    2 +
 security/selinux/include/av_permissions.h    |    2 +
 security/selinux/include/objsec.h            |    1 +
 6 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/Documentation/keys.txt b/Documentation/keys.txt
index 70e83cf..61c0fad 100644
--- a/Documentation/keys.txt
+++ b/Documentation/keys.txt
@@ -241,25 +241,30 @@ The security class "key" has been added 
 controls can be applied to keys created within various contexts.  This support
 is preliminary, and is likely to change quite significantly in the near future.
 Currently, all of the basic permissions explained above are provided in SELinux
-as well; SE Linux is simply invoked after all basic permission checks have been
+as well; SELinux is simply invoked after all basic permission checks have been
 performed.
 
-Each key is labeled with the same context as the task to which it belongs.
-Typically, this is the same task that was running when the key was created.
-The default keyrings are handled differently, but in a way that is very
-intuitive:
+The value of the file /proc/self/attr/keycreate influences the labeling of
+newly-created keys.  If the contents of that file correspond to an SELinux
+security context, then the key will be assigned that context.  Otherwise, the
+key will be assigned the current context of the task that invoked the key
+creation request.  Tasks must be granted explicit permission to assign a
+particular context to newly-created keys, using the "create" permission in the
+key security class.
 
- (*) The user and user session keyrings that are created when the user logs in
-     are currently labeled with the context of the login manager.
-
- (*) The keyrings associated with new threads are each labeled with the context
-     of their associated thread, and both session and process keyrings are
-     handled similarly.
+The default keyrings associated with users will be labeled with the default
+context of the user if and only if the login programs have been instrumented to
+properly initialize keycreate during the login process.  Otherwise, they will
+be labeled with the context of the login program itself.
 
 Note, however, that the default keyrings associated with the root user are
 labeled with the default kernel context, since they are created early in the
 boot process, before root has a chance to log in.
 
+The keyrings associated with new threads are each labeled with the context of
+their associated thread, and both session and process keyrings are handled
+similarly.
+
 
 ================
 NEW PROCFS FILES
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6cc77dc..5334e07 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -121,6 +121,7 @@ #ifdef CONFIG_SECURITY
 	PROC_TGID_ATTR_PREV,
 	PROC_TGID_ATTR_EXEC,
 	PROC_TGID_ATTR_FSCREATE,
+	PROC_TGID_ATTR_KEYCREATE,
 #endif
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TGID_LOGINUID,
@@ -162,6 +163,7 @@ #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR_PREV,
 	PROC_TID_ATTR_EXEC,
 	PROC_TID_ATTR_FSCREATE,
+	PROC_TID_ATTR_KEYCREATE,
 #endif
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TID_LOGINUID,
@@ -275,6 +277,7 @@ static struct pid_entry tgid_attr_stuff[
 	E(PROC_TGID_ATTR_PREV,     "prev",     S_IFREG|S_IRUGO),
 	E(PROC_TGID_ATTR_EXEC,     "exec",     S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TGID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_attr_stuff[] = {
@@ -282,6 +285,7 @@ static struct pid_entry tid_attr_stuff[]
 	E(PROC_TID_ATTR_PREV,      "prev",     S_IFREG|S_IRUGO),
 	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
 	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
+	E(PROC_TID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
 	{0,0,NULL,0}
 };
 #endif
@@ -1800,6 +1804,8 @@ #ifdef CONFIG_SECURITY
 		case PROC_TGID_ATTR_EXEC:
 		case PROC_TID_ATTR_FSCREATE:
 		case PROC_TGID_ATTR_FSCREATE:
+		case PROC_TID_ATTR_KEYCREATE:
+		case PROC_TGID_ATTR_KEYCREATE:
 			inode->i_fop = &proc_pid_attr_operations;
 			break;
 #endif
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f80c74d..8c1e1d5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1099,6 +1099,17 @@ static int may_create(struct inode *dir,
 			    FILESYSTEM__ASSOCIATE, &ad);
 }
 
+/* Check whether a task can create a key. */
+static int may_create_key(u32 ksid,
+			  struct task_struct *ctx)
+{
+	struct task_security_struct *tsec;
+
+	tsec = ctx->security;
+
+	return avc_has_perm(tsec->sid, ksid, SECCLASS_KEY, KEY__CREATE, NULL);
+}
+
 #define MAY_LINK   0
 #define MAY_UNLINK 1
 #define MAY_RMDIR  2
@@ -4140,6 +4151,8 @@ static int selinux_getprocattr(struct ta
 		sid = tsec->exec_sid;
 	else if (!strcmp(name, "fscreate"))
 		sid = tsec->create_sid;
+	else if (!strcmp(name, "keycreate"))
+		sid = tsec->keycreate_sid;
 	else
 		return -EINVAL;
 
@@ -4172,6 +4185,8 @@ static int selinux_setprocattr(struct ta
 		error = task_has_perm(current, p, PROCESS__SETEXEC);
 	else if (!strcmp(name, "fscreate"))
 		error = task_has_perm(current, p, PROCESS__SETFSCREATE);
+	else if (!strcmp(name, "keycreate"))
+		error = task_has_perm(current, p, PROCESS__SETKEYCREATE);
 	else if (!strcmp(name, "current"))
 		error = task_has_perm(current, p, PROCESS__SETCURRENT);
 	else
@@ -4201,7 +4216,12 @@ static int selinux_setprocattr(struct ta
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
 		tsec->create_sid = sid;
-	else if (!strcmp(name, "current")) {
+	else if (!strcmp(name, "keycreate")) {
+		error = may_create_key(sid, p);
+		if (error)
+			return error;
+		tsec->keycreate_sid = sid;
+	} else if (!strcmp(name, "current")) {
 		struct av_decision avd;
 
 		if (sid == 0)
@@ -4265,7 +4285,10 @@ static int selinux_key_alloc(struct key 
 		return -ENOMEM;
 
 	ksec->obj = k;
-	ksec->sid = tsec->sid;
+	if (tsec->keycreate_sid)
+		ksec->sid = tsec->keycreate_sid;
+	else
+		ksec->sid = tsec->sid;
 	k->security = ksec;
 
 	return 0;
@@ -4502,10 +4525,10 @@ static __init int selinux_init(void)
 
 #ifdef CONFIG_KEYS
 	/* Add security information to initial keyrings */
-	security_key_alloc(&root_user_keyring, current,
-			   KEY_ALLOC_NOT_IN_QUOTA);
-	security_key_alloc(&root_session_keyring, current,
-			   KEY_ALLOC_NOT_IN_QUOTA);
+	selinux_key_alloc(&root_user_keyring, current,
+			  KEY_ALLOC_NOT_IN_QUOTA);
+	selinux_key_alloc(&root_session_keyring, current,
+			  KEY_ALLOC_NOT_IN_QUOTA);
 #endif
 
 	return 0;
diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index bc020bd..e777578 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -72,6 +72,7 @@
    S_(SECCLASS_PROCESS, PROCESS__EXECMEM, "execmem")
    S_(SECCLASS_PROCESS, PROCESS__EXECSTACK, "execstack")
    S_(SECCLASS_PROCESS, PROCESS__EXECHEAP, "execheap")
+   S_(SECCLASS_PROCESS, PROCESS__SETKEYCREATE, "setkeycreate")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
@@ -248,3 +249,4 @@
    S_(SECCLASS_KEY, KEY__SEARCH, "search")
    S_(SECCLASS_KEY, KEY__LINK, "link")
    S_(SECCLASS_KEY, KEY__SETATTR, "setattr")
+   S_(SECCLASS_KEY, KEY__CREATE, "create")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index b108dda..ba5ef05 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -467,6 +467,7 @@ #define PROCESS__SETCURRENT             
 #define PROCESS__EXECMEM                          0x02000000UL
 #define PROCESS__EXECSTACK                        0x04000000UL
 #define PROCESS__EXECHEAP                         0x08000000UL
+#define PROCESS__SETKEYCREATE                     0x10000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
@@ -965,3 +966,4 @@ #define KEY__WRITE                      
 #define KEY__SEARCH                               0x00000008UL
 #define KEY__LINK                                 0x00000010UL
 #define KEY__SETATTR                              0x00000020UL
+#define KEY__CREATE                               0x00000040UL
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 8f5547a..191b3e4 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -32,6 +32,7 @@ struct task_security_struct {
 	u32 sid;             /* current SID */
 	u32 exec_sid;        /* exec SID */
 	u32 create_sid;      /* fscreate SID */
+	u32 keycreate_sid;   /* keycreate SID */
 	u32 ptrace_sid;      /* SID of ptrace parent */
 };
 

