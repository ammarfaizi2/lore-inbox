Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbTBLNYx>; Wed, 12 Feb 2003 08:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbTBLNYx>; Wed, 12 Feb 2003 08:24:53 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:26496 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267102AbTBLNVn>; Wed, 12 Feb 2003 08:21:43 -0500
Date: Wed, 12 Feb 2003 22:30:07 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (6/34) AC#6
Message-ID: <20030212133007.GG1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (6/34).

   PC98 support patch in 2.5.50-ac1 with minimum changes
   to apply 2.5.60. (include/*)

- Osamu Tomota

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-default/pci-functions.h linux98-2.5.53/include/asm-i386/mach-default/pci-functions.h
--- linux-2.5.53/include/asm-i386/mach-default/pci-functions.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-default/pci-functions.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,19 @@
+/*
+ *	PCI BIOS function numbering for conventional PCI BIOS 
+ *	systems
+ */
+
+#define PCIBIOS_PCI_FUNCTION_ID 	0xb1XX
+#define PCIBIOS_PCI_BIOS_PRESENT 	0xb101
+#define PCIBIOS_FIND_PCI_DEVICE		0xb102
+#define PCIBIOS_FIND_PCI_CLASS_CODE	0xb103
+#define PCIBIOS_GENERATE_SPECIAL_CYCLE	0xb106
+#define PCIBIOS_READ_CONFIG_BYTE	0xb108
+#define PCIBIOS_READ_CONFIG_WORD	0xb109
+#define PCIBIOS_READ_CONFIG_DWORD	0xb10a
+#define PCIBIOS_WRITE_CONFIG_BYTE	0xb10b
+#define PCIBIOS_WRITE_CONFIG_WORD	0xb10c
+#define PCIBIOS_WRITE_CONFIG_DWORD	0xb10d
+#define PCIBIOS_GET_ROUTING_OPTIONS	0xb10e
+#define PCIBIOS_SET_PCI_HW_INT		0xb10f
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-default/io_ports.h linux98-2.5.53/include/asm-i386/mach-default/io_ports.h
--- linux-2.5.53/include/asm-i386/mach-default/io_ports.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-default/io_ports.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,30 @@
+/*
+ *  arch/i386/mach-generic/io_ports.h
+ *
+ *  Machine specific IO port address definition for generic.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_IO_PORTS_H
+#define _MACH_IO_PORTS_H
+
+/* i8253A PIT registers */
+#define PIT_MODE		0x43
+#define PIT_CH0			0x40
+#define PIT_CH2			0x42
+
+/* i8259A PIC registers */
+#define PIC_MASTER_CMD		0x20
+#define PIC_MASTER_IMR		0x21
+#define PIC_MASTER_ISR		PIC_MASTER_CMD
+#define PIC_MASTER_POLL		PIC_MASTER_ISR
+#define PIC_MASTER_OCW3		PIC_MASTER_ISR
+#define PIC_SLAVE_CMD		0xa0
+#define PIC_SLAVE_IMR		0xa1
+
+/* i8259A PIC related value */
+#define PIC_CASCADE_IR		2
+#define MASTER_ICW4_DEFAULT	0x01
+#define SLAVE_ICW4_DEFAULT	0x01
+#define PIC_ICW4_AEOI		2
+
+#endif /* !_MACH_IO_PORTS_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-default/irq_vectors.h linux98-2.5.53/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.5.53/include/asm-i386/mach-default/irq_vectors.h	2002-11-25 15:09:13.000000000 +0000
+++ linux98-2.5.53/include/asm-i386/mach-default/irq_vectors.h	2002-10-31 15:05:52.000000000 +0000
@@ -82,4 +82,11 @@
 #define NR_IRQS 16
 #endif
 
+#define FPU_IRQ			13
+
+#define	FIRST_VM86_IRQ		3
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 3 || (irq) > 15)
+
+
 #endif /* _ASM_IRQ_VECTORS_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-default/mach_reboot.h linux98-2.5.53/include/asm-i386/mach-default/mach_reboot.h
--- linux-2.5.53/include/asm-i386/mach-default/mach_reboot.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-default/mach_reboot.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,30 @@
+/*
+ *  include/asm-i386/mach-default/mach_reboot.h
+ *
+ *  Machine specific reboot functions for generic.
+ *  Split out from reboot.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_REBOOT_H
+#define _MACH_REBOOT_H
+
+static inline void kb_wait(void)
+{
+	int i;
+
+	for (i = 0; i < 0x10000; i++)
+		if ((inb_p(0x64) & 0x02) == 0)
+			break;
+}
+
+static inline void mach_reboot(void)
+{
+	int i;
+	for (i = 0; i < 100; i++) {
+		kb_wait();
+		udelay(50);
+		outb(0xfe, 0x64);         /* pulse reset low */
+		udelay(50);
+	}
+}
+
+#endif /* !_MACH_REBOOT_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-pc9800/io_ports.h linux98-2.5.53/include/asm-i386/mach-pc9800/io_ports.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/io_ports.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/io_ports.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,30 @@
+/*
+ *  include/asm-i386/mach-pc9800/io_ports.h
+ *
+ *  Machine specific IO port address definition for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_IO_PORTS_H
+#define _MACH_IO_PORTS_H
+
+/* i8253A PIT registers */
+#define PIT_MODE		0x77
+#define PIT_CH0			0x71
+#define PIT_CH2			0x75
+
+/* i8259A PIC registers */
+#define PIC_MASTER_CMD		0x00
+#define PIC_MASTER_IMR		0x02
+#define PIC_MASTER_ISR		PIC_MASTER_CMD
+#define PIC_MASTER_POLL		PIC_MASTER_ISR
+#define PIC_MASTER_OCW3		PIC_MASTER_ISR
+#define PIC_SLAVE_CMD		0x08
+#define PIC_SLAVE_IMR		0x0a
+
+/* i8259A PIC related values */
+#define PIC_CASCADE_IR		7
+#define MASTER_ICW4_DEFAULT	0x1d
+#define SLAVE_ICW4_DEFAULT	0x09
+#define PIC_ICW4_AEOI		0x02
+
+#endif /* !_MACH_IO_PORTS_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-pc9800/irq_vectors.h linux98-2.5.53/include/asm-i386/mach-pc9800/irq_vectors.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/irq_vectors.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/irq_vectors.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,93 @@
+/*
+ * This file should contain #defines for all of the interrupt vector
+ * numbers used by this architecture.
+ *
+ * In addition, there are some standard defines:
+ *
+ *	FIRST_EXTERNAL_VECTOR:
+ *		The first free place for external interrupts
+ *
+ *	SYSCALL_VECTOR:
+ *		The IRQ vector a syscall makes the user to kernel transition
+ *		under.
+ *
+ *	TIMER_IRQ:
+ *		The IRQ number the timer interrupt comes in at.
+ *
+ *	NR_IRQS:
+ *		The total number of interrupt vectors (including all the
+ *		architecture specific interrupts) needed.
+ *
+ */			
+#ifndef _ASM_IRQ_VECTORS_H
+#define _ASM_IRQ_VECTORS_H
+
+/*
+ * IDT vectors usable for external interrupt sources start
+ * at 0x20:
+ */
+#define FIRST_EXTERNAL_VECTOR	0x20
+
+#define SYSCALL_VECTOR		0x80
+
+/*
+ * Vectors 0x20-0x2f are used for ISA interrupts.
+ */
+
+/*
+ * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
+ *
+ *  some of the following vectors are 'rare', they are merged
+ *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
+ *  TLB, reschedule and local APIC vectors are performance-critical.
+ *
+ *  Vectors 0xf0-0xfa are free (reserved for future Linux use).
+ */
+#define SPURIOUS_APIC_VECTOR	0xff
+#define ERROR_APIC_VECTOR	0xfe
+#define INVALIDATE_TLB_VECTOR	0xfd
+#define RESCHEDULE_VECTOR	0xfc
+#define CALL_FUNCTION_VECTOR	0xfb
+
+#define THERMAL_APIC_VECTOR	0xf0
+/*
+ * Local APIC timer IRQ vector is on a different priority level,
+ * to work around the 'lost local interrupt if more than 2 IRQ
+ * sources per level' errata.
+ */
+#define LOCAL_TIMER_VECTOR	0xef
+
+/*
+ * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * we start at 0x31 to spread out vectors evenly between priority
+ * levels. (0x80 is the syscall vector)
+ */
+#define FIRST_DEVICE_VECTOR	0x31
+#define FIRST_SYSTEM_VECTOR	0xef
+
+#define TIMER_IRQ 0
+
+/*
+ * 16 8259A IRQ's, 208 potential APIC interrupt sources.
+ * Right now the APIC is mostly only used for SMP.
+ * 256 vectors is an architectural limit. (we can have
+ * more than 256 devices theoretically, but they will
+ * have to use shared interrupts)
+ * Since vectors 0x00-0x1f are used/reserved for the CPU,
+ * the usable vector space is 0x20-0xff (224 vectors)
+ */
+#ifdef CONFIG_X86_IO_APIC
+#define NR_IRQS 224
+#else
+#define NR_IRQS 16
+#endif
+
+#define FPU_IRQ			8
+
+#define	FIRST_VM86_IRQ		2
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 2 || (irq) == 7 || (irq) > 15)
+
+#endif /* _ASM_IRQ_VECTORS_H */
+
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-pc9800/mach_reboot.h linux98-2.5.53/include/asm-i386/mach-pc9800/mach_reboot.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/mach_reboot.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/mach_reboot.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,21 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_reboot.h
+ *
+ *  Machine specific reboot functions for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_REBOOT_H
+#define _MACH_REBOOT_H
+
+#ifdef CMOS_WRITE
+#undef CMOS_WRITE
+#define CMOS_WRITE(a,b)	do{}while(0)
+#endif
+
+static inline void mach_reboot(void)
+{
+	outb(0, 0xf0);		/* signal CPU reset */
+	mdelay(1);
+}
+
+#endif /* !_MACH_REBOOT_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-pc9800/pci-functions.h linux98-2.5.53/include/asm-i386/mach-pc9800/pci-functions.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/pci-functions.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/pci-functions.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,20 @@
+/*
+ *	PCI BIOS function codes for the PC9800. Different from
+ *	standard PC systems
+ */
+
+/* Note: PC-9800 confirms PCI 2.1 on only few models */
+
+#define PCIBIOS_PCI_FUNCTION_ID 	0xccXX
+#define PCIBIOS_PCI_BIOS_PRESENT 	0xcc81
+#define PCIBIOS_FIND_PCI_DEVICE		0xcc82
+#define PCIBIOS_FIND_PCI_CLASS_CODE	0xcc83
+/*      PCIBIOS_GENERATE_SPECIAL_CYCLE	0xcc86	(not supported by bios) */
+#define PCIBIOS_READ_CONFIG_BYTE	0xcc88
+#define PCIBIOS_READ_CONFIG_WORD	0xcc89
+#define PCIBIOS_READ_CONFIG_DWORD	0xcc8a
+#define PCIBIOS_WRITE_CONFIG_BYTE	0xcc8b
+#define PCIBIOS_WRITE_CONFIG_WORD	0xcc8c
+#define PCIBIOS_WRITE_CONFIG_DWORD	0xcc8d
+#define PCIBIOS_GET_ROUTING_OPTIONS	0xcc8e	/* PCI 2.1 only */
+#define PCIBIOS_SET_PCI_HW_INT		0xcc8f	/* PCI 2.1 only */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-pc9800/setup_arch_post.h linux98-2.5.53/include/asm-i386/mach-pc9800/setup_arch_post.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/setup_arch_post.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/setup_arch_post.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,29 @@
+/**
+ * machine_specific_memory_setup - Hook for machine specific memory setup.
+ *
+ * Description:
+ *	This is included late in kernel/setup.c so that it can make
+ *	use of all of the static functions.
+ **/
+
+static inline char * __init machine_specific_memory_setup(void)
+{
+	char *who;
+	unsigned long low_mem_size, lower_high, higher_high;
+
+
+	who = "BIOS (common area)";
+
+	low_mem_size = ((*(unsigned char *)__va(PC9800SCA_BIOS_FLAG) & 7) + 1) << 17;
+	add_memory_region(0, low_mem_size, 1);
+	lower_high = (__u32) *(__u8 *) bus_to_virt(PC9800SCA_EXPMMSZ) << 17;
+	higher_high = (__u32) *(__u16 *) bus_to_virt(PC9800SCA_MMSZ16M) << 20;
+	if (lower_high != 0x00f00000UL) {
+		add_memory_region(HIGH_MEMORY, lower_high, 1);
+		add_memory_region(0x01000000UL, higher_high, 1);
+	}
+	else
+		add_memory_region(HIGH_MEMORY, lower_high + higher_high, 1);
+
+	return who;
+}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-pc9800/setup_arch_pre.h linux98-2.5.53/include/asm-i386/mach-pc9800/setup_arch_pre.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/setup_arch_pre.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/setup_arch_pre.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,36 @@
+/* Hook to call BIOS initialisation function */
+
+/* no action for generic */
+
+#define ARCH_SETUP arch_setup_pc9800();
+
+#include <linux/timex.h>
+#include <asm/io.h>
+#include <asm/pc9800.h>
+#include <asm/pc9800_sca.h>
+
+int CLOCK_TICK_RATE;
+unsigned long tick_usec;	/* ACTHZ          period (usec) */
+unsigned long tick_nsec;	/* USER_HZ period (nsec) */
+unsigned char pc9800_misc_flags;
+/* (bit 0) 1:High Address Video ram exists 0:otherwise */
+
+#ifdef CONFIG_SMP
+#define MPC_TABLE_SIZE 512
+#define MPC_TABLE ((char *) (PARAM+0x400))
+char mpc_table[MPC_TABLE_SIZE];
+#endif
+
+static  inline void arch_setup_pc9800(void)
+{
+	CLOCK_TICK_RATE = PC9800_8MHz_P() ? 1996800 : 2457600;
+	printk(KERN_DEBUG "CLOCK_TICK_RATE = %d\n", CLOCK_TICK_RATE);
+	tick_usec = TICK_USEC; 		/* ACTHZ          period (usec) */
+	tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+
+	pc9800_misc_flags = PC9800_MISC_FLAGS;
+#ifdef CONFIG_SMP
+	if ((*(u32 *)(MPC_TABLE)) == 0x504d4350)
+		memcpy(mpc_table, MPC_TABLE, *(u16 *)(MPC_TABLE + 4));
+#endif /* CONFIG_SMP */
+}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-visws/irq_vectors.h linux98-2.5.53/include/asm-i386/mach-visws/irq_vectors.h
--- linux-2.5.53/include/asm-i386/mach-visws/irq_vectors.h	2002-12-10 11:45:43.000000000 +0900
+++ linux98-2.5.53/include/asm-i386/mach-visws/irq_vectors.h	2002-12-16 09:15:54.000000000 +0900
@@ -61,4 +61,10 @@
 #define NR_IRQS 16
 #endif
 
+#define FPU_IRQ			13
+
+#define	FIRST_VM86_IRQ		3
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 3 || (irq) > 15)
+
 #endif /* _ASM_IRQ_VECTORS_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/include/asm-i386/mach-voyager/irq_vectors.h linux98-2.5.53/include/asm-i386/mach-voyager/irq_vectors.h
--- linux-2.5.53/include/asm-i386/mach-voyager/irq_vectors.h	2002-11-25 15:09:13.000000000 +0000
+++ linux98-2.5.53/include/asm-i386/mach-voyager/irq_vectors.h	2002-10-31 15:05:52.000000000 +0000
@@ -57,6 +57,12 @@
 
 #define NR_IRQS 224
 
+#define FPU_IRQ				13
+
+#define	FIRST_VM86_IRQ		3
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 3 || (irq) > 15)
+
 #ifndef __ASSEMBLY__
 extern asmlinkage void vic_cpi_interrupt(void);
 extern asmlinkage void vic_sys_interrupt(void);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/include/asm-i386/gdc.h linux.50-ac1/include/asm-i386/gdc.h
--- linux.50/include/asm-i386/gdc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux.50-ac1/include/asm-i386/gdc.h	2002-10-31 15:06:16.000000000 +0000
@@ -0,0 +1,217 @@
+/*
+ *  gdc.h - macro & inline functions for accessing GDC text-VRAM
+ *
+ *  Copyright (C) 1997-2002   Osamu Tomita <tomita@cinet.co.jp>
+ *			      KITAGAWA Takurou,
+ *			      UGAWA Tomoharu,
+ *			      TAKAI Kosuke
+ *			      (Linux/98 Project)
+ */
+#ifndef _LINUX_ASM_GDC_H_
+#define _LINUX_ASM_GDC_H_
+
+#include <linux/config.h>
+
+#define PC9800_VRAM_ATTR_OFFSET 0x2000
+
+#define GDC_MAP_MEM(x) (unsigned long)phys_to_virt(x)
+
+#define gdc_readb(x) (*(x))
+#define gdc_writeb(x,y) (*(y) = (x))
+
+extern int	fbcon_softback_size;
+
+#ifdef CONFIG_FB_EGC
+#define pc9800_attr_offset(p) \
+		((u16 *)((u32)(p) + \
+		(((u32)(p) >= (u32)(vc_cons[currcons].d->vc_screenbuf) \
+			&& (u32)(p) < (u32)(vc_cons[currcons].d->vc_screenbuf) \
+				+ vc_cons[currcons].d->vc_screenbuf_size) ? \
+		vc_cons[currcons].d->vc_screenbuf_size : fbcon_softback_size)))
+#else
+#define pc9800_attr_offset(p) \
+		((u16 *)((u32)(p) + \
+			(((u32)(p) >= (u32)(__va(0xa0000)) \
+				&& (u32)(p) < (u32)(__va(0xa2000))) ? \
+			0x2000 : vc_cons[currcons].d->vc_screenbuf_size)))
+#endif
+
+#define VT_BUF_HAVE_RW
+#define scr_writew(val, p) \
+	{ \
+		*((u16 *)(p)) = (u16)(((val) >> 16) & 0xff00) \
+			| (u16)((val) & 0xff); \
+		*(pc9800_attr_offset(p)) = (u16)((val) >> 8); \
+	}
+
+#define scr_readw(p) \
+	( \
+		(*((u16 *)(p)) & 0xff) | ((*((u16 *)(p)) & 0xff00) << 16) \
+		| ((*(pc9800_attr_offset(p)) & 0xff) << 8) \
+	)
+
+#define VT_BUF_HAVE_MEMSETW
+extern inline void
+_scr_memsetw(u16 *s, u16 c, unsigned int count)
+{
+#ifdef CONFIG_GDC_32BITACCESS
+	__asm__ __volatile__ ("shr%L1 %1
+	jz 2f
+" /*	cld	kernel code now assumes DF = 0 any time */ "\
+	test%L0 %3,%0
+	jz 1f
+	stos%W2
+	dec%L1 %1
+1:	shr%L1 %1
+	rep
+	stos%L2
+	jnc 2f
+	stos%W2
+	rep
+	stos%W2
+2:"
+			      : "=D"(s), "=c"(count)
+			      : "a"((((u32) c) << 16) | c), "g"(2),
+			        "0"(s), "1"(count));
+#else
+	__asm__ __volatile__ ("rep\n\tstosw"
+			      : "=D"(s), "=c"(count)
+			      : "0"(s), "1"(count / 2), "a"(c));
+#endif	
+}
+
+#define scr_memsetw(s, c, count) \
+	{ \
+	_scr_memsetw((s), (u16)(((c) >> 16) & 0xff00) | (u16)((c) & 0xff), \
+		       	(count)); \
+	_scr_memsetw(pc9800_attr_offset(s), ((u16)(c)) >> 8, (count)); \
+	}
+
+#define VT_BUF_HAVE_MEMCPYW
+extern inline void
+_scr_memcpyw(u16 *d, u16 *s, unsigned int count)
+{
+#if 1 /* def CONFIG_GDC_32BITACCESS */
+	__asm__ __volatile__ ("shr%L2 %2
+	jz 2f
+" /*	cld	*/ "\
+	test%L0 %3,%0
+	jz 1f
+	movs%W0
+	dec%L2 %2
+1:	shr%L2 %2
+	rep
+	movs%L0
+	jnc 2f
+	movs%W0
+2:"
+			      : "=D"(d), "=S"(s), "=c"(count)
+			      : "g"(2), "0"(d), "1"(s), "2"(count));
+#else
+	__asm__ __volatile__ ("rep\n\tmovsw"
+			      : "=D"(d), "=S"(s), "=c"(count)
+			      : "0"(d), "1"(s), "2"(count / 2));
+#endif
+}
+
+#define scr_memcpyw(d, s, count) \
+	{ \
+	_scr_memcpyw((d), (s), (count)); \
+	_scr_memcpyw(pc9800_attr_offset(d), pc9800_attr_offset(s), (count)); \
+	}
+
+extern inline void
+_scr_memrcpyw(u16 *d, u16 *s, unsigned int count)
+{
+#if 1 /* def CONFIG_GDC_32BITACCESS */
+	u16 tmp;
+
+	__asm__ __volatile__ ("shr%L3 %3
+	jz 2f
+	std
+	lea%L1 -4(%1,%3,2),%1
+	lea%L2 -4(%2,%3,2),%2
+	test%L1 %4,%1
+	jz 1f
+	mov%W0 2(%2),%0
+	sub%L2 %4,%2
+	dec%L3 %3
+	mov%W0 %0,2(%1)
+	sub%L1 %4,%1
+1:	shr%L3 %3
+	rep
+	movs%L0
+	jnc 3f
+	mov%W0 2(%2),%0
+	mov%W0 %0,2(%1)
+3:	cld
+2:"
+			      : "=r"(tmp), "=D"(d), "=S"(s), "=c"(count)
+			      : "g"(2), "1"(d), "2"(s), "3"(count));
+#else
+	__asm__ __volatile__ ("std\n\trep\n\tmovsw\n\tcld"
+			      : "=D"(d), "=S"(s), "=c"(count)
+			      : "0"((void *) d + count - 2),
+			        "1"((void *) s + count - 2), "2"(count / 2));
+#endif	
+}
+
+#define VT_BUF_HAVE_MEMMOVEW
+extern inline void
+_scr_memmovew(u16 *d, u16 *s, unsigned int count)
+{
+	if (d > s)
+		_scr_memrcpyw(d, s, count);
+	else
+		_scr_memcpyw(d, s, count);
+}	
+
+#define scr_memmovew(d, s, count) \
+	{ \
+	_scr_memmovew((d), (s), (count)); \
+	_scr_memmovew(pc9800_attr_offset(d), pc9800_attr_offset(s), (count)); \
+	}
+
+#define VT_BUF_HAVE_MEMCPYF
+extern inline void
+_scr_memcpyw_from(u16 *d, u16 *s, unsigned int count)
+{
+#ifdef CONFIG_GDC_32BITACCESS
+	/* VRAM is quite slow, so we align source pointer (%esi)
+	   to double-word alignment. */
+	__asm__ __volatile__ ("shr%L2 %2
+	jz 2f
+" /*	cld	*/ "\
+	test%L0 %3,%0
+	jz 1f
+	movs%W0
+	dec%L2 %2
+1:	shr%L2 %2
+	rep
+	movs%L0
+	jnc 2f
+	movs%W0
+2:"
+			      : "=D"(d), "=S"(s), "=c"(count)
+			      : "g"(2), "0"(d), "1"(s), "2"(count));
+#else
+	__asm__ __volatile__ ("rep\n\tmovsw"
+			      : "=D"(d), "=S"(s), "=c"(count)
+			      : "0"(d), "1"(s), "2"(count / 2));
+#endif
+}
+
+#define scr_memcpyw_from(d, s, count) \
+	{ \
+	_scr_memcpyw_from((d), (s), (count)); \
+	_scr_memcpyw_from(pc9800_attr_offset(d), pc9800_attr_offset(s), \
+				(count)); \
+	}
+
+#ifdef CONFIG_GDC_32BITACCESS
+# define _scr_memcpyw_to _scr_memcpyw
+#else
+# define _scr_memcpyw_to _scr_memcpyw_from
+#endif
+
+#endif /* _LINUX_ASM_GDC_H_ */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/include/asm-i386/pc9800_sca.h linux.50-ac1/include/asm-i386/pc9800_sca.h
--- linux.50/include/asm-i386/pc9800_sca.h	1970-01-01 01:00:00.000000000 +0100
+++ linux.50-ac1/include/asm-i386/pc9800_sca.h	2002-10-31 15:06:16.000000000 +0000
@@ -0,0 +1,25 @@
+/*
+ *  System-common area definitions for NEC PC-9800 series
+ *
+ *  Copyright (C) 1999	TAKAI Kousuke <tak@kmc.kyoto-u.ac.jp>,
+ *			Kyoto University Microcomputer Club.
+ */
+
+#ifndef _ASM_I386_PC9800SCA_H_
+#define _ASM_I386_PC9800SCA_H_
+
+#define PC9800SCA_EXPMMSZ		(0x0401)	/* B */
+#define PC9800SCA_SCSI_PARAMS		(0x0460)	/* 8 * 4B */
+#define PC9800SCA_DISK_EQUIPS		(0x0482)	/* B */
+#define PC9800SCA_XROM_ID		(0x04C0)	/* 52B */
+#define PC9800SCA_BIOS_FLAG		(0x0501)	/* B */
+#define PC9800SCA_MMSZ16M		(0x0594)	/* W */
+
+/* PC-9821 have additional system common area in their BIOS-ROM segment. */
+
+#define PC9821SCA__BASE			(0xF8E8 << 4)
+#define PC9821SCA_ROM_ID		(PC9821SCA__BASE + 0x00)
+#define PC9821SCA_ROM_FLAG4		(PC9821SCA__BASE + 0x05)
+#define PC9821SCA_RSFLAGS		(PC9821SCA__BASE + 0x11)	/* B */
+
+#endif /* !_ASM_I386_PC9800SCA_H_ */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.54/include/asm-i386/processor.h linux98-2.5.54/include/asm-i386/processor.h
--- linux-2.5.54/include/asm-i386/processor.h	2003-01-02 12:21:01.000000000 +0900
+++ linux98-2.5.54/include/asm-i386/processor.h	2003-01-04 10:47:57.000000000 +0900
@@ -92,7 +92,7 @@
 #define current_cpu_data boot_cpu_data
 #endif
 
-extern char ignore_irq13;
+extern char ignore_fpu_irq;
 
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/include/asm-i386/serial.h linux.50-ac1/include/asm-i386/serial.h
--- linux.50/include/asm-i386/serial.h	2002-11-25 15:09:32.000000000 +0000
+++ linux.50-ac1/include/asm-i386/serial.h	2002-11-15 16:03:44.000000000 +0000
@@ -50,12 +50,19 @@
 
 #define C_P(card,port) (((card)<<6|(port)<<3) + 1)
 
+#ifndef CONFIG_PC9800
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
+#else
+#define STD_SERIAL_PORT_DEFNS			\
+	/* UART CLK   PORT IRQ     FLAGS        */			\
+	{ 0, BASE_BAUD, 0x30, 4, STD_COM_FLAGS },	/* ttyS0 */	\
+	{ 0, BASE_BAUD, 0x238, 5, STD_COM_FLAGS },	/* ttyS1 */
+#endif /* CONFIG_PC9800 */
 
 
 #ifdef CONFIG_SERIAL_MANY_PORTS
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/include/asm-i386/setup.h linux.50-ac1/include/asm-i386/setup.h
--- linux.50/include/asm-i386/setup.h	2002-11-25 15:09:32.000000000 +0000
+++ linux.50-ac1/include/asm-i386/setup.h	2002-10-31 15:06:16.000000000 +0000
@@ -28,6 +28,7 @@
 #define APM_BIOS_INFO (*(struct apm_bios_info *) (PARAM+0x40))
 #define DRIVE_INFO (*(struct drive_info_struct *) (PARAM+0x80))
 #define SYS_DESC_TABLE (*(struct sys_desc_table_struct*)(PARAM+0xa0))
