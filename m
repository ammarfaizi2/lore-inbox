Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319125AbSHTAqw>; Mon, 19 Aug 2002 20:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319126AbSHTAqw>; Mon, 19 Aug 2002 20:46:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:9858 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319125AbSHTAqv>;
	Mon, 19 Aug 2002 20:46:51 -0400
Message-ID: <3D61922C.90607@us.ibm.com>
Date: Mon, 19 Aug 2002 17:49:48 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Theurer <habanero@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
References: <Pine.LNX.4.33.0208131421190.3110-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080507060409060309000102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080507060409060309000102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> On Tue, 13 Aug 2002, Martin J. Bligh wrote:
> 
>>Was that before or after you changed HZ to 1000? I *think* that increased
>>the frequency of IO-APIC reprogramming by a factor of 10, though I might
>>be misreading the code. If it does depend on HZ, I think that's bad.
> 
> The 1000Hz thing came much later, and I never noticed any impact of that 
> on my machines.
> 
> (Note that this is all entrely subjective. I was very disappointed in the
> feel of the first HT P4 machine I had for the first few weeks, but apart
> from running lmbench - which looked ok even though it shows that P4's are
> bad at system calls - I've not actually put numbers on it. But my feeling
> was that the irq thing made a noticeable difference. Caveat emptor -
> subjective feelings are not good).
> 
>>People in our benchmarking group (Andrew, cc'ed) have told me that
>>reducing the frequency of IO-APIC reprogramming by a factor of 20 or
>>so improves performance greatly - don't know what HZ that was at, but
>>the whole thing seems a little overenthusiastic to me.
> 
> The rebalancing was certainly done with a 100Hz clock, so yes, it might 
> have become much worse lately.

Here's a patch from Andrea's tree that uses IRQ_BALANCE_INTERVAL to 
define how often interrupts are balanced, staying independent from HZ. 
  It also makes sure that there _is_ a change to the configuration 
before it actually writes it.  It reminds me of the mod_timer 
optimization.

While observing the affect that this has on /proc/interrupts, I 
noticed that timer interrupts aren't very balanced across my 8 CPUs.

stock 2.5.30 kernel:
       CPU0  CPU1  CPU2  CPU3  CPU4  CPU5    CPU6    CPU7
   0:213935 63894 32373  1322  1900  1779    2895  181441  timer

2.5.31 w/attached patch
       CPU0  CPU1  CPU2  CPU3 CPU4   CPU5    CPU6    CPU7
   0: 19322  8778 35805 36771 9219  14091 1091741 1092294   timer

So, my patch didn't cause this situation.  I don't know if it is 
normal, but the other irq's were much more balanced than the timer one.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------080507060409060309000102
Content-Type: text/plain;
 name="irq-balance-tune-2.5.31+bk-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq-balance-tune-2.5.31+bk-0.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.489   -> 1.490  
#	arch/i386/kernel/io_apic.c	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/19	haveblue@elm3b96.(none)	1.490
# Reduce irqbalance's dependence on HZ.  Only write to io_apic when there is actually
# a change to write into it.  
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Mon Aug 19 14:49:03 2002
+++ b/arch/i386/kernel/io_apic.c	Mon Aug 19 14:49:03 2002
@@ -220,6 +220,9 @@
 		((1 << cpu) & (allowed_mask))
 
 #if CONFIG_SMP
+
+#define IRQ_BALANCE_INTERVAL (HZ/50)
+	
 static unsigned long move(int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
 {
 	int search_idle = 1;
@@ -254,8 +257,9 @@
 	if (clustered_apic_mode)
 		return;
 
-	if (entry->timestamp != now) {
+	if (unlikely(time_after(now, entry->timestamp + IRQ_BALANCE_INTERVAL))) {
 		unsigned long allowed_mask;
+		unsigned int new_cpu;
 		int random_number;
 
 		rdtscl(random_number);
@@ -263,8 +267,11 @@
 
 		allowed_mask = cpu_online_map & irq_affinity[irq];
 		entry->timestamp = now;
-		entry->cpu = move(entry->cpu, allowed_mask, now, random_number);
-		set_ioapic_affinity(irq, 1 << entry->cpu);
+		new_cpu = move(entry->cpu, allowed_mask, now, random_number);
+		if (entry->cpu != new_cpu) {
+			entry->cpu = new_cpu;
+			set_ioapic_affinity(irq, 1 << new_cpu);
+		}
 	}
 }
 #else /* !SMP */

--------------080507060409060309000102--

