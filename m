Return-Path: <linux-kernel-owner+w=401wt.eu-S965106AbXAJVUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbXAJVUx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbXAJVUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:20:53 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:35647 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965106AbXAJVUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:20:47 -0500
Date: Wed, 10 Jan 2007 13:26:07 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.19.2
Message-ID: <20070110212607.GK10475@sequoia.sous-sol.org>
References: <20070110212530.GJ10475@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110212530.GJ10475@sequoia.sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 6b53c75..b0a32c2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 19
-EXTRAVERSION = .1
+EXTRAVERSION = .2
 NAME=Avast! A bilge rat!
 
 # *DOCUMENTATION*
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 3173924..e8f7436 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -331,6 +331,19 @@
 		CALL(sys_mbind)
 /* 320 */	CALL(sys_get_mempolicy)
 		CALL(sys_set_mempolicy)
+		CALL(sys_openat)
+		CALL(sys_mkdirat)
+		CALL(sys_mknodat)
+/* 325 */	CALL(sys_fchownat)
+		CALL(sys_futimesat)
+		CALL(sys_fstatat64)
+		CALL(sys_unlinkat)
+		CALL(sys_renameat)
+/* 330 */	CALL(sys_linkat)
+		CALL(sys_symlinkat)
+		CALL(sys_readlinkat)
+		CALL(sys_fchmodat)
+		CALL(sys_faccessat)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index a60358f..44a5535 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -784,7 +784,11 @@ static int apm_do_idle(void)
 	polling = !!(current_thread_info()->status & TS_POLLING);
 	if (polling) {
 		current_thread_info()->status &= ~TS_POLLING;
-		smp_mb__after_clear_bit();
+		/*
+		 * TS_POLLING-cleared state must be visible before we
+		 * test NEED_RESCHED:
+		 */
+		smp_mb();
 	}
 	if (!need_resched()) {
 		idled = 1;
diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
index dd53c58..304b261 100644
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -103,7 +103,12 @@ void default_idle(void)
 
 	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
 		current_thread_info()->status &= ~TS_POLLING;
-		smp_mb__after_clear_bit();
+		/*
+		 * TS_POLLING-cleared state must be visible before we
+		 * test NEED_RESCHED:
+		 */
+		smp_mb();
+
 		while (!need_resched()) {
 			local_irq_disable();
 			if (!need_resched())
diff --git a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
index 4bb8b77..b5f562e 100644
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -1095,7 +1095,7 @@ static int __cpuinit __smp_prepare_cpu(int cpu)
 
 	/* init low mem mapping */
 	clone_pgd_range(swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
-			KERNEL_PGD_PTRS);
+			min_t(unsigned long, KERNEL_PGD_PTRS, USER_PGD_PTRS));
 	flush_tlb_all();
 	schedule_work(&task);
 	wait_for_completion(&done);
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 51922b9..17685ab 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -268,10 +268,16 @@ cpu_idle (void)
 
 	/* endless idle loop with no priority at all */
 	while (1) {
-		if (can_do_pal_halt)
+		if (can_do_pal_halt) {
 			current_thread_info()->status &= ~TS_POLLING;
-		else
+			/*
+			 * TS_POLLING-cleared state must be visible before we
+			 * test NEED_RESCHED:
+			 */
+			smp_mb();
+		} else {
 			current_thread_info()->status |= TS_POLLING;
+		}
 
 		if (!need_resched()) {
 			void (*idle)(void);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 54d51b4..7efb262 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -728,7 +728,8 @@ int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg, int nents,
 	/* IIep is write-through, not flushing. */
 	for (n = 0; n < nents; n++) {
 		BUG_ON(page_address(sg->page) == NULL);
-		sg->dvma_address = virt_to_phys(page_address(sg->page));
+		sg->dvma_address =
+			virt_to_phys(page_address(sg->page)) + sg->offset;
 		sg->dvma_length = sg->length;
 		sg++;
 	}
diff --git a/arch/sparc64/kernel/isa.c b/arch/sparc64/kernel/isa.c
index f028e68..fc7ca6d 100644
--- a/arch/sparc64/kernel/isa.c
+++ b/arch/sparc64/kernel/isa.c
@@ -22,14 +22,15 @@ static void __init report_dev(struct sparc_isa_device *isa_dev, int child)
 		printk(" [%s", isa_dev->prom_node->name);
 }
 
-static struct linux_prom_registers * __init
-isa_dev_get_resource(struct sparc_isa_device *isa_dev)
+static void __init isa_dev_get_resource(struct sparc_isa_device *isa_dev)
 {
 	struct linux_prom_registers *pregs;
 	unsigned long base, len;
 	int prop_len;
 
 	pregs = of_get_property(isa_dev->prom_node, "reg", &prop_len);
+	if (!pregs)
+		return;
 
 	/* Only the first one is interesting. */
 	len = pregs[0].reg_size;
@@ -44,12 +45,9 @@ isa_dev_get_resource(struct sparc_isa_device *isa_dev)
 
 	request_resource(&isa_dev->bus->parent->io_space,
 			 &isa_dev->resource);
-
-	return pregs;
 }
 
-static void __init isa_dev_get_irq(struct sparc_isa_device *isa_dev,
-				   struct linux_prom_registers *pregs)
+static void __init isa_dev_get_irq(struct sparc_isa_device *isa_dev)
 {
 	struct of_device *op = of_find_device_by_node(isa_dev->prom_node);
 
@@ -69,7 +67,6 @@ static void __init isa_fill_children(struct sparc_isa_device *parent_isa_dev)
 
 	printk(" ->");
 	while (dp) {
-		struct linux_prom_registers *regs;
 		struct sparc_isa_device *isa_dev;
 
 		isa_dev = kmalloc(sizeof(*isa_dev), GFP_KERNEL);
@@ -87,8 +84,8 @@ static void __init isa_fill_children(struct sparc_isa_device *parent_isa_dev)
 		isa_dev->bus = parent_isa_dev->bus;
 		isa_dev->prom_node = dp;
 
-		regs = isa_dev_get_resource(isa_dev);
-		isa_dev_get_irq(isa_dev, regs);
+		isa_dev_get_resource(isa_dev);
+		isa_dev_get_irq(isa_dev);
 
 		report_dev(isa_dev, 1);
 
@@ -101,7 +98,6 @@ static void __init isa_fill_devices(struct sparc_isa_bridge *isa_br)
 	struct device_node *dp = isa_br->prom_node->child;
 
 	while (dp) {
-		struct linux_prom_registers *regs;
 		struct sparc_isa_device *isa_dev;
 
 		isa_dev = kmalloc(sizeof(*isa_dev), GFP_KERNEL);
@@ -141,8 +137,8 @@ static void __init isa_fill_devices(struct sparc_isa_bridge *isa_br)
 		isa_dev->bus = isa_br;
 		isa_dev->prom_node = dp;
 
-		regs = isa_dev_get_resource(isa_dev);
-		isa_dev_get_irq(isa_dev, regs);
+		isa_dev_get_resource(isa_dev);
+		isa_dev_get_irq(isa_dev);
 
 		report_dev(isa_dev, 0);
 
diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 09cb7fc..ab6d0ca 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -872,6 +872,115 @@ static unsigned long __init choose_bootmap_pfn(unsigned long start_pfn,
 	prom_halt();
 }
 
+static void __init trim_pavail(unsigned long *cur_size_p,
+			       unsigned long *end_of_phys_p)
+{
+	unsigned long to_trim = *cur_size_p - cmdline_memory_size;
+	unsigned long avoid_start, avoid_end;
+	int i;
+
+	to_trim = PAGE_ALIGN(to_trim);
+
+	avoid_start = avoid_end = 0;
+#ifdef CONFIG_BLK_DEV_INITRD
+	avoid_start = initrd_start;
+	avoid_end = PAGE_ALIGN(initrd_end);
+#endif
+
+	/* Trim some pavail[] entries in order to satisfy the
+	 * requested "mem=xxx" kernel command line specification.
+	 *
+	 * We must not trim off the kernel image area nor the
+	 * initial ramdisk range (if any).  Also, we must not trim
+	 * any pavail[] entry down to zero in order to preserve
+	 * the invariant that all pavail[] entries have a non-zero
+	 * size which is assumed by all of the code in here.
+	 */
+	for (i = 0; i < pavail_ents; i++) {
+		unsigned long start, end, kern_end;
+		unsigned long trim_low, trim_high, n;
+
+		kern_end = PAGE_ALIGN(kern_base + kern_size);
+
+		trim_low = start = pavail[i].phys_addr;
+		trim_high = end = start + pavail[i].reg_size;
+
+		if (kern_base >= start &&
+		    kern_base < end) {
+			trim_low = kern_base;
+			if (kern_end >= end)
+				continue;
+		}
+		if (kern_end >= start &&
+		    kern_end < end) {
+			trim_high = kern_end;
+		}
+		if (avoid_start &&
+		    avoid_start >= start &&
+		    avoid_start < end) {
+			if (trim_low > avoid_start)
+				trim_low = avoid_start;
+			if (avoid_end >= end)
+				continue;
+		}
+		if (avoid_end &&
+		    avoid_end >= start &&
+		    avoid_end < end) {
+			if (trim_high < avoid_end)
+				trim_high = avoid_end;
+		}
+
+		if (trim_high <= trim_low)
+			continue;
+
+		if (trim_low == start && trim_high == end) {
+			/* Whole chunk is available for trimming.
+			 * Trim all except one page, in order to keep
+			 * entry non-empty.
+			 */
+			n = (end - start) - PAGE_SIZE;
+			if (n > to_trim)
+				n = to_trim;
+
+			if (n) {
+				pavail[i].phys_addr += n;
+				pavail[i].reg_size -= n;
+				to_trim -= n;
+			}
+		} else {
+			n = (trim_low - start);
+			if (n > to_trim)
+				n = to_trim;
+
+			if (n) {
+				pavail[i].phys_addr += n;
+				pavail[i].reg_size -= n;
+				to_trim -= n;
+			}
+			if (to_trim) {
+				n = end - trim_high;
+				if (n > to_trim)
+					n = to_trim;
+				if (n) {
+					pavail[i].reg_size -= n;
+					to_trim -= n;
+				}
+			}
+		}
+
+		if (!to_trim)
+			break;
+	}
+
+	/* Recalculate.  */
+	*cur_size_p = 0UL;
+	for (i = 0; i < pavail_ents; i++) {
+		*end_of_phys_p = pavail[i].phys_addr +
+			pavail[i].reg_size;
+		*cur_size_p += pavail[i].reg_size;
+	}
+}
+
 static unsigned long __init bootmem_init(unsigned long *pages_avail,
 					 unsigned long phys_base)
 {
@@ -889,31 +998,13 @@ static unsigned long __init bootmem_init(unsigned long *pages_avail,
 		end_of_phys_memory = pavail[i].phys_addr +
 			pavail[i].reg_size;
 		bytes_avail += pavail[i].reg_size;
-		if (cmdline_memory_size) {
-			if (bytes_avail > cmdline_memory_size) {
-				unsigned long slack = bytes_avail - cmdline_memory_size;
-
-				bytes_avail -= slack;
-				end_of_phys_memory -= slack;
-
-				pavail[i].reg_size -= slack;
-				if ((long)pavail[i].reg_size <= 0L) {
-					pavail[i].phys_addr = 0xdeadbeefUL;
-					pavail[i].reg_size = 0UL;
-					pavail_ents = i;
-				} else {
-					pavail[i+1].reg_size = 0Ul;
-					pavail[i+1].phys_addr = 0xdeadbeefUL;
-					pavail_ents = i + 1;
-				}
-				break;
-			}
-		}
 	}
 
-	*pages_avail = bytes_avail >> PAGE_SHIFT;
-
-	end_pfn = end_of_phys_memory >> PAGE_SHIFT;
+	/* Determine the location of the initial ramdisk before trying
+	 * to honor the "mem=xxx" command line argument.  We must know
+	 * where the kernel image and the ramdisk image are so that we
+	 * do not trim those two areas from the physical memory map.
+	 */
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Now have to check initial ramdisk, so that bootmap does not overwrite it */
@@ -932,6 +1023,16 @@ static unsigned long __init bootmem_init(unsigned long *pages_avail,
 		}
 	}
 #endif	
+
+	if (cmdline_memory_size &&
+	    bytes_avail > cmdline_memory_size)
+		trim_pavail(&bytes_avail,
+			    &end_of_phys_memory);
+
+	*pages_avail = bytes_avail >> PAGE_SHIFT;
+
+	end_pfn = end_of_phys_memory >> PAGE_SHIFT;
+
 	/* Initialize the boot-time allocator. */
 	max_pfn = max_low_pfn = end_pfn;
 	min_low_pfn = (phys_base >> PAGE_SHIFT);
diff --git a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
index 7451a4c..bbab3f2 100644
--- a/arch/x86_64/kernel/process.c
+++ b/arch/x86_64/kernel/process.c
@@ -111,7 +111,11 @@ static void default_idle(void)
 	local_irq_enable();
 
 	current_thread_info()->status &= ~TS_POLLING;
-	smp_mb__after_clear_bit();
+	/*
+	 * TS_POLLING-cleared state must be visible before we
+	 * test NEED_RESCHED:
+	 */
+	smp_mb();
 	while (!need_resched()) {
 		local_irq_disable();
 		if (!need_resched())
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index fc944b5..013539f 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -854,7 +854,10 @@ static void __cpuinit init_intel(struct cpuinfo_x86 *c)
 		set_bit(X86_FEATURE_CONSTANT_TSC, &c->x86_capability);
 	if (c->x86 == 6)
 		set_bit(X86_FEATURE_REP_GOOD, &c->x86_capability);
-	set_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
+	if (c->x86 == 15)
+		set_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
+	else
+		clear_bit(X86_FEATURE_SYNC_RDTSC, &c->x86_capability);
  	c->x86_max_cores = intel_num_cpu_cores(c);
 
 	srat_detect_node();
diff --git a/crypto/sha512.c b/crypto/sha512.c
index 2dfe7f1..15eab9d 100644
--- a/crypto/sha512.c
+++ b/crypto/sha512.c
@@ -24,7 +24,7 @@
 
 #define SHA384_DIGEST_SIZE 48
 #define SHA512_DIGEST_SIZE 64
-#define SHA384_HMAC_BLOCK_SIZE  96
+#define SHA384_HMAC_BLOCK_SIZE 128
 #define SHA512_HMAC_BLOCK_SIZE 128
 
 struct sha512_ctx {
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 65b3f05..6dac605 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -211,7 +211,11 @@ acpi_processor_power_activate(struct acpi_processor *pr,
 static void acpi_safe_halt(void)
 {
 	current_thread_info()->status &= ~TS_POLLING;
-	smp_mb__after_clear_bit();
+	/*
+	 * TS_POLLING-cleared state must be visible before we
+	 * test NEED_RESCHED:
+	 */
+	smp_mb();
 	if (!need_resched())
 		safe_halt();
 	current_thread_info()->status |= TS_POLLING;
@@ -345,7 +349,11 @@ static void acpi_processor_idle(void)
 	 */
 	if (cx->type == ACPI_STATE_C2 || cx->type == ACPI_STATE_C3) {
 		current_thread_info()->status &= ~TS_POLLING;
-		smp_mb__after_clear_bit();
+		/*
+		 * TS_POLLING-cleared state must be visible before we
+		 * test NEED_RESCHED:
+		 */
+		smp_mb();
 		if (need_resched()) {
 			current_thread_info()->status |= TS_POLLING;
 			local_irq_enable();
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 915a55a..ff8a690 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2325,11 +2325,14 @@ static inline void ata_tf_to_host(struct ata_port *ap,
  *	Sleep until ATA Status register bit BSY clears,
  *	or a timeout occurs.
  *
- *	LOCKING: None.
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
  */
-
-unsigned int ata_busy_sleep (struct ata_port *ap,
-			     unsigned long tmout_pat, unsigned long tmout)
+int ata_busy_sleep(struct ata_port *ap,
+		   unsigned long tmout_pat, unsigned long tmout)
 {
 	unsigned long timer_start, timeout;
 	u8 status;
@@ -2337,27 +2340,32 @@ unsigned int ata_busy_sleep (struct ata_port *ap,
 	status = ata_busy_wait(ap, ATA_BUSY, 300);
 	timer_start = jiffies;
 	timeout = timer_start + tmout_pat;
-	while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
+	while (status != 0xff && (status & ATA_BUSY) &&
+	       time_before(jiffies, timeout)) {
 		msleep(50);
 		status = ata_busy_wait(ap, ATA_BUSY, 3);
 	}
 
-	if (status & ATA_BUSY)
+	if (status != 0xff && (status & ATA_BUSY))
 		ata_port_printk(ap, KERN_WARNING,
 				"port is slow to respond, please be patient "
 				"(Status 0x%x)\n", status);
 
 	timeout = timer_start + tmout;
-	while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
+	while (status != 0xff && (status & ATA_BUSY) &&
+	       time_before(jiffies, timeout)) {
 		msleep(50);
 		status = ata_chk_status(ap);
 	}
 
+	if (status == 0xff)
+		return -ENODEV;
+
 	if (status & ATA_BUSY) {
 		ata_port_printk(ap, KERN_ERR, "port failed to respond "
 				"(%lu secs, Status 0x%x)\n",
 				tmout / HZ, status);
-		return 1;
+		return -EBUSY;
 	}
 
 	return 0;
@@ -2448,10 +2456,8 @@ static unsigned int ata_bus_softreset(struct ata_port *ap,
 	 * the bus shows 0xFF because the odd clown forgets the D7
 	 * pulldown resistor.
 	 */
-	if (ata_check_status(ap) == 0xFF) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
-		return AC_ERR_OTHER;
-	}
+	if (ata_check_status(ap) == 0xFF)
+		return 0;
 
 	ata_bus_post_reset(ap, devmask);
 
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 8a13b1a..85a4cb3 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -30,8 +30,6 @@ new_skb(ulong len)
 		skb->nh.raw = skb->mac.raw = skb->data;
 		skb->protocol = __constant_htons(ETH_P_AOE);
 		skb->priority = 0;
-		skb_put(skb, len);
-		memset(skb->head, 0, len);
 		skb->next = skb->prev = NULL;
 
 		/* tell the network layer not to perform IP checksums
@@ -122,8 +120,8 @@ aoecmd_ata_rw(struct aoedev *d, struct frame *f)
 	skb = f->skb;
 	h = (struct aoe_hdr *) skb->mac.raw;
 	ah = (struct aoe_atahdr *) (h+1);
-	skb->len = sizeof *h + sizeof *ah;
-	memset(h, 0, ETH_ZLEN);
+	skb_put(skb, sizeof *h + sizeof *ah);
+	memset(h, 0, skb->len);
 	f->tag = aoehdr_atainit(d, h);
 	f->waited = 0;
 	f->buf = buf;
@@ -149,7 +147,6 @@ aoecmd_ata_rw(struct aoedev *d, struct frame *f)
 		skb->len += bcnt;
 		skb->data_len = bcnt;
 	} else {
-		skb->len = ETH_ZLEN;
 		writebit = 0;
 	}
 
@@ -206,6 +203,7 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff **tail)
 			printk(KERN_INFO "aoe: skb alloc failure\n");
 			continue;
 		}
+		skb_put(skb, sizeof *h + sizeof *ch);
 		skb->dev = ifp;
 		if (sl_tail == NULL)
 			sl_tail = skb;
@@ -243,6 +241,7 @@ freeframe(struct aoedev *d)
 			continue;
 		if (atomic_read(&skb_shinfo(f->skb)->dataref) == 1) {
 			skb_shinfo(f->skb)->nr_frags = f->skb->data_len = 0;
+			skb_trim(f->skb, 0);
 			return f;
 		}
 		n++;
@@ -698,8 +697,8 @@ aoecmd_ata_id(struct aoedev *d)
 	skb = f->skb;
 	h = (struct aoe_hdr *) skb->mac.raw;
 	ah = (struct aoe_atahdr *) (h+1);
-	skb->len = ETH_ZLEN;
-	memset(h, 0, ETH_ZLEN);
+	skb_put(skb, sizeof *h + sizeof *ah);
+	memset(h, 0, skb->len);
 	f->tag = aoehdr_atainit(d, h);
 	f->waited = 0;
 
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 4105c3b..95df5bf 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -2530,7 +2530,7 @@ static void do_cciss_request(request_queue_t *q)
 	c->Request.Type.Type = TYPE_CMD;	// It is a command.
 	c->Request.Type.Attribute = ATTR_SIMPLE;
 	c->Request.Type.Direction =
-	    (rq_data_dir(creq) == READ) ? h->cciss_read : h->cciss_write;
+	    (rq_data_dir(creq) == READ) ? XFER_READ : XFER_WRITE;
 	c->Request.Timeout = 0;	// Don't time out
 	c->Request.CDB[0] =
 	    (rq_data_dir(creq) == READ) ? h->cciss_read : h->cciss_write;
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 5547337..149a1ff 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -646,7 +646,8 @@ static inline size_t read_zero_pagealigned(char __user * buf, size_t size)
 			count = size;
 
 		zap_page_range(vma, addr, count, NULL);
-        	zeromap_page_range(vma, addr, count, PAGE_COPY);
+        	if (zeromap_page_range(vma, addr, count, PAGE_COPY))
+			break;
 
 		size -= count;
 		buf += count;
@@ -713,11 +714,14 @@ out:
 
 static int mmap_zero(struct file * file, struct vm_area_struct * vma)
 {
+	int err;
+
 	if (vma->vm_flags & VM_SHARED)
 		return shmem_zero_setup(vma);
-	if (zeromap_page_range(vma, vma->vm_start, vma->vm_end - vma->vm_start, vma->vm_page_prot))
-		return -EAGAIN;
-	return 0;
+	err = zeromap_page_range(vma, vma->vm_start,
+			vma->vm_end - vma->vm_start, vma->vm_page_prot);
+	BUG_ON(err == -EEXIST);
+	return err;
 }
 #else /* CONFIG_MMU */
 static ssize_t read_zero(struct file * file, char * buf, 
diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 3ece692..5c9f67f 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/connector.h>
 #include <asm/atomic.h>
+#include <asm/unaligned.h>
 
 #include <linux/cn_proc.h>
 
@@ -60,7 +61,7 @@ void proc_fork_connector(struct task_struct *task)
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *)&ev->timestamp_ns);
 	ev->what = PROC_EVENT_FORK;
 	ev->event_data.fork.parent_pid = task->real_parent->pid;
 	ev->event_data.fork.parent_tgid = task->real_parent->tgid;
@@ -88,7 +89,7 @@ void proc_exec_connector(struct task_struct *task)
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *)&ev->timestamp_ns);
 	ev->what = PROC_EVENT_EXEC;
 	ev->event_data.exec.process_pid = task->pid;
 	ev->event_data.exec.process_tgid = task->tgid;
@@ -124,7 +125,7 @@ void proc_id_connector(struct task_struct *task, int which_id)
 	     	return;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *)&ev->timestamp_ns);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
@@ -146,7 +147,7 @@ void proc_exit_connector(struct task_struct *task)
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *)&ev->timestamp_ns);
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
@@ -181,7 +182,7 @@ static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
 	ev = (struct proc_event*)msg->data;
 	msg->seq = rcvd_seq;
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *)&ev->timestamp_ns);
 	ev->cpu = -1;
 	ev->what = PROC_EVENT_NONE;
 	ev->event_data.ack.err = err;
diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
index 93d483b..ec17d6b 100644
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -347,13 +347,19 @@ static void ds1337_init_client(struct i2c_client *client)
 
 	if ((status & 0x80) || (control & 0x80)) {
 		/* RTC not running */
-		u8 buf[16];
+		u8 buf[1+16];	/* First byte is interpreted as address */
 		struct i2c_msg msg[1];
 
 		dev_dbg(&client->dev, "%s: RTC not running!\n", __FUNCTION__);
 
 		/* Initialize all, including STATUS and CONTROL to zero */
 		memset(buf, 0, sizeof(buf));
+
+		/* Write valid values in the date/time registers */
+		buf[1+DS1337_REG_DAY] = 1;
+		buf[1+DS1337_REG_DATE] = 1;
+		buf[1+DS1337_REG_MONTH] = 1;
+
 		msg[0].addr = client->addr;
 		msg[0].flags = 0;
 		msg[0].len = sizeof(buf);
diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
index 6e8ea91..268f282 100644
--- a/drivers/ieee1394/ohci1394.c
+++ b/drivers/ieee1394/ohci1394.c
@@ -3217,6 +3217,19 @@ static int __devinit ohci1394_pci_probe(struct pci_dev *dev,
 	struct ti_ohci *ohci;	/* shortcut to currently handled device */
 	resource_size_t ohci_base;
 
+#ifdef CONFIG_PPC_PMAC
+	/* Necessary on some machines if ohci1394 was loaded/ unloaded before */
+	if (machine_is(powermac)) {
+		struct device_node *of_node = pci_device_to_OF_node(dev);
+
+		if (of_node) {
+			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, of_node,
+					  0, 1);
+			pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 1);
+		}
+	}
+#endif /* CONFIG_PPC_PMAC */
+
         if (pci_enable_device(dev))
 		FAIL(-ENXIO, "Failed to enable OHCI hardware");
         pci_set_master(dev);
@@ -3505,11 +3518,9 @@ static void ohci1394_pci_remove(struct pci_dev *pdev)
 #endif
 
 #ifdef CONFIG_PPC_PMAC
-	/* On UniNorth, power down the cable and turn off the chip
-	 * clock when the module is removed to save power on
-	 * laptops. Turning it back ON is done by the arch code when
-	 * pci_enable_device() is called */
-	{
+	/* On UniNorth, power down the cable and turn off the chip clock
+	 * to save power on laptops */
+	if (machine_is(powermac)) {
 		struct device_node* of_node;
 
 		of_node = pci_device_to_OF_node(ohci->dev);
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 4b09147..ca44cc6 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1879,7 +1879,7 @@ static void srp_add_one(struct ib_device *device)
 	 */
 	srp_dev->fmr_page_shift = max(9, ffs(dev_attr->page_size_cap) - 1);
 	srp_dev->fmr_page_size  = 1 << srp_dev->fmr_page_shift;
-	srp_dev->fmr_page_mask  = ~((unsigned long) srp_dev->fmr_page_size - 1);
+	srp_dev->fmr_page_mask  = ~((u64) srp_dev->fmr_page_size - 1);
 
 	INIT_LIST_HEAD(&srp_dev->dev_list);
 
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index d4e35ef..1e140bb 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -87,7 +87,7 @@ struct srp_device {
 	struct ib_fmr_pool     *fmr_pool;
 	int			fmr_page_shift;
 	int			fmr_page_size;
-	unsigned long		fmr_page_mask;
+	u64			fmr_page_mask;
 };
 
 struct srp_host {
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index c92c152..4540ade 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -215,6 +215,7 @@ config DM_CRYPT
 	tristate "Crypt target support"
 	depends on BLK_DEV_DM && EXPERIMENTAL
 	select CRYPTO
+	select CRYPTO_CBC
 	---help---
 	  This device-mapper target allows you to create a device that
 	  transparently encrypts the data on it. You'll need to activate
diff --git a/drivers/media/dvb/dvb-core/dvb_net.c b/drivers/media/dvb/dvb-core/dvb_net.c
index 8859ab7..ee23125 100644
--- a/drivers/media/dvb/dvb-core/dvb_net.c
+++ b/drivers/media/dvb/dvb-core/dvb_net.c
@@ -604,7 +604,7 @@ static void dvb_net_ule( struct net_device *dev, const u8 *buf, size_t buf_len )
 				{ &utype, sizeof utype },
 				{ priv->ule_skb->data, priv->ule_skb->len - 4 }
 			};
-			unsigned long ule_crc = ~0L, expected_crc;
+			u32 ule_crc = ~0L, expected_crc;
 			if (priv->ule_dbit) {
 				/* Set D-bit for CRC32 verification,
 				 * if it was set originally. */
@@ -617,7 +617,7 @@ static void dvb_net_ule( struct net_device *dev, const u8 *buf, size_t buf_len )
 				       *((u8 *)priv->ule_skb->tail - 2) << 8 |
 				       *((u8 *)priv->ule_skb->tail - 1);
 			if (ule_crc != expected_crc) {
-				printk(KERN_WARNING "%lu: CRC32 check FAILED: %#lx / %#lx, SNDU len %d type %#x, ts_remain %d, next 2: %x.\n",
+				printk(KERN_WARNING "%lu: CRC32 check FAILED: %08x / %08x, SNDU len %d type %#x, ts_remain %d, next 2: %x.\n",
 				       priv->ts_count, ule_crc, expected_crc, priv->ule_sndu_len, priv->ule_sndu_type, ts_remain, ts_remain > 2 ? *(unsigned short *)from_where : 0);
 
 #ifdef ULE_DEBUG
diff --git a/drivers/media/dvb/frontends/lgdt330x.c b/drivers/media/dvb/frontends/lgdt330x.c
index 9a35470..467f199 100644
--- a/drivers/media/dvb/frontends/lgdt330x.c
+++ b/drivers/media/dvb/frontends/lgdt330x.c
@@ -435,9 +435,6 @@ static int lgdt3302_read_status(struct dvb_frontend* fe, fe_status_t* status)
 		/* Test signal does not exist flag */
 		/* as well as the AGC lock flag.   */
 		*status |= FE_HAS_SIGNAL;
-	} else {
-		/* Without a signal all other status bits are meaningless */
-		return 0;
 	}
 
 	/*
@@ -500,9 +497,6 @@ static int lgdt3303_read_status(struct dvb_frontend* fe, fe_status_t* status)
 		/* Test input signal does not exist flag */
 		/* as well as the AGC lock flag.   */
 		*status |= FE_HAS_SIGNAL;
-	} else {
-		/* Without a signal all other status bits are meaningless */
-		return 0;
 	}
 
 	/* Carrier Recovery Lock Status Register */
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index f764a57..dec146f 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1610,7 +1610,7 @@ const unsigned int cx88_idcount = ARRAY_SIZE(cx88_subids);
 /* ----------------------------------------------------------------------- */
 /* some leadtek specific stuff                                             */
 
-static void __devinit leadtek_eeprom(struct cx88_core *core, u8 *eeprom_data)
+static void leadtek_eeprom(struct cx88_core *core, u8 *eeprom_data)
 {
 	/* This is just for the "Winfast 2000XP Expert" board ATM; I don't have data on
 	 * any others.
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index 63db4e9..fcf8693 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -108,6 +108,7 @@ static int tuner_stereo(struct i2c_client *c)
 		case TUNER_PHILIPS_FM1216ME_MK3:
 		case TUNER_PHILIPS_FM1236_MK3:
 		case TUNER_PHILIPS_FM1256_IH3:
+		case TUNER_LG_NTSC_TAPE:
 			stereo = ((status & TUNER_SIGNAL) == TUNER_STEREO_MK3);
 			break;
 		default:
@@ -421,6 +422,7 @@ static void default_set_radio_freq(struct i2c_client *c, unsigned int freq)
 	case TUNER_PHILIPS_FM1216ME_MK3:
 	case TUNER_PHILIPS_FM1236_MK3:
 	case TUNER_PHILIPS_FMD1216ME_MK3:
+	case TUNER_LG_NTSC_TAPE:
 		buffer[3] = 0x19;
 		break;
 	case TUNER_TNF_5335MF:
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index 7816823..1256c64 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -672,16 +672,6 @@ static struct tuner_params tuner_panasonic_vp27_params[] = {
 	},
 };
 
-/* ------------ TUNER_LG_NTSC_TAPE - LGINNOTEK NTSC ------------ */
-
-static struct tuner_params tuner_lg_ntsc_tape_params[] = {
-	{
-		.type   = TUNER_PARAM_TYPE_NTSC,
-		.ranges = tuner_fm1236_mk3_ntsc_ranges,
-		.count  = ARRAY_SIZE(tuner_fm1236_mk3_ntsc_ranges),
-	},
-};
-
 /* ------------ TUNER_TNF_8831BGFF - Philips PAL ------------ */
 
 static struct tuner_range tuner_tnf_8831bgff_pal_ranges[] = {
@@ -1331,8 +1321,8 @@ struct tunertype tuners[] = {
 	},
 	[TUNER_LG_NTSC_TAPE] = { /* LGINNOTEK NTSC */
 		.name   = "LG NTSC (TAPE series)",
-		.params = tuner_lg_ntsc_tape_params,
-		.count  = ARRAY_SIZE(tuner_lg_ntsc_tape_params),
+		.params = tuner_fm1236_mk3_params,
+		.count  = ARRAY_SIZE(tuner_fm1236_mk3_params),
 	},
 	[TUNER_TNF_8831BGFF] = { /* Philips PAL */
 		.name   = "Tenna TNF 8831 BGFF)",
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 17a4611..946303b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3675,7 +3675,7 @@ static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd
 			mii->val_out = 0;
 			read_lock_bh(&bond->lock);
 			read_lock(&bond->curr_slave_lock);
-			if (bond->curr_active_slave) {
+			if (netif_carrier_ok(bond->dev)) {
 				mii->val_out = BMSR_LSTATUS;
 			}
 			read_unlock(&bond->curr_slave_lock);
diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index 2c43433..797ab91 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -1331,7 +1331,7 @@ smc911x_rx_dma_irq(int dma, void *data)
 static void smc911x_poll_controller(struct net_device *dev)
 {
 	disable_irq(dev->irq);
-	smc911x_interrupt(dev->irq, dev, NULL);
+	smc911x_interrupt(dev->irq, dev);
 	enable_irq(dev->irq);
 }
 #endif
diff --git a/drivers/net/wireless/zd1211rw/zd_ieee80211.h b/drivers/net/wireless/zd1211rw/zd_ieee80211.h
index f63245b..3632989 100644
--- a/drivers/net/wireless/zd1211rw/zd_ieee80211.h
+++ b/drivers/net/wireless/zd1211rw/zd_ieee80211.h
@@ -64,7 +64,7 @@ struct cck_plcp_header {
 	u8 service;
 	__le16 length;
 	__le16 crc16;
-};
+} __attribute__((packed));
 
 static inline u8 zd_cck_plcp_header_rate(const struct cck_plcp_header *header)
 {
diff --git a/drivers/net/wireless/zd1211rw/zd_mac.c b/drivers/net/wireless/zd1211rw/zd_mac.c
index a7d29bd..9ab3077 100644
--- a/drivers/net/wireless/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zd1211rw/zd_mac.c
@@ -37,6 +37,8 @@ static void housekeeping_init(struct zd_mac *mac);
 static void housekeeping_enable(struct zd_mac *mac);
 static void housekeeping_disable(struct zd_mac *mac);
 
+static void do_rx(unsigned long mac_ptr);
+
 int zd_mac_init(struct zd_mac *mac,
 	        struct net_device *netdev,
 	        struct usb_interface *intf)
@@ -47,6 +49,10 @@ int zd_mac_init(struct zd_mac *mac,
 	spin_lock_init(&mac->lock);
 	mac->netdev = netdev;
 
+	skb_queue_head_init(&mac->rx_queue);
+	tasklet_init(&mac->rx_tasklet, do_rx, (unsigned long)mac);
+	tasklet_disable(&mac->rx_tasklet);
+
 	ieee_init(ieee);
 	softmac_init(ieee80211_priv(netdev));
 	zd_chip_init(&mac->chip, netdev, intf);
@@ -132,6 +138,8 @@ out:
 
 void zd_mac_clear(struct zd_mac *mac)
 {
+	skb_queue_purge(&mac->rx_queue);
+	tasklet_kill(&mac->rx_tasklet);
 	zd_chip_clear(&mac->chip);
 	ZD_ASSERT(!spin_is_locked(&mac->lock));
 	ZD_MEMCLEAR(mac, sizeof(struct zd_mac));
@@ -160,6 +168,8 @@ int zd_mac_open(struct net_device *netdev)
 	struct zd_chip *chip = &mac->chip;
 	int r;
 
+	tasklet_enable(&mac->rx_tasklet);
+
 	r = zd_chip_enable_int(chip);
 	if (r < 0)
 		goto out;
@@ -210,6 +220,8 @@ int zd_mac_stop(struct net_device *netdev)
 	 */
 
 	zd_chip_disable_rx(chip);
+	skb_queue_purge(&mac->rx_queue);
+	tasklet_disable(&mac->rx_tasklet);
 	housekeeping_disable(mac);
 	ieee80211softmac_stop(netdev);
 
@@ -721,7 +733,7 @@ struct zd_rt_hdr {
 	u8  rt_rate;
 	u16 rt_channel;
 	u16 rt_chbitmask;
-};
+} __attribute__((packed));
 
 static void fill_rt_header(void *buffer, struct zd_mac *mac,
 	                   const struct ieee80211_rx_stats *stats,
@@ -873,45 +885,78 @@ static int fill_rx_stats(struct ieee80211_rx_stats *stats,
 	return 0;
 }
 
-int zd_mac_rx(struct zd_mac *mac, const u8 *buffer, unsigned int length)
+static void zd_mac_rx(struct zd_mac *mac, struct sk_buff *skb)
 {
 	int r;
 	struct ieee80211_device *ieee = zd_mac_to_ieee80211(mac);
 	struct ieee80211_rx_stats stats;
 	const struct rx_status *status;
-	struct sk_buff *skb;
 
-	if (length < ZD_PLCP_HEADER_SIZE + IEEE80211_1ADDR_LEN +
-	             IEEE80211_FCS_LEN + sizeof(struct rx_status))
-		return -EINVAL;
+	if (skb->len < ZD_PLCP_HEADER_SIZE + IEEE80211_1ADDR_LEN +
+	               IEEE80211_FCS_LEN + sizeof(struct rx_status))
+	{
+		dev_dbg_f(zd_mac_dev(mac), "Packet with length %u to small.\n",
+			 skb->len);
+		goto free_skb;
+	}
 
-	r = fill_rx_stats(&stats, &status, mac, buffer, length);
-	if (r)
-		return r;
+	r = fill_rx_stats(&stats, &status, mac, skb->data, skb->len);
+	if (r) {
+		/* Only packets with rx errors are included here. */
+		goto free_skb;
+	}
 
-	length -= ZD_PLCP_HEADER_SIZE+IEEE80211_FCS_LEN+
-		  sizeof(struct rx_status);
-	buffer += ZD_PLCP_HEADER_SIZE;
+	__skb_pull(skb, ZD_PLCP_HEADER_SIZE);
+	__skb_trim(skb, skb->len -
+		        (IEEE80211_FCS_LEN + sizeof(struct rx_status)));
 
-	update_qual_rssi(mac, buffer, length, stats.signal, stats.rssi);
+	update_qual_rssi(mac, skb->data, skb->len, stats.signal,
+		         status->signal_strength);
 
-	r = filter_rx(ieee, buffer, length, &stats);
-	if (r <= 0)
-		return r;
 
-	skb = dev_alloc_skb(sizeof(struct zd_rt_hdr) + length);
-	if (!skb)
-		return -ENOMEM;
+	r = filter_rx(ieee, skb->data, skb->len, &stats);
+	if (r <= 0) {
+		if (r < 0)
+			dev_dbg_f(zd_mac_dev(mac), "Error in packet.\n");
+		goto free_skb;
+	}
+
 	if (ieee->iw_mode == IW_MODE_MONITOR)
-		fill_rt_header(skb_put(skb, sizeof(struct zd_rt_hdr)), mac,
+		fill_rt_header(skb_push(skb, sizeof(struct zd_rt_hdr)), mac,
 			       &stats, status);
-	memcpy(skb_put(skb, length), buffer, length);
 
 	r = ieee80211_rx(ieee, skb, &stats);
-	if (!r) {
-		ZD_ASSERT(in_irq());
-		dev_kfree_skb_irq(skb);
+	if (r)
+		return;
+
+free_skb:
+	/* We are always in a soft irq. */
+	dev_kfree_skb(skb);
+}
+
+static void do_rx(unsigned long mac_ptr)
+{
+	struct zd_mac *mac = (struct zd_mac *)mac_ptr;
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&mac->rx_queue)) != NULL)
+		zd_mac_rx(mac, skb);
+}
+
+int zd_mac_rx_irq(struct zd_mac *mac, const u8 *buffer, unsigned int length)
+{
+	struct sk_buff *skb;
+
+	skb = dev_alloc_skb(sizeof(struct zd_rt_hdr) + length);
+	if (!skb) {
+		dev_warn(zd_mac_dev(mac), "Could not allocate skb.\n");
+		return -ENOMEM;
 	}
+	skb_reserve(skb, sizeof(struct zd_rt_hdr));
+	memcpy(__skb_put(skb, length), buffer, length);
+	skb_queue_tail(&mac->rx_queue, skb);
+	tasklet_schedule(&mac->rx_tasklet);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/zd1211rw/zd_mac.h b/drivers/net/wireless/zd1211rw/zd_mac.h
index b8ea3de..f3213ab 100644
--- a/drivers/net/wireless/zd1211rw/zd_mac.h
+++ b/drivers/net/wireless/zd1211rw/zd_mac.h
@@ -82,7 +82,7 @@ struct zd_ctrlset {
 struct rx_length_info {
 	__le16 length[3];
 	__le16 tag;
-};
+} __attribute__((packed));
 
 #define RX_LENGTH_INFO_TAG		0x697e
 
@@ -93,7 +93,7 @@ struct rx_status {
 	u8 signal_quality_ofdm;
 	u8 decryption_type;
 	u8 frame_status;
-};
+} __attribute__((packed));
 
 /* rx_status field decryption_type */
 #define ZD_RX_NO_WEP	0
@@ -133,6 +133,10 @@ struct zd_mac {
 	/* Unlocked reading possible */
 	struct iw_statistics iw_stats;
 	struct housekeeping housekeeping;
+
+	struct tasklet_struct rx_tasklet;
+	struct sk_buff_head rx_queue;
+
 	unsigned int stats_count;
 	u8 qual_buffer[ZD_MAC_STATS_BUFFER_SIZE];
 	u8 rssi_buffer[ZD_MAC_STATS_BUFFER_SIZE];
@@ -174,7 +178,7 @@ int zd_mac_open(struct net_device *netdev);
 int zd_mac_stop(struct net_device *netdev);
 int zd_mac_set_mac_address(struct net_device *dev, void *p);
 
-int zd_mac_rx(struct zd_mac *mac, const u8 *buffer, unsigned int length);
+int zd_mac_rx_irq(struct zd_mac *mac, const u8 *buffer, unsigned int length);
 
 int zd_mac_set_regdomain(struct zd_mac *zd_mac, u8 regdomain);
 u8 zd_mac_get_regdomain(struct zd_mac *zd_mac);
diff --git a/drivers/net/wireless/zd1211rw/zd_usb.c b/drivers/net/wireless/zd1211rw/zd_usb.c
index 3faaeb2..4a5f5d5 100644
--- a/drivers/net/wireless/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zd1211rw/zd_usb.c
@@ -599,13 +599,13 @@ static void handle_rx_packet(struct zd_usb *usb, const u8 *buffer,
 			n = l+k;
 			if (n > length)
 				return;
-			zd_mac_rx(mac, buffer+l, k);
+			zd_mac_rx_irq(mac, buffer+l, k);
 			if (i >= 2)
 				return;
 			l = (n+3) & ~3;
 		}
 	} else {
-		zd_mac_rx(mac, buffer, length);
+		zd_mac_rx_irq(mac, buffer, length);
 	}
 }
 
diff --git a/drivers/net/wireless/zd1211rw/zd_usb.h b/drivers/net/wireless/zd1211rw/zd_usb.h
index e81a2d3..317d37c 100644
--- a/drivers/net/wireless/zd1211rw/zd_usb.h
+++ b/drivers/net/wireless/zd1211rw/zd_usb.h
@@ -74,17 +74,17 @@ enum control_requests {
 struct usb_req_read_regs {
 	__le16 id;
 	__le16 addr[0];
-};
+} __attribute__((packed));
 
 struct reg_data {
 	__le16 addr;
 	__le16 value;
-};
+} __attribute__((packed));
 
 struct usb_req_write_regs {
 	__le16 id;
 	struct reg_data reg_writes[0];
-};
+} __attribute__((packed));
 
 enum {
 	RF_IF_LE = 0x02,
@@ -101,7 +101,7 @@ struct usb_req_rfwrite {
 	/* RF2595: 24 */
 	__le16 bit_values[0];
 	/* (CR203 & ~(RF_IF_LE | RF_CLK | RF_DATA)) | (bit ? RF_DATA : 0) */
-};
+} __attribute__((packed));
 
 /* USB interrupt */
 
@@ -118,12 +118,12 @@ enum usb_int_flags {
 struct usb_int_header {
 	u8 type;	/* must always be 1 */
 	u8 id;
-};
+} __attribute__((packed));
 
 struct usb_int_regs {
 	struct usb_int_header hdr;
 	struct reg_data regs[0];
-};
+} __attribute__((packed));
 
 struct usb_int_retry_fail {
 	struct usb_int_header hdr;
@@ -131,7 +131,7 @@ struct usb_int_retry_fail {
 	u8 _dummy;
 	u8 addr[ETH_ALEN];
 	u8 ibss_wakeup_dest;
-};
+} __attribute__((packed));
 
 struct read_regs_int {
 	struct completion completion;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3ac4890..f018e49 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -191,6 +191,7 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 		goto out;
 
 	req->cmd_len = COMMAND_SIZE(cmd[0]);
+	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sense;
 	req->sense_len = 0;
diff --git a/drivers/usb/net/asix.c b/drivers/usb/net/asix.c
index 881841e..1a22d00 100644
--- a/drivers/usb/net/asix.c
+++ b/drivers/usb/net/asix.c
@@ -920,7 +920,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 		goto out2;
 
 	if ((ret = asix_write_cmd(dev, AX_CMD_SW_PHY_SELECT,
-				0x0000, 0, 0, buf)) < 0) {
+				1, 0, 0, buf)) < 0) {
 		dbg("Select PHY #1 failed: %d", ret);
 		goto out2;
 	}
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index a624c3e..0509ced 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -481,6 +481,8 @@ static int cramfs_readpage(struct file *file, struct page * page)
 		pgdata = kmap(page);
 		if (compr_len == 0)
 			; /* hole */
+		else if (compr_len > (PAGE_CACHE_SIZE << 1))
+			printk(KERN_ERR "cramfs: bad compressed blocksize %u\n", compr_len);
 		else {
 			mutex_lock(&read_mutex);
 			bytes_filled = cramfs_uncompress_block(pgdata,
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 3e7a84a..852780b 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -368,6 +368,14 @@ struct ext2_dir_entry_2 * ext2_find_entry (struct inode * dir,
 		}
 		if (++n >= npages)
 			n = 0;
+		/* next page is past the blocks we've got */
+		if (unlikely(n > (dir->i_blocks >> (PAGE_CACHE_SHIFT - 9)))) {
+			ext2_error(dir->i_sb, __FUNCTION__,
+				"dir %lu size %lld exceeds block count %llu",
+				dir->i_ino, dir->i_size,
+				(unsigned long long)dir->i_blocks);
+				goto out;
+		}
 	} while (n != start);
 out:
 	return NULL;
diff --git a/fs/ext3/dir.c b/fs/ext3/dir.c
index d0b54f3..5a9313e 100644
--- a/fs/ext3/dir.c
+++ b/fs/ext3/dir.c
@@ -154,6 +154,9 @@ static int ext3_readdir(struct file * filp,
 			ext3_error (sb, "ext3_readdir",
 				"directory #%lu contains a hole at offset %lu",
 				inode->i_ino, (unsigned long)filp->f_pos);
+			/* corrupt size?  Maybe no more blocks to read */
+			if (filp->f_pos > inode->i_blocks << 9)
+				break;
 			filp->f_pos += sb->s_blocksize - offset;
 			continue;
 		}
diff --git a/fs/ext3/namei.c b/fs/ext3/namei.c
index 906731a..60d2f9d 100644
--- a/fs/ext3/namei.c
+++ b/fs/ext3/namei.c
@@ -552,6 +552,15 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 					   dir->i_sb->s_blocksize -
 					   EXT3_DIR_REC_LEN(0));
 	for (; de < top; de = ext3_next_entry(de)) {
+		if (!ext3_check_dir_entry("htree_dirblock_to_tree", dir, de, bh,
+					(block<<EXT3_BLOCK_SIZE_BITS(dir->i_sb))
+						+((char *)de - bh->b_data))) {
+			/* On error, skip the f_pos to the next block. */
+			dir_file->f_pos = (dir_file->f_pos |
+					(dir->i_sb->s_blocksize - 1)) + 1;
+			brelse (bh);
+			return count;
+		}
 		ext3fs_dirhash(de->name, de->name_len, hinfo);
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
diff --git a/fs/ramfs/file-mmu.c b/fs/ramfs/file-mmu.c
index 0947fb5..54ebbc8 100644
--- a/fs/ramfs/file-mmu.c
+++ b/fs/ramfs/file-mmu.c
@@ -25,11 +25,13 @@
  */
 
 #include <linux/fs.h>
+#include <linux/mm.h>
 
 const struct address_space_operations ramfs_aops = {
 	.readpage	= simple_readpage,
 	.prepare_write	= simple_prepare_write,
-	.commit_write	= simple_commit_write
+	.commit_write	= simple_commit_write,
+	.set_page_dirty = __set_page_dirty_nobuffers,
 };
 
 const struct file_operations ramfs_file_operations = {
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index bfe5dbf..24f6faf 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/init.h>
@@ -30,7 +31,8 @@ static int ramfs_nommu_setattr(struct dentry *, struct iattr *);
 const struct address_space_operations ramfs_aops = {
 	.readpage		= simple_readpage,
 	.prepare_write		= simple_prepare_write,
-	.commit_write		= simple_commit_write
+	.commit_write		= simple_commit_write,
+	.set_page_dirty = __set_page_dirty_nobuffers,
 };
 
 const struct file_operations ramfs_file_operations = {
diff --git a/include/asm-arm/unistd.h b/include/asm-arm/unistd.h
index 14a87ee..51b5ee3 100644
--- a/include/asm-arm/unistd.h
+++ b/include/asm-arm/unistd.h
@@ -347,6 +347,19 @@
 #define __NR_mbind			(__NR_SYSCALL_BASE+319)
 #define __NR_get_mempolicy		(__NR_SYSCALL_BASE+320)
 #define __NR_set_mempolicy		(__NR_SYSCALL_BASE+321)
+#define __NR_openat			(__NR_SYSCALL_BASE+322)
+#define __NR_mkdirat			(__NR_SYSCALL_BASE+323)
+#define __NR_mknodat			(__NR_SYSCALL_BASE+324)
+#define __NR_fchownat			(__NR_SYSCALL_BASE+325)
+#define __NR_futimesat			(__NR_SYSCALL_BASE+326)
+#define __NR_fstatat64			(__NR_SYSCALL_BASE+327)
+#define __NR_unlinkat			(__NR_SYSCALL_BASE+328)
+#define __NR_renameat			(__NR_SYSCALL_BASE+329)
+#define __NR_linkat			(__NR_SYSCALL_BASE+330)
+#define __NR_symlinkat			(__NR_SYSCALL_BASE+331)
+#define __NR_readlinkat			(__NR_SYSCALL_BASE+332)
+#define __NR_fchmodat			(__NR_SYSCALL_BASE+333)
+#define __NR_faccessat			(__NR_SYSCALL_BASE+334)
 
 /*
  * The following SWIs are ARM private.
diff --git a/include/linux/libata.h b/include/linux/libata.h
index abd2deb..830e8e7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -744,9 +744,8 @@ extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t mesg);
 extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
 extern void ata_host_resume(struct ata_host *host);
 extern int ata_ratelimit(void);
-extern unsigned int ata_busy_sleep(struct ata_port *ap,
-				   unsigned long timeout_pat,
-				   unsigned long timeout);
+extern int ata_busy_sleep(struct ata_port *ap,
+			  unsigned long timeout_pat, unsigned long timeout);
 extern void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *),
 				void *data, unsigned long delay);
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
@@ -1061,7 +1060,7 @@ static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
 		udelay(10);
 		status = ata_chk_status(ap);
 		max--;
-	} while ((status & bits) && (max > 0));
+	} while (status != 0xff && (status & bits) && (max > 0));
 
 	return status;
 }
@@ -1082,7 +1081,7 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
 {
 	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-	if (status & (ATA_BUSY | ATA_DRQ)) {
+	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ))) {
 		unsigned long l = ap->ioaddr.status_addr;
 		if (ata_msg_warn(ap))
 			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
diff --git a/include/linux/net.h b/include/linux/net.h
index 15c733b..b701d33 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -19,7 +19,6 @@
 #define _LINUX_NET_H
 
 #include <linux/wait.h>
-#include <linux/random.h>
 #include <asm/socket.h>
 
 struct poll_table_struct;
@@ -57,6 +56,7 @@ typedef enum {
 
 #ifdef __KERNEL__
 #include <linux/stringify.h>
+#include <linux/random.h>
 
 #define SOCK_ASYNC_NOSPACE	0
 #define SOCK_ASYNC_WAITDATA	1
diff --git a/include/media/cx2341x.h b/include/media/cx2341x.h
index d91d88f..ecad55b 100644
--- a/include/media/cx2341x.h
+++ b/include/media/cx2341x.h
@@ -49,7 +49,7 @@ struct cx2341x_mpeg_params {
 	enum v4l2_mpeg_audio_mode_extension audio_mode_extension;
 	enum v4l2_mpeg_audio_emphasis audio_emphasis;
 	enum v4l2_mpeg_audio_crc audio_crc;
-	u8 audio_properties;
+	u16 audio_properties;
 
 	/* video */
 	enum v4l2_mpeg_video_encoding video_encoding;
diff --git a/kernel/sched.c b/kernel/sched.c
index 3399701..a7aeb71 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -5493,7 +5493,7 @@ static void cpu_attach_domain(struct sched_domain *sd, int cpu)
 }
 
 /* cpus with isolated domains */
-static cpumask_t __cpuinitdata cpu_isolated_map = CPU_MASK_NONE;
+static cpumask_t cpu_isolated_map = CPU_MASK_NONE;
 
 /* Setup the mask of cpus configured for isolated domains */
 static int __init isolated_cpu_setup(char *str)
diff --git a/mm/memory.c b/mm/memory.c
index 156861f..90c6da0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1110,23 +1110,29 @@ static int zeromap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 {
 	pte_t *pte;
 	spinlock_t *ptl;
+	int err = 0;
 
 	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
-		return -ENOMEM;
+		return -EAGAIN;
 	arch_enter_lazy_mmu_mode();
 	do {
 		struct page *page = ZERO_PAGE(addr);
 		pte_t zero_pte = pte_wrprotect(mk_pte(page, prot));
+
+		if (unlikely(!pte_none(*pte))) {
+			err = -EEXIST;
+			pte++;
+			break;
+		}
 		page_cache_get(page);
 		page_add_file_rmap(page);
 		inc_mm_counter(mm, file_rss);
-		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, zero_pte);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(pte - 1, ptl);
-	return 0;
+	return err;
 }
 
 static inline int zeromap_pmd_range(struct mm_struct *mm, pud_t *pud,
@@ -1134,16 +1140,18 @@ static inline int zeromap_pmd_range(struct mm_struct *mm, pud_t *pud,
 {
 	pmd_t *pmd;
 	unsigned long next;
+	int err;
 
 	pmd = pmd_alloc(mm, pud, addr);
 	if (!pmd)
-		return -ENOMEM;
+		return -EAGAIN;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (zeromap_pte_range(mm, pmd, addr, next, prot))
-			return -ENOMEM;
+		err = zeromap_pte_range(mm, pmd, addr, next, prot);
+		if (err)
+			break;
 	} while (pmd++, addr = next, addr != end);
-	return 0;
+	return err;
 }
 
 static inline int zeromap_pud_range(struct mm_struct *mm, pgd_t *pgd,
@@ -1151,16 +1159,18 @@ static inline int zeromap_pud_range(struct mm_struct *mm, pgd_t *pgd,
 {
 	pud_t *pud;
 	unsigned long next;
+	int err;
 
 	pud = pud_alloc(mm, pgd, addr);
 	if (!pud)
-		return -ENOMEM;
+		return -EAGAIN;
 	do {
 		next = pud_addr_end(addr, end);
-		if (zeromap_pmd_range(mm, pud, addr, next, prot))
-			return -ENOMEM;
+		err = zeromap_pmd_range(mm, pud, addr, next, prot);
+		if (err)
+			break;
 	} while (pud++, addr = next, addr != end);
-	return 0;
+	return err;
 }
 
 int zeromap_page_range(struct vm_area_struct *vma,
diff --git a/mm/mincore.c b/mm/mincore.c
index 7289078..8aca6f7 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -1,7 +1,7 @@
 /*
  *	linux/mm/mincore.c
  *
- * Copyright (C) 1994-1999  Linus Torvalds
+ * Copyright (C) 1994-2006  Linus Torvalds
  */
 
 /*
@@ -38,46 +38,51 @@ static unsigned char mincore_page(struct vm_area_struct * vma,
 	return present;
 }
 
-static long mincore_vma(struct vm_area_struct * vma,
-	unsigned long start, unsigned long end, unsigned char __user * vec)
+/*
+ * Do a chunk of "sys_mincore()". We've already checked
+ * all the arguments, we hold the mmap semaphore: we should
+ * just return the amount of info we're asked for.
+ */
+static long do_mincore(unsigned long addr, unsigned char *vec, unsigned long pages)
 {
-	long error, i, remaining;
-	unsigned char * tmp;
-
-	error = -ENOMEM;
-	if (!vma->vm_file)
-		return error;
-
-	start = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
-	if (end > vma->vm_end)
-		end = vma->vm_end;
-	end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
+	unsigned long i, nr, pgoff;
+	struct vm_area_struct *vma = find_vma(current->mm, addr);
 
-	error = -EAGAIN;
-	tmp = (unsigned char *) __get_free_page(GFP_KERNEL);
-	if (!tmp)
-		return error;
+	/*
+	 * find_vma() didn't find anything above us, or we're
+	 * in an unmapped hole in the address space: ENOMEM.
+	 */
+	if (!vma || addr < vma->vm_start)
+		return -ENOMEM;
 
-	/* (end - start) is # of pages, and also # of bytes in "vec */
-	remaining = (end - start),
+	/*
+	 * Ok, got it. But check whether it's a segment we support
+	 * mincore() on. Right now, we don't do any anonymous mappings.
+	 *
+	 * FIXME: This is just stupid. And returning ENOMEM is 
+	 * stupid too. We should just look at the page tables. But
+	 * this is what we've traditionally done, so we'll just
+	 * continue doing it.
+	 */
+	if (!vma->vm_file)
+		return -ENOMEM;
 
-	error = 0;
-	for (i = 0; remaining > 0; remaining -= PAGE_SIZE, i++) {
-		int j = 0;
-		long thispiece = (remaining < PAGE_SIZE) ?
-						remaining : PAGE_SIZE;
+	/*
+	 * Calculate how many pages there are left in the vma, and
+	 * what the pgoff is for our address.
+	 */
+	nr = (vma->vm_end - addr) >> PAGE_SHIFT;
+	if (nr > pages)
+		nr = pages;
 
-		while (j < thispiece)
-			tmp[j++] = mincore_page(vma, start++);
+	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+	pgoff += vma->vm_pgoff;
 
-		if (copy_to_user(vec + PAGE_SIZE * i, tmp, thispiece)) {
-			error = -EFAULT;
-			break;
-		}
-	}
+	/* And then we just fill the sucker in.. */
+	for (i = 0 ; i < nr; i++, pgoff++)
+		vec[i] = mincore_page(vma, pgoff);
 
-	free_page((unsigned long) tmp);
-	return error;
+	return nr;
 }
 
 /*
@@ -107,82 +112,50 @@ static long mincore_vma(struct vm_area_struct * vma,
 asmlinkage long sys_mincore(unsigned long start, size_t len,
 	unsigned char __user * vec)
 {
-	int index = 0;
-	unsigned long end, limit;
-	struct vm_area_struct * vma;
-	size_t max;
-	int unmapped_error = 0;
-	long error;
-
-	/* check the arguments */
- 	if (start & ~PAGE_CACHE_MASK)
-		goto einval;
-
-	limit = TASK_SIZE;
-	if (start >= limit)
-		goto enomem;
-
-	if (!len)
-		return 0;
-
-	max = limit - start;
-	len = PAGE_CACHE_ALIGN(len);
-	if (len > max || !len)
-		goto enomem;
+	long retval;
+	unsigned long pages;
+	unsigned char *tmp;
 
-	end = start + len;
+	/* Check the start address: needs to be page-aligned.. */
+ 	if (start & ~PAGE_CACHE_MASK)
+		return -EINVAL;
 
-	/* check the output buffer whilst holding the lock */
-	error = -EFAULT;
-	down_read(&current->mm->mmap_sem);
+	/* ..and we need to be passed a valid user-space range */
+	if (!access_ok(VERIFY_READ, (void __user *) start, len))
+		return -ENOMEM;
 
-	if (!access_ok(VERIFY_WRITE, vec, len >> PAGE_SHIFT))
-		goto out;
+	/* This also avoids any overflows on PAGE_CACHE_ALIGN */
+	pages = len >> PAGE_SHIFT;
+	pages += (len & ~PAGE_MASK) != 0;
 
-	/*
-	 * If the interval [start,end) covers some unmapped address
-	 * ranges, just ignore them, but return -ENOMEM at the end.
-	 */
-	error = 0;
-
-	vma = find_vma(current->mm, start);
-	while (vma) {
-		/* Here start < vma->vm_end. */
-		if (start < vma->vm_start) {
-			unmapped_error = -ENOMEM;
-			start = vma->vm_start;
-		}
+	if (!access_ok(VERIFY_WRITE, vec, pages))
+		return -EFAULT;
 
-		/* Here vma->vm_start <= start < vma->vm_end. */
-		if (end <= vma->vm_end) {
-			if (start < end) {
-				error = mincore_vma(vma, start, end,
-							&vec[index]);
-				if (error)
-					goto out;
-			}
-			error = unmapped_error;
-			goto out;
+	tmp = (void *) __get_free_page(GFP_USER);
+	if (!tmp)
+		return -EAGAIN;
+
+	retval = 0;
+	while (pages) {
+		/*
+		 * Do at most PAGE_SIZE entries per iteration, due to
+		 * the temporary buffer size.
+		 */
+		down_read(&current->mm->mmap_sem);
+		retval = do_mincore(start, tmp, min(pages, PAGE_SIZE));
+		up_read(&current->mm->mmap_sem);
+
+		if (retval <= 0)
+			break;
+		if (copy_to_user(vec, tmp, retval)) {
+			retval = -EFAULT;
+			break;
 		}
-
-		/* Here vma->vm_start <= start < vma->vm_end < end. */
-		error = mincore_vma(vma, start, vma->vm_end, &vec[index]);
-		if (error)
-			goto out;
-		index += (vma->vm_end - start) >> PAGE_CACHE_SHIFT;
-		start = vma->vm_end;
-		vma = vma->vm_next;
+		pages -= retval;
+		vec += retval;
+		start += retval << PAGE_SHIFT;
+		retval = 0;
 	}
-
-	/* we found a hole in the area queried if we arrive here */
-	error = -ENOMEM;
-
-out:
-	up_read(&current->mm->mmap_sem);
-	return error;
-
-einval:
-	return -EINVAL;
-enomem:
-	return -ENOMEM;
+	free_page((unsigned long) tmp);
+	return retval;
 }
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 2e3ce3a..d6a94c0 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -61,12 +61,6 @@ unsigned long badness(struct task_struct *p, unsigned long uptime)
 	}
 
 	/*
-	 * swapoff can easily use up all memory, so kill those first.
-	 */
-	if (p->flags & PF_SWAPOFF)
-		return ULONG_MAX;
-
-	/*
 	 * The memory size of the process is the basis for the badness.
 	 */
 	points = mm->total_vm;
@@ -77,6 +71,12 @@ unsigned long badness(struct task_struct *p, unsigned long uptime)
 	task_unlock(p);
 
 	/*
+	 * swapoff can easily use up all memory, so kill those first.
+	 */
+	if (p->flags & PF_SWAPOFF)
+		return ULONG_MAX;
+
+	/*
 	 * Processes which fork a lot of child processes are likely
 	 * a good choice. We add half the vmsize of the children if they
 	 * have an own mm. This prevents forking servers to flood the
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 8d9b19f..565f70b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -893,12 +893,41 @@ int clear_page_dirty_for_io(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 
-	if (mapping) {
+	if (mapping && mapping_cap_account_dirty(mapping)) {
+		/*
+		 * Yes, Virginia, this is indeed insane.
+		 *
+		 * We use this sequence to make sure that
+		 *  (a) we account for dirty stats properly
+		 *  (b) we tell the low-level filesystem to
+		 *      mark the whole page dirty if it was
+		 *      dirty in a pagetable. Only to then
+		 *  (c) clean the page again and return 1 to
+		 *      cause the writeback.
+		 *
+		 * This way we avoid all nasty races with the
+		 * dirty bit in multiple places and clearing
+		 * them concurrently from different threads.
+		 *
+		 * Note! Normally the "set_page_dirty(page)"
+		 * has no effect on the actual dirty bit - since
+		 * that will already usually be set. But we
+		 * need the side effects, and it can help us
+		 * avoid races.
+		 *
+		 * We basically use the page "master dirty bit"
+		 * as a serialization point for all the different
+		 * threads doing their things.
+		 *
+		 * FIXME! We still have a race here: if somebody
+		 * adds the page back to the page tables in
+		 * between the "page_mkclean()" and the "TestClearPageDirty()",
+		 * we might have it mapped without the dirty bit set.
+		 */
+		if (page_mkclean(page))
+			set_page_dirty(page);
 		if (TestClearPageDirty(page)) {
-			if (mapping_cap_account_dirty(mapping)) {
-				page_mkclean(page);
-				dec_zone_page_state(page, NR_FILE_DIRTY);
-			}
+			dec_zone_page_state(page, NR_FILE_DIRTY);
 			return 1;
 		}
 		return 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index d8a842a..8c5dfdf 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -432,7 +432,7 @@ static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-	pte_t *pte, entry;
+	pte_t *pte;
 	spinlock_t *ptl;
 	int ret = 0;
 
@@ -444,17 +444,18 @@ static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
 	if (!pte)
 		goto out;
 
-	if (!pte_dirty(*pte) && !pte_write(*pte))
-		goto unlock;
+	if (pte_dirty(*pte) || pte_write(*pte)) {
+		pte_t entry;
 
-	entry = ptep_get_and_clear(mm, address, pte);
-	entry = pte_mkclean(entry);
-	entry = pte_wrprotect(entry);
-	ptep_establish(vma, address, pte, entry);
-	lazy_mmu_prot_update(entry);
-	ret = 1;
+		flush_cache_page(vma, address, pte_pfn(*pte));
+		entry = ptep_clear_flush(vma, address, pte);
+		entry = pte_wrprotect(entry);
+		entry = pte_mkclean(entry);
+		set_pte_at(mm, address, pte, entry);
+		lazy_mmu_prot_update(entry);
+		ret = 1;
+	}
 
-unlock:
 	pte_unmap_unlock(pte, ptl);
 out:
 	return ret;
@@ -489,6 +490,8 @@ int page_mkclean(struct page *page)
 		if (mapping)
 			ret = page_mkclean_file(mapping, page);
 	}
+	if (page_test_and_clear_dirty(page))
+		ret = 1;
 
 	return ret;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 4959535..697ecd7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -515,7 +515,12 @@ static void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end)
 			size = SHMEM_NR_DIRECT;
 		nr_swaps_freed = shmem_free_swp(ptr+idx, ptr+size);
 	}
-	if (!topdir)
+
+	/*
+	 * If there are no indirect blocks or we are punching a hole
+	 * below indirect blocks, nothing to be done.
+	 */
+	if (!topdir || (punch_hole && (limit <= SHMEM_NR_DIRECT)))
 		goto done2;
 
 	BUG_ON(limit <= SHMEM_NR_DIRECT);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 518540a..f58d359 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -691,7 +691,7 @@ static unsigned long shrink_inactive_list(unsigned long max_scan,
 			__count_vm_events(KSWAPD_STEAL, nr_freed);
 		} else
 			__count_zone_vm_events(PGSCAN_DIRECT, zone, nr_scan);
-		__count_vm_events(PGACTIVATE, nr_freed);
+		__count_zone_vm_events(PGSTEAL, zone, nr_freed);
 
 		if (nr_taken == 0)
 			goto done;
diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index be04e9f..ab166b4 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -196,6 +196,9 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 
 	switch (CAPIMSG_SUBCOMMAND(skb->data)) {
 	case CAPI_CONF:
+		if (skb->len < CAPI_MSG_BASELEN + 10)
+			break;
+
 		func = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 5);
 		info = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 8);
 
@@ -226,6 +229,9 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			break;
 
 		case CAPI_FUNCTION_GET_PROFILE:
+			if (skb->len < CAPI_MSG_BASELEN + 11 + sizeof(capi_profile))
+				break;
+
 			controller = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 11);
 			msgnum = CAPIMSG_MSGID(skb->data);
 
@@ -246,17 +252,26 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			break;
 
 		case CAPI_FUNCTION_GET_MANUFACTURER:
+			if (skb->len < CAPI_MSG_BASELEN + 15)
+				break;
+
 			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 10);
 
 			if (!info && ctrl) {
+				int len = min_t(uint, CAPI_MANUFACTURER_LEN,
+						skb->data[CAPI_MSG_BASELEN + 14]);
+
+				memset(ctrl->manu, 0, CAPI_MANUFACTURER_LEN);
 				strncpy(ctrl->manu,
-					skb->data + CAPI_MSG_BASELEN + 15,
-					skb->data[CAPI_MSG_BASELEN + 14]);
+					skb->data + CAPI_MSG_BASELEN + 15, len);
 			}
 
 			break;
 
 		case CAPI_FUNCTION_GET_VERSION:
+			if (skb->len < CAPI_MSG_BASELEN + 32)
+				break;
+
 			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 12);
 
 			if (!info && ctrl) {
@@ -269,13 +284,18 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			break;
 
 		case CAPI_FUNCTION_GET_SERIAL_NUMBER:
+			if (skb->len < CAPI_MSG_BASELEN + 17)
+				break;
+
 			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 12);
 
 			if (!info && ctrl) {
+				int len = min_t(uint, CAPI_SERIAL_LEN,
+						skb->data[CAPI_MSG_BASELEN + 16]);
+
 				memset(ctrl->serial, 0, CAPI_SERIAL_LEN);
 				strncpy(ctrl->serial,
-					skb->data + CAPI_MSG_BASELEN + 17,
-					skb->data[CAPI_MSG_BASELEN + 16]);
+					skb->data + CAPI_MSG_BASELEN + 17, len);
 			}
 
 			break;
@@ -284,14 +304,18 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 		break;
 
 	case CAPI_IND:
+		if (skb->len < CAPI_MSG_BASELEN + 6)
+			break;
+
 		func = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 3);
 
 		if (func == CAPI_FUNCTION_LOOPBACK) {
+			int len = min_t(uint, skb->len - CAPI_MSG_BASELEN - 6,
+						skb->data[CAPI_MSG_BASELEN + 5]);
 			appl = CAPIMSG_APPID(skb->data);
 			msgnum = CAPIMSG_MSGID(skb->data);
 			cmtp_send_interopmsg(session, CAPI_RESP, appl, msgnum, func,
-						skb->data + CAPI_MSG_BASELEN + 6,
-						skb->data[CAPI_MSG_BASELEN + 5]);
+						skb->data + CAPI_MSG_BASELEN + 6, len);
 		}
 
 		break;
@@ -309,6 +333,9 @@ void cmtp_recv_capimsg(struct cmtp_session *session, struct sk_buff *skb)
 
 	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
 
+	if (skb->len < CAPI_MSG_BASELEN)
+		return;
+
 	if (CAPIMSG_COMMAND(skb->data) == CAPI_INTEROPERABILITY) {
 		cmtp_recv_interopmsg(session, skb);
 		return;
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 136ed7d..473ca3a 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -575,7 +575,7 @@ ebt_check_entry(struct ebt_entry *e, struct ebt_table_info *newinfo,
 	struct ebt_entry_target *t;
 	struct ebt_target *target;
 	unsigned int i, j, hook = 0, hookmask = 0;
-	size_t gap = e->next_offset - e->target_offset;
+	size_t gap;
 	int ret;
 
 	/* don't mess with the struct ebt_entries */
@@ -625,6 +625,7 @@ ebt_check_entry(struct ebt_entry *e, struct ebt_table_info *newinfo,
 	if (ret != 0)
 		goto cleanup_watchers;
 	t = (struct ebt_entry_target *)(((char *)e) + e->target_offset);
+	gap = e->next_offset - e->target_offset;
 	target = find_target_lock(t->u.name, &ret, &ebt_mutex);
 	if (!target)
 		goto cleanup_watchers;
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 733d86d..261f8fb 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -147,6 +147,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/wait.h>
+#include <linux/completion.h>
 #include <linux/etherdevice.h>
 #include <net/checksum.h>
 #include <net/ipv6.h>
@@ -206,6 +207,11 @@ static struct proc_dir_entry *pg_proc_dir = NULL;
 #define VLAN_TAG_SIZE(x) ((x)->vlan_id == 0xffff ? 0 : 4)
 #define SVLAN_TAG_SIZE(x) ((x)->svlan_id == 0xffff ? 0 : 4)
 
+struct pktgen_thread_info {
+       struct pktgen_thread *t;
+       struct completion *c;
+};
+
 struct flow_state {
 	__u32 cur_daddr;
 	int count;
@@ -3264,10 +3270,11 @@ out:;
  * Main loop of the thread goes here
  */
 
-static void pktgen_thread_worker(struct pktgen_thread *t)
+static void pktgen_thread_worker(struct pktgen_thread_info *info)
 {
 	DEFINE_WAIT(wait);
 	struct pktgen_dev *pkt_dev = NULL;
+	struct pktgen_thread *t = info->t;
 	int cpu = t->cpu;
 	sigset_t tmpsig;
 	u32 max_before_softirq;
@@ -3307,6 +3314,8 @@ static void pktgen_thread_worker(struct pktgen_thread *t)
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
 
+        complete(info->c);
+
 	while (1) {
 
 		__set_current_state(TASK_RUNNING);
@@ -3518,6 +3527,8 @@ static struct pktgen_thread *__init pktgen_find_thread(const char *name)
 static int __init pktgen_create_thread(const char *name, int cpu)
 {
 	int err;
+	struct pktgen_thread_info info;
+        struct completion started;
 	struct pktgen_thread *t = NULL;
 	struct proc_dir_entry *pe;
 
@@ -3558,7 +3569,11 @@ static int __init pktgen_create_thread(const char *name, int cpu)
 
 	t->removed = 0;
 
-	err = kernel_thread((void *)pktgen_thread_worker, (void *)t,
+	init_completion(&started);
+        info.t = t;
+        info.c = &started;
+
+	err = kernel_thread((void *)pktgen_thread_worker, (void *)&info,
 			  CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
 	if (err < 0) {
 		printk("pktgen: kernel_thread() failed for cpu %d\n", t->cpu);
@@ -3568,6 +3583,7 @@ static int __init pktgen_create_thread(const char *name, int cpu)
 		return err;
 	}
 
+	wait_for_completion(&started);
 	return 0;
 }
 
diff --git a/net/ieee80211/softmac/ieee80211softmac_assoc.c b/net/ieee80211/softmac/ieee80211softmac_assoc.c
index cf51c87..614aa8d 100644
--- a/net/ieee80211/softmac/ieee80211softmac_assoc.c
+++ b/net/ieee80211/softmac/ieee80211softmac_assoc.c
@@ -427,6 +427,17 @@ ieee80211softmac_handle_assoc_response(struct net_device * dev,
 	return 0;
 }
 
+void
+ieee80211softmac_try_reassoc(struct ieee80211softmac_device *mac)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mac->lock, flags);
+	mac->associnfo.associating = 1;
+	schedule_work(&mac->associnfo.work);
+	spin_unlock_irqrestore(&mac->lock, flags);
+}
+
 int
 ieee80211softmac_handle_disassoc(struct net_device * dev,
 				 struct ieee80211_disassoc *disassoc)
@@ -445,8 +456,7 @@ ieee80211softmac_handle_disassoc(struct net_device * dev,
 	dprintk(KERN_INFO PFX "got disassoc frame\n");
 	ieee80211softmac_disassoc(mac);
 
-	/* try to reassociate */
-	schedule_work(&mac->associnfo.work);
+	ieee80211softmac_try_reassoc(mac);
 
 	return 0;
 }
diff --git a/net/ieee80211/softmac/ieee80211softmac_auth.c b/net/ieee80211/softmac/ieee80211softmac_auth.c
index 4cef39e..88897e4 100644
--- a/net/ieee80211/softmac/ieee80211softmac_auth.c
+++ b/net/ieee80211/softmac/ieee80211softmac_auth.c
@@ -328,6 +328,8 @@ ieee80211softmac_deauth_from_net(struct ieee80211softmac_device *mac,
 	/* can't transmit data right now... */
 	netif_carrier_off(mac->dev);
 	spin_unlock_irqrestore(&mac->lock, flags);
+
+	ieee80211softmac_try_reassoc(mac);
 }
 
 /* 
diff --git a/net/ieee80211/softmac/ieee80211softmac_priv.h b/net/ieee80211/softmac/ieee80211softmac_priv.h
index 0642e09..3ae894f 100644
--- a/net/ieee80211/softmac/ieee80211softmac_priv.h
+++ b/net/ieee80211/softmac/ieee80211softmac_priv.h
@@ -238,4 +238,6 @@ void ieee80211softmac_call_events_locked(struct ieee80211softmac_device *mac, in
 int ieee80211softmac_notify_internal(struct ieee80211softmac_device *mac,
 	int event, void *event_context, notify_function_ptr fun, void *context, gfp_t gfp_mask);
 
+void ieee80211softmac_try_reassoc(struct ieee80211softmac_device *mac);
+
 #endif /* IEEE80211SOFTMAC_PRIV_H_ */
diff --git a/net/ieee80211/softmac/ieee80211softmac_wx.c b/net/ieee80211/softmac/ieee80211softmac_wx.c
index 5b7b5b4..70d4292 100644
--- a/net/ieee80211/softmac/ieee80211softmac_wx.c
+++ b/net/ieee80211/softmac/ieee80211softmac_wx.c
@@ -463,7 +463,7 @@ ieee80211softmac_wx_get_genie(struct net_device *dev,
 			err = -E2BIG;
 	}
 	spin_unlock_irqrestore(&mac->lock, flags);
-	mutex_lock(&mac->associnfo.mutex);
+	mutex_unlock(&mac->associnfo.mutex);
 
 	return err;
 }
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7602c79..b54bd85 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -165,9 +165,8 @@ struct in_device *inetdev_init(struct net_device *dev)
 			      NET_IPV4_NEIGH, "ipv4", NULL, NULL);
 #endif
 
-	/* Account for reference dev->ip_ptr */
+	/* Account for reference dev->ip_ptr (below) */
 	in_dev_hold(in_dev);
-	rcu_assign_pointer(dev->ip_ptr, in_dev);
 
 #ifdef CONFIG_SYSCTL
 	devinet_sysctl_register(in_dev, &in_dev->cnf);
@@ -176,6 +175,8 @@ struct in_device *inetdev_init(struct net_device *dev)
 	if (dev->flags & IFF_UP)
 		ip_mc_up(in_dev);
 out:
+	/* we can receive as soon as ip_ptr is set -- do this last */
+	rcu_assign_pointer(dev->ip_ptr, in_dev);
 	return in_dev;
 out_kfree:
 	kfree(in_dev);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9e1bd37..404dd21 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -167,11 +167,14 @@ int udp_get_port(struct sock *sk, unsigned short snum,
 				goto gotit;
 			}
 			size = 0;
-			sk_for_each(sk2, node, head)
-				if (++size < best_size_so_far) {
-					best_size_so_far = size;
-					best = result;
-				}
+			sk_for_each(sk2, node, head) {
+				if (++size >= best_size_so_far)
+					goto next;
+			}
+			best_size_so_far = size;
+			best = result;
+		next:
+			;
 		}
 		result = best;
 		for(i = 0; i < (1 << 16) / UDP_HTABLE_SIZE; i++, result += UDP_HTABLE_SIZE) {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index b312a5f..4b3ffc6 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -413,8 +413,6 @@ static struct inet6_dev * ipv6_add_dev(struct net_device *dev)
 	if (netif_carrier_ok(dev))
 		ndev->if_flags |= IF_READY;
 
-	/* protected by rtnl_lock */
-	rcu_assign_pointer(dev->ip6_ptr, ndev);
 
 	ipv6_mc_init_dev(ndev);
 	ndev->tstamp = jiffies;
@@ -425,6 +423,8 @@ static struct inet6_dev * ipv6_add_dev(struct net_device *dev)
 			      NULL);
 	addrconf_sysctl_register(ndev, &ndev->cnf);
 #endif
+	/* protected by rtnl_lock */
+	rcu_assign_pointer(dev->ip6_ptr, ndev);
 	return ndev;
 }
 
diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cipso_v4.c
index a6ce1d6..bd45408 100644
--- a/net/netlabel/netlabel_cipso_v4.c
+++ b/net/netlabel/netlabel_cipso_v4.c
@@ -162,6 +162,7 @@ static int netlbl_cipsov4_add_std(struct genl_info *info)
 	struct nlattr *nla_b;
 	int nla_a_rem;
 	int nla_b_rem;
+	u32 iter;
 
 	if (!info->attrs[NLBL_CIPSOV4_A_TAGLST] ||
 	    !info->attrs[NLBL_CIPSOV4_A_MLSLVLLST])
@@ -223,6 +224,10 @@ static int netlbl_cipsov4_add_std(struct genl_info *info)
 		ret_val = -ENOMEM;
 		goto add_std_failure;
 	}
+	for (iter = 0; iter < doi_def->map.std->lvl.local_size; iter++)
+		doi_def->map.std->lvl.local[iter] = CIPSO_V4_INV_LVL;
+	for (iter = 0; iter < doi_def->map.std->lvl.cipso_size; iter++)
+		doi_def->map.std->lvl.cipso[iter] = CIPSO_V4_INV_LVL;
 	nla_for_each_nested(nla_a,
 			    info->attrs[NLBL_CIPSOV4_A_MLSLVLLST],
 			    nla_a_rem)
@@ -296,6 +301,10 @@ static int netlbl_cipsov4_add_std(struct genl_info *info)
 			ret_val = -ENOMEM;
 			goto add_std_failure;
 		}
+		for (iter = 0; iter < doi_def->map.std->cat.local_size; iter++)
+			doi_def->map.std->cat.local[iter] = CIPSO_V4_INV_CAT;
+		for (iter = 0; iter < doi_def->map.std->cat.cipso_size; iter++)
+			doi_def->map.std->cat.cipso[iter] = CIPSO_V4_INV_CAT;
 		nla_for_each_nested(nla_a,
 				    info->attrs[NLBL_CIPSOV4_A_MLSCATLST],
 				    nla_a_rem)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 4f5ff19..f01f8c0 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -56,6 +56,9 @@ endef
 # gcc support functions
 # See documentation in Documentation/kbuild/makefiles.txt
 
+# output directory for tests below
+TMPOUT := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)
+
 # as-option
 # Usage: cflags-y += $(call as-option, -Wa$(comma)-isa=foo,)
 
@@ -66,9 +69,11 @@ as-option = $(shell if $(CC) $(CFLAGS) $(1) -Wa,-Z -c -o /dev/null \
 # as-instr
 # Usage: cflags-y += $(call as-instr, instr, option1, option2)
 
-as-instr = $(shell if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o astest$$$$.out ; \
-		   then echo "$(2)"; else echo "$(3)"; fi; \
-	           rm -f astest$$$$.out)
+as-instr = $(shell if echo -e "$(1)" | \
+		      $(CC) $(AFLAGS) -c -xassembler - \
+			    -o $(TMPOUT)astest$$$$.out > /dev/null 2>&1; \
+		   then rm $(TMPOUT)astest$$$$.out; echo "$(2)"; \
+		   else echo "$(3)"; fi)
 
 # cc-option
 # Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
@@ -97,10 +102,10 @@ cc-ifversion = $(shell if [ $(call cc-version, $(CC)) $(1) $(2) ]; then \
 
 # ld-option
 # Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
-ld-option = $(shell if $(CC) $(1) \
-			     -nostdlib -o ldtest$$$$.out -xc /dev/null \
-             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi; \
-	     rm -f ldtest$$$$.out)
+ld-option = $(shell if $(CC) $(1) -nostdlib -xc /dev/null \
+			     -o $(TMPOUT)ldtest$$$$.out > /dev/null 2>&1; \
+             then rm $(TMPOUT)ldtest$$$$.out; echo "$(1)"; \
+             else echo "$(2)"; fi)
 
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index edeb3d3..f5956d5 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1268,7 +1268,7 @@ static struct snd_pcm_hardware snd_cs4231_playback =
 	.channels_min		= 1,
 	.channels_max		= 2,
 	.buffer_bytes_max	= (32*1024),
-	.period_bytes_min	= 4096,
+	.period_bytes_min	= 64,
 	.period_bytes_max	= (32*1024),
 	.periods_min		= 1,
 	.periods_max		= 1024,
@@ -1288,7 +1288,7 @@ static struct snd_pcm_hardware snd_cs4231_capture =
 	.channels_min		= 1,
 	.channels_max		= 2,
 	.buffer_bytes_max	= (32*1024),
-	.period_bytes_min	= 4096,
+	.period_bytes_min	= 64,
 	.period_bytes_max	= (32*1024),
 	.periods_min		= 1,
 	.periods_max		= 1024,
@@ -1796,7 +1796,7 @@ static irqreturn_t snd_cs4231_sbus_interrupt(int irq, void *dev_id)
 	snd_cs4231_outm(chip, CS4231_IRQ_STATUS, ~CS4231_ALL_IRQS | ~status, 0);
 	spin_unlock_irqrestore(&chip->lock, flags);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 /*
@@ -1821,7 +1821,6 @@ static int sbus_dma_request(struct cs4231_dma_control *dma_cont, dma_addr_t bus_
 	if (!(csr & test))
 		goto out;
 	err = -EBUSY;
-	csr = sbus_readl(base->regs + APCCSR);
 	test = APC_XINT_CNVA;
 	if ( base->dir == APC_PLAY )
 		test = APC_XINT_PNVA;
@@ -1862,17 +1861,16 @@ static void sbus_dma_enable(struct cs4231_dma_control *dma_cont, int on)
 
 	spin_lock_irqsave(&base->lock, flags);
 	if (!on) {
-		if (base->dir == APC_PLAY) { 
-			sbus_writel(0, base->regs + base->dir + APCNVA); 
-			sbus_writel(1, base->regs + base->dir + APCC); 
-		}
-		else
-		{
-			sbus_writel(0, base->regs + base->dir + APCNC); 
-			sbus_writel(0, base->regs + base->dir + APCVA); 
-		} 
+		sbus_writel(0, base->regs + base->dir + APCNC);
+		sbus_writel(0, base->regs + base->dir + APCNVA);
+		sbus_writel(0, base->regs + base->dir + APCC);
+		sbus_writel(0, base->regs + base->dir + APCVA);
+
+		/* ACK any APC interrupts. */
+		csr = sbus_readl(base->regs + APCCSR);
+		sbus_writel(csr, base->regs + APCCSR);
 	} 
-	udelay(600); 
+	udelay(1000);
 	csr = sbus_readl(base->regs + APCCSR);
 	shift = 0;
 	if ( base->dir == APC_PLAY )
