Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288312AbSACVNM>; Thu, 3 Jan 2002 16:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288319AbSACVNC>; Thu, 3 Jan 2002 16:13:02 -0500
Received: from zok.SGI.COM ([204.94.215.101]:24217 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S288312AbSACVMk>;
	Thu, 3 Jan 2002 16:12:40 -0500
Date: Thu, 3 Jan 2002 13:11:39 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Split out unmaintained visws support.
Message-ID: <20020103131139.A757747@sgi.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011230215306.A16140@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011230215306.A16140@suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 09:53:06PM +0000, Dave Jones wrote:
>  The SGI vis workstation support has been unmaintained for moons.
> I've even heard comments that it currently doesn't work.
> Patch below removes it from generic x86 setup, so it can bitrot
> somewhere else.  If no-one steps up to maintain this by the time
> we reach 2.6.0pre, I vote for dropping it altogether.

This post gave me the impetus I needed to get my act together and post
a patch I've had lying around for awhile, so here it is (against
2.4.17).  It still needs a lot of work, but it allows my 320 to limp
along at least.  I've got a project page setup for it at
http://linux-visws.sourceforge.net if anyone's interested (and I hope
some still are as there's lots of work to do).  Any tips on ways to
clean up the patch would be welcome (and should probably be discussed
on linux-visws-devel@lists.sourceforge.net).

Thanks,
Jesse


diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/config.in linux-2.4.17-visws/arch/i386/config.in
--- linux-2.4.17/arch/i386/config.in	Fri Dec 21 09:41:53 2001
+++ linux-2.4.17-visws/arch/i386/config.in	Wed Jan  2 17:05:27 2002
@@ -201,11 +201,12 @@
 
 # Visual Workstation support is utterly broken.
 # If you want to see it working mail an VW540 to hch@infradead.org 8)
-#bool 'SGI Visual Workstation support' CONFIG_VISWS
+bool 'SGI Visual Workstation support' CONFIG_VISWS
 if [ "$CONFIG_VISWS" = "y" ]; then
    define_bool CONFIG_X86_VISWS_APIC y
    define_bool CONFIG_X86_LOCAL_APIC y
    define_bool CONFIG_PCI y
+   define_bool CONFIG_VISWS_HACKS y
 else
    if [ "$CONFIG_SMP" = "y" ]; then
       define_bool CONFIG_X86_IO_APIC y
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/head.S linux-2.4.17-visws/arch/i386/kernel/head.S
--- linux-2.4.17/arch/i386/kernel/head.S	Wed Jun 20 11:00:53 2001
+++ linux-2.4.17-visws/arch/i386/kernel/head.S	Wed Jan  2 16:45:19 2002
@@ -42,6 +42,25 @@
  * On entry, %esi points to the real-mode code as a 32-bit pointer.
  */
 startup_32:
+#ifdef CONFIG_VISWS_HACKS
+ENTRY(stext)
+ENTRY(_stext)
+/*
+ * Initialize page tables
+ */
+	movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
+	movl $007,%eax		/* "007" doesn't mean with right to kill, but
+				   PRESENT+RW+USER */
+2:	stosl
+	add $0x1000,%eax
+	cmp $empty_zero_page-__PAGE_OFFSET,%edi
+	jne 2b
+	movl $0x101000,%eax
+	movl %eax,%cr3
+	lgdt gdt_descr
+	lidt idt_descr
+#endif
+
 /*
  * Set segments to known values
  */
@@ -411,8 +430,10 @@
 /*
  * Real beginning of normal "text" segment
  */
+#ifndef CONFIG_VISWS_HACKS
 ENTRY(stext)
 ENTRY(_stext)
+#endif
 
 /*
  * This starts the data section. Note that the above is all
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/i8259.c linux-2.4.17-visws/arch/i386/kernel/i8259.c
--- linux-2.4.17/arch/i386/kernel/i8259.c	Mon Sep 17 23:03:09 2001
+++ linux-2.4.17-visws/arch/i386/kernel/i8259.c	Wed Jan  2 16:45:19 2002
@@ -52,7 +52,7 @@
  */
 BUILD_16_IRQS(0x0)
 
-#ifdef CONFIG_X86_IO_APIC
+#if defined(CONFIG_X86_IO_APIC) || defined(CONFIG_X86_VISWS_APIC)
 /*
  * The IO-APIC gives us many more interrupt sources. Most of these 
  * are unused but an SMP system is supposed to have enough memory ...
@@ -91,7 +91,7 @@
  * overflow. Linux uses the local APIC timer interrupt to get
  * a much simpler SMP time architecture:
  */
-#ifdef CONFIG_X86_LOCAL_APIC
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_VISWS_APIC)
 BUILD_SMP_TIMER_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
 BUILD_SMP_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
 BUILD_SMP_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
@@ -109,7 +109,7 @@
 void (*interrupt[NR_IRQS])(void) = {
 	IRQLIST_16(0x0),
 
-#ifdef CONFIG_X86_IO_APIC
+#if defined(CONFIG_X86_IO_APIC) || defined(CONFIG_X86_VISWS_APIC)
 			 IRQLIST_16(0x1), IRQLIST_16(0x2), IRQLIST_16(0x3),
 	IRQLIST_16(0x4), IRQLIST_16(0x5), IRQLIST_16(0x6), IRQLIST_16(0x7),
 	IRQLIST_16(0x8), IRQLIST_16(0x9), IRQLIST_16(0xa), IRQLIST_16(0xb),
@@ -407,7 +407,7 @@
  * IRQ2 is cascade interrupt to second interrupt controller
  */
 
-#ifndef CONFIG_VISWS
+#ifndef CONFIG_X86_VISWS_APIC
 static struct irqaction irq2 = { no_action, 0, 0, "cascade", NULL, NULL};
 #endif
 
@@ -444,11 +444,6 @@
 {
 	int i;
 
-#ifndef CONFIG_X86_VISWS_APIC
-	init_ISA_irqs();
-#else
-	init_VISWS_APIC_irqs();
-#endif
 	/*
 	 * Cover the whole vector space, no vector can escape
 	 * us. (some of these will be overridden and become
@@ -460,6 +455,12 @@
 			set_intr_gate(vector, interrupt[i]);
 	}
 
+#ifndef CONFIG_X86_VISWS_APIC
+	init_ISA_irqs();
+#else
+	init_VISWS_APIC_irqs();
+#endif
+
 #ifdef CONFIG_SMP
 	/*
 	 * IRQ0 must be given a fixed assignment and initialized,
@@ -480,7 +481,7 @@
 	set_intr_gate(CALL_FUNCTION_VECTOR, call_function_interrupt);
 #endif	
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_VISWS_APIC)
 	/* self generated IPI for local APIC timer */
 	set_intr_gate(LOCAL_TIMER_VECTOR, apic_timer_interrupt);
 
@@ -497,7 +498,7 @@
 	outb_p(LATCH & 0xff , 0x40);	/* LSB */
 	outb(LATCH >> 8 , 0x40);	/* MSB */
 
-#ifndef CONFIG_VISWS
+#ifndef CONFIG_X86_VISWS_APIC
 	setup_irq(2, &irq2);
 #endif
 
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/irq.c linux-2.4.17-visws/arch/i386/kernel/irq.c
--- linux-2.4.17/arch/i386/kernel/irq.c	Thu Oct 25 13:53:46 2001
+++ linux-2.4.17-visws/arch/i386/kernel/irq.c	Wed Jan  2 16:45:19 2002
@@ -802,6 +802,13 @@
  
 unsigned long probe_irq_on(void)
 {
+#ifdef CONFIG_VISWS_HACKS
+/*
+ * Probing won't work for many devices
+ * with Cobalt
+ */
+        return 0;
+#else
 	unsigned int i;
 	irq_desc_t *desc;
 	unsigned long val;
@@ -872,6 +879,7 @@
 	}
 
 	return val;
+#endif /* CONFIG_VISWS_HACKS */
 }
 
 /*
@@ -943,6 +951,9 @@
  
 int probe_irq_off(unsigned long val)
 {
+#ifdef CONFIG_VISWS_HACKS
+	return 0;
+#else
 	int i, irq_found, nr_irqs;
 
 	nr_irqs = 0;
@@ -970,6 +981,7 @@
 	if (nr_irqs > 1)
 		irq_found = -irq_found;
 	return irq_found;
+#endif /* CONFIG_VISWS_HACKS */
 }
 
 /* this was setup_x86_irq but it seems pretty generic */
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/mpparse.c linux-2.4.17-visws/arch/i386/kernel/mpparse.c
--- linux-2.4.17/arch/i386/kernel/mpparse.c	Fri Nov  9 14:58:18 2001
+++ linux-2.4.17-visws/arch/i386/kernel/mpparse.c	Wed Jan  2 17:26:22 2002
@@ -27,6 +27,10 @@
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
 
+#ifdef CONFIG_VISWS
+#include <asm/sgi-cobalt.h>
+#endif
+
 /* Have we found an MP table */
 int smp_found_config;
 
@@ -67,7 +71,6 @@
  * Intel MP BIOS table parsing routines:
  */
 
-#ifndef CONFIG_X86_VISWS_APIC
 /*
  * Checksum an MP configuration block.
  */
@@ -160,6 +163,11 @@
 			m->mpc_apicver);
 	}
 
+#ifdef CONFIG_VISWS
+	printk("    IMCR and PIC compatibility mode.\n");
+	pic_mode = 1;	
+#endif
+
 	if (m->mpc_featureflag&(1<<0))
 		Dprintk("    Floating point unit present.\n");
 	if (m->mpc_featureflag&(1<<7))
@@ -267,6 +275,8 @@
 	}
 }
 
+#ifndef CONFIG_VISWS
+
 static void __init MP_ioapic_info (struct mpc_config_ioapic *m)
 {
 	if (!(m->mpc_flags & MPC_APIC_USABLE))
@@ -300,6 +310,8 @@
 		panic("Max # of irq sources exceeded!!\n");
 }
 
+#endif
+
 static void __init MP_lintsrc_info (struct mpc_config_lintsrc *m)
 {
 	Dprintk("Lint: type %d, pol %d, trig %d, bus %d,"
@@ -459,6 +471,7 @@
 				count += sizeof(*m);
 				break;
 			}
+#ifndef CONFIG_VISWS
 			case MP_IOAPIC:
 			{
 				struct mpc_config_ioapic *m=
@@ -478,6 +491,7 @@
 				count+=sizeof(*m);
 				break;
 			}
+#endif
 			case MP_LINTSRC:
 			{
 				struct mpc_config_lintsrc *m=
@@ -521,7 +535,9 @@
 	intsrc.mpc_type = MP_INTSRC;
 	intsrc.mpc_irqflag = 0;			/* conforming */
 	intsrc.mpc_srcbus = 0;
+#ifndef CONFIG_VISWS
 	intsrc.mpc_dstapic = mp_ioapics[0].mpc_apicid;
+#endif
 
 	intsrc.mpc_irqtype = mp_INT;
 
@@ -569,13 +585,17 @@
 
 		intsrc.mpc_srcbusirq = i;
 		intsrc.mpc_dstirq = i ? i : 2;		/* IRQ0 to INTIN2 */
+#ifndef CONFIG_VISWS
 		MP_intsrc_info(&intsrc);
+#endif
 	}
 
 	intsrc.mpc_irqtype = mp_ExtINT;
 	intsrc.mpc_srcbusirq = 0;
 	intsrc.mpc_dstirq = 0;				/* 8259A to INTIN0 */
+#ifndef CONFIG_VISWS
 	MP_intsrc_info(&intsrc);
+#endif
 }
 
 static inline void __init construct_default_ISA_mptable(int mpc_default_type)
@@ -642,7 +662,9 @@
 	ioapic.mpc_apicver = mpc_default_type > 4 ? 0x10 : 0x01;
 	ioapic.mpc_flags = MPC_APIC_USABLE;
 	ioapic.mpc_apicaddr = 0xFEC00000;
+#ifndef CONFIG_VISWS
 	MP_ioapic_info(&ioapic);
+#endif
 
 	/*
 	 * We set up most of the low 16 IO-APIC pins according to MPS rules.
@@ -770,6 +792,8 @@
 	return 0;
 }
 
+#ifndef CONFIG_VISWS_HACKS
+
 void __init find_intel_smp (void)
 {
 	unsigned int address;
@@ -808,25 +832,39 @@
 		printk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
 }
 
-#else
+#else /* CONFIG_VISWS_HACKS */
 
 /*
  * The Visual Workstation is Intel MP compliant in the hardware
  * sense, but it doesnt have a BIOS(-configuration table).
  * No problem for Linux.
  */
