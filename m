Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbUJZHCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbUJZHCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUJZHCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:02:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:53977 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262116AbUJZG7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:59:50 -0400
Subject: [PATCH] ppc64: Some sparse fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 16:56:26 +1000
Message-Id: <1098773787.6897.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This is a batch of sparse fixes for things in arch/ppc64/* and include/asm-ppc64/*

More to come of course...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-ppc64/io.h
===================================================================
--- linux-work.orig/include/asm-ppc64/io.h	2004-10-26 13:15:55.000000000 +1000
+++ linux-work/include/asm-ppc64/io.h	2004-10-26 16:16:16.176227848 +1000
@@ -205,7 +205,7 @@
 #define ioremap_nocache(addr, size)	ioremap((addr), (size))
 extern int iounmap_explicit(volatile void __iomem *addr, unsigned long size);
 extern void iounmap(volatile void __iomem *addr);
-extern void * reserve_phb_iospace(unsigned long size);
+extern void __iomem * reserve_phb_iospace(unsigned long size);
 
 /**
  *	virt_to_phys	-	map virtual addresses to physical
Index: linux-work/arch/ppc64/kernel/nvram.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/nvram.c	2004-10-26 14:49:10.901590336 +1000
+++ linux-work/arch/ppc64/kernel/nvram.c	2004-10-26 16:16:16.178227544 +1000
@@ -711,7 +711,7 @@
 /* This doesn't actually zero anything, but it sets the event_logged
  * word to tell that this event is safely in syslog.
  */
