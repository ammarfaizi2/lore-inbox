Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265194AbSJRPyq>; Fri, 18 Oct 2002 11:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265195AbSJRPyp>; Fri, 18 Oct 2002 11:54:45 -0400
Received: from [195.223.140.120] ([195.223.140.120]:18768 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265194AbSJRPyg>; Fri, 18 Oct 2002 11:54:36 -0400
Date: Fri, 18 Oct 2002 18:00:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Srihari Vijayaraghavan <harisri@bigpond.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1
Message-ID: <20021018160031.GI23930@dualathlon.random>
References: <20021018145204.GG23930@dualathlon.random> <29723.1034955246@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29723.1034955246@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 01:34:06AM +1000, Keith Owens wrote:
> Three possibilities :-
> 
> (a) The modprobe at 234040 completed the load successfully then the
> oops occurred before the modprobe task was completely purged.  IOW, the
> module loaded, module_init() ran, modprobe returned to user space then
> the module died handling some event.
> 
> (b) The failing modprobe at 234042 is real, but is performing an
> operation that will not change module state.  For example, it is
> doing modprobe -n, this will not log but will still invoke some module
> syscalls.  The oops is then caused by corrupt module tables.
> 
> (c) modprobe is not being run as root so it cannot log.  Although it
> cannot actually change module state, it will do part of the work in
> extracting existing module symbols.  Again, the oops is caused by
> corrupt module tables.

thanks for the help.

the corrupted module tables rings a bell. I fixed the wrong locking in
the module code that could corrupt these tables (they were relying on
the bkl but the bkl means nothing if you copy_user in the middle of the
loop like the module code does, so I replaced the bkl with a semaphore
and that should fix things), but I wonder if I broken something else
with these fixes.

Here's the patch that I'm talking about, you may want to start the
binary search backing this out and see if the problem goes away. if it
goes away I clearly need to double check it ;)

diff -urNp x-ref/kernel/module.c x/kernel/module.c
--- x-ref/kernel/module.c	Tue Jan 22 18:56:00 2002
+++ x/kernel/module.c	Thu Oct 10 23:47:20 2002
@@ -78,6 +78,8 @@ static int kmalloc_failed;
  
 spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;
 
+static DECLARE_MUTEX(module_mutex);
+
 /**
  * inter_module_register - register a new set of inter module data.
  * @im_name: an arbitrary string to identify the data, must be unique
@@ -298,7 +300,7 @@ sys_create_module(const char *name_user,
 
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
-	lock_kernel();
+	down(&module_mutex);
 	if ((namelen = get_mod_name(name_user, &name)) < 0) {
 		error = namelen;
 		goto err0;
@@ -334,7 +336,7 @@ sys_create_module(const char *name_user,
 err1:
 	put_mod_name(name);
 err0:
-	unlock_kernel();
+	up(&module_mutex);
 	return error;
 }
 
@@ -353,7 +355,7 @@ sys_init_module(const char *name_user, s
 
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
-	lock_kernel();
+	down(&module_mutex);
 	if ((namelen = get_mod_name(name_user, &name)) < 0) {
 		error = namelen;
 		goto err0;
@@ -549,13 +551,16 @@ sys_init_module(const char *name_user, s
 	/* Initialize the module.  */
 	atomic_set(&mod->uc.usecount,1);
 	mod->flags |= MOD_INITIALIZING;
+	up(&module_mutex);
 	if (mod->init && (error = mod->init()) != 0) {
+		down(&module_mutex);
 		atomic_set(&mod->uc.usecount,0);
 		mod->flags &= ~MOD_INITIALIZING;
 		if (error > 0)	/* Buggy module */
 			error = -EBUSY;
 		goto err0;
 	}
+	down(&module_mutex);
 	atomic_dec(&mod->uc.usecount);
 
 	/* And set it running.  */
@@ -571,7 +576,7 @@ err2:
 err1:
 	put_mod_name(name);
 err0:
-	unlock_kernel();
+	up(&module_mutex);
 	kfree(name_tmp);
 	return error;
 }
@@ -602,7 +607,7 @@ sys_delete_module(const char *name_user)
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
 
-	lock_kernel();
+	down(&module_mutex);
 	if (name_user) {
 		if ((error = get_mod_name(name_user, &name)) < 0)
 			goto out;
@@ -664,7 +669,7 @@ restart:
 	
 	error = 0;
 out:
-	unlock_kernel();
+	up(&module_mutex);
 	return error;
 }
 
@@ -887,7 +892,7 @@ sys_query_module(const char *name_user, 
 	struct module *mod;
 	int err;
 
-	lock_kernel();
+	down(&module_mutex);
 	if (name_user == NULL)
 		mod = &kernel_module;
 	else {
@@ -937,7 +942,7 @@ sys_query_module(const char *name_user, 
 	atomic_dec(&mod->uc.usecount);
 	
 out:
-	unlock_kernel();
+	up(&module_mutex);
 	return err;
 }
 
@@ -956,7 +961,7 @@ sys_get_kernel_syms(struct kernel_sym *t
 	int i;
 	struct kernel_sym ksym;
 
-	lock_kernel();
+	down(&module_mutex);
 	for (mod = module_list, i = 0; mod; mod = mod->next) {
 		/* include the count for the module name! */
 		i += mod->nsyms + 1;
@@ -999,7 +1004,7 @@ sys_get_kernel_syms(struct kernel_sym *t
 		}
 	}
 out:
-	unlock_kernel();
+	up(&module_mutex);
 	return i;
 }
 
@@ -1037,8 +1042,11 @@ free_module(struct module *mod, int tag_
 
 	if (mod->flags & MOD_RUNNING)
 	{
-		if(mod->cleanup)
+		if(mod->cleanup) {
+			up(&module_mutex);
 			mod->cleanup();
+			down(&module_mutex);
+		}
 		mod->flags &= ~MOD_RUNNING;
 	}
 
@@ -1082,6 +1090,7 @@ int get_module_list(char *p)
 	char tmpstr[64];
 	struct module_ref *ref;
 
+	down(&module_mutex);
 	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
 		long len;
 		const char *q;
@@ -1150,6 +1159,7 @@ int get_module_list(char *p)
 	}
 
 fini:
+	up(&module_mutex);
 	return PAGE_SIZE - left;
 }
 
@@ -1172,7 +1182,7 @@ static void *s_start(struct seq_file *m,
 
 	if (!p)
 		return ERR_PTR(-ENOMEM);
-	lock_kernel();
+	down(&module_mutex);
 	for (v = module_list, n = *pos; v; n -= v->nsyms, v = v->next) {
 		if (n < v->nsyms) {
 			p->mod = v;
@@ -1180,7 +1190,7 @@ static void *s_start(struct seq_file *m,
 			return p;
 		}
 	}
-	unlock_kernel();
+	up(&module_mutex);
 	kfree(p);
 	return NULL;
 }
@@ -1193,7 +1203,7 @@ static void *s_next(struct seq_file *m, 
 		do {
 			v->mod = v->mod->next;
 			if (!v->mod) {
-				unlock_kernel();
+				up(&module_mutex);
 				kfree(p);
 				return NULL;
 			}
@@ -1206,7 +1216,7 @@ static void *s_next(struct seq_file *m, 
 static void s_stop(struct seq_file *m, void *p)
 {
 	if (p && !IS_ERR(p)) {
-		unlock_kernel();
+		up(&module_mutex);
 		kfree(p);
 	}
 }


Andrea
