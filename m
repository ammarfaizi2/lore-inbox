Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVBQOva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVBQOva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVBQOvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:51:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5637 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262156AbVBQOs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:48:29 -0500
Date: Thu, 17 Feb 2005 15:48:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill include/linux/eeprom.h
Message-ID: <20050217144825.GJ24808@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch kills include/linux/eeprom.h .

Rationale:
- it's only used by one single driver
- most of this file are non-inline and non-static functions (sic)

This patch moves all required contents of this file into ns83820.c and 
removes include/linux/eeprom.h (and makes setup_ee_mem_bitbanger 
static).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/ns83820.c  |   49 +++++++++++++-
 include/linux/eeprom.h |  136 -----------------------------------------
 2 files changed, 44 insertions(+), 141 deletions(-)

--- linux-2.6.11-rc3-mm2-full/include/linux/eeprom.h	2004-12-24 22:33:49.000000000 +0100
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,136 +0,0 @@
-/* credit winbond-840.c
- */
-#include <asm/io.h>
-struct eeprom_ops {
-	void	(*set_cs)(void *ee);
-	void	(*clear_cs)(void *ee);
-};
-
-#define EEPOL_EEDI	0x01
-#define EEPOL_EEDO	0x02
-#define EEPOL_EECLK	0x04
-#define EEPOL_EESEL	0x08
-
-struct eeprom {
-	void *dev;
-	struct eeprom_ops *ops;
-
-	void __iomem *	addr;
-
-	unsigned	ee_addr_bits;
-
-	unsigned	eesel;
-	unsigned	eeclk;
-	unsigned	eedo;
-	unsigned	eedi;
-	unsigned	polarity;
-	unsigned	ee_state;
-
-	spinlock_t	*lock;
-	u32		*cache;
-};
-
-
-u8   eeprom_readb(struct eeprom *ee, unsigned address);
-void eeprom_read(struct eeprom *ee, unsigned address, u8 *bytes,
-		unsigned count);
-void eeprom_writeb(struct eeprom *ee, unsigned address, u8 data);
-void eeprom_write(struct eeprom *ee, unsigned address, u8 *bytes,
-		unsigned count);
-
-/* The EEPROM commands include the alway-set leading bit. */
-enum EEPROM_Cmds {
-        EE_WriteCmd=(5 << 6), EE_ReadCmd=(6 << 6), EE_EraseCmd=(7 << 6),
-};
-
-void setup_ee_mem_bitbanger(struct eeprom *ee, void __iomem *memaddr, int eesel_bit, int eeclk_bit, int eedo_bit, int eedi_bit, unsigned polarity)
-{
-	ee->addr = memaddr;
-	ee->eesel = 1 << eesel_bit;
-	ee->eeclk = 1 << eeclk_bit;
-	ee->eedo = 1 << eedo_bit;
-	ee->eedi = 1 << eedi_bit;
-
-	ee->polarity = polarity;
-
-	*ee->cache = readl(ee->addr);
-}
-
-/* foo. put this in a .c file */
-static inline void eeprom_update(struct eeprom *ee, u32 mask, int pol)
-{
-	unsigned long flags;
-	u32 data;
-
-	spin_lock_irqsave(ee->lock, flags);
-	data = *ee->cache;
-
-	data &= ~mask;
-	if (pol)
-		data |= mask;
-
-	*ee->cache = data;
-//printk("update: %08x\n", data);
-	writel(data, ee->addr);
-	spin_unlock_irqrestore(ee->lock, flags);
-}
-
-void eeprom_clk_lo(struct eeprom *ee)
-{
-	int pol = !!(ee->polarity & EEPOL_EECLK);
-
-	eeprom_update(ee, ee->eeclk, pol);
-	udelay(2);
-}
-
-void eeprom_clk_hi(struct eeprom *ee)
-{
-	int pol = !!(ee->polarity & EEPOL_EECLK);
-
-	eeprom_update(ee, ee->eeclk, !pol);
-	udelay(2);
-}
-
-void eeprom_send_addr(struct eeprom *ee, unsigned address)
-{
-	int pol = !!(ee->polarity & EEPOL_EEDI);
-	unsigned i;
-	address |= 6 << 6;
-
-        /* Shift the read command bits out. */
-        for (i=0; i<11; i++) {
-		eeprom_update(ee, ee->eedi, ((address >> 10) & 1) ^ pol);
-		address <<= 1;
-		eeprom_clk_hi(ee);
-		eeprom_clk_lo(ee);
-        }
-	eeprom_update(ee, ee->eedi, pol);
-}
-
-u16   eeprom_readw(struct eeprom *ee, unsigned address)
-{
-	unsigned i;
-	u16	res = 0;
-
-	eeprom_clk_lo(ee);
-	eeprom_update(ee, ee->eesel, 1 ^ !!(ee->polarity & EEPOL_EESEL));
-	eeprom_send_addr(ee, address);
-
-	for (i=0; i<16; i++) {
-		u32 data;
-		eeprom_clk_hi(ee);
-		res <<= 1;
-		data = readl(ee->addr);
-//printk("eeprom_readw: %08x\n", data);
-		res |= !!(data & ee->eedo) ^ !!(ee->polarity & EEPOL_EEDO);
-		eeprom_clk_lo(ee);
-	}
-	eeprom_update(ee, ee->eesel, 0 ^ !!(ee->polarity & EEPOL_EESEL));
-
-	return res;
-}
-
-
-void eeprom_writeb(struct eeprom *ee, unsigned address, u8 data)
-{
-}
--- linux-2.6.11-rc3-mm2-full/drivers/net/ns83820.c.old	2005-02-16 17:52:43.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/ns83820.c	2005-02-16 18:05:26.000000000 +0100
@@ -107,7 +107,6 @@
 #include <linux/init.h>
 #include <linux/ip.h>	/* for iph */
 #include <linux/in.h>	/* for IPPROTO_... */
