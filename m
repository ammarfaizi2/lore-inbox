Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbTAYDGq>; Fri, 24 Jan 2003 22:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTAYDGq>; Fri, 24 Jan 2003 22:06:46 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:25494 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266091AbTAYDGo>; Fri, 24 Jan 2003 22:06:44 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 24 Jan 2003 19:21:03 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] epoll timeout and syscall return types ...
Message-ID: <Pine.LNX.4.50.0301241908000.2858-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes :

*) Timeout overflow check

*) Ceil()ing of ms->jif conversion

*) Syscalls return type int->long



PS: Andrew, I'm CCing you because I seem to remember that Linus is in
vacation mode.



- Davide



fs/eventpoll.c            |   20 +++++++++++---------
include/linux/eventpoll.h |    8 ++++----
2 files changed, 15 insertions, 13 deletions






diff -Nru linux-2.5.59.vanilla/fs/eventpoll.c linux-2.5.59.epoll/fs/eventpoll.c
--- linux-2.5.59.vanilla/fs/eventpoll.c	Thu Jan 16 18:22:02 2003
+++ linux-2.5.59.epoll/fs/eventpoll.c	Fri Jan 24 19:18:51 2003
@@ -261,7 +261,7 @@
 			  struct epoll_event *events);
 static int ep_events_transfer(struct eventpoll *ep, struct epoll_event *events, int maxevents);
 static int ep_poll(struct eventpoll *ep, struct epoll_event *events, int maxevents,
-		   int timeout);
+		   long timeout);
 static int eventpollfs_delete_dentry(struct dentry *dentry);
 static struct inode *ep_eventpoll_inode(void);
 static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
@@ -446,7 +446,7 @@
  * file descriptors inside the epoll interface. It is the kernel part of
  * the userspace epoll_create(2).
  */
-asmlinkage int sys_epoll_create(int size)
+asmlinkage long sys_epoll_create(int size)
 {
 	int error, fd;
 	unsigned int hashbits;
@@ -492,7 +492,7 @@
  * file that enable the insertion/removal/change of file descriptors inside
  * the interest set. It rapresents the kernel part of the user spcae epoll_ctl(2).
  */
-asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, struct epoll_event *event)
+asmlinkage long sys_epoll_ctl(int epfd, int op, int fd, struct epoll_event *event)
 {
 	int error;
 	struct file *file, *tfile;
@@ -596,8 +596,8 @@
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_wait(2).
  */
-asmlinkage int sys_epoll_wait(int epfd, struct epoll_event *events, int maxevents,
-			      int timeout)
+asmlinkage long sys_epoll_wait(int epfd, struct epoll_event *events, int maxevents,
+			       int timeout)
 {
 	int error;
 	struct file *file;
@@ -1420,7 +1420,7 @@


 static int ep_poll(struct eventpoll *ep, struct epoll_event *events, int maxevents,
-		   int timeout)
+		   long timeout)
 {
 	int res, eavail;
 	unsigned long flags;
@@ -1428,10 +1428,12 @@
 	wait_queue_t wait;

 	/*
-	 * Calculate the timeout by checking for the "infinite" value ( -1 ).
-	 * The passed timeout is in milliseconds, that why (t * HZ) / 1000.
+	 * Calculate the timeout by checking for the "infinite" value ( -1 )
+	 * and the overflow condition. The passed timeout is in milliseconds,
+	 * that why (t * HZ) / 1000.
 	 */
-	jtimeout = timeout == -1 ? MAX_SCHEDULE_TIMEOUT: (timeout * HZ) / 1000;
+	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
+		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;

 retry:
 	write_lock_irqsave(&ep->lock, flags);
diff -Nru linux-2.5.59.vanilla/include/linux/eventpoll.h linux-2.5.59.epoll/include/linux/eventpoll.h
--- linux-2.5.59.vanilla/include/linux/eventpoll.h	Thu Jan 16 18:22:05 2003
+++ linux-2.5.59.epoll/include/linux/eventpoll.h	Fri Jan 24 18:51:37 2003
@@ -32,10 +32,10 @@


 /* Kernel space functions implementing the user space "epoll" API */
-asmlinkage int sys_epoll_create(int size);
-asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
-asmlinkage int sys_epoll_wait(int epfd, struct epoll_event *events, int maxevents,
-			      int timeout);
+asmlinkage long sys_epoll_create(int size);
+asmlinkage long sys_epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
+asmlinkage long sys_epoll_wait(int epfd, struct epoll_event *events, int maxevents,
+			       int timeout);

 /* Used to initialize the epoll bits inside the "struct file" */
 void eventpoll_init_file(struct file *file);
