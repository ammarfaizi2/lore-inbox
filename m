Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWFBVWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWFBVWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWFBVWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:22:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:32417 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030289AbWFBVWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:22:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:from:x-x-sender:to:cc:subject:message-id:references:mime-version:content-type;
        b=AuIV+0NfG33UJlV6pmxfgB3SUd66vpk8PZka0p07bvVz/9o1ncF8GlLHC1AlK5W50XX16iZW7MYi8/VgXNX2kSm7vBAy9ob9NOSqKKWMzmbTFho4co8yzT3xaasg4xsyX1o+VEqeTZLij9lp1i+i3FQgDjerUiZrr9IiZATWpkk=
Date: Fri, 2 Jun 2006 23:23:00 +0100 (BST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@localhost
To: linux-kernel@vger.kernel.org
cc: Ingo Molnar <mingo@elte.hu>
Subject: [patch 1/5] [PREEMPT_RT] Changing interrupt handlers from running
 in thread to hardirq and back runtime.
Message-ID: <Pine.LNX.4.64.0606022321310.9307@localhost>
References: <20060602165336.147812000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains a new lock type based which can be both a raw_spin_lock
and a rt_lock (a rt_mutex basicly). The type can be changed _runtime_. 
spin_mutex_t is a direct drop-in for spin_lock_t. Under PREEMPT_RT it works as 
a rt_lock to begin with otherwise it works as a raw_spin_lock.

The behavior can be changed with the functions

void spin_mutex_to_mutex(spin_mutex_t *lock);
void spin_mutex_to_spin(spin_mutex_t *lock);

These functions can block because they have to be sure they are the owner of
rt_lock before doing the change-over.

Index: linux-2.6.16-rt25/include/linux/spin_mutex.h
===================================================================
--- /dev/null
+++ linux-2.6.16-rt25/include/linux/spin_mutex.h
@@ -0,0 +1,116 @@
+/*
+ * Locks which runtime can be changed from spin lock to mutex and back again
+ *
+ * Copyright (c) 2006 Esben Nielsen
+ *
+ */
+
+#ifndef __LINUX_SPIN_MUTEX_H
+#define __LINUX_SPIN_MUTEX_H
+
+#ifndef CONFIG_SPIN_MUTEXES
+#include <linux/spinlock.h>
+
+/*
+ * A spin_mutex_t is now just a spinlock_t, which can be a raw_spinlock_t or
+ * a rt_mutex_t.
+ * The macros for locking picks up the right operations before picking up the
+ * specific spin_mutex_t operations, which will now be bad operations
+ */
+
+typedef spinlock_t spin_mutex_t;
+
+#define spin_mutex_lock_init(lock,lockname,file,line) __bad_spinlock_type()
+#define spin_mutex_lock(lock) __bad_spinlock_type()
+#define spin_mutex_trylock(lock) __bad_spinlock_type()
+#define spin_mutex_unlock(lock) __bad_spinlock_type()
+#define spin_mutex_lock_bh(lock) __bad_spinlock_type()
+#define spin_mutex_unlock_bh(lock) __bad_spinlock_type()
+#define spin_mutex_lock_irq(lock) __bad_spinlock_type()
+#define spin_mutex_unlock_irq(lock) __bad_spinlock_type()
+#define spin_mutex_lock_irqsave(lock) __bad_spinlock_type()
+#define spin_mutex_trylock_irqsave(lock, flags) __bad_spinlock_type()
+#define spin_mutex_unlock_irqrestore(lock, flags) __bad_spinlock_type()
+#define spin_mutex_unlock_no_resched(lock) __bad_spinlock_type()
+#define spin_mutex_unlock_wait(lock) __bad_spinlock_type()
+#define spin_mutex_is_locked(lock) __bad_spinlock_type()
+
+static inline void spin_mutex_to_mutex(spin_mutex_t *lock)
+{
+}
+
+static inline void spin_mutex_to_spin(spin_mutex_t *lock)
+{
+}
+
+static inline int spin_mutexes_can_spin(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+	return 0;
+#else
+	return 1;
+#endif
+}
+
+#else /* CONFIG_SPIN_MUTEXES */
+
+
+#include <linux/rtmutex.h>
+
+enum spin_mutex_state {
+	SPIN_MUTEX_SPIN,
+	SPIN_MUTEX_MUTEX
+};
+
+struct spin_mutex {
+	/* The state variable is protected by the mutex or
+	   mutex.wait_lock depending on it's value */
+	enum spin_mutex_state state;
+	struct rt_mutex mutex;
+};
+
+typedef struct spin_mutex spin_mutex_t;
+
+#define __SPIN_MUTEX_INITIALIZER(mutexname,s) \
+	{ .state = (s),  \
+          .mutex = (struct rt_mutex)__RT_MUTEX_INITIALIZER(mutexname) }
+
+#define DEFINE_SPIN_MUTEX(mutexname,s) \
+	spin_mutex_t mutexname = __SPIN_MUTEX_INITIALIZER(mutexname,s)
+
+void spin_mutex_lock_init(spin_mutex_t *lock,
+			  const char *lockname,
+			  const char *file,
+			  int line);
+/* May block, depending on state */
+void spin_mutex_lock(spin_mutex_t *lock);
+int spin_mutex_trylock(spin_mutex_t *lock);
+void spin_mutex_unlock(spin_mutex_t *lock);
+void spin_mutex_unlock_no_resched(spin_mutex_t *lock);
+void spin_mutex_unlock_wait(spin_mutex_t *lock);
+
+void spin_mutex_lock_irq(spin_mutex_t *lock);
+int spin_mutex_trylock_irq(spin_mutex_t *lock);
+void spin_mutex_unlock_irq(spin_mutex_t *lock);
+
+unsigned long spin_mutex_lock_bh(spin_mutex_t *lock);
+int spin_mutex_trylock_bh(spin_mutex_t *lock);
+void spin_mutex_unlock_bh(spin_mutex_t *lock);
+
+int spin_mutex_is_locked(spin_mutex_t *lock);
+
+unsigned long spin_mutex_lock_irqsave(spin_mutex_t *lock);
+int spin_mutex_trylock_irqsave(spin_mutex_t *lock, unsigned long *flags);
+void spin_mutex_unlock_irqrestore(spin_mutex_t *lock, unsigned long flags);
+
+static inline int spin_mutexes_can_spin(void)
+{
+	return 1;
+}
+
+/* Blocks until the lock is converted */;
+void spin_mutex_to_mutex(spin_mutex_t *lock);
+void spin_mutex_to_spin(spin_mutex_t *lock);
+
+#endif /* CONFIG_SPIN_MUTEXES */
+#endif
Index: linux-2.6.16-rt25/include/linux/spinlock.h
===================================================================
--- linux-2.6.16-rt25.orig/include/linux/spinlock.h
+++ linux-2.6.16-rt25/include/linux/spinlock.h
@@ -209,6 +209,8 @@ do {								\
  		_raw_##optype##op((type *)(lock));		\
  	else if (TYPE_EQUAL(lock, spinlock_t))			\
  		_spin##op((spinlock_t *)(lock));		\
+	else if (TYPE_EQUAL(lock, spin_mutex_t))       		\
+		spin_mutex##op((spin_mutex_t *)(lock));		\
  	else __bad_spinlock_type();				\
  } while (0)

@@ -220,6 +222,8 @@ do {								\
  		__ret = _raw_##optype##op((type *)(lock));	\
  	else if (TYPE_EQUAL(lock, spinlock_t))			\
  		__ret = _spin##op((spinlock_t *)(lock));	\
+	else if (TYPE_EQUAL(lock, spin_mutex_t))		\
+		__ret = spin_mutex##op((spin_mutex_t *)(lock));	\
  	else __ret = __bad_spinlock_type();			\
  								\
  	__ret;							\
@@ -231,6 +235,8 @@ do {								\
  		_raw_##optype##op((type *)(lock), flags);	\
  	else if (TYPE_EQUAL(lock, spinlock_t))			\
  		_spin##op((spinlock_t *)(lock), flags);		\
+	else if (TYPE_EQUAL(lock, spin_mutex_t))	       	\
+		spin_mutex##op((spin_mutex_t *)(lock), flags);	\
  	else __bad_spinlock_type();				\
  } while (0)

@@ -242,6 +248,8 @@ do {								\
  		__ret = _raw_##optype##op((type *)(lock), flags);\
  	else if (TYPE_EQUAL(lock, spinlock_t))			\
  		__ret = _spin##op((spinlock_t *)(lock), flags);	\
+	else if (TYPE_EQUAL(lock, spin_mutex_t))       		\
+		__ret = spin_mutex##op((spin_mutex_t *)(lock), flags);\
  	else __bad_spinlock_type();				\
  								\
  	__ret;							\
@@ -347,6 +355,8 @@ do {									\
  		_raw_##optype##op((type *)(lock));			\
  	else if (TYPE_EQUAL(lock, spinlock_t))				\
  		_spin##op((spinlock_t *)(lock), #lock, __FILE__, __LINE__); \
+	else if (TYPE_EQUAL(lock, spin_mutex_t))		       	\
+		spin_mutex##op((spin_mutex_t *)(lock), #lock, __FILE__, __LINE__); \
  	else __bad_spinlock_type();					\
  } while (0)

@@ -579,5 +589,7 @@ static inline int bit_spin_is_locked(int
   */
  #define __raw_spin_can_lock(lock)            (!__raw_spin_is_locked(lock))

+#include <linux/spin_mutex.h>
+
  #endif /* __LINUX_SPINLOCK_H */

Index: linux-2.6.16-rt25/init/Kconfig
===================================================================
--- linux-2.6.16-rt25.orig/init/Kconfig
+++ linux-2.6.16-rt25/init/Kconfig
@@ -332,6 +332,10 @@ config RT_MUTEXES
  	boolean
  	select PLIST

+config SPIN_MUTEXES
+	bool "Locks which can be changed between spinlocks and mutexes runtime."
+	select RT_MUTEXES
+
  config FUTEX
  	bool "Enable futex support" if EMBEDDED
  	default y
Index: linux-2.6.16-rt25/kernel/Makefile
===================================================================
--- linux-2.6.16-rt25.orig/kernel/Makefile
+++ linux-2.6.16-rt25/kernel/Makefile
@@ -19,6 +19,7 @@ ifeq ($(CONFIG_COMPAT),y)
  obj-$(CONFIG_FUTEX) += futex_compat.o
  endif
  obj-$(CONFIG_RT_MUTEXES) += rtmutex.o
+obj-$(CONFIG_SPIN_MUTEXES) += spin_mutex.o
  obj-$(CONFIG_DEBUG_RT_MUTEXES) += rtmutex-debug.o
  obj-$(CONFIG_RT_MUTEX_TESTER) += rtmutex-tester.o
  obj-$(CONFIG_PREEMPT_RT) += rt.o
Index: linux-2.6.16-rt25/kernel/spin_mutex.c
===================================================================
--- /dev/null
+++ linux-2.6.16-rt25/kernel/spin_mutex.c
@@ -0,0 +1,153 @@
+#include <linux/spin_mutex.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+
+#include "rtmutex_common.h"
+
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+# include "rtmutex-debug.h"
+#else
+# include "rtmutex.h"
+#endif
+
+
+void spin_mutex_lock_init(struct spin_mutex *lock,
+			  const char *name,
+			  const char *file,
+			  int line)
+{
+#ifdef CONFIG_PREEMPT_RT
+	lock->state = SPIN_MUTEX_MUTEX;
+#else
+	lock->state = SPIN_MUTEX_SPIN;
+#endif
+	rt_mutex_init(&lock->mutex);
+}
+
+static inline int spin_mutex_lock_common(struct spin_mutex *lock,
+					 unsigned long *flags, int try)
+{
+ retry:
+	switch(lock->state) {
+	case SPIN_MUTEX_SPIN:
+		if (try) {
+			if (!spin_trylock_irqsave(&lock->mutex.wait_lock,
+						 *flags))
+				return 0;
+		}
+		else
+			spin_lock_irqsave(&lock->mutex.wait_lock, *flags);
+
+		if (unlikely(lock->state != SPIN_MUTEX_SPIN)) {
+			spin_unlock_irqrestore(&lock->mutex.wait_lock, *flags);
+			goto retry;
+		}
+		return 1;
+	case SPIN_MUTEX_MUTEX:
+		*flags = 0;
+		if (try) {
+			if (!rt_mutex_trylock(&lock->mutex))
+				return 0;
+		}
+		else
+			rt_lock(&lock->mutex);
+
+		if (unlikely(lock->state != SPIN_MUTEX_MUTEX)) {
+			rt_unlock(&lock->mutex);
+			goto retry;
+		}
+		return 1;
+	}
+	BUG_ON(1);
+}
+
+
+unsigned long spin_mutex_lock_irqsave(struct spin_mutex *lock)
+{
+	unsigned long flags;
+	spin_mutex_lock_common(lock, &flags, 0);
+
+	return flags;
+}
+
+void spin_mutex_lock_irq(struct spin_mutex *lock)
+{
+	unsigned long flags;
+	spin_mutex_lock_common(lock, &flags, 0);
+}
+
+void spin_mutex_lock(struct spin_mutex *lock)
+{
+	unsigned long flags;
+	spin_mutex_lock_common(lock, &flags, 0);
+}
+
+
+int spin_mutex_trylock_irqsave(struct spin_mutex *lock,
+			       unsigned long *flags)
+{
+	return spin_mutex_lock_common(lock, flags, 1);
+}
+
+void spin_mutex_unlock_irqrestore(struct spin_mutex *lock, unsigned long flags)
+{
+	switch(lock->state) {
+	case SPIN_MUTEX_SPIN:
+		spin_unlock_irqrestore(&lock->mutex.wait_lock, flags);
+		break;
+	case SPIN_MUTEX_MUTEX:
+		rt_unlock(&lock->mutex);
+		break;
+	}
+}
+
+void spin_mutex_unlock_irq(struct spin_mutex *lock)
+{
+	switch(lock->state) {
+	case SPIN_MUTEX_SPIN:
+		spin_unlock_irq(&lock->mutex.wait_lock);
+		break;
+	case SPIN_MUTEX_MUTEX:
+		rt_unlock(&lock->mutex);
+		break;
+	}
+}
+
+void spin_mutex_unlock(struct spin_mutex *lock)
+{
+	switch(lock->state) {
+	case SPIN_MUTEX_SPIN:
+		spin_unlock(&lock->mutex.wait_lock);
+		break;
+	case SPIN_MUTEX_MUTEX:
+		rt_unlock(&lock->mutex);
+		break;
+	}
+}
+
+void spin_mutex_to_mutex(struct spin_mutex *lock)
+{
+	unsigned long flags;
+
+	rt_lock(&lock->mutex);
+	spin_lock_irqsave(&lock->mutex.wait_lock,flags);
+
+	lock->state = SPIN_MUTEX_MUTEX;
+
+	spin_unlock_irqrestore(&lock->mutex.wait_lock,flags);
+	rt_unlock(&lock->mutex);
+}
+
+/* Blocks until converted */;
+void spin_mutex_to_spin(struct spin_mutex *lock)
+{
+	unsigned long flags;
+
+	rt_lock(&lock->mutex);
+	spin_lock_irqsave(&lock->mutex.wait_lock,flags);
+
+	lock->state = SPIN_MUTEX_SPIN;
+
+	spin_unlock_irqrestore(&lock->mutex.wait_lock,flags);
+	rt_unlock(&lock->mutex);
+}
Index: linux-2.6.16-rt25/kernel/rtmutex.c
===================================================================
--- linux-2.6.16-rt25.orig/kernel/rtmutex.c
+++ linux-2.6.16-rt25/kernel/rtmutex.c
@@ -585,7 +585,7 @@ static void remove_waiter(struct rt_mute
  	spin_lock(&lock->wait_lock);
  }

-#ifdef CONFIG_PREEMPT_RT
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_SPIN_MUTEX)

  static inline void
  rt_lock_fastlock(struct rt_mutex *lock,

--
