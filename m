Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSGXUMf>; Wed, 24 Jul 2002 16:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317539AbSGXUMf>; Wed, 24 Jul 2002 16:12:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39675 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317520AbSGXULM>;
	Wed, 24 Jul 2002 16:11:12 -0400
Message-ID: <3D3F0693.E8C97A3F@mvista.com>
Date: Wed, 24 Jul 2002 12:57:07 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] irqlock patch 2.5.27-H4
References: <Pine.LNX.4.44.0207241407290.18205-100000@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------F95A86FF5F9C899FE94C1B08"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------F95A86FF5F9C899FE94C1B08
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> 
> On Wed, 24 Jul 2002, Christoph Hellwig wrote:
> 
> > >  - move the irqs-off check into preempt_schedule() and remove
> > >    CONFIG_DEBUG_IRQ_SCHEDULE.
> >
> > the config.in entry is still present..
> 
> indeed. Fix is in -H5:

We need to verify correct usage of the
irq_enable/irq_restore() least we miss a preemption.  The
attached patch allows one to enable a test on the these
macros to verify that they are being correctly used.

Ingo, I am not sure about the change in fork.c.  Don't we
always want to check for preemption at the end of this
irq_disable?

Patch is against Ingo's H6.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------F95A86FF5F9C899FE94C1B08
Content-Type: text/plain; charset=us-ascii;
 name="irq-test-2.5.27-ingo-H6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq-test-2.5.27-ingo-H6.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.27-ingo-H6-org/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.5.27-ingo-H6-org/arch/i386/config.in	Mon Jul 22 14:19:20 2002
+++ linux/arch/i386/config.in	Wed Jul 24 12:13:56 2002
@@ -412,6 +412,7 @@
 
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
+   bool '  Debug IRQ preempt interaction' CONFIG_DEBUG_IRQ
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.27-ingo-H6-org/include/asm-i386/system.h linux/include/asm-i386/system.h
--- linux-2.5.27-ingo-H6-org/include/asm-i386/system.h	Wed Jul 24 12:50:03 2002
+++ linux/include/asm-i386/system.h	Wed Jul 24 12:36:08 2002
@@ -312,9 +312,26 @@
 
 /* interrupt control.. */
 #define local_save_flags(x)	__asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */)
-#define local_irq_restore(x) 	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc")
+#define _local_irq_restore(x) 	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc")
 #define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
-#define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
+#define _local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
+#ifdef CONFIG_DEBUG_IRQ
+#define test_preempt() if (unlikely(! current_thread_info()->preempt_count)){ \
+		printk("bad: irq_restore() with preemption_enabled!\n");\
+		show_stack(NULL); } 
+#else
+#define test_preempt()
+#endif
+#define local_irq_enable() \
+                do { _local_irq_enable(); test_preempt(); } while(0)
+#define local_irq_restore(x) \
+                do { _local_irq_restore(x); test_preempt(); } while(0)
+#define local_irq_enable_preempt()  \
+                do { _local_irq_enable(); preempt_check_resched() ; } while(0)
+#define local_irq_restore_preempt(x) \
+                do { _local_irq_restore(x);  preempt_check_resched(); } while(0)
+
+
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.27-ingo-H6-org/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.27-ingo-H6-org/include/linux/spinlock.h	Wed Jul 24 12:50:03 2002
+++ linux/include/linux/spinlock.h	Wed Jul 24 12:39:39 2002
@@ -26,17 +26,17 @@
 #define write_lock_irq(lock)			do { local_irq_disable();        write_lock(lock); } while (0)
 #define write_lock_bh(lock)			do { local_bh_disable();         write_lock(lock); } while (0)
 
-#define spin_unlock_irqrestore(lock, flags)	do { _raw_spin_unlock(lock);  local_irq_restore(flags); preempt_enable(); } while (0)
+#define spin_unlock_irqrestore(lock, flags)	do { _raw_spin_unlock(lock);  local_irq_restore_preempt(flags); } while (0)
 #define _raw_spin_unlock_irqrestore(lock, flags) do { _raw_spin_unlock(lock);  local_irq_restore(flags); } while (0)
