Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUJFDIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUJFDIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUJFDIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:08:21 -0400
Received: from mail.renesas.com ([202.234.163.13]:40672 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S266366AbUJFDGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:06:02 -0400
Date: Wed, 06 Oct 2004 12:05:02 +0900 (JST)
Message-Id: <20041006.120502.57438367.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-pcmcia@lists.infradead.org,
       fujiwara@linux-m32r.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc3-mm2] [m32r] New CF/PCMCIA driver for m32r
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch is for the new M32R CF/PCMCIA drivers.
It is moved from arch/m32r/drivers/ and some part are updated 
for 2.6 kernel.

Especially linux-pcmcia@lists.infradead.org lists,
would you review and give us any comments?

Thanks in advance.

Best Regards,

From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.6.9-rc1-mm4 6/6] [m32r] Update CF/PCMCIA drivers
Date: Sat, 11 Sep 2004 22:02:42 +0100
> On Sun, Sep 12, 2004 at 05:51:23AM +0900, Hirokazu Takata wrote:
> > [PATCH 2.6.9-rc1-mm4 6/6] [m32r] Update CF/PCMCIA drivers
> >   This patch updates m32r-specific CF/PCMCIA drivers and 
> >   fixes compile errors.
> 
> Note that these really should be in drivers/pcmcia/
> 
> Please also send them to linux-pcmcia@lists.infradead.org for review.
> 

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/pcmcia/Kconfig    |   21 -
 drivers/pcmcia/Makefile   |    2 
 drivers/pcmcia/m32r_cfc.c |  879 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pcmcia/m32r_cfc.h |   83 ++++
 drivers/pcmcia/m32r_pcc.c |  816 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pcmcia/m32r_pcc.h |   65 +++
 6 files changed, 1864 insertions(+), 2 deletions(-)


diff -ruNp a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
--- a/drivers/pcmcia/Kconfig	2004-08-14 14:37:37.000000000 +0900
+++ b/drivers/pcmcia/Kconfig	2004-10-05 21:54:32.000000000 +0900
@@ -133,10 +133,27 @@ config PCMCIA_PXA2XX
 	help
 	  Say Y here to include support for the PXA2xx PCMCIA controller
 
-
 config PCMCIA_PROBE
 	bool
 	default y if ISA && !ARCH_SA1100 && !ARCH_CLPS711X
 
-endmenu
+config M32R_PCC
+	bool "M32R PCMCIA I/F"
+	depends on M32R && CHIP_M32700 && PCMCIA
+	help
+	  Say Y here to use the M32R PCMCIA controller.
+
+config M32R_CFC
+	bool "M32R CF I/F Controller"
+	depends on M32R && (PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_OPSPUT)
+	help
+	  Say Y here to use the M32R CompactFlash controller.
+
+config M32R_CFC_NUM
+	int "M32R CF I/F number"
+	depends on M32R_CFC
+	default "1" if PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_OPSPUT
+	help
+	  Set the number of M32R CF slots.
 
+endmenu
diff -ruNp a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
--- a/drivers/pcmcia/Makefile	2004-08-14 14:37:38.000000000 +0900
+++ b/drivers/pcmcia/Makefile	2004-10-05 21:43:43.000000000 +0900
@@ -17,6 +17,8 @@ obj-$(CONFIG_HD64465_PCMCIA)			+= hd6446
 obj-$(CONFIG_PCMCIA_SA1100)			+= sa11xx_core.o sa1100_cs.o
 obj-$(CONFIG_PCMCIA_SA1111)			+= sa11xx_core.o sa1111_cs.o
 obj-$(CONFIG_PCMCIA_PXA2XX)                     += pxa2xx_core.o pxa2xx_cs.o
+obj-$(CONFIG_M32R_PCC)				+= m32r_pcc.o
+obj-$(CONFIG_M32R_CFC)				+= m32r_cfc.o
 
 pcmcia_core-y					+= cistpl.o rsrc_mgr.o bulkmem.o cs.o socket_sysfs.o
 pcmcia_core-$(CONFIG_CARDBUS)			+= cardbus.o
