Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266104AbUBKVTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 16:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266134AbUBKVTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 16:19:22 -0500
Received: from [144.51.25.10] ([144.51.25.10]:19176 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S266104AbUBKVTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 16:19:18 -0500
Subject: [patch] [selinux] Fix bugs in policy loading code
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
       Frank Mayer <mayerf@tresys.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1076534324.7560.170.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Wed, 11 Feb 2004 16:18:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.3-rc2 fixes a couple of bugs in the SELinux
policy loading code.  The first bug was reported by Magosanyi Arpad;
kernel panic upon feeding the kernel a policy with an empty avtab due to
cleanup code trying to free the avtab twice.  The other bugs were
reported by Frank Mayer; failure to properly validate certain values
read from the policy.  Please apply.

 security/selinux/ss/avtab.c    |    3 ++-
 security/selinux/ss/policydb.c |   27 +++++++++++++++++++++------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff -X /home/sds/dontdiff -ru linux-2.6.3-rc2/security/selinux/ss/avtab.c linux-2.6.3-rc2-fix/security/selinux/ss/avtab.c
--- linux-2.6.3-rc2/security/selinux/ss/avtab.c	2004-02-03 22:44:05.000000000 -0500
+++ linux-2.6.3-rc2-fix/security/selinux/ss/avtab.c	2004-02-11 14:51:39.881705960 -0500
@@ -98,7 +98,7 @@
 	int i;
 	struct avtab_node *cur, *temp;
 
-	if (!h)
+	if (!h || !h->htable)
 		return;
 
 	for (i = 0; i < AVTAB_SIZE; i++) {
@@ -111,6 +111,7 @@
 		h->htable[i] = NULL;
 	}
 	vfree(h->htable);
+	h->htable = NULL;
 }
 
 
diff -X /home/sds/dontdiff -ru linux-2.6.3-rc2/security/selinux/ss/policydb.c linux-2.6.3-rc2-fix/security/selinux/ss/policydb.c
--- linux-2.6.3-rc2/security/selinux/ss/policydb.c	2004-02-03 22:43:43.000000000 -0500
+++ linux-2.6.3-rc2-fix/security/selinux/ss/policydb.c	2004-02-11 14:51:30.073060064 -0500
@@ -124,6 +124,8 @@
 
 	comdatum = datum;
 	p = datap;
+	if (!comdatum->value || comdatum->value > p->p_commons.nprim)
+		return -EINVAL;
 	p->p_common_val_to_name[comdatum->value - 1] = key;
 	return 0;
 }
@@ -135,6 +137,8 @@
 
 	cladatum = datum;
 	p = datap;
+	if (!cladatum->value || cladatum->value > p->p_classes.nprim)
+		return -EINVAL;
 	p->p_class_val_to_name[cladatum->value - 1] = key;
 	p->class_val_to_struct[cladatum->value - 1] = cladatum;
 	return 0;
@@ -147,6 +151,8 @@
 
 	role = datum;
 	p = datap;
+	if (!role->value || role->value > p->p_roles.nprim)
+		return -EINVAL;
 	p->p_role_val_to_name[role->value - 1] = key;
 	p->role_val_to_struct[role->value - 1] = role;
 	return 0;
@@ -160,8 +166,11 @@
 	typdatum = datum;
 	p = datap;
 
-	if (typdatum->primary)
+	if (typdatum->primary) {
+		if (!typdatum->value || typdatum->value > p->p_types.nprim)
+			return -EINVAL;
 		p->p_type_val_to_name[typdatum->value - 1] = key;
+	}
 
 	return 0;
 }
@@ -173,6 +182,8 @@
 
 	usrdatum = datum;
 	p = datap;
+	if (!usrdatum->value || usrdatum->value > p->p_users.nprim)
+		return -EINVAL;
 	p->p_user_val_to_name[usrdatum->value - 1] = key;
 	p->user_val_to_struct[usrdatum->value - 1] = usrdatum;
 	return 0;
@@ -502,13 +513,19 @@
 	struct role_datum *role;
 	struct user_datum *usrdatum;
 
-	/*
-	 * Role must be authorized for the type.
-	 */
 	if (!c->role || c->role > p->p_roles.nprim)
 		return 0;
 
+	if (!c->user || c->user > p->p_users.nprim)
+		return 0;
+
+	if (!c->type || c->type > p->p_types.nprim)
+		return 0;
+
 	if (c->role != OBJECT_R_VAL) {
+		/*
+		 * Role must be authorized for the type.
+		 */
 		role = p->role_val_to_struct[c->role - 1];
 		if (!ebitmap_get_bit(&role->types,
 				     c->type - 1))
@@ -518,8 +535,6 @@
 		/*
 		 * User must be authorized for the role.
 		 */
-		if (!c->user || c->user > p->p_users.nprim)
-			return 0;
 		usrdatum = p->user_val_to_struct[c->user - 1];
 		if (!usrdatum)
 			return 0;


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

