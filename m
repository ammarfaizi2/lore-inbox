Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVK0RDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVK0RDK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 12:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVK0RDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 12:03:10 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:6298 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751115AbVK0RDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 12:03:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Message-Id;
  b=syuWIHNp56JriKZFftyEXnX4RHT0GP8ydKXLvQ5ZcXOdcxMb48uehPZpS7huYi9FpBElxnzZ+u9Vamx+DlmlobJFYGUscRZ8g7UXe+PgZ7iw7CY7FcsquAcHxrNmHHokxA6FUDYV8TBEfKQl+nVBIqxmx0mbxpNapPXz8drrScI=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH] -rt: x86_64 ioapic register cache
Date: Sun, 27 Nov 2005 18:05:59 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4deiDy6v+QkOSfI"
Message-Id: <200511271806.00295.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_4deiDy6v+QkOSfI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_4deiDy6v+QkOSfI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-rt_x86_64_ioapic_cached.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-rt_x86_64_ioapic_cached.diff"

x86_64 ioapic register cache

new "_init  setup_IO_APIC_early()" to consolidate data structs.
Config selectable register cache.
Removes "int sis_apic_bug". Sensible?

signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>


diff -urp rt12/arch/x86_64/Kconfig rt12-kw/arch/x86_64/Kconfig
--- rt12/arch/x86_64/Kconfig	2005-11-13 23:49:27.000000000 +0100
+++ rt12-kw/arch/x86_64/Kconfig	2005-11-13 23:51:26.000000000 +0100
@@ -171,6 +171,16 @@ config X86_IO_APIC
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
diff -urp rt12/arch/x86_64/kernel/apic.c rt12-kw/arch/x86_64/kernel/apic.c
--- rt12/arch/x86_64/kernel/apic.c	2005-11-13 23:49:27.000000000 +0100
+++ rt12-kw/arch/x86_64/kernel/apic.c	2005-11-13 23:51:26.000000000 +0100
@@ -628,15 +628,13 @@ void __init init_apic_mappings(void)
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
diff -urp rt12/arch/x86_64/kernel/io_apic.c rt12-kw/arch/x86_64/kernel/io_apic.c
--- rt12/arch/x86_64/kernel/io_apic.c	2005-11-13 23:49:27.000000000 +0100
+++ rt12-kw/arch/x86_64/kernel/io_apic.c	2005-11-13 23:51:26.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
 #include <linux/sysdev.h>
+#include <linux/bootmem.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -40,8 +41,6 @@
 
 #define __apicdebuginit  __init
 
-int sis_apic_bug; /* not actually supported, dummy for compile */
-
 static int no_timer_check;
 
 int disable_timer_pin_1 __initdata;
@@ -49,11 +48,6 @@ int disable_timer_pin_1 __initdata;
 static DEFINE_RAW_SPINLOCK(ioapic_lock);
 
 /*
- * # of IRQ routing registers
- */
-int nr_ioapic_registers[MAX_IO_APICS];
-
-/*
  * Rough estimation of how many shared IRQs there are, can
  * be changed anytime.
  */
