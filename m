Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbSKRT07>; Mon, 18 Nov 2002 14:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264647AbSKRTZJ>; Mon, 18 Nov 2002 14:25:09 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:61093 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264649AbSKRTYu> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:50 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (2/16): system calls.
Date: Mon, 18 Nov 2002 20:17:23 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182017.23689.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add system calls and POLLREMOVE define for eventpoll.

diff -urN linux-2.5.48/arch/s390/kernel/entry.S linux-2.5.48-s390/arch/s390/kernel/entry.S
--- linux-2.5.48/arch/s390/kernel/entry.S	Mon Nov 18 05:29:26 2002
+++ linux-2.5.48-s390/arch/s390/kernel/entry.S	Mon Nov 18 20:11:09 2002
@@ -596,7 +596,11 @@
 	.long  sys_io_submit
 	.long  sys_io_cancel
 	.long  sys_exit_group
-	.rept  255-248
+	.long  sys_epoll_create
+	.long  sys_epoll_ctl		 /* 250 */
+	.long  sys_epoll_wait
+	.long  sys_set_tid_address
+	.rept  255-252
 	.long  sys_ni_syscall
 	.endr
 
diff -urN linux-2.5.48/arch/s390x/kernel/entry.S linux-2.5.48-s390/arch/s390x/kernel/entry.S
--- linux-2.5.48/arch/s390x/kernel/entry.S	Mon Nov 18 05:29:29 2002
+++ linux-2.5.48-s390/arch/s390x/kernel/entry.S	Mon Nov 18 20:11:09 2002
@@ -625,7 +625,11 @@
 	.long  SYSCALL(sys_io_submit,sys_ni_syscall)
 	.long  SYSCALL(sys_io_cancel,sys_ni_syscall)
 	.long  SYSCALL(sys_exit_group,sys32_exit_group_wrapper)
-        .rept  255-248
+	.long  SYSCALL(sys_epoll_create,sys_ni_syscall)
+	.long  SYSCALL(sys_epoll_ctl,sys_ni_syscall)
+	.long  SYSCALL(sys_epoll_wait,sys_ni_syscall)
+	.long  SYSCALL(sys_set_tid_address,sys_ni_syscall)
+        .rept  255-252
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
 	.endr
 
diff -urN linux-2.5.48/include/asm-s390/poll.h linux-2.5.48-s390/include/asm-s390/poll.h
--- linux-2.5.48/include/asm-s390/poll.h	Mon Nov 18 05:29:21 2002
+++ linux-2.5.48-s390/include/asm-s390/poll.h	Mon Nov 18 20:11:09 2002
@@ -23,6 +23,7 @@
 #define POLLWRNORM	0x0100
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
+#define POLLREMOVE	0x1000
 
 struct pollfd {
 	int fd;
diff -urN linux-2.5.48/include/asm-s390/unistd.h linux-2.5.48-s390/include/asm-s390/unistd.h
--- linux-2.5.48/include/asm-s390/unistd.h	Mon Nov 18 05:29:59 2002
+++ linux-2.5.48-s390/include/asm-s390/unistd.h	Mon Nov 18 20:11:09 2002
@@ -241,6 +241,10 @@
 #define __NR_io_submit		246
 #define __NR_io_cancel		247
 #define __NR_exit_group		248
+#define __NR_epoll_create	249
+#define __NR_epoll_ctl		250
+#define __NR_epoll_wait		251
+#define __NR_set_tid_address	252
 
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
diff -urN linux-2.5.48/include/asm-s390x/poll.h linux-2.5.48-s390/include/asm-s390x/poll.h
--- linux-2.5.48/include/asm-s390x/poll.h	Mon Nov 18 05:29:52 2002
+++ linux-2.5.48-s390/include/asm-s390x/poll.h	Mon Nov 18 20:11:09 2002
@@ -23,6 +23,7 @@
 #define POLLWRNORM	0x0100
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
+#define POLLREMOVE	0x1000
 
 struct pollfd {
 	int fd;
diff -urN linux-2.5.48/include/asm-s390x/unistd.h linux-2.5.48-s390/include/asm-s390x/unistd.h
--- linux-2.5.48/include/asm-s390x/unistd.h	Mon Nov 18 05:29:50 2002
+++ linux-2.5.48-s390/include/asm-s390x/unistd.h	Mon Nov 18 20:11:09 2002
@@ -208,6 +208,10 @@
 #define __NR_io_submit		246
 #define __NR_io_cancel		247
 #define __NR_exit_group		248
+#define __NR_epoll_create	249
+#define __NR_epoll_ctl		250
+#define __NR_epoll_wait		251
+#define __NR_set_tid_address	252
 
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */

