Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261399AbSKBSUH>; Sat, 2 Nov 2002 13:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261381AbSKBSUH>; Sat, 2 Nov 2002 13:20:07 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:2132 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261399AbSKBSRX>; Sat, 2 Nov 2002 13:17:23 -0500
Date: Sun, 3 Nov 2002 03:23:35 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC][Patchset 19/20] Support for PC-9800 (SMP)
Message-ID: <20021103032335.M1536@precia.cinet.co.jp>
References: <20021103023345.A1536@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?iso-8859-1?Q?=3C20021103023345=2EA1536?=
	=?iso-8859-1?B?QHByZWNpYS5jaW5ldC5jby5qcD47IGZyb20gdG9taXRhQGNpbmV0LmNv?=
	=?iso-8859-1?B?LmpwIG9uIMb8LCAxMbfu?= 03, 2002 at 02:33:45 +0900
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 19/20 of patchset for add support NEC PC-9800 architecture,
against 2.5.45.

Summary:
  SMP related modules.
   - add PC-9800 bus spec.

diffstat:
  arch/i386/kernel/apic.c    |   16 +++++++++++++---
  arch/i386/kernel/io_apic.c |   25 +++++++++++++++++++++++--
  arch/i386/kernel/mpparse.c |   35 ++++++++++++++++++++++++++++++++++-
  arch/i386/kernel/smpboot.c |   14 ++++++++++++++
  include/asm-i386/mpspec.h  |    4 +++-
  include/asm-i386/smpboot.h |    9 +++++++++
  6 files changed, 96 insertions(+), 7 deletions(-)

patch:
diff -urN linux/arch/i386/kernel/apic.c linux98/arch/i386/kernel/apic.c
--- linux/arch/i386/kernel/apic.c	Wed Oct 16 13:20:29 2002
+++ linux98/arch/i386/kernel/apic.c	Wed Oct 16 15:40:20 2002
@@ -33,6 +33,8 @@
  #include <asm/arch_hooks.h>
  #include "mach_apic.h"
  +#include "io_ports.h"
+
  void __init apic_intr_init(void)
  {
  #ifdef CONFIG_SMP
@@ -135,9 +137,13 @@
  		 * PIC mode, enable APIC mode in the IMCR, i.e.
  		 * connect BSP's local APIC to INT and NMI lines.
  		 */
+#ifndef CONFIG_PC9800
  		printk("leaving PIC mode, enabling APIC mode.\n");
  		outb(0x70, 0x22);
  		outb(0x01, 0x23);
+#else
+		printk("On NEC98, Changing mode from PIC to APIC isNOT supported yet.\n");
+#endif
  	}
  }
  @@ -150,9 +156,13 @@
  		 * interrupts, including IPIs, won't work beyond
  		 * this point!  The only exception are INIT IPIs.
  		 */
+#ifndef CONFIG_PC9800
  		printk("disabling APIC mode, entering PIC mode.\n");
  		outb(0x70, 0x22);
  		outb(0x00, 0x23);
+#else
+		printk("On NEC98, Changing mode from APIC to PIC isNOT supported yet.\n");
+#endif
  	}
  }
  @@ -759,9 +769,9 @@
   	spin_lock_irqsave(&i8253_lock, flags);
  -	outb_p(0x00, 0x43);
-	count = inb_p(0x40);
-	count |= inb_p(0x40) << 8;
+	outb_p(0x00, PIT_MODE);
+	count = inb_p(PIT_CH0);
+	count |= inb_p(PIT_CH0) << 8;
   	spin_unlock_irqrestore(&i8253_lock, flags);
  diff -urN linux/arch/i386/kernel/io_apic.c linux98/arch/i386/kernel/io_apic.c
--- linux/arch/i386/kernel/io_apic.c	Sat Oct 19 13:01:22 2002
+++ linux98/arch/i386/kernel/io_apic.c	Sat Oct 19 16:22:51 2002
@@ -37,6 +37,8 @@
  #include <asm/desc.h>
  #include "mach_apic.h"
  +#include "io_ports.h"
+
  #undef APIC_LOCKUP_DEBUG
   #define APIC_LOCKUP_DEBUG
@@ -354,7 +356,9 @@
   		if ((mp_bus_id_to_type[lbus] == MP_BUS_ISA ||
  		     mp_bus_id_to_type[lbus] == MP_BUS_EISA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_MCA) &&
+		     mp_bus_id_to_type[lbus] == MP_BUS_MCA ||
+		     mp_bus_id_to_type[lbus] == MP_BUS_NEC98
+		    ) &&
  		    (mp_irqs[i].mpc_irqtype == type) &&
  		    (mp_irqs[i].mpc_srcbusirq == irq))
  @@ -448,6 +452,12 @@
  #define default_MCA_trigger(idx)	(1)
  #define default_MCA_polarity(idx)	(0)
  +/* NEC98 interrupts are always polarity zero edge triggered,
+ * when listed as conforming in the MP table. */
+
+#define default_NEC98_trigger(idx)     (0)
+#define default_NEC98_polarity(idx)    (0)
+
  static int __init MPBIOS_polarity(int idx)
  {
  	int bus = mp_irqs[idx].mpc_srcbus;
@@ -482,6 +492,11 @@
  					polarity = default_MCA_polarity(idx);
  					break;
  				}
+				case MP_BUS_NEC98: /* NEC 98 pin */
+				{
+					polarity = default_NEC98_polarity(idx);
+					break;
+				}
  				default:
  				{
  					printk(KERN_WARNING "broken BIOS!!\n");
@@ -551,6 +566,11 @@
  					trigger = default_MCA_trigger(idx);
  					break;
  				}
