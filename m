Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVCVU4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVCVU4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVCVU4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:56:11 -0500
Received: from mail.dif.dk ([193.138.115.101]:951 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261759AbVCVUzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:55:45 -0500
Date: Tue, 22 Mar 2005 21:57:26 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>, Chris Vance <cvance@nai.com>,
       Wayne Salamon <wsalamon@nai.com>, James Morris <jmorris@redhat.com>,
       dgoeddel@trustedcs.com, Karl MacMillan <kmacmillan@tresys.com>,
       Frank Mayer <mayerf@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] don't do pointless NULL checks and casts before kfree()
 in security/selinux/
In-Reply-To: <1111503629.15346.72.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.62.0503222150210.2683@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503201316270.2501@dragon.hyggekrogen.localhost>
 <1111503629.15346.72.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, as pr Stephen's comment below I'm sending you a diff that's a 
subset of the kfree() fixes i did for security/ earlier. The patch below 
contains only the bits from security/selinux/ that Stephen ACK'ed - 
re-diff'ed against 2.6.12-rc1-mm1.

Please consider applying.

On Tue, 22 Mar 2005, Stephen Smalley wrote:

> On Sun, 2005-03-20 at 13:29 +0100, Jesper Juhl wrote:
> > kfree() handles NULL pointers, so checking a pointer for NULL before 
> > calling kfree() on it is pointless. kfree() takes a void* argument and 
> > changing the type of a pointer before kfree()'ing it is equally pointless.
> > This patch removes the pointless checks for NULL and needless mucking 
> > about with the pointer types before kfree() for all files in security/* 
> > where I could locate such code.
> > 
> > The following files are modified by this patch:
[snip]
> > 	security/selinux/hooks.c
> > 	security/selinux/selinuxfs.c
> > 	security/selinux/ss/conditional.c
> > 	security/selinux/ss/policydb.c
> > 	security/selinux/ss/services.c
> > 
> > (please keep me on CC if you reply)
> > 
> > 
> > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> The diffs to selinux look fine to me, and the resulting kernel seems to
> be operating without problem.  Feel free to send along to Andrew Morton.
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

diff -uprN linux-2.6.12-rc1-mm1-orig/security/selinux/hooks.c linux-2.6.12-rc1-mm1/security/selinux/hooks.c
--- linux-2.6.12-rc1-mm1-orig/security/selinux/hooks.c	2005-03-21 23:12:51.000000000 +0100
+++ linux-2.6.12-rc1-mm1/security/selinux/hooks.c	2005-03-22 21:48:29.000000000 +0100
@@ -1663,9 +1663,8 @@ static int selinux_bprm_secureexec (stru
 
 static void selinux_bprm_free_security(struct linux_binprm *bprm)
 {
-	struct bprm_security_struct *bsec = bprm->security;
+	kfree(bprm->security);
 	bprm->security = NULL;
-	kfree(bsec);
 }
 
 extern struct vfsmount *selinuxfs_mount;
diff -uprN linux-2.6.12-rc1-mm1-orig/security/selinux/selinuxfs.c linux-2.6.12-rc1-mm1/security/selinux/selinuxfs.c
--- linux-2.6.12-rc1-mm1-orig/security/selinux/selinuxfs.c	2005-03-21 23:12:51.000000000 +0100
+++ linux-2.6.12-rc1-mm1/security/selinux/selinuxfs.c	2005-03-22 21:48:29.000000000 +0100
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
diff -uprN linux-2.6.12-rc1-mm1-orig/security/selinux/ss/conditional.c linux-2.6.12-rc1-mm1/security/selinux/ss/conditional.c
--- linux-2.6.12-rc1-mm1-orig/security/selinux/ss/conditional.c	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.12-rc1-mm1/security/selinux/ss/conditional.c	2005-03-22 21:48:29.000000000 +0100
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
diff -uprN linux-2.6.12-rc1-mm1-orig/security/selinux/ss/policydb.c linux-2.6.12-rc1-mm1/security/selinux/ss/policydb.c
--- linux-2.6.12-rc1-mm1-orig/security/selinux/ss/policydb.c	2005-03-21 23:12:51.000000000 +0100
+++ linux-2.6.12-rc1-mm1/security/selinux/ss/policydb.c	2005-03-22 21:48:29.000000000 +0100
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
 
diff -uprN linux-2.6.12-rc1-mm1-orig/security/selinux/ss/services.c linux-2.6.12-rc1-mm1/security/selinux/ss/services.c
--- linux-2.6.12-rc1-mm1-orig/security/selinux/ss/services.c	2005-03-21 23:12:51.000000000 +0100
+++ linux-2.6.12-rc1-mm1/security/selinux/ss/services.c	2005-03-22 21:48:29.000000000 +0100
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
 



