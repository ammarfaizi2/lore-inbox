Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbVGNMsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVGNMsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 08:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbVGNMsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 08:48:19 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:53635 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263014AbVGNMsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 08:48:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Message-Id;
  b=qz3JG79qKrVpalNKcuD+1eHLs1tUnIE+YP44XQiNp9YJxVYBSBm2VZQFf/YfOwyI/i50TWAbGMnCWnswHWcCWDLsHGI6SV5+XajnxFsJfgogoQUMEB5bB3FSScquyfbIRISD2VgycQLQSTzKNeZ8gLvQyZ8/ulCqik8Fqp1rnYU=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       Chuck Harding <charding@llnl.gov>, William Weston <weston@sysex.net>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Thu, 14 Jul 2005 14:50:42 +0200
User-Agent: KMail/1.8.1
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050713103930.GA16776@elte.hu> <42D51EAF.2070603@cybsft.com>
In-Reply-To: <42D51EAF.2070603@cybsft.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_i+l1CjKmqQOTlIb"
Message-Id: <200507141450.42837.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_i+l1CjKmqQOTlIb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Mittwoch, 13. Juli 2005 16:01 schrieb K.R. Foley:
> Ingo Molnar wrote:
> > * Chuck Harding <charding@llnl.gov> wrote:
> > 
> > 
> >>>CC [M]  sound/oss/emu10k1/midi.o
> >>>sound/oss/emu10k1/midi.c:48: error: syntax error before '__attribute__'
> >>>sound/oss/emu10k1/midi.c:48: error: syntax error before ')' token
> >>>
> >>>Here's the offending line:
> >>>
> >>>  48 static DEFINE_SPINLOCK(midi_spinlock __attribute((unused)));
> >>>
> >>>Lee
> >>>
> >>
> >>I got it to compile but it won't boot - it hangs right after the
> >>'Uncompressing Linux... OK, booting the kernel' - I'm using .config
> >>from 51-27 (attached)
> > 
> > 
> > and -51-27 worked just fine? I've uploaded -29 with the -28 io-apic 
> > changes undone (will re-apply them once Karsten has figured out what's 
> > wrong).
> > 
> > 	Ingo
> 
> I too had the same problem booting -51-28 on my older SMP system at 
> home. -51-29 just booted fine.
> 
Have I corrected the other path of ioapic early initialization, which had lacked
virtual-address setup before ioapic_data[ioapic] was to be filled in -51-28?
Please test attached patch on top of -51-29 or later.
Also on Systems that liked -51-28.

    thanks, Karsten

--Boundary-00=_i+l1CjKmqQOTlIb
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="io_apic-RT-51-27.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="io_apic-RT-51-27.diff"

diff -ur ../linux-2.6.12-RT-51-23/arch/i386/kernel/apic.c ./arch/i386/kernel/apic.c
--- ../linux-2.6.12-RT-51-23/arch/i386/kernel/apic.c	2005-07-14 12:31:33.000000000 +0200
+++ linux-2.6.12-RT/arch/i386/kernel/apic.c	2005-07-14 12:34:53.000000000 +0200
@@ -832,10 +832,10 @@
 				ioapic_phys = (unsigned long)
 					      alloc_bootmem_pages(PAGE_SIZE);
 				ioapic_phys = __pa(ioapic_phys);
+				set_fixmap_nocache(idx, ioapic_phys);
+				printk(KERN_DEBUG "faked IOAPIC to %08lx (%08lx)\n",
+				       __fix_to_virt(idx), ioapic_phys);
 			}
-			set_fixmap_nocache(idx, ioapic_phys);
-			printk(KERN_DEBUG "mapped IOAPIC to %08lx (%08lx)\n",
-			       __fix_to_virt(idx), ioapic_phys);
 			idx++;
 		}
 	}
diff -ur ../linux-2.6.12-RT-51-23/arch/i386/kernel/io_apic.c ./arch/i386/kernel/io_apic.c
--- ../linux-2.6.12-RT-51-23/arch/i386/kernel/io_apic.c	2005-07-09 23:49:21.000000000 +0200
+++ linux-2.6.12-RT/arch/i386/kernel/io_apic.c	2005-07-14 12:34:54.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/compiler.h>
 #include <linux/acpi.h>
+#include <linux/bootmem.h>
 
 #include <linux/sysdev.h>
 #include <asm/io.h>
@@ -55,11 +56,6 @@
 int sis_apic_bug = -1;
 
 /*
- * # of IRQ routing registers
- */
-int nr_ioapic_registers[MAX_IO_APICS];
-
-/*
  * Rough estimation of how many shared IRQs there are, can
  * be changed anytime.
  */
@@ -132,88 +128,74 @@
 # define IOAPIC_CACHE
 #endif
 
-#ifdef IOAPIC_CACHE
-# define MAX_IOAPIC_CACHE 512
 
-/*
- * Cache register values:
- */
-static struct {
-	unsigned int reg;
-	unsigned int val[MAX_IOAPIC_CACHE];
-} io_apic_cache[MAX_IO_APICS]
-		____cacheline_aligned_in_smp;
+
+struct ioapic_data_struct {
+	struct sys_device dev;
+	int nr_registers;	//  # of IRQ routing registers
+	volatile unsigned int *base;
+	struct IO_APIC_route_entry *entry;
+#ifdef IOAPIC_CACHE
+	unsigned int reg_set;
+	u32 cached_val[0];
 #endif
+};
 
-volatile unsigned int *io_apic_base[MAX_IO_APICS];
+static struct ioapic_data_struct *ioapic_data[MAX_IO_APICS];
 
-static inline unsigned int __raw_io_apic_read(unsigned int apic, unsigned int reg)
+
+static inline unsigned int __raw_io_apic_read(struct ioapic_data_struct *ioapic, unsigned int reg)
 {
-	volatile unsigned int *io_apic;
-#ifdef IOAPIC_CACHE
-	io_apic_cache[apic].reg = reg;
-#endif
-	io_apic = io_apic_base[apic];
-	io_apic[0] = reg;
-	return io_apic[4];
+# ifdef IOAPIC_CACHE
+	ioapic->reg_set = reg;
+# endif
+	ioapic->base[0] = reg;
+	return ioapic->base[4];
 }
 
-unsigned int raw_io_apic_read(unsigned int apic, unsigned int reg)
+
+# ifdef IOAPIC_CACHE
+static void __init ioapic_cache_init(struct ioapic_data_struct *ioapic)
 {
-	unsigned int val = __raw_io_apic_read(apic, reg);
+	int reg;
+	for (reg = 0; reg < (ioapic->nr_registers + 10); reg++)
+		ioapic->cached_val[reg] = __raw_io_apic_read(ioapic, reg);
+}
+# endif
 
-#ifdef IOAPIC_CACHE
-	io_apic_cache[apic].val[reg] = val;
-#endif
+
+static unsigned int raw_io_apic_read(struct ioapic_data_struct *ioapic, unsigned int reg)
+{
+	unsigned int val = __raw_io_apic_read(ioapic, reg);
+
+# ifdef IOAPIC_CACHE
+	ioapic->cached_val[reg] = val;
+# endif
 	return val;
 }
 
-unsigned int io_apic_read(unsigned int apic, unsigned int reg)
+static unsigned int io_apic_read(struct ioapic_data_struct *ioapic, unsigned int reg)
 {
-#ifdef IOAPIC_CACHE
-	if (unlikely(reg >= MAX_IOAPIC_CACHE)) {
-		static int once = 1;
-
-		if (once) {
-			once = 0;
-			printk("WARNING: ioapic register cache overflow: %d.\n",
-				reg);
-			dump_stack();
-		}
-		return __raw_io_apic_read(apic, reg);
-	}
-	if (io_apic_cache[apic].val[reg] && !sis_apic_bug) {
-		io_apic_cache[apic].reg = -1;
-		return io_apic_cache[apic].val[reg];
+# ifdef IOAPIC_CACHE
+	if (likely(!sis_apic_bug)) {
+		ioapic->reg_set = -1;
+		return ioapic->cached_val[reg];
 	}
-#endif
-	return raw_io_apic_read(apic, reg);
+# endif
+	return raw_io_apic_read(ioapic, reg);
 }
 
-void io_apic_write(unsigned int apic, unsigned int reg, unsigned int val)
+static void io_apic_write(struct ioapic_data_struct *ioapic, unsigned int reg, unsigned int val)
 {
-	volatile unsigned int *io_apic;
-#ifdef IOAPIC_CACHE
-	if (unlikely(reg >= MAX_IOAPIC_CACHE)) {
-		static int once = 1;
-
-		if (once) {
-			once = 0;
-			printk("WARNING: ioapic register cache overflow: %d.\n",
-				reg);
-			dump_stack();
-		}
-	} else
-		io_apic_cache[apic].val[reg] = val;
-#endif
-	io_apic = io_apic_base[apic];
-#ifdef IOAPIC_CACHE
-	io_apic_cache[apic].reg = reg;
-#endif
-	io_apic[0] = reg;
-	io_apic[4] = val;
+# ifdef IOAPIC_CACHE
+	ioapic->cached_val[reg] = val;
+	ioapic->reg_set = reg;
+# endif
+	ioapic->base[0] = reg;
+	ioapic->base[4] = val;
 }
 
+
 /*
  * Some systems need a POST flush or else level-triggered interrupts
  * generate lots of spurious interrupts due to the POST-ed write not
@@ -231,44 +213,42 @@
  *
  * Older SiS APIC requires we rewrite the index regiser
  */
-void io_apic_modify(unsigned int apic, unsigned int reg, unsigned int val)
+static void io_apic_modify(struct ioapic_data_struct *ioapic, unsigned int reg, unsigned int val)
 {
-	volatile unsigned int *io_apic;
-#ifdef IOAPIC_CACHE
-	io_apic_cache[apic].val[reg] = val;
-#endif
-	io_apic = io_apic_base[apic];
 #ifdef IOAPIC_CACHE
-	if (io_apic_cache[apic].reg != reg || sis_apic_bug) {
-		io_apic_cache[apic].reg = reg;
+	ioapic->cached_val[reg] = val;
+	if (ioapic->reg_set != reg || sis_apic_bug) {
+		ioapic->reg_set = reg;
 #else
 	if (unlikely(sis_apic_bug)) {
 #endif
-		io_apic[0] = reg;
+		ioapic->base[0] = reg;
 	}
-	io_apic[4] = val;
+	ioapic->base[4] = val;
 #ifndef IOAPIC_POSTFLUSH
 	if (unlikely(sis_apic_bug))
 #endif
 		/*
 		 * Force POST flush by reading:
  		 */
-		val = io_apic[4];
+		val = ioapic->base[4];
 }
 
 static void __modify_IO_APIC_irq (unsigned int irq, unsigned long enable, unsigned long disable)
 {
 	struct irq_pin_list *entry = irq_2_pin + irq;
 	unsigned int pin, val;
+	struct ioapic_data_struct *ioapic;
 
 	for (;;) {
 		pin = entry->pin;
 		if (pin == -1)
 			break;
-		val = io_apic_read(entry->apic, 0x10 + pin*2);
+		ioapic = ioapic_data[entry->apic];
+		val = io_apic_read(ioapic, 0x10 + pin*2);
 		val &= ~disable;
 		val |= enable;
-		io_apic_modify(entry->apic, 0x10 + pin*2, val);
+		io_apic_modify(ioapic, 0x10 + pin*2, val);
 		if (!entry->next)
 			break;
 		entry = irq_2_pin + entry->next;
@@ -305,15 +285,15 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
+static void clear_IO_APIC_pin(struct ioapic_data_struct *ioapic, unsigned int pin)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
 	
 	/* Check delivery_mode to be sure we're not clearing an SMI pin */
 	spin_lock_irqsave(&ioapic_lock, flags);
-	*(((int*)&entry) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
-	*(((int*)&entry) + 1) = io_apic_read(apic, 0x11 + 2 * pin);
+	*(((int*)&entry) + 0) = io_apic_read(ioapic, 0x10 + 2 * pin);
+	*(((int*)&entry) + 1) = io_apic_read(ioapic, 0x11 + 2 * pin);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 	if (entry.delivery_mode == dest_SMI)
 		return;
@@ -324,8 +304,8 @@
 	memset(&entry, 0, sizeof(entry));
 	entry.mask = 1;
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry) + 0));
-	io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry) + 1));
+	io_apic_write(ioapic, 0x10 + 2 * pin, *(((int *)&entry) + 0));
+	io_apic_write(ioapic, 0x11 + 2 * pin, *(((int *)&entry) + 1));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
@@ -334,11 +314,12 @@
 	int apic, pin;
 
 	for (apic = 0; apic < nr_ioapics; apic++) {
+		struct ioapic_data_struct *ioapic = ioapic_data[apic];
 #ifdef IOAPIC_CACHE
-		io_apic_cache[apic].reg = -1;
+		ioapic->reg_set = -1;
 #endif
-		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++)
-			clear_IO_APIC_pin(apic, pin);
+		for (pin = 0; pin < ioapic->nr_registers; pin++)
+			clear_IO_APIC_pin(ioapic, pin);
 	}
 }
 
@@ -357,7 +338,7 @@
 		pin = entry->pin;
 		if (pin == -1)
 			break;
-		io_apic_write(entry->apic, 0x10 + 1 + pin*2, apicid_value);
+		io_apic_write(ioapic_data[entry->apic], 0x10 + 1 + pin*2, apicid_value);
 		if (!entry->next)
 			break;
 		entry = irq_2_pin + entry->next;
@@ -947,7 +928,7 @@
 		return;
 
 	for (ioapic = 0; ioapic < nr_ioapics; ioapic++) {
-		for (pin = 0; pin < nr_ioapic_registers[ioapic]; pin++) {
+		for (pin = 0; pin < ioapic_data[ioapic]->nr_registers; pin++) {
 			irq_entry = find_irq_entry(ioapic, pin, mp_INT);
 			if (irq_entry == -1)
 				continue;
@@ -1190,7 +1171,7 @@
 			 */
 			i = irq = 0;
 			while (i < apic)
-				irq += nr_ioapic_registers[i++];
+				irq += ioapic_data[i++]->nr_registers;
 			irq += pin;
 
 			/*
@@ -1233,7 +1214,7 @@
 	int apic, idx, pin;
 
 	for (apic = 0; apic < nr_ioapics; apic++) {
-		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
+		for (pin = 0; pin < ioapic_data[apic]->nr_registers; pin++) {
 			idx = find_irq_entry(apic,pin,mp_INT);
 			if ((idx != -1) && (irq == pin_2_irq(idx,apic,pin)))
 				return irq_trigger(idx);
@@ -1305,11 +1286,13 @@
 	struct IO_APIC_route_entry entry;
 	int apic, pin, idx, irq, first_notcon = 1, vector;
 	unsigned long flags;
+	struct ioapic_data_struct *ioapic;
 
 	apic_printk(APIC_VERBOSE, KERN_DEBUG "init IO_APIC IRQs\n");
 
 	for (apic = 0; apic < nr_ioapics; apic++) {
-	for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
+		ioapic = ioapic_data[apic];
+	for (pin = 0; pin < ioapic->nr_registers; pin++) {
 
 		/*
 		 * add it to the IO-APIC irq-routing table:
@@ -1366,8 +1349,8 @@
 				disable_8259A_irq(irq);
 		}
 		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
-		io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
+		io_apic_write(ioapic, 0x11+2*pin, *(((int *)&entry)+1));
+		io_apic_write(ioapic, 0x10+2*pin, *(((int *)&entry)+0));
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 	}
 	}
@@ -1432,6 +1415,7 @@
 	union IO_APIC_reg_02 reg_02;
 	union IO_APIC_reg_03 reg_03;
 	unsigned long flags;
+	struct ioapic_data_struct *ioapic;
 
 	if (apic_verbosity == APIC_QUIET)
 		return;
@@ -1439,7 +1423,7 @@
  	printk(KERN_DEBUG "number of MP IRQ sources: %d.\n", mp_irq_entries);
 	for (i = 0; i < nr_ioapics; i++)
 		printk(KERN_DEBUG "number of IO-APIC #%d registers: %d.\n",
-		       mp_ioapics[i].mpc_apicid, nr_ioapic_registers[i]);
+		       mp_ioapics[i].mpc_apicid, ioapic_data[i]->nr_registers);
 
 	/*
 	 * We are a bit conservative about what we expect.  We have to
@@ -1448,14 +1432,14 @@
 	printk(KERN_INFO "testing the IO APIC.......................\n");
 
 	for (apic = 0; apic < nr_ioapics; apic++) {
-
+	ioapic = ioapic_data[apic];
 	spin_lock_irqsave(&ioapic_lock, flags);
-	reg_00.raw = io_apic_read(apic, 0);
-	reg_01.raw = io_apic_read(apic, 1);
+	reg_00.raw = io_apic_read(ioapic, 0);
+	reg_01.raw = io_apic_read(ioapic, 1);
 	if (reg_01.bits.version >= 0x10)
-		reg_02.raw = io_apic_read(apic, 2);
+		reg_02.raw = io_apic_read(ioapic, 2);
 	if (reg_01.bits.version >= 0x20)
-		reg_03.raw = io_apic_read(apic, 3);
+		reg_03.raw = io_apic_read(ioapic, 3);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	printk(KERN_DEBUG "IO APIC #%d......\n", mp_ioapics[apic].mpc_apicid);
@@ -1526,8 +1510,8 @@
 		struct IO_APIC_route_entry entry;
 
 		spin_lock_irqsave(&ioapic_lock, flags);
-		*(((int *)&entry)+0) = raw_io_apic_read(apic, 0x10+i*2);
-		*(((int *)&entry)+1) = raw_io_apic_read(apic, 0x11+i*2);
+		*(((int *)&entry)+0) = raw_io_apic_read(ioapic, 0x10+i*2);
+		*(((int *)&entry)+1) = raw_io_apic_read(ioapic, 0x11+i*2);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 
 		printk(KERN_DEBUG " %02x %03X %02X  ",
@@ -1720,9 +1704,7 @@
 
 static void __init enable_IO_APIC(void)
 {
-	union IO_APIC_reg_01 reg_01;
 	int i;
-	unsigned long flags;
 
 	for (i = 0; i < PIN_MAP_SIZE; i++) {
 		irq_2_pin[i].pin = -1;
@@ -1733,16 +1715,6 @@
 			pirq_entries[i] = -1;
 
 	/*
-	 * The number of IO-APIC IRQ registers (== #pins):
-	 */
-	for (i = 0; i < nr_ioapics; i++) {
-		spin_lock_irqsave(&ioapic_lock, flags);
-		reg_01.raw = io_apic_read(i, 1);
-		spin_unlock_irqrestore(&ioapic_lock, flags);
-		nr_ioapic_registers[i] = reg_01.bits.entries+1;
-	}
-
-	/*
 	 * Do not trust the IO-APIC being empty at bootup
 	 */
 	clear_IO_APIC();
@@ -1777,6 +1749,7 @@
 	int i;
 	unsigned char old_id;
 	unsigned long flags;
+	struct ioapic_data_struct *ioapic;
 
 	/*
 	 * This is broken; anything with a real cpu count has to
@@ -1788,10 +1761,10 @@
 	 * Set the IOAPIC ID to the value stored in the MPC table.
 	 */
 	for (apic = 0; apic < nr_ioapics; apic++) {
-
+		ioapic = ioapic_data[apic];
 		/* Read the register 0 value */
 		spin_lock_irqsave(&ioapic_lock, flags);
-		reg_00.raw = io_apic_read(apic, 0);
+		reg_00.raw = io_apic_read(ioapic, 0);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
@@ -1856,14 +1829,14 @@
 
 		reg_00.bits.ID = mp_ioapics[apic].mpc_apicid;
 		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(apic, 0, reg_00.raw);
+		io_apic_write(ioapic, 0, reg_00.raw);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 
 		/*
 		 * Sanity check
 		 */
 		spin_lock_irqsave(&ioapic_lock, flags);
-		reg_00.raw = io_apic_read(apic, 0);
+		reg_00.raw = io_apic_read(ioapic, 0);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 		if (reg_00.bits.ID != mp_ioapics[apic].mpc_apicid)
 			printk("could not set ID!\n");
@@ -2230,7 +2203,7 @@
  * cycles as some i82489DX-based boards have glue logic that keeps the
  * 8259A interrupt line asserted until INTA.  --macro
  */
-static inline void unlock_ExtINT_logic(void)
+static void __init unlock_ExtINT_logic(void)
 {
 	int pin, i;
 	struct IO_APIC_route_entry entry0, entry1;
@@ -2291,7 +2264,7 @@
  * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
  * fanatically on his truly buggy board.
  */
-static inline void check_timer(void)
+static void __init check_timer(void)
 {
 	int pin1, pin2;
 	int vector;
@@ -2402,6 +2375,46 @@
 		"report.  Then try booting with the 'noapic' option");
 }
 
+void __init setup_IO_APIC_early(int _ioapic)
+{
+	union IO_APIC_reg_01 reg_01;
+	unsigned long flags;
+	int size, nr_ioapic_registers;
+	volatile int *ioapic;
+	if (ioapic_data[_ioapic]) {
+		printk("been in %s before !!!!!\n", __FUNCTION__);
+		return;
+	}
+
+	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + _ioapic, mp_ioapics[_ioapic].mpc_apicaddr);
+	printk(KERN_DEBUG "mapped IOAPIC to %08lx (%08lx)\n",
+	       __fix_to_virt(FIX_IO_APIC_BASE_0 + _ioapic), mp_ioapics[_ioapic].mpc_apicaddr);
+	/*
+	 * The number of IO-APIC IRQ registers (== #pins):
+	 */
+	ioapic = IO_APIC_BASE(_ioapic);
+	spin_lock_irqsave(&ioapic_lock, flags);
+	ioapic[0] = 1;
+	reg_01.raw = ioapic[4];
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+	nr_ioapic_registers = reg_01.bits.entries+1;
+
+	/*
+	 * Initialsize ioapic_data struct:
+	 */
+	size = sizeof(struct ioapic_data_struct);
+#ifdef IOAPIC_CACHE
+	size += 0x10 * sizeof(u32) + nr_ioapic_registers * sizeof(struct IO_APIC_route_entry);
+#endif
+	ioapic_data[_ioapic] = alloc_bootmem(size);
+	memset(ioapic_data[_ioapic], 0, size);
+	ioapic_data[_ioapic]->nr_registers = nr_ioapic_registers;
+	ioapic_data[_ioapic]->base = ioapic;
+#ifdef IOAPIC_CACHE
+	ioapic_cache_init(ioapic_data[_ioapic]);
+#endif
+}
+
 /*
  *
  * IRQ's that are handled by the PIC in the MPS IOAPIC case.
@@ -2449,25 +2462,22 @@
 
 late_initcall(io_apic_bug_finalize);
 
-struct sysfs_ioapic_data {
-	struct sys_device dev;
-	struct IO_APIC_route_entry entry[0];
-};
-static struct sysfs_ioapic_data * mp_ioapic_data[MAX_IO_APICS];
-
 static int ioapic_suspend(struct sys_device *dev, pm_message_t state)
 {
 	struct IO_APIC_route_entry *entry;
-	struct sysfs_ioapic_data *data;
+	struct ioapic_data_struct *data;
 	unsigned long flags;
 	int i;
+	struct ioapic_data_struct *ioapic;
 	
-	data = container_of(dev, struct sysfs_ioapic_data, dev);
+	data = container_of(dev, struct ioapic_data_struct, dev);
 	entry = data->entry;
+
+	ioapic = ioapic_data[dev->id];
 	spin_lock_irqsave(&ioapic_lock, flags);
-	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++, entry ++ ) {
-		*(((int *)entry) + 1) = io_apic_read(dev->id, 0x11 + 2 * i);
-		*(((int *)entry) + 0) = io_apic_read(dev->id, 0x10 + 2 * i);
+	for (i = 0; i < ioapic_data[dev->id]->nr_registers; i ++, entry ++) {
+		*(((int *)entry) + 1) = io_apic_read(ioapic, 0x11 + 2 * i);
+		*(((int *)entry) + 0) = io_apic_read(ioapic, 0x10 + 2 * i);
 	}
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
@@ -2477,23 +2487,25 @@
 static int ioapic_resume(struct sys_device *dev)
 {
 	struct IO_APIC_route_entry *entry;
-	struct sysfs_ioapic_data *data;
+	struct ioapic_data_struct *data;
 	unsigned long flags;
 	union IO_APIC_reg_00 reg_00;
 	int i;
-	
-	data = container_of(dev, struct sysfs_ioapic_data, dev);
+	struct ioapic_data_struct *ioapic;
+
+	data = container_of(dev, struct ioapic_data_struct, dev);
 	entry = data->entry;
 
+	ioapic = ioapic_data[dev->id];
 	spin_lock_irqsave(&ioapic_lock, flags);
-	reg_00.raw = io_apic_read(dev->id, 0);
+	reg_00.raw = io_apic_read(ioapic, 0);
 	if (reg_00.bits.ID != mp_ioapics[dev->id].mpc_apicid) {
 		reg_00.bits.ID = mp_ioapics[dev->id].mpc_apicid;
-		io_apic_write(dev->id, 0, reg_00.raw);
+		io_apic_write(ioapic, 0, reg_00.raw);
 	}
-	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++, entry ++ ) {
-		io_apic_write(dev->id, 0x11+2*i, *(((int *)entry)+1));
-		io_apic_write(dev->id, 0x10+2*i, *(((int *)entry)+0));
+	for (i = 0; i < ioapic_data[dev->id]->nr_registers; i ++, entry ++) {
+		io_apic_write(ioapic, 0x11+2*i, *(((int *)entry)+1));
+		io_apic_write(ioapic, 0x10+2*i, *(((int *)entry)+0));
 	}
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
@@ -2516,21 +2528,20 @@
 		return error;
 
 	for (i = 0; i < nr_ioapics; i++ ) {
-		size = sizeof(struct sys_device) + nr_ioapic_registers[i] 
-			* sizeof(struct IO_APIC_route_entry);
-		mp_ioapic_data[i] = kmalloc(size, GFP_KERNEL);
-		if (!mp_ioapic_data[i]) {
+		size = ioapic_data[i]->nr_registers * sizeof(struct IO_APIC_route_entry);
+		ioapic_data[i]->entry = kmalloc(size, GFP_KERNEL);
+		if (!ioapic_data[i]->entry) {
 			printk(KERN_ERR "Can't suspend/resume IOAPIC %d\n", i);
 			continue;
 		}
-		memset(mp_ioapic_data[i], 0, size);
-		dev = &mp_ioapic_data[i]->dev;
+		memset(ioapic_data[i]->entry, 0, size);
+		dev = &ioapic_data[i]->dev;
 		dev->id = i; 
 		dev->cls = &ioapic_sysdev_class;
 		error = sysdev_register(dev);
 		if (error) {
-			kfree(mp_ioapic_data[i]);
-			mp_ioapic_data[i] = NULL;
+			kfree(ioapic_data[i]->entry);
+			ioapic_data[i]->entry = NULL;
 			printk(KERN_ERR "Can't suspend/resume IOAPIC %d\n", i);
 			continue;
 		}
@@ -2547,13 +2558,14 @@
 
 #ifdef CONFIG_ACPI_BOOT
 
-int __init io_apic_get_unique_id (int ioapic, int apic_id)
+int __init io_apic_get_unique_id (int apic, int apic_id)
 {
 	union IO_APIC_reg_00 reg_00;
 	static physid_mask_t apic_id_map = PHYSID_MASK_NONE;
 	physid_mask_t tmp;
 	unsigned long flags;
 	int i = 0;
+	struct ioapic_data_struct *ioapic = ioapic_data[apic];
 
 	/*
 	 * The P4 platform supports up to 256 APIC IDs on two separate APIC 
@@ -2573,7 +2585,7 @@
 
 	if (apic_id >= get_physical_broadcast()) {
 		printk(KERN_WARNING "IOAPIC[%d]: Invalid apic_id %d, trying "
-			"%d\n", ioapic, apic_id, reg_00.bits.ID);
+			"%d\n", apic, apic_id, reg_00.bits.ID);
 		apic_id = reg_00.bits.ID;
 	}
 
@@ -2592,7 +2604,7 @@
 			panic("Max apic_id exceeded!\n");
 
 		printk(KERN_WARNING "IOAPIC[%d]: apic_id %d already used, "
-			"trying %d\n", ioapic, apic_id, i);
+			"trying %d\n", apic, apic_id, i);
 
 		apic_id = i;
 	} 
@@ -2610,50 +2622,50 @@
 
 		/* Sanity check */
 		if (reg_00.bits.ID != apic_id)
-			panic("IOAPIC[%d]: Unable change apic_id!\n", ioapic);
+			panic("IOAPIC[%d]: Unable change apic_id!\n", apic);
 	}
 
 	apic_printk(APIC_VERBOSE, KERN_INFO
-			"IOAPIC[%d]: Assigned apic_id %d\n", ioapic, apic_id);
+			"IOAPIC[%d]: Assigned apic_id %d\n", apic, apic_id);
 
 	return apic_id;
 }
 
 
-int __init io_apic_get_version (int ioapic)
+int __init io_apic_get_version (int apic)
 {
 	union IO_APIC_reg_01	reg_01;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	reg_01.raw = io_apic_read(ioapic, 1);
+	reg_01.raw = io_apic_read(ioapic_data[apic], 1);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return reg_01.bits.version;
 }
 
 
-int __init io_apic_get_redir_entries (int ioapic)
+int __init io_apic_get_redir_entries (int apic)
 {
 	union IO_APIC_reg_01	reg_01;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	reg_01.raw = io_apic_read(ioapic, 1);
+	reg_01.raw = io_apic_read(ioapic_data[apic], 1);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return reg_01.bits.entries;
 }
 
 
-int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level, int active_high_low)
+int io_apic_set_pci_routing (int apic, int pin, int irq, int edge_level, int active_high_low)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
-
+	struct ioapic_data_struct *ioapic = ioapic_data[apic];
 	if (!IO_APIC_IRQ(irq)) {
 		printk(KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0\n",
-			ioapic);
+			apic);
 		return -EINVAL;
 	}
 
@@ -2676,18 +2688,18 @@
 	 * IRQs < 16 are already in the irq_2_pin[] map
 	 */
 	if (irq >= 16)
-		add_pin_to_irq(irq, ioapic, pin);
+		add_pin_to_irq(irq, apic, pin);
 
 	entry.vector = assign_irq_vector(irq);
 
 	apic_printk(APIC_DEBUG, KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry "
-		"(%d-%d -> 0x%x -> IRQ %d Mode:%i Active:%i)\n", ioapic,
-		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq,
+		"(%d-%d -> 0x%x -> IRQ %d Mode:%i Active:%i)\n", apic,
+		mp_ioapics[apic].mpc_apicid, pin, entry.vector, irq,
 		edge_level, active_high_low);
 
 	ioapic_register_intr(irq, entry.vector, edge_level);
 
-	if (!ioapic && (irq < 16))
+	if (!apic && (irq < 16))
 		disable_8259A_irq(irq);
 
 	spin_lock_irqsave(&ioapic_lock, flags);
diff -ur ../linux-2.6.12-RT-51-23/arch/i386/kernel/mpparse.c ./arch/i386/kernel/mpparse.c
--- ../linux-2.6.12-RT-51-23/arch/i386/kernel/mpparse.c	2005-07-09 23:53:19.000000000 +0200
+++ linux-2.6.12-RT/arch/i386/kernel/mpparse.c	2005-07-14 12:24:25.000000000 +0200
@@ -263,7 +263,7 @@
 		return;
 	}
 	mp_ioapics[nr_ioapics] = *m;
-	io_apic_base[nr_ioapics] = IO_APIC_BASE(nr_ioapics);
+	setup_IO_APIC_early(nr_ioapics);
 	nr_ioapics++;
 }
 
@@ -914,8 +914,7 @@
 	mp_ioapics[idx].mpc_flags = MPC_APIC_USABLE;
 	mp_ioapics[idx].mpc_apicaddr = address;
 
-	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
-	io_apic_base[idx] = IO_APIC_BASE(idx);
+	setup_IO_APIC_early(idx);
 	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
 	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
 	
diff -ur ../linux-2.6.12-RT-51-23/include/asm-i386/io_apic.h ./include/asm-i386/io_apic.h
--- ../linux-2.6.12-RT-51-23/include/asm-i386/io_apic.h	2005-07-09 23:55:50.000000000 +0200
+++ linux-2.6.12-RT/include/asm-i386/io_apic.h	2005-07-14 11:39:33.000000000 +0200
@@ -155,15 +155,10 @@
 /* MP IRQ source entries */
 extern struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
 
-extern volatile unsigned int *io_apic_base[MAX_IO_APICS];
-
 /* non-0 if default (table-less) MP configuration */
 extern int mpc_default_type;
 
-extern unsigned int raw_io_apic_read(unsigned int apic, unsigned int reg);
-extern unsigned int io_apic_read(unsigned int apic, unsigned int reg);
-extern void io_apic_write(unsigned int apic, unsigned int reg, unsigned int value);
-extern void io_apic_modify(unsigned int apic, unsigned int reg, unsigned int value);
+extern void setup_IO_APIC_early(int ioapic);
 extern int sis_apic_bug;
 
 /* 1 if "noapic" boot option passed */

--Boundary-00=_i+l1CjKmqQOTlIb--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
