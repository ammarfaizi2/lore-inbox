Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289056AbSBMWq4>; Wed, 13 Feb 2002 17:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSBMWqq>; Wed, 13 Feb 2002 17:46:46 -0500
Received: from relay04.valueweb.net ([216.219.253.238]:26130 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S289047AbSBMWqk>; Wed, 13 Feb 2002 17:46:40 -0500
From: Craig Christophel <merlin@transgeek.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] -- filesystems.c::sys_nfsservctl 2.5.5-pre1
Date: Wed, 13 Feb 2002 17:46:26 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
In-Reply-To: <20020213205144Z282414-24962+32@thor.valueweb.net> <shsd6z9dqes.fsf@charged.uio.no>
In-Reply-To: <shsd6z9dqes.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_EXTHK8KXV23EIECJ89Z1"
Message-Id: <20020213224618Z281597-18043+38@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_EXTHK8KXV23EIECJ89Z1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> What would remain to protect 'nfsd_linkage' if you removed the BKL?


ok here is a patch with that changed. inlined for commenting and attached for 
patching.  (kmail screws up my inlines occasionally) 
All of this extra checking is only in place if nfsd is a module.  rw_sems 
shouldn't impost that much overhead in the normal case.  

	The while is there to catch extremely unlikely cases of the module unloading 
during this loop, ie:  the cleanup_module section of nfsd is waiting for the 
semaphore.

===== fs/filesystems.c 1.4 vs edited =====
--- 1.4/fs/filesystems.c	Fri Feb  8 22:10:55 2002
+++ edited/fs/filesystems.c	Wed Feb 13 17:43:41 2002
@@ -16,19 +16,28 @@
 
 #if defined(CONFIG_NFSD_MODULE)
 struct nfsd_linkage *nfsd_linkage = NULL;
+DECLARE_RWSEM(nfsd_linkage_lock);
 
 long
 asmlinkage sys_nfsservctl(int cmd, void *argp, void *resp)
 {
 	int ret = -ENOSYS;
 	
-	lock_kernel();
-
-	if (nfsd_linkage ||
-	    (request_module ("nfsd") == 0 && nfsd_linkage))
-		ret = nfsd_linkage->do_nfsservctl(cmd, argp, resp);
-
-	unlock_kernel();
+	down_read(&nfsd_linkage_lock);
+	while(!nfsd_linkage) {
+		up_read(&nfsd_linkage_lock);
+		down_write(&nfsd_linkage_lock);
+		if (!nfsd_linkage)
+			if (request_module ("nfsd") != 0) {
+				up_write(&nfsd_linkage_lock);
+				goto out;
+			}
+		up_write(&nfsd_linkage_lock);
+		down_read(&nfsd_linkage_lock);
+	}
+	ret = nfsd_linkage->do_nfsservctl(cmd, argp, resp);
+	up_read(&nfsd_linkage_lock);
+out:
 	return ret;
 }
 EXPORT_SYMBOL(nfsd_linkage);
===== fs/nfsd/nfsctl.c 1.10 vs edited =====
--- 1.10/fs/nfsd/nfsctl.c	Fri Feb  8 22:10:55 2002
+++ edited/fs/nfsd/nfsctl.c	Wed Feb 13 17:33:17 2002
@@ -290,6 +290,7 @@
 	do_nfsservctl: handle_sys_nfsservctl,
 };
 
+extern struct nfsd_linkage_lock;
 /*
  * Initialize the module
  */
@@ -307,7 +308,9 @@
 void
 cleanup_module(void)
 {
+	down_write(&nfsd_linkage_lock);
 	nfsd_linkage = NULL;
+	up_write(&nfsd_linkage_lock);
 	nfsd_export_shutdown();
 	nfsd_cache_shutdown();
 	remove_proc_entry("fs/nfs/exports", NULL);

--------------Boundary-00=_EXTHK8KXV23EIECJ89Z1
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="filesystems-remove-lock_kernel-nfsd.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="filesystems-remove-lock_kernel-nfsd.diff"

===== fs/filesystems.c 1.4 vs edited =====
--- 1.4/fs/filesystems.c	Fri Feb  8 22:10:55 2002
+++ edited/fs/filesystems.c	Wed Feb 13 17:43:41 2002
@@ -16,19 +16,28 @@
 
 #if defined(CONFIG_NFSD_MODULE)
 struct nfsd_linkage *nfsd_linkage = NULL;
+DECLARE_RWSEM(nfsd_linkage_lock);
 
 long
 asmlinkage sys_nfsservctl(int cmd, void *argp, void *resp)
 {
 	int ret = -ENOSYS;
 	
-	lock_kernel();
-
-	if (nfsd_linkage ||
-	    (request_module ("nfsd") == 0 && nfsd_linkage))
-		ret = nfsd_linkage->do_nfsservctl(cmd, argp, resp);
-
-	unlock_kernel();
+	down_read(&nfsd_linkage_lock);
+	while(!nfsd_linkage) {
+		up_read(&nfsd_linkage_lock);
+		down_write(&nfsd_linkage_lock);
+		if (!nfsd_linkage)
+			if (request_module ("nfsd") != 0) {
+				up_write(&nfsd_linkage_lock);
+				goto out;
+			}
+		up_write(&nfsd_linkage_lock);
+		down_read(&nfsd_linkage_lock);
+	}
+	ret = nfsd_linkage->do_nfsservctl(cmd, argp, resp);
+	up_read(&nfsd_linkage_lock);
+out:
 	return ret;
 }
 EXPORT_SYMBOL(nfsd_linkage);
===== fs/nfsd/nfsctl.c 1.10 vs edited =====
--- 1.10/fs/nfsd/nfsctl.c	Fri Feb  8 22:10:55 2002
+++ edited/fs/nfsd/nfsctl.c	Wed Feb 13 17:33:17 2002
@@ -290,6 +290,7 @@
 	do_nfsservctl: handle_sys_nfsservctl,
 };
 
+extern struct nfsd_linkage_lock;
 /*
  * Initialize the module
  */
@@ -307,7 +308,9 @@
 void
 cleanup_module(void)
 {
+	down_write(&nfsd_linkage_lock);
 	nfsd_linkage = NULL;
+	up_write(&nfsd_linkage_lock);
 	nfsd_export_shutdown();
 	nfsd_cache_shutdown();
 	remove_proc_entry("fs/nfs/exports", NULL);

--------------Boundary-00=_EXTHK8KXV23EIECJ89Z1--
