Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267238AbTBLNt2>; Wed, 12 Feb 2003 08:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTBLNrw>; Wed, 12 Feb 2003 08:47:52 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:36736 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267221AbTBLNqj>; Wed, 12 Feb 2003 08:46:39 -0500
Date: Wed, 12 Feb 2003 22:55:17 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (19/34) include/asm
Message-ID: <20030212135517.GT1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (19/34).

Core patches for PC98 under include/asm-i386/ directory.

- Osamu Tomita

diff -Nru linux/include/asm-i386/dma.h linux98/include/asm-i386/dma.h
--- linux/include/asm-i386/dma.h	2002-07-21 04:52:59.000000000 +0900
+++ linux98/include/asm-i386/dma.h	2002-08-17 22:15:06.000000000 +0900
@@ -10,6 +10,9 @@
 
 #include <linux/config.h>
 #include <linux/spinlock.h>	/* And spinlocks */
+#ifdef CONFIG_X86_PC9800
+#include <asm/pc9800_dma.h>
+#else /* !CONFIG_X86_PC9800 */
 #include <asm/io.h>		/* need byte IO */
 #include <linux/delay.h>
 
@@ -72,8 +75,10 @@
 
 #define MAX_DMA_CHANNELS	8
 
+#ifndef CONFIG_X86_PC9800
 /* The maximum address that we can perform a DMA transfer to on this platform */
 #define MAX_DMA_ADDRESS      (PAGE_OFFSET+0x1000000)
+#endif
 
 /* 8237 DMA controllers */
 #define IO_DMA1_BASE	0x00	/* 8 bit slave DMA, channels 0..3 */
@@ -295,4 +300,6 @@
 #define isa_dma_bridge_buggy 	(0)
 #endif
 
+#endif /* CONFIG_X86_PC9800 */
+
 #endif /* _ASM_DMA_H */
diff -Nru linux/include/asm-i386/io.h linux98/include/asm-i386/io.h
--- linux/include/asm-i386/io.h	2002-10-12 13:22:45.000000000 +0900
+++ linux98/include/asm-i386/io.h	2002-10-12 19:25:19.000000000 +0900
@@ -27,6 +27,8 @@
  *		Linus
  */
 
+#include <linux/config.h>
+
  /*
   *  Bit simplified and optimized by Jan Hubicka
   *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999.
@@ -288,7 +290,11 @@
 #ifdef SLOW_IO_BY_JUMPING
 #define __SLOW_DOWN_IO "jmp 1f; 1: jmp 1f; 1:"
 #else
+#ifndef CONFIG_X86_PC9800
 #define __SLOW_DOWN_IO "outb %%al,$0x80;"
+#else
+#define __SLOW_DOWN_IO "outb %%al,$0x5f;"
+#endif
 #endif
 
 static inline void slow_down_io(void) {
diff -Nru linux/include/asm-i386/irq.h linux98/include/asm-i386/irq.h
--- linux/include/asm-i386/irq.h	2002-09-21 00:20:16.000000000 +0900
+++ linux98/include/asm-i386/irq.h	2002-09-21 07:17:56.000000000 +0900
@@ -17,7 +17,11 @@
 
 static __inline__ int irq_cannonicalize(int irq)
 {
+#ifndef CONFIG_X86_PC9800
 	return ((irq == 2) ? 9 : irq);
+#else
+	return ((irq == 7) ? 11 : irq);
+#endif
 }
 
 extern void disable_irq(unsigned int);
diff -Nru linux/include/asm-i386/pc9800.h linux98/include/asm-i386/pc9800.h
--- linux/include/asm-i386/pc9800.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/pc9800.h	2002-08-17 21:50:18.000000000 +0900
@@ -0,0 +1,27 @@
+/*
+ *  PC-9800 machine types.
+ *
+ *  Copyright (C) 1999	TAKAI Kosuke <tak@kmc.kyoto-u.ac.jp>
+ *			(Linux/98 Project)
+ */
+
+#ifndef _ASM_PC9800_H_
+#define _ASM_PC9800_H_
+
+#include <asm/pc9800_sca.h>
+#include <asm/types.h>
+
+#define __PC9800SCA(type, pa)	(*(type *) phys_to_virt(pa))
+#define __PC9800SCA_TEST_BIT(pa, n)	\
+	((__PC9800SCA(u8, pa) & (1U << (n))) != 0)
+
+#define PC9800_HIGHRESO_P()	__PC9800SCA_TEST_BIT(PC9800SCA_BIOS_FLAG, 3)
+#define PC9800_8MHz_P()		__PC9800SCA_TEST_BIT(PC9800SCA_BIOS_FLAG, 7)
+
+				/* 0x2198 is 98 21 on memory... */
+#define PC9800_9821_P()		(__PC9800SCA(u16, PC9821SCA_ROM_ID) == 0x2198)
+
+/* Note PC9821_...() are valid only when PC9800_9821_P() was true. */
+#define PC9821_IDEIF_DOUBLE_P()	__PC9800SCA_TEST_BIT(PC9821SCA_ROM_FLAG4, 4)
+
+#endif
diff -Nru linux/include/asm-i386/pc9800_dma.h linux98/include/asm-i386/pc9800_dma.h
--- linux/include/asm-i386/pc9800_dma.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/pc9800_dma.h	2002-08-17 21:15:01.000000000 +0900
@@ -0,0 +1,238 @@
+/* $Id: dma.h,v 1.7 1992/12/14 00:29:34 root Exp root $
+ * linux/include/asm/dma.h: Defines for using and allocating dma channels.
+ * Written by Hennus Bergman, 1992.
+ * High DMA channel support & info by Hannu Savolainen
+ * and John Boyd, Nov. 1992.
+ */
+
+#ifndef _ASM_PC9800_DMA_H
+#define _ASM_PC9800_DMA_H
+
+#include <linux/config.h>
+#include <asm/io.h>		/* need byte IO */
+#include <linux/delay.h>
+
+
+#ifdef HAVE_REALLY_SLOW_DMA_CONTROLLER
+#define dma_outb	outb_p
+#else
+#define dma_outb	outb
+#endif
+
+#define dma_inb		inb
+
+/*
+ * NOTES about DMA transfers:
+ *
+ *  controller 1: channels 0-3, byte operations, ports 00-1F
+ *  controller 2: channels 4-7, word operations, ports C0-DF
+ *
+ *  - ALL registers are 8 bits only, regardless of transfer size
+ *  - channel 4 is not used - cascades 1 into 2.
+ *  - channels 0-3 are byte - addresses/counts are for physical bytes
+ *  - channels 5-7 are word - addresses/counts are for physical words
+ *  - transfers must not cross physical 64K (0-3) or 128K (5-7) boundaries
+ *  - transfer count loaded to registers is 1 less than actual count
+ *  - controller 2 offsets are all even (2x offsets for controller 1)
+ *  - page registers for 5-7 don't use data bit 0, represent 128K pages
+ *  - page registers for 0-3 use bit 0, represent 64K pages
+ *
+ * DMA transfers are limited to the lower 16MB of _physical_ memory.  
+ * Note that addresses loaded into registers must be _physical_ addresses,
+ * not logical addresses (which may differ if paging is active).
+ *
+ *  Address mapping for channels 0-3:
+ *
+ *   A23 ... A16 A15 ... A8  A7 ... A0    (Physical addresses)
+ *    |  ...  |   |  ... |   |  ... |
+ *    |  ...  |   |  ... |   |  ... |
+ *    |  ...  |   |  ... |   |  ... |
+ *   P7  ...  P0  A7 ... A0  A7 ... A0   
+ * |    Page    | Addr MSB | Addr LSB |   (DMA registers)
+ *
+ *  Address mapping for channels 5-7:
+ *
+ *   A23 ... A17 A16 A15 ... A9 A8 A7 ... A1 A0    (Physical addresses)
+ *    |  ...  |   \   \   ... \  \  \  ... \  \
+ *    |  ...  |    \   \   ... \  \  \  ... \  (not used)
+ *    |  ...  |     \   \   ... \  \  \  ... \
+ *   P7  ...  P1 (0) A7 A6  ... A0 A7 A6 ... A0   
+ * |      Page      |  Addr MSB   |  Addr LSB  |   (DMA registers)
+ *
+ * Again, channels 5-7 transfer _physical_ words (16 bits), so addresses
+ * and counts _must_ be word-aligned (the lowest address bit is _ignored_ at
+ * the hardware level, so odd-byte transfers aren't possible).
+ *
+ * Transfer count (_not # bytes_) is limited to 64K, represented as actual
+ * count - 1 : 64K => 0xFFFF, 1 => 0x0000.  Thus, count is always 1 or more,
+ * and up to 128K bytes may be transferred on channels 5-7 in one operation. 
+ *
+ */
+
+#define MAX_DMA_CHANNELS	4
+
+/* The maximum address that we can perform a DMA transfer to on this platform */
+#define MAX_DMA_ADDRESS      (~0UL)
+
+/* 8237 DMA controllers */
+#define IO_DMA_BASE		0x01
+
+/* DMA controller registers */
+#define DMA_CMD_REG			((IO_DMA_BASE)+0x10) /* command register (w) */
+#define DMA_STAT_REG		((IO_DMA_BASE)+0x10) /* status register (r) */
+#define DMA_REQ_REG			((IO_DMA_BASE)+0x12) /* request register (w) */
+#define DMA_MASK_REG		((IO_DMA_BASE)+0x14) /* single-channel mask (w) */
+#define DMA_MODE_REG		((IO_DMA_BASE)+0x16) /* mode register (w) */
+#define DMA_CLEAR_FF_REG	((IO_DMA_BASE)+0x18) /* clear pointer flip-flop (w) */
+#define DMA_TEMP_REG		((IO_DMA_BASE)+0x1A) /* Temporary Register (r) */
+#define DMA_RESET_REG		((IO_DMA_BASE)+0x1A) /* Master Clear (w) */
+#define DMA_CLR_MASK_REG	((IO_DMA_BASE)+0x1C) /* Clear Mask */
+#define DMA_MASK_ALL_REG	((IO_DMA_BASE)+0x1E) /* all-channels mask (w) */
+
+#define DMA_PAGE_0			0x27	/* DMA page registers */
+#define DMA_PAGE_1			0x21
+#define DMA_PAGE_2			0x23
+#define DMA_PAGE_3			0x25
+
+#define DMA_Ex_PAGE_0		0xe05	/* DMA Extended page reg base */
+#define DMA_Ex_PAGE_1		0xe07
+#define DMA_Ex_PAGE_2		0xe09
+#define DMA_Ex_PAGE_3		0xe0b
+
+#define DMA_MODE_READ	0x44	/* I/O to memory, no autoinit, increment, single mode */
+#define DMA_MODE_WRITE	0x48	/* memory to I/O, no autoinit, increment, single mode */
+#define DMA_AUTOINIT	0x10
+
+extern spinlock_t  dma_spin_lock;
+
+static __inline__ unsigned long claim_dma_lock(void)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&dma_spin_lock, flags);
+	return flags;
+}
+
+static __inline__ void release_dma_lock(unsigned long flags)
+{
+	spin_unlock_irqrestore(&dma_spin_lock, flags);
+}
+
+/* enable/disable a specific DMA channel */
+static __inline__ void enable_dma(unsigned int dmanr)
+{
+	dma_outb(dmanr,  DMA_MASK_REG);
+}
+
+static __inline__ void disable_dma(unsigned int dmanr)
+{
+	dma_outb(dmanr | 4,  DMA_MASK_REG);
+}
+
+/* Clear the 'DMA Pointer Flip Flop'.
+ * Write 0 for LSB/MSB, 1 for MSB/LSB access.
+ * Use this once to initialize the FF to a known state.
+ * After that, keep track of it. :-)
+ * --- In order to do that, the DMA routines below should ---
+ * --- only be used while holding the DMA lock ! ---
+ */
+static __inline__ void clear_dma_ff(unsigned int dmanr)
+{
+	dma_outb(0,  DMA_CLEAR_FF_REG);
+}
+
+/* set mode (above) for a specific DMA channel */
+static __inline__ void set_dma_mode(unsigned int dmanr, char mode)
+{
+	dma_outb(mode | dmanr,  DMA_MODE_REG);
+}
+
+/* Set only the page register bits of the transfer address.
+ * This is used for successive transfers when we know the contents of
+ * the lower 16 bits of the DMA current address register, but a 64k boundary
+ * may have been crossed.
+ */
+static __inline__ void set_dma_page(unsigned int dmanr, unsigned int pagenr)
+{
+	unsigned char low=pagenr&0xff;
+	unsigned char hi=pagenr>>8;
+
+	switch(dmanr) {
+		case 0:
+			dma_outb(low, DMA_PAGE_0);
+			dma_outb(hi, DMA_Ex_PAGE_0);
+			break;
+		case 1:
+			dma_outb(low, DMA_PAGE_1);
+			dma_outb(hi, DMA_Ex_PAGE_1);
+			break;
+		case 2:
+			dma_outb(low, DMA_PAGE_2);
+			dma_outb(hi, DMA_Ex_PAGE_2);
+			break;
+		case 3:
+			dma_outb(low, DMA_PAGE_3);
+			dma_outb(hi, DMA_Ex_PAGE_3);
+			break;
+	}
+}
+
+/* Set transfer address & page bits for specific DMA channel.
+ * Assumes dma flipflop is clear.
+ */
+static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int a)
+{
+	set_dma_page(dmanr, a>>16);
+	dma_outb( a & 0xff, ((dmanr&3)<<2) + IO_DMA_BASE );
+	dma_outb( (a>>8) & 0xff, ((dmanr&3)<<2) + IO_DMA_BASE );
+}
+
+
+/* Set transfer size (max 64k for DMA1..3, 128k for DMA5..7) for
+ * a specific DMA channel.
+ * You must ensure the parameters are valid.
+ * NOTE: from a manual: "the number of transfers is one more
+ * than the initial word count"! This is taken into account.
+ * Assumes dma flip-flop is clear.
+ * NOTE 2: "count" represents _bytes_ and must be even for channels 5-7.
+ */
+static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
+{
+	count--;
+	dma_outb( count & 0xff, ((dmanr&3)<<2) + 2 + IO_DMA_BASE );
+	dma_outb( (count>>8) & 0xff, ((dmanr&3)<<2) + 2 + IO_DMA_BASE );
+}
+
+
+/* Get DMA residue count. After a DMA transfer, this
+ * should return zero. Reading this while a DMA transfer is
+ * still in progress will return unpredictable results.
+ * If called before the channel has been used, it may return 1.
+ * Otherwise, it returns the number of _bytes_ left to transfer.
+ *
+ * Assumes DMA flip-flop is clear.
+ */
+static __inline__ int get_dma_residue(unsigned int dmanr)
+{
+	/* using short to get 16-bit wrap around */
+	unsigned short count;
+
+	count = 1 + dma_inb(((dmanr&3)<<2) + 2 + IO_DMA_BASE);
+	count += dma_inb(((dmanr&3)<<2) + 2 + IO_DMA_BASE) << 8;
+	
+	return count;
+}
+
+
+/* These are in kernel/dma.c: */
+extern int request_dma(unsigned int dmanr, const char * device_id);	/* reserve a DMA channel */
+extern void free_dma(unsigned int dmanr);	/* release it again */
+
+/* From PCI */
+
+#ifdef CONFIG_PCI
+extern int isa_dma_bridge_buggy;
+#else
+#define isa_dma_bridge_buggy 	(0)
+#endif
+
+#endif /* _ASM_PC9800_DMA_H */
diff -Nru linux-2.5.60/include/asm-i386/pgtable.h linux98-2.5.60/include/asm-i386/pgtable.h
--- linux-2.5.60/include/asm-i386/pgtable.h	2003-02-11 03:38:48.000000000 +0900
+++ linux98-2.5.60/include/asm-i386/pgtable.h	2003-02-11 12:56:40.000000000 +0900
@@ -49,7 +49,11 @@
 
 #endif
 
+#ifndef CONFIG_X86_PC9800
 #define __beep() asm("movb $0x3,%al; outb %al,$0x61")
+#else
+#define __beep() asm("movb $0x6,%al; outb %al,$0x37")
+#endif
 
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
diff -Nru linux/include/asm-i386/scatterlist.h linux98/include/asm-i386/scatterlist.h
--- linux/include/asm-i386/scatterlist.h	2002-04-15 04:18:52.000000000 +0900
+++ linux98/include/asm-i386/scatterlist.h	2002-04-17 10:37:22.000000000 +0900
@@ -1,6 +1,8 @@
 #ifndef _I386_SCATTERLIST_H
 #define _I386_SCATTERLIST_H
 
+#include <linux/config.h>
+
 struct scatterlist {
     struct page		*page;
     unsigned int	offset;
@@ -8,6 +10,10 @@
     unsigned int	length;
 };
 
+#ifdef CONFIG_X86_PC9800
+#define ISA_DMA_THRESHOLD (0xffffffff)
+#else
 #define ISA_DMA_THRESHOLD (0x00ffffff)
+#endif
 
 #endif /* !(_I386_SCATTERLIST_H) */
diff -Nru linux/include/asm-i386/timex.h linux98/include/asm-i386/timex.h
--- linux/include/asm-i386/timex.h	2002-02-14 18:09:15.000000000 +0900
+++ linux98/include/asm-i386/timex.h	2002-02-14 23:58:57.000000000 +0900
@@ -9,11 +9,15 @@
 #include <linux/config.h>
 #include <asm/msr.h>
 
+#ifdef CONFIG_X86_PC9800
+   extern int CLOCK_TICK_RATE;
+#else
 #ifdef CONFIG_MELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
 #else
 #  define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
 #endif
+#endif
 
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
