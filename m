Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVKETBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVKETBu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 14:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVKETBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 14:01:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59914 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932203AbVKETBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 14:01:49 -0500
Date: Sat, 5 Nov 2005 20:01:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill include/linux/eeprom.h
Message-ID: <20051105190147.GA4493@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch kills include/linux/eeprom.h .

Rationale:
- it was only used by one single driver
- even this driver didn't do anything useful with it
- most of this file are non-inline and non-static functions (sic)

This removes include/linux/eeprom.h and cleans drivers/net/ns83820.c up.


If you think eeprom.h should be used more extensively, please consider:
- the code has to be moved from the header file to a .c file
- the currently empty write function has to be implemented
- ns83820.c or any other driver should actually use it

Noone did any of these during the more than 3 years eeprom.h already
exists...


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/ns83820.c  |   13 ---
 include/linux/eeprom.h |  136 -----------------------------------------
 2 files changed, 2 insertions(+), 147 deletions(-)

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


--- linux-2.6.14-rc5-mm1-full/drivers/net/ns83820.c.old	2005-11-05 19:45:57.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/ns83820.c	2005-11-05 19:50:20.000000000 +0100
@@ -110,7 +110,6 @@
 #include <linux/init.h>
 #include <linux/ip.h>	/* for iph */
 #include <linux/in.h>	/* for IPPROTO_... */
-#include <linux/eeprom.h>
 #include <linux/compiler.h>
 #include <linux/prefetch.h>
 #include <linux/ethtool.h>
@@ -445,7 +444,6 @@
 
 	u32			MEAR_cache;
 	u32			IMR_cache;
-	struct eeprom		ee;
 
 	unsigned		linkstate;
 
@@ -1558,15 +1556,13 @@
 	unsigned i;
 	for (i=0; i<3; i++) {
 		u32 data;
-#if 0	/* I've left this in as an example of how to use eeprom.h */
-		data = eeprom_readw(&dev->ee, 0xa + 2 - i);
-#else
+
 		/* Read from the perfect match memory: this is loaded by
 		 * the chip from the EEPROM via the EELOAD self test.
 		 */
 		writel(i*2, dev->base + RFCR);
 		data = readl(dev->base + RFDR);
-#endif
+
 		*mac++ = data;
 		*mac++ = data >> 8;
 	}
@@ -1851,8 +1847,6 @@
 	spin_lock_init(&dev->misc_lock);
 	dev->pci_dev = pci_dev;
 
-	dev->ee.cache = &dev->MEAR_cache;
-	dev->ee.lock = &dev->misc_lock;
 	SET_MODULE_OWNER(ndev);
 	SET_NETDEV_DEV(ndev, &pci_dev->dev);
 
@@ -1887,9 +1881,6 @@
 
 	dev->IMR_cache = 0;
 
-	setup_ee_mem_bitbanger(&dev->ee, dev->base + MEAR, 3, 2, 1, 0,
-		0);
-
 	err = request_irq(pci_dev->irq, ns83820_irq, SA_SHIRQ,
 			  DRV_NAME, ndev);
 	if (err) {
