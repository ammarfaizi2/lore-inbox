Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVCKAP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVCKAP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVCKAPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 19:15:52 -0500
Received: from [205.233.219.253] ([205.233.219.253]:56268 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S262567AbVCKAHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 19:07:17 -0500
Date: Thu, 10 Mar 2005 19:06:46 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: linux-kernel@vger.kernel.org
Cc: willy@debian.org
Subject: [PATCH, RFC 1/3] Add sem_getcount() to arches that lack it
Message-ID: <20050311000646.GJ1111@conscoop.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

parisc and frv define sem_getcount() in semaphore.h, which returns the
current semaphore value.  This is cleaner than doing
atomic_read(&semaphore.count), currently done in
drivers/ieee1394/nodemgr.c and fs/xfs/linux-2.6/xfs_buf.c, and will work
on all architectures if sem_getcount() is added.

This patch adds sem_getcount().  I will also send patches that convert
ieee1394 and xfs to use sem_getcount(), which fixes a warning on parisc
(and presumably frv.)

Any objections?

Jody

--

Adds sem_getcount() to architectures that were missing it.  Renames
sema_count on arm for this purpose (sema_count has no current callers.)

Tested on i386, ia64, parisc.

Signed-off-by: Jody McIntyre <scjody@modernduck.com>

Index: 1394-dev/include/asm-h8300/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-h8300/semaphore.h	2005-02-10 12:39:28.000000000 -0500
+++ 1394-dev/include/asm-h8300/semaphore.h	2005-03-08 16:38:06.000000000 -0500
@@ -59,6 +59,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-sh64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sh64/semaphore.h	2005-02-10 12:39:41.000000000 -0500
+++ 1394-dev/include/asm-sh64/semaphore.h	2005-03-08 16:42:14.000000000 -0500
@@ -72,6 +72,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 #if 0
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
Index: 1394-dev/include/asm-m68knommu/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-m68knommu/semaphore.h	2005-02-10 12:39:29.000000000 -0500
+++ 1394-dev/include/asm-m68knommu/semaphore.h	2005-03-08 16:39:18.000000000 -0500
@@ -59,6 +59,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-m32r/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-m32r/semaphore.h	2005-02-10 12:39:28.000000000 -0500
+++ 1394-dev/include/asm-m32r/semaphore.h	2005-03-08 16:38:26.000000000 -0500
@@ -64,6 +64,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-ia64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-ia64/semaphore.h	2005-02-10 12:39:28.000000000 -0500
+++ 1394-dev/include/asm-ia64/semaphore.h	2005-03-08 16:38:21.000000000 -0500
@@ -50,6 +50,11 @@ init_MUTEX_LOCKED (struct semaphore *sem
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 extern void __down (struct semaphore * sem);
 extern int  __down_interruptible (struct semaphore * sem);
 extern int  __down_trylock (struct semaphore * sem);
Index: 1394-dev/include/asm-i386/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-i386/semaphore.h	2005-02-10 12:39:28.000000000 -0500
+++ 1394-dev/include/asm-i386/semaphore.h	2005-03-08 16:13:56.000000000 -0500
@@ -87,6 +87,13 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+typedef atomic_t semcount_t;
+
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 fastcall void __down_failed(void /* special register calling convention */);
 fastcall int  __down_failed_interruptible(void  /* params in registers */);
 fastcall int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-sparc/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sparc/semaphore.h	2005-02-10 12:39:41.000000000 -0500
+++ 1394-dev/include/asm-sparc/semaphore.h	2005-03-08 16:42:37.000000000 -0500
@@ -48,6 +48,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 extern void __down(struct semaphore * sem);
 extern int __down_interruptible(struct semaphore * sem);
 extern int __down_trylock(struct semaphore * sem);
Index: 1394-dev/include/asm-x86_64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-x86_64/semaphore.h	2005-02-10 12:39:41.000000000 -0500
+++ 1394-dev/include/asm-x86_64/semaphore.h	2005-03-08 16:43:23.000000000 -0500
@@ -88,6 +88,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-ppc/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-ppc/semaphore.h	2005-02-10 12:39:40.000000000 -0500
+++ 1394-dev/include/asm-ppc/semaphore.h	2005-03-08 16:41:22.000000000 -0500
@@ -62,6 +62,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 extern void __down(struct semaphore * sem);
 extern int  __down_interruptible(struct semaphore * sem);
 extern void __up(struct semaphore * sem);
Index: 1394-dev/include/asm-ppc64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-ppc64/semaphore.h	2005-02-10 12:39:40.000000000 -0500
+++ 1394-dev/include/asm-ppc64/semaphore.h	2005-03-08 16:41:32.000000000 -0500
@@ -56,6 +56,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 extern void __down(struct semaphore * sem);
 extern int  __down_interruptible(struct semaphore * sem);
 extern void __up(struct semaphore * sem);
Index: 1394-dev/include/asm-arm26/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-arm26/semaphore.h	2005-02-10 12:39:28.000000000 -0500
+++ 1394-dev/include/asm-arm26/semaphore.h	2005-03-08 16:36:37.000000000 -0500
@@ -51,6 +51,11 @@ static inline void init_MUTEX_LOCKED(str
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 /*
  * special register calling convention
  */
Index: 1394-dev/include/asm-s390/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-s390/semaphore.h	2005-02-10 12:39:40.000000000 -0500
+++ 1394-dev/include/asm-s390/semaphore.h	2005-03-08 16:41:41.000000000 -0500
@@ -53,6 +53,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 asmlinkage void __down(struct semaphore * sem);
 asmlinkage int  __down_interruptible(struct semaphore * sem);
 asmlinkage int  __down_trylock(struct semaphore * sem);
Index: 1394-dev/include/asm-m68k/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-m68k/semaphore.h	2005-02-10 12:39:28.000000000 -0500
+++ 1394-dev/include/asm-m68k/semaphore.h	2005-03-08 16:39:10.000000000 -0500
@@ -60,6 +60,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
Index: 1394-dev/include/asm-arm/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-arm/semaphore.h	2005-02-10 12:39:27.000000000 -0500
+++ 1394-dev/include/asm-arm/semaphore.h	2005-03-08 16:36:00.000000000 -0500
@@ -49,7 +49,7 @@ static inline void init_MUTEX_LOCKED(str
 	sema_init(sem, 0);
 }
 
-static inline int sema_count(struct semaphore *sem)
+static inline int sem_getcount(struct semaphore *sem)
 {
 	return atomic_read(&sem->count);
 }
Index: 1394-dev/include/asm-sparc64/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sparc64/semaphore.h	2005-02-10 12:39:41.000000000 -0500
+++ 1394-dev/include/asm-sparc64/semaphore.h	2005-03-08 16:42:51.000000000 -0500
@@ -47,6 +47,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 extern void up(struct semaphore *sem);
 extern void down(struct semaphore *sem);
 extern int down_trylock(struct semaphore *sem);
Index: 1394-dev/include/asm-sh/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-sh/semaphore.h	2005-02-10 12:39:40.000000000 -0500
+++ 1394-dev/include/asm-sh/semaphore.h	2005-03-08 16:42:04.000000000 -0500
@@ -65,6 +65,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 #if 0
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
Index: 1394-dev/include/asm-mips/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-mips/semaphore.h	2005-02-10 12:39:29.000000000 -0500
+++ 1394-dev/include/asm-mips/semaphore.h	2005-03-08 16:39:31.000000000 -0500
@@ -70,6 +70,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 extern void __down(struct semaphore * sem);
 extern int  __down_interruptible(struct semaphore * sem);
 extern void __up(struct semaphore * sem);
Index: 1394-dev/include/asm-alpha/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-alpha/semaphore.h	2005-02-10 12:39:27.000000000 -0500
+++ 1394-dev/include/asm-alpha/semaphore.h	2005-03-08 16:13:47.000000000 -0500
@@ -57,6 +57,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem.count);
+}
+
 extern void down(struct semaphore *);
 extern void __down_failed(struct semaphore *);
 extern int  down_interruptible(struct semaphore *);
Index: 1394-dev/include/asm-cris/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-cris/semaphore.h	2005-02-10 12:39:28.000000000 -0500
+++ 1394-dev/include/asm-cris/semaphore.h	2005-03-08 16:37:12.000000000 -0500
@@ -57,6 +57,11 @@ extern inline void init_MUTEX_LOCKED (st
         sema_init(sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 extern void __down(struct semaphore * sem);
 extern int __down_interruptible(struct semaphore * sem);
 extern int __down_trylock(struct semaphore * sem);
Index: 1394-dev/include/asm-v850/semaphore.h
===================================================================
--- 1394-dev.orig/include/asm-v850/semaphore.h	2005-02-10 12:39:41.000000000 -0500
+++ 1394-dev/include/asm-v850/semaphore.h	2005-03-08 16:43:13.000000000 -0500
@@ -42,6 +42,11 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init (sem, 0);
 }
 
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return atomic_read(&sem->count);
+}
+
 /*
  * special register calling convention
  */
-- 
