Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVBUNsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVBUNsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 08:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVBUNsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 08:48:03 -0500
Received: from mxc.rambler.ru ([81.19.66.31]:28686 "EHLO mxc.rambler.ru")
	by vger.kernel.org with ESMTP id S261968AbVBUNrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 08:47:15 -0500
Date: Mon, 21 Feb 2005 16:49:44 -0500
From: Pavel Fedin <sonic_amiga@rambler.ru>
To: linux-kernel@vger.kernel.org
Cc: Alain.Knaff@poboxes.com, linuxppc-dev@ozlabs.org
Subject: [PATCH] Non-DMA mode for floppy on PowerPC
Message-Id: <20050221164944.178e402d.sonic_amiga@rambler.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__21_Feb_2005_16_49_44_-0500_zd6ultuw.aZohvYx"
X-Auth-User: sonic_amiga, whoson: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__21_Feb_2005_16_49_44_-0500_zd6ultuw.aZohvYx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

 Nobody answered, repost again.

 This patch allows to use floppy drive in non-DMA mode on PegasosPPC machines. To use it:
 1. Do not build floppy driver as a module, link it statically. Transferring parameters to it from insmod is still problematic, at least it doesn't work properly on my system. May be i'll clean it up in future.
 2. Specify floppy=nodma in kernel's arguments. Also you'll need to specify your drive type here using floppy=<Drive number>,<Drive type>,cmos. For example, floppy=0,4,cmos specifies type 4 (1.44 mb 3.5") for drive 0 on my system.
 This patch does not affect operation of the driver in DMA mode so it's safe to use on any platform.
 The patch is written for kernel version 2.6.8. Please merge it with -p0 argument, i already know it's wrong and will be more correct in the future.

-- 
Best regards,
Pavel Fedin,									mailto:sonic_amiga@rambler.ru



--Multipart=_Mon__21_Feb_2005_16_49_44_-0500_zd6ultuw.aZohvYx
Content-Type: text/plain;
 name="ppc_floppy-vdma.diff"
Content-Disposition: attachment;
 filename="ppc_floppy-vdma.diff"
Content-Transfer-Encoding: 7bit

--- include/asm-ppc/floppy.h.orig	2004-08-14 09:36:45.000000000 +0400
+++ include/asm-ppc/floppy.h	2005-02-12 02:26:54.000000000 +0300
@@ -11,30 +11,188 @@
 #ifndef __ASM_PPC_FLOPPY_H
 #define __ASM_PPC_FLOPPY_H
 
+#include <linux/vmalloc.h>
+
+#define CSW fd_routine[can_use_virtual_dma & 1]
+
 #define fd_inb(port)			inb_p(port)
 #define fd_outb(value,port)		outb_p(value,port)
 
-#define fd_enable_dma()         enable_dma(FLOPPY_DMA)
-#define fd_disable_dma()        disable_dma(FLOPPY_DMA)
-#define fd_request_dma()        request_dma(FLOPPY_DMA,"floppy")
-#define fd_free_dma()           free_dma(FLOPPY_DMA)
-#define fd_clear_dma_ff()       clear_dma_ff(FLOPPY_DMA)
-#define fd_set_dma_mode(mode)   set_dma_mode(FLOPPY_DMA,mode)
-#define fd_set_dma_addr(addr)   set_dma_addr(FLOPPY_DMA,(unsigned int)virt_to_bus(addr))
-#define fd_set_dma_count(count) set_dma_count(FLOPPY_DMA,count)
+#define fd_disable_dma()	CSW._disable_dma(FLOPPY_DMA)
+#define fd_request_dma()        CSW._request_dma(FLOPPY_DMA,"floppy")
+#define fd_free_dma()           CSW._free_dma(FLOPPY_DMA)
+#define fd_get_dma_residue()    CSW._get_dma_residue(FLOPPY_DMA)
+#define fd_dma_mem_alloc(size)	CSW._dma_mem_alloc(size)
+#define fd_dma_setup(addr, size, mode, io) CSW._dma_setup(addr, size, mode, io)
 #define fd_enable_irq()         enable_irq(FLOPPY_IRQ)
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
-#define fd_cacheflush(addr,size) /* nothing */
-#define fd_request_irq()        request_irq(FLOPPY_IRQ, floppy_interrupt, \
-					    SA_INTERRUPT|SA_SAMPLE_RANDOM, \
-				            "floppy", NULL)
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL);
 
