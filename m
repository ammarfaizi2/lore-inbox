Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSKBRrP>; Sat, 2 Nov 2002 12:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSKBRrP>; Sat, 2 Nov 2002 12:47:15 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:56915 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261321AbSKBRrC>; Sat, 2 Nov 2002 12:47:02 -0500
Date: Sun, 3 Nov 2002 02:53:07 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC][Patchset 5/20] Support for PC-9800 (core2)
Message-ID: <20021103025307.I1536@precia.cinet.co.jp>
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

This is a part 5/20 of patchset for add support NEC PC-9800 architecture,
against 2.5.45.

Summary:
  core modules (continued)

diffstat:
  include/asm-i386/bugs.h         |    2  include/asm-i386/dma.h          |    7 +
  include/asm-i386/io.h           |    6 +
  include/asm-i386/irq.h          |    4  include/asm-i386/pc9800.h       |   27 ++++
  include/asm-i386/pc9800_debug.h |  152 +++++++++++++++++++++++++
  include/asm-i386/pc9800_dma.h   |  238 ++++++++++++++++++++++++++++++++++++++++
  include/asm-i386/pc9800_sca.h   |   25 ++++
  include/asm-i386/pgtable.h      |    4  include/asm-i386/processor.h    |    2  include/asm-i386/scatterlist.h  |    6 +
  include/asm-i386/setup.h        |    1  include/asm-i386/timex.h        |    4  13 files changed, 477 insertions(+), 1 deletion(-)

patch:
diff -urN linux/include/asm-i386/bugs.h linux98/include/asm-i386/bugs.h
--- linux/include/asm-i386/bugs.h	Sun Jun  9 14:27:38 2002
+++ linux98/include/asm-i386/bugs.h	Mon Jun 10 20:49:15 2002
@@ -34,6 +34,7 @@
   __setup("no-hlt", no_halt);
  +#ifndef CONFIG_PC9800
  static int __init mca_pentium(char *s)
  {
  	mca_pentium_flag = 1;
@@ -41,6 +42,7 @@
  }
   __setup("mca-pentium", mca_pentium);