+				case MP_BUS_NEC98: /* NEC 98 pin */
+				{
+					trigger = default_NEC98_trigger(idx);
+					break;
+				}
  				default:
  				{
  					printk(KERN_WARNING "broken BIOS!!\n");
@@ -612,6 +632,7 @@
  		case MP_BUS_ISA: /* ISA pin */
  		case MP_BUS_EISA:
  		case MP_BUS_MCA:
+		case MP_BUS_NEC98:
  		{
  			irq = mp_irqs[idx].mpc_srcbusirq;
  			break;
@@ -1718,7 +1739,7 @@
   * Additionally, something is definitely wrong with irq9
   * on PIIX4 boards.
   */
-#define PIC_IRQS	(1<<2)
+#define PIC_IRQS	(1 << PIC_CASCADE_IR)
   void __init setup_IO_APIC(void)
  {
diff -urN linux/arch/i386/kernel/mpparse.c linux98/arch/i386/kernel/mpparse.c
--- linux/arch/i386/kernel/mpparse.c	Wed Oct 16 13:20:29 2002
+++ linux98/arch/i386/kernel/mpparse.c	Wed Oct 16 15:40:20 2002
@@ -236,6 +236,8 @@
  		mp_current_pci_id++;
  	} else if (strncmp(str, BUSTYPE_MCA, sizeof(BUSTYPE_MCA)-1) == 0) {
  		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_MCA;
+	} else if (strncmp(str, BUSTYPE_NEC98, sizeof(BUSTYPE_NEC98)-1) == 0) {
+		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_NEC98;
  	} else {
  		printk("Unknown bustype %s - ignoring\n", str);
  	}
@@ -681,7 +683,12 @@
  		 * Read the physical hardware table.  Anything here will
  		 * override the defaults.
  		 */
-		if (!smp_read_mpc((void *)mpf->mpf_physptr)) {
+#ifndef CONFIG_PC9800
+		if (!smp_read_mpc((void *)mpf->mpf_physptr))
+#else
+		if (!smp_read_mpc(phys_to_virt(mpf->mpf_physptr)))
+#endif
+		{
  			smp_found_config = 0;
  			printk(KERN_ERR "BIOS bug, MP table errors detected!...\n");
  			printk(KERN_ERR "... disabling SMP support. (tell your hw vendor)\n");
@@ -735,8 +742,30 @@
  			printk("found SMP MP-table at %08lx\n",
  						virt_to_phys(mpf));
  			reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE);
+#ifndef CONFIG_PC9800
  			if (mpf->mpf_physptr)
  				reserve_bootmem(mpf->mpf_physptr, PAGE_SIZE);
+#else
+			/*
+			 * PC-9800's MPC table places on the very last of
+			 * physical memory; so that simply reserving PAGE_SIZE
+			 * from mpg->mpf_physptr yields BUG() in
+			 * reserve_bootmem.
+			 */
+			if (mpf->mpf_physptr) {
+				/*
+				 * We cannot access to MPC table to compute
+				 * table size yet, as only few megabytes from
+				 * the bottom is mapped now.
+				 */
+				unsigned long size = PAGE_SIZE;
+				unsigned long end = max_low_pfn * PAGE_SIZE;
+				if (mpf->mpf_physptr + size > end)
+					size = end - mpf->mpf_physptr;
+				reserve_bootmem(mpf->mpf_physptr, size);
+			}
+#endif
+
  			mpf_found = mpf;
  			return 1;
  		}
@@ -748,7 +777,9 @@
   void __init find_smp_config (void)
  {
+#ifndef CONFIG_PC9800
  	unsigned int address;
+#endif
   	/*
  	 * FIXME: Linux assumes you have 640K of base ram..
@@ -762,6 +793,7 @@
  		smp_scan_config(639*0x400,0x400) ||
  			smp_scan_config(0xF0000,0x10000))
  		return;
+#ifndef CONFIG_PC9800	/* PC-9800 has no EBDA area? */
  	/*
  	 * If it is an SMP machine we should know now, unless the
  	 * configuration is in an EISA/MCA bus machine with an
@@ -784,6 +816,7 @@
  	smp_scan_config(address, 0x400);
  	if (smp_found_config)
  		printk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
+#endif
  }
   diff -urN linux/arch/i386/kernel/smpboot.c linux98/arch/i386/kernel/smpboot.c
--- linux/arch/i386/kernel/smpboot.c	Wed Oct 16 13:20:29 2002
+++ linux98/arch/i386/kernel/smpboot.c	Wed Oct 16 15:40:20 2002
@@ -821,13 +821,27 @@
  		nmi_low = *((volatile unsigned short *) TRAMPOLINE_LOW);
  	}  +#ifndef CONFIG_PC9800
  	CMOS_WRITE(0xa, 0xf);
+#else
+	/* reset code is stored in 8255 on PC-9800. */
+	outb(0x0e, 0x37);	/* SHUT0 = 0 */
+#endif
  	local_flush_tlb();
  	Dprintk("1.\n");
  	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
  	Dprintk("2.\n");
  	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
  	Dprintk("3.\n");
+#ifdef CONFIG_PC9800
+	/*
+	 * On PC-9800, continuation on warm reset is done by loading
+	 * %ss:%sp from 0x0000:0404 and executing 'lret', so:
+	 */
+	/* 0x3f0 is on unused interrupt vector and should be safe... */
+	*((volatile unsigned long *) phys_to_virt(0x404)) = 0x000003f0;
+	Dprintk("4.\n");
+#endif
   	/*
  	 * Be paranoid about clearing APIC errors.
diff -urN linux/include/asm-i386/mpspec.h linux98/include/asm-i386/mpspec.h
--- linux/include/asm-i386/mpspec.h	Fri Apr 12 13:58:13 2002
+++ linux98/include/asm-i386/mpspec.h	Fri Apr 12 14:02:42 2002
@@ -105,6 +105,7 @@
  #define BUSTYPE_TC	"TC"
  #define BUSTYPE_VME	"VME"
  #define BUSTYPE_XPRESS	"XPRESS"
+#define BUSTYPE_NEC98	"NEC98"
   struct mpc_config_ioapic
  {
@@ -195,7 +196,8 @@
  	MP_BUS_ISA = 1,
  	MP_BUS_EISA,
  	MP_BUS_PCI,
-	MP_BUS_MCA
+	MP_BUS_MCA,
+	MP_BUS_NEC98
  };
  extern int mp_bus_id_to_type [MAX_MP_BUSSES];
  extern int mp_bus_id_to_node [MAX_MP_BUSSES];
diff -urN linux/include/asm-i386/smpboot.h linux98/include/asm-i386/smpboot.h
--- linux/include/asm-i386/smpboot.h	Sat Oct 12 13:22:19 2002
+++ linux98/include/asm-i386/smpboot.h	Sat Oct 12 19:33:46 2002
@@ -13,8 +13,17 @@
   #define TRAMPOLINE_LOW phys_to_virt(0x8)
   #define TRAMPOLINE_HIGH phys_to_virt(0xa)
  #else /* !CONFIG_CLUSTERED_APIC */
+ #ifndef CONFIG_PC9800
   #define TRAMPOLINE_LOW phys_to_virt(0x467)
   #define TRAMPOLINE_HIGH phys_to_virt(0x469)
+ #else  /* CONFIG_PC9800 */
+  /*
+   * On PC-9800, continuation on warm reset is done by loading
+   * %ss:%sp from 0x0000:0404 and executing 'lret', so:
+   */
+  #define TRAMPOLINE_LOW phys_to_virt(0x4fa)
+  #define TRAMPOLINE_HIGH phys_to_virt(0x4fc)
+ #endif /* !CONFIG_PC9800 */
  #endif /* CONFIG_CLUSTERED_APIC */
   #ifdef CONFIG_CLUSTERED_APIC
