Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278050AbRKFFVp>; Tue, 6 Nov 2001 00:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRKFFVh>; Tue, 6 Nov 2001 00:21:37 -0500
Received: from trout.hpc.CSIRO.AU ([138.194.72.10]:10399 "EHLO
	trout.hpc.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S276956AbRKFFVa>; Tue, 6 Nov 2001 00:21:30 -0500
Message-Id: <200111060521.QAA07024@trout.hpc.CSIRO.AU>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Pete Wyckoff <pw@osc.edu>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Red Hat needs this patch (was Re: handling NFSERR_JUKEBOX)
In-Reply-To: Your message of "Fri, 13 Jul 2001 10:06:50 -0400."
             <20010713100650.D25733@osc.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Nov 2001 16:21:14 +1100
From: Bob Smart <smart@hpc.CSIRO.AU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Take a look at the nfs sourceforge mailing list.  There's a long thread
> about this in the context of a Solaris HSM server.  I wrote a patch to
> try to do the right thing on a linux client, but it is not perfect for
> many reasons: http://devrandom.net/lists/archives/2001/6/NFS/0135.html

Thanks again for this patch. I've appended our current version to
save others the trouble of minor modifications. I've just tested
it against 2.4.13-ac7. 

Your patch may not be perfect but it is a million times better than
nothing. We have had no problems with it. Linux has a long tradition 
of utilizing imperfect software till something better comes along.

This patch is ESSENTIAL to make Linux useable in large enterprises,
because they increasingly commonly utilize hirearchically managed
storage. I strongly urge Alan/Linus/Macello to include this patch
in the stable kernel tree (but marked experimental). Or at least
can the kernel maintainers at Red Hat and other distributions put
it in their offerings: surely you see that you need this for your
big customers.

I understand that some people think the problem should be addressed 
in glibc (+ all other places that do open system calls). Well really
this is just a small part of a much wider problem. I've included a
rant below. The bottom line is that default "wait as long as necessary"
behaviour should be provided by the kernel, but there needs to be an
optional mechanism that lets the user know when things will take longer
than expected.

Cheers,

Bob

-----------------------------------------------------------------------------

Handling long latency events
----------------------------

The linux kernel potentially returns the error EJUKEBOX from
some operations. This error means: "This operation might well
succeed eventually, and I've started the task [e.g. get
file from tape] that will cause it to later succeed. However
since it will take a long time I'm returning this error so
that you can: inform the user; wait a while; then retry the op."
Now that NFS servers are starting to use NFSERR_JUKEBOX returns,
(which get turned into EJUKEBOX if you don't have the Wyckoff
patch) this is starting to happen and we find that linux user
mode software doesn't handle it.

Getting a file from tape is just one of many circumstances where
operations sometimes take an unexpectedly long time. Other cases
typcially revolve around network operations where remote servers
are not responding for one reason or another. As use of network
services increases this problem is getting worse.

We need to be able to handle these situations in 2 different ways.
If it is a batch or background operation then most of the time
we just want it to wait. Typical example: a telnet server shouldn't
drop a terminal session just because the client has been out of
touch for an hour because of network problems. On the other hand
if the software is interacting with the user and suddenly there
are delays, then we want to give the user useful feedback and
also allow the user to kill the operation. A typical example is
a telnet client [and the (old?) windows behaviour of locking up
is particularly annoying].

It seems to me that the right unixy solution to this problem is
through signals. The EJUKEBOX idea is regretable. However it has
happened and we need to handle it. I strongly urge that:

 - default behaviour is for the kernel to wait and never return 
   EJUKEBOX.

 - however user programs that want to handle EJUKEBOX should
   be able to put themselves into a mode where EJUKEBOX is returned.

This approach has the advantage of minimizing impact on existing
user mode software. If you accept my argument then Pete Wyckoff's
patch is a step in the right direction.

-----------------------------------------------------------------------------

diff -r -u --exclude='*.orig' SAVE/linux-2.4.13-0.3/Documentation/Configure.help linux-2.4.13-0.3+jukebox/Documentation/Configure.help
--- SAVE/linux-2.4.13-0.3/Documentation/Configure.help	Tue Oct 30 09:19:01 2001
+++ linux-2.4.13-0.3+jukebox/Documentation/Configure.help	Sun Nov  4 14:03:59 2001
@@ -14094,6 +14094,23 @@
 
   If unsure, say N.
 