-__inline__ void virtual_dma_init(void)
+static int virtual_dma_count;
+static int virtual_dma_residue;
+static char *virtual_dma_addr;
+static int virtual_dma_mode;
+static int doing_pdma;
+
+static irqreturn_t floppy_hardint(int irq, void *dev_id, struct pt_regs * regs)
+{
+	register unsigned char st;
+
+#undef TRACE_FLPY_INT
+
+#ifdef TRACE_FLPY_INT
+	static int calls=0;
+	static int bytes=0;
+	static int dma_wait=0;
+#endif
+	if (!doing_pdma)
+		return floppy_interrupt(irq, dev_id, regs);
+
+#ifdef TRACE_FLPY_INT
+	if(!calls)
+		bytes = virtual_dma_count;
+#endif
+	{
+		register int lcount;
+		register char *lptr;
+
+		st = 1;
+		for(lcount=virtual_dma_count, lptr=virtual_dma_addr; 
+		    lcount; lcount--, lptr++) {
+			st=inb(virtual_dma_port+4) & 0xa0 ;
+			if(st != 0xa0) 
+				break;
+			if(virtual_dma_mode)
+				outb_p(*lptr, virtual_dma_port+5);
+			else
+				*lptr = inb_p(virtual_dma_port+5);
+		}
+		virtual_dma_count = lcount;
+		virtual_dma_addr = lptr;
+		st = inb(virtual_dma_port+4);
+	}
+
+#ifdef TRACE_FLPY_INT
+	calls++;
+#endif
+	if(st == 0x20)
+		return IRQ_HANDLED;
+	if(!(st & 0x20)) {
+		virtual_dma_residue += virtual_dma_count;
+		virtual_dma_count=0;
+#ifdef TRACE_FLPY_INT
+		printk("count=%x, residue=%x calls=%d bytes=%d dma_wait=%d\n", 
+		       virtual_dma_count, virtual_dma_residue, calls, bytes,
+		       dma_wait);
+		calls = 0;
+		dma_wait=0;
+#endif
+		doing_pdma = 0;
+		floppy_interrupt(irq, dev_id, regs);
+		return IRQ_HANDLED;
+	}
+#ifdef TRACE_FLPY_INT
+	if(!virtual_dma_count)
+		dma_wait++;
+#endif
+	return IRQ_HANDLED;
+}
+
+static void vdma_disable_dma(unsigned int dummy)
 {
-	/* Nothing to do on PowerPC */
+	doing_pdma = 0;
+	virtual_dma_residue += virtual_dma_count;
+	virtual_dma_count=0;
 }
 
+static int vdma_request_dma(unsigned int dmanr, const char * device_id)
+{
+	return 0;
+}
+
+static void vdma_nop(unsigned int dummy)
+{
+}
+
+
+static int vdma_get_dma_residue(unsigned int dummy)
+{
+	return virtual_dma_count + virtual_dma_residue;
+}
+
+
+static int fd_request_irq(void)
+{
+	if(can_use_virtual_dma)
+		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
+						   "floppy", NULL);
+	else
+		return request_irq(FLOPPY_IRQ, floppy_interrupt,
+						   SA_INTERRUPT|SA_SAMPLE_RANDOM,
+						   "floppy", NULL);	
+
+}
+
+static inline unsigned long dma_mem_alloc(unsigned long size)
+{
+	return __get_dma_pages(GFP_KERNEL,get_order(size));
+}
+
+
+static inline unsigned long vdma_mem_alloc(unsigned long size)
+{
+	return __get_free_pages(GFP_KERNEL,get_order(size));
+}
+
+static int vdma_dma_setup(char *addr, unsigned long size, int mode, int io)
+{
+	doing_pdma = 1;
+	virtual_dma_port = io;
+	virtual_dma_mode = (mode  == DMA_MODE_WRITE);
+	virtual_dma_addr = addr;
+	virtual_dma_count = size;
+	virtual_dma_residue = 0;
+	return 0;
+}
+
+static int hard_dma_setup(char *addr, unsigned long size, int mode, int io)
+{
+	/* actual, physical DMA */
+	doing_pdma = 0;
+	clear_dma_ff(FLOPPY_DMA);
+	set_dma_mode(FLOPPY_DMA,mode);
+	set_dma_addr(FLOPPY_DMA,(unsigned int)virt_to_bus(addr));
+	set_dma_count(FLOPPY_DMA,size);
+	enable_dma(FLOPPY_DMA);
+	return 0;
+}
+
+struct fd_routine_l {
+	void (*_disable_dma)(unsigned int dmanr);
+	int (*_request_dma)(unsigned int dmanr, const char * device_id);
+	void (*_free_dma)(unsigned int dmanr);
+	int (*_get_dma_residue)(unsigned int dummy);
+	unsigned long (*_dma_mem_alloc) (unsigned long size);
+	int (*_dma_setup)(char *addr, unsigned long size, int mode, int io);
+} fd_routine[] = {
+	{
+		disable_dma,
+		request_dma,
+		free_dma,
+		get_dma_residue,
+		dma_mem_alloc,
+		hard_dma_setup
+	},
+	{
+		vdma_disable_dma,
+		vdma_request_dma,
+		vdma_nop,
+		vdma_get_dma_residue,
+		vdma_mem_alloc,
+		vdma_dma_setup
+	}
+};
+
 static int FDC1 = 0x3f0;
 static int FDC2 = -1;
 

--Multipart=_Mon__21_Feb_2005_16_49_44_-0500_zd6ultuw.aZohvYx--
