Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271676AbTGRCCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 22:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271680AbTGRCBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 22:01:35 -0400
Received: from dp.samba.org ([66.70.73.150]:28038 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271676AbTGRCBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 22:01:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: [PATCH] Re-xmit: module_put_and_exit
Date: Fri, 18 Jul 2003 11:58:15 +1000
Message-Id: <20030718021559.12AFD2C5A4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply.  Neil wants this for safety of his kernel threads in
modules (which hold a reference count).

Name: module_put_and_exit
Author: Neil Brown
Status: Booted on 2.5.74-bk1

D: Define module_put_and_exit() and use it for nfsd/lockd
D: 
D: Both nfsd and lockd have threads which expect to hold a reference
D: to the module while the thread is running.  In order for the thread
D: to be able to put_module() the module before exiting, the
D: put_module code must be call from outside the module.
D: 
D: This patch provides module_put_and_exit in non-modular code which a
D: thread-in-a-module can call.  It also gets nfsd and lockd to use it
D: as appropriate.
D: 
D: Note that in lockd, we can __get_module in the thread itself as the
D: creator of the thread is waiting for the thread to startup.
D: 
D: In nfsd and for the 'reclaimer' threaded started by locked, we
D: __get_module first and put_module if the thread failed to start.
D: 
D:  ----------- Diffstat output ------------
D:  ./fs/lockd/clntlock.c    |    9 ++++-----
D:  ./fs/lockd/svc.c         |    8 ++++++--
D:  ./fs/nfsd/nfssvc.c       |    8 +++++---
D:  ./include/linux/module.h |    8 ++++++++
D:  ./kernel/exit.c          |    1 +
D:  ./kernel/module.c        |   12 ++++++++++++
D:  6 files changed, 36 insertions(+), 10 deletions(-)

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25804-linux-2.5.74-bk1/fs/lockd/clntlock.c .25804-linux-2.5.74-bk1.updated/fs/lockd/clntlock.c
--- .25804-linux-2.5.74-bk1/fs/lockd/clntlock.c	2003-02-17 11:37:52.000000000 +1100
+++ .25804-linux-2.5.74-bk1.updated/fs/lockd/clntlock.c	2003-07-04 07:58:04.000000000 +1000
@@ -187,8 +187,9 @@ nlmclnt_recovery(struct nlm_host *host, 
 	} else {
 		nlmclnt_prepare_reclaim(host, newstate);
 		nlm_get_host(host);
-		MOD_INC_USE_COUNT;
-		kernel_thread(reclaimer, host, CLONE_KERNEL);
+		__module_get(THIS_MODULE);
+		if (kernel_thread(reclaimer, host, CLONE_KERNEL))
+			module_put(THIS_MODULE);
 	}
 }
 
@@ -244,7 +245,5 @@ restart:
 	nlm_release_host(host);
 	lockd_down();
 	unlock_kernel();
-	MOD_DEC_USE_COUNT;
-
-	return 0;
+	module_put_and_exit(0);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25804-linux-2.5.74-bk1/fs/lockd/svc.c .25804-linux-2.5.74-bk1.updated/fs/lockd/svc.c
--- .25804-linux-2.5.74-bk1/fs/lockd/svc.c	2003-07-03 09:43:54.000000000 +1000
+++ .25804-linux-2.5.74-bk1.updated/fs/lockd/svc.c	2003-07-04 07:58:04.000000000 +1000
@@ -88,7 +88,11 @@ lockd(struct svc_rqst *rqstp)
 	unsigned long grace_period_expire;
 
 	/* Lock module and set up kernel thread */
-	MOD_INC_USE_COUNT;
+	/* lockd_up is waiting for us to startup, so will
+	 * be holding a reference to this module, so it
+	 * is safe to just claim another reference
+	 */
+	__module_get(THIS_MODULE);
 	lock_kernel();
 
 	/*
@@ -183,7 +187,7 @@ lockd(struct svc_rqst *rqstp)
 
 	/* Release module */
 	unlock_kernel();
