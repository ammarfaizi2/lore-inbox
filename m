Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVCOETA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVCOETA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVCOES7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:18:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:8862 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262231AbVCOESL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:18:11 -0500
Subject: [PATCH] ppc32: Add virtual DMA support to legacy floppy driver on
	ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 15:16:22 +1100
Message-Id: <1110860182.29124.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for pseudo-dma transfers on ppc32 for the
legacy floppy driver. It is useful on some machines like pegasos
where the legacy DMA doesn't seem to work properly (possibly to
the lack of a "legacy" DMA zone on ppc32).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Pavel Fedin <sonic_amiga@rambler.ru>

Index: linux-work/include/asm-ppc/floppy.h
===================================================================
--- linux-work.orig/include/asm-ppc/floppy.h	2005-03-15 11:59:38.000000000 +1100
+++ linux-work/include/asm-ppc/floppy.h	2005-03-15 14:36:56.000000000 +1100
@@ -11,28 +11,149 @@
 #ifndef __ASM_PPC_FLOPPY_H
 #define __ASM_PPC_FLOPPY_H
 
-#define fd_inb(port)			inb_p(port)
-#define fd_outb(value,port)		outb_p(value,port)
+#define fd_inb(port)		inb_p(port)
+#define fd_outb(value,port)	outb_p(value,port)
 
-#define fd_enable_dma()         enable_dma(FLOPPY_DMA)
-#define fd_disable_dma()        disable_dma(FLOPPY_DMA)
-#define fd_request_dma()        request_dma(FLOPPY_DMA,"floppy")
-#define fd_free_dma()           free_dma(FLOPPY_DMA)
-#define fd_clear_dma_ff()       clear_dma_ff(FLOPPY_DMA)
-#define fd_set_dma_mode(mode)   set_dma_mode(FLOPPY_DMA,mode)
-#define fd_set_dma_addr(addr)   set_dma_addr(FLOPPY_DMA,(unsigned int)virt_to_bus(addr))
-#define fd_set_dma_count(count) set_dma_count(FLOPPY_DMA,count)
+#define fd_disable_dma()	fd_ops->_disable_dma(FLOPPY_DMA)
+#define fd_free_dma()           fd_ops->_free_dma(FLOPPY_DMA)
+#define fd_get_dma_residue()    fd_ops->_get_dma_residue(FLOPPY_DMA)
+#define fd_dma_setup(addr, size, mode, io) fd_ops->_dma_setup(addr, size, mode, io)
 #define fd_enable_irq()         enable_irq(FLOPPY_IRQ)
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
-#define fd_cacheflush(addr,size) /* nothing */
-#define fd_request_irq()        request_irq(FLOPPY_IRQ, floppy_interrupt, \
-					    SA_INTERRUPT|SA_SAMPLE_RANDOM, \
-				            "floppy", NULL)
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL);
 
-__inline__ void virtual_dma_init(void)
+static int fd_request_dma(void);
+
+struct fd_dma_ops {
+	void (*_disable_dma)(unsigned int dmanr);
+	void (*_free_dma)(unsigned int dmanr);
+	int (*_get_dma_residue)(unsigned int dummy);
+	int (*_dma_setup)(char *addr, unsigned long size, int mode, int io);
+};
+
+static int virtual_dma_count;
+static int virtual_dma_residue;
+static char *virtual_dma_addr;
+static int virtual_dma_mode;
+static int doing_vdma;
+static struct fd_dma_ops *fd_ops;
+
+static irqreturn_t floppy_hardint(int irq, void *dev_id, struct pt_regs * regs)
+{
+	unsigned char st;
+	int lcount;
+	char *lptr;
+
+	if (!doing_vdma)
+		return floppy_interrupt(irq, dev_id, regs);
+
+
+	st = 1;
+	for (lcount=virtual_dma_count, lptr=virtual_dma_addr; 
+	     lcount; lcount--, lptr++) {
+		st=inb(virtual_dma_port+4) & 0xa0 ;
+		if (st != 0xa0) 
+			break;
+		if (virtual_dma_mode)
+			outb_p(*lptr, virtual_dma_port+5);
+		else
+			*lptr = inb_p(virtual_dma_port+5);
+	}
+	virtual_dma_count = lcount;
+	virtual_dma_addr = lptr;
+	st = inb(virtual_dma_port+4);
+
+	if (st == 0x20)
+		return IRQ_HANDLED;
+	if (!(st & 0x20)) {
+		virtual_dma_residue += virtual_dma_count;
+		virtual_dma_count=0;
+		doing_vdma = 0;
+		floppy_interrupt(irq, dev_id, regs);
+		return IRQ_HANDLED;
+	}
+	return IRQ_HANDLED;
+}
+
+static void vdma_disable_dma(unsigned int dummy)
+{
+	doing_vdma = 0;
+	virtual_dma_residue += virtual_dma_count;
+	virtual_dma_count=0;
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
+	if (can_use_virtual_dma)
+		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
+						   "floppy", NULL);
+	else
+		return request_irq(FLOPPY_IRQ, floppy_interrupt,
+						   SA_INTERRUPT|SA_SAMPLE_RANDOM,
+						   "floppy", NULL);	
+
+}
+
+static int vdma_dma_setup(char *addr, unsigned long size, int mode, int io)
+{
+	doing_vdma = 1;
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
+	doing_vdma = 0;
+	clear_dma_ff(FLOPPY_DMA);
+	set_dma_mode(FLOPPY_DMA,mode);
+	set_dma_addr(FLOPPY_DMA,(unsigned int)virt_to_bus(addr));
+	set_dma_count(FLOPPY_DMA,size);
+	enable_dma(FLOPPY_DMA);
+	return 0;
+}
+
+static struct fd_dma_ops real_dma_ops =
+{
+	._disable_dma = disable_dma,
+	._free_dma = free_dma,
+	._get_dma_residue = get_dma_residue,
+	._dma_setup = hard_dma_setup
+};
+
+static struct fd_dma_ops virt_dma_ops =
+{
+	._disable_dma = vdma_disable_dma,
+	._free_dma = vdma_nop,
+	._get_dma_residue = vdma_get_dma_residue,
+	._dma_setup = vdma_dma_setup
+};
+
+static int fd_request_dma()
 {
-	/* Nothing to do on PowerPC */
+	if (can_use_virtual_dma & 1) {
+		fd_ops = &virt_dma_ops;
+		return 0;
+	}
+	else {
+		fd_ops = &real_dma_ops;
+		return request_dma(FLOPPY_DMA, "floppy");
+	}
 }
 
 static int FDC1 = 0x3f0;


