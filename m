Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbTDHADM (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbTDGX1R (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:27:17 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3713
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263820AbTDGXMt (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:12:49 -0400
Date: Tue, 8 Apr 2003 01:31:38 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080031.h380VcRQ009182@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: add the same mach specific headers for pc9800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-pc9800/apm.h linux-2.5.67-ac1/include/asm-i386/mach-pc9800/apm.h
--- linux-2.5.67/include/asm-i386/mach-pc9800/apm.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-pc9800/apm.h	2003-03-06 23:29:16.000000000 +0000
@@ -0,0 +1,82 @@
+/*
+ *  include/asm-i386/mach-pc9800/apm.h
+ *
+ *  Machine specific APM BIOS functions for NEC PC9800.
+ *  Split out from apm.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+
+#ifndef _ASM_APM_H
+#define _ASM_APM_H
+
+#include <linux/apm_bios.h>
+
+#ifdef APM_ZERO_SEGS
+#	define APM_DO_ZERO_SEGS \
+		"pushl %%ds\n\t" \
+		"pushl %%es\n\t" \
+		"xorl %%edx, %%edx\n\t" \
+		"mov %%dx, %%ds\n\t" \
+		"mov %%dx, %%es\n\t" \
+		"mov %%dx, %%fs\n\t" \
+		"mov %%dx, %%gs\n\t"
+#	define APM_DO_POP_SEGS \
+		"popl %%es\n\t" \
+		"popl %%ds\n\t"
+#else
+#	define APM_DO_ZERO_SEGS
+#	define APM_DO_POP_SEGS
+#endif
+
+static inline void apm_bios_call_asm(u32 func, u32 ebx_in, u32 ecx_in,
+					u32 *eax, u32 *ebx, u32 *ecx,
+					u32 *edx, u32 *esi)
+{
+	/*
+	 * N.B. We do NOT need a cld after the BIOS call
+	 * because we always save and restore the flags.
+	 */
+	__asm__ __volatile__(APM_DO_ZERO_SEGS
+		"pushl %%edi\n\t"
+		"pushl %%ebp\n\t"
+		"pushfl\n\t"
+		"lcall *%%cs:apm_bios_entry\n\t"
+		"setc %%al\n\t"
+		"popl %%ebp\n\t"
+		"popl %%edi\n\t"
+		APM_DO_POP_SEGS
+		: "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx),
+		  "=S" (*esi)
+		: "a" (func), "b" (ebx_in), "c" (ecx_in)
+		: "memory", "cc");
+}
+
+static inline u8 apm_bios_call_simple_asm(u32 func, u32 ebx_in,
+						u32 ecx_in, u32 *eax)
+{
+	int	cx, dx, si;
+	u8	error;
+
+	/*
+	 * N.B. We do NOT need a cld after the BIOS call
+	 * because we always save and restore the flags.
+	 */
+	__asm__ __volatile__(APM_DO_ZERO_SEGS
+		"pushl %%edi\n\t"
+		"pushl %%ebp\n\t"
+		"pushfl\n\t"
+		"lcall *%%cs:apm_bios_entry\n\t"
+		"setc %%bl\n\t"
+		"popl %%ebp\n\t"
+		"popl %%edi\n\t"
+		APM_DO_POP_SEGS
+		: "=a" (*eax), "=b" (error), "=c" (cx), "=d" (dx),
+		  "=S" (si)
+		: "a" (func), "b" (ebx_in), "c" (ecx_in)
+		: "memory", "cc");
+	if (func == APM_FUNC_VERSION)
+		*eax = (*eax & 0xff00) | ((*eax & 0x00f0) >> 4);
+
+	return error;
+}
+
+#endif /* _ASM_APM_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-pc9800/bios_ebda.h linux-2.5.67-ac1/include/asm-i386/mach-pc9800/bios_ebda.h
--- linux-2.5.67/include/asm-i386/mach-pc9800/bios_ebda.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-pc9800/bios_ebda.h	2003-03-14 01:10:39.000000000 +0000
@@ -0,0 +1,14 @@
+#ifndef _MACH_BIOS_EBDA_H
+#define _MACH_BIOS_EBDA_H
+
+/*
+ * PC-9800 has no EBDA.
+ * Its BIOS uses 0x40E for other purpose,
+ * Not pointer to 4K EBDA area.
+ */
+static inline unsigned int get_bios_ebda(void)
+{
+	return 0;	/* 0 means none */
+}
+
+#endif /* _MACH_BIOS_EBDA_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-pc9800/do_timer.h linux-2.5.67-ac1/include/asm-i386/mach-pc9800/do_timer.h
--- linux-2.5.67/include/asm-i386/mach-pc9800/do_timer.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-pc9800/do_timer.h	2003-03-14 01:17:16.000000000 +0000
@@ -0,0 +1,82 @@
+/* defines for inline arch setup functions */
+
+#include <asm/apic.h>
+
+/**
+ * do_timer_interrupt_hook - hook into timer tick
+ * @regs:	standard registers from interrupt
+ *
+ * Description:
+ *	This hook is called immediately after the timer interrupt is ack'd.
+ *	It's primary purpose is to allow architectures that don't possess
+ *	individual per CPU clocks (like the CPU APICs supply) to broadcast the
+ *	timer interrupt as a means of triggering reschedules etc.
+ **/
+
+static inline void do_timer_interrupt_hook(struct pt_regs *regs)
+{
+	do_timer(regs);
+/*
+ * In the SMP case we use the local APIC timer interrupt to do the
+ * profiling, except when we simulate SMP mode on a uniprocessor
+ * system, in that case we have to call the local interrupt handler.
+ */
+#ifndef CONFIG_X86_LOCAL_APIC
+	x86_do_profile(regs);
+#else
+	if (!using_apic_timer)
+		smp_local_timer_interrupt(regs);
+#endif
+}
+
+
+/* you can safely undefine this if you don't have the Neptune chipset */
+
+#define BUGGY_NEPTUN_TIMER
+
+/**
+ * do_timer_overflow - process a detected timer overflow condition
+ * @count:	hardware timer interrupt count on overflow
+ *
+ * Description:
+ *	This call is invoked when the jiffies count has not incremented but
+ *	the hardware timer interrupt has.  It means that a timer tick interrupt
+ *	came along while the previous one was pending, thus a tick was missed
+ **/
+static inline int do_timer_overflow(int count)
+{
+	int i;
+
+	spin_lock(&i8259A_lock);
+	/*
+	 * This is tricky when I/O APICs are used;
+	 * see do_timer_interrupt().
+	 */
+	i = inb(0x00);
+	spin_unlock(&i8259A_lock);
+	
+	/* assumption about timer being IRQ0 */
+	if (i & 0x01) {
+		/*
+		 * We cannot detect lost timer interrupts ... 
+		 * well, that's why we call them lost, don't we? :)
+		 * [hmm, on the Pentium and Alpha we can ... sort of]
+		 */
+		count -= LATCH;
+	} else {
+#ifdef BUGGY_NEPTUN_TIMER
+		/*
+		 * for the Neptun bug we know that the 'latch'
+		 * command doesn't latch the high and low value
+		 * of the counter atomically. Thus we have to 
+		 * substract 256 from the counter 
+		 * ... funny, isnt it? :)
+		 */
+		
+		count -= 256;
+#else
+		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
+#endif
+	}
+	return count;
+}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-pc9800/io_ports.h linux-2.5.67-ac1/include/asm-i386/mach-pc9800/io_ports.h
--- linux-2.5.67/include/asm-i386/mach-pc9800/io_ports.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-pc9800/io_ports.h	2003-02-14 22:59:47.000000000 +0000
@@ -0,0 +1,30 @@
+/*
+ *  arch/i386/mach-pc9800/io_ports.h
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-pc9800/irq_vectors.h linux-2.5.67-ac1/include/asm-i386/mach-pc9800/irq_vectors.h
--- linux-2.5.67/include/asm-i386/mach-pc9800/irq_vectors.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-pc9800/irq_vectors.h	2003-02-14 22:59:47.000000000 +0000
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-pc9800/mach_resources.h linux-2.5.67-ac1/include/asm-i386/mach-pc9800/mach_resources.h
--- linux-2.5.67/include/asm-i386/mach-pc9800/mach_resources.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-pc9800/mach_resources.h	2003-03-14 01:17:51.000000000 +0000
@@ -0,0 +1,191 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_resources.h
+ *
+ *  Machine specific resource allocation for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_RESOURCES_H
+#define _MACH_RESOURCES_H
+
+static char str_pic1[] = "pic1";
+static char str_dma[] = "dma";
+static char str_pic2[] = "pic2";
+static char str_calender_clock[] = "calender clock";
+static char str_system[] = "system";
+static char str_nmi_control[] = "nmi control";
+static char str_kanji_rom[] = "kanji rom";
+static char str_keyboard[] = "keyboard";
+static char str_text_gdc[] = "text gdc";
+static char str_crtc[] = "crtc";
+static char str_timer[] = "timer";
+static char str_graphic_gdc[] = "graphic gdc";
+static char str_dma_ex_bank[] = "dma ex. bank";
+static char str_beep_freq[] = "beep freq.";
+static char str_mouse_pio[] = "mouse pio";
+struct resource standard_io_resources[] = {
+	{ str_pic1, 0x00, 0x00, IORESOURCE_BUSY },
+	{ str_dma, 0x01, 0x01, IORESOURCE_BUSY },
+	{ str_pic1, 0x02, 0x02, IORESOURCE_BUSY },
+	{ str_dma, 0x03, 0x03, IORESOURCE_BUSY },
+	{ str_dma, 0x05, 0x05, IORESOURCE_BUSY },
+	{ str_dma, 0x07, 0x07, IORESOURCE_BUSY },
+	{ str_pic2, 0x08, 0x08, IORESOURCE_BUSY },
+	{ str_dma, 0x09, 0x09, IORESOURCE_BUSY },
+	{ str_pic2, 0x0a, 0x0a, IORESOURCE_BUSY },
+	{ str_dma, 0x0b, 0x0b, IORESOURCE_BUSY },
+	{ str_dma, 0x0d, 0x0d, IORESOURCE_BUSY },
+	{ str_dma, 0x0f, 0x0f, IORESOURCE_BUSY },
+	{ str_dma, 0x11, 0x11, IORESOURCE_BUSY },
+	{ str_dma, 0x13, 0x13, IORESOURCE_BUSY },
+	{ str_dma, 0x15, 0x15, IORESOURCE_BUSY },
+	{ str_dma, 0x17, 0x17, IORESOURCE_BUSY },
+	{ str_dma, 0x19, 0x19, IORESOURCE_BUSY },
+	{ str_dma, 0x1b, 0x1b, IORESOURCE_BUSY },
+	{ str_dma, 0x1d, 0x1d, IORESOURCE_BUSY },
+	{ str_dma, 0x1f, 0x1f, IORESOURCE_BUSY },
+	{ str_calender_clock, 0x20, 0x20, 0 },
+	{ str_dma, 0x21, 0x21, IORESOURCE_BUSY },
+	{ str_calender_clock, 0x22, 0x22, 0 },
+	{ str_dma, 0x23, 0x23, IORESOURCE_BUSY },
+	{ str_dma, 0x25, 0x25, IORESOURCE_BUSY },
+	{ str_dma, 0x27, 0x27, IORESOURCE_BUSY },
+	{ str_dma, 0x29, 0x29, IORESOURCE_BUSY },
+	{ str_dma, 0x2b, 0x2b, IORESOURCE_BUSY },
+	{ str_dma, 0x2d, 0x2d, IORESOURCE_BUSY },
+	{ str_system, 0x31, 0x31, IORESOURCE_BUSY },
+	{ str_system, 0x33, 0x33, IORESOURCE_BUSY },
+	{ str_system, 0x35, 0x35, IORESOURCE_BUSY },
+	{ str_system, 0x37, 0x37, IORESOURCE_BUSY },
+	{ str_nmi_control, 0x50, 0x50, IORESOURCE_BUSY },
+	{ str_nmi_control, 0x52, 0x52, IORESOURCE_BUSY },
+	{ "time stamp", 0x5c, 0x5f, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa1, 0xa1, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa3, 0xa3, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa5, 0xa5, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa7, 0xa7, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa9, 0xa9, IORESOURCE_BUSY },
+	{ str_keyboard, 0x41, 0x41, IORESOURCE_BUSY },
+	{ str_keyboard, 0x43, 0x43, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x60, 0x60, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x62, 0x62, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x64, 0x64, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x66, 0x66, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x68, 0x68, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6a, 0x6a, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6c, 0x6c, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6e, 0x6e, IORESOURCE_BUSY },
+	{ str_crtc, 0x70, 0x70, IORESOURCE_BUSY },
+	{ str_crtc, 0x72, 0x72, IORESOURCE_BUSY },
+	{ str_crtc, 0x74, 0x74, IORESOURCE_BUSY },
+	{ str_crtc, 0x74, 0x74, IORESOURCE_BUSY },
+	{ str_crtc, 0x76, 0x76, IORESOURCE_BUSY },
+	{ str_crtc, 0x78, 0x78, IORESOURCE_BUSY },
+	{ str_crtc, 0x7a, 0x7a, IORESOURCE_BUSY },
+	{ str_timer, 0x71, 0x71, IORESOURCE_BUSY },
+	{ str_timer, 0x73, 0x73, IORESOURCE_BUSY },
+	{ str_timer, 0x75, 0x75, IORESOURCE_BUSY },
+	{ str_timer, 0x77, 0x77, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa0, 0xa0, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa2, 0xa2, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa4, 0xa4, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa6, 0xa6, IORESOURCE_BUSY },
+	{ "cpu", 0xf0, 0xf7, IORESOURCE_BUSY },
+	{ "fpu", 0xf8, 0xff, IORESOURCE_BUSY },
+	{ str_dma_ex_bank, 0x0e05, 0x0e05, 0 },
+	{ str_dma_ex_bank, 0x0e07, 0x0e07, 0 },
+	{ str_dma_ex_bank, 0x0e09, 0x0e09, 0 },
+	{ str_dma_ex_bank, 0x0e0b, 0x0e0b, 0 },
+	{ str_beep_freq, 0x3fd9, 0x3fd9, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdb, 0x3fdb, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdd, 0x3fdd, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdf, 0x3fdf, IORESOURCE_BUSY },
+	/* All PC-9800 have (exactly) one mouse interface.  */
+	{ str_mouse_pio, 0x7fd9, 0x7fd9, 0 },
+	{ str_mouse_pio, 0x7fdb, 0x7fdb, 0 },
+	{ str_mouse_pio, 0x7fdd, 0x7fdd, 0 },
+	{ str_mouse_pio, 0x7fdf, 0x7fdf, 0 },
+	{ "mouse timer", 0xbfdb, 0xbfdb, 0 },
+	{ "mouse irq", 0x98d7, 0x98d7, 0 },
+};
+
+#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
+
+static struct resource tvram_resource = { "Text VRAM/CG window", 0xa0000, 0xa4fff, IORESOURCE_BUSY };
+static struct resource gvram_brg_resource = { "Graphic VRAM (B/R/G)", 0xa8000, 0xbffff, IORESOURCE_BUSY };
+static struct resource gvram_e_resource = { "Graphic VRAM (E)", 0xe0000, 0xe7fff, IORESOURCE_BUSY };
+
+/* System ROM resources */
+#define MAXROMS 6
+static struct resource rom_resources[MAXROMS] = {
+	{ "System ROM", 0xe8000, 0xfffff, IORESOURCE_BUSY }
+};
+
+static inline void probe_video_rom(int roms)
+{
+	/* PC-9800 has no video ROM */
+}
+
+static inline void probe_extension_roms(int roms)
+{
+	int i;
+	__u8 *xrom_id;
+
+	xrom_id = (__u8 *) isa_bus_to_virt(PC9800SCA_XROM_ID + 0x10);
+
+	for (i = 0; i < 16; i++) {
+		if (xrom_id[i] & 0x80) {
+			int j;
+
+			for (j = i + 1; j < 16 && (xrom_id[j] & 0x80); j++)
+				;
+			rom_resources[roms].start = 0x0d0000 + i * 0x001000;
+			rom_resources[roms].end = 0x0d0000 + j * 0x001000 - 1;
+			rom_resources[roms].name = "Extension ROM";
+			rom_resources[roms].flags = IORESOURCE_BUSY;
+
+			request_resource(&iomem_resource,
+					  rom_resources + roms);
+			if (++roms >= MAXROMS)
+				return;
+		}
+	}
+}
+
+static inline void request_graphics_resource(void)
+{
+	int i;
+
+	if (PC9800_HIGHRESO_P()) {
+		tvram_resource.start = 0xe0000;
+		tvram_resource.end   = 0xe4fff;
+		gvram_brg_resource.name  = "Graphic VRAM";
+		gvram_brg_resource.start = 0xc0000;
+		gvram_brg_resource.end   = 0xdffff;
+	}
+
+	request_resource(&iomem_resource, &tvram_resource);
+	request_resource(&iomem_resource, &gvram_brg_resource);
+	if (!PC9800_HIGHRESO_P())
+		request_resource(&iomem_resource, &gvram_e_resource);
+
+	if (PC9800_HIGHRESO_P() || PC9800_9821_P()) {
+		static char graphics[] = "graphics";
+		static struct resource graphics_resources[] = {
+			{ graphics, 0x9a0, 0x9a0, 0 },
+			{ graphics, 0x9a2, 0x9a2, 0 },
+			{ graphics, 0x9a4, 0x9a4, 0 },
+			{ graphics, 0x9a6, 0x9a6, 0 },
+			{ graphics, 0x9a8, 0x9a8, 0 },
+			{ graphics, 0x9aa, 0x9aa, 0 },
+			{ graphics, 0x9ac, 0x9ac, 0 },
+			{ graphics, 0x9ae, 0x9ae, 0 },
+		};
+
+#define GRAPHICS_RESOURCES (sizeof(graphics_resources)/sizeof(struct resource))
+
+		for (i = 0; i < GRAPHICS_RESOURCES; i++)
+			request_resource(&ioport_resource, graphics_resources + i);
+	}
+}
+
+#endif /* !_MACH_RESOURCES_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-pc9800/mach_time.h linux-2.5.67-ac1/include/asm-i386/mach-pc9800/mach_time.h
--- linux-2.5.67/include/asm-i386/mach-pc9800/mach_time.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-pc9800/mach_time.h	2003-03-14 01:06:58.000000000 +0000
@@ -0,0 +1,100 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_time.h
+ *
+ *  Machine specific set RTC function for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TIME_H
+#define _MACH_TIME_H
+
+#include <linux/bcd.h>
+#include <linux/upd4990a.h>
+
+/* for check timing call set_rtc_mmss() */
+/* used in arch/i386/time.c::do_timer_interrupt() */
+/*
+ * Because PC-9800's RTC (NEC uPD4990A) does not allow setting
+ * time partially, we always have to read-modify-write the
+ * entire time (including year) so that set_rtc_mmss() will
+ * take quite much time to execute.  You may want to relax
+ * RTC resetting interval (currently ~11 minuts)...
+ */
+#define USEC_AFTER	1000000
+#define USEC_BEFORE	0
+
+static inline int mach_set_rtc_mmss(unsigned long nowtime)
+{
+	int retval = 0;
+	int real_seconds, real_minutes, cmos_minutes;
+	struct upd4990a_raw_data data;
+
+	upd4990a_get_time(&data, 1);
+	cmos_minutes = BCD2BIN(data.min);
+
+	/*
+	 * since we're only adjusting minutes and seconds,
+	 * don't interfere with hour overflow. This avoids
+	 * messing with unknown time zones but requires your
+	 * RTC not to be off by more than 15 minutes
+	 */
+	real_seconds = nowtime % 60;
+	real_minutes = nowtime / 60;
+	if (((abs(real_minutes - cmos_minutes) + 15) / 30) & 1)
+		real_minutes += 30;	/* correct for half hour time zone */
+	real_minutes %= 60;
+
+	if (abs(real_minutes - cmos_minutes) < 30) {
+		u8 temp_seconds = (real_seconds / 10) * 16 + real_seconds % 10;
+		u8 temp_minutes = (real_minutes / 10) * 16 + real_minutes % 10;
+
+		if (data.sec != temp_seconds || data.min != temp_minutes) {
+			data.sec = temp_seconds;
+			data.min = temp_minutes;
+			upd4990a_set_time(&data, 1);
+		}
+	} else {
+		printk(KERN_WARNING
+		       "set_rtc_mmss: can't update from %d to %d\n",
+		       cmos_minutes, real_minutes);
+		retval = -1;
+	}
+
+	/* uPD4990A users' manual says we should issue Register Hold
+	 * command after reading time, or future Time Read command
+	 * may not work.  When we have set the time, this also starts
+	 * the clock.
+	 */
+	upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+
+	return retval;
+}
+
+static inline unsigned long mach_get_cmos_time(void)
+{
+	int i;
+	u8 prev, cur;
+	unsigned int year;
+	struct upd4990a_raw_data data;
+
+	/* Connect uPD4990A's DATA OUT pin to its 1Hz reference clock. */
+	upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+
+	/* Catch rising edge of reference clock.  */
+	prev = ~UPD4990A_READ_DATA();
+	for (i = 0; i < 1800000; i++) { /* may take up to 1 second... */
+		__asm__ ("outb %%al,%0" : : "N" (0x5f)); /* 0.6usec delay */
+		cur = UPD4990A_READ_DATA();
+		if (!(prev & cur & 1))
+			break;
+		prev = ~cur;
+	}
+
+	upd4990a_get_time(&data, 0);
+
+	if ((year = BCD2BIN(data.year) + 1900) < 1995)
+		year += 100;
+	return mktime(year, data.mon, BCD2BIN(data.mday), BCD2BIN(data.hour),
+			BCD2BIN(data.min), BCD2BIN(data.sec));
+}
+
+#endif /* !_MACH_TIME_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-pc9800/mach_timer.h linux-2.5.67-ac1/include/asm-i386/mach-pc9800/mach_timer.h
--- linux-2.5.67/include/asm-i386/mach-pc9800/mach_timer.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-pc9800/mach_timer.h	2003-03-14 01:17:16.000000000 +0000
@@ -0,0 +1,31 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_timer.h
+ *
+ *  Machine specific calibrate_tsc() for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+/* ------ Calibrate the TSC ------- 
+ * PC-9800:
+ *  CTC cannot be used because some models (especially
+ *  note-machines) may disable clock to speaker channel (#1)
+ *  unless speaker is enabled.  We use ARTIC instead.
+ */
+#ifndef _MACH_TIMER_H
+#define _MACH_TIMER_H
+
+#define CALIBRATE_LATCH	(5 * 307200/HZ) /* 0.050sec * 307200Hz = 15360 */
+
+static inline void mach_prepare_counter(void)
+{
+	/* ARTIC can't be stopped nor reset. So we wait roundup. */
+	while (inw(0x5c));
+}
+
+static inline void mach_countup(unsigned long *count)
+{
+	do {
+		*count = inw(0x5c);
+	} while (*count < CALIBRATE_LATCH);
+}
+
+#endif /* !_MACH_TIMER_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-pc9800/mach_traps.h linux-2.5.67-ac1/include/asm-i386/mach-pc9800/mach_traps.h
--- linux-2.5.67/include/asm-i386/mach-pc9800/mach_traps.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-pc9800/mach_traps.h	2003-03-06 23:33:53.000000000 +0000
@@ -0,0 +1,27 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_traps.h
+ *
+ *  Machine specific NMI handling for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TRAPS_H
+#define _MACH_TRAPS_H
+
+static inline void clear_mem_error(unsigned char reason)
+{
+	outb(0x08, 0x37);
+	outb(0x09, 0x37);
+}
+
+static inline unsigned char get_nmi_reason(void)
+{
+	return (inb(0x33) & 6) ? 0x80 : 0;
+}
+
+static inline void reassert_nmi(void)
+{
+	outb(0x09, 0x50);	/* disable NMI once */
+	outb(0x09, 0x52);	/* re-enable it */
+}
+
+#endif /* !_MACH_TRAPS_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-pc9800/mach_wakecpu.h linux-2.5.67-ac1/include/asm-i386/mach-pc9800/mach_wakecpu.h
--- linux-2.5.67/include/asm-i386/mach-pc9800/mach_wakecpu.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-pc9800/mach_wakecpu.h	2003-03-14 01:10:39.000000000 +0000
@@ -0,0 +1,45 @@
+#ifndef __ASM_MACH_WAKECPU_H
+#define __ASM_MACH_WAKECPU_H
+
+/* 
+ * This file copes with machines that wakeup secondary CPUs by the
+ * INIT, INIT, STARTUP sequence.
+ */
+
+#define WAKE_SECONDARY_VIA_INIT
+
+/*
+ * On PC-9800, continuation on warm reset is done by loading
+ * %ss:%sp from 0x0000:0404 and executing 'lret', so:
+ */
+#define TRAMPOLINE_LOW phys_to_virt(0x4fa)
+#define TRAMPOLINE_HIGH phys_to_virt(0x4fc)
+
+#define boot_cpu_apicid boot_cpu_physical_apicid
+
+static inline void wait_for_init_deassert(atomic_t *deassert)
+{
+	while (!atomic_read(deassert));
+	return;
+}
+
+/* Nothing to do for most platforms, since cleared by the INIT cycle */
+static inline void smp_callin_clear_local_apic(void)
+{
+}
+
+static inline void store_NMI_vector(unsigned short *high, unsigned short *low)
+{
+}
+
+static inline void restore_NMI_vector(unsigned short *high, unsigned short *low)
+{
+}
+
+#if APIC_DEBUG
+ #define inquire_remote_apic(apicid) __inquire_remote_apic(apicid)
+#else
+ #define inquire_remote_apic(apicid) {}
+#endif
+
+#endif /* __ASM_MACH_WAKECPU_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-i386/mach-pc9800/smpboot_hooks.h linux-2.5.67-ac1/include/asm-i386/mach-pc9800/smpboot_hooks.h
--- linux-2.5.67/include/asm-i386/mach-pc9800/smpboot_hooks.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-i386/mach-pc9800/smpboot_hooks.h	2003-03-14 01:10:39.000000000 +0000
@@ -0,0 +1,52 @@
+/* two abstractions specific to kernel/smpboot.c, mainly to cater to visws
+ * which needs to alter them. */
+
+static inline void smpboot_clear_io_apic_irqs(void)
+{
+	io_apic_irqs = 0;
+}
+
+static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
+{
+	/* reset code is stored in 8255 on PC-9800. */
+	outb(0x0e, 0x37);	/* SHUT0 = 0 */
+	local_flush_tlb();
+	Dprintk("1.\n");
+	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
+	Dprintk("2.\n");
+	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
+	Dprintk("3.\n");
+	/*
+	 * On PC-9800, continuation on warm reset is done by loading
+	 * %ss:%sp from 0x0000:0404 and executing 'lret', so:
+	 */
+	/* 0x3f0 is on unused interrupt vector and should be safe... */
+	*((volatile unsigned long *) phys_to_virt(0x404)) = 0x000003f0;
+	Dprintk("4.\n");
+}
+
+static inline void smpboot_restore_warm_reset_vector(void)
+{
+	/*
+	 * Install writable page 0 entry to set BIOS data area.
+	 */
+	local_flush_tlb();
+
+	/*
+	 * Paranoid:  Set warm reset code and vector here back
+	 * to default values.
+	 */
+	outb(0x0f, 0x37);	/* SHUT0 = 1 */
+
+	*((volatile long *) phys_to_virt(0x404)) = 0;
+}
+
+static inline void smpboot_setup_io_apic(void)
+{
+	/*
+	 * Here we can be sure that there is an IO-APIC in the system. Let's
+	 * go and set it up:
+	 */
+	if (!skip_ioapic_setup && nr_ioapics)
+		setup_IO_APIC();
+}
