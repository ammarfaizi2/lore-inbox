Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVCNTkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVCNTkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVCNTkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:40:42 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:60919 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261768AbVCNThf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:37:35 -0500
Subject: Re: [2.6 patch] selinux: cleanups
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       selinux@tycho.nsa.gov
In-Reply-To: <20050313030157.GN3814@stusta.de>
References: <20041128190139.GD4390@stusta.de>
	 <1102089296.29971.110.camel@moss-spartans.epoch.ncsc.mil>
	 <1102532326.26951.129.camel@moss-spartans.epoch.ncsc.mil>
	 <20050313030157.GN3814@stusta.de>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 14 Mar 2005 14:22:10 -0500
Message-Id: <1110828130.21378.213.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-13 at 04:01 +0100, Adrian Bunk wrote:
> The patch below contains the following possible cleanups:
> - make needlessly global code static
> - remove the following unused global functions:
>   - avc.c: avc_ss_grant
>   - avc.c: avc_ss_try_revoke
>   - avc.c: avc_ss_revoke
>   - avc.c: avc_ss_set_auditallow
>   - avc.c: avc_ss_set_auditdeny
>   - ss/avtab.c: avtab_map
>   - ss/ebitmap.c: ebitmap_or
>   - ss/hashtab.c: hashtab_remove
>   - ss/hashtab.c: hashtab_replace
>   - ss/hashtab.c: hashtab_map_remove_on_error
>   - ss/sidtab.c: sidtab_remove
> - remove the following unused static functions:
>   - avc.c: avc_update_cache
>   - avc.c: avc_control
> 
> 
> Please review and comment on which of these changes are correct and 
> which conflict with pending patches for in-kernel users of the functions 
> affected.
> 
> 
> diffstat output:
>  security/selinux/avc.c              |  174 ----------------------------
>  security/selinux/hooks.c            |   40 +++---
>  security/selinux/include/avc.h      |    7 -
>  security/selinux/include/avc_ss.h   |   13 --
>  security/selinux/include/objsec.h   |    2 
>  security/selinux/include/security.h |    3 
>  security/selinux/selinuxfs.c        |    4 
>  security/selinux/ss/avtab.c         |   27 ----
>  security/selinux/ss/avtab.h         |    6 
>  security/selinux/ss/conditional.c   |    2 
>  security/selinux/ss/ebitmap.c       |   43 ------
>  security/selinux/ss/ebitmap.h       |    1 
>  security/selinux/ss/hashtab.c       |  113 ------------------
>  security/selinux/ss/hashtab.h       |   38 ------
>  security/selinux/ss/mls.c           |    2 
>  security/selinux/ss/policydb.c      |   10 -
>  security/selinux/ss/policydb.h      |    3 
>  security/selinux/ss/services.c      |   23 ---
>  security/selinux/ss/sidtab.c        |   36 -----
>  19 files changed, 34 insertions(+), 513 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Looks fine to me (although your diffstat output is stale).  Re-diff
against 2.6.11-mm3 is below, feel free to send along to Andrew Morton.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

 security/selinux/avc.c            |  174 --------------------------------------
 security/selinux/hooks.c          |   40 ++++----
 security/selinux/include/avc.h    |    7 -
 security/selinux/include/avc_ss.h |   13 --
 security/selinux/include/objsec.h |    2 
 security/selinux/selinuxfs.c      |    4 
 security/selinux/ss/avtab.c       |   29 ------
 security/selinux/ss/avtab.h       |    6 -
 security/selinux/ss/conditional.c |    2 
 security/selinux/ss/ebitmap.c     |   43 ---------
 security/selinux/ss/ebitmap.h     |    1 
 security/selinux/ss/hashtab.c     |  113 ------------------------
 security/selinux/ss/hashtab.h     |   38 --------
 security/selinux/ss/policydb.c    |   10 +-
 security/selinux/ss/policydb.h    |    3 
 security/selinux/ss/services.c    |   18 +--
 security/selinux/ss/services.h    |    6 -
 security/selinux/ss/sidtab.c      |   36 -------
 18 files changed, 42 insertions(+), 503 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/avc.c linux-2.6.11-mm3-adrian/security/selinux/avc.c