-void __init find_visws_smp(void)
+#define CO_CPU_NUM_PHYS 0x1e00
+#define CO_CPU_TAB_PHYS (CO_CPU_NUM_PHYS + 2)
+
+#define CO_CPU_MAX 4
+
+void __init init_visws_smp(void)
 {
-	smp_found_config = 1;
+	struct mpc_config_processor *mp = (struct mpc_config_processor *)
+		(PAGE_OFFSET + CO_CPU_TAB_PHYS);
+	unsigned short ncpus = *(unsigned short *)
+		(PAGE_OFFSET + CO_CPU_NUM_PHYS);
 
-	phys_cpu_present_map |= 2; /* or in id 1 */
-	apic_version[1] |= 0x10; /* integrated APIC */
-	apic_version[0] |= 0x10;
+	if(ncpus > CO_CPU_MAX) {
+		printk("find_visws_smp: got cpu count of %d at %p\n", 
+		       ncpus, mp);
+		return;
+	}
+
+	smp_found_config = 1;
+	while(ncpus--)
+		MP_processor_info(mp++);
 
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
 }
 
-#endif
+#endif /* CONFIG_VISWS_HACKS */
 
 /*
  * - Intel MP Configuration Table
@@ -834,11 +872,8 @@
  */
 void __init find_smp_config (void)
 {
-#ifdef CONFIG_X86_LOCAL_APIC
+#if defined(CONFIG_X86_LOCAL_APIC) && !defined(CONFIG_VISWS_HACKS)
 	find_intel_smp();
-#endif
-#ifdef CONFIG_VISWS
-	find_visws_smp();
 #endif
 }
 
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/pci-i386.h linux-2.4.17-visws/arch/i386/kernel/pci-i386.h
--- linux-2.4.17/arch/i386/kernel/pci-i386.h	Sun Nov 11 10:09:32 2001
+++ linux-2.4.17-visws/arch/i386/kernel/pci-i386.h	Wed Jan  2 16:45:20 2002
@@ -4,7 +4,7 @@
  *	(c) 1999 Martin Mares <mj@ucw.cz>
  */
 
-#undef DEBUG
+#define DEBUG
 
 #ifdef DEBUG
 #define DBG(x...) printk(x)
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/pci-visws.c linux-2.4.17-visws/arch/i386/kernel/pci-visws.c
--- linux-2.4.17/arch/i386/kernel/pci-visws.c	Sun Nov  4 09:31:58 2001
+++ linux-2.4.17-visws/arch/i386/kernel/pci-visws.c	Wed Jan  2 16:45:20 2002
@@ -13,13 +13,17 @@
 #include <linux/irq.h>
 
 #include <asm/smp.h>
-#include <asm/lithium.h>
 #include <asm/io.h>
+#include <asm/sgi-lithium.h>
 
 #include "pci-i386.h"
 
+#define DBG(x...) printk(x)
+
 unsigned int pci_probe = 0;
 
+struct pci_fixup pcibios_fixups[] = { { 0 } };
+
 /*
  *  The VISWS uses configuration access type 1 only.
  */
@@ -96,10 +100,13 @@
 			pin = (pin + PCI_SLOT(dev->devfn)) % 4;
 		} else
 			p = dev;
-		irq = visws_get_PCI_irq_vector(p->bus->number, PCI_SLOT(p->devfn), pin+1);
+
+		irq = visws_get_PCI_irq_vector(p->bus->number,
+					       PCI_SLOT(p->devfn), pin);
 		if (irq >= 0)
 			dev->irq = irq;
-		DBG("PCI IRQ: %s pin %d -> %d\n", dev->slot_name, pin, irq);
+		DBG("PCI IRQ: Bus %d, Slot %d, Pin %d -> %d\n",
+		    dev->bus->number, PCI_SLOT(p->devfn), pin, irq);
 	}
 }
 
@@ -117,11 +124,12 @@
 
 void __init pcibios_init(void)
 {
-	unsigned int sec_bus = li_pcib_read16(LI_PCI_BUSNUM) & 0xff;
+	unsigned int bus0 = li_pcib_read16(LI_PCI_BUSNUM) & 0xff;
+	unsigned int bus1 = li_pcia_read16(LI_PCI_BUSNUM) & 0xff;
 
-	printk("PCI: Probing PCI hardware on host buses 00 and %02x\n", sec_bus);
-	pci_scan_bus(0, &visws_pci_ops, NULL);
-	pci_scan_bus(sec_bus, &visws_pci_ops, NULL);
+	DBG("PCI: Probing PCI hardware on host buses %02x and %02x\n", bus0, bus1);
+	pci_scan_bus(bus0, &visws_pci_ops, NULL);
+	pci_scan_bus(bus1, &visws_pci_ops, NULL);
 	pcibios_fixup_irqs();
 	pcibios_resource_survey();
 }
@@ -138,4 +146,9 @@
 
 void __init pcibios_penalize_isa_irq(irq)
 {
+}
+
+unsigned int pcibios_assign_all_busses(void)
+{
+	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
 }
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/process.c linux-2.4.17-visws/arch/i386/kernel/process.c
--- linux-2.4.17/arch/i386/kernel/process.c	Thu Oct  4 18:42:54 2001
+++ linux-2.4.17-visws/arch/i386/kernel/process.c	Wed Jan  2 16:45:20 2002
@@ -362,6 +362,11 @@
 				: "i" ((void *) (0x1000 - sizeof (real_mode_switch) - 100)));
 }
 
+#ifdef CONFIG_VISWS
+static void visws_restart(void);
+static void visws_power_off(void);
+#endif
+
 void machine_restart(char * __unused)
 {
 #if CONFIG_SMP
@@ -401,6 +406,10 @@
 	disable_IO_APIC();
 #endif
 
+#ifdef CONFIG_VISWS
+	visws_restart();
+#endif
+
 	if(!reboot_thru_bios) {
 		/* rebooting needs to touch the page at absolute addr 0 */
 		*((unsigned short *)__va(0x472)) = reboot_mode;
@@ -427,6 +436,9 @@
 
 void machine_power_off(void)
 {
+#ifdef CONFIG_VISWS_HACKS
+	visws_power_off();
+#endif
 	if (pm_power_off)
 		pm_power_off();
 }
@@ -599,6 +611,37 @@
 
 	return 0;
 }
+
+#ifdef CONFIG_VISWS
+
+#include <linux/pci.h>
+#include <asm/sgi-piix.h>
+
+static void visws_restart(void)
+{
+	/*
+	 * Visual Workstations restart after this
+	 * register is poked on the PIIX4
+	 */
+	outb(PIIX4_RESET_VAL, PIIX4_RESET_PORT);
+}
+
+static void visws_power_off(void)
+{
+	unsigned short pm_status;
+
+	while((pm_status = inw(PMSTS_PORT)) & 0x100) {
+		outw(pm_status, PMSTS_PORT);
+	}
+
+	outw(PM_SUSPEND_ENABLE, PMCNTRL_PORT);
+
+	udelay(10000);
+
+	pcibios_write_config_dword(PIIX4_BUS, SPECIAL_DEV, SPECIAL_REG,
+				   PIIX_SPECIAL_STOP);
+}
+#endif /* CONFIG_VISWS */
 
 /*
  * fill in the user structure for a core dump..
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/setup.c linux-2.4.17-visws/arch/i386/kernel/setup.c
--- linux-2.4.17/arch/i386/kernel/setup.c	Fri Dec 21 09:41:53 2001
+++ linux-2.4.17-visws/arch/i386/kernel/setup.c	Wed Jan  2 17:24:56 2002
@@ -106,13 +106,16 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/smp.h>
-#include <asm/cobalt.h>
 #include <asm/msr.h>
 #include <asm/desc.h>
 #include <asm/e820.h>
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+#ifdef CONFIG_VISWS
+#include <asm/sgi-cobalt.h>
+#include <asm/sgi-piix.h>
+#endif
 /*
  * Machine setup..
  */
@@ -190,10 +193,6 @@
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000	
 
-#ifdef	CONFIG_VISWS
-char visws_board_type = -1;
-char visws_board_rev = -1;
-
 #define	PIIX_PM_START		0x0F80
 
 #define	SIO_GPIO_START		0x0FC0
@@ -236,7 +235,18 @@
 
 #define	SIO_PM_GP_EN	0x80
 
-static void __init visws_get_board_type_and_rev(void)
+#ifdef        CONFIG_VISWS
+char visws_board_type = -1;
+char visws_board_rev = -1;
+
+#ifdef CONFIG_VISWS_HACKS
+extern unsigned long sgivwfb_mem_phys;
+extern unsigned long sgivwfb_mem_size;
+void init_visws_smp(void);
+#endif
+
+static void __init
+visws_get_board_type_and_rev(void)
 {
 	int raw;
 
@@ -292,28 +302,31 @@
 	raw = inb_p(SIO_GP_DATA1);
 	raw &= 0x7f;	/* 7 bits of valid board revision ID. */
 
-	if (visws_board_type == VISWS_320) {
-		if (raw < 0x6) {
-			visws_board_rev = 4;
-		} else if (raw < 0xc) {
-			visws_board_rev = 5;
-		} else {
-			visws_board_rev = 6;
-	
-		}
-	} else if (visws_board_type == VISWS_540) {
-			visws_board_rev = 2;
-		} else {
-			visws_board_rev = raw;
-		}
-
-		printk(KERN_INFO "Silicon Graphics %s (rev %d)\n",
-			visws_board_type == VISWS_320 ? "320" :
-			(visws_board_type == VISWS_540 ? "540" :
-					"unknown"),
-					visws_board_rev);
-	}
-#endif
+	switch(visws_board_type) {
+	case VISWS_320:
+	     if (raw < 0x6) {
+		  visws_board_rev = 4;
+	     } else if (raw < 0xc) {
+		  visws_board_rev = 5;
+	     } else {
+		  visws_board_rev = 6;
+	     }
+	     break;
+	case VISWS_540:
+	     visws_board_rev = 2;
+	     break;
+	default:
+	     visws_board_rev = raw;
+	     break;
+	}
+
+	printk(KERN_INFO "Silicon Graphics %s (rev %d)\n",
+	       visws_board_type == VISWS_320 ? "320" :
+	       (visws_board_type == VISWS_540 ? "540" :
+		"unknown"),
+	       visws_board_rev);
+}
+#endif /* CONFIG_VISWS */
 
 
 static char command_line[COMMAND_LINE_SIZE];
@@ -700,10 +713,44 @@
 		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
 		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
   	}
-	printk(KERN_INFO "BIOS-provided physical RAM map:\n");
+	printk(KERN_DEBUG "BIOS-provided physical RAM map:\n");
 	print_memory_map(who);
 } /* setup_memory_region */
 
+#ifdef CONFIG_VISWS_HACKS
+void __init setup_visws_memory_region(void)
+{
+	/*
+	 * Some silly defaults until I find out how
+	 * to get the memory size.
+	 */
+	long long mem_size = 128 << 20;
+	long long gfx_mem_size = 16 << 20;
+	long long end_mem = HIGH_MEMORY + mem_size;
+
+	add_memory_region(0, LOWMEMSIZE(), E820_RAM);
+	add_memory_region(HIGH_MEMORY, mem_size, E820_RAM);
+	add_memory_region(end_mem, gfx_mem_size ,E820_RESERVED);
+	
+	/*
+	 * this hardcodes the graphics memory to 16 MB
+	 * it really should be sized dynamically (or at least
+	 * set as a boot param)
+	 */
+	if(!sgivwfb_mem_size)
+		sgivwfb_mem_size = gfx_mem_size;
+	
+	/*
+	 * Trim to nearest MB
+	 */
+	sgivwfb_mem_size &= ~((1<<20) - 1);
+	sgivwfb_mem_phys = end_mem;
+
+	printk(KERN_INFO "visws-hacked physical RAM map:\n");
+	print_memory_map("visws");
+}
+#endif /* CONFIG_VISWS_HACKS */
+
 
 static void __init parse_mem_cmdline (char ** cmdline_p)
 {
@@ -723,6 +770,13 @@
 		 * "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
 		 * <start> to <start>+<mem>, overriding the bios size.
 		 */
+#ifdef CONFIG_VISWS
+		if (c == ' ' && !memcmp(from,"gfxmem=",7)) {
+			if (to != command_line) to--;
+			sgivwfb_mem_size = memparse(from+7, &from);
+			printk("Got gfxmem size %ld\n", sgivwfb_mem_size);
+		}
+#endif
 		if (c == ' ' && !memcmp(from, "mem=", 4)) {
 			if (to != command_line)
 				to--;
@@ -757,7 +811,19 @@
 					mem_size -= HIGH_MEMORY;
 					usermem=0;
 				}
+#ifdef CONFIG_VISWS_HACKS
+				add_memory_region(start_at, 
+						  mem_size - sgivwfb_mem_size,
+						  E820_RAM);
+				add_memory_region(start_at + mem_size - 
+						  sgivwfb_mem_size,
+						  sgivwfb_mem_size,
+						  E820_RESERVED);
+				sgivwfb_mem_phys = start_at + mem_size - 
+				     sgivwfb_mem_size;
+#else
 				add_memory_region(start_at, mem_size, E820_RAM);
+#endif /* CONFIG_VISWS_HACKS */
 			}
 		}
 		/* acpismp=force forces parsing and use of the ACPI SMP table */
