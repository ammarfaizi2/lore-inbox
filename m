Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbSKQRvp>; Sun, 17 Nov 2002 12:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267533AbSKQRvp>; Sun, 17 Nov 2002 12:51:45 -0500
Received: from verein.lst.de ([212.34.181.86]:48655 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267532AbSKQRvk>;
	Sun, 17 Nov 2002 12:51:40 -0500
Date: Sun, 17 Nov 2002 18:58:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH] don't include net.h in fs.h
Message-ID: <20021117185836.A6496@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs.h is pulling so much crap in..  No need to include net.h in fs.h if
we move struct sock_alloc to net.h (which already includes fs.h through
skbuf.h and mm.h..).  Fixup the few files in net/ that relied on this,
and the readv/writev implementations that got uio.h through net.h.


--- 1.111/fs/block_dev.c	Sat Nov 16 15:41:20 2002
+++ edited/fs/block_dev.c	Sun Nov 17 13:09:16 2002
@@ -21,8 +21,9 @@
 #include <linux/buffer_head.h>
 #include <linux/mpage.h>
 #include <linux/mount.h>
-
+#include <linux/uio.h>
 #include <asm/uaccess.h>
+
 
 static sector_t max_block(struct block_device *bdev)
 {
===== fs/direct-io.c 1.20 vs edited =====
--- 1.20/fs/direct-io.c	Fri Nov 15 08:54:17 2002
+++ edited/fs/direct-io.c	Sun Nov 17 13:13:11 2002
@@ -21,6 +21,7 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/rwsem.h>
+#include <linux/uio.h>
 #include <asm/atomic.h>
 
 /*
===== fs/ext3/inode.c 1.48 vs edited =====
--- 1.48/fs/ext3/inode.c	Tue Nov  5 07:52:41 2002
+++ edited/fs/ext3/inode.c	Sun Nov 17 13:42:44 2002
@@ -34,6 +34,7 @@
 #include <linux/string.h>
 #include <linux/buffer_head.h>
 #include <linux/mpage.h>
+#include <linux/uio.h>
 #include "xattr.h"
 #include "acl.h"
 
===== include/linux/fs.h 1.191 vs edited =====
--- 1.191/include/linux/fs.h	Sat Nov 16 15:18:12 2002
+++ edited/include/linux/fs.h	Sun Nov 17 12:55:55 2002
@@ -12,7 +12,6 @@
 #include <linux/wait.h>
 #include <linux/types.h>
 #include <linux/vfs.h>
-#include <linux/net.h>
 #include <linux/kdev_t.h>
 #include <linux/ioctl.h>
 #include <linux/list.h>
@@ -27,7 +27,9 @@
 #include <asm/atomic.h>
 
 struct poll_table_struct;
+struct iovec;
 struct nameidata;
+struct vm_area_struct;
 struct vfsmount;
 
 /*
@@ -412,21 +414,6 @@
 	} u;
 };
 
-struct socket_alloc {
-	struct socket socket;
-	struct inode vfs_inode;
-};
-
-static inline struct socket *SOCKET_I(struct inode *inode)
-{
-	return &container_of(inode, struct socket_alloc, vfs_inode)->socket;
-}
-
-static inline struct inode *SOCK_INODE(struct socket *socket)
-{
-	return &container_of(socket, struct socket_alloc, socket)->vfs_inode;
-}
-
 /* will die */
 #include <linux/coda_fs_i.h>
 #include <linux/ext3_fs_i.h>
===== include/net/sock.h 1.28 vs edited =====
--- 1.28/include/net/sock.h	Tue Nov  5 15:03:52 2002
+++ edited/include/net/sock.h	Sun Nov 17 12:58:01 2002
@@ -321,6 +321,21 @@
 	return container_of((void *)si, struct kiocb, private);
 }
 
+struct socket_alloc {
+	struct socket socket;
+	struct inode vfs_inode;
+};
+
+static inline struct socket *SOCKET_I(struct inode *inode)
+{
+	return &container_of(inode, struct socket_alloc, vfs_inode)->socket;
+}
+
+static inline struct inode *SOCK_INODE(struct socket *socket)
+{
+	return &container_of(socket, struct socket_alloc, socket)->vfs_inode;
+}
+
 /* Used by processes to "lock" a socket state, so that
  * interrupts and bottom half handlers won't change it
  * from under us. It essentially blocks any incoming
===== net/ipv4/arp.c 1.15 vs edited =====
--- 1.15/net/ipv4/arp.c	Mon Nov 11 09:40:35 2002
+++ edited/net/ipv4/arp.c	Sun Nov 17 13:45:03 2002
@@ -90,6 +90,7 @@
 #include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/init.h>
+#include <linux/net.h>
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif
===== net/ipv4/inetpeer.c 1.5 vs edited =====
--- 1.5/net/ipv4/inetpeer.c	Tue Nov  5 05:20:34 2002
+++ edited/net/ipv4/inetpeer.c	Sun Nov 17 13:44:36 2002
@@ -18,6 +18,7 @@
 #include <linux/time.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/net.h>
 #include <net/inetpeer.h>
 
 /*
===== net/ipv4/raw.c 1.24 vs edited =====
--- 1.24/net/ipv4/raw.c	Thu Nov 14 12:14:43 2002
+++ edited/net/ipv4/raw.c	Sun Nov 17 13:44:52 2002
@@ -64,6 +64,7 @@
 #include <net/sock.h>
 #include <linux/gfp.h>
 #include <linux/ip.h>
+#include <linux/net.h>
 #include <net/ip.h>
 #include <net/icmp.h>
 #include <net/udp.h>
===== net/sunrpc/cache.c 1.6 vs edited =====
--- 1.6/net/sunrpc/cache.c	Wed Oct 16 00:47:02 2002
+++ edited/net/sunrpc/cache.c	Sun Nov 17 13:45:26 2002
@@ -23,6 +23,7 @@
 #include <asm/uaccess.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
+#include <linux/net.h>
 #include <asm/ioctls.h>
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/cache.h>