-#include <linux/eeprom.h>
 #include <linux/compiler.h>
 #include <linux/prefetch.h>
 #include <linux/ethtool.h>
@@ -422,6 +421,35 @@
 
 #define DESC_SIZE	8		/* Should be cache line sized */
 
+struct eeprom_ops {
+	void	(*set_cs)(void *ee);
+	void	(*clear_cs)(void *ee);
+};
+
+#define EEPOL_EEDI	0x01
+#define EEPOL_EEDO	0x02
+#define EEPOL_EECLK	0x04
+#define EEPOL_EESEL	0x08
+
+struct eeprom {
+	void *dev;
+	struct eeprom_ops *ops;
+
+	void __iomem *	addr;
+
+	unsigned	ee_addr_bits;
+
+	unsigned	eesel;
+	unsigned	eeclk;
+	unsigned	eedo;
+	unsigned	eedi;
+	unsigned	polarity;
+	unsigned	ee_state;
+
+	spinlock_t	*lock;
+	u32		*cache;
+};
+
 struct rx_info {
 	spinlock_t	lock;
 	int		up;
@@ -481,6 +509,21 @@
 	struct timer_list	tx_watchdog;
 };
 
+static void setup_ee_mem_bitbanger(struct eeprom *ee, void __iomem *memaddr,
+				   int eesel_bit, int eeclk_bit, int eedo_bit,
+				   int eedi_bit, unsigned polarity)
+{
+	ee->addr = memaddr;
+	ee->eesel = 1 << eesel_bit;
+	ee->eeclk = 1 << eeclk_bit;
+	ee->eedo = 1 << eedo_bit;
+	ee->eedi = 1 << eedi_bit;
+
+	ee->polarity = polarity;
+
+	*ee->cache = readl(ee->addr);
+}
+
 static inline struct ns83820 *PRIV(struct net_device *dev)
 {
 	return netdev_priv(dev);
@@ -1568,15 +1611,11 @@
 	unsigned i;
 	for (i=0; i<3; i++) {
 		u32 data;
-#if 0	/* I've left this in as an example of how to use eeprom.h */
-		data = eeprom_readw(&dev->ee, 0xa + 2 - i);
-#else
 		/* Read from the perfect match memory: this is loaded by
 		 * the chip from the EEPROM via the EELOAD self test.
 		 */
 		writel(i*2, dev->base + RFCR);
 		data = readl(dev->base + RFDR);
-#endif
 		*mac++ = data;
 		*mac++ = data >> 8;
 	}

