Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbTENIPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbTENIPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:15:48 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:39412 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id S261203AbTENIPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:15:37 -0400
Date: Wed, 14 May 2003 01:28:23 -0700
From: Christopher Hoover <ch@murgatroid.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Cc: ch@murgatroid.com
Subject: [PATCH] 2.5.69  eventpollfs configuration option
Message-ID: <20030514012823.A4128@heavens.murgatroid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch to drop some more text/data/bss out of 2.5.  This time
the ``victim'' is eventpollfs (epoll).

Continuing to put 2.5 on a diet so it'll fit nicely on a 4 MiB Ceiva ...

-ch
mailto:ch(at)murgatroid.com
mailto:ch(at)hpl.hp.com


diff -X /home/ch/src/dontdiff.txt -Naurp linux-2.5.69.orig/kernel/sys.c linux-2.5.69/kernel/sys.c
--- linux-2.5.69.orig/kernel/sys.c	2003-05-04 16:53:02.000000000 -0700
+++ linux-2.5.69/kernel/sys.c	2003-05-14 01:08:14.000000000 -0700
@@ -226,6 +226,9 @@ cond_syscall(sys_shutdown)
 cond_syscall(sys_sendmsg)
 cond_syscall(sys_recvmsg)
 cond_syscall(sys_socketcall)
+cond_syscall(sys_epoll_create)
+cond_syscall(sys_epoll_ctl)
+cond_syscall(sys_epoll_wait)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
diff -X /home/ch/src/dontdiff.txt -Naurp linux-2.5.69.orig/fs/Kconfig linux-2.5.69/fs/Kconfig
--- linux-2.5.69.orig/fs/Kconfig	2003-05-04 16:53:32.000000000 -0700
+++ linux-2.5.69/fs/Kconfig	2003-05-14 01:14:26.000000000 -0700
@@ -835,6 +835,13 @@ config RAMFS
 	  say M here and read <file:Documentation/modules.txt>.  The module
 	  will be called ramfs.
 
+config EVENTPOLLFS
+       bool "Efficient event polling (epoll)"
+       default y
+       ---help---
+       Say Y if you want epoll support which is an efficent event
+       polling implementation.
+
 endmenu
 
 menu "Miscellaneous filesystems"
diff -X /home/ch/src/dontdiff.txt -Naurp linux-2.5.69.orig/fs/Makefile linux-2.5.69/fs/Makefile
--- linux-2.5.69.orig/fs/Makefile	2003-05-04 16:53:32.000000000 -0700
+++ linux-2.5.69/fs/Makefile	2003-05-14 01:08:14.000000000 -0700
@@ -10,7 +10,9 @@ obj-y :=	open.o read_write.o file_table.
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o eventpoll.o
+		fs-writeback.o mpage.o direct-io.o aio.o
+
+obj-$(CONFIG_EVENTPOLLFS)	+= eventpoll.o
 
 obj-$(CONFIG_COMPAT) += compat.o
 
diff -X /home/ch/src/dontdiff.txt -Naurp linux-2.5.69.orig/include/linux/eventpoll.h linux-2.5.69/include/linux/eventpoll.h
--- linux-2.5.69.orig/include/linux/eventpoll.h	2003-05-04 16:53:14.000000000 -0700
+++ linux-2.5.69/include/linux/eventpoll.h	2003-05-14 01:08:14.000000000 -0700
@@ -40,12 +40,21 @@ asmlinkage long sys_epoll_ctl(int epfd, 
 asmlinkage long sys_epoll_wait(int epfd, struct epoll_event *events, int maxevents,
 			       int timeout);
 
+#ifdef CONFIG_EVENTPOLLFS
+
 /* Used to initialize the epoll bits inside the "struct file" */
 void eventpoll_init_file(struct file *file);
 
 /* Used in fs/file_table.c:__fput() to unlink files from the eventpoll interface */
 void eventpoll_release(struct file *file);
 
+#else
+
+static inline void eventpoll_init_file(struct file *file) {}
+static inline void eventpoll_release(struct file *file) {}
+
+#endif
+
 #endif /* #ifdef __KERNEL__ */
 
 #endif /* #ifndef _LINUX_EVENTPOLL_H */
