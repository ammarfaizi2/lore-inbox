Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbUK1TDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUK1TDE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 14:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbUK1TDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 14:03:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18960 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261567AbUK1TBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 14:01:41 -0500
Date: Sun, 28 Nov 2004 20:01:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: sds@epoch.ncsc.mil, jmorris@redhat.com
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [2.6 patch] selinux: possible cleanups
Message-ID: <20041128190139.GD4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups:
- make needlessly global code static
- remove the following unused global functions:
  - avc.c: avc_ss_grant
  - avc.c: avc_ss_try_revoke
  - avc.c: avc_ss_revoke
  - avc.c: avc_ss_set_auditallow
  - avc.c: avc_ss_set_auditdeny
  - ss/avtab.c: avtab_map
  - ss/ebitmap.c: ebitmap_or
  - ss/hashtab.c: hashtab_remove
  - ss/hashtab.c: hashtab_replace
  - ss/hashtab.c: hashtab_map_remove_on_error
  - ss/services.c: security_member_sid
  - ss/sidtab.c: sidtab_remove
- remove the following unused static functions:
  - avc.c: avc_update_cache
  - avc.c: avc_control


Please review and comment on which of these changes are correct and 
which conflict with pending patches for in-kernel users of the functions 
affected.


diffstat output:
 security/selinux/avc.c              |  174 ----------------------------
 security/selinux/hooks.c            |   40 +++---
 security/selinux/include/avc.h      |    7 -
 security/selinux/include/avc_ss.h   |   13 --
 security/selinux/include/objsec.h   |    2 
 security/selinux/include/security.h |    3 
 security/selinux/selinuxfs.c        |    4 
 security/selinux/ss/avtab.c         |   27 ----
 security/selinux/ss/avtab.h         |    6 
 security/selinux/ss/conditional.c   |    2 
 security/selinux/ss/ebitmap.c       |   43 ------
 security/selinux/ss/ebitmap.h       |    1 
 security/selinux/ss/hashtab.c       |  113 ------------------
 security/selinux/ss/hashtab.h       |   38 ------
 security/selinux/ss/mls.c           |    2 
 security/selinux/ss/policydb.c      |   10 -
 security/selinux/ss/policydb.h      |    3 
 security/selinux/ss/services.c      |   23 ---
 security/selinux/ss/sidtab.c        |   36 -----
 19 files changed, 34 insertions(+), 513 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/security/selinux/include/avc.h.old	2004-11-28 03:06:40.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/include/avc.h	2004-11-28 04:04:11.000000000 +0100
@@ -93,13 +93,6 @@
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
 
--- linux-2.6.10-rc2-mm3-full/security/selinux/include/avc_ss.h.old	2004-11-28 03:08:01.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/include/avc_ss.h	2004-11-28 04:04:11.000000000 +0100
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
 
--- linux-2.6.10-rc2-mm3-full/security/selinux/avc.c.old	2004-11-28 03:06:55.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/avc.c	2004-11-28 04:04:11.000000000 +0100
@@ -108,7 +108,7 @@
  * @tclass: target security class
  * @av: access vector
  */
-void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
+static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
 {
 	char **common_pts = NULL;
 	u32 common_base = 0;
@@ -161,7 +161,7 @@
  * @tsid: target security identifier
  * @tclass: target security class
  */
-void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tclass)
+static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tclass)
 {
 	int rc;
 	char *scontext;
@@ -779,136 +779,6 @@
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
@@ -942,46 +812,6 @@
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
--- linux-2.6.10-rc2-mm3-full/security/selinux/hooks.c.old	2004-11-28 03:09:58.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/hooks.c	2004-11-28 04:04:11.000000000 +0100
@@ -927,9 +927,9 @@
 
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
 
@@ -940,8 +940,8 @@
 }
 
 /* Check whether a task is allowed to use a capability. */
-int task_has_capability(struct task_struct *tsk,
-			int cap)
+static int task_has_capability(struct task_struct *tsk,
+			       int cap)
 {
 	struct task_security_struct *tsec;
 	struct avc_audit_data ad;
@@ -957,8 +957,8 @@
 }
 
 /* Check whether a task is allowed to use a system operation. */
-int task_has_system(struct task_struct *tsk,
-		    u32 perms)
+static int task_has_system(struct task_struct *tsk,
+			   u32 perms)
 {
 	struct task_security_struct *tsec;
 
@@ -971,10 +971,10 @@
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
@@ -1196,10 +1196,10 @@
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
@@ -1256,7 +1256,7 @@
 }
 
 /* Set an inode's SID to a specified value. */
