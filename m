Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965920AbWK2Tdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965920AbWK2Tdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966048AbWK2Tdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:33:39 -0500
Received: from mga06.intel.com ([134.134.136.21]:49192 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S965920AbWK2Tdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:33:38 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,475,1157353200"; 
   d="scan'208"; a="170659769:sNHT18556419"
Date: Wed, 29 Nov 2006 10:56:27 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Suresh B Siddha <suresh.b.siddha@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86-64: Fix the nterrupt race is in idle callback (3rd try)
Message-ID: <20061129105627.A23549@unix-os.sc.intel.com>
References: <20061129091503.A23188@unix-os.sc.intel.com> <20061129093139.A23242@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061129093139.A23242@unix-os.sc.intel.com>; from venkatesh.pallipadi@intel.com on Wed, Nov 29, 2006 at 09:31:39AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Idle callbacks has some races when enter_idle() sets isidle and subsequent
interrupts that can happen on that CPU, before CPU goes to idle. Due to this,
an IDLE_END can get called before IDLE_START. To avoid these races, disable
interrupts before enter_idle and make sure that all idle routines do not
enable interrupts before entering idle.

Note that poll_idle() still has a this race as it has to enable interrupts
before going to idle. But, all other idle routines have the race fixed.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

---
 
  Here is the second try. Thanks to Suresh Siddha who pointed out a issue with
  enabling interrupts in the first patch.

Well 2nd try did try to fix. But, did not really fix the issue in original
patch. Guess, today is not my day to send out patches.
Here is the 3rd try. Again thanks to Suresh for being the eagle eye...


Index: linux-2.6.19-rc-mm/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.19-rc-mm.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.19-rc-mm/arch/x86_64/kernel/process.c
@@ -127,6 +127,7 @@ static void default_idle(void)
  */
 static void poll_idle (void)
 {
+	local_irq_enable();
 	cpu_relax();
 }
 
@@ -206,6 +207,12 @@ void cpu_idle (void)
 				idle = default_idle;
 			if (cpu_is_offline(smp_processor_id()))
 				play_dead();
+			/*
+			 * Idle routines should keep interrupts disabled
+			 * from here on, until they go to idle.
+			 * Otherwise, idle callbacks can misfire.
+			 */
+			local_irq_disable();
 			enter_idle();
 			idle();
 			/* In many cases the interrupt that ended idle
@@ -243,8 +250,16 @@ void mwait_idle_with_hints(unsigned long
 /* Default MONITOR/MWAIT with no hints, used for default C1 state */
 static void mwait_idle(void)
 {
-	local_irq_enable();
-	mwait_idle_with_hints(0,0);
+	if (!need_resched()) {
+		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		smp_mb();
+		if (!need_resched())
+			__sti_mwait(0, 0);
+		else
+			local_irq_enable();
+	} else {
+		local_irq_enable();
+	}
 }
 
 void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
Index: linux-2.6.19-rc-mm/include/asm-x86_64/processor.h
===================================================================
--- linux-2.6.19-rc-mm.orig/include/asm-x86_64/processor.h
+++ linux-2.6.19-rc-mm/include/asm-x86_64/processor.h
@@ -475,6 +475,14 @@ static inline void __mwait(unsigned long
 		: :"a" (eax), "c" (ecx));
 }
 
+static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
+{
+	/* "mwait %eax,%ecx;" */
+	asm volatile(
+		"sti; .byte 0x0f,0x01,0xc9;"
+		: :"a" (eax), "c" (ecx));
+}
+
 extern void mwait_idle_with_hints(unsigned long eax, unsigned long ecx);
 
 #define stack_current() \
