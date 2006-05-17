Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWEQXGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWEQXGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 19:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWEQXGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 19:06:31 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:39695 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750780AbWEQXGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 19:06:31 -0400
Date: Wed, 17 May 2006 16:06:29 -0700
From: Tim Mann <mann@vmware.com>
To: linux-kernel@vger.kernel.org
Cc: Tim Mann <mann@vmware.com>, john stultz <johnstul@us.ibm.com>
Subject: Fix time going backward with clock=pit [2/2]
Message-ID: <20060517160629.5f9dbab9@mann-lx.eng.vmware.com>
In-Reply-To: <20060517160428.62022efd@mann-lx.eng.vmware.com>
References: <20060517160428.62022efd@mann-lx.eng.vmware.com>
Organization: VMware, Inc.
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 2 of a 2-patch series.  The diff is against the
2.6.17-rc3-git17 snapshot.  It nukes some code that is dead after the
first patch.

* * *

do_timer_overflow is no longer used now; nuke it.

(By the way, the comment "It means that a timer tick interrupt came
along while the previous one was pending, thus a tick was missed" in
do_timer_overflow was wrong.  The code was meant to handle the easier
and more common case where the PIT counter wrapped just before we read
it and the tick interrupt that that caused was still pending.)

Note: There is some other code in the kernel that was meant to support
what do_timer_overflow was doing here.  See the "Subtle..." comments
in do_timer_interrupt and check_timer.  Unfortunately I don't know how
much of that code (if any) can be cleaned out now, as I don't
understand the stuff about "NMI lines for the watchdog if run on an
82489DX-based system" or all the details of check_timer.

 include/asm-i386/mach-default/do_timer.h |   52 -------------------------------
 include/asm-i386/mach-visws/do_timer.h   |   26 ---------------
 include/asm-i386/mach-voyager/do_timer.h |   13 -------
 3 files changed, 91 deletions(-)

Index: linux-2.6.17-rc3-git17/include/asm-i386/mach-default/do_timer.h
===================================================================
--- linux-2.6.17-rc3-git17.orig/include/asm-i386/mach-default/do_timer.h
+++ linux-2.6.17-rc3-git17/include/asm-i386/mach-default/do_timer.h
@@ -32,55 +32,3 @@ static inline void do_timer_interrupt_ho
 		smp_local_timer_interrupt(regs);
 #endif
 }
-
-
-/* you can safely undefine this if you don't have the Neptune chipset */
-
-#define BUGGY_NEPTUN_TIMER
-
-/**
- * do_timer_overflow - process a detected timer overflow condition
- * @count:	hardware timer interrupt count on overflow
- *
- * Description:
- *	This call is invoked when the jiffies count has not incremented but
- *	the hardware timer interrupt has.  It means that a timer tick interrupt
- *	came along while the previous one was pending, thus a tick was missed
- **/
-static inline int do_timer_overflow(int count)
-{
-	int i;
-
-	spin_lock(&i8259A_lock);
-	/*
-	 * This is tricky when I/O APICs are used;
-	 * see do_timer_interrupt().
-	 */
-	i = inb(0x20);
-	spin_unlock(&i8259A_lock);
-	
-	/* assumption about timer being IRQ0 */
-	if (i & 0x01) {
-		/*
-		 * We cannot detect lost timer interrupts ... 
-		 * well, that's why we call them lost, don't we? :)
-		 * [hmm, on the Pentium and Alpha we can ... sort of]
-		 */
-		count -= LATCH;
-	} else {
-#ifdef BUGGY_NEPTUN_TIMER
-		/*
-		 * for the Neptun bug we know that the 'latch'
-		 * command doesn't latch the high and low value
-		 * of the counter atomically. Thus we have to 
-		 * substract 256 from the counter 
-		 * ... funny, isnt it? :)
-		 */
-		
-		count -= 256;
-#else
-		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
-#endif
-	}
-	return count;
-}
Index: linux-2.6.17-rc3-git17/include/asm-i386/mach-visws/do_timer.h
===================================================================
--- linux-2.6.17-rc3-git17.orig/include/asm-i386/mach-visws/do_timer.h
+++ linux-2.6.17-rc3-git17/include/asm-i386/mach-visws/do_timer.h
@@ -25,29 +25,3 @@ static inline void do_timer_interrupt_ho
 		smp_local_timer_interrupt(regs);
 #endif
 }
-
-static inline int do_timer_overflow(int count)
-{
-	int i;
-
-	spin_lock(&i8259A_lock);
-	/*
-	 * This is tricky when I/O APICs are used;
-	 * see do_timer_interrupt().
-	 */
-	i = inb(0x20);
-	spin_unlock(&i8259A_lock);
-	
-	/* assumption about timer being IRQ0 */
-	if (i & 0x01) {
-		/*
-		 * We cannot detect lost timer interrupts ... 
-		 * well, that's why we call them lost, don't we? :)
-		 * [hmm, on the Pentium and Alpha we can ... sort of]
-		 */
-		count -= LATCH;
-	} else {
-		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
-	}
-	return count;
-}
Index: linux-2.6.17-rc3-git17/include/asm-i386/mach-voyager/do_timer.h
===================================================================
--- linux-2.6.17-rc3-git17.orig/include/asm-i386/mach-voyager/do_timer.h
+++ linux-2.6.17-rc3-git17/include/asm-i386/mach-voyager/do_timer.h
@@ -10,16 +10,3 @@ static inline void do_timer_interrupt_ho
 
 	voyager_timer_interrupt(regs);
 }
-
-static inline int do_timer_overflow(int count)
-{
-	/* can't read the ISR, just assume 1 tick
-	   overflow */
-	if(count > LATCH || count < 0) {
-		printk(KERN_ERR "VOYAGER PROBLEM: count is %d, latch is %d\n", count, LATCH);
-		count = LATCH;
-	}
-	count -= LATCH;
-
-	return count;
-}
Index: linux-2.6.17-rc3-git17/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.17-rc3-git17.orig/arch/i386/kernel/time.c
+++ linux-2.6.17-rc3-git17/arch/i386/kernel/time.c
@@ -254,6 +254,12 @@ static inline void do_timer_interrupt(in
 		 * manually to reset the IRR bit for do_slow_gettimeoffset().
 		 * This will also deassert NMI lines for the watchdog if run
 		 * on an 82489DX-based system.
+		 *
+		 * XXX The code that formerly looked at the IRR bit in
+		 * do_slow_gettimeoffset no longer exists.  Can we
+		 * remove the "timer_ack" code here and the
+		 * corresponding setup in check_timer, or do NMI
+		 * watchdogs still need this?
 		 */
 		spin_lock(&i8259A_lock);
 		outb(0x0c, PIC_MASTER_OCW3);


-- 
Tim Mann  work: mann@vmware.com  home: tim@tim-mann.org
          http://www.vmware.com  http://tim-mann.org