@@ -773,7 +839,7 @@
 	}
 	*to = '\0';
 	*cmdline_p = command_line;
-	if (usermem) {
+	if (1) {
 		printk(KERN_INFO "user-defined physical RAM map:\n");
 		print_memory_map("user");
 	}
@@ -787,11 +853,12 @@
 
 #ifdef CONFIG_VISWS
 	visws_get_board_type_and_rev();
-#endif
+#else /* !CONFIG_VISWS */
 
  	ROOT_DEV = to_kdev_t(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
+#endif
 	apm_info.bios = APM_BIOS_INFO;
 	if( SYS_DESC_TABLE.length != 0 ) {
 		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
@@ -806,7 +873,13 @@
 	rd_prompt = ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) != 0);
 	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
 #endif
+
+#ifdef CONFIG_VISWS_HACKS
+	boot_cpu_data.hlt_works_ok = 0;
+	setup_visws_memory_region();
+#else
 	setup_memory_region();
+#endif /* CONFIG_VISWS_HACKS */
 
 	if (!MOUNT_ROOT_RDONLY)
 		root_mountflags &= ~MS_RDONLY;
@@ -822,6 +895,7 @@
 
 	parse_mem_cmdline(cmdline_p);
 
+
 #define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
 #define PFN_PHYS(x)	((x) << PAGE_SHIFT)
@@ -985,6 +1059,7 @@
 #ifdef CONFIG_SMP
 	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
 #endif
+
 	paging_init();
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
@@ -992,8 +1067,12 @@
 	 */
 	if (smp_found_config)
 		get_smp_config();
-	init_apic_mappings();
+#ifdef CONFIG_X86_VISWS_APIC
+	init_visws_smp();
 #endif
+	init_apic_mappings();
+
+#endif /* CONFIG_X86_LOCAL_APIC */
 
 
 	/*
@@ -1038,7 +1117,7 @@
 		pci_mem_start = low_mem_size;
 
 #ifdef CONFIG_VT
-#if defined(CONFIG_VGA_CONSOLE)
+#if defined(CONFIG_VGA_CONSOLE) && !defined(CONFIG_VISWS)
 	conswitchp = &vga_con;
 #elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/smp.c linux-2.4.17-visws/arch/i386/kernel/smp.c
--- linux-2.4.17/arch/i386/kernel/smp.c	Fri Dec 21 09:41:53 2001
+++ linux-2.4.17-visws/arch/i386/kernel/smp.c	Wed Jan  2 16:45:21 2002
@@ -137,7 +137,9 @@
 	/*
 	 * Wait for idle.
 	 */
+#ifndef CONFIG_VISWS_HACKS
 	apic_wait_icr_idle();
+#endif
 
 	/*
 	 * No need to touch the target chip field
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/smpboot.c linux-2.4.17-visws/arch/i386/kernel/smpboot.c
--- linux-2.4.17/arch/i386/kernel/smpboot.c	Fri Dec 21 09:41:53 2001
+++ linux-2.4.17-visws/arch/i386/kernel/smpboot.c	Wed Jan  2 16:45:21 2002
@@ -1068,9 +1068,9 @@
 		smp_num_cpus = 1;
 		goto smp_done;
 	}
-
-	verify_local_APIC();
-
+#ifndef CONFIG_VISWS_HACKS
+ 	verify_local_APIC();
+#endif
 	/*
 	 * If SMP should be disabled, then really disable it!
 	 */
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/time.c linux-2.4.17-visws/arch/i386/kernel/time.c
--- linux-2.4.17/arch/i386/kernel/time.c	Sun Nov 11 10:20:21 2001
+++ linux-2.4.17-visws/arch/i386/kernel/time.c	Wed Jan  2 16:45:21 2002
@@ -56,7 +56,7 @@
 #include <linux/config.h>
 
 #include <asm/fixmap.h>
-#include <asm/cobalt.h>
+#include <asm/sgi-cobalt.h>
 
 /*
  * for x86_do_profile()
@@ -708,10 +708,6 @@
 
 	/* Enable (unmask) the timer interrupt */
 	co_cpu_write(CO_CPU_CTRL, co_cpu_read(CO_CPU_CTRL) & ~CO_CTRL_TIMEMASK);
-
-	/* Wire cpu IDT entry to s/w handler (and Cobalt APIC to IDT) */
-	setup_irq(CO_IRQ_TIMER, &irq0);
-#else
-	setup_irq(0, &irq0);
 #endif
+	setup_irq(0, &irq0);
 }
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/trampoline.S linux-2.4.17-visws/arch/i386/kernel/trampoline.S
--- linux-2.4.17/arch/i386/kernel/trampoline.S	Thu Oct  4 18:42:54 2001
+++ linux-2.4.17-visws/arch/i386/kernel/trampoline.S	Wed Jan  2 16:45:21 2002
@@ -56,7 +56,11 @@
 	lmsw	%ax		# into protected mode
 	jmp	flush_instr
 flush_instr:
+#ifdef CONFIG_VISWS_HACKS
+	ljmpl	$__KERNEL_CS, $0x0010002e
+#else
 	ljmpl	$__KERNEL_CS, $0x00100000
+#endif
 			# jump to startup_32 in arch/i386/kernel/head.S
 
 idt_48:
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/traps.c linux-2.4.17-visws/arch/i386/kernel/traps.c
--- linux-2.4.17/arch/i386/kernel/traps.c	Sun Sep 30 12:26:08 2001
+++ linux-2.4.17-visws/arch/i386/kernel/traps.c	Wed Jan  2 16:45:22 2002
@@ -43,8 +43,8 @@
 
 #ifdef CONFIG_X86_VISWS_APIC
 #include <asm/fixmap.h>
-#include <asm/cobalt.h>
-#include <asm/lithium.h>
+#include <asm/sgi-cobalt.h>
+#include <asm/sgi-lithium.h>
 #endif
 
 #include <linux/irq.h>
@@ -825,56 +825,6 @@
 
 #ifdef CONFIG_X86_VISWS_APIC
 
-/*
- * On Rev 005 motherboards legacy device interrupt lines are wired directly
- * to Lithium from the 307.  But the PROM leaves the interrupt type of each
- * 307 logical device set appropriate for the 8259.  Later we'll actually use
- * the 8259, but for now we have to flip the interrupt types to
- * level triggered, active lo as required by Lithium.
- */
-
-#define	REG	0x2e	/* The register to read/write */
-#define	DEV	0x07	/* Register: Logical device select */
-#define	VAL	0x2f	/* The value to read/write */
-
-static void
-superio_outb(int dev, int reg, int val)
-{
-	outb(DEV, REG);
-	outb(dev, VAL);
-	outb(reg, REG);
-	outb(val, VAL);
-}
-
-static int __attribute__ ((unused))
-superio_inb(int dev, int reg)
-{
-	outb(DEV, REG);
-	outb(dev, VAL);
-	outb(reg, REG);
-	return inb(VAL);
-}
-
-#define	FLOP	3	/* floppy logical device */
-#define	PPORT	4	/* parallel logical device */
-#define	UART5	5	/* uart2 logical device (not wired up) */
-#define	UART6	6	/* uart1 logical device (THIS is the serial port!) */
-#define	IDEST	0x70	/* int. destination (which 307 IRQ line) reg. */
-#define	ITYPE	0x71	/* interrupt type register */
-
-/* interrupt type bits */
-#define	LEVEL	0x01	/* bit 0, 0 == edge triggered */
-#define	ACTHI	0x02	/* bit 1, 0 == active lo */
-
-static void
-superio_init(void)
-{
-	if (visws_board_type == VISWS_320 && visws_board_rev == 5) {
-		superio_outb(UART6, IDEST, 0);	/* 0 means no intr propagated */
-		printk("SGI 320 rev 5: disabling 307 uart1 interrupt\n");
-	}
-}
-
 static void
 lithium_init(void)
 {
@@ -885,9 +835,11 @@
 	printk("Lithium PCI Bridge B (PIIX4), Bus Number: %d\n",
 				li_pcib_read16(LI_PCI_BUSNUM) & 0xff);
 
-	/* XXX blindly enables all interrupts */
-	li_pcia_write16(LI_PCI_INTEN, 0xffff);
-	li_pcib_write16(LI_PCI_INTEN, 0xffff);
+#define A01234 (LI_INTA_0|LI_INTA_1|LI_INTA_2|LI_INTA_3|LI_INTA_4)
+#define BCD (LI_INTB|LI_INTC|LI_INTD)
+#define ALLDEVS (A01234|BCD)
+	li_pcia_write16(LI_PCI_INTEN, ALLDEVS);
+	li_pcib_write16(LI_PCI_INTEN, ALLDEVS);
 }
 
 static void
@@ -898,6 +850,7 @@
 	 * use it and set it up here to start the Cobalt clock
 	 */
 	set_fixmap(FIX_APIC_BASE, APIC_DEFAULT_PHYS_BASE);
+	setup_local_APIC();
 	printk("Local APIC ID %lx\n", apic_read(APIC_ID));
 	printk("Local APIC Version %lx\n", apic_read(APIC_LVR));
 
@@ -956,7 +909,6 @@
 	cpu_init();
 
 #ifdef CONFIG_X86_VISWS_APIC
-	superio_init();
 	lithium_init();
 	cobalt_init();
 #endif
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/arch/i386/kernel/visws_apic.c linux-2.4.17-visws/arch/i386/kernel/visws_apic.c
--- linux-2.4.17/arch/i386/kernel/visws_apic.c	Fri Feb  9 11:29:44 2001
+++ linux-2.4.17-visws/arch/i386/kernel/visws_apic.c	Wed Jan  2 17:22:28 2002
@@ -10,6 +10,8 @@
  *  hardware in the system uses this controller directly.  Legacy devices
  *  are connected to the PIIX4 which in turn has its 8259(s) connected to
  *  a of the Cobalt APIC entry.
+ *
+ *  09/02/2000 - Updated for 2.4 by jbarnes@sgi.com
  */
 
 #include <linux/ptrace.h>
@@ -24,6 +26,7 @@
 #include <linux/random.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
+#include <linux/irq.h>
 #include <linux/init.h>
 
 #include <asm/system.h>
@@ -34,10 +37,17 @@
 #include <asm/pgtable.h>
 #include <asm/delay.h>
 #include <asm/desc.h>
+#include <asm/sgi-cobalt.h>
 
-#include <asm/cobalt.h>
+int irq_vector[NR_IRQS] = { FIRST_EXTERNAL_VECTOR, 0 };
 
-#include <linux/irq.h>
+#define IRQ_VECTOR(irq) irq_vector[irq]
+
+static spinlock_t cobalt_lock = SPIN_LOCK_UNLOCKED;
+
+static void dump_cobalt_vectors(void);
+static void co_apic_set(int, int);
+static int assign_irq_vector(int irq);
 
 /*
  * This is the PIIX4-based 8259 that is wired up indirectly to Cobalt
@@ -49,57 +59,63 @@
  * interrupt controller type, and through a special virtual interrupt-
  * controller. Device drivers only see the virtual interrupt sources.
  */
-
-#define	CO_IRQ_BASE	0x20	/* This is the 0x20 in init_IRQ()! */
-
-static void startup_piix4_master_irq(unsigned int irq);
+static unsigned int startup_piix4_master_irq(unsigned int irq);
 static void shutdown_piix4_master_irq(unsigned int irq);
-static void do_piix4_master_IRQ(unsigned int irq, struct pt_regs * regs);
-#define enable_piix4_master_irq startup_piix4_master_irq
-#define disable_piix4_master_irq shutdown_piix4_master_irq
+static void ack_piix4_master_irq(unsigned int irq);
+static void end_piix4_master_irq(unsigned int irq);
+static void enable_piix4_master_irq(unsigned int irq)
+{ startup_piix4_master_irq(irq); }
+static void disable_piix4_master_irq(unsigned int irq)
+{ shutdown_piix4_master_irq(irq); }
 
 static struct hw_interrupt_type piix4_master_irq_type = {
 	"PIIX4-master",
 	startup_piix4_master_irq,
 	shutdown_piix4_master_irq,
-	do_piix4_master_IRQ,
 	enable_piix4_master_irq,
-	disable_piix4_master_irq
+	disable_piix4_master_irq,
+	ack_piix4_master_irq,
+	end_piix4_master_irq
 };
 
