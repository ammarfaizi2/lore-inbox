Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTFECRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTFECRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:17:36 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:21484 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S264448AbTFECRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:17:03 -0400
From: NeilBrown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 05 Jun 2003 12:30:32 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
cc: linux-kernel@vger.kernel.org
Subject: [PATCH]  Add module_kernel_thread for threads that live in modules.
Message-Id: <E19NkWO-0005i0-00@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nfsd (and lockd) run kernel threads that currently use
MOD_{INC,DEC}_USE_COUNT to manage references to the module on
behalf of those threads.  This is deprecated and unsafe.

This patch introduces module_kernel_thread which ensures that
references counts are taken and dropped as appropriate for kernel
threads, and uses it for nfsd and lockd.

NeilBrown

### Comments for ChangeSet

If a kernel thread runs code that is in a module, it can be started
with module_kernel_thread, and this will safely managed the reference
counts on the module implied by the existance of the thread.

This is then used for nfsd and lockd.

 ----------- Diffstat output ------------
 ./fs/lockd/svc.c             |    9 ++------
 ./fs/nfsd/nfssvc.c           |   11 +++-------
 ./include/linux/module.h     |   15 +++++++++++++
 ./include/linux/sunrpc/svc.h |    4 +--
 ./kernel/module.c            |   47 +++++++++++++++++++++++++++++++++++++++++++
 ./net/sunrpc/svc.c           |    7 ++++--
 6 files changed, 76 insertions(+), 17 deletions(-)

