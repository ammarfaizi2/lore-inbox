Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422939AbWBBFgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422939AbWBBFgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 00:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422947AbWBBFgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 00:36:16 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:1642 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422939AbWBBFgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 00:36:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=mYUrD3GURTr0Ql0cPtvlZk16fkhXwIiYdSWAlAl2qIhXQIPhdgMH2Q2aSi3JmDGjW1c8/mT/04K0qTbdj9Muw5a9Rf2KYDiKeo0e8VB6fh1tNOpx2ghY1wDoSDLqzrIGkufOEqDJatDS3dLOIxLhw0Bil1u0eBfUmCCb70T2jlc=
Message-ID: <81083a450602012136t4193fd94we8f0ea59f2508060@mail.gmail.com>
Date: Thu, 2 Feb 2006 11:06:14 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] kernel/module.c Semaphore to Mutex Conversion for module_mutex
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5346_18682158.1138858574978"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_5346_18682158.1138858574978
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch converts the module_mutex semaphore to a mutex.

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

------=_Part_5346_18682158.1138858574978
Content-Type: text/plain; name=patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch.txt"

--- /usr/src/linux-2.6.16-rc1-mm4/kernel/module.c.orig	2006-02-02 10:54:31.000000000 +0530
+++ /usr/src/linux-2.6.16-rc1-mm4/kernel/module.c	2006-02-02 10:50:12.000000000 +0530
@@ -61,7 +61,7 @@
 static DEFINE_SPINLOCK(modlist_lock);
 
 /* List of modules, protected by module_mutex AND modlist_lock */
-static DECLARE_MUTEX(module_mutex);
+static DEFINE_MUTEX(module_mutex);
 static LIST_HEAD(modules);
 
 static DEFINE_MUTEX(notify_mutex);
@@ -558,7 +558,7 @@ static void free_module(struct module *m
 static void wait_for_zero_refcount(struct module *mod)
 {
 	/* Since we might sleep for some time, drop the semaphore first */
-	up(&module_mutex);
+	mutex_unlock(&module_mutex);
 	for (;;) {
 		DEBUGP("Looking at refcount...\n");
 		set_current_state(TASK_UNINTERRUPTIBLE);
@@ -567,7 +567,7 @@ static void wait_for_zero_refcount(struc
 		schedule();
 	}
 	current->state = TASK_RUNNING;
-	down(&module_mutex);
+	mutex_lock(&module_mutex);
 }
 
 asmlinkage long
@@ -584,7 +584,7 @@ sys_delete_module(const char __user *nam
 		return -EFAULT;
 	name[MODULE_NAME_LEN-1] = '\0';
 
-	if (down_interruptible(&module_mutex) != 0)
+	if (mutex_lock_interruptible(&module_mutex) != 0)
 		return -EINTR;
 
 	mod = find_module(name);
@@ -633,14 +633,14 @@ sys_delete_module(const char __user *nam
 
 	/* Final destruction now noone is using it. */
 	if (mod->exit != NULL) {
-		up(&module_mutex);
+		mutex_unlock(&module_mutex);
 		mod->exit();
-		down(&module_mutex);
+		mutex_lock(&module_mutex);
 	}
 	free_module(mod);
 
  out:
-	up(&module_mutex);
+	mutex_unlock(&module_mutex);
 	return ret;
 }
 
@@ -1931,13 +1931,13 @@ sys_init_module(void __user *umod,
 		return -EPERM;
 
 	/* Only one module load at a time, please */
-	if (down_interruptible(&module_mutex) != 0)
+	if (mutex_lock_interruptible(&module_mutex) != 0)
 		return -EINTR;
 
 	/* Do all the hard work */
 	mod = load_module(umod, len, uargs);
 	if (IS_ERR(mod)) {
-		up(&module_mutex);
+		mutex_unlock(&module_mutex);
 		return PTR_ERR(mod);
 	}
 
@@ -1946,7 +1946,7 @@ sys_init_module(void __user *umod,
 	stop_machine_run(__link_module, mod, NR_CPUS);
 
 	/* Drop lock so they can recurse */
-	up(&module_mutex);
+	mutex_unlock(&module_mutex);
 
 	mutex_lock(&notify_mutex);
 	notifier_call_chain(&module_notify_list, MODULE_STATE_COMING, mod);
@@ -1965,15 +1965,15 @@ sys_init_module(void __user *umod,
 			       mod->name);
 		else {
 			module_put(mod);
-			down(&module_mutex);
+			mutex_lock(&module_mutex);
 			free_module(mod);
-			up(&module_mutex);
+			mutex_unlock(&module_mutex);
 		}
 		return ret;
 	}
 
 	/* Now it's a first class citizen! */
-	down(&module_mutex);
+	mutex_lock(&module_mutex);
 	mod->state = MODULE_STATE_LIVE;
 	/* Drop initial reference. */
 	module_put(mod);
@@ -1981,7 +1981,7 @@ sys_init_module(void __user *umod,
 	mod->module_init = NULL;
 	mod->init_size = 0;
 	mod->init_text_size = 0;
-	up(&module_mutex);
+	mutex_unlock(&module_mutex);
 
 	return 0;
 }
@@ -2071,7 +2071,7 @@ struct module *module_get_kallsym(unsign
 {
 	struct module *mod;
 
-	down(&module_mutex);
+	mutex_lock(&module_mutex);
 	list_for_each_entry(mod, &modules, list) {
 		if (symnum < mod->num_symtab) {
 			*value = mod->symtab[symnum].st_value;
@@ -2079,12 +2079,12 @@ struct module *module_get_kallsym(unsign
 			strncpy(namebuf,
 				mod->strtab + mod->symtab[symnum].st_name,
 				127);
-			up(&module_mutex);
+			mutex_unlock(&module_mutex);
 			return mod;
 		}
 		symnum -= mod->num_symtab;
 	}
-	up(&module_mutex);
+	mutex_unlock(&module_mutex);
 	return NULL;
 }
 
@@ -2127,7 +2127,7 @@ static void *m_start(struct seq_file *m,
 	struct list_head *i;
 	loff_t n = 0;
 
-	down(&module_mutex);
+	mutex_lock(&module_mutex);
 	list_for_each(i, &modules) {
 		if (n++ == *pos)
 			break;
@@ -2148,7 +2148,7 @@ static void *m_next(struct seq_file *m, 
 
 static void m_stop(struct seq_file *m, void *p)
 {
-	up(&module_mutex);
+	mutex_unlock(&module_mutex);
 }
 
 static int m_show(struct seq_file *m, void *p)

------=_Part_5346_18682158.1138858574978--