+Auto-retry jukebox error requests (EXPERIMENTAL)
+CONFIG_NFS_V3_JUKEBOX_RETRY
+  Say Y here if you want your NFS client to automatically retry requests
+  to which the server responded with EJUKEBOX (528).  Some NFS servers
+  export filesystems which are hierarchical, in that some files may take
+  much longer than others to read or write.  These files may be migrated
+  to a slow tape storage system which serves as the bulk capacity for the
+  file system; the fast disk becomes essentially a cache.
+
+  If you try to read a file which has been migrated to tape, the server
+  may return the error EJUKEBOX and begin the process which brings the
+  file from tape to disk.  This option enables the kernel to retry
+  the access until the file is ready, rather than passing the error to
+  userspace applications, which is the default.
+ 
+  If unsure, say N.
+
 Root file system on NFS
 CONFIG_ROOT_NFS
   If you want your Linux box to mount its whole root file system (the
diff -r -u --exclude='*.orig' SAVE/linux-2.4.13-0.3/fs/Config.in linux-2.4.13-0.3+jukebox/fs/Config.in
--- SAVE/linux-2.4.13-0.3/fs/Config.in	Tue Oct 30 09:18:42 2001
+++ linux-2.4.13-0.3+jukebox/fs/Config.in	Sun Nov  4 14:03:59 2001
@@ -95,6 +95,7 @@
    dep_tristate 'InterMezzo file system support (experimental, replicating fs)' CONFIG_INTERMEZZO_FS $CONFIG_INET $CONFIG_EXPERIMENTAL
    dep_tristate 'NFS file system support' CONFIG_NFS_FS $CONFIG_INET
    dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
+   dep_mbool '    Auto-retry jukebox error requests' CONFIG_NFS_V3_JUKEBOX_RETRY $CONFIG_NFS_V3
    dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS $CONFIG_IP_PNP
 
    dep_tristate 'NFS server support' CONFIG_NFSD $CONFIG_INET
diff -r -u --exclude='*.orig' SAVE/linux-2.4.13-0.3/fs/nfs/file.c linux-2.4.13-0.3+jukebox/fs/nfs/file.c
--- SAVE/linux-2.4.13-0.3/fs/nfs/file.c	Mon Sep 24 02:48:01 2001
+++ linux-2.4.13-0.3+jukebox/fs/nfs/file.c	Sun Nov  4 15:17:14 2001
@@ -192,8 +192,19 @@
 	if (!inode)
 		return 0;
 
+#ifdef CONFIG_NFS_V3_JUKEBOX_RETRY
+        /* perhaps nfsv3 server returned jukebox, go try again */
+        /* if (PageError(page) && inode->u.nfs_i.async_error == -EJUKEBOX) {
+                result = nfs_readpage_sync(inode->u.nfs_i.file, inode, page); */
+        if (PageError(page) && NFS_I(inode)->async_error == -EJUKEBOX) {
+                result = nfs_readpage_sync(NFS_I(inode)->file, inode, page);
+        } else
+#endif
+        {
 	rpages = NFS_SERVER(inode)->rpages;
 	result = nfs_pagein_inode(inode, index, rpages);
+        }
+
 	if (result < 0)
 		return result;
 	return 0;
diff -r -u --exclude='*.orig' SAVE/linux-2.4.13-0.3/fs/nfs/nfs3proc.c linux-2.4.13-0.3+jukebox/fs/nfs/nfs3proc.c
--- SAVE/linux-2.4.13-0.3/fs/nfs/nfs3proc.c	Tue Oct  2 06:45:37 2001
+++ linux-2.4.13-0.3+jukebox/fs/nfs/nfs3proc.c	Sun Nov  4 16:28:09 2001
@@ -4,6 +4,8 @@
  *  Client-side NFSv3 procedures stubs.
  *
  *  Copyright (C) 1997, Olaf Kirch
+ *
+ *  21 Jun 01 - Retry NFSv3 EJUKEBOX errors by Pete Wyckoff 
  */
 
 #include <linux/mm.h>
@@ -56,10 +58,25 @@
 	struct nfs3_sattrargs	arg = { NFS_FH(inode), sattr, 0, 0 };
 	int	status;
 
+        for (;;) {
 	dprintk("NFS call  setattr\n");
 	fattr->valid = 0;
-	status = rpc_call(NFS_CLIENT(inode), NFS3PROC_SETATTR, &arg, fattr, 0);
-	dprintk("NFS reply setattr\n");
+                status = rpc_call(NFS_CLIENT(inode), NFS3PROC_SETATTR, &arg,
+                    fattr, 0);
+                dprintk("NFS reply setattr %d\n", status);
+#ifdef CONFIG_NFS_V3_JUKEBOX_RETRY
+                if (status == -EJUKEBOX) {
+                        DECLARE_WAIT_QUEUE_HEAD(jukebox_wq);
+                        tty_write_message(current->tty,
+                          "NFSv3: write waiting for file unmigration\r\n");
+                        if (interruptible_sleep_on_timeout(&jukebox_wq,
+                            NFS_JUKEBOX_RETRY_TIMEO) == 0)
+                                continue;  /* but not if interrupted */
+                }
+#endif
+                break;
+        }
+
 	return status;
 }
 
@@ -147,10 +164,24 @@
 	struct rpc_message	msg = { NFS3PROC_READ, &arg, &res, cred };
 	int			status;
 
+        for (;;) {
 	dprintk("NFS call  read %d @ %Ld\n", count, (long long)offset);
 	fattr->valid = 0;
 	status = rpc_call_sync(NFS_CLIENT(inode), &msg, flags);
 	dprintk("NFS reply read: %d\n", status);
+#ifdef CONFIG_NFS_V3_JUKEBOX_RETRY
+                if (status == -EJUKEBOX) {
+                        DECLARE_WAIT_QUEUE_HEAD(jukebox_wq);
+                        tty_write_message(current->tty,
+                          "NFSv3: read waiting for file unmigration\r\n");
+                        if (interruptible_sleep_on_timeout(&jukebox_wq,
+                            NFS_JUKEBOX_RETRY_TIMEO) == 0)
+                                continue;  /* but not if interrupted */
+                }
+#endif
+                break;
+        }
+
 	*eofp = res.eof;
 	return status;
 }
