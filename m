Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbUKCVs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbUKCVs0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUKCVqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:46:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52493 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261891AbUKCVoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:44:30 -0500
Date: Wed, 3 Nov 2004 22:43:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Olaf Kirch <okir@monad.swb.de>
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill lockd_syms.c
Message-ID: <20041103214352.GC31830@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below kills lockd_syms.c .


diffstat output:
 fs/lockd/Makefile     |    2 +-
 fs/lockd/clntproc.c   |    2 ++
 fs/lockd/lockd_syms.c |   36 ------------------------------------
 fs/lockd/svc.c        |    5 +++++
 4 files changed, 8 insertions(+), 37 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/lockd/lockd_syms.c	2004-10-18 23:54:32.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,36 +0,0 @@
-/*
- * linux/fs/lockd/lockd_syms.c
- *
- * Symbols exported by the lockd module.
- *
- * Authors:	Olaf Kirch (okir@monad.swb.de)
- *
- * Copyright (C) 1997 Olaf Kirch <okir@monad.swb.de>
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-
-#ifdef CONFIG_MODULES
-
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/time.h>
-#include <linux/uio.h>
-#include <linux/unistd.h>
-
-#include <linux/sunrpc/clnt.h>
-#include <linux/sunrpc/svc.h>
-#include <linux/lockd/lockd.h>
-
-/* Start/stop the daemon */
-EXPORT_SYMBOL(lockd_up);
-EXPORT_SYMBOL(lockd_down);
-
-/* NFS client entry */
-EXPORT_SYMBOL(nlmclnt_proc);
-
-/* NFS server entry points/hooks */
-EXPORT_SYMBOL(nlmsvc_ops);
-
-#endif /* CONFIG_MODULES */
--- linux-2.6.10-rc1-mm2-full/fs/lockd/Makefile.old	2004-11-03 22:12:29.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/fs/lockd/Makefile	2004-11-03 22:12:52.000000000 +0100
@@ -5,6 +5,6 @@
 obj-$(CONFIG_LOCKD) += lockd.o
 
 lockd-objs-y := clntlock.o clntproc.o host.o svc.o svclock.o svcshare.o \
-	        svcproc.o svcsubs.o mon.o xdr.o lockd_syms.o
+	        svcproc.o svcsubs.o mon.o xdr.o
 lockd-objs-$(CONFIG_LOCKD_V4) += xdr4.o svc4proc.o
 lockd-objs		      := $(lockd-objs-y)
--- linux-2.6.10-rc1-mm2-full/fs/lockd/svc.c.old	2004-11-03 22:36:01.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/fs/lockd/svc.c	2004-11-03 22:37:17.000000000 +0100
@@ -39,7 +39,10 @@
 #define ALLOWED_SIGS		(sigmask(SIGKILL))
 
 extern struct svc_program	nlmsvc_program;
+
 struct nlmsvc_binding *		nlmsvc_ops;
+EXPORT_SYMBOL(nlmsvc_ops);
+
 static DECLARE_MUTEX(nlmsvc_sema);
 static unsigned int		nlmsvc_users;
 static pid_t			nlmsvc_pid;
@@ -270,6 +273,7 @@
 	up(&nlmsvc_sema);
 	return error;
 }
+EXPORT_SYMBOL(lockd_up);
 
 /*
  * Decrement the user count and bring down lockd if we're the last.
@@ -311,6 +315,7 @@
 out:
 	up(&nlmsvc_sema);
 }
+EXPORT_SYMBOL(lockd_down);
 
 /*
  * Sysctl parameters (same as module parameters, different interface).
--- linux-2.6.10-rc1-mm2-full/fs/lockd/clntproc.c.old	2004-11-03 22:12:30.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/fs/lockd/clntproc.c	2004-11-03 22:16:29.000000000 +0100
@@ -7,6 +7,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -278,6 +279,7 @@
 	nlm_release_host(host);
 	return status;
 }
+EXPORT_SYMBOL(nlmclnt_proc);
 
 /*
  * Allocate an NLM RPC call struct