-#define spin_unlock_irq(lock)			do { _raw_spin_unlock(lock);  local_irq_enable(); preempt_enable();       } while (0)
+#define spin_unlock_irq(lock)			do { _raw_spin_unlock(lock);  local_irq_enable_preempt();       } while (0)
 #define spin_unlock_bh(lock)			do { spin_unlock(lock); local_bh_enable(); } while (0)
 
-#define read_unlock_irqrestore(lock, flags)	do { _raw_read_unlock(lock);  local_irq_restore(flags); preempt_enable(); } while (0)
-#define read_unlock_irq(lock)			do { _raw_read_unlock(lock);  local_irq_enable(); preempt_enable(); } while (0)
+#define read_unlock_irqrestore(lock, flags)	do { _raw_read_unlock(lock);  local_irq_restore_preempt(flags); } while (0)
+#define read_unlock_irq(lock)			do { _raw_read_unlock(lock);  local_irq_enable_preempt(); } while (0)
 #define read_unlock_bh(lock)			do { read_unlock(lock);  local_bh_enable();        } while (0)
 
-#define write_unlock_irqrestore(lock, flags)	do { _raw_write_unlock(lock); local_irq_restore(flags); preempt_enable(); } while (0)
-#define write_unlock_irq(lock)			do { _raw_write_unlock(lock); local_irq_enable(); preempt_enable();       } while (0)
+#define write_unlock_irqrestore(lock, flags)	do { _raw_write_unlock(lock); local_irq_restore_preempt(flags); } while (0)
+#define write_unlock_irq(lock)			do { _raw_write_unlock(lock); local_irq_enable_preempt();       } while (0)
 #define write_unlock_bh(lock)			do { write_unlock(lock); local_bh_enable();        } while (0)
 #define spin_trylock_bh(lock)			({ int __r; local_bh_disable();\
 						__r = spin_trylock(lock);      \
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.27-ingo-H6-org/kernel/fork.c linux/kernel/fork.c
--- linux-2.5.27-ingo-H6-org/kernel/fork.c	Wed Jul 24 12:50:03 2002
+++ linux/kernel/fork.c	Wed Jul 24 12:46:52 2002
@@ -753,10 +753,8 @@
 		current->time_slice = 1;
 		preempt_disable();
 		scheduler_tick(0, 0);
-		local_irq_restore(flags);
-		preempt_enable();
-	} else
-		local_irq_restore(flags);
+	}
+        local_irq_restore_preempt(flags);
 
 	/*
 	 * Ok, add it to the run-queues and make it
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.27-ingo-H6-org/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.27-ingo-H6-org/kernel/sched.c	Wed Jul 24 12:50:03 2002
+++ linux/kernel/sched.c	Wed Jul 24 12:12:02 2002
@@ -907,6 +907,7 @@
 		printk("bad: schedule() with irqs disabled!\n");
 		show_stack(NULL);
 		preempt_enable_no_resched();
+                return;
 	}
 
 need_resched:
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.27-ingo-H6-org/mm/slab.c linux/mm/slab.c
--- linux-2.5.27-ingo-H6-org/mm/slab.c	Wed Jul 24 12:50:03 2002
+++ linux/mm/slab.c	Wed Jul 24 12:38:27 2002
@@ -1386,9 +1386,8 @@
 			} else {
 				STATS_INC_ALLOCMISS(cachep);
 				objp = kmem_cache_alloc_batch(cachep,flags);
-				local_irq_restore(save_flags);
 				/* end of non-preemptible region */
-				preempt_enable();
+				local_irq_restore_preempt(save_flags);
 				if (!objp)
 					goto alloc_new_slab_nolock;
 				return objp;

--------------F95A86FF5F9C899FE94C1B08--

