Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTDVXsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 19:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTDVXsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 19:48:55 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:61119 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263913AbTDVXsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 19:48:51 -0400
Date: Tue, 22 Apr 2003 17:02:32 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: akpm@digeo.com
cc: hannal@us.ibm.com, linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: [PATCH 2.5.68-mm1] lockmeter fix from tytso
Message-ID: <162650000.1051056152@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is a fix from Ted Ts'o that I have tested and ported to the 
2.5.68-mm1 kernel. Here is the note from Ted describing the
problem:

> ridiculous hold times for a network spin lock that I *knew* wasn't
> right.  What was happening was that networking code was using
> spin_lock_bh to enter the lock, did some work, then called a function
> which called spin_unlock to temporarily release the lock, and then
> called spin_lock.  The top level function then called spin_unlock_bh.
> Because spin_{lock,unlock}_bh wasn't being metered, the result was
> ridiculous hold times.


Here is the patch. However, in order to test it I discovered that
the config LOCKMETER part of the original patch has been dropped.
I have included the code to add it back in for the i386 arch. Let
me know if there was a reason to remove it from the config ;)

Thanks a lot for fixing the preempt problem too. I definitely
owe you one...

Hanna

----------

diff -Nrup -Xdontdiff linux-2.5.68-mm1/arch/i386/Kconfig linux-lockmeter/arch/i386/Kconfig
--- linux-2.5.68-mm1/arch/i386/Kconfig	Tue Apr 22 14:45:33 2003
+++ linux-lockmeter/arch/i386/Kconfig	Tue Apr 22 16:38:36 2003
@@ -1573,6 +1573,13 @@ config DEBUG_SPINLOCK_SLEEP
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.	
 
+config LOCKMETER
+	bool "Kernel lock metering"
+	depends on SMP
+	help
+	  Say Y to enable kernel lock metering, which adds overhead to SMP locks,
+	  but allows you to see various statistics using the lockstat command.
+
 config KGDB
 	bool "Include kgdb kernel debugger"
 	depends on DEBUG_KERNEL
diff -Nrup -Xdontdiff linux-2.5.68-mm1/include/linux/spinlock.h linux-lockmeter/include/linux/spinlock.h
--- linux-2.5.68-mm1/include/linux/spinlock.h	Tue Apr 22 14:45:45 2003
+++ linux-lockmeter/include/linux/spinlock.h	Tue Apr 22 14:46:28 2003
@@ -400,6 +400,27 @@ do { \
 				({preempt_enable(); local_bh_enable(); 0;});})
 
 #ifdef CONFIG_LOCKMETER
+#undef spin_lock
+#undef spin_trylock
+#undef spin_unlock
+#undef spin_lock_irqsave
+#undef spin_lock_irq
+#undef spin_lock_bh
+#undef read_lock
+#undef read_unlock
+#undef write_lock
+#undef write_unlock
+#undef write_trylock
+#undef spin_unlock_bh
+#undef read_lock_irqsave
+#undef read_lock_irq
+#undef read_lock_bh
+#undef read_unlock_bh
+#undef write_lock_irqsave
+#undef write_lock_irq
+#undef write_lock_bh
+#undef write_unlock_bh
+
 #define spin_lock(lock) \
 do { \
 	preempt_disable(); \
@@ -414,6 +435,35 @@ do { \
 	preempt_enable(); \
 } while (0)
 
+#define spin_lock_irqsave(lock, flags) \
+do { \
+	local_irq_save(flags); \
+	preempt_disable(); \
+	_metered_spin_lock(lock); \
+} while (0)
+
+#define spin_lock_irq(lock) \
+do { \
+	local_irq_disable(); \
+	preempt_disable(); \
+	_metered_spin_lock(lock); \
+} while (0)
+
+#define spin_lock_bh(lock) \
+do { \
+	local_bh_disable(); \
+	preempt_disable(); \
+	_metered_spin_lock(lock); \
+} while (0)
+
+#define spin_unlock_bh(lock) \
+do { \
+	_metered_spin_unlock(lock); \
+	preempt_enable(); \
+	local_bh_enable(); \
+} while (0)
+
+
 #define read_lock(lock)                ({preempt_disable(); _metered_read_lock(lock);})
 #define read_unlock(lock)      ({_metered_read_unlock(lock); preempt_enable();})
 #define write_lock(lock)       ({preempt_disable(); _metered_write_lock(lock);})
@@ -426,6 +476,62 @@ do { \
 	preempt_enable_no_resched(); \
 } while (0)
 
+#define read_lock_irqsave(lock, flags) \
+do { \
+	local_irq_save(flags); \
+	preempt_disable(); \
+	_metered_read_lock(lock); \
+} while (0)
+
+#define read_lock_irq(lock) \
+do { \
+	local_irq_disable(); \
+	preempt_disable(); \
+	_metered_read_lock(lock); \
+} while (0)
+
+#define read_lock_bh(lock) \
+do { \
+	local_bh_disable(); \
+	preempt_disable(); \
+	_metered_read_lock(lock); \
+} while (0)
+
+#define read_unlock_bh(lock) \
+do { \
+	_metered_read_unlock(lock); \
+	preempt_enable(); \
+	local_bh_enable(); \
+} while (0)
+
+#define write_lock_irqsave(lock, flags) \
+do { \
+	local_irq_save(flags); \
+	preempt_disable(); \
+	_metered_write_lock(lock); \
+} while (0)
+
+#define write_lock_irq(lock) \
+do { \
+	local_irq_disable(); \
+	preempt_disable(); \
+	_metered_write_lock(lock); \
+} while (0)
+
+#define write_lock_bh(lock) \
+do { \
+	local_bh_disable(); \
+	preempt_disable(); \
+	_metered_write_lock(lock); \
+} while (0)
+
+#define write_unlock_bh(lock) \
+do { \
+	_metered_write_unlock(lock); \
+	preempt_enable(); \
+	local_bh_enable(); \
+} while (0)
+
 #endif /* !CONFIG_LOCKMETER */
 
 /* "lock on reference count zero" */

