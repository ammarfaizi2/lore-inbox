Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSG1Rrv>; Sun, 28 Jul 2002 13:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSG1Rrv>; Sun, 28 Jul 2002 13:47:51 -0400
Received: from h-64-105-136-34.SNVACAID.covad.net ([64.105.136.34]:26281 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316969AbSG1Rru>; Sun, 28 Jul 2002 13:47:50 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 28 Jul 2002 10:50:58 -0700
Message-Id: <200207281750.KAA19369@baldur.yggdrasil.com>
To: dhowells@redhat.com
Subject: Patch: linux-2.5.29 __downgrade_write() for CONFIG_RWSEM_GENERIC_SPINLOCK
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.5.29 lacks __downgrade_write() platforms that use
CONFIG_RWSEM_GENERIC_SPINLOCK, such as i386 (as opposed to later x86
processors).  This causes a compiler warnings for compilations
of numerous files.

	Although noting in 2.5.29 appears to use downgrade_write(),
I assume that the facility was added because it is going to be used
in the near future.  So, I've added what I think is an implementation
of __downgrade_write for lib/rwsem-spinlock.c.  It is the same as
__up_write, except that it sets sem->activity to 1.  Since nothing
uses it yet, I haven't tested it.

	David, please let me know if you are going to forward this
to Linus, if you want me to submit it to Linus, or if you want to
do something else.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.29/include/linux/rwsem-spinlock.h	2002-07-26 19:58:39.000000000 -0700
+++ linux/include/linux/rwsem-spinlock.h	2002-07-28 10:38:59.000000000 -0700
@@ -57,6 +57,7 @@
 extern void FASTCALL(__down_write(struct rw_semaphore *sem));
 extern void FASTCALL(__up_read(struct rw_semaphore *sem));
 extern void FASTCALL(__up_write(struct rw_semaphore *sem));
+extern void FASTCALL(__downgrade_write(struct rw_semaphore *sem));
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_RWSEM_SPINLOCK_H */
--- linux-2.5.29/lib/rwsem-spinlock.c	2002-07-26 19:58:30.000000000 -0700
+++ linux/lib/rwsem-spinlock.c	2002-07-28 10:49:30.000000000 -0700
@@ -229,11 +229,30 @@
 	rwsemtrace(sem,"Leaving __up_write");
 }
 
+/*
+ * downgrade a write lock into a read lock
+ */
+void __downgrade_write(struct rw_semaphore *sem)
+{
+	rwsemtrace(sem,"Entering __downgrade_write");
+
+	spin_lock(&sem->wait_lock);
+
+	sem->activity = 1;
+	if (!list_empty(&sem->wait_list))
+		sem = __rwsem_do_wake(sem);
+
+	spin_unlock(&sem->wait_lock);
+
+	rwsemtrace(sem,"Leaving __downgrade_write");
+}
+
 EXPORT_SYMBOL(init_rwsem);
 EXPORT_SYMBOL(__down_read);
 EXPORT_SYMBOL(__down_write);
 EXPORT_SYMBOL(__up_read);
 EXPORT_SYMBOL(__up_write);
+EXPORT_SYMBOL(__downgrade_write);
 #if RWSEM_DEBUG
 EXPORT_SYMBOL(rwsemtrace);
 #endif