-int inode_security_set_sid(struct inode *inode, u32 sid)
+static int inode_security_set_sid(struct inode *inode, u32 sid)
 {
 	struct inode_security_struct *isec = inode->i_security;
 	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
@@ -4024,7 +4024,7 @@
 }
 
 /* module stacking operations */
-int selinux_register_security (const char *name, struct security_operations *ops)
+static int selinux_register_security (const char *name, struct security_operations *ops)
 {
 	if (secondary_ops != original_ops) {
 		printk(KERN_INFO "%s:  There is already a secondary security "
@@ -4041,7 +4041,7 @@
 	return 0;
 }
 
-int selinux_unregister_security (const char *name, struct security_operations *ops)
+static int selinux_unregister_security (const char *name, struct security_operations *ops)
 {
 	if (ops != secondary_ops) {
 		printk (KERN_INFO "%s:  trying to unregister a security module "
@@ -4158,7 +4158,7 @@
 	return size;
 }
 
-struct security_operations selinux_ops = {
+static struct security_operations selinux_ops = {
 	.ptrace =			selinux_ptrace,
 	.capget =			selinux_capget,
 	.capset_check =			selinux_capset_check,
@@ -4307,7 +4307,7 @@
 #endif
 };
 
-__init int selinux_init(void)
+static __init int selinux_init(void)
 {
 	struct task_security_struct *tsec;
 
--- linux-2.6.10-rc2-mm3-full/security/selinux/include/objsec.h.old	2004-11-28 03:10:31.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/include/objsec.h	2004-11-28 04:04:11.000000000 +0100
@@ -101,6 +101,4 @@
 	u32 peer_sid;			/* SID of peer */
 };
 
-extern int inode_security_set_sid(struct inode *inode, u32 sid);
-
 #endif /* _SELINUX_OBJSEC_H_ */
--- linux-2.6.10-rc2-mm3-full/security/selinux/selinuxfs.c.old	2004-11-28 03:13:22.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/selinuxfs.c	2004-11-28 04:04:11.000000000 +0100
@@ -44,8 +44,8 @@
 extern void selnl_notify_setenforce(int val);
 
 /* Check whether a task is allowed to use a security operation. */
-int task_has_security(struct task_struct *tsk,
-		      u32 perms)
+static int task_has_security(struct task_struct *tsk,
+			     u32 perms)
 {
 	struct task_security_struct *tsec;
 
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/avtab.h.old	2004-11-28 03:14:10.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/avtab.h	2004-11-28 04:04:11.000000000 +0100
@@ -58,14 +58,8 @@
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
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/avtab.c.old	2004-11-28 03:14:24.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/avtab.c	2004-11-28 04:04:11.000000000 +0100
@@ -31,7 +31,8 @@
 static kmem_cache_t *avtab_node_cachep;
 
 static struct avtab_node*
-avtab_insert_node(struct avtab *h, int hvalue, struct avtab_node * prev, struct avtab_node * cur,
+avtab_insert_node(struct avtab *h, int hvalue,
+		  struct avtab_node * prev, struct avtab_node * cur,
 		  struct avtab_key *key, struct avtab_datum *datum)
 {
 	struct avtab_node * newnode;
@@ -237,30 +238,6 @@
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
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/conditional.c.old	2004-11-28 03:15:23.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/conditional.c	2004-11-28 04:04:11.000000000 +0100
@@ -208,7 +208,7 @@
 	return 0;
 }
 
-int bool_isvalid(struct cond_bool_datum *b)
+static int bool_isvalid(struct cond_bool_datum *b)
 {
 	if (!(b->state == 0 || b->state == 1))
 		return 0;
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/ebitmap.h.old	2004-11-28 03:15:44.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/ebitmap.h	2004-11-28 04:04:11.000000000 +0100
@@ -38,7 +38,6 @@
 }
 
 int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
-int ebitmap_or(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
 int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2);
 int ebitmap_get_bit(struct ebitmap *e, unsigned long bit);
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/ebitmap.c.old	2004-11-28 03:16:31.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/ebitmap.c	2004-11-28 04:04:11.000000000 +0100
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
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/hashtab.h.old	2004-11-28 03:16:45.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/hashtab.h	2004-11-28 04:04:11.000000000 +0100
@@ -54,33 +54,6 @@
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
@@ -108,17 +81,6 @@
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
 
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/hashtab.c.old	2004-11-28 03:17:07.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/hashtab.c	2004-11-28 04:04:11.000000000 +0100
@@ -73,81 +73,6 @@
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
@@ -215,44 +140,6 @@
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
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/mls.c.old	2004-11-28 03:18:38.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/mls.c	2004-11-28 04:04:11.000000000 +0100
@@ -415,7 +415,7 @@
  * Read a MLS level structure from a policydb binary
  * representation file.
  */
-struct mls_level *mls_read_level(void *fp)
+static struct mls_level *mls_read_level(void *fp)
 {
 	struct mls_level *l;
 	u32 *buf;
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/policydb.c.old	2004-11-28 03:19:05.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/policydb.c	2004-11-28 04:04:11.000000000 +0100
@@ -97,7 +97,7 @@
 /*
  * Initialize the role table.
  */
-int roles_init(struct policydb *p)
+static int roles_init(struct policydb *p)
 {
 	char *key = NULL;
 	int rc;
@@ -136,7 +136,7 @@
 /*
  * Initialize a policy database structure.
  */
-int policydb_init(struct policydb *p)
+static int policydb_init(struct policydb *p)
 {
 	int i, rc;
 
@@ -272,7 +272,7 @@
  *
  * Caller must clean up upon failure.
  */
-int policydb_index_classes(struct policydb *p)
+static int policydb_index_classes(struct policydb *p)
 {
 	int rc;
 
@@ -329,7 +329,7 @@
  *
  * Caller must clean up on failure.
  */
-int policydb_index_others(struct policydb *p)
+static int policydb_index_others(struct policydb *p)
 {
 	int i, rc = 0;
 
@@ -478,7 +478,7 @@
 	cond_destroy_bool
 };
 
-void ocontext_destroy(struct ocontext *c, int i)
+static void ocontext_destroy(struct ocontext *c, int i)
 {
 	context_destroy(&c->context[0]);
 	context_destroy(&c->context[1]);
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/policydb.h.old	2004-11-28 03:19:29.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/policydb.h	2004-11-28 04:04:11.000000000 +0100
@@ -248,9 +248,6 @@
 #endif
 };
 
-extern int policydb_init(struct policydb *p);
-extern int policydb_index_classes(struct policydb *p);
-extern int policydb_index_others(struct policydb *p);
 extern void policydb_destroy(struct policydb *p);
 extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern int policydb_context_isvalid(struct policydb *p, struct context *c);
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/services.c.old	2004-11-28 04:04:41.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/services.c	2004-11-28 04:05:59.000000000 +0100
@@ -351,7 +351,7 @@
  * to point to this string and set `*scontext_len' to
  * the length of the string.
  */
-int context_struct_to_string(struct context *context, char **scontext, u32 *scontext_len)
+static int context_struct_to_string(struct context *context, char **scontext, u32 *scontext_len)
 {
 	char *scontextp;
 
@@ -780,27 +780,6 @@
 }
 
 /**
- * security_member_sid - Compute the SID for member selection.
- * @ssid: source security identifier
- * @tsid: target security identifier
- * @tclass: target security class
- * @out_sid: security identifier for selected member
- *
- * Compute a SID to use when selecting a member of a polyinstantiated
- * object of class @tclass based on a SID pair (@ssid, @tsid).
- * Return -%EINVAL if any of the parameters are invalid, -%ENOMEM
- * if insufficient memory is available, or %0 if the SID was
- * computed successfully.
- */
-int security_member_sid(u32 ssid,
-			u32 tsid,
-			u16 tclass,
-			u32 *out_sid)
-{
-	return security_compute_sid(ssid, tsid, tclass, AVTAB_MEMBER, out_sid);
-}
-
-/**
  * security_change_sid - Compute the SID for object relabeling.
  * @ssid: source security identifier
  * @tsid: target security identifier
--- linux-2.6.10-rc2-mm3-full/security/selinux/include/security.h.old	2004-11-28 03:22:15.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/include/security.h	2004-11-28 04:04:11.000000000 +0100
@@ -55,9 +55,6 @@
 int security_transition_sid(u32 ssid, u32 tsid,
 	u16 tclass, u32 *out_sid);
 
-int security_member_sid(u32 ssid, u32 tsid,
-	u16 tclass, u32 *out_sid);
-
 int security_change_sid(u32 ssid, u32 tsid,
 	u16 tclass, u32 *out_sid);
 
--- linux-2.6.10-rc2-mm3-full/security/selinux/ss/sidtab.c.old	2004-11-28 03:24:46.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/security/selinux/ss/sidtab.c	2004-11-28 04:04:11.000000000 +0100
@@ -87,42 +87,6 @@
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



