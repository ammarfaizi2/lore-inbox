Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVCTM2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVCTM2I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 07:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVCTM2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 07:28:08 -0500
Received: from mail.dif.dk ([193.138.115.101]:15787 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261178AbVCTM1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 07:27:46 -0500
Date: Sun, 20 Mar 2005 13:29:24 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Chris Vance <cvance@nai.com>, Wayne Salamon <wsalamon@nai.com>,
       James Morris <jmorris@redhat.com>, dgoeddel@trustedcs.com,
       Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
       selinux@tycho.nsa.gov, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: [PATCH] don't do pointless NULL checks and casts before kfree() in
 security/
Message-ID: <Pine.LNX.4.62.0503201316270.2501@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kfree() handles NULL pointers, so checking a pointer for NULL before 
calling kfree() on it is pointless. kfree() takes a void* argument and 
changing the type of a pointer before kfree()'ing it is equally pointless.
This patch removes the pointless checks for NULL and needless mucking 
about with the pointer types before kfree() for all files in security/* 
where I could locate such code.

The following files are modified by this patch:
	security/keys/key.c
	security/keys/user_defined.c
	security/selinux/hooks.c
	security/selinux/selinuxfs.c
	security/selinux/ss/conditional.c
	security/selinux/ss/policydb.c
	security/selinux/ss/services.c

(please keep me on CC if you reply)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-mm4-orig/security/keys/key.c	2005-03-16 15:45:42.000000000 +0100
+++ linux-2.6.11-mm4/security/keys/key.c	2005-03-20 12:40:19.000000000 +0100
@@ -114,8 +114,7 @@ struct key_user *key_user_lookup(uid_t u
  found:
 	atomic_inc(&user->usage);
 	spin_unlock(&key_user_lock);
-	if (candidate)
-		kfree(candidate);
+	kfree(candidate);
  out:
 	return user;
 
--- linux-2.6.11-mm4-orig/security/keys/user_defined.c	2005-03-16 15:45:42.000000000 +0100
+++ linux-2.6.11-mm4/security/keys/user_defined.c	2005-03-20 12:41:54.000000000 +0100
@@ -182,9 +182,7 @@ static int user_match(const struct key *
  */
 static void user_destroy(struct key *key)
 {
-	struct user_key_payload *upayload = key->payload.data;
-
-	kfree(upayload);
+	kfree(key->payload.data);
 
 } /* end user_destroy() */
 
--- linux-2.6.11-mm4-orig/security/selinux/hooks.c	2005-03-16 15:45:42.000000000 +0100
+++ linux-2.6.11-mm4/security/selinux/hooks.c	2005-03-20 12:44:43.000000000 +0100
@@ -1663,9 +1663,8 @@ static int selinux_bprm_secureexec (stru
 
 static void selinux_bprm_free_security(struct linux_binprm *bprm)
 {
-	struct bprm_security_struct *bsec = bprm->security;
+	kfree(bprm->security);
 	bprm->security = NULL;
-	kfree(bsec);
 }
 
 extern struct vfsmount *selinuxfs_mount;
--- linux-2.6.11-mm4-orig/security/selinux/selinuxfs.c	2005-03-16 15:45:42.000000000 +0100
+++ linux-2.6.11-mm4/security/selinux/selinuxfs.c	2005-03-20 12:46:11.000000000 +0100
@@ -951,8 +951,7 @@ static int sel_make_bools(void)
 	u32 sid;
 
 	/* remove any existing files */
-	if (bool_pending_values)
-		kfree(bool_pending_values);
+	kfree(bool_pending_values);
 
 	sel_remove_bools(dir);
 
@@ -997,10 +996,8 @@ static int sel_make_bools(void)
 out:
 	free_page((unsigned long)page);
 	if (names) {
-		for (i = 0; i < num; i++) {
-			if (names[i])
-				kfree(names[i]);
-		}
+		for (i = 0; i < num; i++)
+			kfree(names[i]);
 		kfree(names);
 	}
 	return ret;
--- linux-2.6.11-mm4-orig/security/selinux/ss/conditional.c	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.11-mm4/security/selinux/ss/conditional.c	2005-03-20 12:47:16.000000000 +0100
@@ -166,16 +166,14 @@ static void cond_list_destroy(struct con
 
 void cond_policydb_destroy(struct policydb *p)
 {
-	if (p->bool_val_to_struct != NULL)
-		kfree(p->bool_val_to_struct);
+	kfree(p->bool_val_to_struct);
 	avtab_destroy(&p->te_cond_avtab);
 	cond_list_destroy(p->cond_list);
 }
 
 int cond_init_bool_indexes(struct policydb *p)
 {
-	if (p->bool_val_to_struct)
-		kfree(p->bool_val_to_struct);
+	kfree(p->bool_val_to_struct);
 	p->bool_val_to_struct = (struct cond_bool_datum**)
 		kmalloc(p->p_bools.nprim * sizeof(struct cond_bool_datum*), GFP_KERNEL);
 	if (!p->bool_val_to_struct)
@@ -185,8 +183,7 @@ int cond_init_bool_indexes(struct policy
 
 int cond_destroy_bool(void *key, void *datum, void *p)
 {
-	if (key)
-		kfree(key);
+	kfree(key);
 	kfree(datum);
 	return 0;
 }
--- linux-2.6.11-mm4-orig/security/selinux/ss/policydb.c	2005-03-16 15:45:42.000000000 +0100
+++ linux-2.6.11-mm4/security/selinux/ss/policydb.c	2005-03-20 12:59:28.000000000 +0100
@@ -590,17 +590,12 @@ void policydb_destroy(struct policydb *p
 		hashtab_destroy(p->symtab[i].table);
 	}
 
-	for (i = 0; i < SYM_NUM; i++) {
-		if (p->sym_val_to_name[i])
-			kfree(p->sym_val_to_name[i]);
-	}
+	for (i = 0; i < SYM_NUM; i++)
+		kfree(p->sym_val_to_name[i]);
 
-	if (p->class_val_to_struct)
-		kfree(p->class_val_to_struct);
-	if (p->role_val_to_struct)
-		kfree(p->role_val_to_struct);
-	if (p->user_val_to_struct)
-		kfree(p->user_val_to_struct);
+	kfree(p->class_val_to_struct);
+	kfree(p->role_val_to_struct);
+	kfree(p->user_val_to_struct);
 
 	avtab_destroy(&p->te_avtab);
 
--- linux-2.6.11-mm4-orig/security/selinux/ss/services.c	2005-03-16 15:45:42.000000000 +0100
+++ linux-2.6.11-mm4/security/selinux/ss/services.c	2005-03-20 13:01:46.000000000 +0100
@@ -1703,11 +1703,9 @@ out:
 err:
 	if (*names) {
 		for (i = 0; i < *len; i++)
-			if ((*names)[i])
-				kfree((*names)[i]);
+			kfree((*names)[i]);
 	}
-	if (*values)
-		kfree(*values);
+	kfree(*values);
 	goto out;
 }
 



