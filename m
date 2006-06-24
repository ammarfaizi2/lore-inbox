Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932741AbWFXAmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbWFXAmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWFXAmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:42:00 -0400
Received: from narn.hozed.org ([209.234.73.39]:2522 "EHLO narn.hozed.org")
	by vger.kernel.org with ESMTP id S932741AbWFXAl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:41:59 -0400
Date: Fri, 23 Jun 2006 19:41:59 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: Change in-kernel afs client filesystem name to 'kafs'
Message-ID: <20060624004154.GL5040@narn.hozed.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_narn.hozed.org-10411-1151109719-0001-2"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_narn.hozed.org-10411-1151109719-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch changes the in-kernel AFS client filesystem name to 'kafs',
as well as allowing the AFS cache manager port to be set as a module
parameter. This is usefull for having a system boot with the root
filesystem on afs with the kernel AFS client, while still having the
option of loading the OpenAFS kernel module for use as a read-write
filesystem later.

Signed-off-by: Troy Benjegerdes <hozer@hozed.org>



--=_narn.hozed.org-10411-1151109719-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="kafs.patch"

# HG changeset patch
# User hozer@minbar-g5.scl.ameslab.gov
# Node ID f2b66f75ac858c7eacf681c73ddad3f0058df480
# Parent  28e3d8204fdbfc0f2bef6dd513ab79184047a1ab
Change mount name to 'kafs' and allow setting the cache manager port

diff -r 28e3d8204fdb -r f2b66f75ac85 fs/afs/main.c
--- a/fs/afs/main.c	Fri Jun 23 22:47:27 2006 +0700
+++ b/fs/afs/main.c	Fri Jun 23 18:11:35 2006 -0500
@@ -42,6 +42,11 @@ module_param(rootcell, charp, 0);
 module_param(rootcell, charp, 0);
 MODULE_PARM_DESC(rootcell, "root AFS cell name and VL server IP addr list");
 
+static uint rxrpc_port = 7001;
+
+module_param(rxrpc_port, uint, 0);
+MODULE_PARM_DESC(rxrpc_port, "kAFS cache manager port (default 7001)");
+
 
 static struct rxrpc_peer_ops afs_peer_ops = {
 	.adding		= afs_adding_peer,
@@ -57,7 +62,7 @@ static struct cachefs_netfs_operations a
 };
 
 struct cachefs_netfs afs_cache_netfs = {
-	.name			= "afs",
+	.name			= "kafs",
 	.version		= 0,
 	.ops			= &afs_cache_ops,
 };
@@ -71,7 +76,8 @@ static int __init afs_init(void)
 {
 	int loop, ret;
 
-	printk(KERN_INFO "kAFS: Red Hat AFS client v0.1 registering.\n");
+	printk(KERN_INFO "kAFS: Red Hat AFS client v0.1 registering, using port %d.\n",
+			rxrpc_port);
 
 	/* initialise the callback hash table */
 	spin_lock_init(&afs_cb_hash_lock);
@@ -113,7 +119,7 @@ static int __init afs_init(void)
 		goto error_kafstimod;
 
 	/* create the RxRPC transport */
-	ret = rxrpc_create_transport(7001, &afs_transport);
+	ret = rxrpc_create_transport(rxrpc_port, &afs_transport);
 	if (ret < 0)
 		goto error_kafsasyncd;
 
diff -r 28e3d8204fdb -r f2b66f75ac85 fs/afs/mntpt.c
--- a/fs/afs/mntpt.c	Fri Jun 23 22:47:27 2006 +0700
+++ b/fs/afs/mntpt.c	Fri Jun 23 18:11:35 2006 -0500
@@ -203,7 +203,7 @@ static struct vfsmount *afs_mntpt_do_aut
 
 	/* try and do the mount */
 	kdebug("--- attempting mount %s -o %s ---", devname, options);
-	mnt = do_kern_mount("afs", 0, devname, options);
+	mnt = do_kern_mount("kafs", 0, devname, options);
 	kdebug("--- mount result %p ---", mnt);
 
 	free_page((unsigned long) devname);
diff -r 28e3d8204fdb -r f2b66f75ac85 fs/afs/super.c
--- a/fs/afs/super.c	Fri Jun 23 22:47:27 2006 +0700
+++ b/fs/afs/super.c	Fri Jun 23 18:11:35 2006 -0500
@@ -50,7 +50,7 @@ static void afs_destroy_inode(struct ino
 
 static struct file_system_type afs_fs_type = {
 	.owner		= THIS_MODULE,
-	.name		= "afs",
+	.name		= "kafs",
 	.get_sb		= afs_get_sb,
 	.kill_sb	= kill_anon_super,
 	.fs_flags	= FS_BINARY_MOUNTDATA,

--=_narn.hozed.org-10411-1151109719-0001-2--
