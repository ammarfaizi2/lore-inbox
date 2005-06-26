Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVFZWhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVFZWhu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVFZWhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:37:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27291 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261629AbVFZWfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:35:00 -0400
Date: Sun, 26 Jun 2005 18:34:57 -0400 (EDT)
From: Rik Van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org, Song Jiang <sjiang@lanl.gov>
Subject: [PATCH] 1/2 swap token tuning
In-Reply-To: <Pine.LNX.4.61.0506261827500.18834@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.61.0506261834280.18834@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0506261827500.18834@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add sem_is_read/write_locked functions to the read/write semaphores,
along the same lines of the *_is_locked spinlock functions.  The swap
token tuning patch uses sem_is_read_locked; sem_is_write_locked is
added for completeness.

Signed-off-by: Rik van Riel <riel@redhat.com>

 asm-alpha/rwsem.h      |   10 ++++++++++
 asm-i386/rwsem.h       |   10 ++++++++++
 asm-ia64/rwsem.h       |   10 ++++++++++
 asm-ppc/rwsem.h        |   10 ++++++++++
 asm-ppc64/rwsem.h      |   10 ++++++++++
 asm-s390/rwsem.h       |   10 ++++++++++
 asm-sh/rwsem.h         |   10 ++++++++++
 asm-sparc64/rwsem.h    |   10 ++++++++++
 asm-x86_64/rwsem.h     |   10 ++++++++++
 linux/rwsem-spinlock.h |   10 ++++++++++
 10 files changed, 100 insertions(+)

diff -uNrp vanilla/include/asm-alpha/rwsem.h 2.6.12-rwsem/include/asm-alpha/rwsem.h
--- vanilla/include/asm-alpha/rwsem.h	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.12-rwsem/include/asm-alpha/rwsem.h	2005-06-26 14:25:34.000000000 -0400
@@ -262,5 +262,15 @@ static inline long rwsem_atomic_update(l
 #endif
 }
 
+static inline int sem_is_read_locked(struct rw_semaphore *sem)
+{
+	return (sem->count > 0);
+}
+
+static inline int sem_is_write_locked(struct rw_semaphore *sem)
+{
+	return (sem->count < 0);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _ALPHA_RWSEM_H */
diff -uNrp vanilla/include/asm-i386/rwsem.h 2.6.12-rwsem/include/asm-i386/rwsem.h
--- vanilla/include/asm-i386/rwsem.h	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.12-rwsem/include/asm-i386/rwsem.h	2005-06-26 14:20:35.000000000 -0400
@@ -284,5 +284,15 @@ LOCK_PREFIX	"xadd %0,(%2)"
 	return tmp+delta;
 }
 
+static inline int sem_is_read_locked(struct rw_semaphore *sem)
+{
+	return (sem->count > 0);
+}
+
+static inline int sem_is_write_locked(struct rw_semaphore *sem)
+{
+	return (sem->count < 0);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _I386_RWSEM_H */
diff -uNrp vanilla/include/asm-ia64/rwsem.h 2.6.12-rwsem/include/asm-ia64/rwsem.h
--- vanilla/include/asm-ia64/rwsem.h	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.12-rwsem/include/asm-ia64/rwsem.h	2005-06-26 15:36:40.000000000 -0400
@@ -185,4 +185,14 @@ __downgrade_write (struct rw_semaphore *
 #define rwsem_atomic_add(delta, sem)	atomic_add(delta, (atomic_t *)(&(sem)->count))
 #define rwsem_atomic_update(delta, sem)	atomic_add_return(delta, (atomic_t *)(&(sem)->count))
 
+static inline int sem_is_read_locked(struct rw_semaphore *sem)
+{
+	return (sem->count > 0);
+}
+
+static inline int sem_is_write_locked(struct rw_semaphore *sem)
+{
+	return (sem->count < 0);
+}
+
 #endif /* _ASM_IA64_RWSEM_H */
diff -uNrp vanilla/include/asm-ppc/rwsem.h 2.6.12-rwsem/include/asm-ppc/rwsem.h
--- vanilla/include/asm-ppc/rwsem.h	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.12-rwsem/include/asm-ppc/rwsem.h	2005-06-26 16:00:10.000000000 -0400
@@ -168,5 +168,15 @@ static inline int rwsem_atomic_update(in
 	return atomic_add_return(delta, (atomic_t *)(&sem->count));
 }
 
+static inline int sem_is_read_locked(struct rw_semaphore *sem)
+{
+	return (sem->count > 0);
+}
+
+static inline int sem_is_write_locked(struct rw_semaphore *sem)
+{
+	return (sem->count < 0);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _PPC_RWSEM_XADD_H */
diff -uNrp vanilla/include/asm-ppc64/rwsem.h 2.6.12-rwsem/include/asm-ppc64/rwsem.h
--- vanilla/include/asm-ppc64/rwsem.h	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.12-rwsem/include/asm-ppc64/rwsem.h	2005-06-26 15:59:48.000000000 -0400
@@ -163,5 +163,15 @@ static inline int rwsem_atomic_update(in
 	return atomic_add_return(delta, (atomic_t *)(&sem->count));
 }
 
+static inline int sem_is_read_locked(struct rw_semaphore *sem)
+{
+	return (sem->count > 0);
+}
+
+static inline int sem_is_write_locked(struct rw_semaphore *sem)
+{
+	return (sem->count < 0);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _PPC_RWSEM_XADD_H */
diff -uNrp vanilla/include/asm-s390/rwsem.h 2.6.12-rwsem/include/asm-s390/rwsem.h
--- vanilla/include/asm-s390/rwsem.h	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.12-rwsem/include/asm-s390/rwsem.h	2005-06-26 16:33:04.000000000 -0400
@@ -351,5 +351,15 @@ static inline long rwsem_atomic_update(l
 	return new;
 }
 
+static inline int sem_is_read_locked(struct rw_semaphore *sem)
+{
+	return (sem->count > 0);
+}
+
+static inline int sem_is_write_locked(struct rw_semaphore *sem)
+{
+	return (sem->count < 0);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _S390_RWSEM_H */
diff -uNrp vanilla/include/asm-sh/rwsem.h 2.6.12-rwsem/include/asm-sh/rwsem.h
--- vanilla/include/asm-sh/rwsem.h	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.12-rwsem/include/asm-sh/rwsem.h	2005-06-26 16:33:20.000000000 -0400
@@ -166,5 +166,15 @@ static inline int rwsem_atomic_update(in
 	return atomic_add_return(delta, (atomic_t *)(&sem->count));
 }
 
+static inline int sem_is_read_locked(struct rw_semaphore *sem)
+{
+	return (sem->count > 0);
+}
+
+static inline int sem_is_write_locked(struct rw_semaphore *sem)
+{
+	return (sem->count < 0);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_SH_RWSEM_H */
diff -uNrp vanilla/include/asm-sparc64/rwsem.h 2.6.12-rwsem/include/asm-sparc64/rwsem.h
--- vanilla/include/asm-sparc64/rwsem.h	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.12-rwsem/include/asm-sparc64/rwsem.h	2005-06-26 16:43:50.000000000 -0400
@@ -95,6 +95,16 @@ static __inline__ signed long rwsem_cmpx
 	return cmpxchg(&sem->count,old,new);
 }
 
+static inline int sem_is_read_locked(struct rw_semaphore *sem)
+{
+	return (sem->count > 0);
+}
+
+static inline int sem_is_write_locked(struct rw_semaphore *sem)
+{
+	return (sem->count < 0);
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _SPARC64_RWSEM_H */
diff -uNrp vanilla/include/asm-x86_64/rwsem.h 2.6.12-rwsem/include/asm-x86_64/rwsem.h
--- vanilla/include/asm-x86_64/rwsem.h	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.12-rwsem/include/asm-x86_64/rwsem.h	2005-06-26 16:36:35.000000000 -0400
@@ -274,5 +274,15 @@ LOCK_PREFIX	"xaddl %0,(%2)"
 	return tmp+delta;
 }
 
+static inline int sem_is_read_locked(struct rw_semaphore *sem)
+{
+	return (sem->count > 0);
+}
+
+static inline int sem_is_write_locked(struct rw_semaphore *sem)
+{
+	return (sem->count < 0);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _X8664_RWSEM_H */
diff -uNrp vanilla/include/linux/rwsem-spinlock.h 2.6.12-rwsem/include/linux/rwsem-spinlock.h
--- vanilla/include/linux/rwsem-spinlock.h	2005-06-17 15:48:29.000000000 -0400
+++ 2.6.12-rwsem/include/linux/rwsem-spinlock.h	2005-06-26 16:37:56.000000000 -0400
@@ -61,5 +61,15 @@ extern void FASTCALL(__up_read(struct rw
 extern void FASTCALL(__up_write(struct rw_semaphore *sem));
 extern void FASTCALL(__downgrade_write(struct rw_semaphore *sem));
 
+static inline int sem_is_read_locked(struct rw_semaphore *sem)
+{
+	return (sem->activity > 0);
+}
+
+static inline int sem_is_write_locked(struct rw_semaphore *sem)
+{
+	return (sem->activity < 0);
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_RWSEM_SPINLOCK_H */
