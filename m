Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267197AbUBSO2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267217AbUBSO2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:28:38 -0500
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:65197 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S267197AbUBSO21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:28:27 -0500
Date: Thu, 19 Feb 2004 15:28:22 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: linux-kernel@vger.kernel.org
cc: Manfred Spraul <manfred@colorfullife.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: [RFC][PATCH] 2/6 POSIX message queues
Message-ID: <Pine.GSO.4.58.0402191527030.18841@Juliusz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 2
//  EXTRAVERSION =
--- 2.6/ipc/util.c	2004-02-14 18:47:10.000000000 +0100
+++ build-2.6/ipc/util.c	2004-02-14 18:44:34.000000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/security.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
+#include <linux/mqueue.h>

 #if defined(CONFIG_SYSVIPC)

--- 2.6/arch/i386/kernel/entry.S	2004-02-14 18:47:10.000000000 +0100
+++ build-2.6/arch/i386/kernel/entry.S	2004-02-14 18:43:43.000000000 +0100
@@ -882,5 +882,11 @@
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_mq_open
+	.long sys_mq_unlink	/* 275 */
+	.long sys_mq_timedsend
+	.long sys_mq_timedreceive
+	.long sys_mq_notify
+	.long sys_mq_getsetattr

 syscall_table_size=(.-sys_call_table)
--- 2.6/include/asm-i386/unistd.h	2004-02-14 18:47:10.000000000 +0100
+++ build-2.6/include/asm-i386/unistd.h	2004-02-14 18:43:43.000000000 +0100
@@ -279,8 +279,14 @@
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
 #define __NR_vserver		273
+#define __NR_mq_open 		274
+#define __NR_mq_unlink		(__NR_mq_open+1)
+#define __NR_mq_timedsend	(__NR_mq_open+2)
+#define __NR_mq_timedreceive	(__NR_mq_open+3)
+#define __NR_mq_notify		(__NR_mq_open+4)
+#define __NR_mq_getsetattr	(__NR_mq_open+5)

-#define NR_syscalls 274
+#define NR_syscalls 280

 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */

--- 2.6/include/linux/mqueue.h	1970-01-01 01:00:00.000000000 +0100
+++ build-2.6/include/linux/mqueue.h	2004-02-14 18:50:50.000000000 +0100
@@ -0,0 +1,50 @@
+/* Copyright (C) 2003 Krzysztof Benedyczak & Michal Wronski
+
+   This program is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   It is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with this software; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#ifndef _LINUX_MQUEUE_H
+#define _LINUX_MQUEUE_H
+
+#define MQ_PRIO_MAX 	32768
+
+typedef int mqd_t;
+
+struct mq_attr {
+	long	mq_flags;	/* message queue flags			*/
+	long	mq_maxmsg;	/* maximum number of messages		*/
+	long	mq_msgsize;	/* maximum message size			*/
+	long	mq_curmsgs;	/* number of messages currently queued	*/
+};
+
+#define NOTIFY_NONE	0
+#define NOTIFY_WOKENUP	1
+#define NOTIFY_REMOVED	2
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/signal.h>
+#include <linux/linkage.h>
+
+asmlinkage long sys_mq_open(const char __user *name, int oflag, mode_t mode, struct mq_attr __user *attr);
+asmlinkage long sys_mq_unlink(const char __user *name);
+asmlinkage long mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct timespec __user *abs_timeout);
+asmlinkage ssize_t mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct timespec __user *abs_timeout);
+asmlinkage long mq_notify(mqd_t mqdes, const struct sigevent __user *notification);
+asmlinkage long mq_getsetattr(mqd_t mqdes, const struct mq_attr __user *mqstat, struct mq_attr __user *omqstat);
+#endif
+
+#endif
--- 2.6/kernel/sys.c	2004-02-14 17:19:39.000000000 +0100
+++ build-2.6/kernel/sys.c	2004-02-14 18:45:23.000000000 +0100
@@ -249,6 +249,12 @@
 cond_syscall(sys_epoll_create)
 cond_syscall(sys_epoll_ctl)
 cond_syscall(sys_epoll_wait)
+cond_syscall(sys_mq_open)
+cond_syscall(sys_mq_unlink)
+cond_syscall(sys_mq_timedsend)
+cond_syscall(sys_mq_timedreceive)
+cond_syscall(sys_mq_notify)
+cond_syscall(sys_mq_getsetattr)

 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read)
