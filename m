Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUIPCLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUIPCLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUIPCLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:11:35 -0400
Received: from mail.renesas.com ([202.234.163.13]:51380 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S265943AbUIPCKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:10:16 -0400
Date: Thu, 16 Sep 2004 11:09:29 +0900 (JST)
Message-Id: <20040916.110929.424265408.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm5 2/3] [m32r] Modify drivers/net/smc91x.c for
 m32r
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20040916.110622.640922499.takata.hirokazu@renesas.com>
References: <20040916.110622.640922499.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.9-rc1-mm5 2/3] [m32r] Modify drivers/net/smc91x.c for m32r
  This patch updates drivers/net/smc91x.c and merges m32r support to it.
  - Add m32r support.
  - Modify for SMP kernel.

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/io_mappi2.c      |   23 +++++++++++++----------
 arch/m32r/kernel/setup_m32700ut.c |   34 ++++++++++++++++++++++++++++++++--
 arch/m32r/kernel/setup_mappi2.c   |   34 ++++++++++++++++++++++++++++++++--
 arch/m32r/kernel/setup_opsput.c   |   34 ++++++++++++++++++++++++++++++++--
 drivers/net/Kconfig               |    2 +-
 drivers/net/smc91x.c              |   29 +++++++++++++++++++----------
 drivers/net/smc91x.h              |   13 +++++++++++++
 7 files changed, 142 insertions(+), 27 deletions(-)


diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/io_mappi2.c linux-2.6.9-rc1-mm5/arch/m32r/kernel/io_mappi2.c
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/io_mappi2.c	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/kernel/io_mappi2.c	2004-09-14 16:23:03.000000000 +0900
@@ -36,6 +36,9 @@ static __inline__ void *_port2addr(unsig
 {
 	return (void *)(port + NONCACHE_OFFSET);
 }
+
+#define LAN_IOSTART	0x300
+#define LAN_IOEND	0x320
 #ifdef CONFIG_CHIP_OPSP
 static __inline__ void *_port2addr_ne(unsigned long port)
 {
@@ -98,7 +101,7 @@ static __inline__ void _ne_outw(unsigned
 
 unsigned char _inb(unsigned long port)
 {
-	if (port >= 0x300 && port < 0x320)
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		return _ne_inb(PORT2ADDR_NE(port));
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
@@ -113,7 +116,7 @@ unsigned char _inb(unsigned long port)
 
 unsigned short _inw(unsigned long port)
 {
-	if (port >= 0x300 && port < 0x320)
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		return _ne_inw(PORT2ADDR_NE(port));
 #if defined(CONFIG_USB)
         else if (port >= 0x340 && port < 0x3a0)
@@ -198,7 +201,7 @@ unsigned long _inl_p(unsigned long port)
 
 void _outb(unsigned char b, unsigned long port)
 {
-	if (port >= 0x300 && port < 0x320)
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outb(b, PORT2ADDR_NE(port));
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
@@ -211,7 +214,7 @@ void _outb(unsigned char b, unsigned lon
 
 void _outw(unsigned short w, unsigned long port)
 {
-	if (port >= 0x300 && port < 0x320)
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
 #if defined(CONFIG_USB)
@@ -239,7 +242,7 @@ void _outl(unsigned long l, unsigned lon
 
 void _outb_p(unsigned char b, unsigned long port)
 {
-	if (port >= 0x300 && port < 0x320)
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outb(b, PORT2ADDR_NE(port));
 	else
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
@@ -254,7 +257,7 @@ void _outb_p(unsigned char b, unsigned l
 
 void _outw_p(unsigned short w, unsigned long port)
 {
-	if (port >= 0x300 && port < 0x320)
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
 #if defined(CONFIG_USB)
@@ -280,7 +283,7 @@ void _outl_p(unsigned long l, unsigned l
 
 void _insb(unsigned int port, void * addr, unsigned long count)
 {
-	if (port >= 0x300 && port < 0x320)
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_insb(PORT2ADDR_NE(port), addr, count);
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	  else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
@@ -299,7 +302,7 @@ void _insw(unsigned int port, void * add
 	unsigned short *buf = addr;
 	unsigned short *portp;
 
-	if (port >= 0x300 && port < 0x320) {
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		portp = PORT2ADDR_NE(port);
 		while (count--) *buf++ = *(volatile unsigned short *)portp;
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
@@ -326,7 +329,7 @@ void _outsb(unsigned int port, const voi
 	const unsigned char *buf = addr;
 	unsigned char *portp;
 
-	if (port >= 0x300 && port < 0x320) {
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		portp = PORT2ADDR_NE(port);
 		while (count--) _ne_outb(*buf++, portp);
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
@@ -344,7 +347,7 @@ void _outsw(unsigned int port, const voi
 	const unsigned short *buf = addr;
 	unsigned short *portp;
 
-	if (port >= 0x300 && port < 0x320) {
+	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		portp = PORT2ADDR_NE(port);
 		while (count--) *(volatile unsigned short *)portp = *buf++;
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/setup_m32700ut.c linux-2.6.9-rc1-mm5/arch/m32r/kernel/setup_m32700ut.c
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/setup_m32700ut.c	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/kernel/setup_m32700ut.c	2004-09-14 16:23:03.000000000 +0900
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/device.h>
 
 #include <asm/system.h>
 #include <asm/m32r.h>
@@ -305,7 +306,7 @@ static struct hw_interrupt_type m32700ut
 
 void __init init_IRQ(void)
 {
-#ifdef CONFIG_M32R_SMC91111
+#if defined(CONFIG_SMC91X)
 	/* INT#0: LAN controller on M32700UT-LAN (SMC91C111)*/
 	irq_desc[M32700UT_LAN_IRQ_LAN].status = IRQ_DISABLED;
 	irq_desc[M32700UT_LAN_IRQ_LAN].handler = &m32700ut_lanpld_irq_type;
@@ -313,7 +314,7 @@ void __init init_IRQ(void)
 	irq_desc[M32700UT_LAN_IRQ_LAN].depth = 1;	/* disable nested irq */
 	lanpld_icu_data[irq2lanpldirq(M32700UT_LAN_IRQ_LAN)].icucr = PLD_ICUCR_IEN|PLD_ICUCR_ISMOD02;	/* "H" edge sense */
 	disable_m32700ut_lanpld_irq(M32700UT_LAN_IRQ_LAN);
-#endif  /* CONFIG_M32R_SMC91111 */
+#endif  /* CONFIG_SMC91X */
 
 	/* MFT2 : system timer */
 	irq_desc[M32R_IRQ_MFT2].status = IRQ_DISABLED;
@@ -448,3 +449,32 @@ void __init init_IRQ(void)
 	disable_m32700ut_irq(M32R_IRQ_INT3);
 //#endif	/* CONFIG_M32R_ARV */
 }
+
+#define LAN_IOSTART     0x300
+#define LAN_IOEND       0x320
+static struct resource smc91x_resources[] = {
+	[0] = {
+		.start  = (LAN_IOSTART),
+		.end    = (LAN_IOEND),
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = M32700UT_LAN_IRQ_LAN,
+		.end    = M32700UT_LAN_IRQ_LAN,
+		.flags  = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources  = ARRAY_SIZE(smc91x_resources),
+	.resource       = smc91x_resources,
+};
+
+static int __init platform_init(void)
+{
+	platform_device_register(&smc91x_device);
+	return 0;
+}
+arch_initcall(platform_init);
diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/setup_mappi2.c linux-2.6.9-rc1-mm5/arch/m32r/kernel/setup_mappi2.c
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/setup_mappi2.c	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/kernel/setup_mappi2.c	2004-09-14 16:23:03.000000000 +0900
@@ -15,6 +15,7 @@ static void use_rcsid(void) {rcsid = rcs
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/device.h>
 
 #include <asm/system.h>
 #include <asm/m32r.h>
@@ -93,7 +94,7 @@ static struct hw_interrupt_type mappi2_i
 
 void __init init_IRQ(void)
 {
-#ifdef CONFIG_M32R_SMC91111
+#if defined(CONFIG_SMC91X)
 	/* INT0 : LAN controller (SMC91111) */
 	irq_desc[M32R_IRQ_INT0].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_INT0].handler = &mappi2_irq_type;
@@ -101,7 +102,7 @@ void __init init_IRQ(void)
 	irq_desc[M32R_IRQ_INT0].depth = 1;
 	icu_data[M32R_IRQ_INT0].icucr = M32R_ICUCR_IEN|M32R_ICUCR_ISMOD10;
 	disable_mappi2_irq(M32R_IRQ_INT0);
-#endif  /* CONFIG_MAPPI2_SMC9111 */
+#endif  /* CONFIG_SMC91X */
 
 	/* MFT2 : system timer */
 	irq_desc[M32R_IRQ_MFT2].status = IRQ_DISABLED;
@@ -184,3 +185,32 @@ void __init init_IRQ(void)
 
 #endif /* CONFIG_MAPPI2_CFC */
 }
+
+#define LAN_IOSTART     0x300
+#define LAN_IOEND       0x320
+static struct resource smc91x_resources[] = {
+	[0] = {
+		.start  = (LAN_IOSTART),
+		.end    = (LAN_IOEND),
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = M32R_IRQ_INT0,
+		.end    = M32R_IRQ_INT0,
+		.flags  = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources  = ARRAY_SIZE(smc91x_resources),
+	.resource       = smc91x_resources,
+};
+
+static int __init platform_init(void)
+{
+	platform_device_register(&smc91x_device);
+	return 0;
+}
+arch_initcall(platform_init);
diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/setup_opsput.c linux-2.6.9-rc1-mm5/arch/m32r/kernel/setup_opsput.c
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/setup_opsput.c	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/kernel/setup_opsput.c	2004-09-14 16:23:03.000000000 +0900
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/device.h>
 
 #include <asm/system.h>
 #include <asm/m32r.h>
@@ -306,7 +307,7 @@ static struct hw_interrupt_type opsput_l
 
 void __init init_IRQ(void)
 {
-#ifdef CONFIG_M32R_SMC91111
+#if defined(CONFIG_SMC91X)
 	/* INT#0: LAN controller on OPSPUT-LAN (SMC91C111)*/
 	irq_desc[OPSPUT_LAN_IRQ_LAN].status = IRQ_DISABLED;
 	irq_desc[OPSPUT_LAN_IRQ_LAN].handler = &opsput_lanpld_irq_type;
@@ -314,7 +315,7 @@ void __init init_IRQ(void)
 	irq_desc[OPSPUT_LAN_IRQ_LAN].depth = 1;	/* disable nested irq */
 	lanpld_icu_data[irq2lanpldirq(OPSPUT_LAN_IRQ_LAN)].icucr = PLD_ICUCR_IEN|PLD_ICUCR_ISMOD02;	/* "H" edge sense */
 	disable_opsput_lanpld_irq(OPSPUT_LAN_IRQ_LAN);
-#endif  /* CONFIG_M32R_SMC91111 */
+#endif  /* CONFIG_SMC91X */
 
 	/* MFT2 : system timer */
 	irq_desc[M32R_IRQ_MFT2].status = IRQ_DISABLED;
@@ -452,3 +453,32 @@ void __init init_IRQ(void)
 	disable_opsput_irq(M32R_IRQ_INT3);
 //#endif	/* CONFIG_M32R_ARV */
 }
+
+#define LAN_IOSTART     0x300
+#define LAN_IOEND       0x320
+static struct resource smc91x_resources[] = {
+	[0] = {
+		.start  = (LAN_IOSTART),
+		.end    = (LAN_IOEND),
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = OPSPUT_LAN_IRQ_LAN,
+		.end    = OPSPUT_LAN_IRQ_LAN,
+		.flags  = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources  = ARRAY_SIZE(smc91x_resources),
+	.resource       = smc91x_resources,
+};
+
+static int __init platform_init(void)
+{
+	platform_device_register(&smc91x_device);
+	return 0;
+}
+arch_initcall(platform_init);
diff -ruNp linux-2.6.9-rc1-mm5.orig/drivers/net/Kconfig linux-2.6.9-rc1-mm5/drivers/net/Kconfig
--- linux-2.6.9-rc1-mm5.orig/drivers/net/Kconfig	2004-09-13 21:44:19.000000000 +0900
+++ linux-2.6.9-rc1-mm5/drivers/net/Kconfig	2004-09-14 16:24:33.000000000 +0900
@@ -817,7 +817,7 @@ config SMC91X
 	tristate "SMC 91C9x/91C1xxx support"
 	select CRC32
 	select MII
-	depends on NET_ETHERNET && (ARM || REDWOOD_5 || REDWOOD_6)
+	depends on NET_ETHERNET && (ARM || REDWOOD_5 || REDWOOD_6 || M32R)
 	help
 	  This is a driver for SMC's 91x series of Ethernet chipsets,
 	  including the SMC91C94 and the SMC91C111. Say Y if you want it
diff -ruNp linux-2.6.9-rc1-mm5.orig/drivers/net/smc91x.c linux-2.6.9-rc1-mm5/drivers/net/smc91x.c
--- linux-2.6.9-rc1-mm5.orig/drivers/net/smc91x.c	2004-09-13 21:44:19.000000000 +0900
+++ linux-2.6.9-rc1-mm5/drivers/net/smc91x.c	2004-09-16 10:10:02.000000000 +0900
@@ -55,6 +55,9 @@
  *                                  smc_phy_configure
  *                                - clean up (and fix stack overrun) in PHY
  *                                  MII read/write functions
+ *   09/15/04  Hayato Fujiwara    - Add m32r support.
+ *                                - Modify for SMP kernel; Change spin-locked
+ *                                  regions.
  */
 static const char version[] =
 	"smc91x.c: v1.0, mar 07 2003 by Nicolas Pitre <nico@cam.org>\n";
@@ -256,24 +259,18 @@ static void PRINT_PKT(u_char *buf, int l
 
 /* this enables an interrupt in the interrupt mask register */
 #define SMC_ENABLE_INT(x) do {						\
-	unsigned long flags;						\
 	unsigned char mask;						\
-	spin_lock_irqsave(&lp->lock, flags);				\
 	mask = SMC_GET_INT_MASK();					\
 	mask |= (x);							\
 	SMC_SET_INT_MASK(mask);						\
-	spin_unlock_irqrestore(&lp->lock, flags);			\
 } while (0)
 
 /* this disables an interrupt from the interrupt mask register */
 #define SMC_DISABLE_INT(x) do {						\
-	unsigned long flags;						\
 	unsigned char mask;						\
-	spin_lock_irqsave(&lp->lock, flags);				\
 	mask = SMC_GET_INT_MASK();					\
 	mask &= ~(x);							\
 	SMC_SET_INT_MASK(mask);						\
-	spin_unlock_irqrestore(&lp->lock, flags);			\
 } while (0)
 
 /*
@@ -580,9 +577,12 @@ static int smc_hard_start_xmit(struct sk
 	struct smc_local *lp = netdev_priv(dev);
 	unsigned long ioaddr = dev->base_addr;
 	unsigned int numPages, poll_count, status, saved_bank;
+	unsigned long flags;
 
 	DBG(3, "%s: %s\n", dev->name, __FUNCTION__);
 
+	spin_lock_irqsave(&lp->lock, flags);
+
 	BUG_ON(lp->saved_skb != NULL);
 	lp->saved_skb = skb;
 
@@ -604,6 +604,7 @@ static int smc_hard_start_xmit(struct sk
 		lp->stats.tx_errors++;
 		lp->stats.tx_dropped++;
 		dev_kfree_skb(skb);
+		spin_unlock_irqrestore(&lp->lock, flags);
 		return 0;
 	}
 
@@ -652,6 +653,7 @@ static int smc_hard_start_xmit(struct sk
 	}
 
 	SMC_SELECT_BANK(saved_bank);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	return 0;
 }
 
@@ -1166,6 +1168,8 @@ static irqreturn_t smc_interrupt(int irq
 
 	DBG(3, "%s: %s\n", dev->name, __FUNCTION__);
 
+	spin_lock(&lp->lock);
+
 	saved_bank = SMC_CURRENT_BANK();
 	SMC_SELECT_BANK(2);
 	saved_pointer = SMC_GET_PTR();
@@ -1189,8 +1193,6 @@ static irqreturn_t smc_interrupt(int irq
 		if (!status)
 			break;
 
-		spin_lock(&lp->lock);
-
 		if (status & IM_RCV_INT) {
 			DBG(3, "%s: RX irq\n", dev->name);
 			smc_rcv(dev);
@@ -1239,7 +1241,6 @@ static irqreturn_t smc_interrupt(int irq
 			PRINTK("%s: UNSUPPORTED: ERCV INTERRUPT \n", dev->name);
 		}
 
-		spin_unlock(&lp->lock);
 	} while (--timeout);
 
 	/* restore register states */
@@ -1249,6 +1250,7 @@ static irqreturn_t smc_interrupt(int irq
 
 	DBG(3, "%s: Interrupt done (%d loops)\n", dev->name, 8-timeout);
 
+	spin_unlock(&lp->lock);
 	/*
 	 * We return IRQ_HANDLED unconditionally here even if there was
 	 * nothing to do.  There is a possibility that a packet might
@@ -1264,7 +1266,9 @@ static irqreturn_t smc_interrupt(int irq
 static void smc_timeout(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
+	unsigned long flags;
 
+	spin_lock_irqsave(&lp->lock, flags);
 	DBG(2, "%s: %s\n", dev->name, __FUNCTION__);
 
 	smc_reset(dev);
@@ -1298,6 +1302,9 @@ static void smc_timeout(struct net_devic
 	}
 	/* We can accept TX packets again */
 	dev->trans_start = jiffies;
+
+	spin_unlock_irqrestore(&lp->lock, flags);
+
 	netif_wake_queue(dev);
 }
 
@@ -1438,7 +1445,7 @@ smc_open(struct net_device *dev)
 	 * address using ifconfig eth0 hw ether xx:xx:xx:xx:xx:xx
 	 */
 	if (!is_valid_ether_addr(dev->dev_addr)) {
-		DBG(2, (KERN_DEBUG "smc_open: no valid ethernet hw addr\n"));
+		DBG(2, "smc_open: no valid ethernet hw addr\n");
 		return -EINVAL;
 	}
 
@@ -1878,7 +1885,9 @@ static int __init smc_probe(struct net_d
       	if (retval)
       		goto err_out;
 
+#if !defined(__m32r__)
 	set_irq_type(dev->irq, IRQT_RISING);
+#endif
 #ifdef SMC_USE_PXA_DMA
 	{
 		int dma = pxa_request_dma(dev->name, DMA_PRIO_LOW,
diff -ruNp linux-2.6.9-rc1-mm5.orig/drivers/net/smc91x.h linux-2.6.9-rc1-mm5/drivers/net/smc91x.h
--- linux-2.6.9-rc1-mm5.orig/drivers/net/smc91x.h	2004-09-13 21:44:19.000000000 +0900
+++ linux-2.6.9-rc1-mm5/drivers/net/smc91x.h	2004-09-14 16:23:03.000000000 +0900
@@ -203,6 +203,19 @@ static inline void SMC_outsw (unsigned l
 #define RPC_LSA_DEFAULT		RPC_LED_TX_RX
 #define RPC_LSB_DEFAULT		RPC_LED_100_10
 
+#elif   defined(CONFIG_M32R)
+
+#define SMC_CAN_USE_8BIT	0
+#define SMC_CAN_USE_16BIT	1
+#define SMC_CAN_USE_32BIT	0
+
+#define SMC_inb(a, r)		inb((a) + (r) - 0xa0000000)
+#define SMC_inw(a, r)		inw((a) + (r) - 0xa0000000)
+#define SMC_outb(v, a, r)	outb(v, (a) + (r) - 0xa0000000)
+#define SMC_outw(v, a, r)	outw(v, (a) + (r) - 0xa0000000)
+#define SMC_insw(a, r, p, l)	insw((a) + (r) - 0xa0000000, p, l)
+#define SMC_outsw(a, r, p, l)	outsw((a) + (r) - 0xa0000000, p, l)
+
 #else
 
 #define SMC_CAN_USE_8BIT	1

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
