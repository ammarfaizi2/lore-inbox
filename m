Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbTDLP0X (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 11:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTDLP0W (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 11:26:22 -0400
Received: from dhcp065-024-013-119.columbus.rr.com ([65.24.13.119]:220 "EHLO
	united.lan.codewhore.org") by vger.kernel.org with ESMTP
	id S263314AbTDLP0V (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 11:26:21 -0400
Date: Sat, 12 Apr 2003 11:29:51 -0400
From: David Brown <dave@codewhore.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Preempt on PowerPC/SMP appears to leak memory
Message-ID: <20030412152951.GA10367@codewhore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I recently applied the preempt-kernel-rml-2.4.21-pre1-1.patch from
kernel.org to BenH's stable tree from rsync.penguinppc.org. With the
following modification, I was able to get a preemptive kernel running on
a dual 1Ghz PowerMac in SMP mode:

diff -urN linux-2.4.20-preempt/include/asm-ppc/spinlock.h linux-2.4.20-dev/include/asm-ppc/spinlock.h
--- linux-2.4.20-preempt/include/asm-ppc/spinlock.h	2003-04-06 22:35:45.000000000 -0400
+++ linux-2.4.20-dev/include/asm-ppc/spinlock.h	2003-04-06 01:30:48.000000000 -0500
@@ -49,7 +49,7 @@
 
 #else /* ! SPINLOCK_DEBUG */
 
-static inline void spin_lock(spinlock_t *lock)
+static inline void _raw_spin_lock(spinlock_t *lock)
 {
 	unsigned long tmp;
 
@@ -69,13 +69,13 @@
 	: "cr0", "memory");
 }
 
-static inline void spin_unlock(spinlock_t *lock)
+static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 	__asm__ __volatile__("eieio		# spin_unlock": : :"memory");
 	lock->lock = 0;
 }
 
-#define spin_trylock(lock) (!test_and_set_bit(0,(lock)))
+#define _raw_spin_trylock(lock) (!test_and_set_bit(0,(lock)))
 
 #endif
 
@@ -119,7 +119,7 @@
 
 #else /* ! SPINLOCK_DEBUG */
 
-static __inline__ void read_lock(rwlock_t *rw)
+static __inline__ void _raw_read_lock(rwlock_t *rw)
 {
 	unsigned int tmp;
 
@@ -139,7 +139,7 @@
 	: "cr0", "memory");
 }
 
-static __inline__ void read_unlock(rwlock_t *rw)
+static __inline__ void _raw_read_unlock(rwlock_t *rw)
 {
 	unsigned int tmp;
 
@@ -154,7 +154,7 @@
 	: "cr0", "memory");
 }
 
-static __inline__ void write_lock(rwlock_t *rw)
+static __inline__ void _raw_write_lock(rwlock_t *rw)
 {
 	unsigned int tmp;
 
@@ -174,7 +174,7 @@
 	: "cr0", "memory");
 }
 
-static __inline__ void write_unlock(rwlock_t *rw)
+static __inline__ void _raw_write_unlock(rwlock_t *rw)
 {
 	__asm__ __volatile__("eieio		# write_unlock": : :"memory");
 	rw->lock = 0;


Unfortunately, something appears to be leaking memory across forks.
Running `while /bin/true; do /bin/echo -n; done` manages to trigger the
OOM killer within 2 minutes. Under normal load (make -j3 and gcc), the
machine takes over an hour to leak away its 256MB of memory. In both
cases, after the login shell is killed, a SysRq to 'dump memory' shows
roughly 2MB free, with the rest allocated.

Before I debug/trace any further, I'm curious as to whether or not
preempt is known to work on PowerPC in SMP mode. If it's supposed to,
I'd be happy to capture any data that may help.

Anyway - any help or advice would be greatly appreciated.

Thanks,

- Dave
  dave@codewhore.org

