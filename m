Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbTCQB7J>; Sun, 16 Mar 2003 20:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbTCQB7J>; Sun, 16 Mar 2003 20:59:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59060 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261654AbTCQB7F>;
	Sun, 16 Mar 2003 20:59:05 -0500
Date: Mon, 17 Mar 2003 02:09:57 +0000
From: Matthew Wilcox <willy@debian.org>
To: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@debian.org>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] Increase efficiency of CONFIG_NET=n
Message-ID: <20030317020957.GA28607@parcelfarce.linux.theplanet.co.uk>
References: <20030316214334.GR29631@parcelfarce.linux.theplanet.co.uk> <20030316235708.A30119@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030316235708.A30119@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 11:57:08PM +0000, Christoph Hellwig wrote:
> On Sun, Mar 16, 2003 at 09:43:34PM +0000, Matthew Wilcox wrote:
> > +asmlinkage long sys_socket(int family, int type, int protocol)
> > +{
> > +	return -ENOSYS;
> > +}
> 
> Please just use cond_syscall in kernel/sys.c for all this stubbed
> out syscalls.

OK.

diff -urpNX ../dontdiff linux-2.5.64/kernel/sys.c linux-2.5.64-flock/kernel/sys.c
--- linux-2.5.64/kernel/sys.c	2003-03-07 11:40:53.000000000 -0500
+++ linux-2.5.64-flock/kernel/sys.c	2003-03-16 20:59:33.000000000 -0500
@@ -209,6 +209,23 @@ cond_syscall(sys_swapon)
 cond_syscall(sys_swapoff)
 cond_syscall(sys_init_module)
 cond_syscall(sys_delete_module)
+cond_syscall(sys_socketpair)
+cond_syscall(sys_bind)
+cond_syscall(sys_listen)
+cond_syscall(sys_accept)
+cond_syscall(sys_connect)
+cond_syscall(sys_getsockname)
+cond_syscall(sys_getpeername)
+cond_syscall(sys_sendto)
+cond_syscall(sys_send)
+cond_syscall(sys_recvfrom)
+cond_syscall(sys_recv)
+cond_syscall(sys_setsockopt)
+cond_syscall(sys_getsockopt)
+cond_syscall(sys_shutdown)
+cond_syscall(sys_sendmsg)
+cond_syscall(sys_recvmsg)
+cond_syscall(sys_socketcall)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
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
+++ linux-2.5.64-flock/net/nonet.c	2003-03-16 20:57:26.000000000 -0500
@@ -0,0 +1,28 @@
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

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