diff ./fs/lockd/svc.c~current~ ./fs/lockd/svc.c
--- ./fs/lockd/svc.c~current~	2003-06-05 12:04:57.000000000 +1000
+++ ./fs/lockd/svc.c	2003-06-05 12:04:51.000000000 +1000
@@ -80,7 +80,7 @@ static inline void clear_grace_period(vo
 /*
  * This is the lockd kernel thread
  */
-static void
+static int
 lockd(struct svc_rqst *rqstp)
 {
 	struct svc_serv	*serv = rqstp->rq_server;
@@ -88,7 +88,6 @@ lockd(struct svc_rqst *rqstp)
 	unsigned long grace_period_expire;
 
 	/* Lock module and set up kernel thread */
-	MOD_INC_USE_COUNT;
 	lock_kernel();
 
 	/*
@@ -181,9 +180,7 @@ lockd(struct svc_rqst *rqstp)
 	/* release rpciod */
 	rpciod_down();
 
-	/* Release module */
-	unlock_kernel();
-	MOD_DEC_USE_COUNT;
+	return 0;
 }
 
 /*
@@ -238,7 +235,7 @@ lockd_up(void)
 	/*
 	 * Create the kernel thread and wait for it to start.
 	 */
-	error = svc_create_thread(lockd, serv);
+	error = svc_create_thread(lockd, serv, THIS_MODULE);
 	if (error) {
 		printk(KERN_WARNING
 			"lockd_up: create thread failed, error=%d\n", error);

diff ./fs/nfsd/nfssvc.c~current~ ./fs/nfsd/nfssvc.c
--- ./fs/nfsd/nfssvc.c~current~	2003-06-05 12:04:57.000000000 +1000
+++ ./fs/nfsd/nfssvc.c	2003-06-05 12:04:51.000000000 +1000
@@ -48,7 +48,7 @@
 #define	SIG_NOCLEAN	SIGHUP
 
 extern struct svc_program	nfsd_program;
-static void			nfsd(struct svc_rqst *rqstp);
+static int			nfsd(struct svc_rqst *rqstp);
 struct timeval			nfssvc_boot;
 static struct svc_serv 		*nfsd_serv;
 static atomic_t			nfsd_busy;
@@ -114,7 +114,7 @@ nfsd_svc(unsigned short port, int nrserv
 	nrservs -= (nfsd_serv->sv_nrthreads-1);
 	while (nrservs > 0) {
 		nrservs--;
-		error = svc_create_thread(nfsd, nfsd_serv);
+		error = svc_create_thread(nfsd, nfsd_serv, THIS_MODULE);
 		if (error < 0)
 			break;
 	}
@@ -163,7 +163,7 @@ update_thread_usage(int busy_threads)
 /*
  * This is the NFS server kernel thread
  */
-static void
+static int
 nfsd(struct svc_rqst *rqstp)
 {
 	struct svc_serv	*serv = rqstp->rq_server;
@@ -172,7 +172,6 @@ nfsd(struct svc_rqst *rqstp)
 	sigset_t shutdown_mask, allowed_mask;
 
 	/* Lock module and set up kernel thread */
-	MOD_INC_USE_COUNT;
 	lock_kernel();
 	daemonize("nfsd");
 	current->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
@@ -255,9 +254,7 @@ nfsd(struct svc_rqst *rqstp)
 
 	/* Release the thread */
 	svc_exit_thread(rqstp);
-
-	/* Release module */
-	MOD_DEC_USE_COUNT;
+	return 0;
 }
 
 int

diff ./include/linux/module.h~current~ ./include/linux/module.h
--- ./include/linux/module.h~current~	2003-06-05 12:04:57.000000000 +1000
+++ ./include/linux/module.h	2003-06-05 11:34:24.000000000 +1000
@@ -314,6 +314,9 @@ static inline void module_put(struct mod
 	}
 }
 
+extern int module_kernel_thread(int (*fn)(void*), void *arg, 
+				unsigned long flags, struct module *owner);
+
 #else /*!CONFIG_MODULE_UNLOAD*/
 static inline int try_module_get(struct module *module)
 {
@@ -328,6 +331,12 @@ static inline void __module_get(struct m
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(p) do { } while(0)
 
+static inline int module_kernel_thread(int (*fn)(void*), void *arg, 
+				       unsigned long flags, struct module *owner)
+{
+	return kernel_thread(fn, arg, flags);
+}
+	       
 #endif /* CONFIG_MODULE_UNLOAD */
 
 /* This is a #define so the string doesn't get put in every .o file */
@@ -419,6 +428,12 @@ static inline int unregister_module_noti
 	return 0;
 }
 
+static inline int module_kernel_thread(int (*fn)(void*), void *arg,
+				       unsigned long flags, struct module *owner)
+{
+	return kernel_thread(fn, arg, flags);
+}
+
 #endif /* CONFIG_MODULES */
 
 #ifdef MODULE

diff ./include/linux/sunrpc/svc.h~current~ ./include/linux/sunrpc/svc.h
--- ./include/linux/sunrpc/svc.h~current~	2003-06-05 12:04:57.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2003-06-05 12:04:51.000000000 +1000
@@ -276,13 +276,13 @@ struct svc_procedure {
 /*
  * This is the RPC server thread function prototype
  */
-typedef void		(*svc_thread_fn)(struct svc_rqst *);
+typedef int		(*svc_thread_fn)(struct svc_rqst *);
 
 /*
  * Function prototypes.
  */
 struct svc_serv *  svc_create(struct svc_program *, unsigned int);
-int		   svc_create_thread(svc_thread_fn, struct svc_serv *);
+int		   svc_create_thread(svc_thread_fn, struct svc_serv *, struct module *);
 void		   svc_exit_thread(struct svc_rqst *);
 void		   svc_destroy(struct svc_serv *);
 int		   svc_process(struct svc_serv *, struct svc_rqst *);

diff ./kernel/module.c~current~ ./kernel/module.c
--- ./kernel/module.c~current~	2003-06-05 12:04:57.000000000 +1000
+++ ./kernel/module.c	2003-06-05 11:34:24.000000000 +1000
@@ -616,6 +616,53 @@ void symbol_put_addr(void *addr)
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
+
+/*
+ * If a kernel_thread runs in a module, we might want to
+ * module to be refcounted by the threads.  This code
+ * allows that to happen.
+ * When module_kernel_thread completes, the module will
+ * have been ref-counted iif the thread started.
+ */
+struct kern_thread_info {
+	int (*fn)(void*);
+	void *arg;
+	struct module *owner;
+};
+static int module_kernel_thread_helper(void *arg)
+{
+	struct kern_thread_info *kti = arg;
+	int rv;
+
+	rv = kti->fn(kti->arg);
+	module_put(kti->owner);
+	kfree(kti);
+	return rv;
+}
+int module_kernel_thread(int (*fn)(void*), void *arg, 
+			 unsigned long flags, struct module *owner)
+{
+	struct kern_thread_info *kti;
+	int err;
+
+	if (!owner)
+		return kernel_thread(fn, arg, flags);
+	kti = kmalloc(sizeof(*kti), GFP_KERNEL);
+	if (!kti)
+		return -ENOMEM;
+	kti->fn = fn;
+	kti->arg = arg;
+	kti->owner = owner;
+	__module_get(owner);
+	err = kernel_thread(module_kernel_thread_helper, kti, flags);
+	if (err < 0) {
+		module_put(owner);
+		kfree(kti);
+	}
+	return err;
+}
+EXPORT_SYMBOL(module_kernel_thread);
+
 #else /* !CONFIG_MODULE_UNLOAD */
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {

diff ./net/sunrpc/svc.c~current~ ./net/sunrpc/svc.c
--- ./net/sunrpc/svc.c~current~	2003-06-05 12:04:57.000000000 +1000
+++ ./net/sunrpc/svc.c	2003-06-05 12:06:13.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/in.h>
 #include <linux/unistd.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/xdr.h>
@@ -150,7 +151,8 @@ svc_release_buffer(struct svc_rqst *rqst
  * Create a server thread
  */
 int
-svc_create_thread(svc_thread_fn func, struct svc_serv *serv)
+svc_create_thread(svc_thread_fn func, struct svc_serv *serv,
+		  struct module *owner)
 {
 	struct svc_rqst	*rqstp;
 	int		error = -ENOMEM;
@@ -169,7 +171,8 @@ svc_create_thread(svc_thread_fn func, st
 
 	serv->sv_nrthreads++;
 	rqstp->rq_server = serv;
-	error = kernel_thread((int (*)(void *)) func, rqstp, 0);
+	error = module_kernel_thread((int(*)(void*))func, rqstp,
+				     0, owner);
 	if (error < 0)
 		goto out_thread;
 	svc_sock_update_bufs(serv);
