Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265407AbSJRVuh>; Fri, 18 Oct 2002 17:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265410AbSJRVuh>; Fri, 18 Oct 2002 17:50:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:56779 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265407AbSJRVud>; Fri, 18 Oct 2002 17:50:33 -0400
Date: Fri, 18 Oct 2002 15:00:27 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: torvalds@transmeta.com, bcrl@redhat.com
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org, davidel@xmailserver.org
Subject: [PATCH] sys_epoll system call interface to /dev/epoll
Message-ID: <44010000.1034978427@w-hlinder>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

	You said earlier that you didn't like epoll being
in /dev. How about a system call interface instead? this
patch provides the skeleton for that system call. We
can have Davide's patch ported into it ASAP if you include 
this by the freeze.
	/dev/epoll has been shown to be the most scalable
of all the existing solutions and there needs to be a
scalable poll in 2.6 for various applications. 

Please include or give any feedback that might help us
get it into the next release.

Thank you.

Hanna Linder
IBM Linux Technology Center
Kernel Group

----

diff -Nru -X ../dontdiff linux-2.5.43/arch/um/kernel/sys_call_table.c linux-epoll/arch/um/kernel/sys_call_table.c
--- linux-2.5.43/arch/um/kernel/sys_call_table.c	Tue Oct 15 20:28:34 2002
+++ linux-epoll/arch/um/kernel/sys_call_table.c	Fri Oct 18 12:21:15 2002
@@ -228,6 +228,7 @@
 extern syscall_handler_t sys_io_getevents;
 extern syscall_handler_t sys_io_submit;
 extern syscall_handler_t sys_io_cancel;
+extern syscall_handler_t sys_epoll;
 extern syscall_handler_t sys_exit_group;
 
 #if CONFIG_NFSD
@@ -476,6 +477,7 @@
 	[ __NR_io_getevents ] = sys_io_getevents,
 	[ __NR_io_submit ] = sys_io_submit,
 	[ __NR_io_cancel ] = sys_io_cancel,
+	[ __NR_epoll ] = sys_epoll,
 	[ __NR_alloc_hugepages ] = sys_ni_syscall,
 	[ __NR_free_hugepages ] = sys_ni_syscall,
 	[ __NR_exit_group ] = sys_exit_group,
diff -Nru -X ../dontdiff linux-2.5.43/fs/select.c linux-epoll/fs/select.c
--- linux-2.5.43/fs/select.c	Tue Oct 15 20:27:09 2002
+++ linux-epoll/fs/select.c	Fri Oct 18 14:22:49 2002
@@ -20,6 +20,7 @@
 #include <linux/personality.h> /* for STICKY_TIMEOUTS */
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/epoll.h>
 
 #include <asm/uaccess.h>
 
@@ -495,3 +496,23 @@
 	poll_freewait(&table);
 	return err;
 }
+
+asmlinkage long sys_epoll(unsigned int cmd, struct epoll_struct epd)
+{
+
+	switch(cmd) {
+	case EP_CREATE:
+		return -ENOSYS;
+	case EP_ADDFD:
+		return -ENOSYS;
+	case EP_DELFD:
+		return -ENOSYS;
+	case EP_POLL:
+		return -ENOSYS;
+	case EP_DELETE:
+		return -ENOSYS;
+	default:
+		return -ENOSYS;
+	}
+}
+	
diff -Nru -X ../dontdiff linux-2.5.43/include/asm-x86_64/unistd.h linux-epoll/include/asm-x86_64/unistd.h
--- linux-2.5.43/include/asm-x86_64/unistd.h	Tue Oct 15 20:28:29 2002
+++ linux-epoll/include/asm-x86_64/unistd.h	Fri Oct 18 12:24:37 2002
@@ -480,7 +480,9 @@
 __SYSCALL(__NR_io_submit, sys_io_submit)
 #define __NR_io_cancel	210
 __SYSCALL(__NR_io_cancel, sys_io_cancel)
-#define __NR_get_thread_area	211
+#define __NR_epoll	211
+__SYSCALL(__NR_epoll, sys_epoll)
+#define __NR_get_thread_area	212
 __SYSCALL(__NR_get_thread_area, sys_get_thread_area)
 
 #define __NR_syscall_max __NR_get_thread_area
diff -Nru -X ../dontdiff linux-2.5.43/include/linux/epoll.h linux-epoll/include/linux/epoll.h
--- linux-2.5.43/include/linux/epoll.h	Wed Dec 31 16:00:00 1969
+++ linux-epoll/include/linux/epoll.h	Fri Oct 18 14:20:15 2002
@@ -0,0 +1,29 @@
+#ifndef _LINUX_EPOLL_H
+#define _LINUX_EPOLL_H
+
+#include <linux/poll.h>
+
+struct evpoll {
+	int ep_timeout;
+	unsigned long ep_resoff;
+};
+
+struct epoll_struct {
+	int maxfds;
+	void *mmap_base;
+	struct pollfd pfd;
+	struct evpoll evp;
+};
+
+enum cmd {
+	EP_CREATE,
+	EP_ADDFD,
+	EP_DELFD,
+	EP_POLL,
+	EP_DELETE
+};
+
+
+#endif
+
+



---------- End Forwarded Message ----------


