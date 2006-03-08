Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWCHJKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWCHJKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWCHJKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:10:49 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27560
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964886AbWCHJKr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:10:47 -0500
Message-ID: <440E9F91.7080100@tglx.de>
Date: Wed, 08 Mar 2006 10:10:41 +0100
From: Jan Altenberg <tb10alj@tglx.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.15-rt20 compilation errors
References: <6bffcb0e0603070919k64e325f6h@mail.gmail.com>
In-Reply-To: <6bffcb0e0603070919k64e325f6h@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

could you have a look at this patch?
Maybe it helps...

Signed-off-by: Jan Altenberg <tb10alj@tglx.de>

---

diff -uprN -X linux-2.6.15-rt20/Documentation/dontdiff linux-2.6.15-rt20/kernel/rt.c linux-2.6.15-rt20-hacked/kernel/rt.c
--- linux-2.6.15-rt20/kernel/rt.c	2006-03-07 15:05:45.000000000 +0100
+++ linux-2.6.15-rt20-hacked/kernel/rt.c	2006-03-08 09:42:55.000000000 +0100
@@ -1507,7 +1507,7 @@ EXPORT_SYMBOL(_spin_lock_init);
 int __lockfunc _read_trylock(rwlock_t *rwlock)
 {
 	if(debug_rt_lockmode_nopreempt())
-		return debug_rt_lockmode_read_trylock(&lock->lock.lock);
+		return debug_rt_lockmode_read_trylock(&rwlock->lock.lock);
 	else
 		return down_read_trylock_mutex(&rwlock->lock);
 }
@@ -1516,7 +1516,7 @@ EXPORT_SYMBOL(_read_trylock);
 int __lockfunc _write_trylock(rwlock_t *rwlock)
 {
 	if(debug_rt_lockmode_nopreempt())
-		return debug_rt_lockmode_write_trylock(&lock->lock.lock);
+		return debug_rt_lockmode_write_trylock(&rwlock->lock.lock);
 	else
 		return down_write_trylock_mutex(&rwlock->lock);
 }
@@ -1525,7 +1525,7 @@ EXPORT_SYMBOL(_write_trylock);
 inline void __lockfunc _write_lock(rwlock_t *rwlock)
 {
 	if(debug_rt_lockmode_nopreempt())
-		debug_rt_lockmode_write_lock(&lock->lock.lock);
+		debug_rt_lockmode_write_lock(&rwlock->lock.lock);
 	else
 		down_write_mutex(&rwlock->lock, current __CALLER0__);
 }
@@ -1534,7 +1534,7 @@ EXPORT_SYMBOL(_write_lock);
 inline void __lockfunc _read_lock(rwlock_t *rwlock)
 {
 	if(debug_rt_lockmode_nopreempt())
-		debug_rt_lockmode_read_lock(&lock->lock.lock);
+		debug_rt_lockmode_read_lock(&rwlock->lock.lock);
 	else
 		down_read_mutex(&rwlock->lock __CALLER0__);
 }
@@ -1543,7 +1543,7 @@ EXPORT_SYMBOL(_read_lock);
 inline void __lockfunc _write_unlock(rwlock_t *rwlock)
 {
 	if(debug_rt_lockmode_nopreempt())
-		debug_rt_lockmode_write_unlock(&lock->lock.lock);
+		debug_rt_lockmode_write_unlock(&rwlock->lock.lock);
 	else
 		up_write_mutex(&rwlock->lock __CALLER0__);
 }
@@ -1552,7 +1552,7 @@ EXPORT_SYMBOL(_write_unlock);
 static inline void __read_unlock(rwlock_t *rwlock)
 {
 	if(debug_rt_lockmode_nopreempt())
-		debug_rt_lockmode_read_unlock(&lock->lock.lock);
+		debug_rt_lockmode_read_unlock(&rwlock->lock.lock);
 	else
 		up_read_mutex(&rwlock->lock __CALLER0__);
 }
diff -uprN -X linux-2.6.15-rt20/Documentation/dontdiff linux-2.6.15-rt20/kernel/rt-debug.h linux-2.6.15-rt20-hacked/kernel/rt-debug.h
--- linux-2.6.15-rt20/kernel/rt-debug.h	2006-03-07 15:05:45.000000000 +0100
+++ linux-2.6.15-rt20-hacked/kernel/rt-debug.h	2006-03-08 09:52:05.000000000 +0100
@@ -234,48 +234,48 @@ do {						\
 #ifdef CONFIG_DEBUG_RT_LOCKING_MODE

 # define debug_rt_lockmode_init(_lock)			\
-	_raw_rwlock_init((_lock)->debug_slock)
+	_raw_spin_lock_init(&(_lock)->debug_slock)

 # define debug_rt_lockmode_nopreempt()			(!preempt_locks)

 # define debug_rt_lockmode_spin_lock(_lock)		\
-	_raw_spin_lock((_lock)->debug_slock)
+	_raw_spin_lock(&(_lock)->debug_slock)

 # define debug_rt_lockmode_spin_unlock(_lock)		\
-	_raw_spin_unlock((_lock)->debug_slock)
+	_raw_spin_unlock(&(_lock)->debug_slock)

 # define debug_rt_lockmode_spin_is_locked(_lock)	\
-	_raw_spin_is_locked((_lock)->debug_slock)
+	_raw_spin_is_locked(&(_lock)->debug_slock)

 # define debug_rt_lockmode_spin_trylock(_lock)		\
-	_raw_spin_trylock((_lock)->debug_slock)
+	_raw_spin_trylock(&(_lock)->debug_slock)

 # define debug_rt_lockmode_initrw(_lock)		\
-	_raw_rwlock_init((_lock)->debug_rwlock)
+	_raw_rwlock_init(&(_lock)->debug_rwlock)

 # define debug_rt_lockmode_read_can_lock(_lock)		\
-	_raw_read_can_lock((_lock)->debug_rwlock)
+	_raw_read_can_lock(&(_lock)->debug_rwlock)

 # define debug_rt_lockmode_write_can_lock(_lock)	\
-	_raw_write_can_lock((_lock)->debug_rwlock)
+	_raw_write_can_lock(&(_lock)->debug_rwlock)

 # define debug_rt_lockmode_read_trylock(_lock)		\
-	_raw_read_trylock((_lock)->debug_rwlock)
+	_raw_read_trylock(&(_lock)->debug_rwlock)

 # define debug_rt_lockmode_write_trylock(_lock)		\
-	_raw_write_trylock((_lock)->debug_rwlock)
+	_raw_write_trylock(&(_lock)->debug_rwlock)

 # define debug_rt_lockmode_read_lock(_lock)		\
-	_raw_read_lock((_lock)->debug_rwlock)
+	_raw_read_lock(&(_lock)->debug_rwlock)

 # define debug_rt_lockmode_write_lock(_lock)		\
-	_raw_write_lock((_lock)->debug_rwlock)
+	_raw_write_lock(&(_lock)->debug_rwlock)

 # define debug_rt_lockmode_read_unlock(_lock)		\
-	_raw_read_unlock((_lock)->debug_rwlock)
+	_raw_read_unlock(&(_lock)->debug_rwlock)

 # define debug_rt_lockmode_write_unlock(_lock)		\
-	_raw_write_unlock((_lock)->debug_rwlock)
+	_raw_write_unlock(&(_lock)->debug_rwlock)

 #else