--- linux-2.6.11-mm3/security/selinux/avc.c	2005-03-02 02:38:17.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/avc.c	2005-03-14 14:08:28.000000000 -0500
@@ -139,7 +139,7 @@ static inline int avc_hash(u32 ssid, u32
  * @tclass: target security class
  * @av: access vector
  */
-void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
+static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
 {
 	const char **common_pts = NULL;
 	u32 common_base = 0;
@@ -199,7 +199,7 @@ void avc_dump_av(struct audit_buffer *ab
  * @tsid: target security identifier
  * @tclass: target security class
  */
-void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tclass)
+static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tclass)
 {
 	int rc;
 	char *scontext;
@@ -828,136 +828,6 @@ out:
 	return rc;
 }
 
-static int avc_update_cache(u32 event, u32 ssid, u32 tsid,
-                            u16 tclass, u32 perms)
-{
-	struct avc_node *node;
-	int i;
-
-	rcu_read_lock();
-
-	if (ssid == SECSID_WILD || tsid == SECSID_WILD) {
-		/* apply to all matching nodes */
-		for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-			list_for_each_entry_rcu(node, &avc_cache.slots[i], list) {
-				if (avc_sidcmp(ssid, node->ae.ssid) &&
-				    avc_sidcmp(tsid, node->ae.tsid) &&
-				    tclass == node->ae.tclass ) {
-					avc_update_node(event, perms, node->ae.ssid,
-							node->ae.tsid, node->ae.tclass);
-				}
-			}
-		}
-	} else {
-		/* apply to one node */
-		avc_update_node(event, perms, ssid, tsid, tclass);
-	}
-
-	rcu_read_unlock();
-
-	return 0;
-}
-
-static int avc_control(u32 event, u32 ssid, u32 tsid,
-                       u16 tclass, u32 perms,
-                       u32 seqno, u32 *out_retained)
-{
-	struct avc_callback_node *c;
-	u32 tretained = 0, cretained = 0;
-	int rc = 0;
-
-	/*
-	 * try_revoke only removes permissions from the cache
-	 * state if they are not retained by the object manager.
-	 * Hence, try_revoke must wait until after the callbacks have
-	 * been invoked to update the cache state.
-	 */
-	if (event != AVC_CALLBACK_TRY_REVOKE)
-		avc_update_cache(event,ssid,tsid,tclass,perms);
-
-	for (c = avc_callbacks; c; c = c->next)
-	{
-		if ((c->events & event) &&
-		    avc_sidcmp(c->ssid, ssid) &&
-		    avc_sidcmp(c->tsid, tsid) &&
-		    c->tclass == tclass &&
-		    (c->perms & perms)) {
-			cretained = 0;
-			rc = c->callback(event, ssid, tsid, tclass,
-					 (c->perms & perms),
-					 &cretained);
-			if (rc)
-				goto out;
-			tretained |= cretained;
-		}
-	}
-
-	if (event == AVC_CALLBACK_TRY_REVOKE) {
-		/* revoke any unretained permissions */
-		perms &= ~tretained;
-		avc_update_cache(event,ssid,tsid,tclass,perms);
-		*out_retained = tretained;
-	}
-
-	avc_latest_notif_update(seqno, 0);
-
-out:
-	return rc;
-}
-
-/**
- * avc_ss_grant - Grant previously denied permissions.
- * @ssid: source security identifier or %SECSID_WILD
- * @tsid: target security identifier or %SECSID_WILD
- * @tclass: target security class
- * @perms: permissions to grant
- * @seqno: policy sequence number
- */
-int avc_ss_grant(u32 ssid, u32 tsid, u16 tclass,
-                 u32 perms, u32 seqno)
-{
-	return avc_control(AVC_CALLBACK_GRANT,
-			   ssid, tsid, tclass, perms, seqno, NULL);
-}
-
-/**
- * avc_ss_try_revoke - Try to revoke previously granted permissions.
- * @ssid: source security identifier or %SECSID_WILD
- * @tsid: target security identifier or %SECSID_WILD
- * @tclass: target security class
- * @perms: permissions to grant
- * @seqno: policy sequence number
- * @out_retained: subset of @perms that are retained
- *
- * Try to revoke previously granted permissions, but
- * only if they are not retained as migrated permissions.
- * Return the subset of permissions that are retained via @out_retained.
- */
-int avc_ss_try_revoke(u32 ssid, u32 tsid, u16 tclass,
-                      u32 perms, u32 seqno, u32 *out_retained)
-{
-	return avc_control(AVC_CALLBACK_TRY_REVOKE,
-			   ssid, tsid, tclass, perms, seqno, out_retained);
-}
-
-/**
- * avc_ss_revoke - Revoke previously granted permissions.
- * @ssid: source security identifier or %SECSID_WILD
- * @tsid: target security identifier or %SECSID_WILD
- * @tclass: target security class
- * @perms: permissions to grant
- * @seqno: policy sequence number
- *
- * Revoke previously granted permissions, even if
- * they are retained as migrated permissions.
- */
-int avc_ss_revoke(u32 ssid, u32 tsid, u16 tclass,
-                  u32 perms, u32 seqno)
-{
-	return avc_control(AVC_CALLBACK_REVOKE,
-			   ssid, tsid, tclass, perms, seqno, NULL);
-}
-
 /**
  * avc_ss_reset - Flush the cache and revalidate migrated permissions.
  * @seqno: policy sequence number
@@ -991,46 +861,6 @@ out:
 }
 
 /**
- * avc_ss_set_auditallow - Enable or disable auditing of granted permissions.
- * @ssid: source security identifier or %SECSID_WILD
- * @tsid: target security identifier or %SECSID_WILD
- * @tclass: target security class
- * @perms: permissions to grant
- * @seqno: policy sequence number
- * @enable: enable flag.
- */
-int avc_ss_set_auditallow(u32 ssid, u32 tsid, u16 tclass,
-                          u32 perms, u32 seqno, u32 enable)
-{
-	if (enable)
-		return avc_control(AVC_CALLBACK_AUDITALLOW_ENABLE,
-				   ssid, tsid, tclass, perms, seqno, NULL);
-	else
-		return avc_control(AVC_CALLBACK_AUDITALLOW_DISABLE,
-				   ssid, tsid, tclass, perms, seqno, NULL);
-}
-
-/**
- * avc_ss_set_auditdeny - Enable or disable auditing of denied permissions.
- * @ssid: source security identifier or %SECSID_WILD
- * @tsid: target security identifier or %SECSID_WILD
- * @tclass: target security class
- * @perms: permissions to grant
- * @seqno: policy sequence number
- * @enable: enable flag.
- */
-int avc_ss_set_auditdeny(u32 ssid, u32 tsid, u16 tclass,
-                         u32 perms, u32 seqno, u32 enable)
-{
-	if (enable)
-		return avc_control(AVC_CALLBACK_AUDITDENY_ENABLE,
-				   ssid, tsid, tclass, perms, seqno, NULL);
-	else
-		return avc_control(AVC_CALLBACK_AUDITDENY_DISABLE,
-				   ssid, tsid, tclass, perms, seqno, NULL);
-}
-
-/**
  * avc_has_perm_noaudit - Check permissions but perform no auditing.
  * @ssid: source security identifier
  * @tsid: target security identifier
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/hooks.c linux-2.6.11-mm3-adrian/security/selinux/hooks.c
--- linux-2.6.11-mm3/security/selinux/hooks.c	2005-03-14 13:56:06.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/hooks.c	2005-03-14 14:08:28.000000000 -0500
@@ -921,9 +921,9 @@ static inline u32 signal_to_av(int sig)
 
 /* Check permission betweeen a pair of tasks, e.g. signal checks,
    fork check, ptrace check, etc. */
