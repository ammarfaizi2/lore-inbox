Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265189AbSKEUQh>; Tue, 5 Nov 2002 15:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbSKEUQh>; Tue, 5 Nov 2002 15:16:37 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:12442 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265189AbSKEUQe>; Tue, 5 Nov 2002 15:16:34 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 5 Nov 2002 12:32:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] epoll bits 0.31 and epoll user space access library ...
Message-ID: <Pine.LNX.4.44.0211051211290.1774-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, these are a few bits changes from 2.4.46 :

*) Some constant adjusted

*) Comments plus

*) Better hash initialization

*) Correct timeout setup

*) Added __KERNEL__ bypass to avoid userspace inclusion problems



A new user space access library to the epoll interface is available here :

http://www.xmailserver.org/linux-patches/nio-improve.html#sys_epoll



- Davide



fs/eventpoll.c            |   55 +++++++++++++++++++++++++++++++---------------
include/linux/eventpoll.h |   14 +++++++----
2 files changed, 47 insertions, 22 deletions




diff -Nru linux-2.5.46.vanilla/fs/eventpoll.c linux-2.5.46.epoll/fs/eventpoll.c
--- linux-2.5.46.vanilla/fs/eventpoll.c	Mon Nov  4 15:45:35 2002
+++ linux-2.5.46.epoll/fs/eventpoll.c	Mon Nov  4 15:50:27 2002
@@ -61,8 +61,12 @@
 /* Maximum storage for the eventpoll interest set */
 #define EP_MAX_FDS_SIZE (1024 * 128)

-/* We don't want the hash to be smaller than this */
-#define EP_MIN_HASH_SIZE 101
+/*
+ * We don't want the hash to be smaller than this. This is basically
+ * the highest prime lower than (PAGE_SIZE / sizeof(struct list_head)).
+ */
+#define EP_MIN_HASH_SIZE 509
+
 /*
  * Event buffer dimension used to cache events before sending them in
  * userspace with a __copy_to_user(). The event buffer is in stack,
@@ -188,6 +192,7 @@


 static int ep_is_prime(int n);
+static int ep_size_hash(int hintsize);
 static int ep_getfd(int *efd, struct inode **einode, struct file **efile);
 static int ep_alloc_pages(char **pages, int numpages);
 static int ep_free_pages(char **pages, int numpages);
@@ -252,14 +257,14 @@



-/* Report if the number is prime. Needed to correctly size the hash  */
+/* Report if the number is prime. Needed to correctly size the hash */
 static int ep_is_prime(int n)
 {

 	if (n > 3) {
 		if (n & 1) {
 			int i, hn = n / 2;
-
+
 			for (i = 3; i < hn; i += 2)
 				if (!(n % i))
 					return 0;
@@ -296,9 +301,30 @@
 }


+static int ep_size_hash(int hintsize)
+{
+	int maxsize = (EP_MAX_HPAGES - 1) * EP_HENTRY_X_PAGE;
+
+	/*
+	 * Search the nearest prime number higher than "hintsize" and
+	 * smaller than "maxsize".
+	 */
+	for (; !ep_is_prime(hintsize); hintsize++);
+	if (hintsize < EP_MIN_HASH_SIZE)
+		hintsize = EP_MIN_HASH_SIZE;
+	else if (hintsize >= maxsize)
+		for (hintsize = maxsize - 1; !ep_is_prime(hintsize); hintsize--);
+
+	return hintsize;
+}
+
+
 /*
  * It opens an eventpoll file descriptor by suggesting a storage of "size"
- * file descriptors. It is the kernel part of the userspace epoll_create(2).
+ * file descriptors. The size parameter is just an hint about how to size
+ * data structures. It won't prevent the user to store more than "size"
+ * file descriptors inside the epoll interface. It is the kernel part of
+ * the userspace epoll_create(2).
  */
 asmlinkage int sys_epoll_create(int size)
 {
@@ -309,10 +335,8 @@
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d)\n",
 		     current, size));

-	/* Search the nearest prime number higher than "size" */
-	for (; !ep_is_prime(size); size++);
-	if (size < EP_MIN_HASH_SIZE)
-		size = EP_MIN_HASH_SIZE;
+	/* Correctly size the hash */
+	size = ep_size_hash(size);

 	/*
 	 * Creates all the items needed to setup an eventpoll file. That is,
@@ -567,7 +591,7 @@
 eexit_2:
 	put_filp(file);
 eexit_1:
-	return error;
+	return error;
 }


@@ -723,8 +747,7 @@
 	write_unlock_irqrestore(&eplock, flags);

 	/* Free hash pages */
-	if (ep->nhpages > 0)
-		ep_free_pages(ep->hpages, ep->nhpages);
+	ep_free_pages(ep->hpages, ep->nhpages);
 }


@@ -1126,12 +1149,10 @@
 	wait_queue_t wait;

 	/*
-	 * Calculate the timeout by checking for the "infinite" value ( -1 )
-	 * and the overflow condition ( > MAX_SCHEDULE_TIMEOUT / HZ ). The
-	 * passed timeout is in milliseconds, that why (t * HZ) / 1000.
+	 * Calculate the timeout by checking for the "infinite" value ( -1 ).
+	 * The passed timeout is in milliseconds, that why (t * HZ) / 1000.
 	 */
-	jtimeout = timeout == -1 || timeout > MAX_SCHEDULE_TIMEOUT / HZ ?
-		MAX_SCHEDULE_TIMEOUT: (timeout * HZ) / 1000;
+	jtimeout = timeout == -1 ? MAX_SCHEDULE_TIMEOUT: (timeout * HZ) / 1000;

 retry:
 	write_lock_irqsave(&ep->lock, flags);
diff -Nru linux-2.5.46.vanilla/include/linux/eventpoll.h linux-2.5.46.epoll/include/linux/eventpoll.h
--- linux-2.5.46.vanilla/include/linux/eventpoll.h	Mon Nov  4 15:45:36 2002
+++ linux-2.5.46.epoll/include/linux/eventpoll.h	Tue Nov  5 11:13:26 2002
@@ -14,10 +14,6 @@
 #ifndef _LINUX_EVENTPOLL_H
 #define _LINUX_EVENTPOLL_H

-/* Forward declarations to avoid compiler errors */
-struct file;
-struct pollfd;
-

 /* Valid opcodes to issue to sys_epoll_ctl() */
 #define EP_CTL_ADD 1
@@ -25,6 +21,13 @@
 #define EP_CTL_MOD 3


+#ifdef __KERNEL__
+
+/* Forward declarations to avoid compiler errors */
+struct file;
+struct pollfd;
+
+
 /* Kernel space functions implementing the user space "epoll" API */
 asmlinkage int sys_epoll_create(int size);
 asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, unsigned int events);
@@ -34,6 +37,7 @@
 /* Used in fs/file_table.c:__fput() to unlink files from the eventpoll interface */
 void ep_notify_file_close(struct file *file);

+#endif /* #ifdef __KERNEL__ */

-#endif
+#endif /* #ifndef _LINUX_EVENTPOLL_H */




