Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVETRg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVETRg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVETRg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:36:28 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:25754 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S261503AbVETRf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:35:57 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116608144.29037.55.camel@localhost.localdomain>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
	 <1116502449.23972.207.camel@hades.cambridge.redhat.com>
	 <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu>
	 <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu>
	 <1116601195.29037.18.camel@localhost.localdomain>
	 <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil>
	 <1116603414.29037.36.camel@localhost.localdomain>
	 <1116607223.12489.155.camel@moss-spartans.epoch.ncsc.mil>
	 <1116608144.29037.55.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 20 May 2005 13:26:23 -0400
Message-Id: <1116609983.12489.180.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 17:55 +0100, David Woodhouse wrote:
> Yeah, basically. Although it would be better to introduce AUDIT_AVC_PATH
> instead of using AUDIT_AVC for the type. If there's general agreement
> this this is a sane answer, I'll stick it in the git tree. Can I see a
> Signed-off-by line please?

This patch changes the SELinux AVC to defer logging of paths to the audit
framework upon syscall exit, by saving a reference to the (dentry,vfsmount)
pair in an auxiliary audit item on the current audit context for processing
by audit_log_exit.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 include/linux/audit.h  |    3 +++
 kernel/auditsc.c       |   39 +++++++++++++++++++++++++++++++++++++++
 security/selinux/avc.c |   17 ++++++++---------
 3 files changed, 50 insertions(+), 9 deletions(-)

--- linux-2.6.12-rc4-mm2/include/linux/audit.h.orig	2005-05-20 12:37:41.000000000 -0400
+++ linux-2.6.12-rc4-mm2/include/linux/audit.h	2005-05-20 13:17:21.000000000 -0400
@@ -75,6 +75,7 @@
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
+#define AUDIT_AVC_PATH		1402	/* dentry, vfsmount pair from avc */
 
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
@@ -238,6 +239,7 @@ extern uid_t audit_get_loginuid(struct a
 extern int audit_ipc_perms(unsigned long qbytes, uid_t uid, gid_t gid, mode_t mode);
 extern int audit_socketcall(int nargs, unsigned long *args);
 extern int audit_sockaddr(int len, void *addr);
+extern int audit_avc_path(struct dentry *dentry, struct vfsmount *mnt);
 extern void audit_signal_info(int sig, struct task_struct *t);
 #else
 #define audit_alloc(t) ({ 0; })
@@ -253,6 +255,7 @@ extern void audit_signal_info(int sig, s
 #define audit_ipc_perms(q,u,g,m) ({ 0; })
 #define audit_socketcall(n,a) ({ 0; })
 #define audit_sockaddr(len, addr) ({ 0; })
+#define audit_avc_path(dentry, mnt) ({ 0; })
 #define audit_signal_info(s,t) do { ; } while (0)
 #endif
 
--- linux-2.6.12-rc4-mm2/kernel/auditsc.c.orig	2005-05-20 12:37:19.000000000 -0400
+++ linux-2.6.12-rc4-mm2/kernel/auditsc.c	2005-05-20 13:21:40.000000000 -0400
@@ -34,6 +34,7 @@
 #include <asm/types.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/socket.h>
 #include <linux/audit.h>
 #include <linux/personality.h>
@@ -124,6 +125,11 @@ struct audit_aux_data_sockaddr {
 	char			a[0];
 };
 
+struct audit_aux_data_path {
+	struct audit_aux_data	d;
+	struct dentry		*dentry;
+	struct vfsmount		*mnt;
+};
 
 /* The per-task audit context. */
 struct audit_context {
@@ -553,6 +559,11 @@ static inline void audit_free_aux(struct
 	struct audit_aux_data *aux;
 
 	while ((aux = context->aux)) {
+		if (aux->type == AUDIT_AVC_PATH) {
+			struct audit_aux_data_path *axi = (void *)aux;
+			dput(axi->dentry);
+			mntput(axi->mnt);
+		}
 		context->aux = aux->next;
 		kfree(aux);
 	}
@@ -728,6 +739,13 @@ static void audit_log_exit(struct audit_
 			} /* case AUDIT_SOCKADDR */
 			break;
 
+		case AUDIT_AVC_PATH: {
+			struct audit_aux_data_path *axi = (void *)aux;
+			audit_log_d_path(ab, "path=", axi->dentry, axi->mnt);
+			dput(axi->dentry);
+			mntput(axi->mnt);
+			} /* case AUDIT_AVC_PATH */
+			break;
 		}
 		audit_log_end(ab);
 
@@ -1128,6 +1146,27 @@ int audit_sockaddr(int len, void *a)
 	return 0;
 }
 
+int audit_avc_path(struct dentry *dentry, struct vfsmount *mnt)
+{
+	struct audit_aux_data_path *ax;
+	struct audit_context *context = current->audit_context;
+
+	if (likely(!context))
+		return 0;
+
+	ax = kmalloc(sizeof(*ax), GFP_ATOMIC);
+	if (!ax)
+		return -ENOMEM;
+
+	ax->dentry = dget(dentry);
+	ax->mnt = mntget(mnt);
+
+	ax->d.type = AUDIT_AVC_PATH;
+	ax->d.next = context->aux;
+	context->aux = (void *)ax;
+	return 0;
+}
+
 void audit_signal_info(int sig, struct task_struct *t)
 {
 	extern pid_t audit_sig_pid;
--- linux-2.6.12-rc4-mm2/security/selinux/avc.c.orig	2005-05-20 12:37:41.000000000 -0400
+++ linux-2.6.12-rc4-mm2/security/selinux/avc.c	2005-05-20 12:39:06.000000000 -0400
@@ -566,13 +566,10 @@ void avc_audit(u32 ssid, u32 tsid,
 		case AVC_AUDIT_DATA_FS:
 			if (a->u.fs.dentry) {
 				struct dentry *dentry = a->u.fs.dentry;
-				if (a->u.fs.mnt) {
-					audit_log_d_path(ab, "path=", dentry,
-							a->u.fs.mnt);
-				} else {
-					audit_log_format(ab, " name=%s",
-							 dentry->d_name.name);
-				}
+				if (a->u.fs.mnt)
+					audit_avc_path(dentry, a->u.fs.mnt);
+				audit_log_format(ab, " name=%s",
+						 dentry->d_name.name);
 				inode = dentry->d_inode;
 			} else if (a->u.fs.inode) {
 				struct dentry *dentry;
@@ -623,8 +620,10 @@ void avc_audit(u32 ssid, u32 tsid,
 				case AF_UNIX:
 					u = unix_sk(sk);
 					if (u->dentry) {
-						audit_log_d_path(ab, "path=",
-							u->dentry, u->mnt);
+						audit_avc_path(u->dentry, u->mnt);
+						audit_log_format(ab, " name=%s",
+								 u->dentry->d_name.name);
+
 						break;
 					}
 					if (!u->addr)



-- 
Stephen Smalley
National Security Agency