-static void enable_piix4_virtual_irq(unsigned int irq);
-static void disable_piix4_virtual_irq(unsigned int irq);
-#define startup_piix4_virtual_irq enable_piix4_virtual_irq
-#define shutdown_piix4_virtual_irq disable_piix4_virtual_irq
+static unsigned int startup_piix4_virtual_irq(unsigned int irq);
+static void shutdown_piix4_virtual_irq(unsigned int irq);
+static void ack_piix4_virtual_irq(unsigned int irq) { }
+static void end_piix4_virtual_irq(unsigned int irq) { }
+static void enable_piix4_virtual_irq(unsigned int irq)
+{ startup_piix4_virtual_irq(irq); }
+static void disable_piix4_virtual_irq(unsigned int irq)
+{ shutdown_piix4_virtual_irq(irq); }
 
 static struct hw_interrupt_type piix4_virtual_irq_type = {
 	"PIIX4-virtual",
 	startup_piix4_virtual_irq,
 	shutdown_piix4_virtual_irq,
-	0, /* no handler, it's never called physically */
 	enable_piix4_virtual_irq,
-	disable_piix4_virtual_irq
+	disable_piix4_virtual_irq,
+	ack_piix4_virtual_irq,
+	end_piix4_virtual_irq
 };
 
 /*
  * This is the SGI Cobalt (IO-)APIC:
  */
 
-static void do_cobalt_IRQ(unsigned int irq, struct pt_regs * regs);
 static void enable_cobalt_irq(unsigned int irq);
 static void disable_cobalt_irq(unsigned int irq);
-static void startup_cobalt_irq(unsigned int irq);
-#define shutdown_cobalt_irq disable_cobalt_irq
-
-static spinlock_t irq_controller_lock = SPIN_LOCK_UNLOCKED;
+static unsigned int startup_cobalt_irq(unsigned int irq);
+static void shutdown_cobalt_irq(unsigned int irq);
+static void ack_cobalt_irq(unsigned int irq);
+static void end_cobalt_irq(unsigned int irq);
 
 static struct hw_interrupt_type cobalt_irq_type = {
 	"Cobalt-APIC",
 	startup_cobalt_irq,
 	shutdown_cobalt_irq,
-	do_cobalt_IRQ,
 	enable_cobalt_irq,
-	disable_cobalt_irq
+	disable_cobalt_irq,
+	ack_cobalt_irq,
+	end_cobalt_irq
 };
 
 
@@ -115,120 +131,112 @@
  * Cobalt (IO)-APIC functions to handle PCI devices.
  */
 
+static int co_apic_ide0_hack(void)
+{
+	extern char visws_board_type;
+	extern char visws_board_rev;
+
+	if(visws_board_type == VISWS_320 && visws_board_rev == 5)
+		return 5;
+	return CO_APIC_IDE0;
+}
+
+static int is_co_apic(unsigned int irq)
+{
+	if(IS_CO_APIC(irq))
+		return CO_APIC(irq);
+
+	switch(irq) {
+	case 0: return CO_APIC_CPU;
+	case CO_IRQ_IDE0: return co_apic_ide0_hack();
+	case CO_IRQ_IDE1: return CO_APIC_IDE1;
+	default: return -1;
+	}
+}
+
 static void disable_cobalt_irq(unsigned int irq)
 {
-	/* XXX undo the APIC entry here? */
+	int entry = is_co_apic(irq);
 
-	/*
-	 * definitely, we do not want to have IRQ storms from
-	 * unused devices --mingo
-	 */
+	if(entry == -1) {
+		printk(KERN_ERR "**** Tried to disable non-Cobalt IRQ %d!", irq);
+		return;
+	}
+
+	co_apic_write(CO_APIC_LO(entry), CO_APIC_MASK);
+	(void)co_apic_read(CO_APIC_LO(entry));
 }
 
 static void enable_cobalt_irq(unsigned int irq)
 {
+	int ent = is_co_apic(irq);
+
+	if(ent == -1) {
+		printk(KERN_ERR "**** Tried to enable non-Cobalt IRQ %d!", irq);
+		return;
+	}
+	co_apic_set(ent, irq);
 }
 
 /*
  * Set the given Cobalt APIC Redirection Table entry to point
  * to the given IDT vector/index.
  */
-static void co_apic_set(int entry, int idtvec)
+static void co_apic_set(int entry, int irq)
 {
-	co_apic_write(CO_APIC_LO(entry), CO_APIC_LEVEL | (CO_IRQ_BASE+idtvec));
+	co_apic_write(CO_APIC_LO(entry), CO_APIC_LEVEL|IRQ_VECTOR(irq));
+/*	co_apic_write(CO_APIC_LO(entry), CO_APIC_LEVEL| (0x20+irq)); */
 	co_apic_write(CO_APIC_HI(entry), 0);
-
-	printk("Cobalt APIC Entry %d IDT Vector %d\n", entry, idtvec);
 }
 
 /*
  * "irq" really just serves to identify the device.  Here is where we
  * map this to the Cobalt APIC entry where it's physically wired.
- * This is called via request_irq -> setup_x86_irq -> irq_desc->startup()
+ * This is called via request_irq -> setup_irq -> irq_desc->startup()
  */
-static void startup_cobalt_irq(unsigned int irq)
+extern struct desc_struct idt_table[256];
+static unsigned int startup_cobalt_irq(unsigned int irq)
 {
-	/*
-	 * These "irq"'s are wired to the same Cobalt APIC entries
-	 * for all (known) motherboard types/revs
-	 */
-	switch (irq) {
-	case CO_IRQ_TIMER:	co_apic_set(CO_APIC_CPU, CO_IRQ_TIMER);
-				return;
-
-	case CO_IRQ_ENET:	co_apic_set(CO_APIC_ENET, CO_IRQ_ENET);
-				return;
-
-	case CO_IRQ_SERIAL:	return; /* XXX move to piix4-8259 "virtual" */
-
-	case CO_IRQ_8259:	co_apic_set(CO_APIC_8259, CO_IRQ_8259);
-				return;
-
-	case CO_IRQ_IDE:
-		switch (visws_board_type) {
-		case VISWS_320:
-			switch (visws_board_rev) {
-			case 5:
-				co_apic_set(CO_APIC_0_5_IDE0, CO_IRQ_IDE);
-				co_apic_set(CO_APIC_0_5_IDE1, CO_IRQ_IDE);
-					return;
-			case 6:
-				co_apic_set(CO_APIC_0_6_IDE0, CO_IRQ_IDE);
-				co_apic_set(CO_APIC_0_6_IDE1, CO_IRQ_IDE);
-					return;
-			}
-		case VISWS_540:
-			switch (visws_board_rev) {
-			case 2:
-				co_apic_set(CO_APIC_1_2_IDE0, CO_IRQ_IDE);
-					return;
-			}
-		}
-		break;
-	default:
-		panic("huh?");
-	}
+	unsigned long flags;
+	if(irq == 4)
+		return 0; /* serial hack? */
+	printk(KERN_WARNING "IRQ %d, Cobalt APIC entry %d, IDT vector %x: starting up\n",
+	       irq, is_co_apic(irq), IRQ_VECTOR(irq));
+	spin_lock_irqsave(&cobalt_lock, flags);
+	if ((irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS|IRQ_WAITING)))
+		irq_desc[irq].status &= ~(IRQ_DISABLED|IRQ_INPROGRESS|IRQ_WAITING);
+	enable_cobalt_irq(irq);
+	spin_unlock_irqrestore(&cobalt_lock, flags);
+	return 0;
 }
 
-/*
- * This is the handle() op in do_IRQ()
- */
-static void do_cobalt_IRQ(unsigned int irq, struct pt_regs * regs)
+static void shutdown_cobalt_irq(unsigned int irq)
 {
-	struct irqaction * action;
-	irq_desc_t *desc = irq_desc + irq;
-
-	spin_lock(&irq_controller_lock);
-	{
-		unsigned int status;
-		/* XXX APIC EOI? */
-		status = desc->status & ~(IRQ_REPLAY | IRQ_WAITING);
-		action = NULL;
-		if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-			action = desc->action;
-			status |= IRQ_INPROGRESS;
-		}
-		desc->status = status;
-	}
-	spin_unlock(&irq_controller_lock);
+	if(irq == 4)
+		return; /* serial hack? */
+	printk(KERN_WARNING "IRQ %d, Cobalt APIC entry %d, IDT vector %x: shutting down\n",
+	       irq, is_co_apic(irq), IRQ_VECTOR(irq));
+	disable_cobalt_irq(irq);
+}
 
-	/* Exit early if we had no action or it was disabled */
-	if (!action)
-		return;
+static void ack_cobalt_irq(unsigned int irq)
+{
+	unsigned long flags;
 
-	handle_IRQ_event(irq, regs, action);
+	spin_lock_irqsave(&cobalt_lock, flags);
+	disable_cobalt_irq(irq);
+	apic_write(APIC_EOI, APIC_EIO_ACK);
+	spin_unlock_irqrestore(&cobalt_lock, flags);
+}
 
-	(void)co_cpu_read(CO_CPU_REV); /* Sync driver ack to its h/w */
-	apic_write(APIC_EOI, APIC_EIO_ACK); /* Send EOI to Cobalt APIC */
+static void end_cobalt_irq(unsigned int irq)
+{
+	unsigned long flags;
 
-	spin_lock(&irq_controller_lock);
-	{
-		unsigned int status = desc->status & ~IRQ_INPROGRESS;
-		desc->status = status;
-		if (!(status & IRQ_DISABLED))
-			enable_cobalt_irq(irq);
-	}
-	spin_unlock(&irq_controller_lock);
+	spin_lock_irqsave(&cobalt_lock, flags);
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		enable_cobalt_irq(irq);
+	spin_unlock_irqrestore(&cobalt_lock, flags);
 }
 
 /*
@@ -237,7 +245,8 @@
  *	floppy
  *	parallel
  *	serial
- *	audio (?)
+ *      [ps2 kbd]
+ *      [ps2 mouse]
  *
  * None of these get Cobalt APIC entries, neither do they have IDT
  * entries. These interrupts are purely virtual and distributed from
@@ -251,7 +260,7 @@
  * manipulated by any driver.
  */
 
-static void startup_piix4_master_irq(unsigned int irq)
+static unsigned int startup_piix4_master_irq(unsigned int irq)
 {
 	/* ICW1 */
 	outb(0x11, 0x20);
@@ -285,15 +294,24 @@
 	shutdown_cobalt_irq(irq);
 }
 
