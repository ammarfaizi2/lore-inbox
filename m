Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSL3ANN>; Sun, 29 Dec 2002 19:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSL3ANN>; Sun, 29 Dec 2002 19:13:13 -0500
Received: from verein.lst.de ([212.34.181.86]:8204 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262392AbSL3ANG>;
	Sun, 29 Dec 2002 19:13:06 -0500
Date: Mon, 30 Dec 2002 01:21:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] avoid deprecated module functions in core code
Message-ID: <20021230012115.A13069@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20021229230011.A12151@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021229230011.A12151@lst.de>; from hch@lst.de on Sun, Dec 29, 2002 at 11:00:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 11:00:11PM +0100, Christoph Hellwig wrote:
> A first start at removing them from kernel/*.c and fs/*.c.
> 
> Note that module_put is fine for a NULL argument.

Two persons told me independantly that this patch is utter crap and
doesn't even compile.  And they're right..

Here's a version that does not even compile but even boot and cover
more uses.

Note that the return value of set_binfmt isn't yet checked.  That's
another patch.


--- 1.24/crypto/api.c	Sun Dec  8 17:36:48 2002
+++ edited/crypto/api.c	Sun Dec 29 23:45:53 2002
@@ -29,8 +29,7 @@
 
 static inline void crypto_alg_put(struct crypto_alg *alg)
 {
-	if (alg->cra_module)
-		__MOD_DEC_USE_COUNT(alg->cra_module);
+	module_put(alg->cra_module);
 }
 
 struct crypto_alg *crypto_alg_lookup(const char *name)
--- 1.61/drivers/block/genhd.c	Wed Dec  4 19:07:17 2002
+++ edited/drivers/block/genhd.c	Sun Dec 29 23:52:58 2002
@@ -168,15 +168,13 @@
 		best = p->range;
 		*part = dev - p->dev;
 		if (p->lock && p->lock(dev, data) < 0) {
-			if (owner)
-				__MOD_DEC_USE_COUNT(owner);
+			module_put(owner);
 			continue;
 		}
 		read_unlock(&gendisk_lock);
 		disk = probe(dev, part, data);
 		/* Currently ->owner protects _only_ ->probe() itself. */
-		if (owner)
-			__MOD_DEC_USE_COUNT(owner);
+		module_put(owner);
 		if (disk)
 			return disk;
 		goto retry;
--- 1.119/fs/block_dev.c	Sun Dec 15 18:49:04 2002
+++ edited/fs/block_dev.c	Sun Dec 29 21:50:13 2002
@@ -623,8 +623,7 @@
 		}
 	} else {
 		put_disk(disk);
-		if (owner)
-			__MOD_DEC_USE_COUNT(owner);
+		module_put(owner);
 		if (bdev->bd_contains == bdev) {
 			if (bdev->bd_disk->fops->open) {
 				ret = bdev->bd_disk->fops->open(inode, file);
@@ -651,8 +650,7 @@
 		blkdev_put(bdev->bd_contains, BDEV_RAW);
 	bdev->bd_contains = NULL;
 	put_disk(disk);
-	if (owner)
-		__MOD_DEC_USE_COUNT(owner);
+	module_put(owner);
 out:
 	up(&bdev->bd_sem);
 	unlock_kernel();
@@ -723,9 +721,10 @@
 	}
 	if (!bdev->bd_openers) {
 		struct module *owner = disk->fops->owner;
+
 		put_disk(disk);
-		if (owner)
-			__MOD_DEC_USE_COUNT(owner);
+		module_put(owner);
+
 		bdev->bd_disk = NULL;
 		bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
 		if (bdev != bdev->bd_contains) {
===== fs/dquot.c 1.52 vs edited =====
--- 1.52/fs/dquot.c	Wed Nov 27 18:11:14 2002
+++ edited/fs/dquot.c	Sun Dec 29 21:33:57 2002
@@ -111,8 +111,7 @@
 
 static void put_quota_format(struct quota_format_type *fmt)
 {
-	if (fmt->qf_owner)
-		__MOD_DEC_USE_COUNT(fmt->qf_owner);
+	module_put(fmt->qf_owner);
 }
 
 /*
===== fs/exec.c 1.58 vs edited =====
--- 1.58/fs/exec.c	Sun Dec 15 06:07:04 2002
+++ edited/fs/exec.c	Sun Dec 29 23:06:11 2002
@@ -102,8 +102,7 @@
 
 static inline void put_binfmt(struct linux_binfmt * fmt)
 {
-	if (fmt->module)
-		__MOD_DEC_USE_COUNT(fmt->module);
+	module_put(fmt->module);
 }
 
 /*
@@ -1108,14 +1107,18 @@
 	return retval;
 }
 
-void set_binfmt(struct linux_binfmt *new)
+int set_binfmt(struct linux_binfmt *new)
 {
 	struct linux_binfmt *old = current->binfmt;
-	if (new && new->module)
-		__MOD_INC_USE_COUNT(new->module);
+
+	if (new) {
+		if (!try_module_get(new->module))
+			return -1;
+	}
 	current->binfmt = new;
-	if (old && old->module)
-		__MOD_DEC_USE_COUNT(old->module);
+	if (old)
+		module_put(old->module);
+	return 0;
 }
 
 #define CORENAME_MAX_SIZE 64
===== fs/nls/nls_base.c 1.7 vs edited =====
--- 1.7/fs/nls/nls_base.c	Wed Aug 28 03:53:09 2002
+++ edited/fs/nls/nls_base.c	Sun Dec 29 23:46:36 2002
@@ -245,8 +245,7 @@
 
 void unload_nls(struct nls_table *nls)
 {
-	if (nls->owner)
-		__MOD_DEC_USE_COUNT(nls->owner);
+	module_put(nls->owner);
 }
 
 wchar_t charset2uni[256] = {
===== fs/partitions/check.c 1.90 vs edited =====
--- 1.90/fs/partitions/check.c	Thu Dec  5 14:01:25 2002
+++ edited/fs/partitions/check.c	Sun Dec 29 23:45:36 2002
@@ -565,8 +565,7 @@
 	dname->name = NULL;
 	if (hd) {
 		dname->name = disk_name(hd, part, dname->namebuf);
-		if (hd->fops->owner)
-			__MOD_DEC_USE_COUNT(hd->fops->owner);
+		module_put(hd->fops->owner);
 		put_disk(hd);
 	}
 	if (!dname->name) {
===== include/linux/binfmts.h 1.5 vs edited =====
--- 1.5/include/linux/binfmts.h	Sun Dec 15 06:07:04 2002
+++ edited/include/linux/binfmts.h	Sun Dec 29 23:06:35 2002
@@ -58,13 +58,7 @@
 extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *bprm);
 extern void compute_creds(struct linux_binprm *binprm);
 extern int do_coredump(long signr, int exit_code, struct pt_regs * regs);
-extern void set_binfmt(struct linux_binfmt *new);
-
-
-#if 0
-/* this went away now */
-#define change_ldt(a,b) setup_arg_pages(a,b)
-#endif
+extern int set_binfmt(struct linux_binfmt *new);
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_BINFMTS_H */
===== include/linux/compiler.h 1.7 vs edited =====
--- 1.7/include/linux/compiler.h	Sat Dec 28 12:45:03 2002
+++ edited/include/linux/compiler.h	Sun Dec 29 18:52:54 2002
@@ -21,9 +21,9 @@
  * and then gcc will emit a warning for each usage of the function.
  */
 #if __GNUC__ >= 3
-#define deprecated	__attribute__((deprecated))
+#define __deprecated	__attribute__((deprecated))
 #else
-#define deprecated
+#define __deprecated
 #endif
 
 /* This macro obfuscates arithmetic on a variable address so that gcc
===== include/linux/fs.h 1.204 vs edited =====
--- 1.204/include/linux/fs.h	Sat Dec 14 18:20:24 2002
+++ edited/include/linux/fs.h	Sun Dec 29 23:05:01 2002
@@ -983,13 +983,13 @@
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
 #define fops_get(fops) \
 	(((fops) && (fops)->owner)	\
-		? ( try_inc_mod_count((fops)->owner) ? (fops) : NULL ) \
+		? (try_inc_mod_count((fops)->owner) ? (fops) : NULL) \
 		: (fops))
 
 #define fops_put(fops) \
 do {	\
 	if ((fops) && (fops)->owner) \
-		__MOD_DEC_USE_COUNT((fops)->owner);	\
+		module_put((fops)->owner);	\
 } while(0)
 
 extern int register_filesystem(struct file_system_type *);
===== include/linux/ioport.h 1.5 vs edited =====
--- 1.5/include/linux/ioport.h	Sat Dec 28 17:14:46 2002
+++ edited/include/linux/ioport.h	Sun Dec 29 18:53:36 2002
@@ -108,7 +108,7 @@
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
-extern int deprecated __check_region(struct resource *, unsigned long, unsigned long);
+extern int __deprecated __check_region(struct resource *, unsigned long, unsigned long);
 extern void __release_region(struct resource *, unsigned long, unsigned long);
 
 #define get_ioport_list(buf)	get_resource_list(&ioport_resource, buf, PAGE_SIZE)
===== include/linux/module.h 1.30 vs edited =====
--- 1.30/include/linux/module.h	Mon Dec  2 01:44:43 2002
+++ edited/include/linux/module.h	Sun Dec 29 19:50:27 2002
@@ -296,9 +296,20 @@
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
-#define __MOD_INC_USE_COUNT(mod) \
-	do { __unsafe(mod); (void)try_module_get(mod); } while(0)
-#define __MOD_DEC_USE_COUNT(mod) module_put(mod)
+static inline void __deprecated __MOD_INC_USE_COUNT(struct module *module)
+{
+	__unsafe(module);
+	/*
+	 * Yes, we ignore the retval here, that's why it's deprecated.
+	 */
+	try_module_get(module);
+}
+
+static inline void __deprecated __MOD_DEC_USE_COUNT(struct module *module)
+{
+	module_put(module);
+}
+
 #define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)
 
 struct obsolete_modparm {
@@ -319,14 +330,21 @@
 /* People do this inside their init routines, when the module isn't
    "live" yet.  They should no longer be doing that, but
    meanwhile... */
+static inline void __deprecated _MOD_INC_USE_COUNT(struct module *module)
+{
+	__unsafe(module);
+
 #if defined(CONFIG_MODULE_UNLOAD) && defined(MODULE)
-#define MOD_INC_USE_COUNT	\
-	do { __unsafe(THIS_MODULE); local_inc(&THIS_MODULE->ref[get_cpu()].count); put_cpu(); } while (0)
+	local_inc(&module->ref[get_cpu()].count);
+	put_cpu();
 #else
-#define MOD_INC_USE_COUNT \
-	do { __unsafe(THIS_MODULE); (void)try_module_get(THIS_MODULE); } while (0)
+	try_module_get(module);
 #endif
-#define MOD_DEC_USE_COUNT module_put(THIS_MODULE)
+}
+#define MOD_INC_USE_COUNT \
+	_MOD_INC_USE_COUNT(THIS_MODULE)
+#define MOD_DEC_USE_COUNT \
+	__MOD_DEC_USE_COUNT(THIS_MODULE)
 #define try_inc_mod_count(mod) try_module_get(mod)
 #define EXPORT_NO_SYMBOLS
 extern int module_dummy_usage;
@@ -364,5 +382,4 @@
 extern const void *inter_module_get(const char *);
 extern const void *inter_module_get_request(const char *, const char *);
 extern void inter_module_put(const char *);
-
 #endif /* _LINUX_MODULE_H */
===== include/linux/personality.h 1.4 vs edited =====
--- 1.4/include/linux/personality.h	Fri Aug 30 10:00:40 2002
+++ edited/include/linux/personality.h	Sun Dec 29 23:44:39 2002
@@ -107,22 +107,4 @@
 #define set_personality(pers) \
 	((current->personality == pers) ? 0 : __set_personality(pers))
 
-/*
- * Load an execution domain.
- */
-#define get_exec_domain(ep)				\
-do {							\
-	if (ep != NULL && ep->module != NULL)		\
-		__MOD_INC_USE_COUNT(ep->module);	\
-} while (0)
-
-/*
- * Unload an execution domain.
- */
-#define put_exec_domain(ep)				\
-do {							\
-	if (ep != NULL && ep->module != NULL)		\
-		__MOD_DEC_USE_COUNT(ep->module);	\
-} while (0)
-
 #endif /* _LINUX_PERSONALITY_H */
===== include/linux/wait.h 1.12 vs edited =====
--- 1.12/include/linux/wait.h	Fri Nov 15 10:36:32 2002
+++ edited/include/linux/wait.h	Sun Dec 29 19:05:26 2002
@@ -11,6 +11,7 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
@@ -244,11 +245,11 @@
  * They are racy.  DO NOT use them, use the wait_event* interfaces above.  
  * We plan to remove these interfaces during 2.7.
  */
-extern void FASTCALL(sleep_on(wait_queue_head_t *q));
-extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
+extern void __deprecated FASTCALL(sleep_on(wait_queue_head_t *q));
+extern long __deprecated FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
 				      signed long timeout));
-extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
-extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
+extern void __deprecated FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
+extern long __deprecated FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
 						    signed long timeout));
 
 /*
--- 1.11/kernel/exec_domain.c	Wed Nov 13 19:56:02 2002
+++ edited/kernel/exec_domain.c	Sun Dec 29 23:42:14 2002
@@ -172,7 +172,7 @@
 
 		fsp = copy_fs_struct(current->fs);
 		if (fsp == NULL) {
-			put_exec_domain(ep);
+			module_put(ep->module);
 			return -ENOMEM;;
 		}
 
@@ -194,10 +194,7 @@
 	current_thread_info()->exec_domain = ep;
 	set_fs_altroot();
 
-	put_exec_domain(oep);
-
-	printk(KERN_DEBUG "[%s:%d]: set personality to %lx\n",
-			current->comm, current->pid, personality);
+	module_put(oep->module);
 	return 0;
 }
 
===== kernel/exit.c 1.76 vs edited =====
--- 1.76/kernel/exit.c	Mon Dec  2 08:44:31 2002
+++ edited/kernel/exit.c	Sun Dec 29 23:44:15 2002
@@ -664,9 +664,9 @@
 	if (current->leader)
 		disassociate_ctty(1);
 
-	put_exec_domain(tsk->thread_info->exec_domain);
-	if (tsk->binfmt && tsk->binfmt->module)
-		__MOD_DEC_USE_COUNT(tsk->binfmt->module);
+	module_put(tsk->thread_info->exec_domain->module);
+	if (tsk->binfmt)
+		module_put(tsk->binfmt->module);
 
 	tsk->exit_code = code;
 	exit_notify();
===== kernel/fork.c 1.93 vs edited =====
--- 1.93/kernel/fork.c	Sat Dec 14 12:42:12 2002
+++ edited/kernel/fork.c	Sun Dec 29 23:43:58 2002
@@ -743,10 +743,11 @@
 	if (nr_threads >= max_threads)
 		goto bad_fork_cleanup_count;
 	
-	get_exec_domain(p->thread_info->exec_domain);
+	if (!try_module_get(p->thread_info->exec_domain->module))
+		goto bad_fork_cleanup_count;
 
-	if (p->binfmt && p->binfmt->module)
-		__MOD_INC_USE_COUNT(p->binfmt->module);
+	if (p->binfmt && !try_module_get(p->binfmt->module))
+		goto bad_fork_cleanup_put_domain;
 
 #ifdef CONFIG_PREEMPT
 	/*
@@ -958,9 +959,10 @@
 bad_fork_cleanup:
 	if (p->pid > 0)
 		free_pidmap(p->pid);
-	put_exec_domain(p->thread_info->exec_domain);
-	if (p->binfmt && p->binfmt->module)
-		__MOD_DEC_USE_COUNT(p->binfmt->module);
+	if (p->binfmt)
+		module_put(p->binfmt->module);
+bad_fork_cleanup_put_domain:
+	module_put(p->thread_info->exec_domain->module);
 bad_fork_cleanup_count:
 	atomic_dec(&p->user->processes);
 	free_uid(p->user);
===== kernel/intermodule.c 1.1 vs edited =====
--- 1.1/kernel/intermodule.c	Fri Nov  8 23:08:33 2002
+++ edited/kernel/intermodule.c	Sun Dec 29 21:32:41 2002
@@ -166,7 +166,7 @@
 		ime = list_entry(tmp, struct inter_module_entry, list);
 		if (strcmp(ime->im_name, im_name) == 0) {
 			if (ime->owner)
-				__MOD_DEC_USE_COUNT(ime->owner);
+				module_put(ime->owner);
 			spin_unlock(&ime_lock);
 			return;
 		}
===== kernel/resource.c 1.7 vs edited =====
--- 1.7/kernel/resource.c	Sat Dec 28 17:05:55 2002
+++ edited/kernel/resource.c	Sun Dec 29 18:53:07 2002
@@ -237,7 +237,7 @@
 	return res;
 }
 
-int deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
+int __deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
 {
 	struct resource * res;
 
===== kernel/sched.c 1.145 vs edited =====
--- 1.145/kernel/sched.c	Mon Dec  2 08:06:13 2002
+++ edited/kernel/sched.c	Sun Dec 29 18:57:50 2002
@@ -1238,7 +1238,7 @@
 	__remove_wait_queue(q, &wait);				\
 	spin_unlock_irqrestore(&q->lock, flags);
 
-void interruptible_sleep_on(wait_queue_head_t *q)
+void __deprecated interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 
@@ -1249,7 +1249,7 @@
 	SLEEP_ON_TAIL
 }
 
-long interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
+long __deprecated interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 
@@ -1262,7 +1262,7 @@
 	return timeout;
 }
 
-void sleep_on(wait_queue_head_t *q)
+void __deprecated sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
 	
@@ -1273,7 +1273,7 @@
 	SLEEP_ON_TAIL
 }
 
-long sleep_on_timeout(wait_queue_head_t *q, long timeout)
+long __deprecated sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
 	