diff -ruNp a/drivers/pcmcia/m32r_cfc.c b/drivers/pcmcia/m32r_cfc.c
--- a/drivers/pcmcia/m32r_cfc.c	1970-01-01 09:00:00.000000000 +0900
+++ b/drivers/pcmcia/m32r_cfc.c	2004-10-05 21:15:44.000000000 +0900
@@ -0,0 +1,879 @@
+/*
+ *  drivers/pcmcia/m32r_cfc.c
+ *
+ *  Device driver for the CFC functionality of M32R.
+ *
+ *  Copyright (c) 2001, 2002, 2003, 2004
+ *    Hiroyuki Kondo, Naoto Sugai, Hayato Fujiwara
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/timer.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/bitops.h>
+#include <asm/system.h>
+
+#include <pcmcia/version.h>
+#include <pcmcia/cs_types.h>
+#include <pcmcia/ss.h>
+#include <pcmcia/cs.h>
+
+#undef MAX_IO_WIN	/* FIXME */
+#define MAX_IO_WIN 1
+#undef MAX_WIN		/* FIXME */
+#define MAX_WIN 1
+
+#include "m32r_cfc.h"
+
+#ifdef DEBUG
+static int m32r_cfc_debug;
+module_param(m32r_cfc_debug, int, 0644);
+#define debug(lvl, fmt, arg...) do {				\
+	if (m32r_cfc_debug > (lvl))				\
+		printk(KERN_DEBUG "m32r_cfc: " fmt , ## arg);	\
+} while (0)
+#else
+#define debug(n, args...) do { } while (0)
+#endif
+
+/* Poll status interval -- 0 means default to interrupt */
+static int poll_interval = 0;
+
+typedef enum pcc_space { as_none = 0, as_comm, as_attr, as_io } pcc_as_t;
+
+typedef struct pcc_socket {
+	u_short			type, flags;
+	struct pcmcia_socket	socket;
+	unsigned int		number;
+ 	ioaddr_t		ioaddr;
+	u_long			mapaddr;
+	u_long			base;	/* PCC register base */
+	u_char			cs_irq1, cs_irq2, intr;
+	pccard_io_map		io_map[MAX_IO_WIN];
+	pccard_mem_map		mem_map[MAX_WIN];
+	u_char			io_win;
+	u_char			mem_win;
+	pcc_as_t		current_space;
+	u_char			last_iodbex;
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *proc;
+#endif
+} pcc_socket_t;
+
+static int pcc_sockets = 0;
+static pcc_socket_t socket[M32R_MAX_PCC] = {
+	{ 0, }, /* ... */
+};
+
+/*====================================================================*/
+
+static unsigned int pcc_get(u_short, unsigned int);
+static void pcc_set(u_short, unsigned int , unsigned int );
+
+static spinlock_t pcc_lock = SPIN_LOCK_UNLOCKED;
+
+#if !defined(CONFIG_PLAT_USRV)
+static inline u_long pcc_port2addr(unsigned long port, int size) {
+	u_long addr = 0;
+	u_long odd;
+
+	if (size == 1) {	/* byte access */
+		odd = (port&1) << 11;
+		port -= port & 1;
+		addr = CFC_IO_MAPBASE_BYTE - CFC_IOPORT_BASE + odd + port;
+	} else if (size == 2)
+		addr = CFC_IO_MAPBASE_WORD - CFC_IOPORT_BASE + port;
+
+	return addr;
+}
+#else	/* CONFIG_PLAT_USRV */
+static inline u_long pcc_port2addr(unsigned long port, int size) {
+	u_long odd;
+	u_long addr = ((port - CFC_IOPORT_BASE) & 0xf000) << 8;
+
+	if (size == 1) {	/* byte access */
+		odd = port & 1;
+		port -= odd;
+		odd <<= 11;
+		addr = (addr | CFC_IO_MAPBASE_BYTE) + odd + (port & 0xfff);
+	} else if (size == 2)	/* word access */
+		addr = (addr | CFC_IO_MAPBASE_WORD) + (port & 0xfff);
+
+	return addr;
+}
+#endif	/* CONFIG_PLAT_USRV */
+
+void pcc_ioread_byte(int sock, unsigned long port, void *buf, size_t size,
+	size_t nmemb, int flag)
+{
+	u_long addr;
+	unsigned char *bp = (unsigned char *)buf;
+	unsigned long flags;
+
+	debug(3, "m32r_cfc: pcc_ioread_byte: sock=%d, port=%#lx, buf=%p, "
+		 "size=%u, nmemb=%d, flag=%d\n",
+		  sock, port, buf, size, nmemb, flag);
+
+	addr = pcc_port2addr(port, 1);
+	if (!addr) {
+		printk("m32r_cfc:ioread_byte null port :%#lx\n",port);
+		return;
+	}
+	debug(3, "m32r_cfc: pcc_ioread_byte: addr=%#lx\n", addr);
+
+	spin_lock_irqsave(&pcc_lock, flags);
+	/* read Byte */
+	while (nmemb--)
+		*bp++ = readb(addr);
+	spin_unlock_irqrestore(&pcc_lock, flags);
+}
+
+void pcc_ioread_word(int sock, unsigned long port, void *buf, size_t size,
+	size_t nmemb, int flag)
+{
+	u_long addr;
+	unsigned short *bp = (unsigned short *)buf;
+	unsigned long flags;
+
+	debug(3, "m32r_cfc: pcc_ioread_word: sock=%d, port=%#lx, "
+		 "buf=%p, size=%u, nmemb=%d, flag=%d\n",
+		 sock, port, buf, size, nmemb, flag);
+
+	if (size != 2)
+		printk("m32r_cfc: ioread_word :illigal size %u : %#lx\n", size,
+			port);
+	if (size == 9)
+		printk("m32r_cfc: ioread_word :insw \n");
+
+	addr = pcc_port2addr(port, 2);
+	if (!addr) {
+		printk("m32r_cfc:ioread_word null port :%#lx\n",port);
+		return;
+	}
+	debug(3, "m32r_cfc: pcc_ioread_word: addr=%#lx\n", addr);
+
+	spin_lock_irqsave(&pcc_lock, flags);
+	/* read Word */
+	while (nmemb--)
+		*bp++ = readw(addr);
+	spin_unlock_irqrestore(&pcc_lock, flags);
+}
+
+void pcc_iowrite_byte(int sock, unsigned long port, void *buf, size_t size,
+	size_t nmemb, int flag)
+{
+	u_long addr;
+	unsigned char *bp = (unsigned char *)buf;
+	unsigned long flags;
+
+	debug(3, "m32r_cfc: pcc_iowrite_byte: sock=%d, port=%#lx, "
+		 "buf=%p, size=%u, nmemb=%d, flag=%d\n",
+		 sock, port, buf, size, nmemb, flag);
+
+	/* write Byte */
+	addr = pcc_port2addr(port, 1);
+	if (!addr) {
+		printk("m32r_cfc:iowrite_byte null port:%#lx\n",port);
+		return;
+	}
+	debug(3, "m32r_cfc: pcc_iowrite_byte: addr=%#lx\n", addr);
+
+	spin_lock_irqsave(&pcc_lock, flags);
+	while (nmemb--)
+		writeb(*bp++, addr);
+	spin_unlock_irqrestore(&pcc_lock, flags);
+}
+
+void pcc_iowrite_word(int sock, unsigned long port, void *buf, size_t size,
+	size_t nmemb, int flag)
+{
+	u_long addr;
+	unsigned short *bp = (unsigned short *)buf;
+	unsigned long flags;
+
+	debug(3, "m32r_cfc: pcc_iowrite_word: sock=%d, port=%#lx, "
+		 "buf=%p, size=%u, nmemb=%d, flag=%d\n",
+		 sock, port, buf, size, nmemb, flag);
+
+	if(size != 2)
+		printk("m32r_cfc: iowrite_word :illigal size %u : %#lx\n",
+			size, port);
+	if(size == 9)
+		printk("m32r_cfc: iowrite_word :outsw \n");
+
+	addr = pcc_port2addr(port, 2);
+	if (!addr) {
+		printk("m32r_cfc:iowrite_word null addr :%#lx\n",port);
+		return;
+	}
+#if 1
+	if (addr & 1) {
+		printk("m32r_cfc:iowrite_word port addr (%#lx):%#lx\n", port,
+			addr);
+		return;
+	}
+#endif
+	debug(3, "m32r_cfc: pcc_iowrite_word: addr=%#lx\n", addr);
+
+	spin_lock_irqsave(&pcc_lock, flags);
+	while (nmemb--)
+		writew(*bp++, addr);
+	spin_unlock_irqrestore(&pcc_lock, flags);
+}
+
+/*====================================================================*/
+
+#define IS_ALIVE		0x8000
+
+typedef struct pcc_t {
+	char			*name;
+	u_short			flags;
+} pcc_t;
+
+static pcc_t pcc[] = {
+#if !defined(CONFIG_PLAT_USRV)
+	{ "m32r_cfc", 0 }, { "", 0 },
+#else	/* CONFIG_PLAT_USRV */
+	{ "m32r_cfc", 0 }, { "m32r_cfc", 0 }, { "m32r_cfc", 0 },
+	{ "m32r_cfc", 0 }, { "m32r_cfc", 0 }, { "", 0 },
+#endif	/* CONFIG_PLAT_USRV */
+};
+
+static irqreturn_t pcc_interrupt(int, void *, struct pt_regs *);
+
+/*====================================================================*/
+
+static struct timer_list poll_timer;
+
+static unsigned int pcc_get(u_short sock, unsigned int reg)
+{
+	unsigned int val = inw(reg);
+	debug(3, "m32r_cfc: pcc_get: reg(0x%08x)=0x%04x\n", reg, val);
+	return val;
+}
+
+
+static void pcc_set(u_short sock, unsigned int reg, unsigned int data)
+{
+	outw(data, reg);
+	debug(3, "m32r_cfc: pcc_set: reg(0x%08x)=0x%04x\n", reg, data);
+}
+
+/*======================================================================
+
+	See if a card is present, powered up, in IO mode, and already
+	bound to a (non PC Card) Linux driver.  We leave these alone.
+
+	We make an exception for cards that seem to be serial devices.
+
+======================================================================*/
+
+static int __init is_alive(u_short sock)
+{
+	unsigned int stat;
+
+	debug(3, "m32r_cfc: is_alive:\n");
+
+	printk("CF: ");
+	stat = pcc_get(sock, (unsigned int)PLD_CFSTS);
+	if (!stat)
+		printk("No ");
+	printk("Card is detected at socket %d : stat = 0x%08x\n", sock, stat);
+	debug(3, "m32r_cfc: is_alive: sock stat is 0x%04x\n", stat);
+
+	return 0;
+}
+
+static void add_pcc_socket(ulong base, int irq, ulong mapaddr, ioaddr_t ioaddr)
+{
+	pcc_socket_t *t = &socket[pcc_sockets];
+
+	debug(3, "m32r_cfc: add_pcc_socket: base=%#lx, irq=%d, "
+		 "mapaddr=%#lx, ioaddr=%08x\n",
+		 base, irq, mapaddr, ioaddr);
+
+	/* add sockets */
+	t->ioaddr = ioaddr;
+	t->mapaddr = mapaddr;
+#if !defined(CONFIG_PLAT_USRV)
+	t->base = 0;
+	t->flags = 0;
+	t->cs_irq1 = irq;		// insert irq
+	t->cs_irq2 = irq + 1;		// eject irq
+#else	/* CONFIG_PLAT_USRV */
+	t->base = base;
+	t->flags = 0;
+	t->cs_irq1 = 0;			// insert irq
+	t->cs_irq2 = 0;			// eject irq
+#endif	/* CONFIG_PLAT_USRV */
+
+	if (is_alive(pcc_sockets))
+		t->flags |= IS_ALIVE;
+
+	/* add pcc */
+#if !defined(CONFIG_PLAT_USRV)
+	request_region((unsigned int)PLD_CFRSTCR, 0x20, "m32r_cfc");
+#else	/* CONFIG_PLAT_USRV */
+	{
+		unsigned int reg_base;
+
+		reg_base = (unsigned int)PLD_CFRSTCR;
+		reg_base |= pcc_sockets << 8;
+		request_region(reg_base, 0x20, "m32r_cfc");
+	}
+#endif	/* CONFIG_PLAT_USRV */
+	printk(KERN_INFO "  %s ", pcc[pcc_sockets].name);
+	printk("pcc at 0x%08lx\n", t->base);
+
+	/* Update socket interrupt information, capabilities */
+	t->socket.features |= (SS_CAP_PCCARD | SS_CAP_STATIC_MAP);
+	t->socket.map_size = M32R_PCC_MAPSIZE;
+	t->socket.io_offset = ioaddr;	/* use for io access offset */
+	t->socket.irq_mask = 0;
+#if !defined(CONFIG_PLAT_USRV)
+	t->socket.pci_irq = PLD_IRQ_CFIREQ ;	/* card interrupt */
+#else	/* CONFIG_PLAT_USRV */
+	t->socket.pci_irq = PLD_IRQ_CF0 + pcc_sockets;
+#endif	/* CONFIG_PLAT_USRV */
+
+#ifndef CONFIG_PLAT_USRV
+	/* insert interrupt */
+	request_irq(irq, pcc_interrupt, 0, "m32r_cfc", pcc_interrupt);
+	/* eject interrupt */
+	request_irq(irq+1, pcc_interrupt, 0, "m32r_cfc", pcc_interrupt);
+
+	debug(3, "m32r_cfc: enable CFMSK, RDYSEL\n");
+	pcc_set(pcc_sockets, (unsigned int)PLD_CFIMASK, 0x01);
+#endif	/* CONFIG_PLAT_USRV */
+#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_USRV) || defined(CONFIG_PLAT_OPSPUT)
+	pcc_set(pcc_sockets, (unsigned int)PLD_CFCR1, 0x0200);
+#endif
+	pcc_sockets++;
+
+	return;
+}
+
+
+/*====================================================================*/
+
+static irqreturn_t pcc_interrupt(int irq, void *dev, struct pt_regs *regs)
+{
+	int i;
+	u_int events = 0;
+	int handled = 0;
+
+	debug(3, "m32r_cfc: pcc_interrupt: irq=%d, dev=%p, regs=%p\n",
+		irq, dev, regs);
+	for (i = 0; i < pcc_sockets; i++) {
+		if (socket[i].cs_irq1 != irq && socket[i].cs_irq2 != irq)
+			continue;
+
+		handled = 1;
+		debug(3, "m32r_cfc: pcc_interrupt: socket %d irq 0x%02x ",
+			i, irq);
+		events |= SS_DETECT;	/* insert or eject */
+		if (events)
+			pcmcia_parse_events(&socket[i].socket, events);
+	}
+	debug(3, "m32r_cfc: pcc_interrupt: done\n");
+
+	return IRQ_RETVAL(handled);
+} /* pcc_interrupt */
+
+static void pcc_interrupt_wrapper(u_long data)
+{
+	debug(3, "m32r_cfc: pcc_interrupt_wrapper:\n");
+	pcc_interrupt(0, NULL, NULL);
+	init_timer(&poll_timer);
+	poll_timer.expires = jiffies + poll_interval;
+	add_timer(&poll_timer);
+}
+
+/*====================================================================*/
+
+static int _pcc_get_status(u_short sock, u_int *value)
+{
+	u_int status;
+
+	debug(3, "m32r_cfc: _pcc_get_status:\n");
+	status = pcc_get(sock, (unsigned int)PLD_CFSTS);
+	*value = (status) ? SS_DETECT : 0;
+ 	debug(3, "m32r_cfc: _pcc_get_status: status=0x%08x\n", status);
+
+#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_USRV) || defined(CONFIG_PLAT_OPSPUT)
+	if ( status ) {
+		/* enable CF power */
+		status = inw((unsigned int)PLD_CPCR);
+		if (!(status & PLD_CPCR_CF)) {
+			debug(3, "m32r_cfc: _pcc_get_status: "
+				 "power on (CPCR=0x%08x)\n", status);
+			status |= PLD_CPCR_CF;
+			outw(status, (unsigned int)PLD_CPCR);
+			udelay(100);
+		}
+		*value |= SS_POWERON;
+
+		pcc_set(sock, (unsigned int)PLD_CFBUFCR,0);/* enable buffer */
+		udelay(100);
+
+		*value |= SS_READY; 		/* always ready */
+		*value |= SS_3VCARD;
+	} else {
+		/* disable CF power */
+		status = inw((unsigned int)PLD_CPCR);
+		status &= ~PLD_CPCR_CF;
+		outw(status, (unsigned int)PLD_CPCR);
+		udelay(100);
+		debug(3, "m32r_cfc: _pcc_get_status: "
+			 "power off (CPCR=0x%08x)\n", status);
+	}
+#elif defined(CONFIG_PLAT_MAPPI2)
+	if ( status ) {
+		status = pcc_get(sock, (unsigned int)PLD_CPCR);
+		if (status == 0) { /* power off */
+			pcc_set(sock, (unsigned int)PLD_CPCR, 1);
+			pcc_set(sock, (unsigned int)PLD_CFBUFCR,0); /* force buffer off for ZA-36 */
+			udelay(50);
+		}
+		status = pcc_get(sock, (unsigned int)PLD_CFBUFCR);
+		if (status != 0) { /* buffer off */
+			pcc_set(sock, (unsigned int)PLD_CFBUFCR,0);
+			udelay(50);
+			pcc_set(sock, (unsigned int)PLD_CFRSTCR, 0x0101);
+			udelay(25); /* for IDE reset */
+			pcc_set(sock, (unsigned int)PLD_CFRSTCR, 0x0100);
+			mdelay(2);  /* for IDE reset */
+		} else {
+			*value |= SS_POWERON;
+			*value |= SS_READY;
+		}
+	}
+#else
+#error no platform configuration
+#endif
+	debug(3, "m32r_cfc: _pcc_get_status: GetStatus(%d) = %#4.4x\n",
+		 sock, *value);
+	return 0;
+} /* _get_status */
+
+/*====================================================================*/
+
+static int _pcc_get_socket(u_short sock, socket_state_t *state)
+{
+//	pcc_socket_t *t = &socket[sock];
+
+#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_USRV) || defined(CONFIG_PLAT_OPSPUT)
+	state->flags = 0;
+	state->csc_mask = SS_DETECT;
+	state->csc_mask |= SS_READY;
+	state->io_irq = 0;
+	state->Vcc = 33;	/* 3.3V fixed */
+	state->Vpp = 33;
+#endif
+	debug(3, "m32r_cfc: GetSocket(%d) = flags %#3.3x, Vcc %d, Vpp %d, "
+		  "io_irq %d, csc_mask %#2.2x\n", sock, state->flags,
+		  state->Vcc, state->Vpp, state->io_irq, state->csc_mask);
+	return 0;
+} /* _get_socket */
+
+/*====================================================================*/
+
+static int _pcc_set_socket(u_short sock, socket_state_t *state)
+{
+#if defined(CONFIG_PLAT_MAPPI2)
+	u_long reg = 0;
+#endif
+	debug(3, "m32r_cfc: SetSocket(%d, flags %#3.3x, Vcc %d, Vpp %d, "
+		  "io_irq %d, csc_mask %#2.2x)\n", sock, state->flags,
+		  state->Vcc, state->Vpp, state->io_irq, state->csc_mask);
+
+#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_USRV) || defined(CONFIG_PLAT_OPSPUT)
+	if (state->Vcc) {
+		if ((state->Vcc != 50) && (state->Vcc != 33))
+			return -EINVAL;
+		/* accept 5V and 3.3V */
+	}
+#elif defined(CONFIG_PLAT_MAPPI2)
+	if (state->Vcc) {
+		/*
+		 * 5V only
+		 */
+		if (state->Vcc == 50) {
+			reg |= PCCSIGCR_VEN;
+		} else {
+			return -EINVAL;
+		}
+	}
+#endif
+
+	if (state->flags & SS_RESET) {
+		debug(3, ":RESET\n");
+		pcc_set(sock,(unsigned int)PLD_CFRSTCR,0x101);
+	}else{
+		pcc_set(sock,(unsigned int)PLD_CFRSTCR,0x100);
+	}
+	if (state->flags & SS_OUTPUT_ENA){
+		debug(3, ":OUTPUT_ENA\n");
+		/* bit clear */
+		pcc_set(sock,(unsigned int)PLD_CFBUFCR,0);
+	} else {
+		pcc_set(sock,(unsigned int)PLD_CFBUFCR,1);
+	}
+
+#ifdef DEBUG
+	if(state->flags & SS_IOCARD){
+		debug(3, ":IOCARD");
+	}
+	if (state->flags & SS_PWR_AUTO) {
+		debug(3, ":PWR_AUTO");
+	}
+	if (state->csc_mask & SS_DETECT)
+		debug(3, ":csc-SS_DETECT");
+	if (state->flags & SS_IOCARD) {
+		if (state->csc_mask & SS_STSCHG)
+			debug(3, ":STSCHG");
+	} else {
+		if (state->csc_mask & SS_BATDEAD)
+			debug(3, ":BATDEAD");
+		if (state->csc_mask & SS_BATWARN)
+			debug(3, ":BATWARN");
+		if (state->csc_mask & SS_READY)
+			debug(3, ":READY");
+	}
+	debug(3, "\n");
+#endif
+	return 0;
+} /* _set_socket */
+
+/*====================================================================*/
+
+static int _pcc_set_io_map(u_short sock, struct pccard_io_map *io)
+{
+	u_char map;
+
+	debug(3, "m32r_cfc: SetIOMap(%d, %d, %#2.2x, %d ns, "
+		  "%#4.4x-%#4.4x)\n", sock, io->map, io->flags,
+		  io->speed, io->start, io->stop);
+	map = io->map;
+
+	return 0;
+} /* _set_io_map */
+
+/*====================================================================*/
+
+static int _pcc_set_mem_map(u_short sock, struct pccard_mem_map *mem)
+{
+
+	u_char map = mem->map;
+	u_long addr;
+	pcc_socket_t *t = &socket[sock];
+
+	debug(3, "m32r_cfc: SetMemMap(%d, %d, %#2.2x, %d ns, "
+		 "%#5.5lx, %#5.5x)\n", sock, map, mem->flags,
+		 mem->speed, mem->static_start, mem->card_start);
+
+	/*
+	 * sanity check
+	 */
+	if ((map > MAX_WIN) || (mem->card_start > 0x3ffffff)){
+		return -EINVAL;
+	}
+
+	/*
+	 * de-activate
+	 */
+	if ((mem->flags & MAP_ACTIVE) == 0) {
+		t->current_space = as_none;
+		return 0;
+	}
+
+	/*
+	 * Set mode
+	 */
+	if (mem->flags & MAP_ATTRIB) {
+		t->current_space = as_attr;
+	} else {
+		t->current_space = as_comm;
+	}
+
+	/*
+	 * Set address
+	 */
+	addr = t->mapaddr + (mem->card_start & M32R_PCC_MAPMASK);
+	mem->static_start = addr + mem->card_start;
+
+	return 0;
+
+} /* _set_mem_map */
+
+#if 0 /* driver model ordering issue */
+/*======================================================================
+
+	Routines for accessing socket information and register dumps via
+	/proc/bus/pccard/...
+
+======================================================================*/
+
+static ssize_t show_info(struct class_device *class_dev, char *buf)
+{
+	pcc_socket_t *s = container_of(class_dev, struct pcc_socket,
+		socket.dev);
+
+	return sprintf(buf, "type:     %s\nbase addr:    0x%08lx\n",
+		pcc[s->type].name, s->base);
+}
+
+static ssize_t show_exca(struct class_device *class_dev, char *buf)
+{
+	/* FIXME */
+
+	return 0;
+}
+
+static CLASS_DEVICE_ATTR(info, S_IRUGO, show_info, NULL);
+static CLASS_DEVICE_ATTR(exca, S_IRUGO, show_exca, NULL);
+#endif
+
+/*====================================================================*/
+
+/* this is horribly ugly... proper locking needs to be done here at
+ * some time... */
+#define LOCKED(x) do {					\
+	int retval;					\
+	unsigned long flags;				\
+	spin_lock_irqsave(&pcc_lock, flags);		\
+	retval = x;					\
+	spin_unlock_irqrestore(&pcc_lock, flags);	\
+	return retval;					\
+} while (0)
+
+
+static int pcc_get_status(struct pcmcia_socket *s, u_int *value)
+{
+	unsigned int sock = container_of(s, struct pcc_socket, socket)->number;
+
+	if (socket[sock].flags & IS_ALIVE) {
+		debug(3, "m32r_cfc: pcc_get_status: sock(%d) -EINVAL\n", sock);
+		*value = 0;
+		return -EINVAL;
+	}
+	debug(3, "m32r_cfc: pcc_get_status: sock(%d)\n", sock);
+	LOCKED(_pcc_get_status(sock, value));
+}
+
+static int pcc_get_socket(struct pcmcia_socket *s, socket_state_t *state)
+{
+	unsigned int sock = container_of(s, struct pcc_socket, socket)->number;
+
+	if (socket[sock].flags & IS_ALIVE) {
+		debug(3, "m32r_cfc: pcc_get_socket: sock(%d) -EINVAL\n", sock);
+		return -EINVAL;
+	}
+	debug(3, "m32r_cfc: pcc_get_socket: sock(%d)\n", sock);
+	LOCKED(_pcc_get_socket(sock, state));
+}
+
+static int pcc_set_socket(struct pcmcia_socket *s, socket_state_t *state)
+{
+	unsigned int sock = container_of(s, struct pcc_socket, socket)->number;
+
+	if (socket[sock].flags & IS_ALIVE) {
+		debug(3, "m32r_cfc: pcc_set_socket: sock(%d) -EINVAL\n", sock);
+		return -EINVAL;
+	}
+	debug(3, "m32r_cfc: pcc_set_socket: sock(%d)\n", sock);
+	LOCKED(_pcc_set_socket(sock, state));
+}
+
+static int pcc_set_io_map(struct pcmcia_socket *s, struct pccard_io_map *io)
+{
+	unsigned int sock = container_of(s, struct pcc_socket, socket)->number;
+
+	if (socket[sock].flags & IS_ALIVE) {
+		debug(3, "m32r_cfc: pcc_set_io_map: sock(%d) -EINVAL\n", sock);
+		return -EINVAL;
+	}
+	debug(3, "m32r_cfc: pcc_set_io_map: sock(%d)\n", sock);
+	LOCKED(_pcc_set_io_map(sock, io));
+}
+
+static int pcc_set_mem_map(struct pcmcia_socket *s, struct pccard_mem_map *mem)
+{
+	unsigned int sock = container_of(s, struct pcc_socket, socket)->number;
+
+	if (socket[sock].flags & IS_ALIVE) {
+		debug(3, "m32r_cfc: pcc_set_mem_map: sock(%d) -EINVAL\n", sock);
+		return -EINVAL;
+	}
+	debug(3, "m32r_cfc: pcc_set_mem_map: sock(%d)\n", sock);
+	LOCKED(_pcc_set_mem_map(sock, mem));
+}
+
+static int pcc_init(struct pcmcia_socket *s)
+{
+	debug(3, "m32r_cfc: pcc_init()\n");
+	return 0;
+}
+
+static int pcc_suspend(struct pcmcia_socket *sock)
+{
+	debug(3, "m32r_cfc: pcc_suspend()\n");
+	return pcc_set_socket(sock, &dead_socket);
+}
+
+static struct pccard_operations pcc_operations = {
+	.init			= pcc_init,
+	.suspend		= pcc_suspend,
+	.get_status		= pcc_get_status,
+	.get_socket		= pcc_get_socket,
+	.set_socket		= pcc_set_socket,
+	.set_io_map		= pcc_set_io_map,
+	.set_mem_map		= pcc_set_mem_map,
+};
+
+/*====================================================================*/
+
+static int m32r_pcc_suspend(struct device *dev, u32 state, u32 level)
+{
+	int ret = 0;
+	if (level == SUSPEND_SAVE_STATE)
+		ret = pcmcia_socket_dev_suspend(dev, state);
+	return ret;
+}
+
+static int m32r_pcc_resume(struct device *dev, u32 level)
+{
+	int ret = 0;
+	if (level == RESUME_RESTORE_STATE)
+		ret = pcmcia_socket_dev_resume(dev);
+	return ret;
+}
+
+
+static struct device_driver pcc_driver = {
+	.name = "cfc",
+	.bus = &platform_bus_type,
+	.suspend = m32r_pcc_suspend,
+	.resume = m32r_pcc_resume,
+};
+
+static struct platform_device pcc_device = {
+	.name = "cfc",
+	.id = 0,
+};
+
+/*====================================================================*/
+
+static int __init init_m32r_pcc(void)
+{
+	int i, ret;
+
+	ret = driver_register(&pcc_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_device_register(&pcc_device);
+	if (ret){
+		driver_unregister(&pcc_driver);
+		return ret;
+	}
+
+#if defined(CONFIG_PLAT_MAPPI2)
+	pcc_set(0, (unsigned int)PLD_CFCR0, 0x0f0f);
+	pcc_set(0, (unsigned int)PLD_CFCR1, 0x0200);
+#endif
+
+	pcc_sockets = 0;
+
+#if !defined(CONFIG_PLAT_USRV)
+	add_pcc_socket(M32R_PCC0_BASE, PLD_IRQ_CFC_INSERT, CFC_ATTR_MAPBASE,
+		       CFC_IOPORT_BASE);
+#else	/* CONFIG_PLAT_USRV */
+	{
+		ulong base, mapaddr;
+		ioaddr_t ioaddr;
+
+		for (i = 0 ; i < M32R_MAX_PCC ; i++) {
+			base = (ulong)PLD_CFRSTCR;
+			base = base | (i << 8);
+			ioaddr = (i + 1) << 12;
+			mapaddr = CFC_ATTR_MAPBASE | (i << 20);
+			add_pcc_socket(base, 0, mapaddr, ioaddr);
+		}
+	}
+#endif	/* CONFIG_PLAT_USRV */
+
+	if (pcc_sockets == 0) {
+		printk("socket is not found.\n");
+		platform_device_unregister(&pcc_device);
+		driver_unregister(&pcc_driver);
+		return -ENODEV;
+	}
+
+	/* Set up interrupt handler(s) */
+
+	for (i = 0 ; i < pcc_sockets ; i++) {
+		socket[i].socket.dev.dev = &pcc_device.dev;
+		socket[i].socket.ops = &pcc_operations;
+		socket[i].socket.owner = THIS_MODULE;
+		socket[i].number = i;
+		ret = pcmcia_register_socket(&socket[i].socket);
+		if (ret && i--) {
+			for (; i>= 0; i--)
+				pcmcia_unregister_socket(&socket[i].socket);
+			break;
+		}
+#if 0	/* driver model ordering issue */
+		class_device_create_file(&socket[i].socket.dev,
+					 &class_device_attr_info);
+		class_device_create_file(&socket[i].socket.dev,
+					 &class_device_attr_exca);
+#endif
+	}
+
+	/* Finally, schedule a polling interrupt */
+	if (poll_interval != 0) {
+		poll_timer.function = pcc_interrupt_wrapper;
+		poll_timer.data = 0;
+		init_timer(&poll_timer);
+		poll_timer.expires = jiffies + poll_interval;
+		add_timer(&poll_timer);
+	}
+
+	return 0;
+} /* init_m32r_pcc */
+
+static void __exit exit_m32r_pcc(void)
+{
+	int i;
+
+	for (i = 0; i < pcc_sockets; i++)
+		pcmcia_unregister_socket(&socket[i].socket);
+
+	platform_device_unregister(&pcc_device);
+	if (poll_interval != 0)
+		del_timer_sync(&poll_timer);
+
+	driver_unregister(&pcc_driver);
+} /* exit_m32r_pcc */
+
+module_init(init_m32r_pcc);
+module_exit(exit_m32r_pcc);
+MODULE_LICENSE("Dual MPL/GPL");
+/*====================================================================*/
diff -ruNp a/drivers/pcmcia/m32r_cfc.h b/drivers/pcmcia/m32r_cfc.h
--- a/drivers/pcmcia/m32r_cfc.h	1970-01-01 09:00:00.000000000 +0900
+++ b/drivers/pcmcia/m32r_cfc.h	2004-10-05 21:15:44.000000000 +0900
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2001 by Hiroyuki Kondo
+ */
+
+#if !defined(CONFIG_M32R_CFC_NUM)
+#define M32R_MAX_PCC	2
+#else
+#define M32R_MAX_PCC	CONFIG_M32R_CFC_NUM
+#endif
+
+/*
+ * M32R PC Card Controler
+ */
+#define M32R_PCC0_BASE        0x00ef7000
+#define M32R_PCC1_BASE        0x00ef7020
+
+/*
+ * Register offsets
+ */
+#define PCCR            0x00
+#define PCADR           0x04
+#define PCMOD           0x08
+#define PCIRC           0x0c
+#define PCCSIGCR        0x10
+#define PCATCR          0x14
+
+/*
+ * PCCR
+ */
+#define PCCR_PCEN       (1UL<<(31-31))
+
+/*
+ * PCIRC
+ */
+#define PCIRC_BWERR     (1UL<<(31-7))
+#define PCIRC_CDIN1     (1UL<<(31-14))
+#define PCIRC_CDIN2     (1UL<<(31-15))
+#define PCIRC_BEIEN     (1UL<<(31-23))
+#define PCIRC_CIIEN     (1UL<<(31-30))
+#define PCIRC_COIEN     (1UL<<(31-31))
+
+/*
+ * PCCSIGCR
+ */
+#define PCCSIGCR_SEN    (1UL<<(31-3))
+#define PCCSIGCR_VEN    (1UL<<(31-7))
+#define PCCSIGCR_CRST   (1UL<<(31-15))
+#define PCCSIGCR_COCR   (1UL<<(31-31))
+
+/*
+ *
+ */
+#define PCMOD_AS_ATTRIB	(1UL<<(31-19))
+#define PCMOD_AS_IO	(1UL<<(31-18))
+
+#define PCMOD_CBSZ	(1UL<<(31-23)) /* set for 8bit */
+
+#define PCMOD_DBEX	(1UL<<(31-31)) /* set for excahnge */
+
+/*
+ * M32R PCC Map addr
+ */
+
+#define M32R_PCC0_MAPBASE        0x14000000
+#define M32R_PCC1_MAPBASE        0x16000000
+
+#define M32R_PCC_MAPMAX		 0x02000000
+
+#define M32R_PCC_MAPSIZE	 0x00001000 /* XXX */
+#define M32R_PCC_MAPMASK     	(~(M32R_PCC_MAPMAX-1))
+
+#define CFC_IOPORT_BASE		0x1000
+
+#if !defined(CONFIG_PLAT_USRV)
+#define CFC_ATTR_MAPBASE        0x0c014000
+#define CFC_IO_MAPBASE_BYTE     0xac012000
+#define CFC_IO_MAPBASE_WORD     0xac002000
+#else	/* CONFIG_PLAT_USRV */
+#define CFC_ATTR_MAPBASE	0x04014000
+#define CFC_IO_MAPBASE_BYTE	0xa4012000
+#define CFC_IO_MAPBASE_WORD	0xa4002000
+#endif	/* CONFIG_PLAT_USRV */
+
diff -ruNp a/drivers/pcmcia/m32r_pcc.c b/drivers/pcmcia/m32r_pcc.c
--- a/drivers/pcmcia/m32r_pcc.c	1970-01-01 09:00:00.000000000 +0900
+++ b/drivers/pcmcia/m32r_pcc.c	2004-10-05 21:15:44.000000000 +0900
@@ -0,0 +1,816 @@
+/*
+ *  drivers/pcmcia/m32r_pcc.c
+ *
+ *  Device driver for the PCMCIA functionality of M32R.
+ *
+ *  Copyright (c) 2001, 2002, 2003, 2004
+ *    Hiroyuki Kondo, Naoto Sugai, Hayato Fujiwara
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/timer.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/bitops.h>
+#include <asm/system.h>
+#include <asm/addrspace.h>
+
+#include <pcmcia/version.h>
+#include <pcmcia/cs_types.h>
+#include <pcmcia/ss.h>
+#include <pcmcia/cs.h>
+
+/* XXX: should be moved into asm/irq.h */
+#define PCC0_IRQ 24
+#define PCC1_IRQ 25
+
+#include "m32r_pcc.h"
+
+#define CHAOS_PCC_DEBUG
+#ifdef CHAOS_PCC_DEBUG
+	static volatile u_short dummy_readbuf;
+#endif
+
+#define PCC_DEBUG_DBEX
+
+#ifdef DEBUG
+static int m32r_pcc_debug;
+module_param(m32r_pcc_debug, int, 0644);
+#define debug(lvl, fmt, arg...) do {				\
+	if (m32r_pcc_debug > (lvl))				\
+		printk(KERN_DEBUG "m32r_pcc: " fmt , ## arg);	\
+} while (0)
+#else
+#define debug(n, args...) do { } while (0)
+#endif
+
+/* Poll status interval -- 0 means default to interrupt */
+static int poll_interval = 0;
+
+typedef enum pcc_space { as_none = 0, as_comm, as_attr, as_io } pcc_as_t;
+
+typedef struct pcc_socket {
+	u_short			type, flags;
+	struct pcmcia_socket	socket;
+	unsigned int		number;
+ 	ioaddr_t		ioaddr;
+	u_long			mapaddr;
+	u_long			base;	/* PCC register base */
+	u_char			cs_irq, intr;
+	pccard_io_map		io_map[MAX_IO_WIN];
+	pccard_mem_map		mem_map[MAX_WIN];
+	u_char			io_win;
+	u_char			mem_win;
+	pcc_as_t		current_space;
+	u_char			last_iodbex;
+#ifdef CHAOS_PCC_DEBUG
+	u_char			last_iosize;
+#endif
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *proc;
+#endif
+} pcc_socket_t;
+
+static int pcc_sockets = 0;
+static pcc_socket_t socket[M32R_MAX_PCC] = {
+	{ 0, }, /* ... */
+};
+
+/*====================================================================*/
+
+static unsigned int pcc_get(u_short, unsigned int);
+static void pcc_set(u_short, unsigned int , unsigned int );
+
+static spinlock_t pcc_lock = SPIN_LOCK_UNLOCKED;
+
+void pcc_iorw(int sock, unsigned long port, void *buf, size_t size, size_t nmemb, int wr, int flag)
+{
+	u_long addr;
+	u_long flags;
+	int need_ex;
+#ifdef PCC_DEBUG_DBEX
+	int _dbex;
+#endif
+	pcc_socket_t *t = &socket[sock];
+#ifdef CHAOS_PCC_DEBUG
+	int map_changed = 0;
+#endif
+
+	/* Need lock ? */
+	spin_lock_irqsave(&pcc_lock, flags);
+
+	/*
+	 * Check if need dbex
+	 */
+	need_ex = (size > 1 && flag == 0) ? PCMOD_DBEX : 0;
+#ifdef PCC_DEBUG_DBEX
+	_dbex = need_ex;
+	need_ex = 0;
+#endif
+
+	/*
+	 * calculate access address
+	 */
+	addr = t->mapaddr + port - t->ioaddr + KSEG1; /* XXX */
+
+	/*
+	 * Check current mapping
+	 */
+	if (t->current_space != as_io || t->last_iodbex != need_ex) {
+
+		u_long cbsz;
+
+		/*
+		 * Disable first
+		 */
+		pcc_set(sock, PCCR, 0);
+
+		/*
+		 * Set mode and io address
+		 */
+		cbsz = (t->flags & MAP_16BIT) ? 0 : PCMOD_CBSZ;
+		pcc_set(sock, PCMOD, PCMOD_AS_IO | cbsz | need_ex);
+		pcc_set(sock, PCADR, addr & 0x1ff00000);
+
+		/*
+		 * Enable and read it
+		 */
+		pcc_set(sock, PCCR, 1);
+
+#ifdef CHAOS_PCC_DEBUG
+#if 0
+		map_changed = (t->current_space == as_attr && size == 2); /* XXX */
+#else
+		map_changed = 1;
+#endif
+#endif
+		t->current_space = as_io;
+	}
+
+	/*
+	 * access to IO space
+	 */
+	if (size == 1) {
+		/* Byte */
+		unsigned char *bp = (unsigned char *)buf;
+
+#ifdef CHAOS_DEBUG
+		if (map_changed) {
+			dummy_readbuf = readb(addr);
+		}
+#endif
+		if (wr) {
+			/* write Byte */
+			while (nmemb--) {
+				writeb(*bp++, addr);
+			}
+		} else {
+			/* read Byte */
+			while (nmemb--) {
+	    		*bp++ = readb(addr);
+			}
+		}
+	} else {
+		/* Word */
+		unsigned short *bp = (unsigned short *)buf;
+
+#ifdef CHAOS_PCC_DEBUG
+		if (map_changed) {
+			dummy_readbuf = readw(addr);
+		}
+#endif
+		if (wr) {
+			/* write Word */
+			while (nmemb--) {
+#ifdef PCC_DEBUG_DBEX
+				if (_dbex) {
+					unsigned char *cp = (unsigned char *)bp;
+					unsigned short tmp;
+					tmp = cp[1] << 8 | cp[0];
+					writew(tmp, addr);
+					bp++;
+				} else
+#endif
+				writew(*bp++, addr);
+	    	}
+	    } else {
+	    	/* read Word */
+	    	while (nmemb--) {
+#ifdef  PCC_DEBUG_DBEX
+				if (_dbex) {
+					unsigned char *cp = (unsigned char *)bp;
+					unsigned short tmp;
+					tmp = readw(addr);
+					cp[0] = tmp & 0xff;
+					cp[1] = (tmp >> 8) & 0xff;
+					bp++;
+				} else
+#endif
+				*bp++ = readw(addr);
+	    	}
+	    }
+	}
+
+#if 1
+	/* addr is no longer used */
+	if ((addr = pcc_get(sock, PCIRC)) & PCIRC_BWERR) {
+	  printk("m32r_pcc: BWERR detected : port 0x%04lx : iosize %dbit\n",
+			 port, size * 8);
+	  pcc_set(sock, PCIRC, addr);
+	}
+#endif
+	/*
+	 * save state
+	 */
+	t->last_iosize = size;
+	t->last_iodbex = need_ex;
+
+	/* Need lock ? */
+
+	spin_unlock_irqrestore(&pcc_lock,flags);
+
+	return;
+}
+
+void pcc_ioread(int sock, unsigned long port, void *buf, size_t size, size_t nmemb, int flag) {
+	pcc_iorw(sock, port, buf, size, nmemb, 0, flag);
+}
+
+void pcc_iowrite(int sock, unsigned long port, void *buf, size_t size, size_t nmemb, int flag) {
+    pcc_iorw(sock, port, buf, size, nmemb, 1, flag);
+}
+
+/*====================================================================*/
+
+#define IS_ALIVE		0x8000
+
+typedef struct pcc_t {
+	char			*name;
+	u_short			flags;
+} pcc_t;
+
+static pcc_t pcc[] = {
+	{ "xnux2", 0 }, { "xnux2", 0 },
+};
+
+static irqreturn_t pcc_interrupt(int, void *, struct pt_regs *);
+
+/*====================================================================*/
+
+static struct timer_list poll_timer;
+
+static unsigned int pcc_get(u_short sock, unsigned int reg)
+{
+	return inl(socket[sock].base + reg);
+}
+
+
+static void pcc_set(u_short sock, unsigned int reg, unsigned int data)
+{
+  	outl(data, socket[sock].base + reg);
+}
+
+/*======================================================================
+
+	See if a card is present, powered up, in IO mode, and already
+	bound to a (non PC Card) Linux driver.  We leave these alone.
+
+	We make an exception for cards that seem to be serial devices.
+
+======================================================================*/
+
+static int __init is_alive(u_short sock)
+{
+	unsigned int stat;
+	unsigned int f;
+
+	stat = pcc_get(sock, PCIRC);
+	f = (stat & (PCIRC_CDIN1 | PCIRC_CDIN2)) >> 16;
+	if(!f){
+		printk("m32r_pcc: No Card is detected at socket %d : stat = 0x%08x\n",stat,sock);
+		return 0;
+	}
+	if(f!=3)
+		printk("m32r_pcc: Insertion fail (%.8x) at socket %d\n",stat,sock);
+	else
+		printk("m32r_pcc: Card is Inserted at socket %d(%.8x)\n",sock,stat);
+	return 0;
+}
+
+static void add_pcc_socket(ulong base, int irq, ulong mapaddr, ioaddr_t ioaddr)
+{
+  	pcc_socket_t *t = &socket[pcc_sockets];
+
+	/* add sockets */
+	t->ioaddr = ioaddr;
+	t->mapaddr = mapaddr;
+	t->base = base;
+#ifdef CHAOS_PCC_DEBUG
+	t->flags = MAP_16BIT;
+#else
+	t->flags = 0;
+#endif
+	if (is_alive(pcc_sockets))
+		t->flags |= IS_ALIVE;
+
+	/* add pcc */
+	if (t->base > 0) {
+		request_region(t->base, 0x20, "m32r-pcc");
+	}
+
+	printk(KERN_INFO "  %s ", pcc[pcc_sockets].name);
+	printk("pcc at 0x%08lx\n", t->base);
+
+	/* Update socket interrupt information, capabilities */
+	t->socket.features |= (SS_CAP_PCCARD | SS_CAP_STATIC_MAP);
+	t->socket.map_size = M32R_PCC_MAPSIZE;
+	t->socket.io_offset = ioaddr;	/* use for io access offset */
+	t->socket.irq_mask = 0;
+	t->socket.pci_irq = 2 + pcc_sockets; /* XXX */
+
+	request_irq(irq, pcc_interrupt, 0, "m32r-pcc", pcc_interrupt);
+
+	pcc_sockets++;
+
+	return;
+}
+
+
+/*====================================================================*/
+
+static irqreturn_t pcc_interrupt(int irq, void *dev, struct pt_regs *regs)
+{
+	int i, j, irc;
+	u_int events, active;
+	int handled = 0;
+
+	debug(4, "m32r: pcc_interrupt(%d)\n", irq);
+
+	for (j = 0; j < 20; j++) {
+		active = 0;
+		for (i = 0; i < pcc_sockets; i++) {
+			if ((socket[i].cs_irq != irq) &&
+				(socket[i].socket.pci_irq != irq))
+				continue;
+			handled = 1;
+			irc = pcc_get(i, PCIRC);
+			irc >>=16;
+			debug(2, "m32r-pcc:interrput: socket %d pcirc 0x%02x ", i, irc);
+			if (!irc)
+				continue;
+
+			events = (irc) ? SS_DETECT : 0;
+			events |= (pcc_get(i,PCCR) & PCCR_PCEN) ? SS_READY : 0;
+			debug(2, " event 0x%02x\n", events);
+
+			if (events)
+				pcmcia_parse_events(&socket[i].socket, events);
+
+			active |= events;
+			active = 0;
+		}
+		if (!active) break;
+	}
+	if (j == 20)
+		printk(KERN_NOTICE "m32r-pcc: infinite loop in interrupt handler\n");
+
+	debug(4, "m32r-pcc: interrupt done\n");
+
+	return IRQ_RETVAL(handled);
+} /* pcc_interrupt */
+
+static void pcc_interrupt_wrapper(u_long data)
+{
+	pcc_interrupt(0, NULL, NULL);
+	init_timer(&poll_timer);
+	poll_timer.expires = jiffies + poll_interval;
+	add_timer(&poll_timer);
+}
+
+/*====================================================================*/
+
+static int _pcc_get_status(u_short sock, u_int *value)
+{
+	u_int status;
+
+	status = pcc_get(sock,PCIRC);
+	*value = ((status & PCIRC_CDIN1) && (status & PCIRC_CDIN2))
+		? SS_DETECT : 0;
+
+	status = pcc_get(sock,PCCR);
+
+#if 0
+	*value |= (status & PCCR_PCEN) ? SS_READY : 0;
+#else
+	*value |= SS_READY; /* XXX: always */
+#endif
+
+	status = pcc_get(sock,PCCSIGCR);
+	*value |= (status & PCCSIGCR_VEN) ? SS_POWERON : 0;
+
+	debug(3, "m32r-pcc: GetStatus(%d) = %#4.4x\n", sock, *value);
+	return 0;
+} /* _get_status */
+
+/*====================================================================*/
+
+static int _pcc_get_socket(u_short sock, socket_state_t *state)
+{
+	debug(3, "m32r-pcc: GetSocket(%d) = flags %#3.3x, Vcc %d, Vpp %d, "
+		  "io_irq %d, csc_mask %#2.2x\n", sock, state->flags,
+		  state->Vcc, state->Vpp, state->io_irq, state->csc_mask);
+	return 0;
+} /* _get_socket */
+
+/*====================================================================*/
+
+static int _pcc_set_socket(u_short sock, socket_state_t *state)
+{
+	u_long reg = 0;
+
+	debug(3, "m32r-pcc: SetSocket(%d, flags %#3.3x, Vcc %d, Vpp %d, "
+		  "io_irq %d, csc_mask %#2.2x)", sock, state->flags,
+		  state->Vcc, state->Vpp, state->io_irq, state->csc_mask);
+
+	if (state->Vcc) {
+		/*
+		 * 5V only
+		 */
+		if (state->Vcc == 50) {
+			reg |= PCCSIGCR_VEN;
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	if (state->flags & SS_RESET) {
+		debug(3, ":RESET\n");
+		reg |= PCCSIGCR_CRST;
+	}
+	if (state->flags & SS_OUTPUT_ENA){
+		debug(3, ":OUTPUT_ENA\n");
+		/* bit clear */
+	} else {
+		reg |= PCCSIGCR_SEN;
+	}
+
+	pcc_set(sock,PCCSIGCR,reg);
+
+#ifdef DEBUG
+	if(state->flags & SS_IOCARD){
+		debug(3, ":IOCARD");
+	}
+	if (state->flags & SS_PWR_AUTO) {
+		debug(3, ":PWR_AUTO");
+	}
+	if (state->csc_mask & SS_DETECT)
+		debug(3, ":csc-SS_DETECT");
+	if (state->flags & SS_IOCARD) {
+		if (state->csc_mask & SS_STSCHG)
+			debug(3, ":STSCHG");
+	} else {
+		if (state->csc_mask & SS_BATDEAD)
+			debug(3, ":BATDEAD");
+		if (state->csc_mask & SS_BATWARN)
+			debug(3, ":BATWARN");
+		if (state->csc_mask & SS_READY)
+			debug(3, ":READY");
+	}
+	debug(3, "\n");
+#endif
+	return 0;
+} /* _set_socket */
+
+/*====================================================================*/
+
+static int _pcc_set_io_map(u_short sock, struct pccard_io_map *io)
+{
+	u_char map;
+
+	debug(3, "m32r-pcc: SetIOMap(%d, %d, %#2.2x, %d ns, "
+		  "%#4.4x-%#4.4x)\n", sock, io->map, io->flags,
+		  io->speed, io->start, io->stop);
+	map = io->map;
+
+	return 0;
+} /* _set_io_map */
+
+/*====================================================================*/
+
+static int _pcc_set_mem_map(u_short sock, struct pccard_mem_map *mem)
+{
+
+	u_char map = mem->map;
+	u_long mode;
+	u_long addr;
+	pcc_socket_t *t = &socket[sock];
+#ifdef CHAOS_PCC_DEBUG
+#if 0
+	pcc_as_t last = t->current_space;
+#endif
+#endif
+
+	debug(3, "m32r-pcc: SetMemMap(%d, %d, %#2.2x, %d ns, "
+		 "%#5.5lx,  %#5.5x)\n", sock, map, mem->flags,
+		 mem->speed, mem->static_start, mem->card_start);
+
+	/*
+	 * sanity check
+	 */
+	if ((map > MAX_WIN) || (mem->card_start > 0x3ffffff)){
+		return -EINVAL;
+	}
+
+	/*
+	 * de-activate
+	 */
+	if ((mem->flags & MAP_ACTIVE) == 0) {
+		t->current_space = as_none;
+		return 0;
+	}
+
+	/*
+	 * Disable first
+	 */
+	pcc_set(sock, PCCR, 0);
+
+	/*
+	 * Set mode
+	 */
+	if (mem->flags & MAP_ATTRIB) {
+		mode = PCMOD_AS_ATTRIB | PCMOD_CBSZ;
+		t->current_space = as_attr;
+	} else {
+		mode = 0; /* common memory */
+		t->current_space = as_comm;
+	}
+	pcc_set(sock, PCMOD, mode);
+
+	/*
+	 * Set address
+	 */
+	addr = t->mapaddr + (mem->card_start & M32R_PCC_MAPMASK);
+	pcc_set(sock, PCADR, addr);
+
+	mem->static_start = addr + mem->card_start;
+
+	/*
+	 * Enable again
+	 */
+	pcc_set(sock, PCCR, 1);
+
+#ifdef CHAOS_PCC_DEBUG
+#if 0
+	if (last != as_attr) {
+#else
+	if (1) {
+#endif
+		dummy_readbuf = *(u_char *)(addr + KSEG1);
+	}
+#endif
+
+	return 0;
+
+} /* _set_mem_map */
+
+#if 0 /* driver model ordering issue */
+/*======================================================================
+
+	Routines for accessing socket information and register dumps via
+	/proc/bus/pccard/...
+
+======================================================================*/
+
+static ssize_t show_info(struct class_device *class_dev, char *buf)
+{
+	pcc_socket_t *s = container_of(class_dev, struct pcc_socket,
+		socket.dev);
+
+	return sprintf(buf, "type:     %s\nbase addr:    0x%08lx\n",
+		pcc[s->type].name, s->base);
+}
+
+static ssize_t show_exca(struct class_device *class_dev, char *buf)
+{
+	/* FIXME */
+
+	return 0;
+}
+
+static CLASS_DEVICE_ATTR(info, S_IRUGO, show_info, NULL);
+static CLASS_DEVICE_ATTR(exca, S_IRUGO, show_exca, NULL);
+#endif
+
+/*====================================================================*/
+
+/* this is horribly ugly... proper locking needs to be done here at
+ * some time... */
+#define LOCKED(x) do {					\
+	int retval;					\
+	unsigned long flags;				\
+	spin_lock_irqsave(&pcc_lock, flags);		\
+	retval = x;					\
+	spin_unlock_irqrestore(&pcc_lock, flags);	\
+	return retval;					\
+} while (0)
+
+
+static int pcc_get_status(struct pcmcia_socket *s, u_int *value)
+{
+	unsigned int sock = container_of(s, struct pcc_socket, socket)->number;
+
+	if (socket[sock].flags & IS_ALIVE) {
+		*value = 0;
+		return -EINVAL;
+	}
+	LOCKED(_pcc_get_status(sock, value));
+}
+
+static int pcc_get_socket(struct pcmcia_socket *s, socket_state_t *state)
+{
+	unsigned int sock = container_of(s, struct pcc_socket, socket)->number;
+
+	if (socket[sock].flags & IS_ALIVE)
+		return -EINVAL;
+	LOCKED(_pcc_get_socket(sock, state));
+}
+
+static int pcc_set_socket(struct pcmcia_socket *s, socket_state_t *state)
+{
+	unsigned int sock = container_of(s, struct pcc_socket, socket)->number;
+
+	if (socket[sock].flags & IS_ALIVE)
+		return -EINVAL;
+
+	LOCKED(_pcc_set_socket(sock, state));
+}
+
+static int pcc_set_io_map(struct pcmcia_socket *s, struct pccard_io_map *io)
+{
+	unsigned int sock = container_of(s, struct pcc_socket, socket)->number;
+
+	if (socket[sock].flags & IS_ALIVE)
+		return -EINVAL;
+	LOCKED(_pcc_set_io_map(sock, io));
+}
+
+static int pcc_set_mem_map(struct pcmcia_socket *s, struct pccard_mem_map *mem)
+{
+	unsigned int sock = container_of(s, struct pcc_socket, socket)->number;
+
+	if (socket[sock].flags & IS_ALIVE)
+		return -EINVAL;
+	LOCKED(_pcc_set_mem_map(sock, mem));
+}
+
+static int pcc_init(struct pcmcia_socket *s)
+{
+	debug(4, "m32r-pcc: init call\n");
+	return 0;
+}
+
+static int pcc_suspend(struct pcmcia_socket *sock)
+{
+	return pcc_set_socket(sock, &dead_socket);
+}
+
+static struct pccard_operations pcc_operations = {
+	.init			= pcc_init,
+	.suspend		= pcc_suspend,
+	.get_status		= pcc_get_status,
+	.get_socket		= pcc_get_socket,
+	.set_socket		= pcc_set_socket,
+	.set_io_map		= pcc_set_io_map,
+	.set_mem_map		= pcc_set_mem_map,
+};
+
+/*====================================================================*/
+
+static int m32r_pcc_suspend(struct device *dev, u32 state, u32 level)
+{
+	int ret = 0;
+	if (level == SUSPEND_SAVE_STATE)
+		ret = pcmcia_socket_dev_suspend(dev, state);
+	return ret;
+}
+
+static int m32r_pcc_resume(struct device *dev, u32 level)
+{
+	int ret = 0;
+	if (level == RESUME_RESTORE_STATE)
+		ret = pcmcia_socket_dev_resume(dev);
+	return ret;
+}
+
+
+static struct device_driver pcc_driver = {
+	.name = "pcc",
+	.bus = &platform_bus_type,
+	.suspend = m32r_pcc_suspend,
+	.resume = m32r_pcc_resume,
+};
+
+static struct platform_device pcc_device = {
+	.name = "pcc",
+	.id = 0,
+};
+
+/*====================================================================*/
+
+static int __init init_m32r_pcc(void)
+{
+	int i, ret;
+
+	ret = driver_register(&pcc_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_device_register(&pcc_device);
+	if (ret){
+		driver_unregister(&pcc_driver);
+		return ret;
+	}
+
+	printk(KERN_INFO "m32r PCC probe:\n");
+
+	pcc_sockets = 0;
+
+	add_pcc_socket(M32R_PCC0_BASE, PCC0_IRQ, M32R_PCC0_MAPBASE, 0x1000);
+
+#ifdef CONFIG_M32RPCC_SLOT2
+	add_pcc_socket(M32R_PCC1_BASE, PCC1_IRQ, M32R_PCC1_MAPBASE, 0x2000);
+#endif
+
+	if (pcc_sockets == 0) {
+		printk("socket is not found.\n");
+		platform_device_unregister(&pcc_device);
+		driver_unregister(&pcc_driver);
+		return -ENODEV;
+	}
+
+	/* Set up interrupt handler(s) */
+
+	for (i = 0 ; i < pcc_sockets ; i++) {
+		socket[i].socket.dev.dev = &pcc_device.dev;
+		socket[i].socket.ops = &pcc_operations;
+		socket[i].socket.owner = THIS_MODULE;
+		socket[i].number = i;
+		ret = pcmcia_register_socket(&socket[i].socket);
+		if (ret && i--) {
+			for (; i>= 0; i--)
+				pcmcia_unregister_socket(&socket[i].socket);
+			break;
+		}
+#if 0	/* driver model ordering issue */
+		class_device_create_file(&socket[i].socket.dev,
+					 &class_device_attr_info);
+		class_device_create_file(&socket[i].socket.dev,
+					 &class_device_attr_exca);
+#endif
+	}
+
+	/* Finally, schedule a polling interrupt */
+	if (poll_interval != 0) {
+		poll_timer.function = pcc_interrupt_wrapper;
+		poll_timer.data = 0;
+		init_timer(&poll_timer);
+		poll_timer.expires = jiffies + poll_interval;
+		add_timer(&poll_timer);
+	}
+
+	return 0;
+} /* init_m32r_pcc */
+
+static void __exit exit_m32r_pcc(void)
+{
+	int i;
+
+	for (i = 0; i < pcc_sockets; i++)
+		pcmcia_unregister_socket(&socket[i].socket);
+
+	platform_device_unregister(&pcc_device);
+	if (poll_interval != 0)
+		del_timer_sync(&poll_timer);
+
+	driver_unregister(&pcc_driver);
+} /* exit_m32r_pcc */
+
+module_init(init_m32r_pcc);
+module_exit(exit_m32r_pcc);
+MODULE_LICENSE("Dual MPL/GPL");
+/*====================================================================*/
diff -ruNp a/drivers/pcmcia/m32r_pcc.h b/drivers/pcmcia/m32r_pcc.h
--- a/drivers/pcmcia/m32r_pcc.h	1970-01-01 09:00:00.000000000 +0900
+++ b/drivers/pcmcia/m32r_pcc.h	2004-10-05 21:15:44.000000000 +0900
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 2001 by Hiroyuki Kondo
+ */
+
+#define M32R_MAX_PCC	2
+
+/*
+ * M32R PC Card Controler
+ */
+#define M32R_PCC0_BASE        0x00ef7000
+#define M32R_PCC1_BASE        0x00ef7020
+
+/*
+ * Register offsets
+ */
+#define PCCR            0x00
+#define PCADR           0x04
+#define PCMOD           0x08
+#define PCIRC           0x0c
+#define PCCSIGCR        0x10
+#define PCATCR          0x14
+
+/*
+ * PCCR
+ */
+#define PCCR_PCEN       (1UL<<(31-31))
+
+/*
+ * PCIRC
+ */
+#define PCIRC_BWERR     (1UL<<(31-7))
+#define PCIRC_CDIN1     (1UL<<(31-14))
+#define PCIRC_CDIN2     (1UL<<(31-15))
+#define PCIRC_BEIEN     (1UL<<(31-23))
+#define PCIRC_CIIEN     (1UL<<(31-30))
+#define PCIRC_COIEN     (1UL<<(31-31))
+
+/*
+ * PCCSIGCR
+ */
+#define PCCSIGCR_SEN    (1UL<<(31-3))
+#define PCCSIGCR_VEN    (1UL<<(31-7))
+#define PCCSIGCR_CRST   (1UL<<(31-15))
+#define PCCSIGCR_COCR   (1UL<<(31-31))
+
+/*
+ *
+ */
+#define PCMOD_AS_ATTRIB	(1UL<<(31-19))
+#define PCMOD_AS_IO	(1UL<<(31-18))
+
+#define PCMOD_CBSZ	(1UL<<(31-23)) /* set for 8bit */
+
+#define PCMOD_DBEX	(1UL<<(31-31)) /* set for excahnge */
+
+/*
+ * M32R PCC Map addr
+ */
+#define M32R_PCC0_MAPBASE        0x14000000
+#define M32R_PCC1_MAPBASE        0x16000000
+
+#define M32R_PCC_MAPMAX		 0x02000000
+
+#define M32R_PCC_MAPSIZE	 0x00001000 /* XXX */
+#define M32R_PCC_MAPMASK     	(~(M32R_PCC_MAPMAX-1))

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