@@ -79,22 +73,138 @@ int vector_irq[NR_VECTORS] __read_mostly
 #define vector_to_irq(vector)	(vector)
 #endif
 
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
+static int nr_ioapic_registers(int apic)
+{
+	return ioapic_data[apic]->nr_registers;
+}
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
+	unsig ned int val = __raw_io_apic_read(ioapic, reg);
+
+#ifdef IOAPIC_CACHE
+	ioapic->cached_val[reg] = val;
+#endif
+	return val;
+}
+#endif
+
+static inline unsigned int __io_apic_read(struct ioapic_data_struct *ioapic, unsigned int reg)
+{
+#ifdef IOAPIC_CACHE
+	ioapic->reg_set = -1;
+	return ioapic->cached_val[reg];
+#else
+	return raw_io_apic_read(ioapic, reg);
+#endif
+}
+
+static unsigned int io_apic_read(unsigned int apic, unsigned int reg)
+{
+	return  __io_apic_read(ioapic_data[apic], reg);
+}
+
+static void __io_apic_write(struct ioapic_data_struct *ioapic, unsigned int reg, unsigned int val)
+{
+#ifdef IOAPIC_CACHE
+	ioapic->cached_val[reg] = val;
+	ioapic->reg_set = reg;
+#endif
+	ioapic->base[0] = reg;
+	ioapic->base[4] = val;
+}
+
+static void io_apic_write(unsigned int apic, unsigned int reg, unsigned int val)
+{
+	return __io_apic_write(ioapic_data[apic], reg, val);
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
+		val = __io_apic_read(ioapic, reg);			\
+		val ACTION;						\
+		io_apic_modify(ioapic, reg, val);			\
 									\
 		if (!entry->next)					\
 			break;						\
@@ -207,9 +317,10 @@ static void clear_IO_APIC (void)
 {
 	int apic, pin;
 
-	for (apic = 0; apic < nr_ioapics; apic++)
-		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++)
+	for (apic = 0; apic < nr_ioapics; apic++) {
+		for (pin = 0; pin < nr_ioapic_registers(apic); pin++)
 			clear_IO_APIC_pin(apic, pin);
+	}
 }
 
 /*
@@ -638,7 +749,7 @@ static int pin_2_irq(int idx, int apic, 
 			 */
 			i = irq = 0;
 			while (i < apic)
-				irq += nr_ioapic_registers[i++];
+				irq += nr_ioapic_registers(i++);
 			irq += pin;
 			break;
 		}
