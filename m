Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUIPCOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUIPCOB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUIPCL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:11:59 -0400
Received: from mail.renesas.com ([202.234.163.13]:56529 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S266009AbUIPCKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:10:31 -0400
Date: Thu, 16 Sep 2004 11:09:35 +0900 (JST)
Message-Id: <20040916.110935.719912603.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm5 3/3] [m32r] Modify drivers/net/ne.c for m32r
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
In-Reply-To: <20040916.110622.640922499.takata.hirokazu@renesas.com>
References: <20040916.110622.640922499.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.9-rc1-mm5 3/3] [m32r] Modify drivers/net/ne.c for m32r
  This patch updates drivers/net/ne.c and merges m32r support to it.
  - Add m32r support.

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/setup_mappi.c   |    2 +-
 arch/m32r/kernel/setup_oaks32r.c |    2 +-
 drivers/net/8390.c               |   10 ++++++++++
 drivers/net/Kconfig              |    2 +-
 drivers/net/ne.c                 |   30 +++++++++++++++++++++++++++++-
 5 files changed, 42 insertions(+), 4 deletions(-)


diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/setup_mappi.c linux-2.6.9-rc1-mm5/arch/m32r/kernel/setup_mappi.c
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/setup_mappi.c	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/kernel/setup_mappi.c	2004-09-14 16:24:33.000000000 +0900
@@ -92,7 +92,7 @@ void __init init_IRQ(void)
 	else
 		once++;
 
-#ifdef CONFIG_M32R_NE2000
+#ifdef CONFIG_NE2000
 	/* INT0 : LAN controller (RTL8019AS) */
 	irq_desc[M32R_IRQ_INT0].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_INT0].handler = &mappi_irq_type;
diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/setup_oaks32r.c linux-2.6.9-rc1-mm5/arch/m32r/kernel/setup_oaks32r.c
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/setup_oaks32r.c	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/kernel/setup_oaks32r.c	2004-09-14 16:24:33.000000000 +0900
@@ -92,7 +92,7 @@ void __init init_IRQ(void)
 	else
 		once++;
 
-#ifdef CONFIG_M32R_NE2000
+#ifdef CONFIG_NE2000
 	/* INT3 : LAN controller (RTL8019AS) */
 	irq_desc[M32R_IRQ_INT3].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_INT3].handler = &oaks32r_irq_type;
diff -ruNp linux-2.6.9-rc1-mm5.orig/drivers/net/Kconfig linux-2.6.9-rc1-mm5/drivers/net/Kconfig
--- linux-2.6.9-rc1-mm5.orig/drivers/net/Kconfig	2004-09-13 21:44:19.000000000 +0900
+++ linux-2.6.9-rc1-mm5/drivers/net/Kconfig	2004-09-14 16:24:33.000000000 +0900
@@ -1075,7 +1075,7 @@ config ETH16I
 
 config NE2000
 	tristate "NE2000/NE1000 support"
-	depends on NET_ISA || (Q40 && m)
+	depends on NET_ISA || (Q40 && m) || M32R
 	select CRC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y and read
diff -ruNp linux-2.6.9-rc1-mm5.orig/drivers/net/8390.c linux-2.6.9-rc1-mm5/drivers/net/8390.c
--- linux-2.6.9-rc1-mm5.orig/drivers/net/8390.c	2004-09-13 21:42:30.000000000 +0900
+++ linux-2.6.9-rc1-mm5/drivers/net/8390.c	2004-09-16 10:11:16.000000000 +0900
@@ -42,6 +42,7 @@
   Alan Cox		: Spinlocking work, added 'BUG_83C690'
   Paul Gortmaker	: Separate out Tx timeout code from Tx path.
   Paul Gortmaker	: Remove old unused single Tx buffer code.
+  Hayato Fujiwara	: Add m32r support.
 
   Sources:
   The National Semiconductor LAN Databook, and the 3Com 3c503 databook.