-int nvram_clear_error_log()
+int nvram_clear_error_log(void)
 {
 	loff_t tmp_index;
 	int clear_word = ERR_FLAG_ALREADY_LOGGED;
Index: linux-work/arch/ppc64/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pci.c	2004-10-26 16:16:15.822281656 +1000
+++ linux-work/arch/ppc64/kernel/pci.c	2004-10-26 16:16:16.180227240 +1000
@@ -576,7 +576,7 @@
 
 static void __devinit pci_process_ISA_OF_ranges(struct device_node *isa_node,
 				      unsigned long phb_io_base_phys,
-				      void * phb_io_base_virt)
+				      void __iomem * phb_io_base_virt)
 {
 	struct isa_range *range;
 	unsigned long pci_addr;
@@ -795,7 +795,7 @@
 	
 	if (get_bus_io_range(bus, &start_phys, &start_virt, &size))
 		return 1;
-	if (iounmap_explicit((void *) start_virt, size))
+	if (iounmap_explicit((void __iomem *) start_virt, size))
 		return 1;
 
 	return 0;
Index: linux-work/arch/ppc64/kernel/pSeries_pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pSeries_pci.c	2004-10-25 21:58:12.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pSeries_pci.c	2004-10-26 16:16:16.182226936 +1000
@@ -154,8 +154,8 @@
 
 static void python_countermeasures(unsigned long addr)
 {
-	void *chip_regs;
-	volatile u32 *tmp, i;
+	void __iomem *chip_regs;
+	volatile u32 val;
 
 	/* Python's register file is 1 MB in size. */
 	chip_regs = ioremap(addr & ~(0xfffffUL), 0x100000); 
@@ -167,17 +167,17 @@
 
 #define PRG_CL_RESET_VALID 0x00010000
 
-	tmp = (u32 *)((unsigned long)chip_regs + 0xf6030);
-
-	if (*tmp & PRG_CL_RESET_VALID) {
+	val = in_be32(chip_regs + 0xf6030);
+	if (val & PRG_CL_RESET_VALID) {
 		printk(KERN_INFO "Python workaround: ");
-		*tmp &= ~PRG_CL_RESET_VALID;
+		val &= ~PRG_CL_RESET_VALID;
+		out_be32(chip_regs + 0xf6030, val);
 		/*
 		 * We must read it back for changes to
 		 * take effect
 		 */
-		i = *tmp;
-		printk("reg0: %x\n", i);
+		val = in_be32(chip_regs + 0xf6030);
+		printk("reg0: %x\n", val);
 	}
 
 	iounmap(chip_regs);
Index: linux-work/arch/ppc64/kernel/rtasd.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/rtasd.c	2004-10-17 12:07:07.000000000 +1000
+++ linux-work/arch/ppc64/kernel/rtasd.c	2004-10-26 16:16:16.183226784 +1000
@@ -275,7 +275,7 @@
  * know that we can safely clear the events in NVRAM.
  * Next we'll sit and wait for something else to log.
  */
-static ssize_t rtas_log_read(struct file * file, char * buf,
+static ssize_t rtas_log_read(struct file * file, char __user * buf,
 			 size_t count, loff_t *ppos)
 {
 	int error;
Index: linux-work/arch/ppc64/kernel/xics.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/xics.c	2004-10-25 21:58:12.000000000 +1000
+++ linux-work/arch/ppc64/kernel/xics.c	2004-10-26 16:16:16.185226480 +1000
@@ -85,7 +85,7 @@
 	} qirr;
 };
 
-static struct xics_ipl *xics_per_cpu[NR_CPUS];
+static struct xics_ipl __iomem *xics_per_cpu[NR_CPUS];
 
 static int xics_irq_8259_cascade = 0;
 static int xics_irq_8259_cascade_real = 0;
@@ -116,22 +116,22 @@
 
 static int pSeries_xirr_info_get(int n_cpu)
 {
-	return xics_per_cpu[n_cpu]->xirr.word;
+	return in_be32(&xics_per_cpu[n_cpu]->xirr.word);
 }
 
 static void pSeries_xirr_info_set(int n_cpu, int value)
 {
-	xics_per_cpu[n_cpu]->xirr.word = value;
+	out_be32(&xics_per_cpu[n_cpu]->xirr.word, value);
 }
 
 static void pSeries_cppr_info(int n_cpu, u8 value)
 {
-	xics_per_cpu[n_cpu]->xirr.bytes[0] = value;
+	out_8(&xics_per_cpu[n_cpu]->xirr.bytes[0], value);
 }
 
 static void pSeries_qirr_info(int n_cpu, u8 value)
 {
-	xics_per_cpu[n_cpu]->qirr.bytes[0] = value;
+	out_8(&xics_per_cpu[n_cpu]->qirr.bytes[0], value);
 }
 
 static xics_ops pSeries_ops = {
@@ -457,7 +457,7 @@
 	struct xics_interrupt_node {
 		unsigned long addr;
 		unsigned long size;
-	} inodes[NR_CPUS]; 
+	} intnodes[NR_CPUS]; 
 
 	ppc64_boot_msg(0x20, "XICS Init");
 
@@ -484,13 +484,13 @@
 		panic("xics_init_IRQ: can't find interrupt reg property");
 	
 	while (ilen) {
-		inodes[indx].addr = (unsigned long long)*ireg++ << 32;
+		intnodes[indx].addr = (unsigned long)*ireg++ << 32;
 		ilen -= sizeof(uint);
-		inodes[indx].addr |= *ireg++;
+		intnodes[indx].addr |= *ireg++;
 		ilen -= sizeof(uint);
-		inodes[indx].size = (unsigned long long)*ireg++ << 32;
+		intnodes[indx].size = (unsigned long)*ireg++ << 32;
 		ilen -= sizeof(uint);
-		inodes[indx].size |= *ireg++;
+		intnodes[indx].size |= *ireg++;
 		ilen -= sizeof(uint);
 		indx++;
 		if (indx >= NR_CPUS) break;
@@ -505,7 +505,8 @@
 	     np = of_find_node_by_type(np, "cpu")) {
 		ireg = (uint *)get_property(np, "reg", &ilen);
 		if (ireg && ireg[0] == hard_smp_processor_id()) {
-			ireg = (uint *)get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
+			ireg = (uint *)get_property(np, "ibm,ppc-interrupt-gserver#s",
+						    &ilen);
 			i = ilen / sizeof(int);
 			if (ireg && i > 0) {
 				default_server = ireg[0];
@@ -516,8 +517,8 @@
 	}
 	of_node_put(np);
 
-	intr_base = inodes[0].addr;
-	intr_size = (ulong)inodes[0].size;
+	intr_base = intnodes[0].addr;
+	intr_size = intnodes[0].size;
 
 	np = of_find_node_by_type(NULL, "interrupt-controller");
 	if (!np) {
@@ -538,16 +539,18 @@
 	if (systemcfg->platform == PLATFORM_PSERIES) {
 #ifdef CONFIG_SMP
 		for_each_cpu(i) {
+			int hard_id;
+
 			/* FIXME: Do this dynamically! --RR */
 			if (!cpu_present(i))
 				continue;
-			xics_per_cpu[i] = __ioremap((ulong)inodes[get_hard_smp_processor_id(i)].addr, 
-						    (ulong)inodes[get_hard_smp_processor_id(i)].size,
-						    _PAGE_NO_CACHE);
+
+			hard_id = get_hard_smp_processor_id(i);
+			xics_per_cpu[i] = ioremap(intnodes[hard_id].addr, 
+						  intnodes[hard_id].size);
 		}
 #else
-		xics_per_cpu[0] = __ioremap((ulong)intr_base, intr_size,
-					    _PAGE_NO_CACHE);
+		xics_per_cpu[0] = ioremap(intr_base, intr_size);
 #endif /* CONFIG_SMP */
 	} else if (systemcfg->platform == PLATFORM_PSERIES_LPAR) {
 		ops = &pSeriesLP_ops;
Index: linux-work/arch/ppc64/mm/init.c
===================================================================
--- linux-work.orig/arch/ppc64/mm/init.c	2004-10-26 13:15:54.000000000 +1000
+++ linux-work/arch/ppc64/mm/init.c	2004-10-26 16:16:16.187226176 +1000
@@ -874,14 +874,14 @@
 	local_irq_restore(flags);
 }
 
-void * reserve_phb_iospace(unsigned long size)
+void __iomem * reserve_phb_iospace(unsigned long size)
 {
-	void *virt_addr;
+	void __iomem *virt_addr;
 		
 	if (phbs_io_bot >= IMALLOC_BASE) 
 		panic("reserve_phb_iospace(): phb io space overflow\n");
 			
-	virt_addr = (void *) phbs_io_bot;
+	virt_addr = (void __iomem *) phbs_io_bot;
 	phbs_io_bot += size;
 
 	return virt_addr;
Index: linux-work/arch/ppc64/kernel/udbg.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/udbg.c	2004-10-26 16:16:15.399345952 +1000
+++ linux-work/arch/ppc64/kernel/udbg.c	2004-10-26 16:51:33.034416488 +1000
@@ -11,6 +11,8 @@
 
 #include <stdarg.h>
 #define WANT_PPCDBG_TAB /* Only defined here */
+#include <linux/config.h>
+#include <linux/types.h>
 #include <asm/ppcdebug.h>
 #include <asm/processor.h>
 #include <asm/naca.h>
@@ -20,8 +22,8 @@
 #include <asm/prom.h>
 #include <asm/pmac_feature.h>
 
-extern u8 real_readb(volatile u8 *addr);
-extern void real_writeb(u8 data, volatile u8 *addr);
+extern u8 real_readb(volatile u8 __iomem  *addr);
+extern void real_writeb(u8 data, volatile u8 __iomem *addr);
 
 struct NS16550 {
 	/* this struct must be packed */
@@ -50,9 +52,9 @@
 #define LSR_TEMT 0x40  /* Xmitter empty */
 #define LSR_ERR  0x80  /* Error */
 
-static volatile struct NS16550 *udbg_comport;
+static volatile struct NS16550 __iomem *udbg_comport;
 
-void udbg_init_uart(void *comport, unsigned int speed)
+void udbg_init_uart(void __iomem *comport, unsigned int speed)
 {
 	u8 dll = 12;
 
@@ -68,16 +70,18 @@
 		break;
 	}
 	if (comport) {
-		udbg_comport = (struct NS16550 *)comport;
-		udbg_comport->lcr = 0x00; eieio();
-		udbg_comport->ier = 0xFF; eieio();
-		udbg_comport->ier = 0x00; eieio();
-		udbg_comport->lcr = 0x80; eieio();	/* Access baud rate */
-		udbg_comport->dll = dll;   eieio();	/* 1 = 115200,  2 = 57600, 3 = 38400, 12 = 9600 baud */
-		udbg_comport->dlm = 0;    eieio();	/* dll >> 8 which should be zero for fast rates; */
-		udbg_comport->lcr = 0x03; eieio();	/* 8 data, 1 stop, no parity */
-		udbg_comport->mcr = 0x03; eieio();	/* RTS/DTR */
-		udbg_comport->fcr = 0x07; eieio();	/* Clear & enable FIFOs */
+		udbg_comport = (struct NS16550 __iomem *)comport;
+		out_8(&udbg_comport->lcr, 0x00);
+		out_8(&udbg_comport->ier, 0xff);
+		out_8(&udbg_comport->ier, 0x00);
+		out_8(&udbg_comport->lcr, 0x80);	/* Access baud rate */
+		out_8(&udbg_comport->dll,  dll);	/* 1 = 115200,  2 = 57600,
+							   3 = 38400, 12 = 9600 baud */
+		out_8(&udbg_comport->dlm, 0x00);	/* dll >> 8 which should be zero
+							   for fast rates; */
+		out_8(&udbg_comport->lcr, 0x03);	/* 8 data, 1 stop, no parity */
+		out_8(&udbg_comport->mcr, 0x03);	/* RTS/DTR */
+		out_8(&udbg_comport->fcr ,0x07);	/* Clear & enable FIFOs */
 	}
 }
 
@@ -86,7 +90,8 @@
 #define	SCC_TXRDY	4
 #define SCC_RXRDY	1
 
-static volatile u8 *sccc, *sccd;
+static volatile u8 __iomem *sccc;
+static volatile u8 __iomem *sccd;
 
 static unsigned char scc_inittab[] = {
     13, 0,		/* set baud rate divisor */
@@ -125,7 +130,7 @@
 
 	/* Setup for 57600 8N1 */
 	addr += 0x20;
-	sccc = (volatile u8 *) ioremap(addr & PAGE_MASK, PAGE_SIZE) ;
+	sccc = (volatile u8 * __iomem) ioremap(addr & PAGE_MASK, PAGE_SIZE) ;
 	sccc += addr & ~PAGE_MASK;
 	sccd = sccc + 0x10;
 
@@ -133,13 +138,11 @@
 	mb();
 
 	for (i = 20000; i != 0; --i)
-		x = *sccc; eieio();
-	*sccc = 9; eieio();		/* reset A or B side */
-	*sccc = 0xc0; eieio();
-	for (i = 0; i < sizeof(scc_inittab); ++i) {
-		*sccc = scc_inittab[i];
-		eieio();
-	}
+		x = in_8(sccc);
+	out_8(sccc, 0x09);		/* reset A or B side */
+	out_8(sccc, 0xc0);
+	for (i = 0; i < sizeof(scc_inittab); ++i)
+		out_8(sccc, scc_inittab[i]);
 
 	ppc_md.udbg_putc = udbg_putc;
 	ppc_md.udbg_getc = udbg_getc;
@@ -162,8 +165,8 @@
 
 void udbg_init_pmac_realmode(void)
 {
-	sccc = (volatile u8 *)0x80013020ul;
-	sccd = (volatile u8 *)0x80013030ul;
+	sccc = (volatile u8 __iomem *)0x80013020ul;
+	sccd = (volatile u8 __iomem *)0x80013030ul;
 
 	ppc_md.udbg_putc = udbg_real_putc;
 	ppc_md.udbg_getc = NULL;
@@ -189,7 +192,7 @@
 
 void udbg_init_maple_realmode(void)
 {
-	udbg_comport = (volatile struct NS16550 *)0xf40003f8;
+	udbg_comport = (volatile struct NS16550 __iomem *)0xf40003f8;
 
 	ppc_md.udbg_putc = udbg_maple_real_putc;
 	ppc_md.udbg_getc = NULL;
@@ -200,22 +203,21 @@
 void udbg_putc(unsigned char c)
 {
 	if (udbg_comport) {
-		while ((udbg_comport->lsr & LSR_THRE) == 0)
+		while ((in_8(&udbg_comport->lsr) & LSR_THRE) == 0)
 			/* wait for idle */;
-		udbg_comport->thr = c; eieio();
+		out_8(&udbg_comport->thr, c);
 		if (c == '\n') {
 			/* Also put a CR.  This is for convenience. */
-			while ((udbg_comport->lsr & LSR_THRE) == 0)
-				/* wait for idle */;
-			udbg_comport->thr = '\r'; eieio();
+			while ((in_8(&udbg_comport->lsr) & LSR_THRE) == 0)
+				/* wait for idle */; 
+			out_8(&udbg_comport->thr, '\r');
 		}
 	}
 #ifdef CONFIG_PPC_PMAC
 	else if (sccc) {
-		while ((*sccc & SCC_TXRDY) == 0)
-			eieio();
-		*sccd = c;		
-		eieio();
+		while ((in_8(sccc) & SCC_TXRDY) == 0)
+			;
+		out_8(sccd,  c);		
 		if (c == '\n')
 			udbg_putc('\r');
 	}
@@ -225,16 +227,15 @@
 int udbg_getc_poll(void)
 {
 	if (udbg_comport) {
-		if ((udbg_comport->lsr & LSR_DR) != 0)
-			return udbg_comport->rbr;
+		if ((in_8(&udbg_comport->lsr) & LSR_DR) != 0)
+			return in_8(&udbg_comport->rbr);
 		else
 			return -1;
 	}
 #ifdef CONFIG_PPC_PMAC
 	else if (sccc) {
-		eieio();
-		if ((*sccc & SCC_RXRDY) != 0)
-			return *sccd;
+		if ((in_8(sccc) & SCC_RXRDY) != 0)
+			return in_8(sccd);
 		else
 			return -1;
 	}
@@ -245,16 +246,15 @@
 unsigned char udbg_getc(void)
 {
 	if (udbg_comport) {
-		while ((udbg_comport->lsr & LSR_DR) == 0)
+		while ((in_8(&udbg_comport->lsr) & LSR_DR) == 0)
 			/* wait for char */;
-		return udbg_comport->rbr;
+		return in_8(&udbg_comport->rbr);
 	}
 #ifdef CONFIG_PPC_PMAC
 	else if (sccc) {
-		eieio();
-		while ((*sccc & SCC_RXRDY) == 0)
-			eieio();
-		return *sccd;
+		while ((in_8(sccc) & SCC_RXRDY) == 0)
+			;
+		return in_8(sccd);
 	}
 #endif /* CONFIG_PPC_PMAC */
 	return 0;
Index: linux-work/include/asm-ppc64/udbg.h
===================================================================
--- linux-work.orig/include/asm-ppc64/udbg.h	2004-10-26 08:30:21.000000000 +1000
+++ linux-work/include/asm-ppc64/udbg.h	2004-10-26 16:52:28.963913912 +1000
@@ -1,6 +1,8 @@
 #ifndef __UDBG_HDR
 #define __UDBG_HDR
 
+#include <linux/compiler.h>
+
 /*
  * c 2001 PPC 64 Team, IBM Corp
  *
@@ -10,7 +12,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-void udbg_init_uart(void *comport, unsigned int speed);
+void udbg_init_uart(void __iomem *comport, unsigned int speed);
 void udbg_putc(unsigned char c);
 unsigned char udbg_getc(void);
 int udbg_getc_poll(void);
Index: linux-work/arch/ppc64/kernel/proc_ppc64.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/proc_ppc64.c	2004-10-21 11:47:00.000000000 +1000
+++ linux-work/arch/ppc64/kernel/proc_ppc64.c	2004-10-26 16:36:24.137589808 +1000
@@ -33,7 +33,8 @@
 #include <asm/prom.h>
 
 static loff_t  page_map_seek( struct file *file, loff_t off, int whence);
-static ssize_t page_map_read( struct file *file, char *buf, size_t nbytes, loff_t *ppos);
+static ssize_t page_map_read( struct file *file, char __user *buf, size_t nbytes,
+			      loff_t *ppos);
 static int     page_map_mmap( struct file *file, struct vm_area_struct *vma );
 
 static struct file_operations page_map_fops = {
@@ -161,7 +162,8 @@
 	return (file->f_pos = new);
 }
 
-static ssize_t page_map_read( struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+static ssize_t page_map_read( struct file *file, char __user *buf, size_t nbytes,
+			      loff_t *ppos)
 {
 	struct proc_dir_entry *dp = PDE(file->f_dentry->d_inode);
 	return simple_read_from_buffer(buf, nbytes, ppos, dp->data, dp->size);
@@ -208,7 +210,8 @@
  * whole nodes along with their properties.  Operations on individual
  * properties are not implemented (yet).
  */
-static ssize_t ofdt_write(struct file *file, const char __user *buf, size_t count, loff_t *off)
+static ssize_t ofdt_write(struct file *file, const char __user *buf, size_t count,
+			  loff_t *off)
 {
 	int rv = 0;
 	char *kbuf;
@@ -302,7 +305,8 @@
 	return rv;
 }
 
-static struct property *new_property(const char *name, const int length, const unsigned char *value, struct property *last)
+static struct property *new_property(const char *name, const int length,
+				     const unsigned char *value, struct property *last)
 {
 	struct property *new = kmalloc(sizeof(*new), GFP_KERNEL);
 
@@ -343,7 +347,8 @@
  * this function does no allocation or copying of the data.  Return value
  * is set to the next name in buf, or NULL on error.
  */
-static char * parse_next_property(char *buf, char *end, char **name, int *length, unsigned char **value)
+static char * parse_next_property(char *buf, char *end, char **name, int *length,
+				  unsigned char **value)
 {
 	char *tmp;
 
@@ -351,13 +356,15 @@
 
 	tmp = strchr(buf, ' ');
 	if (!tmp) {
-		printk(KERN_ERR "property parse failed in %s at line %d\n", __FUNCTION__, __LINE__);
+		printk(KERN_ERR "property parse failed in %s at line %d\n",
+		       __FUNCTION__, __LINE__);
 		return NULL;
 	}
 	*tmp = '\0';
 
 	if (++tmp >= end) {
-		printk(KERN_ERR "property parse failed in %s at line %d\n", __FUNCTION__, __LINE__);
+		printk(KERN_ERR "property parse failed in %s at line %d\n",
+		       __FUNCTION__, __LINE__);
 		return NULL;
 	}
 
@@ -365,11 +372,13 @@
 	*length = -1;
 	*length = simple_strtoul(tmp, &tmp, 10);
 	if (*length == -1) {
-		printk(KERN_ERR "property parse failed in %s at line %d\n", __FUNCTION__, __LINE__);
+		printk(KERN_ERR "property parse failed in %s at line %d\n", 
+		       __FUNCTION__, __LINE__);
 		return NULL;
 	}
 	if (*tmp != ' ' || ++tmp >= end) {
-		printk(KERN_ERR "property parse failed in %s at line %d\n", __FUNCTION__, __LINE__);
+		printk(KERN_ERR "property parse failed in %s at line %d\n",
+		       __FUNCTION__, __LINE__);
 		return NULL;
 	}
 
@@ -377,11 +386,13 @@
 	*value = tmp;
 	tmp += *length;
 	if (tmp > end) {
-		printk(KERN_ERR "property parse failed in %s at line %d\n", __FUNCTION__, __LINE__);
+		printk(KERN_ERR "property parse failed in %s at line %d\n",
+		       __FUNCTION__, __LINE__);
 		return NULL;
 	}
 	else if (tmp < end && *tmp != ' ' && *tmp != '\0') {
-		printk(KERN_ERR "property parse failed in %s at line %d\n", __FUNCTION__, __LINE__);
+		printk(KERN_ERR "property parse failed in %s at line %d\n",
+		       __FUNCTION__, __LINE__);
 		return NULL;
 	}
 	tmp++;
Index: linux-work/arch/ppc64/kernel/vecemu.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/vecemu.c	2004-10-17 12:07:07.000000000 +1000
+++ linux-work/arch/ppc64/kernel/vecemu.c	2004-10-26 16:42:56.250979512 +1000
@@ -263,7 +263,7 @@
 	unsigned int va, vb, vc, vd;
 	vector128 *vrs;
 
-	if (get_user(instr, (unsigned int *) regs->nip))
+	if (get_user(instr, (unsigned int __user *) regs->nip))
 		return -EFAULT;
 	if ((instr >> 26) != 4)
 		return -EINVAL;		/* not an altivec instruction */
Index: linux-work/arch/ppc64/kernel/lparcfg.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/lparcfg.c	2004-10-17 12:07:05.000000000 +1000
+++ linux-work/arch/ppc64/kernel/lparcfg.c	2004-10-26 16:42:05.491696096 +1000
@@ -192,7 +192,7 @@
  * is coming, but at this time is still problematic, so for now this
  * function will return 0.
  */
-static unsigned long get_purr()
+static unsigned long get_purr(void)
 {
 	unsigned long sum_purr = 0;
 	return sum_purr;
@@ -524,10 +524,10 @@
 }
 
 struct file_operations lparcfg_fops = {
-      owner:THIS_MODULE,
-      read:seq_read,
-      open:lparcfg_open,
-      release:single_release,
+      .owner	= THIS_MODULE,
+      .read	= seq_read,
+      .open	= lparcfg_open,
+      .release	= single_release,
 };
 
 int __init lparcfg_init(void)