+#endif
   static int __init no_387(char *s)
  {
diff -urN linux/include/asm-i386/dma.h linux98/include/asm-i386/dma.h
--- linux/include/asm-i386/dma.h	Sat Jul 21 04:52:59 2001
+++ linux98/include/asm-i386/dma.h	Fri Aug 17 22:15:06 2001
@@ -10,6 +10,9 @@
   #include <linux/config.h>
  #include <linux/spinlock.h>	/* And spinlocks */
+#ifdef CONFIG_PC9800
+#include <asm/pc9800_dma.h>
+#else /* !CONFIG_PC9800 */
  #include <asm/io.h>		/* need byte IO */
  #include <linux/delay.h>
  @@ -72,8 +75,10 @@
   #define MAX_DMA_CHANNELS	8
  +#ifndef CONFIG_PC9800
  /* The maximum address that we can perform a DMA transfer to on this platform */
  #define MAX_DMA_ADDRESS      (PAGE_OFFSET+0x1000000)
+#endif
   /* 8237 DMA controllers */
  #define IO_DMA1_BASE	0x00	/* 8 bit slave DMA, channels 0..3 */
@@ -295,4 +300,6 @@
  #define isa_dma_bridge_buggy 	(0)
  #endif
  +#endif /* CONFIG_PC9800 */
+
  #endif /* _ASM_DMA_H */
diff -urN linux/include/asm-i386/io.h linux98/include/asm-i386/io.h
--- linux/include/asm-i386/io.h	Sat Oct 12 13:22:45 2002
+++ linux98/include/asm-i386/io.h	Sat Oct 12 19:25:19 2002
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
+#ifndef CONFIG_PC9800
  #define __SLOW_DOWN_IO "outb %%al,$0x80;"
+#else
+#define __SLOW_DOWN_IO "outb %%al,$0x5f;"
+#endif
  #endif
   static inline void slow_down_io(void) {
diff -urN linux/include/asm-i386/irq.h linux98/include/asm-i386/irq.h
--- linux/include/asm-i386/irq.h	Sat Sep 21 00:20:16 2002
+++ linux98/include/asm-i386/irq.h	Sat Sep 21 07:17:56 2002
@@ -17,7 +17,11 @@
   static __inline__ int irq_cannonicalize(int irq)
  {
+#ifndef CONFIG_PC9800
  	return ((irq == 2) ? 9 : irq);
+#else
+	return ((irq == 7) ? 11 : irq);
+#endif
  }
   extern void disable_irq(unsigned int);
diff -urN linux/include/asm-i386/pc9800.h linux98/include/asm-i386/pc9800.h
--- linux/include/asm-i386/pc9800.h	Thu Jan  1 09:00:00 1970
+++ linux98/include/asm-i386/pc9800.h	Fri Aug 17 21:50:18 2001
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
diff -urN linux/include/asm-i386/pc9800_debug.h linux98/include/asm-i386/pc9800_debug.h
--- linux/include/asm-i386/pc9800_debug.h	Thu Jan  1 09:00:00 1970
+++ linux98/include/asm-i386/pc9800_debug.h	Fri Aug 17 22:20:21 2001
@@ -0,0 +1,152 @@
+/*
+ * linux/include/asm-i386/pc9800_debug.h: Defines for debug routines
+ *
+ * Written by Linux/98 Project, 1998.
+ *
+ * Revised by TAKAI Kousuke, Nov 1999.
+ */
+
+#ifndef _ASM_PC9800_DEBUG_H
+#define _ASM_PC9800_DEBUG_H
+
+extern unsigned char __pc9800_beep_flag;
+
+/* Don't depend on <asm/io.h> ... */
+static __inline__ void pc9800_beep_on(void)
+{
+	__asm__ ("out%B0 %0,%1" : : "a"((char) 0x6), "N"(0x37));
+	__pc9800_beep_flag = 0x6;
+}
+
+static __inline__ void pc9800_beep_off(void)
+{
+	__asm__ ("out%B0 %0,%1" : : "a"((char) 0x7), "N"(0x37));
+	__pc9800_beep_flag = 0x7;
+}
+
+static __inline__ void pc9800_beep_toggle(void)
+{
+	__pc9800_beep_flag ^= 1;
+	__asm__ ("out%B0 %0,%1" : : "a"(__pc9800_beep_flag), "N"(0x37));
+}
+
+static __inline__ void pc9800_udelay(unsigned int __usec)
+{
+	if ((__usec = __usec * 10 / 6) > 0)
+		do
+			__asm__ ("out%B0 %%al,%0" : : "N"(0x5F));
+		while (--__usec);
+}
+
+# define assertk(expr)	({						\
+	if (!(expr)) {							\
+		__pc9800_saveregs();					\
+		__assert_fail(__BASE_FILE__, __FILE__, __LINE__,	\
+			       __PRETTY_FUNCTION__,			\
+			       __builtin_return_address (0), #expr);	\
+	}								\
+})
+# define check_kernel_pointer(expr)	({				\
+	void *__p = (expr);						\
+	if ((unsigned long) __p < PAGE_OFFSET) {			\
+		__pc9800_saveregs();					\
+		__invalid_kernel_pointer				\
+			(__BASE_FILE__, __FILE__, __LINE__,		\
+			 __PRETTY_FUNCTION__,				\
+			 __builtin_return_address(0), #expr, __p);	\
+	}								\
+})
+
+extern void __assert_fail(const char *, const char *, unsigned int,
+			   const char *, void *, const char *)
+     __attribute__ ((__noreturn__));
+extern void __invalid_kernel_pointer(const char *, const char *, unsigned int,
+				      const char *, void *,
+				      const char *, void *)
+     __attribute__ ((__noreturn__));
+extern void __pc9800_saveregs(void);
+
+extern void ucg_saveargs(unsigned int, ...);
+
+#ifdef NEED_UNMAP_PHYSPAGE
+
+#include <linux/mm.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+
+/*
+ * unmap_physpage (addr)
+ */
+static __inline__ void
+unmap_physpage(unsigned long addr)
+{
+	pgd_t *pgd = pgd_offset_k(addr);
+	pmd_t *pmd;
+	pte_t *pte;
+
+	if (pgd_none(*pgd))
+		panic("%s: No pgd?!?", __BASE_FILE__);
+	pmd = pmd_offset(pgd, addr);
+	if (pmd_none(*pmd))
+		panic("%s: No pmd?!?", __BASE_FILE__);
+	if (pmd_val(*pmd) & _PAGE_PSE) {
+		int i;
+		unsigned long paddr = pmd_val(*pmd) & PAGE_MASK;
+
+		pte = (pte_t *) __get_free_page(GFP_KERNEL);
+		set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)));
+		for (i = 0; i < PTRS_PER_PTE; pte++, i++)
+			*pte = mk_pte_phys(paddr + i * PAGE_SIZE,
+					    PAGE_KERNEL);
+	}
+	pte = pte_offset(pmd, addr);
+
+	set_pte(pte, pte_modify(*pte, PAGE_NONE));
+	__flush_tlb_one(addr);
+}
+#endif /* NEED_UNMAP_PHYSPAGE */
+
+#ifdef NEED_KERNEL_POINTER_CHECKER
+# /* no dep */ include <asm/uaccess.h>
+
+/*
+ *  KERNEL_POINTER_VALIDP(PTR) validates kernel pointer PTR.
+ *  If PTR points vaild memory address for kernel internal use,
+ *  return nonzero; otherwise return zero.
+ *
+ *  Note PTR is invalid if PTR points user area.
+ */
+#define KERNEL_POINTER_VALIDP(PTR)	({	\
+	const int *_ptr = (const int *) (PTR);	\
+	int _dummy;				\
+	(unsigned long) _ptr >= PAGE_OFFSET	\
+		&& !__get_user(_dummy, _ptr);	\
+})
+
+/*
+ *  Similar, but validates for a trivial string in kernel.
+ *  Here `trivial' means that the string has no non-ASCII characters
+ *  and is shorter than 80 characters.
+ *
+ *  Note this is intended for checking various `name' (I/O
+ *  resources and so on).
+ */
+#define KERNEL_POINTER_TRIVIAL_STRING_P(PTR)	({			\
+	const char *_ptr = (const char *) (PTR);			\
+	char _dummy;							\
+	(unsigned long) _ptr >= PAGE_OFFSET				\
+		&& ({ int _result;					\
+		      while (!(_result = __get_user(_dummy, _ptr))	\
+			     && _dummy)					\
+			      _ptr++;					\
+		      !_result; }); })
+
+#endif /* NEED_VALIDATE_KERNEL_POINTER */
+
+#endif /* _ASM_PC9800_DEBUG_H */
+ 
+/*
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -urN linux/include/asm-i386/pc9800_dma.h linux98/include/asm-i386/pc9800_dma.h
--- linux/include/asm-i386/pc9800_dma.h	Thu Jan  1 09:00:00 1970
+++ linux98/include/asm-i386/pc9800_dma.h	Fri Aug 17 22:15:01 2001
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
+ * DMA transfers are limited to the lower 16MB of _physical_ memory.  + * Note that addresses loaded into registers must be _physical_ addresses,
+ * not logical addresses (which may differ if paging is active).
+ *
+ *  Address mapping for channels 0-3:
+ *
+ *   A23 ... A16 A15 ... A8  A7 ... A0    (Physical addresses)
+ *    |  ...  |   |  ... |   |  ... |
+ *    |  ...  |   |  ... |   |  ... |
+ *    |  ...  |   |  ... |   |  ... |
+ *   P7  ...  P0  A7 ... A0  A7 ... A0   + * |    Page    | Addr MSB | Addr LSB |   (DMA registers)
+ *
+ *  Address mapping for channels 5-7:
+ *
+ *   A23 ... A17 A16 A15 ... A9 A8 A7 ... A1 A0    (Physical addresses)
+ *    |  ...  |   \   \   ... \  \  \  ... \  \
+ *    |  ...  |    \   \   ... \  \  \  ... \  (not used)
+ *    |  ...  |     \   \   ... \  \  \  ... \
+ *   P7  ...  P1 (0) A7 A6  ... A0 A7 A6 ... A0   + * |      Page      |  Addr MSB   |  Addr LSB  |   (DMA registers)
+ *
+ * Again, channels 5-7 transfer _physical_ words (16 bits), so addresses
+ * and counts _must_ be word-aligned (the lowest address bit is _ignored_ at
+ * the hardware level, so odd-byte transfers aren't possible).
+ *
+ * Transfer count (_not # bytes_) is limited to 64K, represented as actual
+ * count - 1 : 64K => 0xFFFF, 1 => 0x0000.  Thus, count is always 1 or more,
+ * and up to 128K bytes may be transferred on channels 5-7 in one operation. + *
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
diff -urN linux/include/asm-i386/pc9800_sca.h linux98/include/asm-i386/pc9800_sca.h
--- linux/include/asm-i386/pc9800_sca.h	Thu Jan  1 09:00:00 1970
+++ linux98/include/asm-i386/pc9800_sca.h	Fri Aug 17 21:50:18 2001
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
diff -urN linux/include/asm-i386/pgtable.h linux98/include/asm-i386/pgtable.h
--- linux/include/asm-i386/pgtable.h	Mon Apr 15 04:18:55 2002
+++ linux98/include/asm-i386/pgtable.h	Wed Apr 17 10:37:22 2002
@@ -58,7 +58,11 @@
  #endif
  #endif
  +#ifndef CONFIG_PC9800
  #define __beep() asm("movb $0x3,%al; outb %al,$0x61")
+#else
+#define __beep() asm("movb $0x6,%al; outb %al,$0x37")
+#endif
   #define PMD_SIZE	(1UL << PMD_SHIFT)
  #define PMD_MASK	(~(PMD_SIZE-1))
diff -urN linux/include/asm-i386/processor.h linux98/include/asm-i386/processor.h
--- linux/include/asm-i386/processor.h	Sat Sep 21 00:20:15 2002
+++ linux98/include/asm-i386/processor.h	Sun Sep 22 09:16:38 2002
@@ -87,7 +87,7 @@
  #define current_cpu_data boot_cpu_data
  #endif
  -extern char ignore_irq13;
+extern char ignore_fpu_irq;
   extern void identify_cpu(struct cpuinfo_x86 *);
  extern void print_cpu_info(struct cpuinfo_x86 *);
diff -urN linux/include/asm-i386/scatterlist.h linux98/include/asm-i386/scatterlist.h
--- linux/include/asm-i386/scatterlist.h	Mon Apr 15 04:18:52 2002
+++ linux98/include/asm-i386/scatterlist.h	Wed Apr 17 10:37:22 2002
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
  +#ifdef CONFIG_PC9800
+#define ISA_DMA_THRESHOLD (0xffffffff)
+#else
  #define ISA_DMA_THRESHOLD (0x00ffffff)
+#endif
   #endif /* !(_I386_SCATTERLIST_H) */
