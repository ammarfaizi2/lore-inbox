Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318134AbSGWQ0F>; Tue, 23 Jul 2002 12:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318124AbSGWQ0A>; Tue, 23 Jul 2002 12:26:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53452 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318129AbSGWQZp>;
	Tue, 23 Jul 2002 12:25:45 -0400
Message-ID: <3D3D8414.1040201@us.ibm.com>
Date: Tue, 23 Jul 2002 09:28:04 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org, Adam G Litke <aglitke@us.ibm.com>,
       Robert Love <rml@mvista.com>
Subject: [PATCH] reduce code in generic spinlock.h
Content-Type: multipart/mixed;
 boundary="------------010203030106070901080600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010203030106070901080600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The last time lockmeter was ported to 2.5, it was getting a little
messy.  There were separate declarations for spin_*lock() for each
combination of lockmeter and preemption, which made four, plus the
no-smp definition.  While lockmeter's mess isn't the kernel's fault, 
we noticed some some simplifications which could be made to the 
generic spinlock code.  This patch uses a single definition for each 
of the macros, eliminating some redundant code.

In the preemption-off case, spin lock is changed from this:
_raw_spin_lock(lock)
to this:
do {
	preempt_disable();
	_raw_spin_lock(lock)
} while (0)
The preemption-on case is unchanged.

Since preempt_disable() is a do{}while(0) with preemption off anyway,
it gets back to the same effective result as before, with a little
extra work from the compiler.  The preempt_disable() macro just had to
be moved up in the file a bit.

Thanks to Adam Litke <aglitke@us.ibm.com>, who has been doing the
lockmeter port and who initially wrote this patch.

Compiles in all combinations of SMP and preempt.
-- 
Dave Hansen
haveblue@us.ibm.com



--------------010203030106070901080600
Content-Type: text/plain;
 name="spinlock-cleanup-2.5.27-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spinlock-cleanup-2.5.27-2.diff"

diff -ur linux-2.5.27-clean/include/linux/spinlock.h linux-2.5.27/include/linux/spinlock.h
--- linux-2.5.27-clean/include/linux/spinlock.h	Tue Jul 23 09:19:51 2002
+++ linux-2.5.27/include/linux/spinlock.h	Tue Jul 23 09:26:16 2002
@@ -150,6 +150,14 @@
 		preempt_schedule(); \
 } while (0)
 
+#else /* !CONFIG_PREEMPT */
+#define preempt_get_count()		(0)
+#define preempt_disable()		do { } while(0)
+#define preempt_enable_no_resched()	do { } while(0)
+#define preempt_enable()		do { } while(0)
+#define preempt_check_resched()		do { } while(0)
+#endif /* !CONFIG_PREEMPT */
+
 #define spin_lock(lock)	\
 do { \
 	preempt_disable(); \
@@ -176,26 +184,6 @@
 #define write_unlock(lock)	({_raw_write_unlock(lock); preempt_enable();})
 #define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
-
-#else
-
-#define preempt_get_count()		(0)
-#define preempt_disable()		do { } while (0)
-#define preempt_enable_no_resched()	do {} while(0)
-#define preempt_enable()		do { } while (0)
-#define preempt_check_resched()		do { } while (0)
-
-#define spin_lock(lock)			_raw_spin_lock(lock)
-#define spin_trylock(lock)		_raw_spin_trylock(lock)
-#define spin_unlock(lock)		_raw_spin_unlock(lock)
-#define spin_unlock_no_resched(lock)	_raw_spin_unlock(lock)
-
-#define read_lock(lock)			_raw_read_lock(lock)
-#define read_unlock(lock)		_raw_read_unlock(lock)
-#define write_lock(lock)		_raw_write_lock(lock)
-#define write_unlock(lock)		_raw_write_unlock(lock)
-#define write_trylock(lock)		_raw_write_trylock(lock)
-#endif
 
 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK
Only in linux-2.5.27-clean/include/linux: spinlock.h.orig

--------------010203030106070901080600--