@@ -219,6 +220,15 @@ void ei_tx_timeout(struct net_device *de
 	int txsr, isr, tickssofar = jiffies - dev->trans_start;
 	unsigned long flags;
 
+#if defined(CONFIG_M32R) && defined(CONFIG_SMP)
+	unsigned long icucr;
+
+	local_irq_save(flags);
+	icucr = inl(ICUCR1);
+	icucr |= M32R_ICUCR_ISMOD11;
+	outl(icucr, ICUCR1);
+	local_irq_restore(flags);
+#endif
 	ei_local->stat.tx_errors++;
 
 	spin_lock_irqsave(&ei_local->page_lock, flags);
diff -ruNp linux-2.6.9-rc1-mm5.orig/drivers/net/ne.c linux-2.6.9-rc1-mm5/drivers/net/ne.c
--- linux-2.6.9-rc1-mm5.orig/drivers/net/ne.c	2004-08-14 14:36:57.000000000 +0900
+++ linux-2.6.9-rc1-mm5/drivers/net/ne.c	2004-09-16 10:09:51.000000000 +0900
@@ -29,6 +29,7 @@
     last in cleanup_modue()
     Richard Guenther    : Added support for ISAPnP cards
     Paul Gortmaker	: Discontinued PCI support - use ne2k-pci.c instead.
+    Hayato Fujiwara	: Add m32r support.
 
 */
 
@@ -128,6 +129,14 @@ bad_clone_list[] __initdata = {
 #define NESM_START_PG	0x40	/* First page of TX buffer */
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
 
+#ifdef CONFIG_PLAT_MAPPI
+#  define DCR_VAL 0x4b
+#elif CONFIG_PLAT_OAKS32R
+#  define DCR_VAL 0x48
+#else
+#  define DCR_VAL 0x49
+#endif
+
 static int ne_probe1(struct net_device *dev, int ioaddr);
 static int ne_probe_isapnp(struct net_device *dev);
 
@@ -387,7 +396,7 @@ static int __init ne_probe1(struct net_d
 		for (i = 0; i < 16; i++)
 			SA_prom[i] = SA_prom[i+i];
 		/* We must set the 8390 for word mode. */
-		outb_p(0x49, ioaddr + EN0_DCFG);
+		outb_p(DCR_VAL, ioaddr + EN0_DCFG);
 		start_page = NESM_START_PG;
 		stop_page = NESM_STOP_PG;
 	} else {
@@ -395,7 +404,12 @@ static int __init ne_probe1(struct net_d
 		stop_page = NE1SM_STOP_PG;
 	}
 
+#if  defined(CONFIG_PLAT_MAPPI) || defined(CONFIG_PLAT_OAKS32R)
+	neX000 = ((SA_prom[14] == 0x57  &&  SA_prom[15] == 0x57) 
+		|| (SA_prom[14] == 0x42 && SA_prom[15] == 0x42));
+#else
 	neX000 = (SA_prom[14] == 0x57  &&  SA_prom[15] == 0x57);
+#endif
 	ctron =  (SA_prom[0] == 0x00 && SA_prom[1] == 0x00 && SA_prom[2] == 0x1d);
 	copam =  (SA_prom[14] == 0x49 && SA_prom[15] == 0x00);
 
@@ -476,10 +490,20 @@ static int __init ne_probe1(struct net_d
 
 	dev->base_addr = ioaddr;
 
+#ifdef CONFIG_PLAT_MAPPI
+	outb_p(E8390_NODMA + E8390_PAGE1 + E8390_STOP, 
+		ioaddr + E8390_CMD); /* 0x61 */
+	for (i = 0 ; i < ETHER_ADDR_LEN ; i++) {
+		dev->dev_addr[i] = SA_prom[i] 
+			= inb_p(ioaddr + EN1_PHYS_SHIFT(i));
+		printk(" %2.2x", SA_prom[i]);
+	}
+#else
 	for(i = 0; i < ETHER_ADDR_LEN; i++) {
 		printk(" %2.2x", SA_prom[i]);
 		dev->dev_addr[i] = SA_prom[i];
 	}
+#endif
 
 	printk("\n%s: %s found at %#x, using IRQ %d.\n",
 		dev->name, name, ioaddr, dev->irq);
@@ -487,7 +511,11 @@ static int __init ne_probe1(struct net_d
 	ei_status.name = name;
 	ei_status.tx_start_page = start_page;
 	ei_status.stop_page = stop_page;
+#ifdef CONFIG_PLAT_OAKS32R
+	ei_status.word16 = 0;
+#else
 	ei_status.word16 = (wordlength == 2);
+#endif
 
 	ei_status.rx_start_page = start_page + TX_PAGES;
 #ifdef PACKETBUF_MEMSIZE

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
