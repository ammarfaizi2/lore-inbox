Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTE0Gzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 02:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTE0Gzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 02:55:45 -0400
Received: from zok.sgi.com ([204.94.215.101]:62874 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262352AbTE0Gzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 02:55:42 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [patch] 2.4.21-rc4 close race between sys_init_module and search_exception_table
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 May 2003 17:08:11 +1000
Message-ID: <28712.1054019291@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copying a module from user space directly into the kernel breaks the
module_list chain for several hundred cycles.  Another cpu can call
search_exception_table() and get an oops because the chain of exception
entries is broken, we do not even find the kernel exception tables!

This race has been there for a _long_ time, since at least 2.2.0.  It
was found by SGI QE stress tests, doing repeated module load and unload.

Patch is against 2.4.21-rc4, it fits 2.4.20 with offsets.


Index: 21-rc4.1/kernel/module.c
--- 21-rc4.1/kernel/module.c Wed, 11 Dec 2002 11:38:55 +1100 kaos (linux-2.4/j/45_module.c 1.1.2.1.3.1.3.1.1.1.2.2 644)
+++ 21-rc4.1(w)/kernel/module.c Tue, 27 May 2003 16:54:55 +1000 kaos (linux-2.4/j/45_module.c 1.1.2.1.3.1.3.1.1.1.2.2 644)
@@ -345,10 +345,10 @@ err0:
 asmlinkage long
 sys_init_module(const char *name_user, struct module *mod_user)
 {
-	struct module mod_tmp, *mod;
+	struct module mod_tmp, *mod, *mod2 = NULL;
 	char *name, *n_name, *name_tmp = NULL;
 	long namelen, n_namelen, i, error;
-	unsigned long mod_user_size;
+	unsigned long mod_user_size, flags;
 	struct module_ref *dep;
 
 	if (!capable(CAP_SYS_MODULE))
@@ -387,11 +387,23 @@ sys_init_module(const char *name_user, s
 	}
 	strcpy(name_tmp, mod->name);
 
-	error = copy_from_user(mod, mod_user, mod_user_size);
+	/* Copying mod_user directly over mod breaks the module_list chain and
+	 * races against search_exception_table.  copy_from_user may sleep so it
+	 * cannot be under modlist_lock, do the copy in two stages.
+	 */
+	if (!(mod2 = vmalloc(mod_user_size))) {
+		error = -ENOMEM;
+		goto err2;
+	}
+	error = copy_from_user(mod2, mod_user, mod_user_size);
 	if (error) {
 		error = -EFAULT;
 		goto err2;
 	}
+	spin_lock_irqsave(&modlist_lock, flags);
+	memcpy(mod, mod2, mod_user_size);
+	mod->next = mod_tmp.next;
+	spin_unlock_irqrestore(&modlist_lock, flags);
 
 	/* Sanity check the size of the module.  */
 	error = -EINVAL;
@@ -505,7 +517,6 @@ sys_init_module(const char *name_user, s
 	   to make the I and D caches consistent.  */
 	flush_icache_range((unsigned long)mod, (unsigned long)mod + mod->size);
 
-	mod->next = mod_tmp.next;
 	mod->refs = NULL;
 
 	/* Sanity check the module's dependents */
@@ -566,6 +577,8 @@ sys_init_module(const char *name_user, s
 err3:
 	put_mod_name(n_name);
 err2:
+	if (mod2)
+		vfree(mod2);
 	*mod = mod_tmp;
 	strcpy((char *)mod->name, name_tmp);	/* We know there is room for this */
 err1:

