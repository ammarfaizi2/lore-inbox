Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVGTSml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVGTSml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 14:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVGTSmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 14:42:37 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:63135 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261454AbVGTSmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 14:42:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Message-Id;
  b=M+G3JdRHJz4q8dJaj/erAfReKJQrR32X1SHJfsb++8k0RMmOJsjAb8KCgDqjQ+bhFP/+Xxb6FnsdZV6J8N4D12zwkZeOsFfUTcYasXD7cV/PP77E6INPNjQSX/UTrnpQZ3La/E25a3iidtJxQVOzkm9NA6uNLaqMB826itiQg1k=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]IOAPIC_CACHE for PREEMPT_RT @ x86_64
Date: Wed, 20 Jul 2005 20:45:48 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cvp3CKuN63SFLHQ"
Message-Id: <200507202045.48211.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_cvp3CKuN63SFLHQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

attached patch implements IOAPIC_CACHE on x86_64,
if I haven't forgotten something....
Note that in the patch, IOAPIC_POSTFLUSH is initially not set.
Thats different to plain -51-32.
Works fine here on a K8T800 Mobo.
Would be fine, if some guys could give this a try ontop of -51-32.
Thanks,

    Karsten

--Boundary-00=_cvp3CKuN63SFLHQ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="io_apic-RT-51-32_x86_64"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="io_apic-RT-51-32_x86_64"

--- linux-2.6.12-RT-51-32/arch/x86_64/kernel/io_apic.c	2005-07-19 11:00:17.000000000 +0200
+++ linux-2.6.12-RT/arch/x86_64/kernel/io_apic.c	2005-07-20 18:15:10.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
 #include <linux/sysdev.h>
+#include <linux/bootmem.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -41,16 +42,11 @@
 
 #define __apicdebuginit  __init
 
-int sis_apic_bug; /* not actually supported, dummy for compile */
 
 static int no_timer_check;
 
 static DEFINE_RAW_SPINLOCK(ioapic_lock);
 
-/*
- * # of IRQ routing registers
- */
-int nr_ioapic_registers[MAX_IO_APICS];
 
 /*
  * Rough estimation of how many shared IRQs there are, can
@@ -101,22 +97,123 @@
 	entry->pin = pin;
 }
 
+#ifdef CONFIG_X86_IOAPIC_FAST
+# define IOAPIC_CACHE
+#endif
+
+/*
+ * some chips need this commented out:
+ */
+// #define IOAPIC_POSTFLUSH
+/*
+ * K8T800 seams not to need it.
+ */
+
+struct ioapic_data_struct {
+	volatile unsigned int *base;
+#ifdef IOAPIC_CACHE
+	unsigned int reg_set;
+#endif
+	int nr_registers;	//  # of IRQ routing registers
+	struct sys_device dev;
+	struct IO_APIC_route_entry *entry;
+#ifdef IOAPIC_CACHE
+	u32 cached_val[0];
+#endif
+};
+
+static struct ioapic_data_struct *ioapic_data[MAX_IO_APICS];
+
+
+static inline unsigned int __raw_io_apic_read(struct ioapic_data_struct *ioapic, unsigned int reg)
+{
+#ifdef IOAPIC_CACHE
+	ioapic->reg_set = reg;
+#endif
+	ioapic->base[0] = reg;
+	return ioapic->base[4];
+}
+
+
+#ifdef IOAPIC_CACHE
+static void __init ioapic_cache_init(struct ioapic_data_struct *ioapic)
+{
+	int reg;
+	for (reg = 0; reg < (0x10 + 2 * ioapic->nr_registers); reg++)
+		ioapic->cached_val[reg] = __raw_io_apic_read(ioapic, reg);
+}
+#endif
+
+#if !defined(IOAPIC_CACHE) || defined(IOAPIC_POSTFLUSH)
+static unsigned int raw_io_apic_read(struct ioapic_data_struct *ioapic, unsigned int reg)
+{
+	unsigned int val = __raw_io_apic_read(ioapic, reg);
+
+#ifdef IOAPIC_CACHE
+	ioapic->cached_val[reg] = val;
+#endif
+	return val;
+}
+#endif
+
+static inline unsigned int io_apic_read(struct ioapic_data_struct *ioapic, unsigned int reg)
+{
+#ifdef IOAPIC_CACHE
+	ioapic->reg_set = -1;
+	return ioapic->cached_val[reg];
+#else
+	return raw_io_apic_read(ioapic, reg);
+#endif
+}
+
+static void io_apic_write(struct ioapic_data_struct *ioapic, unsigned int reg, unsigned int val)
+{
+#ifdef IOAPIC_CACHE
+	ioapic->cached_val[reg] = val;
+	ioapic->reg_set = reg;
+#endif
+	ioapic->base[0] = reg;
+	ioapic->base[4] = val;
+}
+
+/*
+ * Re-write a value: to be used for read-modify-write
+ * cycles where the read already set up the index register.
+ */
+static inline void io_apic_modify(struct ioapic_data_struct *ioapic, unsigned int reg, unsigned int val)
+{
+#ifdef IOAPIC_CACHE
+	if (ioapic->reg_set != reg) {
+		ioapic->base[0] = reg;
+		ioapic->reg_set = reg;
+	}
+	ioapic->cached_val[reg] = val;
+#endif
+	ioapic->base[4] = val;
+
+#ifdef IOAPIC_POSTFLUSH
+		 /* Force POST flush by reading: */
+	val = raw_io_apic_read(ioapic, reg);
+#endif
+}
+
 #define __DO_ACTION(R, ACTION, FINAL)					\
 									\
 {									\
 	int pin;							\
 	struct irq_pin_list *entry = irq_2_pin + irq;			\
+	struct ioapic_data_struct *ioapic;				\
 									\
 	for (;;) {							\
-		unsigned int reg;					\
+		unsigned int reg, val;					\
 		pin = entry->pin;					\
 		if (pin == -1)						\
 			break;						\
-		reg = io_apic_read(entry->apic, 0x10 + R + pin*2);	\
-		reg ACTION;						\
-		io_apic_modify(entry->apic, reg);			\
-		 /* Force POST flush by reading: */			\
-		reg = io_apic_read(entry->apic, 0x10 + R + pin*2);	\
+		ioapic = ioapic_data[entry->apic];			\
+		reg = 0x10 + R + pin*2;					\
+		val = io_apic_read(ioapic, reg);			\
+		val ACTION;						\
+		io_apic_modify(ioapic, reg, val);			\
 									\
 		if (!entry->next)					\
 			break;						\
@@ -151,15 +248,15 @@
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
@@ -169,8 +266,8 @@
 	memset(&entry, 0, sizeof(entry));
 	entry.mask = 1;
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry) + 0));
-	io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry) + 1));
+	io_apic_write(ioapic, 0x10 + 2 * pin, *(((int *)&entry) + 0));
+	io_apic_write(ioapic, 0x11 + 2 * pin, *(((int *)&entry) + 1));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
@@ -178,9 +275,14 @@
 {
 	int apic, pin;
 
-	for (apic = 0; apic < nr_ioapics; apic++)
-		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++)
-			clear_IO_APIC_pin(apic, pin);
+	for (apic = 0; apic < nr_ioapics; apic++) {
+		struct ioapic_data_struct *ioapic = ioapic_data[apic];
+#ifdef IOAPIC_CACHE
+		ioapic->reg_set = -1;
+#endif
+		for (pin = 0; pin < ioapic->nr_registers; pin++)
+			clear_IO_APIC_pin(ioapic, pin);
+	}
 }
 
 /*
@@ -609,7 +711,7 @@
 			 */
 			i = irq = 0;
 			while (i < apic)
-				irq += nr_ioapic_registers[i++];
+				irq += ioapic_data[i++]->nr_registers;
 			irq += pin;
 			break;
 		}
@@ -643,7 +745,7 @@
 	int apic, idx, pin;
 
 	for (apic = 0; apic < nr_ioapics; apic++) {
-		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
+		for (pin = 0; pin < ioapic_data[apic]->nr_registers; pin++) {
 			idx = find_irq_entry(apic,pin,mp_INT);
 			if ((idx != -1) && (irq == pin_2_irq(idx,apic,pin)))
 				return irq_trigger(idx);
@@ -716,11 +818,13 @@
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
@@ -766,8 +870,8 @@
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
@@ -814,8 +918,8 @@
 	 * Add it to the IO-APIC irq-routing table:
 	 */
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
-	io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
+	io_apic_write(ioapic_data[0], 0x11+2*pin, *(((int *)&entry)+1));
+	io_apic_write(ioapic_data[0], 0x10+2*pin, *(((int *)&entry)+0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	enable_8259A_irq(0);
@@ -832,6 +936,7 @@
 	union IO_APIC_reg_01 reg_01;
 	union IO_APIC_reg_02 reg_02;
 	unsigned long flags;
+	struct ioapic_data_struct *ioapic;
 
 	if (apic_verbosity == APIC_QUIET)
 		return;
@@ -839,7 +944,7 @@
 	printk(KERN_DEBUG "number of MP IRQ sources: %d.\n", mp_irq_entries);
 	for (i = 0; i < nr_ioapics; i++)
 		printk(KERN_DEBUG "number of IO-APIC #%d registers: %d.\n",
-		       mp_ioapics[i].mpc_apicid, nr_ioapic_registers[i]);
+		       mp_ioapics[i].mpc_apicid, ioapic_data[i]->nr_registers);
 
 	/*
 	 * We are a bit conservative about what we expect.  We have to
@@ -848,12 +953,12 @@
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
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	printk("\n");
@@ -905,8 +1010,8 @@
 		struct IO_APIC_route_entry entry;
 
 		spin_lock_irqsave(&ioapic_lock, flags);
-		*(((int *)&entry)+0) = io_apic_read(apic, 0x10+i*2);
-		*(((int *)&entry)+1) = io_apic_read(apic, 0x11+i*2);
+		*(((int *)&entry)+0) = io_apic_read(ioapic, 0x10+i*2);
+		*(((int *)&entry)+1) = io_apic_read(ioapic, 0x11+i*2);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 
 		printk(KERN_DEBUG " %02x %03X %02X  ",
@@ -1099,9 +1204,7 @@
 
 static void __init enable_IO_APIC(void)
 {
-	union IO_APIC_reg_01 reg_01;
 	int i;
-	unsigned long flags;
 
 	for (i = 0; i < PIN_MAP_SIZE; i++) {
 		irq_2_pin[i].pin = -1;
@@ -1112,16 +1215,6 @@
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
@@ -1154,15 +1247,16 @@
 	int i;
 	unsigned char old_id;
 	unsigned long flags;
+	struct ioapic_data_struct *ioapic;
 
 	/*
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
@@ -1190,19 +1284,19 @@
 
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
 		else
-			apic_printk(APIC_VERBOSE," ok.\n");
+			apic_printk(APIC_VERBOSE, " ok.\n");
 	}
 }
 
@@ -1233,6 +1327,7 @@
 	/* jiffies wrap? */
 	if (jiffies - t1 > 4)
 		return 1;
+
 	return 0;
 }
 
@@ -1258,7 +1353,6 @@
  * This is not complete - we should be able to fake
  * an edge even if it isn't on the 8259A...
  */
-
 static unsigned int startup_edge_ioapic_irq(unsigned int irq)
 {
 	int was_pending = 0;
@@ -1441,27 +1535,26 @@
  * edge-triggered handler, without risking IRQ storms and other ugly
  * races.
  */
-
 static struct hw_interrupt_type ioapic_edge_type = {
-	.typename = "IO-APIC-edge",
+	.typename	= "IO-APIC-edge",
 	.startup 	= startup_edge_ioapic,
 	.shutdown 	= shutdown_edge_ioapic,
 	.enable 	= enable_edge_ioapic,
 	.disable 	= disable_edge_ioapic,
 	.ack 		= ack_edge_ioapic,
 	.end 		= end_edge_ioapic,
-	.set_affinity = set_ioapic_affinity,
+	.set_affinity	= set_ioapic_affinity,
 };
 
 static struct hw_interrupt_type ioapic_level_type = {
-	.typename = "IO-APIC-level",
+	.typename	= "IO-APIC-level",
 	.startup 	= startup_level_ioapic,
 	.shutdown 	= shutdown_level_ioapic,
 	.enable 	= enable_level_ioapic,
 	.disable 	= disable_level_ioapic,
 	.ack 		= mask_and_ack_level_ioapic,
 	.end 		= end_level_ioapic,
-	.set_affinity = set_ioapic_affinity,
+	.set_affinity	= set_ioapic_affinity,
 };
 
 static inline void init_IO_APIC_traps(void)
@@ -1525,13 +1618,13 @@
 static void end_lapic_irq (unsigned int i) { /* nothing */ }
 
 static struct hw_interrupt_type lapic_irq_type = {
-	.typename = "local-APIC-edge",
-	.startup = NULL, /* startup_irq() not used for IRQ0 */
-	.shutdown = NULL, /* shutdown_irq() not used for IRQ0 */
-	.enable = enable_lapic_irq,
-	.disable = disable_lapic_irq,
-	.ack = ack_lapic_irq,
-	.end = end_lapic_irq,
+	.typename	= "local-APIC-edge",
+	.startup	= NULL, /* startup_irq() not used for IRQ0 */
+	.shutdown	= NULL, /* shutdown_irq() not used for IRQ0 */
+	.enable		= enable_lapic_irq,
+	.disable	= disable_lapic_irq,
+	.ack		= ack_lapic_irq,
+	.end		= end_lapic_irq
 };
 
 static void setup_nmi (void)
@@ -1565,16 +1658,17 @@
 	struct IO_APIC_route_entry entry0, entry1;
 	unsigned char save_control, save_freq_select;
 	unsigned long flags;
+	struct ioapic_data_struct *ioapic0 = ioapic_data[0];
 
 	pin = find_isa_irq_pin(8, mp_INT);
 	if (pin == -1)
 		return;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	*(((int *)&entry0) + 1) = io_apic_read(0, 0x11 + 2 * pin);
-	*(((int *)&entry0) + 0) = io_apic_read(0, 0x10 + 2 * pin);
+	*(((int *)&entry0) + 1) = io_apic_read(ioapic0, 0x11 + 2 * pin);
+	*(((int *)&entry0) + 0) = io_apic_read(ioapic0, 0x10 + 2 * pin);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
-	clear_IO_APIC_pin(0, pin);
+	clear_IO_APIC_pin(ioapic0, pin);
 
 	memset(&entry1, 0, sizeof(entry1));
 
@@ -1587,8 +1681,8 @@
 	entry1.vector = 0;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry1) + 1));
-	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry1) + 0));
+	io_apic_write(ioapic0, 0x11 + 2 * pin, *(((int *)&entry1) + 1));
+	io_apic_write(ioapic0, 0x10 + 2 * pin, *(((int *)&entry1) + 0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	save_control = CMOS_READ(RTC_CONTROL);
@@ -1606,11 +1700,11 @@
 
 	CMOS_WRITE(save_control, RTC_CONTROL);
 	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
-	clear_IO_APIC_pin(0, pin);
+	clear_IO_APIC_pin(ioapic0, pin);
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry0) + 1));
-	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry0) + 0));
+	io_apic_write(ioapic0, 0x11 + 2 * pin, *(((int *)&entry0) + 1));
+	io_apic_write(ioapic0, 0x10 + 2 * pin, *(((int *)&entry0) + 0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
@@ -1624,6 +1718,7 @@
 {
 	int pin1, pin2;
 	int vector;
+	struct ioapic_data_struct *ioapic0 = ioapic_data[0];
 
 	/*
 	 * get/set the timer IRQ vector:
@@ -1662,7 +1757,7 @@
 			}
 			return;
 		}
-		clear_IO_APIC_pin(0, pin1);
+		clear_IO_APIC_pin(ioapic0, pin1);
 		apic_printk(APIC_QUIET,KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 	}
 
@@ -1684,7 +1779,7 @@
 		/*
 		 * Cleanup, just in case ...
 		 */
-		clear_IO_APIC_pin(0, pin2);
+		clear_IO_APIC_pin(ioapic0, pin2);
 	}
 	printk(" failed.\n");
 
@@ -1730,6 +1825,46 @@
 }
 __setup("no_timer_check", notimercheck);
 
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
+	printk(KERN_DEBUG "mapped IOAPIC to %016lx (%016x)\n",
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
@@ -1763,25 +1898,20 @@
 		print_IO_APIC();
 }
 
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
 	unsigned long flags;
 	int i;
+	struct ioapic_data_struct *ioapic;
+	
+	ioapic = ioapic_data[dev->id];
+	entry = ioapic->entry;
 
-	data = container_of(dev, struct sysfs_ioapic_data, dev);
-	entry = data->entry;
 	spin_lock_irqsave(&ioapic_lock, flags);
-	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++, entry ++ ) {
-		*(((int *)entry) + 1) = io_apic_read(dev->id, 0x11 + 2 * i);
-		*(((int *)entry) + 0) = io_apic_read(dev->id, 0x10 + 2 * i);
+	for (i = 0; i < ioapic_data[dev->id]->nr_registers; i ++, entry ++) {
+		*(((int *)entry) + 1) = io_apic_read(ioapic, 0x11 + 2 * i);
+		*(((int *)entry) + 0) = io_apic_read(ioapic, 0x10 + 2 * i);
 	}
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
@@ -1791,23 +1921,23 @@
 static int ioapic_resume(struct sys_device *dev)
 {
 	struct IO_APIC_route_entry *entry;
-	struct sysfs_ioapic_data *data;
 	unsigned long flags;
 	union IO_APIC_reg_00 reg_00;
 	int i;
+	struct ioapic_data_struct *ioapic;
 
-	data = container_of(dev, struct sysfs_ioapic_data, dev);
-	entry = data->entry;
+	ioapic = ioapic_data[dev->id];
+	entry = ioapic->entry;
 
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
 
@@ -1830,21 +1960,20 @@
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
-		dev->id = i;
+		memset(ioapic_data[i]->entry, 0, size);
+		dev = &ioapic_data[i]->dev;
+		dev->id = i; 
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
@@ -1863,26 +1992,26 @@
 
 #define IO_APIC_MAX_ID		0xFE
 
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
@@ -1934,8 +2063,8 @@
 		disable_8259A_irq(irq);
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(ioapic, 0x11+2*pin, *(((int *)&entry)+1));
-	io_apic_write(ioapic, 0x10+2*pin, *(((int *)&entry)+0));
+	io_apic_write(ioapic_data[ioapic], 0x11+2*pin, *(((int *)&entry)+1));
+	io_apic_write(ioapic_data[ioapic], 0x10+2*pin, *(((int *)&entry)+0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return 0;
@@ -1951,17 +2080,18 @@
  */
 void __init setup_ioapic_dest(void)
 {
-	int pin, ioapic, irq, irq_entry;
+	int pin, apic, irq, irq_entry;
 
 	if (skip_ioapic_setup == 1)
 		return;
 
-	for (ioapic = 0; ioapic < nr_ioapics; ioapic++) {
-		for (pin = 0; pin < nr_ioapic_registers[ioapic]; pin++) {
-			irq_entry = find_irq_entry(ioapic, pin, mp_INT);
+	for (apic = 0; apic < nr_ioapics; apic++) {
+		struct ioapic_data_struct *ioapic = ioapic_data[apic];
+		for (pin = 0; pin < ioapic->nr_registers; pin++) {
+			irq_entry = find_irq_entry(apic, pin, mp_INT);
 			if (irq_entry == -1)
 				continue;
-			irq = pin_2_irq(irq_entry, ioapic, pin);
+			irq = pin_2_irq(irq_entry, apic, pin);
 			set_ioapic_affinity_irq(irq, TARGET_CPUS);
 		}
 
--- linux-2.6.12-RT-51-32/arch/x86_64/kernel/mpparse.c	2005-07-19 11:02:55.000000000 +0200
+++ linux-2.6.12-RT/arch/x86_64/kernel/mpparse.c	2005-07-20 16:48:04.000000000 +0200
@@ -203,6 +203,7 @@
 		return;
 	}
 	mp_ioapics[nr_ioapics] = *m;
+	setup_IO_APIC_early(nr_ioapics);
 	nr_ioapics++;
 }
 
@@ -767,7 +768,7 @@
 	mp_ioapics[idx].mpc_flags = MPC_APIC_USABLE;
 	mp_ioapics[idx].mpc_apicaddr = address;
 
-	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
+	setup_IO_APIC_early(idx);
 	mp_ioapics[idx].mpc_apicid = id;
 	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
 	
--- linux-2.6.12-RT-51-32/arch/x86_64/kernel/apic.c	2005-07-17 12:33:27.000000000 +0200
+++ linux-2.6.12-RT/arch/x86_64/kernel/apic.c	2005-07-20 16:48:04.000000000 +0200
@@ -622,15 +622,13 @@
 		int i;
 
 		for (i = 0; i < nr_ioapics; i++) {
-			if (smp_found_config) {
-				ioapic_phys = mp_ioapics[i].mpc_apicaddr;
-			} else {
+			if (!smp_found_config) {
 				ioapic_phys = (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
 				ioapic_phys = __pa(ioapic_phys);
+				set_fixmap_nocache(idx, ioapic_phys);
+				printk("faked IOAPIC to %016lx (%016lx)\n",
+				       __fix_to_virt(idx), ioapic_phys);
 			}
-			set_fixmap_nocache(idx, ioapic_phys);
-			apic_printk(APIC_VERBOSE,"mapped IOAPIC to %016lx (%016lx)\n",
-					__fix_to_virt(idx), ioapic_phys);
 			idx++;
 		}
 	}
--- linux-2.6.12-RT-51-32/arch/x86_64/Kconfig	2005-07-17 12:33:27.000000000 +0200
+++ linux-2.6.12-RT/arch/x86_64/Kconfig	2005-07-20 16:48:04.000000000 +0200
@@ -156,6 +156,16 @@
 	bool
 	default y
 
+config X86_IOAPIC_FAST
+	bool "enhanced IO-APIC support"
+	depends on X86_IO_APIC
+	default y
+	help
+	  this option will activate further optimizations in the IO-APIC
+	  code. NOTE: this is experimental code, and disabled by default.
+	  Symptoms of non-working systems are boot-time lockups, stray or
+	  screaming interrupts and other interrupt related weirdnesses.
+
 config X86_LOCAL_APIC
 	bool
 	default y
--- linux-2.6.12-RT-51-32/include/asm-x86_64/io_apic.h	2005-07-19 11:02:05.000000000 +0200
+++ linux-2.6.12-RT/include/asm-x86_64/io_apic.h	2005-07-20 16:48:04.000000000 +0200
@@ -103,7 +103,6 @@
  * # of IO-APICs and # of IRQ routing registers
  */
 extern int nr_ioapics;
-extern int nr_ioapic_registers[MAX_IO_APICS];
 
 enum ioapic_irq_destination_types {
 	dest_Fixed = 0,
@@ -160,27 +159,6 @@
 /* non-0 if default (table-less) MP configuration */
 extern int mpc_default_type;
 
-static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
-{
-	*IO_APIC_BASE(apic) = reg;
-	return *(IO_APIC_BASE(apic)+4);
-}
-
-static inline void io_apic_write(unsigned int apic, unsigned int reg, unsigned int value)
-{
-	*IO_APIC_BASE(apic) = reg;
-	*(IO_APIC_BASE(apic)+4) = value;
-}
-
-/*
- * Re-write a value: to be used for read-modify-write
- * cycles where the read already set up the index register.
- */
-static inline void io_apic_modify(unsigned int apic, unsigned int value)
-{
-	*(IO_APIC_BASE(apic)+4) = value;
-}
-
 /*
  * Synchronize the IO-APIC and the CPU by doing
  * a dummy read from the IO-APIC
@@ -205,7 +183,7 @@
 extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int, int);
 #endif
 
-extern int sis_apic_bug; /* dummy */ 
+extern void setup_IO_APIC_early(int ioapic);
 
 #else  /* !CONFIG_X86_IO_APIC */
 #define io_apic_assign_pci_irqs 0
--- linux-2.6.12-RT-51-32/kernel/irq/spurious.c	2005-07-17 12:33:27.000000000 +0200
+++ linux-2.6.12-RT/kernel/irq/spurious.c	2005-07-20 16:48:04.000000000 +0200
@@ -36,11 +36,13 @@
 				irq, action_ret);
 	} else {
 		printk(KERN_ERR "irq %d: nobody cared!\n", irq);
-#ifdef CONFIG_X86_IO_APIC
+#ifndef CONFIG_X86_64
+# ifdef CONFIG_X86_IO_APIC
 		if (!sis_apic_bug) {
 			sis_apic_bug = 1;
 			printk(KERN_ERR "turning off IO-APIC fast mode.\n");
 		}
+# endif
 #endif
 	}
 	dump_stack();
@@ -83,7 +85,7 @@
 		 * The interrupt is stuck
 		 */
 		__report_bad_irq(irq, desc, action_ret);
-#ifdef CONFIG_X86_IO_APIC
+#if defined(CONFIG_X86_IO_APIC) && !defined(CONFIG_X86_64)
 		if (!sis_apic_bug) {
 			sis_apic_bug = 1;
 			printk(KERN_ERR "turning off IO-APIC fast mode.\n");
--- linux-2.6.12-RT-51-32/drivers/pci/quirks.c	2005-07-09 23:20:57.000000000 +0200
+++ linux-2.6.12-RT/drivers/pci/quirks.c	2005-07-20 16:48:04.000000000 +0200
@@ -423,12 +423,14 @@
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic );
 
+#if !defined(CONFIG_X86_64)
 static void __init quirk_ioapic_rmw(struct pci_dev *dev)
 {
 	if (dev->devfn == 0 && dev->bus->number == 0)
 		sis_apic_bug = 1;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw );
+#endif
 
 int pci_msi_quirk;
 
@@ -465,6 +467,7 @@
 #endif /* CONFIG_X86_IO_APIC */
 
 
+#if !defined(CONFIG_X86_64)
 /*
  * FIXME: it is questionable that quirk_via_acpi
  * is needed.  It shows up as an ISA bridge, and does not
@@ -511,6 +514,7 @@
 	}
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
+#endif
 
 /*
  * PIIX3 USB: We have to disable USB interrupts that are

--Boundary-00=_cvp3CKuN63SFLHQ--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