-static void do_piix4_master_IRQ(unsigned int irq, struct pt_regs * regs)
+static void ack_piix4_master_irq(unsigned int irq)
+{
+}
+
+static void end_piix4_master_irq(unsigned int irq)
+{
+}
+
+void piix4_master_intr(int irq, void *dev_id, struct pt_regs * regs)
 {
 	int realirq, mask;
+	irq_desc_t *desc;
 
 	/* Find out what's interrupting in the PIIX4 8259 */
 
-	spin_lock(&irq_controller_lock);
 	outb(0x0c, 0x20);		/* OCW3 Poll command */
 	realirq = inb(0x20);
+	desc = irq_desc + realirq;
 
 	if (!(realirq & 0x80)) {
 		/*
@@ -319,92 +337,176 @@
 	 */
 	outb(0x20, 0x20);
 
-	spin_unlock(&irq_controller_lock);
-
 	/*
 	 * handle this 'virtual interrupt' as a Cobalt one now.
 	 */
 	kstat.irqs[smp_processor_id()][irq]++;
-	do_cobalt_IRQ(realirq, regs);
-
-	spin_lock(&irq_controller_lock);
+	kstat.irqs[smp_processor_id()][realirq]++;
+	handle_IRQ_event(realirq, regs, desc->action);
 	{
-		irq_desc_t *desc = irq_desc + realirq;
-
 		if (!(desc->status & IRQ_DISABLED))
 			enable_piix4_virtual_irq(realirq);
 	}
-	spin_unlock(&irq_controller_lock);
 	return;
 
 out_unlock:
-	spin_unlock(&irq_controller_lock);
 	return;
 }
 
-static void enable_piix4_virtual_irq(unsigned int irq)
+static unsigned int startup_piix4_virtual_irq(unsigned int irq)
 {
 	/*
 	 * assumes this irq is one of the legacy devices
-	 */
-
 	unsigned int mask = inb(0x21);
  	mask &= ~(1 << irq);
-	outb(mask, 0x21);
-	enable_cobalt_irq(irq);
+	outb(mask, 0x21);*/
+	return 0;
 }
 
 /*
  * assumes this irq is one of the legacy devices
  */
-static void disable_piix4_virtual_irq(unsigned int irq)
+static void shutdown_piix4_virtual_irq(unsigned int irq)
+{/*
+	unsigned int mask = inb(0x21);
+ 	mask &= ~(1 << irq);
+	outb(mask, 0x21);*/
+}
+
+static struct irqaction master_action =
+		{ piix4_master_intr, 0, 0, "piix4_master_intr", NULL, NULL };
+
+int visws_get_PCI_irq_vector(int bus, int slot, int line)
 {
-	unsigned int mask;
+	int irq;
+#define BRIDGE_A	1	/* XXX simplistic bus numbering! */
+#define	BRIDGE_B	0	/* XXX simplistic bus numbering! */
+/* XXX note how we pass the bus number as the "bridge id" -- simplistic! */
+#define BASE(bridge)	((bridge) == BRIDGE_B ? \
+					CO_APIC_PCIB_BASE0 : \
+					CO_APIC_PCIA_BASE0)
+	/*
+	 * PIIX4 USB is on Bus 0, Slot 4, Line 3
+	 */
+	if (bus == BRIDGE_B && slot == 4 && line == 3) {
+		irq = CO_IRQ(CO_APIC_PIIX4_USB);
+		goto out;
+	}
 
-	disable_cobalt_irq(irq);
+	/* 
+	 * First pin spread down 1 APIC entry per slot
+	 */
+	if (line == 0) { 
+		irq = CO_IRQ(BASE(bus) + slot);
+		goto out;
+	}
 
-	mask = inb(0x21);
- 	mask &= ~(1 << irq);
-	outb(mask, 0x21);
+	/* lines 1,2,3 from any slot is shared in this twirly pattern */
+	if (bus == BRIDGE_A) {
+		/* lines 1-3 from devices 0 1 rotate over 2 apic entries */
+		irq = CO_IRQ(CO_APIC_PCIA_BASE123 + ((slot + (line-1)) % 2));
+		goto out;
+	} else { /* bus == BRIDGE_B */
+		/* lines 1-3 from devices 0-3 rotate over 3 apic entries */
+		if (slot == 0) slot = 3; /* same pattern */
+		irq = CO_IRQ(CO_APIC_PCIA_BASE123 + ((3-slot) + (line-1) % 3));
+		goto out;
+	}
+ out:
+	printk(KERN_DEBUG "get_irq_vector: Bus %d Slot %d Line %d -> IRQ %d\n",
+	       bus, slot, line, irq);
+	return irq;
+#undef BRIDGE_A
+#undef BRIDGE_B
+#undef BASE
 }
 
-static struct irqaction master_action =
-		{ no_action, 0, 0, "PIIX4-8259", NULL, NULL };
+#if (CO_IRQ_APIC0 + CO_APIC_LAST + 1) > NR_IRQS
+#error NR_IRQS too small
+#endif
+
+extern void (*interrupt[NR_IRQS])(void);
 
 void init_VISWS_APIC_irqs(void)
 {
 	int i;
 
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < CO_IRQ_APIC0 + CO_APIC_LAST + 1; i++) {
 		irq_desc[i].status = IRQ_DISABLED;
 		irq_desc[i].action = 0;
 		irq_desc[i].depth = 1;
 
-		/*
-		 * Cobalt IRQs are mapped to standard ISA
-		 * interrupt vectors:
-		 */
-		switch (i) {
-			/*
-			 * Only CO_IRQ_8259 will be raised
-			 * externally.
-			 */
-		case CO_IRQ_8259:
+		if(i == 0) {
+			irq_desc[i].handler = &cobalt_irq_type;
+		}
+		else if(i == 4) {
+			irq_desc[i].handler = &cobalt_irq_type;
+		}
+		else if(i == CO_IRQ_IDE0) {
+			irq_desc[i].handler = &cobalt_irq_type;
+		}
+		else if(i == CO_IRQ_IDE1) {
+			irq_desc[i].handler = &cobalt_irq_type;
+		}/*
+		else if(i == CO_IRQ_8259) {
 			irq_desc[i].handler = &piix4_master_irq_type;
-			break;
-		case CO_IRQ_FLOPPY:
-		case CO_IRQ_PARLL:
+		}
+		else if(i < CO_IRQ_APIC0) {
 			irq_desc[i].handler = &piix4_virtual_irq_type;
-			break;
-		default:
+			}*/
+		else if(IS_CO_APIC(i)) {
 			irq_desc[i].handler = &cobalt_irq_type;
-			break;
 		}
+		assign_irq_vector(i);
 	}
+/*
+	setup_irq(CO_IRQ_8259, &master_action);
+*/
+}
 
-	/*
-	 * The master interrupt is always present:
-	 */
-	setup_x86_irq(CO_IRQ_8259, &master_action);
+static int __init assign_irq_vector(int irq)
+{
+        static int current_vector = FIRST_EXTERNAL_VECTOR;
+
+	IRQ_VECTOR(irq) = irq + FIRST_EXTERNAL_VECTOR;
+	return IRQ_VECTOR(irq);
+
+	if(IRQ_VECTOR(irq) > 0) {
+		printk("Assigned IRQ %d to IDT %x\n", irq, IRQ_VECTOR(irq));
+		return IRQ_VECTOR(irq);
+	}
+
+ next:
+	current_vector += 1;
+	if(current_vector == SYSCALL_VECTOR)
+		goto next;
+
+	if(current_vector == FIRST_SYSTEM_VECTOR)
+		panic("ran out of interrupt sources!");
+
+	IRQ_VECTOR(irq) = current_vector;
+
+	printk("Assigned IRQ %d to IDT %x\n", irq, IRQ_VECTOR(irq));
+
+	return current_vector;
 }
 
+int get_cobalt_entries(char *buf)
+{
+	int i;
+	unsigned long value;
+	char *p = buf;
+
+	p += sprintf(p, "Entry    Value         Notes\n");
+	for(i = 0; i < CO_IRQ_APIC0 + CO_APIC_LAST + 1; i++) {
+		p += sprintf(p, "%2d       ", i);
+		value = co_apic_read(CO_APIC_LO(i));
+		p += sprintf(p, "0x%08lx    ", value);
+		if(value & CO_APIC_MASK)
+			p += sprintf(p, "masked ");
+		if(value & CO_APIC_LEVEL)
+			p += sprintf(p, "level " );
+		p += sprintf(p, "\n");
+	}
+	return p - buf;
+}
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/drivers/net/eepro100.c linux-2.4.17-visws/drivers/net/eepro100.c
--- linux-2.4.17/drivers/net/eepro100.c	Fri Dec 21 09:41:54 2001
+++ linux-2.4.17-visws/drivers/net/eepro100.c	Wed Jan  2 19:50:04 2002
@@ -302,6 +302,7 @@
 	outw(val, port);
 }
 
+#define USE_IO
 #ifndef USE_IO
 /* Currently alpha headers define in/out macros.
    Undefine them.  2000/03/30  SAW */
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/drivers/video/sgivwfb.c linux-2.4.17-visws/drivers/video/sgivwfb.c
--- linux-2.4.17/drivers/video/sgivwfb.c	Wed Nov 14 14:52:20 2001
+++ linux-2.4.17-visws/drivers/video/sgivwfb.c	Wed Jan  2 17:24:22 2002
@@ -49,8 +49,8 @@
  */
 
 /* set by arch/i386/kernel/setup.c */
-u_long                sgivwfb_mem_phys;
-u_long                sgivwfb_mem_size;
+unsigned long sgivwfb_mem_phys;
+unsigned long sgivwfb_mem_size;
 
 static volatile char  *fbmem;
 static asregs         *regs;
@@ -86,6 +86,18 @@
   0				/* par not activated */
 };
 
+static struct sgivwfb_par par_current_new = {
+  {                             /* var (screeninfo) */
+    /* 800x600, 16 bpp */
+    800, 600, 800, 600, 0, 0, 16, 0,
+    {0, 16, 0}, {0, 16, 0}, {0, 16, 0}, {0, 0, 0},
+    0, 0, -1, -1, 0, 25000, 88, 40, 23, 1, 128, 4,
+    0, FB_VMODE_NONINTERLACED
+  },
+  0,                            /* timing_num */
+  0				/* par not activated */
+};
+
 /*
  *  Interface used by the world
  */
@@ -660,7 +672,6 @@
 
   /* XXX FIXME - should try to pick best refresh rate */
   /* for now, pick closest dot-clock within 3MHz*/
-#error "Floating point not allowed in kernel"  
   req_dot = (int)((1.0e3/1.0e6) / (1.0e-12 * (float)var->pixclock));
   printk(KERN_INFO "sgivwfb: requested pixclock=%d ps (%d KHz)\n", var->pixclock,
 	 req_dot);
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/fs/proc/proc_misc.c linux-2.4.17-visws/fs/proc/proc_misc.c
--- linux-2.4.17/fs/proc/proc_misc.c	Tue Nov 20 21:29:09 2001
+++ linux-2.4.17-visws/fs/proc/proc_misc.c	Wed Jan  2 16:45:22 2002
@@ -64,6 +64,9 @@
 #ifdef CONFIG_SGI_DS1286
 extern int get_ds1286_status(char *);
 #endif
+#ifdef CONFIG_X86_VISWS_APIC
+extern int get_cobalt_entries(char *);
+#endif
 
 static int proc_calc_metrics(char *page, char **start, off_t off,
 				 int count, int *eof, int len)
@@ -337,6 +340,15 @@
 }
 #endif
 