@@ -177,7 +208,7 @@
 
 	status = rpc_call_sync(NFS_CLIENT(inode), &msg, rpcflags);
 
-	dprintk("NFS reply read: %d\n", status);
+	dprintk("NFS reply write: %d\n", status);
 	return status < 0? status : res.count;
 }
 
diff -r -u --exclude='*.orig' SAVE/linux-2.4.13-0.3/fs/nfs/read.c linux-2.4.13-0.3+jukebox/fs/nfs/read.c
--- SAVE/linux-2.4.13-0.3/fs/nfs/read.c	Tue Oct 30 09:18:42 2001
+++ linux-2.4.13-0.3+jukebox/fs/nfs/read.c	Sun Nov  4 15:28:38 2001
@@ -81,7 +81,7 @@
 /*
  * Read a page synchronously.
  */
-static int
+int
 nfs_readpage_sync(struct file *file, struct inode *inode, struct page *page)
 {
 	struct rpc_cred	*cred = NULL;
@@ -449,11 +449,27 @@
 		if (task->tk_status >= 0 && count >= 0) {
 			SetPageUptodate(page);
 			count -= PAGE_CACHE_SIZE;
-		} else
+			flush_dcache_page(page);
+                        kunmap(page);
+                        UnlockPage(page);
+		} else {
 			SetPageError(page);
 		flush_dcache_page(page);
 		kunmap(page);
+#ifdef CONFIG_NFS_V3_JUKEBOX_RETRY
+                        /* do not unlock page, let nfs_sync_page retry */
+                        if (task->tk_status == -EJUKEBOX) {
+                                NFS_I(inode)->async_error = task->tk_status;
+                                if (waitqueue_active(&page->wait))
+                                        wake_up(&page->wait);
+                                else  /* nobody waiting, just unlock */
 		UnlockPage(page);
+                        } else
+#endif
+                        {
+                                UnlockPage(page);
+                        }
+                }
 
 		dprintk("NFS: read (%x/%Ld %d@%Ld)\n",
                         req->wb_inode->i_dev,
@@ -504,8 +520,13 @@
 		goto out_error;
 
 	error = -1;
-	if (!PageError(page) && NFS_SERVER(inode)->rsize >= PAGE_CACHE_SIZE)
+	if (!PageError(page) && NFS_SERVER(inode)->rsize >= PAGE_CACHE_SIZE) {
+#ifdef CONFIG_NFS_V3_JUKEBOX_RETRY
+                NFS_I(inode)->file = file;
+                NFS_I(inode)->async_error = 0;
+#endif
 		error = nfs_readpage_async(file, inode, page);
+	}
 	if (error >= 0)
 		goto out;
 
diff -r -u --exclude='*.orig' SAVE/linux-2.4.13-0.3/include/linux/nfs_fs.h linux-2.4.13-0.3+jukebox/include/linux/nfs_fs.h
--- SAVE/linux-2.4.13-0.3/include/linux/nfs_fs.h	Tue Oct 30 10:04:16 2001
+++ linux-2.4.13-0.3+jukebox/include/linux/nfs_fs.h	Sun Nov  4 14:09:34 2001
@@ -104,6 +104,9 @@
 /* Inode Flags */
 #define NFS_USE_READDIRPLUS(inode)	((NFS_FLAGS(inode) & NFS_INO_ADVISE_RDPLUS) ? 1 : 0)
 
+/* Jukebox retry interval */
+#define NFS_JUKEBOX_RETRY_TIMEO		(10 * HZ)
+
 /*
  * These are the default flags for swap requests
  */
@@ -258,6 +261,7 @@
 extern int  nfs_readpage(struct file *, struct page *);
 extern int  nfs_pagein_inode(struct inode *, unsigned long, unsigned int);
 extern int  nfs_pagein_timeout(struct inode *);
+extern int  nfs_readpage_sync(struct file *, struct inode *, struct page *);
 
 /*
  * linux/fs/mount_clnt.c
diff -r -u --exclude='*.orig' SAVE/linux-2.4.13-0.3/include/linux/nfs_fs_i.h linux-2.4.13-0.3+jukebox/include/linux/nfs_fs_i.h
--- SAVE/linux-2.4.13-0.3/include/linux/nfs_fs_i.h	Tue Oct 30 10:03:46 2001
+++ linux-2.4.13-0.3+jukebox/include/linux/nfs_fs_i.h	Sun Nov  4 14:09:25 2001
@@ -75,6 +75,11 @@
 
 	/* Credentials for shared mmap */
 	struct rpc_cred		*mm_cred;
+
+#ifdef CONFIG_NFS_V3_JUKEBOX_RETRY
+        struct file *file;
+        int async_error;
+#endif
 };
 
 /*