-	MOD_DEC_USE_COUNT;
+	module_put_and_exit(0);
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25804-linux-2.5.74-bk1/fs/nfsd/nfssvc.c .25804-linux-2.5.74-bk1.updated/fs/nfsd/nfssvc.c
--- .25804-linux-2.5.74-bk1/fs/nfsd/nfssvc.c	2003-07-03 09:43:54.000000000 +1000
+++ .25804-linux-2.5.74-bk1.updated/fs/nfsd/nfssvc.c	2003-07-04 07:58:04.000000000 +1000
@@ -115,9 +115,12 @@ nfsd_svc(unsigned short port, int nrserv
 	nrservs -= (nfsd_serv->sv_nrthreads-1);
 	while (nrservs > 0) {
 		nrservs--;
+		__module_get(THIS_MODULE);
 		error = svc_create_thread(nfsd, nfsd_serv);
-		if (error < 0)
+		if (error < 0) {
+			module_put(THIS_MODULE);
 			break;
+		}
 	}
 	victim = nfsd_list.next;
 	while (nrservs < 0 && victim != &nfsd_list) {
@@ -173,7 +176,6 @@ nfsd(struct svc_rqst *rqstp)
 	sigset_t shutdown_mask, allowed_mask;
 
 	/* Lock module and set up kernel thread */
-	MOD_INC_USE_COUNT;
 	lock_kernel();
 	daemonize("nfsd");
 	current->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
@@ -266,7 +268,7 @@ nfsd(struct svc_rqst *rqstp)
 	svc_exit_thread(rqstp);
 
 	/* Release module */
-	MOD_DEC_USE_COUNT;
+	module_put_and_exit(0);
 }
 
 int
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25804-linux-2.5.74-bk1/include/linux/module.h .25804-linux-2.5.74-bk1.updated/include/linux/module.h
--- .25804-linux-2.5.74-bk1/include/linux/module.h	2003-07-03 09:44:00.000000000 +1000
+++ .25804-linux-2.5.74-bk1.updated/include/linux/module.h	2003-07-04 08:00:09.000000000 +1000
@@ -276,8 +276,12 @@ struct module *module_get_kallsym(unsign
 				  char *type,
 				  char namebuf[128]);
 int is_exported(const char *name, const struct module *mod);
-#ifdef CONFIG_MODULE_UNLOAD
 
+extern void __module_put_and_exit(struct module *mod, long code)
+	__attribute__((noreturn));
+#define module_put_and_exit(code) __module_put_and_exit(THIS_MODULE, code);
+
+#ifdef CONFIG_MODULE_UNLOAD
 unsigned int module_refcount(struct module *mod);
 void __symbol_put(const char *symbol);
 #define symbol_put(x) __symbol_put(MODULE_SYMBOL_PREFIX #x)
@@ -445,6 +449,8 @@ static inline int unregister_module_noti
 	return 0;
 }
 
+#define module_put_and_exit(code) do_exit(code)
+
 #endif /* CONFIG_MODULES */
 
 #ifdef MODULE
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25804-linux-2.5.74-bk1/kernel/module.c .25804-linux-2.5.74-bk1.updated/kernel/module.c
--- .25804-linux-2.5.74-bk1/kernel/module.c	2003-07-03 09:44:01.000000000 +1000
+++ .25804-linux-2.5.74-bk1.updated/kernel/module.c	2003-07-04 07:59:20.000000000 +1000
@@ -98,6 +98,17 @@ int init_module(void)
 }
 EXPORT_SYMBOL(init_module);
 
+/* A thread that wants to hold a reference to a module only while it
+ * is running can call ths to safely exit.
+ * nfsd and lockd use this.
+ */
+void __module_put_and_exit(struct module *mod, long code)
+{
+	module_put(mod);
+	do_exit(code);
+}
+EXPORT_SYMBOL(__module_put_and_exit);
+	
 /* Find a module section: 0 means not found. */
 static unsigned int find_sec(Elf_Ehdr *hdr,
 			     Elf_Shdr *sechdrs,

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
