Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267362AbTAOWYa>; Wed, 15 Jan 2003 17:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267364AbTAOWYa>; Wed, 15 Jan 2003 17:24:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:36265 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267362AbTAOWY1>;
	Wed, 15 Jan 2003 17:24:27 -0500
Date: Wed, 15 Jan 2003 14:33:13 -0800
From: Andrew Morton <akpm@digeo.com>
To: Robert Macaulay <robert_macaulay@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.57 IO slowdown with CONFIG_PREEMPT enabled
Message-Id: <20030115143313.76953b63.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301151604000.22150-100000@ping.us.dell.com>
References: <20030115111834.41881823.akpm@digeo.com>
	<Pine.LNX.4.44.0301151604000.22150-100000@ping.us.dell.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2003 22:33:13.0274 (UTC) FILETIME=[16EA29A0:01C2BCE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Macaulay <robert_macaulay@dell.com> wrote:
>
> No change either

OK, thanks.  The below patch reverts the spinlocking change,
if you could please test that with CONFIG_PREEMPT=y

> 
> I have been hitting an odd issue, and I haven't had a chance to traceback
> to where it came from(versionwise). FS changes seem to be getting rolled
> back at times.  For example, I run make menuconfig, add my config options
> for CONFIG_MEGARAID to be built in, and recompile kernel. I install and
> reboot, and that config file, which contained CONFIG_MEGARAID=y, reverts
> back to its original state. multiple syncs seem to keep this in the 
> correct state. The filesystem that this is occuring on is ext3, mounted 
> with defaults, on a megaraid controller. I'll trace this down later and 
> post results.

Suggest that you make sure it's not some strangeness in the kernel build
system which is writing out a modified .config file.



 include/linux/spinlock.h |   56 ++++++++++++++---------------------------------
 kernel/ksyms.c           |    4 ---
 kernel/sched.c           |   47 ---------------------------------------
 3 files changed, 17 insertions(+), 90 deletions(-)

diff -puN include/linux/spinlock.h~preempt-oddity include/linux/spinlock.h
--- 25/include/linux/spinlock.h~preempt-oddity	Wed Jan 15 14:28:20 2003
+++ 25-akpm/include/linux/spinlock.h	Wed Jan 15 14:28:53 2003
@@ -85,37 +85,31 @@
  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
  * methods are defined as nops in the case they are not required.
  */
-#define spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
+#define spin_lock(lock)	\
+do { \
+	preempt_disable(); \
+	_raw_spin_lock(lock); \
+} while(0)
 
-#define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
+#define spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
 
-/* Where's read_trylock? */
-
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-void __preempt_spin_lock(spinlock_t *lock);
-void __preempt_write_lock(rwlock_t *lock);
-
-#define spin_lock(lock) \
+#define spin_unlock(lock) \
 do { \
-	preempt_disable(); \
-	if (unlikely(!_raw_spin_trylock(lock))) \
-		__preempt_spin_lock(lock); \
+	_raw_spin_unlock(lock); \
+	preempt_enable(); \
 } while (0)
 
-#define write_lock(lock) \
+#define read_lock(lock)	\
 do { \
 	preempt_disable(); \
-	if (unlikely(!_raw_write_trylock(lock))) \
-		__preempt_write_lock(lock); \
-} while (0)
+	_raw_read_lock(lock); \
+} while(0)
 
-#else
-#define spin_lock(lock)	\
+#define read_unlock(lock) \
 do { \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
+	_raw_read_unlock(lock); \
+	preempt_enable(); \
 } while(0)
 
 #define write_lock(lock) \
@@ -123,19 +117,6 @@ do { \
 	preempt_disable(); \
 	_raw_write_lock(lock); \
 } while(0)
-#endif
-
-#define read_lock(lock)	\
-do { \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-} while(0)
-
-#define spin_unlock(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	preempt_enable(); \
-} while (0)
 
 #define write_unlock(lock) \
 do { \
@@ -143,11 +124,8 @@ do { \
 	preempt_enable(); \
 } while(0)
 
-#define read_unlock(lock) \
-do { \
-	_raw_read_unlock(lock); \
-	preempt_enable(); \
-} while(0)
+#define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
+				1 : ({preempt_enable(); 0;});})
 
 #define spin_lock_irqsave(lock, flags) \
 do { \
diff -puN kernel/sched.c~preempt-oddity kernel/sched.c
--- 25/kernel/sched.c~preempt-oddity	Wed Jan 15 14:28:24 2003
+++ 25-akpm/kernel/sched.c	Wed Jan 15 14:28:53 2003
@@ -2278,50 +2278,3 @@ void __might_sleep(char *file, int line)
 #endif
 }
 #endif
-
-
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-/*
- * This could be a long-held lock.  If another CPU holds it for a long time,
- * and that CPU is not asked to reschedule then *this* CPU will spin on the
- * lock for a long time, even if *this* CPU is asked to reschedule.
- *
- * So what we do here, in the slow (contended) path is to spin on the lock by
- * hand while permitting preemption.
- *
- * Called inside preempt_disable().
- */
-void __preempt_spin_lock(spinlock_t *lock)
-{
-	if (preempt_count() > 1) {
-		_raw_spin_lock(lock);
-		return;
-	}
-
-	while (!_raw_spin_trylock(lock)) {
-		if (need_resched()) {
-			preempt_enable_no_resched();
-			__cond_resched();
-			preempt_disable();
-		}
-		cpu_relax();
-	}
-}
-
-void __preempt_write_lock(rwlock_t *lock)
-{
-	if (preempt_count() > 1) {
-		_raw_write_lock(lock);
-		return;
-	}
-
-	while (!_raw_write_trylock(lock)) {
-		if (need_resched()) {
-			preempt_enable_no_resched();
-			__cond_resched();
-			preempt_disable();
-		}
-		cpu_relax();
-	}
-}
-#endif
diff -puN kernel/ksyms.c~preempt-oddity kernel/ksyms.c
--- 25/kernel/ksyms.c~preempt-oddity	Wed Jan 15 14:28:30 2003
+++ 25-akpm/kernel/ksyms.c	Wed Jan 15 14:28:53 2003
@@ -493,10 +493,6 @@ EXPORT_SYMBOL(do_settimeofday);
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
 EXPORT_SYMBOL(__might_sleep);
 #endif
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-EXPORT_SYMBOL(__preempt_spin_lock);
-EXPORT_SYMBOL(__preempt_write_lock);
-#endif
 #if !defined(__ia64__)
 EXPORT_SYMBOL(loops_per_jiffy);
 #endif

_

