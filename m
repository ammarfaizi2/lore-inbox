Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWFZGYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWFZGYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 02:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWFZGYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 02:24:39 -0400
Received: from narn.hozed.org ([209.234.73.39]:6370 "EHLO narn.hozed.org")
	by vger.kernel.org with ESMTP id S964826AbWFZGYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 02:24:38 -0400
Date: Mon, 26 Jun 2006 01:24:38 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Change in-kernel afs client filesystem name to 'kafs'
Message-ID: <20060626062437.GR5040@narn.hozed.org>
References: <20060624004154.GL5040@narn.hozed.org> <1151151360.3181.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_narn.hozed.org-3342-1151303078-0001-2"
Content-Disposition: inline
In-Reply-To: <1151151360.3181.34.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_narn.hozed.org-3342-1151303078-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Jun 24, 2006 at 02:16:00PM +0200, Arjan van de Ven wrote:
> On Fri, 2006-06-23 at 19:41 -0500, Troy Benjegerdes wrote:
> > This patch changes the in-kernel AFS client filesystem name to 'kafs',
> > as well as allowing the AFS cache manager port to be set as a module
> > parameter. This is usefull for having a system boot with the root
> > filesystem on afs with the kernel AFS client, while still having the
> > option of loading the OpenAFS kernel module for use as a read-write
> > filesystem later.
> 
> sounds weird... the filesystem it implements is afs.
> your change also breaks userspace, since the fs type is a mount option
> so your change is userspace visible and means people need to fix their
> scripts...

Is something like this any better? (unfortunately I have not been able
to test it yet since ppc32 with CONFIG_KEXEC is currently broken because 
'reserve_crashkernel()' is not defined..



--=_narn.hozed.org-3342-1151303078-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="kafs2.patch"

diff -r 58a4bf8bafa2 fs/Kconfig
--- a/fs/Kconfig	Sat Jun 24 05:58:44 2006 +0700
+++ b/fs/Kconfig	Mon Jun 26 01:20:35 2006 -0500
@@ -1851,6 +1851,15 @@ config AFS_FS
 
 	  If unsure, say N.
 
+config AFS_DEFAULT_ROOTCELL
+        string "Kernel AFS client default root cell and VL server IP addr list"
+        depends on AFS_FS
+        default "grand.central.org:18.7.14.88:128.2.191.224"
+        help
+          This is the default root cell for the in-kernel AFS client. This
+	  can be changed for your local configureation either at compile
+	  time or with the 'rootcell' module parameter
+
 config RXRPC
 	tristate
 
diff -r 58a4bf8bafa2 fs/afs/internal.h
--- a/fs/afs/internal.h	Sat Jun 24 05:58:44 2006 +0700
+++ b/fs/afs/internal.h	Mon Jun 26 01:20:35 2006 -0500
@@ -100,6 +100,7 @@ extern void afs_key_unregister(void);
 #ifdef AFS_CACHING_SUPPORT
 extern struct cachefs_netfs afs_cache_netfs;
 #endif
+extern char *kafs_name;
 
 /*
  * mntpt.c
diff -r 58a4bf8bafa2 fs/afs/main.c
--- a/fs/afs/main.c	Sat Jun 24 05:58:44 2006 +0700
+++ b/fs/afs/main.c	Mon Jun 26 01:20:35 2006 -0500
@@ -37,11 +37,18 @@ MODULE_AUTHOR("Red Hat, Inc.");
 MODULE_AUTHOR("Red Hat, Inc.");
 MODULE_LICENSE("GPL");
 
-static char *rootcell;
+static char *rootcell = CONFIG_AFS_DEFAULT_ROOTCELL;
+char *kafs_name = "afs";
+static uint rxrpc_port = 7001;
 
 module_param(rootcell, charp, 0);
 MODULE_PARM_DESC(rootcell, "root AFS cell name and VL server IP addr list");
 
+module_param(rxrpc_port, uint, 0);
+MODULE_PARM_DESC(rxrpc_port, "kAFS cache manager port (default 7001)");
+
+module_param(kafs_name, charp, 0);
+MODULE_PARM_DESC(kafs_name, "kAFS filesystem name (suggest using 'kafs')");
 
 static struct rxrpc_peer_ops afs_peer_ops = {
 	.adding		= afs_adding_peer,
@@ -57,7 +64,7 @@ static struct cachefs_netfs_operations a
 };
 
 struct cachefs_netfs afs_cache_netfs = {
-	.name			= "afs",
+	.name			= kafs_name,
 	.version		= 0,
 	.ops			= &afs_cache_ops,
 };
@@ -71,7 +78,10 @@ static int __init afs_init(void)
 {
 	int loop, ret;
 
-	printk(KERN_INFO "kAFS: Red Hat AFS client v0.1 registering.\n");
+	printk(KERN_INFO "kAFS: Red Hat AFS client v0.1\n");
+	printk(KERN_INFO "registering filesystem %s using callback port %d.\n",
+			kafs_name, rxrpc_port);
+	printk(KERN_INFO "using root cell/vldb servers: %s", rootcell);
 
 	/* initialise the callback hash table */
 	spin_lock_init(&afs_cb_hash_lock);
@@ -113,7 +123,7 @@ static int __init afs_init(void)
 		goto error_kafstimod;
 
 	/* create the RxRPC transport */
-	ret = rxrpc_create_transport(7001, &afs_transport);
+	ret = rxrpc_create_transport(rxrpc_port, &afs_transport);
 	if (ret < 0)
 		goto error_kafsasyncd;
 
diff -r 58a4bf8bafa2 fs/afs/mntpt.c
--- a/fs/afs/mntpt.c	Sat Jun 24 05:58:44 2006 +0700
+++ b/fs/afs/mntpt.c	Mon Jun 26 01:20:35 2006 -0500
@@ -25,7 +25,6 @@
 #include "vnode.h"
 #include "internal.h"
 
-
 static struct dentry *afs_mntpt_lookup(struct inode *dir,
 				       struct dentry *dentry,
 				       struct nameidata *nd);
@@ -203,7 +202,7 @@ static struct vfsmount *afs_mntpt_do_aut
 
 	/* try and do the mount */
 	kdebug("--- attempting mount %s -o %s ---", devname, options);
-	mnt = do_kern_mount("afs", 0, devname, options);
+	mnt = do_kern_mount(kafs_name, 0, devname, options);
 	kdebug("--- mount result %p ---", mnt);
 
 	free_page((unsigned long) devname);
diff -r 58a4bf8bafa2 fs/afs/super.c
--- a/fs/afs/super.c	Sat Jun 24 05:58:44 2006 +0700
+++ b/fs/afs/super.c	Mon Jun 26 01:20:35 2006 -0500
@@ -50,7 +50,7 @@ static void afs_destroy_inode(struct ino
 
 static struct file_system_type afs_fs_type = {
 	.owner		= THIS_MODULE,
-	.name		= "afs",
+	.name		= NULL,
 	.get_sb		= afs_get_sb,
 	.kill_sb	= kill_anon_super,
 	.fs_flags	= FS_BINARY_MOUNTDATA,
@@ -96,6 +96,7 @@ int __init afs_fs_init(void)
 	}
 
 	/* now export our filesystem to lesser mortals */
+	afs_fs_type.name = kafs_name;
 	ret = register_filesystem(&afs_fs_type);
 	if (ret < 0) {
 		kmem_cache_destroy(afs_inode_cachep);

--=_narn.hozed.org-3342-1151303078-0001-2--