@@ -672,7 +783,7 @@ static inline int IO_APIC_irq_trigger(in
 	int apic, idx, pin;
 
 	for (apic = 0; apic < nr_ioapics; apic++) {
-		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
+		for (pin = 0; pin < nr_ioapic_registers(apic); pin++) {
 			idx = find_irq_entry(apic,pin,mp_INT);
 			if ((idx != -1) && (irq == pin_2_irq(idx,apic,pin)))
 				return irq_trigger(idx);
@@ -749,7 +860,7 @@ static void __init setup_IO_APIC_irqs(vo
 	apic_printk(APIC_VERBOSE, KERN_DEBUG "init IO_APIC IRQs\n");
 
 	for (apic = 0; apic < nr_ioapics; apic++) {
-	for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
+	for (pin = 0; pin < nr_ioapic_registers(apic); pin++) {
 
 		/*
 		 * add it to the IO-APIC irq-routing table:
@@ -869,7 +980,7 @@ void __apicdebuginit print_IO_APIC(void)
 	printk(KERN_DEBUG "number of MP IRQ sources: %d.\n", mp_irq_entries);
 	for (i = 0; i < nr_ioapics; i++)
 		printk(KERN_DEBUG "number of IO-APIC #%d registers: %d.\n",
-		       mp_ioapics[i].mpc_apicid, nr_ioapic_registers[i]);
+		       mp_ioapics[i].mpc_apicid, nr_ioapic_registers(i));
 
 	/*
 	 * We are a bit conservative about what we expect.  We have to
@@ -1123,9 +1234,7 @@ void __apicdebuginit print_PIC(void)
 
 static void __init enable_IO_APIC(void)
 {
-	union IO_APIC_reg_01 reg_01;
 	int i;
-	unsigned long flags;
 
 	for (i = 0; i < PIN_MAP_SIZE; i++) {
 		irq_2_pin[i].pin = -1;
@@ -1136,16 +1245,6 @@ static void __init enable_IO_APIC(void)
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
@@ -1206,7 +1305,7 @@ void disable_IO_APIC(void)
 static void __init setup_ioapic_ids_from_mpc (void)
 {
 	union IO_APIC_reg_00 reg_00;
-	int apic;
+	int ioapic;
 	int i;
 	unsigned char old_id;
 	unsigned long flags;
@@ -1214,51 +1313,51 @@ static void __init setup_ioapic_ids_from
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
 	 */
-	for (apic = 0; apic < nr_ioapics; apic++) {
+	for (ioapic = 0; ioapic < nr_ioapics; ioapic++) {
 
 		/* Read the register 0 value */
 		spin_lock_irqsave(&ioapic_lock, flags);
-		reg_00.raw = io_apic_read(apic, 0);
+		reg_00.raw = io_apic_read(ioapic, 0);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 		
-		old_id = mp_ioapics[apic].mpc_apicid;
+		old_id = mp_ioapics[ioapic].mpc_apicid;
 
 
-		printk(KERN_INFO "Using IO-APIC %d\n", mp_ioapics[apic].mpc_apicid);
+		printk(KERN_INFO "Using IO-APIC %d\n", mp_ioapics[ioapic].mpc_apicid);
 
 
 		/*
 		 * We need to adjust the IRQ routing table
 		 * if the ID changed.
 		 */
-		if (old_id != mp_ioapics[apic].mpc_apicid)
+		if (old_id != mp_ioapics[ioapic].mpc_apicid)
 			for (i = 0; i < mp_irq_entries; i++)
 				if (mp_irqs[i].mpc_dstapic == old_id)
 					mp_irqs[i].mpc_dstapic
-						= mp_ioapics[apic].mpc_apicid;
+						= mp_ioapics[ioapic].mpc_apicid;
 
 		/*
 		 * Read the right value from the MPC table and
 		 * write it into the ID register.
 	 	 */
 		apic_printk(APIC_VERBOSE,KERN_INFO "...changing IO-APIC physical APIC ID to %d ...",
-				mp_ioapics[apic].mpc_apicid);
+				mp_ioapics[ioapic].mpc_apicid);
 
-		reg_00.bits.ID = mp_ioapics[apic].mpc_apicid;
+		reg_00.bits.ID = mp_ioapics[ioapic].mpc_apicid;
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
-		if (reg_00.bits.ID != mp_ioapics[apic].mpc_apicid)
+		if (reg_00.bits.ID != mp_ioapics[ioapic].mpc_apicid)
 			printk("could not set ID!\n");
 		else
-			apic_printk(APIC_VERBOSE," ok.\n");
+			apic_printk(APIC_VERBOSE, " ok.\n");
 	}
 }
 
@@ -1314,7 +1413,6 @@ static int __init timer_irq_works(void)
  * This is not complete - we should be able to fake
  * an edge even if it isn't on the 8259A...
  */
-
 static unsigned int startup_edge_ioapic_irq(unsigned int irq)
 {
 	int was_pending = 0;
@@ -1783,6 +1881,46 @@ static int __init notimercheck(char *s)
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
@@ -1816,25 +1954,20 @@ void __init setup_IO_APIC(void)
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
+		*(((int *)entry) + 1) = __io_apic_read(ioapic, 0x11 + 2 * i);
+		*(((int *)entry) + 0) = __io_apic_read(ioapic, 0x10 + 2 * i);
 	}
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
@@ -1844,23 +1977,23 @@ static int ioapic_suspend(struct sys_dev
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
+	reg_00.raw = __io_apic_read(ioapic, 0);
 	if (reg_00.bits.ID != mp_ioapics[dev->id].mpc_apicid) {
 		reg_00.bits.ID = mp_ioapics[dev->id].mpc_apicid;
-		io_apic_write(dev->id, 0, reg_00.raw);
+		__io_apic_write(ioapic, 0, reg_00.raw);
 	}
-	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++, entry ++ ) {
-		io_apic_write(dev->id, 0x11+2*i, *(((int *)entry)+1));
-		io_apic_write(dev->id, 0x10+2*i, *(((int *)entry)+0));
+	for (i = 0; i < ioapic_data[dev->id]->nr_registers; i ++, entry ++) {
+		__io_apic_write(ioapic, 0x11+2*i, *(((int *)entry)+1));
+		__io_apic_write(ioapic, 0x10+2*i, *(((int *)entry)+0));
 	}
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
@@ -1883,21 +2016,20 @@ static int __init ioapic_init_sysfs(void
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
@@ -2012,7 +2144,7 @@ void __init setup_ioapic_dest(void)
 		return;
 
 	for (ioapic = 0; ioapic < nr_ioapics; ioapic++) {
-		for (pin = 0; pin < nr_ioapic_registers[ioapic]; pin++) {
+		for (pin = 0; pin < nr_ioapic_registers(ioapic); pin++) {
 			irq_entry = find_irq_entry(ioapic, pin, mp_INT);
 			if (irq_entry == -1)
 				continue;
diff -urp rt12/arch/x86_64/kernel/mpparse.c rt12-kw/arch/x86_64/kernel/mpparse.c
--- rt12/arch/x86_64/kernel/mpparse.c	2005-11-01 11:31:49.000000000 +0100
+++ rt12-kw/arch/x86_64/kernel/mpparse.c	2005-11-13 23:51:26.000000000 +0100
@@ -207,6 +207,7 @@ static void __init MP_ioapic_info (struc
 		return;
 	}
 	mp_ioapics[nr_ioapics] = *m;
+	setup_IO_APIC_early(nr_ioapics);
 	nr_ioapics++;
 }
 
@@ -769,7 +770,7 @@ void __init mp_register_ioapic (
 	mp_ioapics[idx].mpc_flags = MPC_APIC_USABLE;
 	mp_ioapics[idx].mpc_apicaddr = address;
 
-	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
+	setup_IO_APIC_early(idx);
 	mp_ioapics[idx].mpc_apicid = id;
 	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
 	
diff -urp rt12/include/asm-x86_64/io_apic.h rt12-kw/include/asm-x86_64/io_apic.h
--- rt12/include/asm-x86_64/io_apic.h	2005-11-13 23:49:32.000000000 +0100
+++ rt12-kw/include/asm-x86_64/io_apic.h	2005-11-13 23:51:26.000000000 +0100
@@ -103,7 +103,6 @@ union IO_APIC_reg_03 {
  * # of IO-APICs and # of IRQ routing registers
  */
 extern int nr_ioapics;
-extern int nr_ioapic_registers[MAX_IO_APICS];
 
 enum ioapic_irq_destination_types {
 	dest_Fixed = 0,
@@ -160,27 +159,6 @@ extern struct mpc_config_intsrc mp_irqs[
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
@@ -205,7 +183,7 @@ extern int io_apic_get_redir_entries (in
 extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int, int);
 #endif
 
-extern int sis_apic_bug; /* dummy */ 
+extern void setup_IO_APIC_early(int ioapic);
 
 #else  /* !CONFIG_X86_IO_APIC */
 #define io_apic_assign_pci_irqs 0
diff -urp rt12/drivers/pci/quirks.c rt12-kw/drivers/pci/quirks.c
--- rt12/drivers/pci/quirks.c	2005-11-01 11:31:51.000000000 +0100
+++ rt12-kw/drivers/pci/quirks.c	2005-11-13 23:51:26.000000000 +0100
@@ -543,12 +543,14 @@ static void __devinit quirk_amd_ioapic(s
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
 
diff -urp rt12/kernel/irq/spurious.c rt12-kw/kernel/irq/spurious.c
--- rt12/kernel/irq/spurious.c	2005-11-13 23:49:33.000000000 +0100
+++ rt12-kw/kernel/irq/spurious.c	2005-11-13 23:51:26.000000000 +0100
@@ -164,11 +164,13 @@ void note_interrupt(unsigned int irq, ir
 		 * The interrupt is stuck
 		 */
 		__report_bad_irq(irq, desc, action_ret);
-#ifdef CONFIG_X86_IO_APIC
-		if (!sis_apic_bug) {
-			sis_apic_bug = 1;
-			printk(KERN_ERR "turning off IO-APIC fast mode.\n");
-		}
+#ifndef CONFIG_X86_64
+# ifdef CONFIG_X86_IO_APIC
+ 		if (!sis_apic_bug) {
+ 			sis_apic_bug = 1;
+ 			printk(KERN_ERR "turning off IO-APIC fast mode.\n");
+ 		}
+# endif
 #else
 		/*
 		 * Now kill the IRQ

--Boundary-00=_4deiDy6v+QkOSfI--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