-int task_has_perm(struct task_struct *tsk1,
-		  struct task_struct *tsk2,
-		  u32 perms)
+static int task_has_perm(struct task_struct *tsk1,
+			 struct task_struct *tsk2,
+			 u32 perms)
 {
 	struct task_security_struct *tsec1, *tsec2;
 
@@ -934,8 +934,8 @@ int task_has_perm(struct task_struct *ts
 }
 
 /* Check whether a task is allowed to use a capability. */
-int task_has_capability(struct task_struct *tsk,
-			int cap)
+static int task_has_capability(struct task_struct *tsk,
+			       int cap)
 {
 	struct task_security_struct *tsec;
 	struct avc_audit_data ad;
@@ -951,8 +951,8 @@ int task_has_capability(struct task_stru
 }
 
 /* Check whether a task is allowed to use a system operation. */
-int task_has_system(struct task_struct *tsk,
-		    u32 perms)
+static int task_has_system(struct task_struct *tsk,
+			   u32 perms)
 {
 	struct task_security_struct *tsec;
 
@@ -965,10 +965,10 @@ int task_has_system(struct task_struct *
 /* Check whether a task has a particular permission to an inode.
    The 'adp' parameter is optional and allows other audit
    data to be passed (e.g. the dentry). */
-int inode_has_perm(struct task_struct *tsk,
-		   struct inode *inode,
-		   u32 perms,
-		   struct avc_audit_data *adp)
+static int inode_has_perm(struct task_struct *tsk,
+			  struct inode *inode,
+			  u32 perms,
+			  struct avc_audit_data *adp)
 {
 	struct task_security_struct *tsec;
 	struct inode_security_struct *isec;
@@ -1190,10 +1190,10 @@ static inline int may_rename(struct inod
 }
 
 /* Check whether a task can perform a filesystem operation. */
-int superblock_has_perm(struct task_struct *tsk,
-			struct super_block *sb,
-			u32 perms,
-			struct avc_audit_data *ad)
+static int superblock_has_perm(struct task_struct *tsk,
+			       struct super_block *sb,
+			       u32 perms,
+			       struct avc_audit_data *ad)
 {
 	struct task_security_struct *tsec;
 	struct superblock_security_struct *sbsec;
@@ -1250,7 +1250,7 @@ static inline u32 file_to_av(struct file
 }
 
 /* Set an inode's SID to a specified value. */
-int inode_security_set_sid(struct inode *inode, u32 sid)
+static int inode_security_set_sid(struct inode *inode, u32 sid)
 {
 	struct inode_security_struct *isec = inode->i_security;
 	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
@@ -4019,7 +4019,7 @@ static int selinux_ipc_permission(struct
 }
 
 /* module stacking operations */
-int selinux_register_security (const char *name, struct security_operations *ops)
+static int selinux_register_security (const char *name, struct security_operations *ops)
 {
 	if (secondary_ops != original_ops) {
 		printk(KERN_INFO "%s:  There is already a secondary security "
@@ -4036,7 +4036,7 @@ int selinux_register_security (const cha
 	return 0;
 }
 
-int selinux_unregister_security (const char *name, struct security_operations *ops)
+static int selinux_unregister_security (const char *name, struct security_operations *ops)
 {
 	if (ops != secondary_ops) {
 		printk (KERN_INFO "%s:  trying to unregister a security module "
@@ -4203,7 +4203,7 @@ static int selinux_setprocattr(struct ta
 	return size;
 }
 
-struct security_operations selinux_ops = {
+static struct security_operations selinux_ops = {
 	.ptrace =			selinux_ptrace,
 	.capget =			selinux_capget,
 	.capset_check =			selinux_capset_check,
@@ -4352,7 +4352,7 @@ struct security_operations selinux_ops =
 #endif
 };
 
-__init int selinux_init(void)
+static __init int selinux_init(void)
 {
 	struct task_security_struct *tsec;
 
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/include/avc.h linux-2.6.11-mm3-adrian/security/selinux/include/avc.h
--- linux-2.6.11-mm3/security/selinux/include/avc.h	2005-03-02 02:37:49.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/include/avc.h	2005-03-14 14:08:28.000000000 -0500
@@ -93,13 +93,6 @@ struct avc_cache_stats
 };
 
 /*
- * AVC display support
- */
-struct audit_buffer;
-void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av);
-void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tclass);
-
-/*
  * AVC operations
  */
 
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/include/avc_ss.h linux-2.6.11-mm3-adrian/security/selinux/include/avc_ss.h
--- linux-2.6.11-mm3/security/selinux/include/avc_ss.h	2005-03-02 02:38:33.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/include/avc_ss.h	2005-03-14 14:08:28.000000000 -0500
@@ -8,20 +8,7 @@
 
 #include "flask.h"
 
-int avc_ss_grant(u32 ssid, u32 tsid, u16 tclass, u32 perms, u32 seqno);
-
-int avc_ss_try_revoke(u32 ssid, u32 tsid, u16 tclass, u32 perms, u32 seqno,
-		      u32 *out_retained);
-
-int avc_ss_revoke(u32 ssid, u32 tsid, u16 tclass, u32 perms, u32 seqno);
-
 int avc_ss_reset(u32 seqno);
 
-int avc_ss_set_auditallow(u32 ssid, u32 tsid, u16 tclass, u32 perms,
-			  u32 seqno, u32 enable);
-
-int avc_ss_set_auditdeny(u32 ssid, u32 tsid, u16 tclass, u32 perms,
-			 u32 seqno, u32 enable);
-
 #endif /* _SELINUX_AVC_SS_H_ */
 
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/include/objsec.h linux-2.6.11-mm3-adrian/security/selinux/include/objsec.h
--- linux-2.6.11-mm3/security/selinux/include/objsec.h	2005-03-14 13:56:06.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/include/objsec.h	2005-03-14 14:08:28.000000000 -0500
@@ -107,8 +107,6 @@ struct sk_security_struct {
 	u32 peer_sid;			/* SID of peer */
 };
 
-extern int inode_security_set_sid(struct inode *inode, u32 sid);
-
 extern unsigned int selinux_checkreqprot;
 
 #endif /* _SELINUX_OBJSEC_H_ */
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/selinuxfs.c linux-2.6.11-mm3-adrian/security/selinux/selinuxfs.c
--- linux-2.6.11-mm3/security/selinux/selinuxfs.c	2005-03-14 13:56:06.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/selinuxfs.c	2005-03-14 14:08:28.000000000 -0500
@@ -54,8 +54,8 @@ static int *bool_pending_values = NULL;
 extern void selnl_notify_setenforce(int val);
 
 /* Check whether a task is allowed to use a security operation. */
-int task_has_security(struct task_struct *tsk,
-		      u32 perms)
+static int task_has_security(struct task_struct *tsk,
+			     u32 perms)
 {
 	struct task_security_struct *tsec;
 
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/avtab.c linux-2.6.11-mm3-adrian/security/selinux/ss/avtab.c
--- linux-2.6.11-mm3/security/selinux/ss/avtab.c	2005-03-02 02:38:17.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/avtab.c	2005-03-14 14:08:28.000000000 -0500
@@ -31,7 +31,8 @@
 static kmem_cache_t *avtab_node_cachep;
 
 static struct avtab_node*
-avtab_insert_node(struct avtab *h, int hvalue, struct avtab_node * prev, struct avtab_node * cur,
+avtab_insert_node(struct avtab *h, int hvalue,
+		  struct avtab_node * prev, struct avtab_node * cur,
 		  struct avtab_key *key, struct avtab_datum *datum)
 {
 	struct avtab_node * newnode;
@@ -53,7 +54,7 @@ avtab_insert_node(struct avtab *h, int h
 	return newnode;
 }
 
-int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
+static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
 {
 	int hvalue;
 	struct avtab_node *prev, *cur, *newnode;
@@ -237,30 +238,6 @@ void avtab_destroy(struct avtab *h)
 }
 
 
-int avtab_map(struct avtab *h,
-	      int (*apply) (struct avtab_key *k,
-			    struct avtab_datum *d,
-			    void *args),
-	      void *args)
-{
-	int i, ret;
-	struct avtab_node *cur;
-
-	if (!h)
-		return 0;
-
-	for (i = 0; i < AVTAB_SIZE; i++) {
-		cur = h->htable[i];
-		while (cur != NULL) {
-			ret = apply(&cur->key, &cur->datum, args);
-			if (ret)
-				return ret;
-			cur = cur->next;
-		}
-	}
-	return 0;
-}
-
 int avtab_init(struct avtab *h)
 {
 	int i;
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/avtab.h linux-2.6.11-mm3-adrian/security/selinux/ss/avtab.h
--- linux-2.6.11-mm3/security/selinux/ss/avtab.h	2005-03-02 02:37:58.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/avtab.h	2005-03-14 14:08:28.000000000 -0500
@@ -58,14 +58,8 @@ struct avtab {
 };
 
 int avtab_init(struct avtab *);
-int avtab_insert(struct avtab *h, struct avtab_key *k, struct avtab_datum *d);
 struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k, int specified);
 void avtab_destroy(struct avtab *h);
-int avtab_map(struct avtab *h,
-	      int (*apply) (struct avtab_key *k,
-			    struct avtab_datum *d,
-			    void *args),
-	      void *args);
 void avtab_hash_eval(struct avtab *h, char *tag);
 
 int avtab_read_item(void *fp, struct avtab_datum *avdatum, struct avtab_key *avkey);
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/conditional.c linux-2.6.11-mm3-adrian/security/selinux/ss/conditional.c
--- linux-2.6.11-mm3/security/selinux/ss/conditional.c	2005-03-02 02:37:49.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/conditional.c	2005-03-14 14:08:28.000000000 -0500
@@ -208,7 +208,7 @@ int cond_index_bool(void *key, void *dat
 	return 0;
 }
 
-int bool_isvalid(struct cond_bool_datum *b)
+static int bool_isvalid(struct cond_bool_datum *b)
 {
 	if (!(b->state == 0 || b->state == 1))
 		return 0;
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/ebitmap.c linux-2.6.11-mm3-adrian/security/selinux/ss/ebitmap.c
--- linux-2.6.11-mm3/security/selinux/ss/ebitmap.c	2005-03-02 02:38:38.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/ebitmap.c	2005-03-14 14:08:28.000000000 -0500
@@ -9,49 +9,6 @@
 #include "ebitmap.h"
 #include "policydb.h"
 
-int ebitmap_or(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2)
-{
-	struct ebitmap_node *n1, *n2, *new, *prev;
-
-	ebitmap_init(dst);
-
-	n1 = e1->node;
-	n2 = e2->node;
-	prev = NULL;
-	while (n1 || n2) {
-		new = kmalloc(sizeof(*new), GFP_ATOMIC);
-		if (!new) {
-			ebitmap_destroy(dst);
-			return -ENOMEM;
-		}
-		memset(new, 0, sizeof(*new));
-		if (n1 && n2 && n1->startbit == n2->startbit) {
-			new->startbit = n1->startbit;
-			new->map = n1->map | n2->map;
-			n1 = n1->next;
-			n2 = n2->next;
-		} else if (!n2 || (n1 && n1->startbit < n2->startbit)) {
-			new->startbit = n1->startbit;
-			new->map = n1->map;
-			n1 = n1->next;
-		} else {
-			new->startbit = n2->startbit;
-			new->map = n2->map;
-			n2 = n2->next;
-		}
-
-		new->next = NULL;
-		if (prev)
-			prev->next = new;
-		else
-			dst->node = new;
-		prev = new;
-	}
-
-	dst->highbit = (e1->highbit > e2->highbit) ? e1->highbit : e2->highbit;
-	return 0;
-}
-
 int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
 {
 	struct ebitmap_node *n1, *n2;
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/ebitmap.h linux-2.6.11-mm3-adrian/security/selinux/ss/ebitmap.h
--- linux-2.6.11-mm3/security/selinux/ss/ebitmap.h	2005-03-02 02:38:08.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/ebitmap.h	2005-03-14 14:08:28.000000000 -0500
@@ -38,7 +38,6 @@ static inline void ebitmap_init(struct e
 }
 
 int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
-int ebitmap_or(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
 int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2);
 int ebitmap_get_bit(struct ebitmap *e, unsigned long bit);
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/hashtab.c linux-2.6.11-mm3-adrian/security/selinux/ss/hashtab.c
--- linux-2.6.11-mm3/security/selinux/ss/hashtab.c	2005-03-02 02:38:26.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/hashtab.c	2005-03-14 14:08:28.000000000 -0500
@@ -73,81 +73,6 @@ int hashtab_insert(struct hashtab *h, vo
 	return 0;
 }
 
-int hashtab_remove(struct hashtab *h, void *key,
-		   void (*destroy)(void *k, void *d, void *args),
-		   void *args)
-{
-	u32 hvalue;
-	struct hashtab_node *cur, *last;
-
-	if (!h)
-		return -EINVAL;
-
-	hvalue = h->hash_value(h, key);
-	last = NULL;
-	cur = h->htable[hvalue];
-	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
-		last = cur;
-		cur = cur->next;
-	}
-
-	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
-		return -ENOENT;
-
-	if (last == NULL)
-		h->htable[hvalue] = cur->next;
-	else
-		last->next = cur->next;
-
-	if (destroy)
-		destroy(cur->key, cur->datum, args);
-	kfree(cur);
-	h->nel--;
-	return 0;
-}
-
-int hashtab_replace(struct hashtab *h, void *key, void *datum,
-		    void (*destroy)(void *k, void *d, void *args),
-		    void *args)
-{
-	u32 hvalue;
-	struct hashtab_node *prev, *cur, *newnode;
-
-	if (!h)
-		return -EINVAL;
-
-	hvalue = h->hash_value(h, key);
-	prev = NULL;
-	cur = h->htable[hvalue];
-	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
-		prev = cur;
-		cur = cur->next;
-	}
-
-	if (cur && (h->keycmp(h, key, cur->key) == 0)) {
-		if (destroy)
-			destroy(cur->key, cur->datum, args);
-		cur->key = key;
-		cur->datum = datum;
-	} else {
-		newnode = kmalloc(sizeof(*newnode), GFP_KERNEL);
-		if (newnode == NULL)
-			return -ENOMEM;
-		memset(newnode, 0, sizeof(*newnode));
-		newnode->key = key;
-		newnode->datum = datum;
-		if (prev) {
-			newnode->next = prev->next;
-			prev->next = newnode;
-		} else {
-			newnode->next = h->htable[hvalue];
-			h->htable[hvalue] = newnode;
-		}
-	}
-
-	return 0;
-}
-
 void *hashtab_search(struct hashtab *h, void *key)
 {
 	u32 hvalue;
@@ -215,44 +140,6 @@ int hashtab_map(struct hashtab *h,
 }
 
 
-void hashtab_map_remove_on_error(struct hashtab *h,
-                                 int (*apply)(void *k, void *d, void *args),
-                                 void (*destroy)(void *k, void *d, void *args),
-                                 void *args)
-{
-	u32 i;
-	int ret;
-	struct hashtab_node *last, *cur, *temp;
-
-	if (!h)
-		return;
-
-	for (i = 0; i < h->size; i++) {
-		last = NULL;
-		cur = h->htable[i];
-		while (cur != NULL) {
-			ret = apply(cur->key, cur->datum, args);
-			if (ret) {
-				if (last)
-					last->next = cur->next;
-				else
-					h->htable[i] = cur->next;
-
-				temp = cur;
-				cur = cur->next;
-				if (destroy)
-					destroy(temp->key, temp->datum, args);
-				kfree(temp);
-				h->nel--;
-			} else {
-				last = cur;
-				cur = cur->next;
-			}
-		}
-	}
-	return;
-}
-
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 {
 	u32 i, chain_len, slots_used, max_chain_len;
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/hashtab.h linux-2.6.11-mm3-adrian/security/selinux/ss/hashtab.h
--- linux-2.6.11-mm3/security/selinux/ss/hashtab.h	2005-03-02 02:38:12.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/hashtab.h	2005-03-14 14:08:28.000000000 -0500
@@ -54,33 +54,6 @@ struct hashtab *hashtab_create(u32 (*has
 int hashtab_insert(struct hashtab *h, void *k, void *d);
 
 /*
- * Removes the entry with the specified key from the hash table.
- * Applies the specified destroy function to (key,datum,args) for
- * the entry.
- *
- * Returns -ENOENT if no entry has the specified key,
- * -EINVAL for general errors or
- *0 otherwise.
- */
-int hashtab_remove(struct hashtab *h, void *k,
-		   void (*destroy)(void *k, void *d, void *args),
-		   void *args);
-
-/*
- * Insert or replace the specified (key, datum) pair in the specified
- * hash table.  If an entry for the specified key already exists,
- * then the specified destroy function is applied to (key,datum,args)
- * for the entry prior to replacing the entry's contents.
- *
- * Returns -ENOMEM if insufficient space is available,
- * -EINVAL for general errors or
- * 0 otherwise.
- */
-int hashtab_replace(struct hashtab *h, void *k, void *d,
-		    void (*destroy)(void *k, void *d, void *args),
-		    void *args);
-
-/*
  * Searches for the entry with the specified key in the hash table.
  *
  * Returns NULL if no entry has the specified key or
@@ -108,17 +81,6 @@ int hashtab_map(struct hashtab *h,
 		int (*apply)(void *k, void *d, void *args),
 		void *args);
 
-/*
- * Same as hashtab_map, except that if apply returns a non-zero status,
- * then the (key,datum) pair will be removed from the hashtab and the
- * destroy function will be applied to (key,datum,args).
- */
-void hashtab_map_remove_on_error(struct hashtab *h,
-                                 int (*apply)(void *k, void *d, void *args),
-                                 void (*destroy)(void *k, void *d, void *args),
-                                 void *args);
-
-
 /* Fill info with some hash table statistics */
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
 
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/policydb.c linux-2.6.11-mm3-adrian/security/selinux/ss/policydb.c
--- linux-2.6.11-mm3/security/selinux/ss/policydb.c	2005-03-14 13:56:06.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/policydb.c	2005-03-14 14:08:28.000000000 -0500
@@ -110,7 +110,7 @@ static struct policydb_compat_info *poli
 /*
  * Initialize the role table.
  */
-int roles_init(struct policydb *p)
+static int roles_init(struct policydb *p)
 {
 	char *key = NULL;
 	int rc;
@@ -149,7 +149,7 @@ out_free_role:
 /*
  * Initialize a policy database structure.
  */
-int policydb_init(struct policydb *p)
+static int policydb_init(struct policydb *p)
 {
 	int i, rc;
 
@@ -321,7 +321,7 @@ static int (*index_f[SYM_NUM]) (void *ke
  *
  * Caller must clean up upon failure.
  */
-int policydb_index_classes(struct policydb *p)
+static int policydb_index_classes(struct policydb *p)
 {
 	int rc;
 
@@ -378,7 +378,7 @@ static void symtab_hash_eval(struct symt
  *
  * Caller must clean up on failure.
  */
-int policydb_index_others(struct policydb *p)
+static int policydb_index_others(struct policydb *p)
 {
 	int i, rc = 0;
 
@@ -566,7 +566,7 @@ static int (*destroy_f[SYM_NUM]) (void *
 	cat_destroy,
 };
 
-void ocontext_destroy(struct ocontext *c, int i)
+static void ocontext_destroy(struct ocontext *c, int i)
 {
 	context_destroy(&c->context[0]);
 	context_destroy(&c->context[1]);
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/policydb.h linux-2.6.11-mm3-adrian/security/selinux/ss/policydb.h
--- linux-2.6.11-mm3/security/selinux/ss/policydb.h	2005-03-14 13:56:06.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/policydb.h	2005-03-14 14:08:28.000000000 -0500
@@ -240,9 +240,6 @@ struct policydb {
 	unsigned int policyvers;
 };
 
-extern int policydb_init(struct policydb *p);
-extern int policydb_index_classes(struct policydb *p);
-extern int policydb_index_others(struct policydb *p);
 extern void policydb_destroy(struct policydb *p);
 extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern int policydb_context_isvalid(struct policydb *p, struct context *c);
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/services.c linux-2.6.11-mm3-adrian/security/selinux/ss/services.c
--- linux-2.6.11-mm3/security/selinux/ss/services.c	2005-03-14 13:56:06.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/services.c	2005-03-14 14:08:28.000000000 -0500
@@ -52,7 +52,7 @@ static DECLARE_MUTEX(load_sem);
 #define LOAD_LOCK down(&load_sem)
 #define LOAD_UNLOCK up(&load_sem)
 
-struct sidtab sidtab;
+static struct sidtab sidtab;
 struct policydb policydb;
 int ss_initialized = 0;
 
@@ -64,9 +64,9 @@ int ss_initialized = 0;
  */
 static u32 latest_granting = 0;
 
-/* Forward declarations. */
-int context_struct_to_string(struct context *context, char **scontext,
-                             u32 *scontext_len);
+/* Forward declaration. */
+static int context_struct_to_string(struct context *context, char **scontext,
+				    u32 *scontext_len);
 
 /*
  * Return the boolean value of a constraint expression
@@ -79,10 +79,10 @@ int context_struct_to_string(struct cont
  * of the process performing the transition.  All other callers of
  * constraint_expr_eval should pass in NULL for xcontext.
  */
-int constraint_expr_eval(struct context *scontext,
-                         struct context *tcontext,
-                         struct context *xcontext,
-                         struct constraint_expr *cexpr)
+static int constraint_expr_eval(struct context *scontext,
+				struct context *tcontext,
+				struct context *xcontext,
+				struct constraint_expr *cexpr)
 {
 	u32 val1, val2;
 	struct context *c;
@@ -515,7 +515,7 @@ out:
  * to point to this string and set `*scontext_len' to
  * the length of the string.
  */
-int context_struct_to_string(struct context *context, char **scontext, u32 *scontext_len)
+static int context_struct_to_string(struct context *context, char **scontext, u32 *scontext_len)
 {
 	char *scontextp;
 
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/services.h linux-2.6.11-mm3-adrian/security/selinux/ss/services.h
--- linux-2.6.11-mm3/security/selinux/ss/services.h	2005-03-02 02:37:49.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/services.h	2005-03-14 14:08:28.000000000 -0500
@@ -9,12 +9,6 @@
 #include "policydb.h"
 #include "sidtab.h"
 
-/*
- * The security server uses two global data structures
- * when providing its services:  the SID table (sidtab)
- * and the policy database (policydb).
- */
-extern struct sidtab sidtab;
 extern struct policydb policydb;
 
 #endif	/* _SS_SERVICES_H_ */
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm3/security/selinux/ss/sidtab.c linux-2.6.11-mm3-adrian/security/selinux/ss/sidtab.c
--- linux-2.6.11-mm3/security/selinux/ss/sidtab.c	2005-03-02 02:38:12.000000000 -0500
+++ linux-2.6.11-mm3-adrian/security/selinux/ss/sidtab.c	2005-03-14 14:08:28.000000000 -0500
@@ -87,42 +87,6 @@ out:
 	return rc;
 }
 
-int sidtab_remove(struct sidtab *s, u32 sid)
-{
-	int hvalue, rc = 0;
-	struct sidtab_node *cur, *last;
-
-	if (!s) {
-		rc = -ENOENT;
-		goto out;
-	}
-
-	hvalue = SIDTAB_HASH(sid);
-	last = NULL;
-	cur = s->htable[hvalue];
-	while (cur != NULL && sid > cur->sid) {
-		last = cur;
-		cur = cur->next;
-	}
-
-	if (cur == NULL || sid != cur->sid) {
-		rc = -ENOENT;
-		goto out;
-	}
-
-	if (last == NULL)
-		s->htable[hvalue] = cur->next;
-	else
-		last->next = cur->next;
-
-	context_destroy(&cur->context);
-
-	kfree(cur);
-	s->nel--;
-out:
-	return rc;
-}
-
 struct context *sidtab_search(struct sidtab *s, u32 sid)
 {
 	int hvalue;




