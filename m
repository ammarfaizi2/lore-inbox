Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVF3SI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVF3SI7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 14:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVF3SI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 14:08:59 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:8062 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262825AbVF3SGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 14:06:05 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Date: Thu, 30 Jun 2005 19:52:21 +0200
User-Agent: KMail/1.8.1
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050629193804.GA6256@elte.hu> <200506300136.01061.annabellesgarden@yahoo.de>
In-Reply-To: <200506300136.01061.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WFDxCZB2cotlskA"
Message-Id: <200506301952.22022.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_WFDxCZB2cotlskA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Donnerstag, 30. Juni 2005 01:36 schrieb Karsten Wiese:
> Am Mittwoch, 29. Juni 2005 21:38 schrieb Ingo Molnar:
> > 
> > * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> > 
> > > attached patch for io_apic.c lets
> > > 1. gcc 3.4.3 optimize io_apic access a little better.
> > > 2. CONFIG_X86_UP_IOAPIC_FAST work here.
> > >    Didn't check, if it really speeds up things.
> > 
> > which change made CONFIG_X86_UP_IOAPIC_FAST work on your box? It seems 
> > you've changed the per-register frontside read-cache to something else - 
> > was that on purpose?
> > 
> CONFIG_X86_UP_IOAPIC_FAST started working here, when I made io_apic_modify()
> look like that:
> 
> void io_apic_modify(unsigned int apic, unsigned int reg, unsigned int val)
> {
> #ifdef IOAPIC_CACHE
> 	io_apic_cache[apic][reg] = val;
> #endif
> //	if (unlikely(sis_apic_bug))
> commented this ^^ out 
> 
> 		*IO_APIC_BASE(apic) = reg;
> 	*(IO_APIC_BASE(apic)+4) = val;
> #ifndef IOAPIC_POSTFLUSH
> 	if (unlikely(sis_apic_bug))
> #endif
> 		/*
> 		 * Force POST flush by reading:
>  		 */
> 		val = *(IO_APIC_BASE(apic)+4);
> }
> 
> This change does it, 'cause when we read a cached value instead of from the ioapic,
> the ioapic's address register isn't set and thus the following write in io_apic_modify
> might not scratch the right ioapic register.
> 
> On top of the above the patch adds
> 	unsigned int reg;
> to io_apic_cache.
> with that "reg" struct member a mark -1 can be set, when we read from cache,
> or the reg-number, when we read from the ioapic.
> Then by comparing parameter reg with io_apic_cache[apic].reg
> the patched io_apic_modify() knows, if it has to set the address register or not.
> The register caching in the patch should be the same as before,
> only the cache changed from a 2 dimensional array
> to an array holding structs, which contain an array:
> io_apic_cache[apic][reg] should be equivalent to io_apic_cache[apic].val[reg], no?
> 
Here come some numbers to back up the usefullness of CONFIG_X86_UP_IOAPIC_FAST.
(and to show that my patch actually works ;-))
All measurement where taken on an UP Athlon64 2Ghz running 32bit 2.6.12-RT-50-35 PREEMPT_RT
on a K8T800 mobo.

I measured the tsc-cycles spent in __do_IRQ() plus those used for interruptcontroller clean-up
after the irq-thread finished the handler.

Did that with 3 Setups:
 XT-PIC
 IO-APIC uncached
 IO-APIC cached
 IO-APIC cached + cpu-cache thrashing application hogging the cpu 

Characteristic values found:
 XT-PIC
  irq#       | cycles/irq
  -----------|------------
   0 timer   | 18733
   5 VIA8237 | 19089
  11 eth0    | 22676
  14 ide0    | 23057

 IO-APIC uncached
  irq#       | cycles/irq
  -----------|------------
   0 timer   |  4711
  22 VIA8237 | 32107
  16 eth0    | 32680
  14 ide0    | 13404

 IO-APIC cached
  irq#       | cycles/irq
  -----------|------------
   0 timer   |  5004
  22 VIA8237 |  1484
  16 eth0    |  1598
  14 ide0    |   905

 IO-APIC cached + cpu-cache thrashing application hogging the cpu 
  irq#       | cycles/irq
  -----------|------------
   0 timer   |  6344
  22 VIA8237 |  2512
  16 eth0    |  2774
  14 ide0    |  1723

Clear winner is IO-APIC cached.

The patch used + full /proc/interrupt logs are attached.
The patch differs from the previously sent one by precalculation 
of the ioapic's virtual address and the cycle-measurement code.

Cheers,
Karsten









--Boundary-00=_WFDxCZB2cotlskA
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ints_io_apic_cached_fullmemload"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ints_io_apic_cached_fullmemload"

           CPU0       
  0:    7390558    IO-APIC-edge      0/  558  6344 3540429, timer
  1:      14651    IO-APIC-edge      0/ 4651  1583 7364358, i8042
  8:         12    IO-APIC-edge      0/   12  1462 17550, rtc
  9:          0   IO-APIC-level      0/    0     0 0, acpi
 12:     120985    IO-APIC-edge      0/  985  1251 1232698, i8042
 14:     117323    IO-APIC-edge      0/ 7321  1723 12621315, ide0
 15:     328390    IO-APIC-edge      0/ 8388   619 5194067, ide1
 16:     458342   IO-APIC-level      0/ 8342  2774 23146219, eth0, nvidia
 21:          0   IO-APIC-level      0/    0     0 0, ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, uhci_hcd:usb5
 22:       7826   IO-APIC-level      0/ 7826  2512 19665441, VIA8237
NMI:          0 
LOC:    7390775 
ERR:          0
MIS:          0

--Boundary-00=_WFDxCZB2cotlskA
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ints_xt-pic_noload"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ints_xt-pic_noload"

           CPU0       
  0:     622269          XT-PIC      0/ 2269 18733 42507219, timer
  1:        886          XT-PIC      0/  886 19145 16962916, i8042
  2:          0          XT-PIC      0/    0     0 0, cascade
  3:          0          XT-PIC      0/    0     0 0, uhci_hcd:usb4, uhci_hcd:usb5
  5:       6381          XT-PIC      0/ 6381 19089 121807578, VIA8237, ehci_hcd:usb1
  8:          1          XT-PIC      0/    1 23697 23697, rtc
  9:          0          XT-PIC      0/    0     0 0, acpi
 11:       1086          XT-PIC      0/ 1086 22676 24626747, uhci_hcd:usb2, uhci_hcd:usb3, eth0
 12:         93          XT-PIC      0/   93 22848 2124875, i8042
 14:       3393          XT-PIC      0/ 3392 23057 78211017, ide0
 15:       5410          XT-PIC      0/ 5409 22818 123423742, ide1
NMI:          0 
LOC:     622240 
ERR:          0
MIS:          0

--Boundary-00=_WFDxCZB2cotlskA
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ints_io_apic_cached_noload"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ints_io_apic_cached_noload"

           CPU0       
  0:    7520343    IO-APIC-edge      0/  343  5004 1716578, timer
  1:      15028    IO-APIC-edge      0/ 5028  1569 7890363, i8042
  8:         12    IO-APIC-edge      0/   12  1462 17550, rtc
  9:          0   IO-APIC-level      0/    0     0 0, acpi
 12:     122185    IO-APIC-edge      0/ 2185   998 2181980, i8042
 14:     133059    IO-APIC-edge      0/ 3057   905 2769148, ide0
 15:     334204    IO-APIC-edge      0/ 4202   515 2166602, ide1
 16:     466139   IO-APIC-level      0/ 6139  1598 9813868, eth0, nvidia
 21:          0   IO-APIC-level      0/    0     0 0, ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, uhci_hcd:usb5
 22:      10619   IO-APIC-level      0/  619  1484 919075, VIA8237
NMI:          0 
LOC:    7520565 
ERR:          0
MIS:          0

--Boundary-00=_WFDxCZB2cotlskA
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ints_io_apic_noload"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ints_io_apic_noload"

           CPU0       
  0:     260074    IO-APIC-edge      0/   74  4711 348679, timer
  1:        596    IO-APIC-edge      0/  596 11293 6731173, i8042
  8:          1    IO-APIC-edge      0/    1 22686 22686, rtc
  9:          0   IO-APIC-level      0/    0     0 0, acpi
 12:         93    IO-APIC-edge      0/   93 11070 1029547, i8042
 14:       3305    IO-APIC-edge      0/ 3303 13404 44275707, ide0
 15:       2135    IO-APIC-edge      0/ 2133 10937 23329953, ide1
 16:        298   IO-APIC-level      0/  298 32680 9738917, eth0
 21:          0   IO-APIC-level      0/    0     0 0, ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, uhci_hcd:usb5
 22:       1294   IO-APIC-level      0/ 1294 32107 41547375, VIA8237
NMI:          0 
LOC:     260001 
ERR:          0
MIS:          0

--Boundary-00=_WFDxCZB2cotlskA
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="io_apic-RT-50-35.2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="io_apic-RT-50-35.2.diff"

diff -ru linux-2.6.12-RT-50-35/arch/i386/kernel/io_apic.c linux-2.6.12-RT/arch/i386/kernel/io_apic.c
--- linux-2.6.12-RT-50-35/arch/i386/kernel/io_apic.c	2005-06-30 16:38:19.000000000 +0200
+++ linux-2.6.12-RT/arch/i386/kernel/io_apic.c	2005-06-29 20:01:10.000000000 +0200
@@ -138,14 +138,24 @@
 /*
  * Cache register values:
  */
-static unsigned int io_apic_cache[MAX_IO_APICS][MAX_IOAPIC_CACHE]
+static struct {
+	unsigned int reg;
+	unsigned int val[MAX_IOAPIC_CACHE];
+} io_apic_cache[MAX_IO_APICS]
 		____cacheline_aligned_in_smp;
 #endif
 
-inline unsigned int __raw_io_apic_read(unsigned int apic, unsigned int reg)
+volatile unsigned int *io_apic_base[MAX_IO_APICS];
+
+static inline unsigned int __raw_io_apic_read(unsigned int apic, unsigned int reg)
 {
-	*IO_APIC_BASE(apic) = reg;
-	return *(IO_APIC_BASE(apic)+4);
+	volatile unsigned int *io_apic;
+#ifdef IOAPIC_CACHE
+	io_apic_cache[apic].reg = reg;
+#endif
+	io_apic = io_apic_base[apic];
+	io_apic[0] = reg;
+	return io_apic[4];
 }
 
 unsigned int raw_io_apic_read(unsigned int apic, unsigned int reg)
@@ -153,7 +163,7 @@
 	unsigned int val = __raw_io_apic_read(apic, reg);
 
 #ifdef IOAPIC_CACHE
-	io_apic_cache[apic][reg] = val;
+	io_apic_cache[apic].val[reg] = val;
 #endif
 	return val;
 }
@@ -172,14 +182,17 @@
 		}
 		return __raw_io_apic_read(apic, reg);
 	}
-	if (io_apic_cache[apic][reg] && !sis_apic_bug)
-		return io_apic_cache[apic][reg];
+	if (io_apic_cache[apic].val[reg] && !sis_apic_bug) {
+		io_apic_cache[apic].reg = -1;
+		return io_apic_cache[apic].val[reg];
+	}
 #endif
 	return raw_io_apic_read(apic, reg);
 }
 
 void io_apic_write(unsigned int apic, unsigned int reg, unsigned int val)
 {
+	volatile unsigned int *io_apic;
 #ifdef IOAPIC_CACHE
 	if (unlikely(reg >= MAX_IOAPIC_CACHE)) {
 		static int once = 1;
@@ -191,10 +204,14 @@
 			dump_stack();
 		}
 	} else
-		io_apic_cache[apic][reg] = val;
+		io_apic_cache[apic].val[reg] = val;
 #endif
-	*IO_APIC_BASE(apic) = reg;
-	*(IO_APIC_BASE(apic)+4) = val;
+	io_apic = io_apic_base[apic];
+#ifdef IOAPIC_CACHE
+	io_apic_cache[apic].reg = reg;
+#endif
+	io_apic[0] = reg;
+	io_apic[4] = val;
 }
 
 /*
@@ -214,34 +231,42 @@
  */
 void io_apic_modify(unsigned int apic, unsigned int reg, unsigned int val)
 {
+	volatile unsigned int *io_apic;
 #ifdef IOAPIC_CACHE
-	io_apic_cache[apic][reg] = val;
+	io_apic_cache[apic].val[reg] = val;
 #endif
-	if (unlikely(sis_apic_bug))
-		*IO_APIC_BASE(apic) = reg;
-	*(IO_APIC_BASE(apic)+4) = val;
+	io_apic = io_apic_base[apic];
+#ifdef IOAPIC_CACHE
+	if (io_apic_cache[apic].reg != reg || sis_apic_bug) {
+		io_apic_cache[apic].reg = reg;
+#else
+	if (unlikely(sis_apic_bug)) {
+#endif
+		io_apic[0] = reg;
+	}
+	io_apic[4] = val;
 #ifndef IOAPIC_POSTFLUSH
 	if (unlikely(sis_apic_bug))
 #endif
 		/*
 		 * Force POST flush by reading:
  		 */
-		val = *(IO_APIC_BASE(apic)+4);
+		val = io_apic[4];
 }
 
 static void __modify_IO_APIC_irq (unsigned int irq, unsigned long enable, unsigned long disable)
 {
 	struct irq_pin_list *entry = irq_2_pin + irq;
-	unsigned int pin, reg;
+	unsigned int pin, val;
 
 	for (;;) {
 		pin = entry->pin;
 		if (pin == -1)
 			break;
-		reg = io_apic_read(entry->apic, 0x10 + pin*2);
-		reg &= ~disable;
-		reg |= enable;
-		io_apic_modify(entry->apic, 0x10 + pin*2, reg);
+		val = io_apic_read(entry->apic, 0x10 + pin*2);
+		val &= ~disable;
+		val |= enable;
+		io_apic_modify(entry->apic, 0x10 + pin*2, val);
 		if (!entry->next)
 			break;
 		entry = irq_2_pin + entry->next;
@@ -249,13 +274,13 @@
 }
 
 /* mask = 1 */
-static void __mask_IO_APIC_irq (unsigned int irq)
+static inline void __mask_IO_APIC_irq (unsigned int irq)
 {
 	__modify_IO_APIC_irq(irq, 0x00010000, 0);
 }
 
 /* mask = 0 */
-static void __unmask_IO_APIC_irq (unsigned int irq)
+static inline void __unmask_IO_APIC_irq (unsigned int irq)
 {
 	__modify_IO_APIC_irq(irq, 0, 0x00010000);
 }
@@ -306,9 +331,13 @@
 {
 	int apic, pin;
 
-	for (apic = 0; apic < nr_ioapics; apic++)
+	for (apic = 0; apic < nr_ioapics; apic++) {
+#ifdef IOAPIC_CACHE
+		io_apic_cache[apic].reg = -1;
+#endif
 		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++)
 			clear_IO_APIC_pin(apic, pin);
+	}
 }
 
 static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t cpumask)
Nur in linux-2.6.12-RT/arch/i386/kernel: io_apic.c~.
Nur in linux-2.6.12-RT/arch/i386/kernel: io_apic.c-50-33.
diff -ru linux-2.6.12-RT-50-35/arch/i386/kernel/irq.c linux-2.6.12-RT/arch/i386/kernel/irq.c
--- linux-2.6.12-RT-50-35/arch/i386/kernel/irq.c	2005-06-30 16:38:19.000000000 +0200
+++ linux-2.6.12-RT/arch/i386/kernel/irq.c	2005-06-30 16:11:18.000000000 +0200
@@ -217,6 +217,8 @@
 	}
 
 	if (i < NR_IRQS) {
+		unsigned int irq_count;
+		cycles_t cycles;
 		spin_lock_irqsave(&irq_desc[i].lock, flags);
 		action = irq_desc[i].action;
 		if (!action)
@@ -230,12 +232,16 @@
 				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
-		seq_printf(p, "  %s", action->name);
 
-		for (action=action->next; action; action = action->next)
-			seq_printf(p, ", %s", action->name);
-		seq_printf(p, "  %d/%d", irq_desc[i].irqs_unhandled, irq_desc[i].irq_count);
+		irq_count = irq_desc[i].irq_count;
+		cycles =  irq_desc[i].cycles;
+		if (irq_count) {
+			do_div(cycles, irq_count);
+		}
+		seq_printf(p, "  %5d/%5d %5lld %lld", irq_desc[i].irqs_unhandled, irq_count, cycles, irq_desc[i].cycles);
 
+		for (; action; action = action->next)
+			seq_printf(p, ", %s", action->name);
 		seq_putc(p, '\n');
 skip:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
Nur in linux-2.6.12-RT/arch/i386/kernel: irq.c~.
diff -ru linux-2.6.12-RT-50-35/arch/i386/kernel/mpparse.c linux-2.6.12-RT/arch/i386/kernel/mpparse.c
--- linux-2.6.12-RT-50-35/arch/i386/kernel/mpparse.c	2005-06-30 16:38:00.000000000 +0200
+++ linux-2.6.12-RT/arch/i386/kernel/mpparse.c	2005-06-29 20:30:50.000000000 +0200
@@ -263,6 +263,7 @@
 		return;
 	}
 	mp_ioapics[nr_ioapics] = *m;
+	io_apic_base[nr_ioapics] = IO_APIC_BASE(nr_ioapics);
 	nr_ioapics++;
 }
 
@@ -914,6 +915,7 @@
 	mp_ioapics[idx].mpc_apicaddr = address;
 
 	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
+	io_apic_base[idx] = IO_APIC_BASE(idx);
 	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
 	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
 	
Nur in linux-2.6.12-RT/arch/i386/kernel: mpparse.c~.
Nur in linux-2.6.12-RT/arch/i386/kernel: mpparse.c-RT-50-35.
Nur in linux-2.6.12-RT: cscope.files.
Nur in linux-2.6.12-RT: cscope.files~.
Nur in linux-2.6.12-RT: cscope.out.
Nur in linux-2.6.12-RT/Documentation: realtime-lsm.txt.
diff -ru linux-2.6.12-RT-50-35/include/asm-i386/io_apic.h linux-2.6.12-RT/include/asm-i386/io_apic.h
--- linux-2.6.12-RT-50-35/include/asm-i386/io_apic.h	2005-06-30 16:38:20.000000000 +0200
+++ linux-2.6.12-RT/include/asm-i386/io_apic.h	2005-06-29 19:59:17.000000000 +0200
@@ -155,6 +155,8 @@
 /* MP IRQ source entries */
 extern struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
 
+extern volatile unsigned int *io_apic_base[MAX_IO_APICS];
+
 /* non-0 if default (table-less) MP configuration */
 extern int mpc_default_type;
 
Nur in linux-2.6.12-RT/include/asm-i386: io_apic.h~.
diff -ru linux-2.6.12-RT-50-35/include/linux/irq.h linux-2.6.12-RT/include/linux/irq.h
--- linux-2.6.12-RT-50-35/include/linux/irq.h	2005-06-30 16:38:20.000000000 +0200
+++ linux-2.6.12-RT/include/linux/irq.h	2005-06-30 13:24:46.000000000 +0200
@@ -79,7 +79,7 @@
 	unsigned int irqs_unhandled;
 	struct task_struct *thread;
 	wait_queue_head_t wait_for_handler;
-	cycles_t timestamp;
+	cycles_t cycles;
 	raw_spinlock_t lock;
 } ____cacheline_aligned irq_desc_t;
 
Nur in linux-2.6.12-RT/include/linux: irq.h~.
Nur in linux-2.6.12-RT/include: sound.
Nur in linux-2.6.12-RT/kernel: cscope.files.
Nur in linux-2.6.12-RT/kernel: cscope.out.
diff -ru linux-2.6.12-RT-50-35/kernel/irq/handle.c linux-2.6.12-RT/kernel/irq/handle.c
--- linux-2.6.12-RT-50-35/kernel/irq/handle.c	2005-06-30 16:38:20.000000000 +0200
+++ linux-2.6.12-RT/kernel/irq/handle.c	2005-06-30 13:36:11.000000000 +0200
@@ -143,10 +143,10 @@
 	return retval;
 }
 
-cycles_t irq_timestamp(unsigned int irq)
-{
-	return irq_desc[irq].timestamp;
-}
+/* cycles_t irq_timestamp(unsigned int irq) */
+/* { */
+/* 	return irq_desc[irq].timestamp; */
+/* } */
 
 /*
  * do_IRQ handles all normal device IRQ's (the special
@@ -160,7 +160,7 @@
 	unsigned int status;
 #ifdef CONFIG_PREEMPT_RT
 	unsigned long flags;
-
+	cycles_t timestamp;
 	/*
 	 * Disable the soft-irq-flag:
 	 */
@@ -178,7 +178,8 @@
 		desc->handler->end(irq);
 		return 1;
 	}
-	desc->timestamp = get_cycles();
+
+	timestamp = get_cycles();
 
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
@@ -256,6 +257,7 @@
 	local_irq_restore(flags);
 	/* re-disable interrupts because callers expect irqs off: */
 //	raw_local_irq_disable();
+	desc->cycles += get_cycles() - timestamp;
 #endif
 	return 1;
 }
Nur in linux-2.6.12-RT/kernel/irq: handle.c~.
diff -ru linux-2.6.12-RT-50-35/kernel/irq/manage.c linux-2.6.12-RT/kernel/irq/manage.c
--- linux-2.6.12-RT-50-35/kernel/irq/manage.c	2005-06-30 16:38:20.000000000 +0200
+++ linux-2.6.12-RT/kernel/irq/manage.c	2005-06-30 13:39:35.000000000 +0200
@@ -412,6 +412,7 @@
 	spin_lock_irq(&desc->lock);
 
 	if (desc->status & IRQ_INPROGRESS) {
+		cycles_t timestamp;
 		action = desc->action;
 		for (;;) {
 			irqreturn_t action_ret = 0;
@@ -434,9 +435,11 @@
 		 * The ->end() handler has to deal with interrupts which got
 		 * disabled while the handler was running.
 		 */
+		timestamp = get_cycles();
 		desc->handler->end(irq);
 		if (!(desc->status & IRQ_DISABLED))
 			desc->handler->enable(irq);
+		desc->cycles += get_cycles() - timestamp;
 	}
 	spin_unlock_irq(&desc->lock);
 
Nur in linux-2.6.12-RT/kernel/irq: manage.c~.
diff -ru linux-2.6.12-RT-50-35/kernel/irq/spurious.c linux-2.6.12-RT/kernel/irq/spurious.c
--- linux-2.6.12-RT-50-35/kernel/irq/spurious.c	2005-06-30 16:38:20.000000000 +0200
+++ linux-2.6.12-RT/kernel/irq/spurious.c	2005-06-30 15:41:54.000000000 +0200
@@ -74,11 +74,12 @@
 	}
 
 	desc->irq_count++;
-	if (desc->irq_count < 100000)
+	if (desc->irq_count < 10000)
 		return;
 
 	desc->irq_count = 0;
-	if (desc->irqs_unhandled > 99900) {
+	desc->cycles = 0;
+	if (desc->irqs_unhandled > 9990) {
 		/*
 		 * The interrupt is stuck
 		 */

--Boundary-00=_WFDxCZB2cotlskA--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
