Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVEXN35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVEXN35 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVEXN1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:27:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15756 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261372AbVEXNZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:25:09 -0400
Date: Tue, 24 May 2005 15:21:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: [patch] Voluntary Kernel Preemption, 2.6.12-rc4-mm2
Message-ID: <20050524132105.GA29477@elte.hu>
References: <20050524121541.GA17049@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524121541.GA17049@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch (ontop of the current -mm scheduler patchset plus the 
previous 2 patches from me) adds a new preemption model: 'Voluntary 
Kernel Preemption'. The 3 models can be selected from a new menu:

            (X) No Forced Preemption (Server)
            ( ) Voluntary Kernel Preemption (Desktop)
            ( ) Preemptible Kernel (Low-Latency Desktop)

we still default to the stock (Server) preemption model.

Voluntary preemption works by adding a cond_resched() 
(reschedule-if-needed) call to every might_sleep() check. It is lighter 
than CONFIG_PREEMPT - at the cost of not having as tight latencies. It 
represents a different latency/complexity/overhead tradeoff.

it has no runtime impact at all if disabled. Here are size stats that 
show how the various preemption models impact the kernel's size:

    text    data     bss     dec     hex filename
 3618774  547184  179896 4345854  424ffe vmlinux.stock
 3626406  547184  179896 4353486  426dce vmlinux.voluntary   +0.2%
 3748414  548640  179896 4476950  445016 vmlinux.preempt     +3.5%

voluntary-preempt is +0.2% of .text, preempt is +3.5%.

this feature has been tested for many months by lots of people (and it's 
also included in the RHEL4 distribution and earlier variants were in 
Fedora as well), and it's intended for users and distributions who dont 
want to use full-blown CONFIG_PREEMPT for one reason or another.

the patched kernel builds/boots on my testsystems (x86 and x64) but it 
obviously needs more testing. It's simple and straightforward enough to 
be considered for upstream inclusion as well, after it gets exposure in 
-mm.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/kernel.h |   18 +++++++++++----
 kernel/Kconfig.preempt |   57 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 62 insertions(+), 13 deletions(-)

--- linux/kernel/Kconfig.preempt.orig
+++ linux/kernel/Kconfig.preempt
@@ -1,15 +1,56 @@
 
-config PREEMPT
-	bool "Preemptible Kernel"
+choice
+	prompt "Preemption Model"
+	default PREEMPT_NONE
+
+config PREEMPT_NONE
+	bool "No Forced Preemption (Server)"
+	help
+	  This is the traditional Linux preemption model, geared towards
+	  throughput. It will still provide good latencies most of the
+	  time, but there are no guarantees and occasional longer delays
+	  are possible.
+
+	  Select this option if you are building a kernel for a server or
+	  scientific/computation system, or if you want to maximize the
+	  raw processing power of the kernel, irrespective of scheduling
+	  latencies.
+
+config PREEMPT_VOLUNTARY
+	bool "Voluntary Kernel Preemption (Desktop)"
 	help
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
-	  This allows applications to run more reliably even when the system is
+	  This option reduces the latency of the kernel by adding more
+	  "explicit preemption points" to the kernel code. These new
+	  preemption points have been selected to reduce the maximum
+	  latency of rescheduling, providing faster application reactions,
+	  at the cost of slighly lower throughput.
+
+	  This allows reaction to interactive events by allowing a
+	  low priority process to voluntarily preempt itself even if it
+	  is in kernel mode executing a system call. This allows
+	  applications to run more 'smoothly' even when the system is
 	  under load.
 
-	  Say Y here if you are building a kernel for a desktop, embedded
-	  or real-time system.  Say N if you are unsure.
+	  Select this if you are building a kernel for a desktop system.
+
+config PREEMPT
+	bool "Preemptible Kernel (Low-Latency Desktop)"
+	help
+	  This option reduces the latency of the kernel by making
+	  all kernel code (that is not executing in a critical section)
+	  preemptible.  This allows reaction to interactive events by
+	  permitting a low priority process to be preempted involuntarily
+	  even if it is in kernel mode executing a system call and would
+	  otherwise not be about to reach a natural preemption point.
+	  This allows applications to run more 'smoothly' even when the
+	  system is under load, at the cost of slighly lower throughput
+	  and a slight runtime overhead to kernel code.
+
+	  Select this if you are building a kernel for a desktop or
+	  embedded system with latency requirements in the milliseconds
+	  range.
+
+endchoice
 
 config PREEMPT_BKL
 	bool "Preempt The Big Kernel Lock"
--- linux/include/linux/kernel.h.orig
+++ linux/include/linux/kernel.h
@@ -58,15 +58,23 @@ struct completion;
  * be biten later when the calling function happens to sleep when it is not
  * supposed to.
  */
+#ifdef CONFIG_PREEMPT_VOLUNTARY
+extern int cond_resched(void);
+# define might_resched() cond_resched()
+#else
+# define might_resched() do { } while (0)
+#endif
+
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
-#define might_sleep() __might_sleep(__FILE__, __LINE__)
-#define might_sleep_if(cond) do { if (unlikely(cond)) might_sleep(); } while (0)
-void __might_sleep(char *file, int line);
+  void __might_sleep(char *file, int line);
+# define might_sleep() \
+	do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
 #else
-#define might_sleep() do {} while(0)
-#define might_sleep_if(cond) do {} while (0)
+# define might_sleep() do { might_resched(); } while (0)
 #endif
 
+#define might_sleep_if(cond) do { if (unlikely(cond)) might_sleep(); } while (0)
+
 #define abs(x) ({				\
 		int __x = (x);			\
 		(__x < 0) ? -__x : __x;		\
