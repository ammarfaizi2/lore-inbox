Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbSKGWeR>; Thu, 7 Nov 2002 17:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266614AbSKGWeQ>; Thu, 7 Nov 2002 17:34:16 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:12928 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S266609AbSKGWeN>; Thu, 7 Nov 2002 17:34:13 -0500
Date: Thu, 7 Nov 2002 17:40:50 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] allow nfsroot to mount with TCP
Message-ID: <Pine.LNX.4.44.0211071738150.18237-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nfsroot needs to pass the network protocol (UDP/TCP) into the mount
functions in order to support mounting root partitions via NFS over TCP.

against 2.5.46.  same patch already applied to 2.4.20-pre.


diff -ruN 04-rto-cleanup/fs/nfs/mount_clnt.c 05-nfsroot/fs/nfs/mount_clnt.c
--- 04-rto-cleanup/fs/nfs/mount_clnt.c	Mon Nov  4 17:30:05 2002
+++ 05-nfsroot/fs/nfs/mount_clnt.c	Thu Nov  7 17:29:59 2002
@@ -29,10 +29,9 @@
 #define MOUNT_UMNT		3
  */
 
-static int			nfs_gen_mount(struct sockaddr_in *,
-					      char *, struct nfs_fh *, int);
-static struct rpc_clnt *	mnt_create(char *, struct sockaddr_in *, int);
-extern struct rpc_program	mnt_program;
+static struct rpc_clnt *	mnt_create(char *, struct sockaddr_in *,
+								int, int);
+struct rpc_program		mnt_program;
 
 struct mnt_fhstatus {
 	unsigned int		status;
@@ -43,19 +42,8 @@
  * Obtain an NFS file handle for the given host and path
  */
 int
-nfs_mount(struct sockaddr_in *addr, char *path, struct nfs_fh *fh)
-{
-	return nfs_gen_mount(addr, path, fh, NFS_MNT_VERSION);
-}
-
-int
-nfs3_mount(struct sockaddr_in *addr, char *path, struct nfs_fh *fh)
-{
-	return nfs_gen_mount(addr, path, fh, NFS_MNT3_VERSION);
-}
-
-static int
-nfs_gen_mount(struct sockaddr_in *addr, char *path, struct nfs_fh *fh, int version)
+nfsroot_mount(struct sockaddr_in *addr, char *path, struct nfs_fh *fh,
+		int version, int protocol)
 {
 	struct rpc_clnt		*mnt_clnt;
 	struct mnt_fhstatus	result = {
@@ -69,21 +57,22 @@
 			(unsigned)ntohl(addr->sin_addr.s_addr), path);
 
 	sprintf(hostname, "%u.%u.%u.%u", NIPQUAD(addr->sin_addr.s_addr));
-	if (!(mnt_clnt = mnt_create(hostname, addr, version)))
+	if (!(mnt_clnt = mnt_create(hostname, addr, version, protocol)))
 		return -EACCES;
 
-	call = (version == 3) ? MOUNTPROC3_MNT : MNTPROC_MNT;
+	call = (version == NFS_MNT3_VERSION) ? MOUNTPROC3_MNT : MNTPROC_MNT;
 	status = rpc_call(mnt_clnt, call, path, &result, 0);
 	return status < 0? status : (result.status? -EACCES : 0);
 }
 
 static struct rpc_clnt *
-mnt_create(char *hostname, struct sockaddr_in *srvaddr, int version)
+mnt_create(char *hostname, struct sockaddr_in *srvaddr, int version,
+		int protocol)
 {
 	struct rpc_xprt	*xprt;
 	struct rpc_clnt	*clnt;
 
-	if (!(xprt = xprt_create_proto(IPPROTO_UDP, srvaddr, NULL)))
+	if (!(xprt = xprt_create_proto(protocol, srvaddr, NULL)))
 		return NULL;
 
 	clnt = rpc_create_client(xprt, hostname,
diff -ruN 04-rto-cleanup/fs/nfs/nfsroot.c 05-nfsroot/fs/nfs/nfsroot.c
--- 04-rto-cleanup/fs/nfs/nfsroot.c	Mon Nov  4 17:30:38 2002
+++ 05-nfsroot/fs/nfs/nfsroot.c	Thu Nov  7 17:29:59 2002
@@ -64,6 +64,8 @@
  *	Trond Myklebust :	Add in preliminary support for NFSv3 and TCP.
  *				Fix bug in root_nfs_addr(). nfs_data.namlen
  *				is NOT for the length of the hostname.
+ *	Hua Qin		:	Support for mounting root file system via
+ *				NFS over TCP.
  */
 
 #include <linux/config.h>
@@ -440,12 +442,14 @@
 {
 	struct sockaddr_in sin;
 	int status;
+	int protocol = (nfs_data.flags & NFS_MOUNT_TCP) ?
+					IPPROTO_TCP : IPPROTO_UDP;
+	int version = (nfs_data.flags & NFS_MOUNT_VER3) ?
+					NFS_MNT3_VERSION : NFS_MNT_VERSION;
 
 	set_sockaddr(&sin, servaddr, mount_port);
-	if (nfs_data.flags & NFS_MOUNT_VER3)
-		status = nfs3_mount(&sin, nfs_path, &nfs_data.root);
-	else
-		status = nfs_mount(&sin, nfs_path, &nfs_data.root);
+	status = nfsroot_mount(&sin, nfs_path, &nfs_data.root,
+							version, protocol);
 	if (status < 0)
 		printk(KERN_ERR "Root-NFS: Server returned error %d "
 				"while mounting %s\n", status, nfs_path);
diff -ruN 04-rto-cleanup/include/linux/nfs_fs.h 05-nfsroot/include/linux/nfs_fs.h
--- 04-rto-cleanup/include/linux/nfs_fs.h	Mon Nov  4 17:30:21 2002
+++ 05-nfsroot/include/linux/nfs_fs.h	Thu Nov  7 17:29:59 2002
@@ -407,8 +407,8 @@
  * linux/fs/mount_clnt.c
  * (Used only by nfsroot module)
  */
-extern int  nfs_mount(struct sockaddr_in *, char *, struct nfs_fh *);
-extern int  nfs3_mount(struct sockaddr_in *, char *, struct nfs_fh *);
+extern int  nfsroot_mount(struct sockaddr_in *, char *, struct nfs_fh *,
+		int, int);
 
 /*
  * inline functions

