Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSHFWry>; Tue, 6 Aug 2002 18:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSHFWry>; Tue, 6 Aug 2002 18:47:54 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:36362 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316289AbSHFWru>; Tue, 6 Aug 2002 18:47:50 -0400
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] module cleanup (1/5)
Message-Id: <E17cDAk-0002ur-00@scrub.xs4all.nl>
From: Roman Zippel <zippel@linux-m68k.org>
Date: Wed, 07 Aug 2002 00:51:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch replaces get_mod_name/put_mod_name with getname/putname.

diff -ur linux-2.5/kernel/module.c linux-mod/kernel/module.c
--- linux-2.5/kernel/module.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/kernel/module.c	Thu Aug  1 14:35:31 2002
@@ -235,8 +235,6 @@
 
 #if defined(CONFIG_MODULES)	/* The rest of the source */
 
-static long get_mod_name(const char *user_name, char **buf);
-static void put_mod_name(char *buf);
 struct module *find_module(const char *name);
 void free_module(struct module *, int tag_freed);
 
@@ -253,40 +251,6 @@
 }
 
 /*
- * Copy the name of a module from user space.
- */
-
-static inline long
-get_mod_name(const char *user_name, char **buf)
-{
-	unsigned long page;
-	long retval;
-
-	page = __get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	retval = strncpy_from_user((char *)page, user_name, PAGE_SIZE);
-	if (retval > 0) {
-		if (retval < PAGE_SIZE) {
-			*buf = (char *)page;
-			return retval;
-		}
-		retval = -ENAMETOOLONG;
-	} else if (!retval)
-		retval = -EINVAL;
-
-	free_page(page);
-	return retval;
-}
-
-static inline void
-put_mod_name(char *buf)
-{
-	free_page((unsigned long)buf);
-}
-
-/*
  * Allocate space for a module.
  */
 
@@ -301,10 +265,12 @@
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
 	lock_kernel();
-	if ((namelen = get_mod_name(name_user, &name)) < 0) {
-		error = namelen;
+	name = getname(name_user);
+	if (IS_ERR(name)) {
+		error = PTR_ERR(name);
 		goto err0;
 	}
+	namelen = strlen(name);
 	if (size < sizeof(struct module)+namelen) {
 		error = -EINVAL;
 		goto err1;
@@ -324,7 +290,7 @@
 	mod->size = size;
 	memcpy((char*)(mod+1), name, namelen+1);
 
-	put_mod_name(name);
+	putname(name);
 
 	spin_lock_irqsave(&modlist_lock, flags);
 	mod->next = module_list;
@@ -334,7 +300,7 @@
 	error = (long) mod;
 	goto err0;
 err1:
-	put_mod_name(name);
+	putname(name);
 err0:
 	unlock_kernel();
 	return error;
@@ -356,10 +322,12 @@
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
 	lock_kernel();
-	if ((namelen = get_mod_name(name_user, &name)) < 0) {
-		error = namelen;
+	name = getname(name_user);
+	if (IS_ERR(name)) {
+		error = PTR_ERR(name);
 		goto err0;
 	}
+	namelen = strlen(name);
 	if ((mod = find_module(name)) == NULL) {
 		error = -ENOENT;
 		goto err1;
@@ -477,13 +445,14 @@
 
 	/* Check that the user isn't doing something silly with the name.  */
 
-	if ((n_namelen = get_mod_name(mod->name - (unsigned long)mod
-				      + (unsigned long)mod_user,
-				      &n_name)) < 0) {
-		printk(KERN_ERR "init_module: get_mod_name failure.\n");
-		error = n_namelen;
+	n_name = getname(mod->name - (unsigned long)mod
+			 + (unsigned long)mod_user);
+	if (IS_ERR(n_name)) {
+		printk(KERN_ERR "init_module: getname failure.\n");
+		error = PTR_ERR(n_name);
 		goto err2;
 	}
+	n_namelen = strlen(n_name);
 	if (namelen != n_namelen || strcmp(n_name, mod_tmp.name) != 0) {
 		printk(KERN_ERR "init_module: changed module name to "
 				"`%s' from `%s'\n",
@@ -545,8 +514,8 @@
 	}
 
 	/* Free our temporary memory.  */
-	put_mod_name(n_name);
-	put_mod_name(name);
+	putname(n_name);
+	putname(name);
 
 	/* Initialize the module.  */
 	atomic_set(&mod->uc.usecount,1);
@@ -566,12 +535,12 @@
 	goto err0;
 
 err3:
-	put_mod_name(n_name);
+	putname(n_name);
 err2:
 	*mod = mod_tmp;
 	strcpy((char *)mod->name, name_tmp);	/* We know there is room for this */
 err1:
-	put_mod_name(name);
+	putname(name);
 err0:
 	unlock_kernel();
 	kfree(name_tmp);
@@ -606,14 +575,17 @@
 
 	lock_kernel();
 	if (name_user) {
-		if ((error = get_mod_name(name_user, &name)) < 0)
+		name = getname(name_user);
+		if (IS_ERR(name)) {
+			error = PTR_ERR(name);
 			goto out;
+		}
 		error = -ENOENT;
 		if ((mod = find_module(name)) == NULL) {
-			put_mod_name(name);
+			putname(name);
 			goto out;
 		}
-		put_mod_name(name);
+		putname(name);
 		error = -EBUSY;
 		if (mod->refs != NULL)
 			goto out;
@@ -896,16 +842,18 @@
 		long namelen;
 		char *name;
 
-		if ((namelen = get_mod_name(name_user, &name)) < 0) {
-			err = namelen;
+		name = getname(name_user);
+		if (IS_ERR(name)) {
+			err = PTR_ERR(name);
 			goto out;
 		}
+		namelen = strlen(name);
 		err = -ENOENT;
 		if ((mod = find_module(name)) == NULL) {
-			put_mod_name(name);
+			putname(name);
 			goto out;
 		}
-		put_mod_name(name);
+		putname(name);
 	}
 
 	/* __MOD_ touches the flags. We must avoid that */