diff -urN linux/include/asm-i386/setup.h linux98/include/asm-i386/setup.h
--- linux/include/asm-i386/setup.h	Sat Oct 19 13:02:01 2002
+++ linux98/include/asm-i386/setup.h	Mon Oct 21 15:32:08 2002
@@ -28,6 +28,7 @@
  #define APM_BIOS_INFO (*(struct apm_bios_info *) (PARAM+0x40))
  #define DRIVE_INFO (*(struct drive_info_struct *) (PARAM+0x80))
  #define SYS_DESC_TABLE (*(struct sys_desc_table_struct*)(PARAM+0xa0))
+#define PC9800_MISC_FLAGS (*(unsigned char *)(PARAM+0x1AF))
  #define MOUNT_ROOT_RDONLY (*(unsigned short *) (PARAM+0x1F2))
  #define RAMDISK_FLAGS (*(unsigned short *) (PARAM+0x1F8))
  #define VIDEO_MODE (*(unsigned short *) (PARAM+0x1FA))
diff -urN linux/include/asm-i386/timex.h linux98/include/asm-i386/timex.h
--- linux/include/asm-i386/timex.h	Thu Feb 14 18:09:15 2002
+++ linux98/include/asm-i386/timex.h	Thu Feb 14 23:58:57 2002
@@ -9,11 +9,15 @@
  #include <linux/config.h>
  #include <asm/msr.h>
  +#ifdef CONFIG_PC9800
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
