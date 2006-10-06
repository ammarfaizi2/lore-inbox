Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWJFRtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWJFRtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWJFRtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:49:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34960 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751400AbWJFRtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:49:22 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<20061006155021.GE14186@rhun.haifa.ibm.com>
Date: Fri, 06 Oct 2006 11:47:12 -0600
In-Reply-To: <20061006155021.GE14186@rhun.haifa.ibm.com> (Muli Ben-Yehuda's
	message of "Fri, 6 Oct 2006 17:50:21 +0200")
Message-ID: <m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <muli@il.ibm.com> writes:

> On Fri, Oct 06, 2006 at 09:14:53AM -0600, Eric W. Biederman wrote:
>
>> Muli Ben-Yehuda <muli@il.ibm.com> writes:
>
> In some cases we haven't made it to userspace at all. In other, we're
> in the initrd.

Ok.  So no irqbalanced? 
Any non-standard firmware on this box like a hypervisor or weird APM
code that could be causing problems.

I'm just trying to think of things that might trip over a change in
irq handling, besides a chipset.

I want to suspect the irq migration code but it doesn't look like
irqbalanced has started at all so irq migration doesn't appear to be
happening.


>> Seeing the failure case is really weird because this early in boot
>> everything should be routed to cpu 0.
>> 
>> What happens if you boot with max_cpus=1?
>
> Trying it now... woohoo, it boots all the way and stays up!

Cool.  So this is clearly about irqs being delivered to multiple
cpus, and getting getting the delivery messed up for some reason.

>> If simple tests don't reveal what is going on then we will
>> have to instrument up that BUG and print out the per
>> cpu vector to irq tables, the cpu number, and the vector
>> the unexpected irq came in on.
>
> I'm certainly game for any debugging you have in mind - this is my
> main Calgary development machine so getting it booting is a pretty
> high priority :-)

Sure.  Anything that breaks irqs for 2.6.19 is clearly a big problem.

Can you try the debug patch below and tell me what it reports.
As long as the problem irq is not for something important this
should allow you to boot, and just collect the information.

What I am hoping is that we will see which irq or irqs are having
problems. Then we can check out how the irq controller for those
irq are programmed.

Eric


diff --git a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
index 506f27c..0bd4281 100644
--- a/arch/x86_64/kernel/irq.c
+++ b/arch/x86_64/kernel/irq.c
@@ -113,9 +113,20 @@ asmlinkage unsigned int do_IRQ(struct pt
        irq = __get_cpu_var(vector_irq)[vector];
 
        if (unlikely(irq >= NR_IRQS)) {
-               printk(KERN_EMERG "%s: cannot handle IRQ %d\n",
-                                       __FUNCTION__, irq);
-               BUG();
+               if (printk_ratelimit()) {
+                       int cpu, vec;
+                       printk(KERN_EMERG "%s: cannot handle IRQ %d vector: %d cpu: %d\n",
+                               __FUNCTION__, irq, vector, smp_processor_id());
+                       for_each_online_cpu(cpu) {
+                               for (vec = 0; vec < NR_VECTORS; vec++) {
+                                       irq = per_cpu(vector_irq, cpu);
+                                       printk(KERN_DEBUG "vector_irq[%d][%d] -> %d\n",
+                                               cpu, vec, irq);
+                               }
+                       }
+               }
+               irq_exit();
+               return 1;
        }
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW

