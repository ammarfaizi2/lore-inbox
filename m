Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVCBRwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVCBRwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVCBRuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:50:09 -0500
Received: from news.suse.de ([195.135.220.2]:20431 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262391AbVCBRtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:49:03 -0500
Subject: Re: [nfsacl v2 01/16] acl kconfig cleanup
From: Andreas Gruenbacher <agruen@suse.de>
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4225FAE8.80308@tomt.net>
References: <20050227165954.566746000@blunzn.suse.de>
	 <20050227170310.810890000@blunzn.suse.de>  <4225FAE8.80308@tomt.net>
Content-Type: multipart/mixed; boundary="=-tOPIHWmah1xYezs9MCHf"
Organization: SUSE Labs
Message-Id: <1109785740.22077.177.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Mar 2005 18:49:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tOPIHWmah1xYezs9MCHf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-03-02 at 18:42, Andre Tomt wrote:
> The Kconfig cleanup from Matt breaks compilation for me, on 2.6.11 
> kernel.org release.

It's based on a patch by Matt, but all bugs are mine ;) The attached
patch went out privately before; I should have posted it here as well.
This should fix the problem.

Thanks for testing!

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

--=-tOPIHWmah1xYezs9MCHf
Content-Disposition: attachment; filename=nfsacl-v2a-v3-delta.diff
Content-Type: text/x-patch; name=nfsacl-v2a-v3-delta.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -u linux-2.6.11-rc5/lib/Makefile linux-2.6.11-rc5/lib/Makefile
--- linux-2.6.11-rc5/lib/Makefile
+++ linux-2.6.11-rc5/lib/Makefile
@@ -5,7 +5,8 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
-	 bitmap.o extable.o kobject_uevent.o prio_tree.o sort.o
+	 bitmap.o extable.o kobject_uevent.o prio_tree.o
+obj-y := sort.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
diff -u linux-2.6.11-rc5/fs/Kconfig linux-2.6.11-rc5/fs/Kconfig
--- linux-2.6.11-rc5/fs/Kconfig
+++ linux-2.6.11-rc5/fs/Kconfig
@@ -1405,6 +1405,7 @@
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
+	select NFS_ACL_SUPPORT if NFSD_ACL
 	help
 	  If you want your Linux box to act as an NFS *server*, so that other
 	  computers on your local network which support NFS can access certain
@@ -1438,7 +1439,6 @@
 config NFSD_ACL
 	bool "NFS_ACL protocol extension"
 	depends on NFSD_V3
-	select NFS_ACL_SUPPORT
 	help
 	  Implement the NFS_ACL protocol extension for manipulating POSIX
 	  Access Control Lists on exported file systems.  The clients must
@@ -1446,7 +1446,7 @@
 	  CONFIG_NFS_ACL option.  If unsure, say N.
 
 config NFS_ACL_SUPPORT
-	bool
+	tristate
 	select FS_POSIX_ACL
 
 config NFSD_V4
diff -u linux-2.6.11-rc5/fs/Kconfig linux-2.6.11-rc5/fs/Kconfig
--- linux-2.6.11-rc5/fs/Kconfig
+++ linux-2.6.11-rc5/fs/Kconfig
@@ -1320,6 +1320,7 @@
 	depends on INET
 	select LOCKD
 	select SUNRPC
+	select NFS_ACL_SUPPORT if NFS_ACL
 	help
 	  If you are connected to some other (usually local) Unix computer
 	  (using SLIP, PLIP, PPP or Ethernet) and want to mount files residing
@@ -1415,7 +1416,6 @@
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
-	select NFS_ACL_SUPPORT if NFS_ACL
 	help
 	  If you want your Linux box to act as an NFS *server*, so that other
 	  computers on your local network which support NFS can access certain
diff -u linux-2.6.11-rc5/fs/nfs/nfs3proc.c linux-2.6.11-rc5/fs/nfs/nfs3proc.c
--- linux-2.6.11-rc5/fs/nfs/nfs3proc.c
+++ linux-2.6.11-rc5/fs/nfs/nfs3proc.c
@@ -1053,7 +1053,6 @@
 	.dentry_ops	= &nfs_dentry_operations,
 	.file_inode_ops	= &nfs3_file_inode_operations,
 	.dir_inode_ops	= &nfs3_dir_inode_operations,
-	.special_inode_ops = &nfs3_special_inode_operations,
 	.getroot	= nfs3_proc_get_root,
 	.getattr	= nfs3_proc_getattr,
 	.setattr	= nfs3_proc_setattr,
@@ -1085,6 +1084,7 @@
 	.file_release	= nfs_release,
 	.lock		= nfs3_proc_lock,
 #ifdef CONFIG_NFS_ACL
+	.special_inode_ops = &nfs3_special_inode_operations,
 	.getacl		= nfs3_proc_getacl,
 	.setacl		= nfs3_proc_setacl,
 	.setacls	= nfs3_proc_setacls,

--=-tOPIHWmah1xYezs9MCHf--

