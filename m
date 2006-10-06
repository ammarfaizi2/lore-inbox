Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWJFXp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWJFXp1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWJFXp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:45:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13732 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932191AbWJFXp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:45:26 -0400
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
	<m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
	<20061006202324.GJ14186@rhun.haifa.ibm.com>
Date: Fri, 06 Oct 2006 17:42:40 -0600
In-Reply-To: <20061006202324.GJ14186@rhun.haifa.ibm.com> (Muli Ben-Yehuda's
	message of "Fri, 6 Oct 2006 22:23:24 +0200")
Message-ID: <m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <muli@il.ibm.com> writes:

> On Fri, Oct 06, 2006 at 11:47:12AM -0600, Eric W. Biederman wrote:
>> Muli Ben-Yehuda <muli@il.ibm.com> writes:
>> 
>> > On Fri, Oct 06, 2006 at 09:14:53AM -0600, Eric W. Biederman wrote:
>> >
>> >> Muli Ben-Yehuda <muli@il.ibm.com> writes:
>> >
>> > In some cases we haven't made it to userspace at all. In other, we're
>> > in the initrd.
>> 
>> Ok.  So no irqbalanced? 
>
> Nope.
>
>> Any non-standard firmware on this box like a hypervisor or weird APM
>> code that could be causing problems.
>
> BIOS is bog standard and has been working fine for at least a
> year. The only firmware I updated recently was the aic94xx firmware
> when aic94xx was merged into mainline.
>
>> I'm just trying to think of things that might trip over a change in
>> irq handling, besides a chipset.
>
> Looking at the code below, aic94xx is certainly suspect.
>
>> Can you try the debug patch below and tell me what it reports.
>> As long as the problem irq is not for something important this
>> should allow you to boot, and just collect the information.
>
> Unfortunately aic94xx is pretty important, but we do get a lot
> further.

Yes.

>> What I am hoping is that we will see which irq or irqs are having
>> problems. Then we can check out how the irq controller for those
>> irq are programmed.
>
> I had to slightly redo your patch to cut down on the verbosity (and
> get the pet CPU vector arrays correctly). This is over Serial-Over-Lan
> which is painful beyond words and also tends to lose the most
> interesting bits of the log. Sorry. Hopefully there's enough in here
> to make progress.

Ok.  A couple of interesting tidbits here.
The first is that it is simply not enough to return, to get avoid this.
This may be simply because we are not acknowledging the irq.

If I read your bootlog right. You have logical cpus, but only two
sockets, and I think only two cores.  The other two logical cpus
being hyperthreaded.

The irq routing is behaving as I would expect, only cpu 0 is being
setup.

So I guess what I need, and didn't provide the code to inspect
is how the ioapic are being programmed.

It looks like either we are programming them wrong, or that
we can't actually control which part of a cpu in a socket
gets an irq.

Here is a quick debug patch that while being over kill
will show how we are programming the ioapic for these problem
interrupts.

Once I know how we have programmed the ioapics.  I will know if
this is a weird irq delivery condition or a bug in our ioapic programming.

I guess I need to start digging through the cpu documentation and errata
and see if I can find any hint of what I am seeing here.

Thanks for your help,
Eric





diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 91728d9..738cc97 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -778,7 +778,7 @@ void __init UNEXPECTED_IO_APIC(void)
 {
 }
 
-void __apicdebuginit print_IO_APIC(void)
+void print_IO_APIC(void)
 {
 	int apic, i;
 	union IO_APIC_reg_00 reg_00;
diff --git a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
index b8a407f..9dd0793 100644
--- a/arch/x86_64/kernel/irq.c
+++ b/arch/x86_64/kernel/irq.c
@@ -18,6 +18,7 @@ #include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/io_apic.h>
 #include <asm/idle.h>
+#include <asm/hw_irq.h>
 
 atomic_t irq_err_count;
 
@@ -115,9 +116,18 @@ asmlinkage unsigned int do_IRQ(struct pt
 	irq = __get_cpu_var(vector_irq)[vector];
 
 	if (unlikely(irq >= NR_IRQS)) {
-		printk(KERN_EMERG "%s: cannot handle IRQ %d\n",
-					__FUNCTION__, irq);
-		BUG();
+		if (printk_ratelimit()) {
+			int cpu, vec;
+			printk(KERN_EMERG "%s: cannot handle IRQ %d vector: %d cpu: %d\n",
+				__FUNCTION__, irq, vector, smp_processor_id());
+			irq = per_cpu(vectro_irq, 0);
+			printk("v[0][%d] -> %d\n", vector, irq);
+			print_IO_APIC();
+		}
+		irq_exit();
+
+		set_irq_regs(old_regs);
+		return 1;
 	}
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
