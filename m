Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262762AbTCPVcr>; Sun, 16 Mar 2003 16:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262763AbTCPVcr>; Sun, 16 Mar 2003 16:32:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8621 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262762AbTCPVcl>;
	Sun, 16 Mar 2003 16:32:41 -0500
Date: Sun, 16 Mar 2003 21:43:34 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [PATCH] Increase efficiency of CONFIG_NET=n
Message-ID: <20030316214334.GR29631@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a file net/nonet.c and amends the Makefile to compile
this and nothing else when CONFIG_NET=n.  It shaves approximately 90k
off the size of a CONFIG_NET=n build (and allows us to remove some ifdefs
from other files which is my real motivation).  Still, this should make
some embedded people happy.

Comments?

diff -urpNX ../dontdiff linux-2.5.64/net/Makefile linux-2.5.64-flock/net/Makefile
--- linux-2.5.64/net/Makefile	2003-02-20 22:46:57.000000000 -0500
+++ linux-2.5.64-flock/net/Makefile	2003-03-16 16:07:00.000000000 -0500
@@ -5,8 +5,9 @@
 # Rewritten to use lists instead of if-statements.
 #
 
-obj-y	:= socket.o core/
+obj-y	:= nonet.o
 
+obj-$(CONFIG_NET)		:= socket.o core/
 # LLC has to be linked before the files in net/802/
 obj-$(CONFIG_LLC)		+= llc/
 obj-$(CONFIG_NET)		+= ethernet/ 802/ sched/ netlink/
diff -urpNX ../dontdiff linux-2.5.64/net/nonet.c linux-2.5.64-flock/net/nonet.c
--- linux-2.5.64/net/nonet.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.5.64-flock/net/nonet.c	2003-03-16 16:11:19.000000000 -0500
@@ -0,0 +1,122 @@
+/*
+ * net/nonet.c
+ *
+ * Dummy functions to allow us to configure network support entirely
+ * out of the kernel.
+ *
+ * Distributed under the terms of the GNU GPL version 2.
+ * Copyright (c) Matthew Wilcox 2003
+ */
+
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/linkage.h>
+#include <linux/socket.h>
+
+void __init sock_init(void)
+{
+	printk(KERN_INFO "Linux NoNET1.0 for Linux 2.6\n");
+}
+
+static int sock_no_open(struct inode *irrelevant, struct file *dontcare)
+{
+	return -ENXIO;
+}
+
+struct file_operations bad_sock_fops = {
+	.open = sock_no_open,
+};
+
+asmlinkage long sys_socket(int family, int type, int protocol)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_socketpair(int family, int type, int protocol, int usockvec[2])
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_bind(int fd, struct sockaddr *umyaddr, int addrlen)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_listen(int fd, int backlog)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_accept(int fd, struct sockaddr *upeer_sockaddr, int *upeer_addrlen)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_connect(int fd, struct sockaddr *uservaddr, int addrlen)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_getsockname(int fd, struct sockaddr *usockaddr, int *usockaddr_len)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_getpeername(int fd, struct sockaddr *usockaddr, int *usockaddr_len)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_sendto(int fd, void * buff, size_t len, unsigned flags,
+			   struct sockaddr *addr, int addr_len)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_send(int fd, void * buff, size_t len, unsigned flags)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_recvfrom(int fd, void * ubuf, size_t size, unsigned flags,
+			     struct sockaddr *addr, int *addr_len)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_recv(int fd, void * ubuf, size_t size, unsigned flags)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_setsockopt(int fd, int level, int optname, char *optval, int optlen)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_getsockopt(int fd, int level, int optname, char *optval, int *optlen)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_shutdown(int fd, int how)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_sendmsg(int fd, struct msghdr *msg, unsigned flags)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_recvmsg(int fd, struct msghdr *msg, unsigned int flags)
+{
+	return -ENOSYS;
+}
+
+asmlinkage long sys_socketcall(int call, unsigned long *args)
+{
+	return -ENOSYS;
+}

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