+#ifdef CONFIG_X86_VISWS_APIC
+static int cobalt_read_proc(char *page, char **start, off_t off,
+			    int count, int *eof, void *data)
+{
+	int len = get_cobalt_entries(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+#endif
+
 static int filesystems_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -514,6 +526,9 @@
 		{"partitions",	partitions_read_proc},
 #if !defined(CONFIG_ARCH_S390)
 		{"interrupts",	interrupts_read_proc},
+#endif
+#ifdef CONFIG_X86_VISWS_APIC
+		{"cobalt",      cobalt_read_proc},
 #endif
 		{"filesystems",	filesystems_read_proc},
 		{"dma",		dma_read_proc},
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/include/asm-i386/cobalt.h linux-2.4.17-visws/include/asm-i386/cobalt.h
--- linux-2.4.17/include/asm-i386/cobalt.h	Thu Jul 26 13:41:22 2001
+++ linux-2.4.17-visws/include/asm-i386/cobalt.h	Wed Dec 31 16:00:00 1969
@@ -1,117 +0,0 @@
-#include <linux/config.h>
-#ifndef __I386_COBALT_H
-#define __I386_COBALT_H
-
-/*
- * Cobalt is the system ASIC on the SGI 320 and 540 Visual Workstations
- */ 
-
-#define	CO_CPU_PHYS		0xc2000000
-#define	CO_APIC_PHYS		0xc4000000
-
-/* see set_fixmap() and asm/fixmap.h */
-#define	CO_CPU_VADDR		(fix_to_virt(FIX_CO_CPU))
-#define	CO_APIC_VADDR		(fix_to_virt(FIX_CO_APIC))
-
-/* Cobalt CPU registers -- relative to CO_CPU_VADDR, use co_cpu_*() */
-#define	CO_CPU_REV		0x08
-#define	CO_CPU_CTRL		0x10
-#define	CO_CPU_STAT		0x20
-#define	CO_CPU_TIMEVAL		0x30
-
-/* CO_CPU_CTRL bits */
-#define	CO_CTRL_TIMERUN		0x04	/* 0 == disabled */
-#define	CO_CTRL_TIMEMASK	0x08	/* 0 == unmasked */
-
-/* CO_CPU_STATUS bits */
-#define	CO_STAT_TIMEINTR	0x02	/* (r) 1 == int pend, (w) 0 == clear */
-
-/* CO_CPU_TIMEVAL value */
-#define	CO_TIME_HZ		100000000 /* Cobalt core rate */
-
-/* Cobalt APIC registers -- relative to CO_APIC_VADDR, use co_apic_*() */
-#define	CO_APIC_HI(n)		(((n) * 0x10) + 4)
-#define	CO_APIC_LO(n)		((n) * 0x10)
-#define	CO_APIC_ID		0x0ffc
-
-/* CO_APIC_ID bits */
-#define	CO_APIC_ENABLE		0x00000100
-
-/* CO_APIC_LO bits */
-#define	CO_APIC_LEVEL		0x08000		/* 0 = edge */
-
-/*
- * Where things are physically wired to Cobalt
- * #defines with no board _<type>_<rev>_ are common to all (thus far)
- */
-#define CO_APIC_0_5_IDE0	5
-#define	CO_APIC_0_5_SERIAL	13	 /* XXX not really...h/w bug! */
-#define CO_APIC_0_5_PARLL	4
-#define CO_APIC_0_5_FLOPPY	6
-
-#define	CO_APIC_0_6_IDE0	4
-#define	CO_APIC_0_6_USB	7	/* PIIX4 USB */
-
-#define	CO_APIC_1_2_IDE0	4
-
-#define CO_APIC_0_5_IDE1	2
-#define CO_APIC_0_6_IDE1	2
-
-/* XXX */
-#define	CO_APIC_IDE0	CO_APIC_0_5_IDE0
-#define	CO_APIC_IDE1	CO_APIC_0_5_IDE1
-#define	CO_APIC_SERIAL	CO_APIC_0_5_SERIAL
-/* XXX */
-
-#define CO_APIC_ENET	3	/* Lithium PCI Bridge A, Device 3 */
-#define	CO_APIC_8259	12	/* serial, floppy, par-l-l, audio */
-
-#define	CO_APIC_VIDOUT0	16
-#define	CO_APIC_VIDOUT1	17
-#define	CO_APIC_VIDIN0	18
-#define	CO_APIC_VIDIN1	19
-
-#define CO_APIC_CPU	28	/* Timer and Cache interrupt */
-
-/*
- * This is the "irq" arg to request_irq(), just a unique cookie.
- */
-#define	CO_IRQ_TIMER	0
-#define CO_IRQ_ENET	3
-#define CO_IRQ_SERIAL	4
-#define CO_IRQ_FLOPPY	6	/* Same as drivers/block/floppy.c:FLOPPY_IRQ */
-#define	CO_IRQ_PARLL	7
-#define	CO_IRQ_POWER	9
-#define CO_IRQ_IDE	14
-#define	CO_IRQ_8259	12
-
-#ifdef CONFIG_X86_VISWS_APIC
-static __inline void co_cpu_write(unsigned long reg, unsigned long v)
-{
-	*((volatile unsigned long *)(CO_CPU_VADDR+reg))=v;
-}
-
-static __inline unsigned long co_cpu_read(unsigned long reg)
-{
-	return *((volatile unsigned long *)(CO_CPU_VADDR+reg));
-}            
-             
-static __inline void co_apic_write(unsigned long reg, unsigned long v)
-{
-	*((volatile unsigned long *)(CO_APIC_VADDR+reg))=v;
-}            
-             
-static __inline unsigned long co_apic_read(unsigned long reg)
-{
-	return *((volatile unsigned long *)(CO_APIC_VADDR+reg));
-}
-#endif
-
-extern char visws_board_type;
-
-#define	VISWS_320	0
-#define	VISWS_540	1
-
-extern char visws_board_rev;
-
-#endif
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/include/asm-i386/hw_irq.h linux-2.4.17-visws/include/asm-i386/hw_irq.h
--- linux-2.4.17/include/asm-i386/hw_irq.h	Thu Nov 22 11:46:18 2001
+++ linux-2.4.17-visws/include/asm-i386/hw_irq.h	Wed Jan  2 19:50:16 2002
@@ -59,7 +59,7 @@
 #define FIRST_SYSTEM_VECTOR	0xef
 
 extern int irq_vector[NR_IRQS];
-#define IO_APIC_VECTOR(irq)	irq_vector[irq]
+#define IO_APIC_VECTOR(irq)    irq_vector[irq]
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
@@ -80,6 +80,7 @@
 extern void setup_IO_APIC(void);
 extern void disable_IO_APIC(void);
 extern void print_IO_APIC(void);
+extern int visws_get_PCI_irq_vector(int bus, int slot, int fn);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int slot, int fn);
 extern void send_IPI(int dest, int vector);
 
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/include/asm-i386/lithium.h linux-2.4.17-visws/include/asm-i386/lithium.h
--- linux-2.4.17/include/asm-i386/lithium.h	Thu Jul 26 13:40:32 2001
+++ linux-2.4.17-visws/include/asm-i386/lithium.h	Wed Dec 31 16:00:00 1969
@@ -1,45 +0,0 @@
-#ifndef __I386_LITHIUM_H
-#define __I386_LITHIUM_H
-
-#include <linux/config.h>
-
-/*
- * Lithium is the I/O ASIC on the SGI 320 and 540 Visual Workstations
- */
-
-#define	LI_PCI_A_PHYS		0xfc000000	/* Enet is dev 3 */
-#define	LI_PCI_B_PHYS		0xfd000000	/* PIIX4 is here */
-
-/* see set_fixmap() and asm/fixmap.h */
-#define LI_PCIA_VADDR   (fix_to_virt(FIX_LI_PCIA))
-#define LI_PCIB_VADDR   (fix_to_virt(FIX_LI_PCIB))
-
-/* Not a standard PCI? (not in linux/pci.h) */
-#define	LI_PCI_BUSNUM	0x44			/* lo8: primary, hi8: sub */
-#define LI_PCI_INTEN    0x46
-
-#ifdef CONFIG_X86_VISWS_APIC
-/* More special purpose macros... */
-static __inline void li_pcia_write16(unsigned long reg, unsigned short v)
-{
-	*((volatile unsigned short *)(LI_PCIA_VADDR+reg))=v;
-}
-
-static __inline unsigned short li_pcia_read16(unsigned long reg)
-{
-	 return *((volatile unsigned short *)(LI_PCIA_VADDR+reg));
-}
-
-static __inline void li_pcib_write16(unsigned long reg, unsigned short v)
-{
-	*((volatile unsigned short *)(LI_PCIB_VADDR+reg))=v;
-}
-
-static __inline unsigned short li_pcib_read16(unsigned long reg)
-{
-	return *((volatile unsigned short *)(LI_PCIB_VADDR+reg));
-}
-#endif
-
-#endif
-
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/include/asm-i386/sgi-cobalt.h linux-2.4.17-visws/include/asm-i386/sgi-cobalt.h
--- linux-2.4.17/include/asm-i386/sgi-cobalt.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.17-visws/include/asm-i386/sgi-cobalt.h	Wed Jan  2 17:19:28 2002
@@ -0,0 +1,119 @@
+#include <linux/config.h>
+#ifndef __I386_SGI_COBALT_H
+#define __I386_SGI_COBALT_H
+
+/*
+ * Cobalt SGI Visual Workstation system ASIC
+ */ 
+
+#define	CO_CPU_PHYS		0xc2000000
+#define	CO_APIC_PHYS		0xc4000000
+
+/* see set_fixmap() and asm/fixmap.h */
+#define	CO_CPU_VADDR		(fix_to_virt(FIX_CO_CPU))
+#define	CO_APIC_VADDR		(fix_to_virt(FIX_CO_APIC))
+
+/* Cobalt CPU registers -- relative to CO_CPU_VADDR, use co_cpu_*() */
+#define	CO_CPU_REV		0x08
+#define	CO_CPU_CTRL		0x10
+#define	CO_CPU_STAT		0x20
+#define	CO_CPU_TIMEVAL		0x30
+
+/* CO_CPU_CTRL bits */
+#define	CO_CTRL_TIMERUN		0x04		/* 0 == disabled */
+#define	CO_CTRL_TIMEMASK	0x08		/* 0 == unmasked */
+
+/* CO_CPU_STATUS bits */
+#define	CO_STAT_TIMEINTR	0x02	/* (r) 1 == int pend, (w) 0 == clear */
+
+/* CO_CPU_TIMEVAL value */
+#define	CO_TIME_HZ		100000000	/* Cobalt core rate */
+
+/* Cobalt APIC registers -- relative to CO_APIC_VADDR, use co_apic_*() */
+#define	CO_APIC_HI(n)		(((n) * 0x10) + 4)
+#define	CO_APIC_LO(n)		((n) * 0x10)
+#define	CO_APIC_ID		0x0ffc
+
+/* CO_APIC_ID bits */
+#define	CO_APIC_ENABLE		0x00000100
+
+/* CO_APIC_LO bits */
+#define	CO_APIC_MASK		0x00010000	/* 0 = enabled */
+#define	CO_APIC_LEVEL		0x00008000	/* 0 = edge */
+
+/*
+ * Where things are physically wired to Cobalt
+ * #defines with no board _<type>_<rev>_ are common to all (thus far)
+ */
+#define	CO_APIC_IDE0		4
+#define CO_APIC_IDE1		2		/* Only on 320 */
+
+#define	CO_APIC_8259		12		/* serial, floppy, par-l-l */
+
+/* Lithium PCI Bridge A -- "the one with 82557 Ethernet" */
+#define	CO_APIC_PCIA_BASE0	0 /* and 1 */	/* slot 0, line 0 */
+#define	CO_APIC_PCIA_BASE123	5 /* and 6 */	/* slot 0, line 1 */
+
+#define	CO_APIC_PIIX4_USB	7		/* this one is wierd */
+
+/* Lithium PCI Bridge B -- "the one with PIIX4" */
+#define	CO_APIC_PCIB_BASE0	8 /* and 9-12 *//* slot 0, line 0 */
+#define	CO_APIC_PCIB_BASE123	13 /* 14.15 */	/* slot 0, line 1 */
+
+#define	CO_APIC_VIDOUT0		16
+#define	CO_APIC_VIDOUT1		17
+#define	CO_APIC_VIDIN0		18
+#define	CO_APIC_VIDIN1		19
+
+#define	CO_APIC_LI_AUDIO	22
+
+#define	CO_APIC_AS		24
+#define	CO_APIC_RE		25
+
+#define CO_APIC_CPU		28		/* Timer and Cache interrupt */
+#define	CO_APIC_NMI		29
+#define	CO_APIC_LAST		CO_APIC_NMI
+
+/*
+ * This is how irqs are assigned on the Visual Workstation.
+ * Legacy devices get irq's 1-15 (system clock is 0 and is CO_APIC_CPU).
+ * All other devices (including PCI) go to Cobalt and are irq's 16 on up.
+ */
+#define	CO_IRQ_APIC0	16			/* irq of apic entry 0 */
+#define	IS_CO_APIC(irq)	((irq) >= CO_IRQ_APIC0)
+#define	CO_IRQ(apic)	(CO_IRQ_APIC0 + (apic))	/* apic ent to irq */
+#define	CO_APIC(irq)	((irq) - CO_IRQ_APIC0)	/* irq to apic ent */
+#define CO_IRQ_IDE0	14			/* knowledge of... */
+#define CO_IRQ_IDE1	15			/* ... ide driver defaults! */
+#define	CO_IRQ_8259	CO_IRQ(CO_APIC_8259)
+
+#ifdef CONFIG_X86_VISWS_APIC
+extern __inline void co_cpu_write(unsigned long reg, unsigned long v)
+{
+	*((volatile unsigned long *)(CO_CPU_VADDR+reg))=v;
+}
+
+extern __inline unsigned long co_cpu_read(unsigned long reg)
+{
+	return *((volatile unsigned long *)(CO_CPU_VADDR+reg));
+}            
+             
+extern __inline void co_apic_write(unsigned long reg, unsigned long v)
+{
+	*((volatile unsigned long *)(CO_APIC_VADDR+reg))=v;
+}            
+             
+extern __inline unsigned long co_apic_read(unsigned long reg)
+{
+	return *((volatile unsigned long *)(CO_APIC_VADDR+reg));
+}
+#endif
+
+extern char visws_board_type;
+
+#define	VISWS_320	0
+#define	VISWS_540	1
+
+extern char visws_board_rev;
+
+#endif /* __I386_SGI_COBALT_H */
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/include/asm-i386/sgi-lithium.h linux-2.4.17-visws/include/asm-i386/sgi-lithium.h
--- linux-2.4.17/include/asm-i386/sgi-lithium.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.17-visws/include/asm-i386/sgi-lithium.h	Wed Jan  2 17:19:28 2002
@@ -0,0 +1,56 @@
+#ifndef __I386_SGI_LITHIUM_H
+#define __I386_SGI_LITHIUM_H
+
+#include <linux/config.h>
+
+/*
+ * Lithium is the SGI Visual Workstation I/O ASIC
+ */
+
+#define	LI_PCI_A_PHYS		0xfc000000	/* Enet is dev 3 */
+#define	LI_PCI_B_PHYS		0xfd000000	/* PIIX4 is here */
+
+/* see set_fixmap() and asm/fixmap.h */
+#define LI_PCIA_VADDR   (fix_to_virt(FIX_LI_PCIA))
+#define LI_PCIB_VADDR   (fix_to_virt(FIX_LI_PCIB))
+
+/* Not a standard PCI? (not in linux/pci.h) */
+#define	LI_PCI_BUSNUM	0x44			/* lo8: primary, hi8: sub */
+#define LI_PCI_INTEN    0x46
+
+/* LI_PCI_INTENT bits */
+#define	LI_INTA_0	0x0001
+#define	LI_INTA_1	0x0002
+#define	LI_INTA_2	0x0004
+#define	LI_INTA_3	0x0008
+#define	LI_INTA_4	0x0010
+#define	LI_INTB		0x0020
+#define	LI_INTC		0x0040
+#define	LI_INTD		0x0080
+
+
+#ifdef CONFIG_X86_VISWS_APIC
+/* More special purpose macros... */
+extern __inline void li_pcia_write16(unsigned long reg, unsigned short v)
+{
+	*((volatile unsigned short *)(LI_PCIA_VADDR+reg))=v;
+}
+
+extern __inline unsigned short li_pcia_read16(unsigned long reg)
+{
+	 return *((volatile unsigned short *)(LI_PCIA_VADDR+reg));
+}
+
+extern __inline void li_pcib_write16(unsigned long reg, unsigned short v)
+{
+	*((volatile unsigned short *)(LI_PCIB_VADDR+reg))=v;
+}
+
+extern __inline unsigned short li_pcib_read16(unsigned long reg)
+{
+	return *((volatile unsigned short *)(LI_PCIB_VADDR+reg));
+}
+#endif
+
+#endif
+
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/include/asm-i386/sgi-piix.h linux-2.4.17-visws/include/asm-i386/sgi-piix.h
--- linux-2.4.17/include/asm-i386/sgi-piix.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.17-visws/include/asm-i386/sgi-piix.h	Wed Jan  2 16:45:27 2002
@@ -0,0 +1,113 @@
+#ifndef __I386_SGI_PIIX_H
+#define __I386_SGI_PIIX_H
+
+/*
+ * PIIX4 as used on SGI Visual Workstations
+ */
+
+/*
+ * The PCI bus with PIIX4.
+ * XXX bus numbering should be virtualized?!
+ */
+#define PIIX4_BUS		0
+
+#define	PIIX_PM_START		0x0F80
+
+#define	SIO_GPIO_START		0x0FC0
+
+#define	SIO_PM_START		0x0FC8
+
+#define	PMBASE			PIIX_PM_START
+#define	GPIREG0			(PMBASE+0x30)
+#define	GPIREG(x)		(GPIREG0+((x)/8))
+#define	GPIBIT(x)		(1 << ((x)%8))
+
+#define	PIIX_GPI_BD_ID1		18
+#define	PIIX_GPI_BD_ID2		19
+#define	PIIX_GPI_BD_ID3		20
+#define	PIIX_GPI_BD_ID4		21
+#define	PIIX_GPI_BD_REG		GPIREG(PIIX_GPI_BD_ID1)
+#define	PIIX_GPI_BD_MASK	(GPIBIT(PIIX_GPI_BD_ID1) | \
+				GPIBIT(PIIX_GPI_BD_ID2) | \
+				GPIBIT(PIIX_GPI_BD_ID3) | \
+				GPIBIT(PIIX_GPI_BD_ID4) )
+
+#define	PIIX_GPI_BD_SHIFT	(PIIX_GPI_BD_ID1 % 8)
+
+#define	SIO_INDEX		0x2e
+#define	SIO_DATA		0x2f
+
+#define	SIO_DEV_SEL		0x7
+#define	SIO_DEV_ENB		0x30
+#define	SIO_DEV_MSB		0x60
+#define	SIO_DEV_LSB		0x61
+
+#define	SIO_GP_DEV		0x7
+
+#define	SIO_GP_BASE		SIO_GPIO_START
+#define	SIO_GP_MSB		(SIO_GP_BASE>>8)
+#define	SIO_GP_LSB		(SIO_GP_BASE&0xff)
+
+#define	SIO_GP_DATA1		(SIO_GP_BASE+0)
+
+#define	SIO_PM_DEV		0x8
+
+#define	SIO_PM_BASE		SIO_PM_START
+#define	SIO_PM_MSB		(SIO_PM_BASE>>8)
+#define	SIO_PM_LSB		(SIO_PM_BASE&0xff)
+#define	SIO_PM_INDEX		(SIO_PM_BASE+0)
+#define	SIO_PM_DATA		(SIO_PM_BASE+1)
+
+#define	SIO_PM_FER2		0x1
+
+#define	SIO_PM_GP_EN		0x80
+
+
+
+/*
+ * This is the dev/reg where generating a config cycle will
+ * result in a PCI special cycle.
+ */
+#define SPECIAL_DEV		0xff
+#define SPECIAL_REG		0x00
+
+/*
+ * PIIX4 needs to see a special cycle with the following data
+ * to be convinced the processor has gone into the stop grant
+ * state.  PIIX4 insists on seeing this before it will power
+ * down a system.
+ */
+#define PIIX_SPECIAL_STOP		0x00120002
+
+#define PIIX4_RESET_PORT	0xcf9
+#define PIIX4_RESET_VAL		0x6
+
+#define PMSTS_PORT		0xf80	// 2 bytes	PM Status
+#define PMEN_PORT		0xf82	// 2 bytes	PM Enable
+#define	PMCNTRL_PORT		0xf84	// 2 bytes	PM Control
+
+#define PM_SUSPEND_ENABLE	0x2000	// start sequence to suspend state
+
+/*
+ * PMSTS and PMEN I/O bit definitions.
+ * (Bits are the same in both registers)
+ */
+#define PM_STS_RSM		(1<<15)	// Resume Status
+#define PM_STS_PWRBTNOR		(1<<11)	// Power Button Override
+#define PM_STS_RTC		(1<<10)	// RTC status
+#define PM_STS_PWRBTN		(1<<8)	// Power Button Pressed?
+#define PM_STS_GBL		(1<<5)	// Global Status
+#define PM_STS_BM		(1<<4)	// Bus Master Status
+#define PM_STS_TMROF		(1<<0)	// Timer Overflow Status.
+
+/*
+ * Stop clock GPI register
+ */
+#define PIIX_GPIREG0			(0xf80 + 0x30)
+
+/*
+ * Stop clock GPI bit in GPIREG0
+ */
+#define	PIIX_GPI_STPCLK		0x4	// STPCLK signal routed back in
+
+#endif
diff -Nuar --exclude=*~ --exclude=TAGS --exclude=*.[oas] --exclude=.* linux-2.4.17/include/asm-i386/sgi-vwdbe.h linux-2.4.17-visws/include/asm-i386/sgi-vwdbe.h
--- linux-2.4.17/include/asm-i386/sgi-vwdbe.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.17-visws/include/asm-i386/sgi-vwdbe.h	Wed Jan  2 16:45:27 2002
@@ -0,0 +1,305 @@
+/*
+ *  linux/asm-i386/sgi-vwdbe.h -- SGI DBE frame buffer device header
+ *
+ *      Copyright (C) 1999 Silicon Graphics, Inc.
+ *      Jeffrey Newquist, newquist@engr.sgi.com
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#ifndef __SGI_VWDBE_H__
+#define __SGI_VWDBE_H__
+
+#define DBE_GETREG(reg, dest)       ((dest) = DBE_REG_BASE->##reg)
+#define DBE_SETREG(reg, src)        DBE_REG_BASE->##reg = (src)
+#define DBE_IGETREG(reg, idx, dest) ((dest) = DBE_REG_BASE->##reg##[idx])
+#define DBE_ISETREG(reg, idx, src)  (DBE_REG_BASE->##reg##[idx] = (src))
+
+#define MASK(msb, lsb)          ( (((u32)1<<((msb)-(lsb)+1))-1) << (lsb) )
+#define GET(v, msb, lsb)        ( ((u32)(v) & MASK(msb,lsb)) >> (lsb) )
+#define SET(v, f, msb, lsb)     ( (v) = ((v)&~MASK(msb,lsb)) | (( (u32)(f)<<(lsb) ) & MASK(msb,lsb)) )
+
+#define GET_DBE_FIELD(reg, field, v)        GET((v), DBE_##reg##_##field##_MSB, DBE_##reg##_##field##_LSB)
+#define SET_DBE_FIELD(reg, field, v, f)     SET((v), (f), DBE_##reg##_##field##_MSB, DBE_##reg##_##field##_LSB)
+
+/* NOTE: All loads/stores must be 32 bits and uncached */
+
+#define DBE_REG_PHYS    0xd0000000
+#define DBE_REG_SIZE        0x01000000
+
+typedef struct {
+  volatile u32 ctrlstat;     /* 0x000000 general control */
+  volatile u32 dotclock;     /* 0x000004 dot clock PLL control */
+  volatile u32 i2c;          /* 0x000008 crt I2C control */
+  volatile u32 sysclk;       /* 0x00000c system clock PLL control */
+  volatile u32 i2cfp;        /* 0x000010 flat panel I2C control */
+  volatile u32 id;           /* 0x000014 device id/chip revision */
+  volatile u32 config;       /* 0x000018 power on configuration */
+  volatile u32 bist;         /* 0x00001c internal bist status */
+
+  char _pad0[ 0x010000 - 0x000020 ];
+
+  volatile u32 vt_xy;        /* 0x010000 current dot coords */
+  volatile u32 vt_xymax;     /* 0x010004 maximum dot coords */
+  volatile u32 vt_vsync;     /* 0x010008 vsync on/off */
+  volatile u32 vt_hsync;     /* 0x01000c hsync on/off */
+  volatile u32 vt_vblank;    /* 0x010010 vblank on/off */
+  volatile u32 vt_hblank;    /* 0x010014 hblank on/off */
+  volatile u32 vt_flags;     /* 0x010018 polarity of vt signals */
+  volatile u32 vt_f2rf_lock; /* 0x01001c f2rf & framelck y coord */
+  volatile u32 vt_intr01;    /* 0x010020 intr 0,1 y coords */
+  volatile u32 vt_intr23;    /* 0x010024 intr 2,3 y coords */
+  volatile u32 fp_hdrv;      /* 0x010028 flat panel hdrv on/off */
+  volatile u32 fp_vdrv;      /* 0x01002c flat panel vdrv on/off */
+  volatile u32 fp_de;        /* 0x010030 flat panel de on/off */
+  volatile u32 vt_hpixen;    /* 0x010034 intrnl horiz pixel on/off*/
+  volatile u32 vt_vpixen;    /* 0x010038 intrnl vert pixel on/off */
+  volatile u32 vt_hcmap;     /* 0x01003c cmap write (horiz) */
+  volatile u32 vt_vcmap;     /* 0x010040 cmap write (vert) */
+  volatile u32 did_start_xy; /* 0x010044 eol/f did/xy reset val */
+  volatile u32 crs_start_xy; /* 0x010048 eol/f crs/xy reset val */
+  volatile u32 vc_start_xy;  /* 0x01004c eol/f vc/xy reset val */
+
+  char _pad1[ 0x020000 - 0x010050 ];
+
+  volatile u32 ovr_width_tile; /* 0x020000 overlay plane ctrl 0 */
+  volatile u32 ovr_inhwctrl;   /* 0x020004 overlay plane ctrl 1 */
+  volatile u32 ovr_control;    /* 0x020008 overlay plane ctrl 1 */
+
+  char _pad2[ 0x030000 - 0x02000C ];
+
+  volatile u32 frm_size_tile;  /* 0x030000 normal plane ctrl 0 */
+  volatile u32 frm_size_pixel; /* 0x030004 normal plane ctrl 1 */
+  volatile u32 frm_inhwctrl;   /* 0x030008 normal plane ctrl 2 */
+  volatile u32 frm_control;        /* 0x03000C normal plane ctrl 3 */
+
+  char _pad3[ 0x040000 - 0x030010 ];
+
+  volatile u32 did_inhwctrl;   /* 0x040000 DID control */
+  volatile u32 did_control;    /* 0x040004 DID shadow */
+
+  char _pad4[ 0x048000 - 0x040008 ];
+
+  volatile u32 mode_regs[32];  /* 0x048000 - 0x04807c WID table */
+
+  char _pad5[ 0x050000 - 0x048080 ];
+
+  volatile u32 cmap[6144];     /* 0x050000 - 0x055ffc color map */
+
+  char _pad6[ 0x058000 - 0x056000 ];
+
+  volatile u32 cm_fifo;        /* 0x058000 color map fifo status */
+
+  char _pad7[ 0x060000 - 0x058004 ];
+
+  volatile u32 gmap[256];      /* 0x060000 - 0x0603fc gamma map */
+
+  char _pad8[ 0x068000 - 0x060400 ];
+
+  volatile u32 gmap10[1024];   /* 0x068000 - 0x068ffc gamma map */
+
+  char _pad9[ 0x070000 - 0x069000 ];
+
+  volatile u32 crs_pos;        /* 0x070000 cusror control 0 */
+  volatile u32 crs_ctl;        /* 0x070004 cusror control 1 */
+  volatile u32 crs_cmap[3];    /* 0x070008 - 0x070010 crs cmap */
+
+  char _pad10[ 0x078000 - 0x070014 ];
+
+  volatile u32 crs_glyph[64];  /* 0x078000 - 0x0780fc crs glyph */
+
+  char _pad11[ 0x080000 - 0x078100 ];
+
+  volatile u32 vc_0;           /* 0x080000 video capture crtl 0 */
+  volatile u32 vc_1;           /* 0x080004 video capture crtl 1 */
+  volatile u32 vc_2;           /* 0x080008 video capture crtl 2 */
+  volatile u32 vc_3;           /* 0x08000c video capture crtl 3 */
+  volatile u32 vc_4;           /* 0x080010 video capture crtl 3 */
+  volatile u32 vc_5;           /* 0x080014 video capture crtl 3 */
+  volatile u32 vc_6;           /* 0x080018 video capture crtl 3 */
+  volatile u32 vc_7;           /* 0x08001c video capture crtl 3 */
+  volatile u32 vc_8;           /* 0x08000c video capture crtl 3 */
+} asregs;
+
+/* Bit mask information */
+
+#define DBE_CTRLSTAT_CHIPID_MSB     3
+#define DBE_CTRLSTAT_CHIPID_LSB     0
+#define DBE_CTRLSTAT_SENSE_N_MSB    4
+#define DBE_CTRLSTAT_SENSE_N_LSB    4
+#define DBE_CTRLSTAT_PCLKSEL_MSB    29
+#define DBE_CTRLSTAT_PCLKSEL_LSB    28
+
+#define DBE_DOTCLK_M_MSB            7
+#define DBE_DOTCLK_M_LSB            0
+#define DBE_DOTCLK_N_MSB            13
+#define DBE_DOTCLK_N_LSB            8
+#define DBE_DOTCLK_P_MSB            15
+#define DBE_DOTCLK_P_LSB            14
+#define DBE_DOTCLK_RUN_MSB          20
+#define DBE_DOTCLK_RUN_LSB          20
+
+#define DBE_VT_XY_VT_FREEZE_MSB     31
+#define DBE_VT_XY_VT_FREEZE_LSB     31
+
+#define DBE_FP_VDRV_FP_VDRV_ON_MSB        23
+#define DBE_FP_VDRV_FP_VDRV_ON_LSB        12
+#define DBE_FP_VDRV_FP_VDRV_OFF_MSB       11
+#define DBE_FP_VDRV_FP_VDRV_OFF_LSB       0
+
+#define DBE_FP_HDRV_FP_HDRV_ON_MSB        23
+#define DBE_FP_HDRV_FP_HDRV_ON_LSB        12
+#define DBE_FP_HDRV_FP_HDRV_OFF_MSB       11
+#define DBE_FP_HDRV_FP_HDRV_OFF_LSB       0
+
+#define DBE_FP_DE_FP_DE_ON_MSB        23
+#define DBE_FP_DE_FP_DE_ON_LSB        12
+#define DBE_FP_DE_FP_DE_OFF_MSB       11
+#define DBE_FP_DE_FP_DE_OFF_LSB       0
+
+#define DBE_VT_VSYNC_VT_VSYNC_ON_MSB        23
+#define DBE_VT_VSYNC_VT_VSYNC_ON_LSB        12
+#define DBE_VT_VSYNC_VT_VSYNC_OFF_MSB       11
+#define DBE_VT_VSYNC_VT_VSYNC_OFF_LSB       0
+
+#define DBE_VT_HSYNC_VT_HSYNC_ON_MSB        23
+#define DBE_VT_HSYNC_VT_HSYNC_ON_LSB        12
+#define DBE_VT_HSYNC_VT_HSYNC_OFF_MSB       11
+#define DBE_VT_HSYNC_VT_HSYNC_OFF_LSB       0
+
+#define DBE_VT_VBLANK_VT_VBLANK_ON_MSB        23
+#define DBE_VT_VBLANK_VT_VBLANK_ON_LSB        12
+#define DBE_VT_VBLANK_VT_VBLANK_OFF_MSB       11
+#define DBE_VT_VBLANK_VT_VBLANK_OFF_LSB       0
+
+#define DBE_VT_HBLANK_VT_HBLANK_ON_MSB        23
+#define DBE_VT_HBLANK_VT_HBLANK_ON_LSB        12
+#define DBE_VT_HBLANK_VT_HBLANK_OFF_MSB       11
+#define DBE_VT_HBLANK_VT_HBLANK_OFF_LSB       0
+
+#define DBE_VT_FLAGS_VDRV_INVERT_MSB  0
+#define DBE_VT_FLAGS_VDRV_INVERT_LSB  0
+#define DBE_VT_FLAGS_HDRV_INVERT_MSB  2
+#define DBE_VT_FLAGS_HDRV_INVERT_LSB  2
+
+#define DBE_VT_VCMAP_VT_VCMAP_ON_MSB        23
+#define DBE_VT_VCMAP_VT_VCMAP_ON_LSB        12
+#define DBE_VT_VCMAP_VT_VCMAP_OFF_MSB       11
+#define DBE_VT_VCMAP_VT_VCMAP_OFF_LSB       0
+
+#define DBE_VT_HCMAP_VT_HCMAP_ON_MSB        23
+#define DBE_VT_HCMAP_VT_HCMAP_ON_LSB        12
+#define DBE_VT_HCMAP_VT_HCMAP_OFF_MSB       11
+#define DBE_VT_HCMAP_VT_HCMAP_OFF_LSB       0
+
+#define DBE_VT_XYMAX_VT_MAXX_MSB    11
+#define DBE_VT_XYMAX_VT_MAXX_LSB    0
+#define DBE_VT_XYMAX_VT_MAXY_MSB    23
+#define DBE_VT_XYMAX_VT_MAXY_LSB    12
+
+#define DBE_VT_HPIXEN_VT_HPIXEN_ON_MSB      23
+#define DBE_VT_HPIXEN_VT_HPIXEN_ON_LSB      12
+#define DBE_VT_HPIXEN_VT_HPIXEN_OFF_MSB     11
+#define DBE_VT_HPIXEN_VT_HPIXEN_OFF_LSB     0
+
+#define DBE_VT_VPIXEN_VT_VPIXEN_ON_MSB      23
+#define DBE_VT_VPIXEN_VT_VPIXEN_ON_LSB      12
+#define DBE_VT_VPIXEN_VT_VPIXEN_OFF_MSB     11
+#define DBE_VT_VPIXEN_VT_VPIXEN_OFF_LSB     0
+
+#define DBE_OVR_CONTROL_OVR_DMA_ENABLE_MSB  0
+#define DBE_OVR_CONTROL_OVR_DMA_ENABLE_LSB  0
+
+#define DBE_OVR_INHWCTRL_OVR_DMA_ENABLE_MSB 0
+#define DBE_OVR_INHWCTRL_OVR_DMA_ENABLE_LSB 0
+
+#define DBE_OVR_WIDTH_TILE_OVR_FIFO_RESET_MSB       13
+#define DBE_OVR_WIDTH_TILE_OVR_FIFO_RESET_LSB       13
+
+#define DBE_FRM_CONTROL_FRM_DMA_ENABLE_MSB  0
+#define DBE_FRM_CONTROL_FRM_DMA_ENABLE_LSB  0
+#define DBE_FRM_CONTROL_FRM_TILE_PTR_MSB    31
+#define DBE_FRM_CONTROL_FRM_TILE_PTR_LSB    9
+#define DBE_FRM_CONTROL_FRM_LINEAR_MSB      1
+#define DBE_FRM_CONTROL_FRM_LINEAR_LSB      1
+
+#define DBE_FRM_INHWCTRL_FRM_DMA_ENABLE_MSB 0
+#define DBE_FRM_INHWCTRL_FRM_DMA_ENABLE_LSB 0
+
+#define DBE_FRM_SIZE_TILE_FRM_WIDTH_TILE_MSB        12
+#define DBE_FRM_SIZE_TILE_FRM_WIDTH_TILE_LSB        5
+#define DBE_FRM_SIZE_TILE_FRM_RHS_MSB       4
+#define DBE_FRM_SIZE_TILE_FRM_RHS_LSB       0
+#define DBE_FRM_SIZE_TILE_FRM_DEPTH_MSB     14
+#define DBE_FRM_SIZE_TILE_FRM_DEPTH_LSB     13
+#define DBE_FRM_SIZE_TILE_FRM_FIFO_RESET_MSB        15
+#define DBE_FRM_SIZE_TILE_FRM_FIFO_RESET_LSB        15
+
+#define DBE_FRM_SIZE_PIXEL_FB_HEIGHT_PIX_MSB        31
+#define DBE_FRM_SIZE_PIXEL_FB_HEIGHT_PIX_LSB        16
+
+#define DBE_DID_CONTROL_DID_DMA_ENABLE_MSB  0
+#define DBE_DID_CONTROL_DID_DMA_ENABLE_LSB  0
+#define DBE_DID_INHWCTRL_DID_DMA_ENABLE_MSB 0
+#define DBE_DID_INHWCTRL_DID_DMA_ENABLE_LSB 0
+
+#define DBE_DID_START_XY_DID_STARTY_MSB     23
+#define DBE_DID_START_XY_DID_STARTY_LSB     12
+#define DBE_DID_START_XY_DID_STARTX_MSB     11
+#define DBE_DID_START_XY_DID_STARTX_LSB     0
+
+#define DBE_CRS_START_XY_CRS_STARTY_MSB     23
+#define DBE_CRS_START_XY_CRS_STARTY_LSB     12
+#define DBE_CRS_START_XY_CRS_STARTX_MSB     11
+#define DBE_CRS_START_XY_CRS_STARTX_LSB     0
+
+#define DBE_WID_TYP_MSB     4
+#define DBE_WID_TYP_LSB     2
+#define DBE_WID_BUF_MSB     1
+#define DBE_WID_BUF_LSB     0
+
+#define DBE_VC_START_XY_VC_STARTY_MSB       23
+#define DBE_VC_START_XY_VC_STARTY_LSB       12
+#define DBE_VC_START_XY_VC_STARTX_MSB       11
+#define DBE_VC_START_XY_VC_STARTX_LSB       0
+
+/* Constants */
+
+#define DBE_FRM_DEPTH_8     0
+#define DBE_FRM_DEPTH_16    1
+#define DBE_FRM_DEPTH_32    2
+
+#define DBE_CMODE_I8        0
+#define DBE_CMODE_I12       1
+#define DBE_CMODE_RG3B2     2
+#define DBE_CMODE_RGB4      3
+#define DBE_CMODE_ARGB5     4
+#define DBE_CMODE_RGB8      5
+#define DBE_CMODE_RGBA5     6
+#define DBE_CMODE_RGB10     7
+
+#define DBE_BMODE_BOTH      3
+
+#define DBE_CRS_MAGIC       54
+
+#define DBE_CLOCK_REF_KHZ 27000
+
+/* Config Register (DBE Only) Definitions */
+
+#define DBE_CONFIG_VDAC_ENABLE       0x00000001
+#define DBE_CONFIG_VDAC_GSYNC        0x00000002
+#define DBE_CONFIG_VDAC_PBLANK       0x00000004
+#define DBE_CONFIG_FPENABLE          0x00000008
+#define DBE_CONFIG_LENDIAN           0x00000020
+#define DBE_CONFIG_TILEHIST          0x00000040
+#define DBE_CONFIG_EXT_ADDR          0x00000080
+
+#define DBE_CONFIG_FBDEV        ( DBE_CONFIG_VDAC_ENABLE | \
+                                      DBE_CONFIG_VDAC_GSYNC  | \
+                                      DBE_CONFIG_VDAC_PBLANK | \
+                                      DBE_CONFIG_LENDIAN     | \
+                                      DBE_CONFIG_EXT_ADDR )
+
+#endif