+#define PC9800_MISC_FLAGS (*(unsigned char *)(PARAM+0x1AF))
 #define MOUNT_ROOT_RDONLY (*(unsigned short *) (PARAM+0x1F2))
 #define RAMDISK_FLAGS (*(unsigned short *) (PARAM+0x1F8))
 #define VIDEO_MODE (*(unsigned short *) (PARAM+0x1FA))
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/include/asm-i386/upd4990a.h linux.50-ac1/include/asm-i386/upd4990a.h
--- linux.50/include/asm-i386/upd4990a.h	1970-01-01 01:00:00.000000000 +0100
+++ linux.50-ac1/include/asm-i386/upd4990a.h	2002-10-31 15:06:16.000000000 +0000
@@ -0,0 +1,58 @@
+/*
+ *  Architecture dependent definitions
+ *  for NEC uPD4990A serial I/O real-time clock.
+ *
+ *  Copyright 2001  TAKAI Kousuke <tak@kmc.kyoto-u.ac.jp>
+ *		    Kyoto University Microcomputer Club (KMC).
+ *
+ *  References:
+ *	uPD4990A serial I/O real-time clock users' manual (Japanese)
+ *	No. S12828JJ4V0UM00 (4th revision), NEC Corporation, 1999.
+ */
+
+#ifndef _ASM_I386_uPD4990A_H
+#define _ASM_I386_uPD4990A_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_PC9800
+
+#include <asm/io.h>
+
+#define UPD4990A_IO		(0x0020)
+#define UPD4990A_IO_DATAOUT	(0x0033)
+
+#define UPD4990A_OUTPUT_DATA_CLK(data, clk)		\
+	outb((((data) & 1) << 5) | (((clk) & 1) << 4)	\
+	      | UPD4990A_PAR_SERIAL_MODE, UPD4990A_IO)
+
+#define UPD4990A_OUTPUT_CLK(clk)	UPD4990A_OUTPUT_DATA_CLK(0, (clk))
+
+#define UPD4990A_OUTPUT_STROBE(stb) \
+	outb(((stb) << 3) | UPD4990A_PAR_SERIAL_MODE, UPD4990A_IO)
+
+/*
+ * Note: udelay() is *not* usable for UPD4990A_DELAY because
+ *	 the Linux kernel reads uPD4990A to set up system clock
+ *	 before calibrating delay...
+ */
+#define UPD4990A_DELAY(usec)						\
+	do {								\
+		if (__builtin_constant_p((usec)) && (usec) < 5)	\
+			__asm__ (".rept %c1\n\toutb %%al,%0\n\t.endr"	\
+				 : : "N" (0x5F),			\
+				     "i" (((usec) * 10 + 5) / 6));	\
+		else {							\
+			int _count = ((usec) * 10 + 5) / 6;		\
+			__asm__ volatile ("1: outb %%al,%1\n\tloop 1b"	\
+					  : "=c" (_count)		\
+					  : "N" (0x5F), "0" (_count));	\
+		}							\
+	} while (0)
+
+/* Caller should ignore all bits except bit0 */
+#define UPD4990A_READ_DATA()	inb(UPD4990A_IO_DATAOUT)
+
+#endif /* CONFIG_PC9800 */
+
+#endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/include/linux/upd4990a.h linux.50-ac1/include/linux/upd4990a.h
--- linux.50/include/linux/upd4990a.h	1970-01-01 01:00:00.000000000 +0100
+++ linux.50-ac1/include/linux/upd4990a.h	2002-10-31 15:06:03.000000000 +0000
@@ -0,0 +1,140 @@
+/*
+ *  Constant and architecture independent procedures
+ *  for NEC uPD4990A serial I/O real-time clock.
+ *
+ *  Copyright 2001  TAKAI Kousuke <tak@kmc.kyoto-u.ac.jp>
+ *		    Kyoto University Microcomputer Club (KMC).
+ *
+ *  References:
+ *	uPD4990A serial I/O real-time clock users' manual (Japanese)
+ *	No. S12828JJ4V0UM00 (4th revision), NEC Corporation, 1999.
+ */
+
+#ifndef _LINUX_uPD4990A_H
+#define _LINUX_uPD4990A_H
+
+#include <asm/byteorder.h>
+
+#include <asm/upd4990a.h>
+
+/* Serial commands (4 bits) */
+#define UPD4990A_REGISTER_HOLD			(0x0)
+#define UPD4990A_REGISTER_SHIFT			(0x1)
+#define UPD4990A_TIME_SET_AND_COUNTER_HOLD	(0x2)
+#define UPD4990A_TIME_READ			(0x3)
+#define UPD4990A_TP_64HZ			(0x4)
+#define UPD4990A_TP_256HZ			(0x5)
+#define UPD4990A_TP_2048HZ			(0x6)
+#define UPD4990A_TP_4096HZ			(0x7)
+#define UPD4990A_TP_1S				(0x8)
+#define UPD4990A_TP_10S				(0x9)
+#define UPD4990A_TP_30S				(0xA)
+#define UPD4990A_TP_60S				(0xB)
+#define UPD4990A_INTERRUPT_RESET		(0xC)
+#define UPD4990A_INTERRUPT_TIMER_START		(0xD)
+#define UPD4990A_INTERRUPT_TIMER_STOP		(0xE)
+#define UPD4990A_TEST_MODE_SET			(0xF)
+
+/* Parallel commands (3 bits)
+   0-6 are same with serial commands.  */
+#define UPD4990A_PAR_SERIAL_MODE		7
+
+#ifndef UPD4990A_DELAY
+# include <linux/delay.h>
+# define UPD4990A_DELAY(usec)	udelay((usec))
+#endif
+#ifndef UPD4990A_OUTPUT_DATA
+# define UPD4990A_OUTPUT_DATA(bit)			\
+	do {						\
+		UPD4990A_OUTPUT_DATA_CLK((bit), 0);	\
+		UPD4990A_DELAY(1); /* t-DSU */		\
+		UPD4990A_OUTPUT_DATA_CLK((bit), 1);	\
+		UPD4990A_DELAY(1); /* t-DHLD */	\
+	} while (0)
+#endif
+
+static __inline__ void upd4990a_serial_command(int command)
+{
+	UPD4990A_OUTPUT_DATA(command >> 0);
+	UPD4990A_OUTPUT_DATA(command >> 1);
+	UPD4990A_OUTPUT_DATA(command >> 2);
+	UPD4990A_OUTPUT_DATA(command >> 3);
+	UPD4990A_DELAY(1);	/* t-HLD */
+	UPD4990A_OUTPUT_STROBE(1);
+	UPD4990A_DELAY(1);	/* t-STB & t-d1 */
+	UPD4990A_OUTPUT_STROBE(0);
+	/* 19 microseconds extra delay is needed
+	   iff previous mode is TIME READ command  */
+}
+
+struct upd4990a_raw_data {
+	u8	sec;		/* BCD */
+	u8	min;		/* BCD */
+	u8	hour;		/* BCD */
+	u8	mday;		/* BCD */
+#if   defined __LITTLE_ENDIAN_BITFIELD
+	unsigned wday :4;	/* 0-6 */
+	unsigned mon :4;	/* 1-based */
+#elif defined __BIG_ENDIAN_BITFIELD
+	unsigned mon :4;	/* 1-based */
+	unsigned wday :4;	/* 0-6 */
+#else
+# error Unknown bitfield endian!
+#endif
+	u8	year;		/* BCD */
+};
+
+static __inline__ void upd4990a_get_time(struct upd4990a_raw_data *buf,
+					  int leave_register_hold)
+{
+	int byte;
+
+	upd4990a_serial_command(UPD4990A_TIME_READ);
+	upd4990a_serial_command(UPD4990A_REGISTER_SHIFT);
+	UPD4990A_DELAY(19);	/* t-d2 - t-d1 */
+
+	for (byte = 0; byte < 6; byte++) {
+		u8 tmp;
+		int bit;
+
+		for (tmp = 0, bit = 0; bit < 8; bit++) {
+			tmp = (tmp | (UPD4990A_READ_DATA() << 8)) >> 1;
+			UPD4990A_OUTPUT_CLK(1);
+			UPD4990A_DELAY(1);
+			UPD4990A_OUTPUT_CLK(0);
+			UPD4990A_DELAY(1);
+		}
+		((u8 *) buf)[byte] = tmp;
+	}
+
+	/* The uPD4990A users' manual says that we should issue `Register
+	   Hold' command after each data retrieval, or next `Time Read'
+	   command may not work correctly.  */
+	if (!leave_register_hold)
+		upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+}
+
+static __inline__ void upd4990a_set_time(const struct upd4990a_raw_data *data,
+					  int time_set_only)
+{
+	int byte;
+
+	if (!time_set_only)
+		upd4990a_serial_command(UPD4990A_REGISTER_SHIFT);
+
+	for (byte = 0; byte < 6; byte++) {
+		int bit;
+		u8 tmp = ((const u8 *) data)[byte];
+
+		for (bit = 0; bit < 8; bit++, tmp >>= 1)
+			UPD4990A_OUTPUT_DATA(tmp);
+	}
+
+	upd4990a_serial_command(UPD4990A_TIME_SET_AND_COUNTER_HOLD);
+
+	/* Release counter hold and start the clock.  */
+	if (!time_set_only)
+		upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+}
+
+#endif /* _LINUX_uPD4990A_H */
