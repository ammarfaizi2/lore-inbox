Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSDVTC5>; Mon, 22 Apr 2002 15:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314452AbSDVTC4>; Mon, 22 Apr 2002 15:02:56 -0400
Received: from zero.tech9.net ([209.61.188.187]:63753 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314448AbSDVTC4>;
	Mon, 22 Apr 2002 15:02:56 -0400
Subject: Re: in_interrupt race
From: Robert Love <rml@tech9.net>
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15553.17071.88897.914713@argo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 22 Apr 2002 15:02:53 -0400
Message-Id: <1019502174.939.50.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-20 at 06:27, Paul Mackerras wrote:

> Thus if we have CONFIG_SMP and CONFIG_PREEMPT, there is a small but
> non-zero probability that in_interrupt() will give the wrong answer if
> it is called with preemption enabled.  If the process gets scheduled
> from cpu A to cpu B between calling smp_processor_id() and evaluating
> local_irq_count(cpu) or local_bh_count(), and cpu A then happens to be
> in interrupt context at the point where the process resumes on cpu B,
> then in_interrupt() will incorrectly return 1.

Looks like you are probably right ...

> One idea I had is to use a couple of bits in
> current_thread_info()->flags to indicate whether local_irq_count and
> local_bh_count are non-zero for the current cpu.  These bits could be
> tested safely without having to disable preemption.

For now we can just do this,

--- linux-2.5.8/include/asm-i386/hardirq.h	Sun Apr 14 15:18:55 2002
+++ linux/include/asm-i386/hardirq.h	Mon Apr 22 14:56:29 2002
@@ -21,8 +21,10 @@
  * Are we in an interrupt context? Either doing bottom half
  * or hardware interrupt processing?
  */
-#define in_interrupt() ({ int __cpu = smp_processor_id(); \
-	(local_irq_count(__cpu) + local_bh_count(__cpu) != 0); })
+#define in_interrupt() ({ int __cpu; preempt_disable(); \
+	__cpu = smp_processor_id(); \
+	(local_irq_count(__cpu) + local_bh_count(__cpu) != 0); \
+	preempt_enable(); })
 
 #define in_irq() (local_irq_count(smp_processor_id()) != 0)
 

Or perhaps leave the code as-is but make the rule preemption needs to be
disabled before calling (either implicitly or explicitly).  I.e., via a
call to preempt_disable or because interrupts are disabled, a lock is
held, etc ...

> In fact almost all uses of local_irq_count() and local_bh_count() are
> for the current cpu; the exceptions are the irqs_running() function
> and some debug printks.  Maybe the irq and bh counters themselves
> could be put into the thread_info struct, if irqs_running could be
> implemented another way.

One thing Linus, DaveM, and I discussed a while back was actually
getting rid of the irq and bh counts completely and folding them into
preempt_count.  I am interested in this...

	Robert Love

