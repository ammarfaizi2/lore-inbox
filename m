Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425480AbWLHM2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425480AbWLHM2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425483AbWLHM2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:28:49 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:61884 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1425480AbWLHM2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:28:46 -0500
Date: Fri, 8 Dec 2006 13:28:24 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] AVR32 update
Message-ID: <20061208132824.242a7f26@dhcp-252-105.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from the 'for-linus' branch of

	git://www.atmel.no/~hskinnemoen/linux/kernel/avr32.git for-linus

to receive the following updates:

Haavard Skinnemoen (11):
      [AVR32] Portmux API update
      [AVR32] Add macb1 platform_device
      [AVR32] Move ethernet tag parsing to board-specific code
      [AVR32] Remove mii_phy_addr and eth_addr from eth_platform_data
      [AVR32] Remove unused file
      [AVR32] Set flow handler for external interrupts
      [AVR32] Put the chip in "stop" mode when halting the system
      [AVR32] Don't include <asm/delay.h>
      [AVR32] Implement intc_get_pending()
      [AVR32] Pass dev parameter to dma_cache_sync()
      [AVR32] Add missing #include <linux/param.h> to delay.c

 arch/avr32/boards/atstk1000/atstk1002.c    |   76 +++++++-
 arch/avr32/kernel/avr32_ksyms.c            |    2 +-
 arch/avr32/kernel/process.c                |    7 +
 arch/avr32/kernel/setup.c                  |   24 ---
 arch/avr32/lib/delay.c                     |    2 +-
 arch/avr32/mach-at32ap/at32ap7000.c        |  182 ++++++++++--------
 arch/avr32/mach-at32ap/extint.c            |   22 ++-
 arch/avr32/mach-at32ap/intc.c              |    4 +
 arch/avr32/mach-at32ap/pio.c               |   85 ++++++++-
 arch/avr32/mach-at32ap/sm.c                |  289 ----------------------------
 include/asm-avr32/arch-at32ap/at32ap7000.h |   33 ++++
 include/asm-avr32/arch-at32ap/board.h      |    3 -
 include/asm-avr32/arch-at32ap/portmux.h    |   20 ++-
 include/asm-avr32/dma-mapping.h            |   12 +-
 14 files changed, 341 insertions(+), 420 deletions(-)
 delete mode 100644 arch/avr32/mach-at32ap/sm.c
 create mode 100644 include/asm-avr32/arch-at32ap/at32ap7000.h

diff --git a/arch/avr32/boards/atstk1000/atstk1002.c b/arch/avr32/boards/atstk1000/atstk1002.c
index cced73c..32b361f 100644
--- a/arch/avr32/boards/atstk1000/atstk1002.c
+++ b/arch/avr32/boards/atstk1000/atstk1002.c
@@ -7,20 +7,83 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/clk.h>
+#include <linux/etherdevice.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
+#include <asm/io.h>
+#include <asm/setup.h>
 #include <asm/arch/board.h>
 #include <asm/arch/init.h>
 
-struct eth_platform_data __initdata eth0_data = {
-	.valid		= 1,
-	.mii_phy_addr	= 0x10,
-	.is_rmii	= 0,
-	.hw_addr	= { 0x6a, 0x87, 0x71, 0x14, 0xcd, 0xcb },
+struct eth_addr {
+	u8 addr[6];
 };
 
+static struct eth_addr __initdata hw_addr[2];
+
+static struct eth_platform_data __initdata eth_data[2];
 extern struct lcdc_platform_data atstk1000_fb0_data;
 
+/*
+ * The next two functions should go away as the boot loader is
+ * supposed to initialize the macb address registers with a valid
+ * ethernet address. But we need to keep it around for a while until
+ * we can be reasonably sure the boot loader does this.
+ *
+ * The phy_id is ignored as the driver will probe for it.
+ */
+static int __init parse_tag_ethernet(struct tag *tag)
+{
+	int i;
+
+	i = tag->u.ethernet.mac_index;
+	if (i < ARRAY_SIZE(hw_addr))
+		memcpy(hw_addr[i].addr, tag->u.ethernet.hw_address,
+		       sizeof(hw_addr[i].addr));
+
+	return 0;
+}
+__tagtable(ATAG_ETHERNET, parse_tag_ethernet);
+
+static void __init set_hw_addr(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	const u8 *addr;
+	void __iomem *regs;
+	struct clk *pclk;
+
+	if (!res)
+		return;
+	if (pdev->id >= ARRAY_SIZE(hw_addr))
+		return;
+
+	addr = hw_addr[pdev->id].addr;
+	if (!is_valid_ether_addr(addr))
+		return;
+
+	/*
+	 * Since this is board-specific code, we'll cheat and use the
+	 * physical address directly as we happen to know that it's
+	 * the same as the virtual address.
+	 */
+	regs = (void __iomem __force *)res->start;
+	pclk = clk_get(&pdev->dev, "pclk");
+	if (!pclk)
+		return;
+
+	clk_enable(pclk);
+	__raw_writel((addr[3] << 24) | (addr[2] << 16)
+		     | (addr[1] << 8) | addr[0], regs + 0x98);
+	__raw_writel((addr[5] << 8) | addr[4], regs + 0x9c);
+	clk_disable(pclk);
+	clk_put(pclk);
+}
+
 void __init setup_board(void)
 {
 	at32_map_usart(1, 0);	/* /dev/ttyS0 */
@@ -38,7 +101,8 @@ static int __init atstk1002_init(void)
 	at32_add_device_usart(1);
 	at32_add_device_usart(2);
 
-	at32_add_device_eth(0, &eth0_data);
+	set_hw_addr(at32_add_device_eth(0, &eth_data[0]));
+
 	at32_add_device_spi(0);
 	at32_add_device_lcdc(0, &atstk1000_fb0_data);
 
diff --git a/arch/avr32/kernel/avr32_ksyms.c b/arch/avr32/kernel/avr32_ksyms.c
index 372e3f8..7c4c761 100644
--- a/arch/avr32/kernel/avr32_ksyms.c
+++ b/arch/avr32/kernel/avr32_ksyms.c
@@ -7,12 +7,12 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
 
 #include <asm/checksum.h>
 #include <asm/uaccess.h>
-#include <asm/delay.h>
 
 /*
  * GCC functions
diff --git a/arch/avr32/kernel/process.c b/arch/avr32/kernel/process.c
index 317dc50..0b43259 100644
--- a/arch/avr32/kernel/process.c
+++ b/arch/avr32/kernel/process.c
@@ -38,6 +38,13 @@ void cpu_idle(void)
 
 void machine_halt(void)
 {
+	/*
+	 * Enter Stop mode. The 32 kHz oscillator will keep running so
+	 * the RTC will keep the time properly and the system will
+	 * boot quickly.
+	 */
+	asm volatile("sleep 3\n\t"
+		     "sub pc, -2");
 }
 
 void machine_power_off(void)
diff --git a/arch/avr32/kernel/setup.c b/arch/avr32/kernel/setup.c
index ea2d1ff..a342116 100644
--- a/arch/avr32/kernel/setup.c
+++ b/arch/avr32/kernel/setup.c
@@ -229,30 +229,6 @@ static int __init parse_tag_rsvd_mem(str
 }
 __tagtable(ATAG_RSVD_MEM, parse_tag_rsvd_mem);
 
-static int __init parse_tag_ethernet(struct tag *tag)
-{
-#if 0
-	const struct platform_device *pdev;
-
-	/*
-	 * We really need a bus type that supports "classes"...this
-	 * will do for now (until we must handle other kinds of
-	 * ethernet controllers)
-	 */
-	pdev = platform_get_device("macb", tag->u.ethernet.mac_index);
-	if (pdev && pdev->dev.platform_data) {
-		struct eth_platform_data *data = pdev->dev.platform_data;
-
-		data->valid = 1;
-		data->mii_phy_addr = tag->u.ethernet.mii_phy_addr;
-		memcpy(data->hw_addr, tag->u.ethernet.hw_address,
-		       sizeof(data->hw_addr));
-	}
-#endif
-	return 0;
-}
-__tagtable(ATAG_ETHERNET, parse_tag_ethernet);
-
 /*
  * Scan the tag table for this tag, and call its parse function. The
  * tag table is built by the linker from all the __tagtable
diff --git a/arch/avr32/lib/delay.c b/arch/avr32/lib/delay.c
index 462c830..b3bc0b5 100644
--- a/arch/avr32/lib/delay.c
+++ b/arch/avr32/lib/delay.c
@@ -12,9 +12,9 @@
 
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/param.h>
 #include <linux/types.h>
 
-#include <asm/delay.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
 
diff --git a/arch/avr32/mach-at32ap/at32ap7000.c b/arch/avr32/mach-at32ap/at32ap7000.c
index 7ff6ad8..48f4ef3 100644
--- a/arch/avr32/mach-at32ap/at32ap7000.c
+++ b/arch/avr32/mach-at32ap/at32ap7000.c
@@ -11,6 +11,7 @@
 
 #include <asm/io.h>
 
+#include <asm/arch/at32ap7000.h>
 #include <asm/arch/board.h>
 #include <asm/arch/portmux.h>
 #include <asm/arch/sm.h>
@@ -57,6 +58,9 @@ static struct platform_device _name##_id
 	.num_resources	= ARRAY_SIZE(_name##_id##_resource),	\
 }
 
+#define select_peripheral(pin, periph, flags)			\
+	at32_select_periph(GPIO_PIN_##pin, GPIO_##periph, flags)
+
 #define DEV_CLK(_name, devname, bus, _index)			\
 static struct clk devname##_##_name = {				\
 	.name		= #_name,				\
@@ -67,18 +71,6 @@ static struct clk devname##_##_name = {
 	.index		= _index,				\
 }
 
-enum {
-	PIOA,
-	PIOB,
-	PIOC,
-	PIOD,
-};
-
-enum {
-	FUNC_A,
-	FUNC_B,
-};
-
 unsigned long at32ap7000_osc_rates[3] = {
 	[0] = 32768,
 	/* FIXME: these are ATSTK1002-specific */
@@ -569,26 +561,26 @@ DEV_CLK(usart, atmel_usart3, pba, 6);
 
 static inline void configure_usart0_pins(void)
 {
-	portmux_set_func(PIOA,  8, FUNC_B);	/* RXD	*/
-	portmux_set_func(PIOA,  9, FUNC_B);	/* TXD	*/
+	select_peripheral(PA(8),  PERIPH_B, 0);	/* RXD	*/
+	select_peripheral(PA(9),  PERIPH_B, 0);	/* TXD	*/
 }
 
 static inline void configure_usart1_pins(void)
 {
-	portmux_set_func(PIOA, 17, FUNC_A);	/* RXD	*/
-	portmux_set_func(PIOA, 18, FUNC_A);	/* TXD	*/
+	select_peripheral(PA(17), PERIPH_A, 0);	/* RXD	*/
+	select_peripheral(PA(18), PERIPH_A, 0);	/* TXD	*/
 }
 
 static inline void configure_usart2_pins(void)
 {
-	portmux_set_func(PIOB, 26, FUNC_B);	/* RXD	*/
-	portmux_set_func(PIOB, 27, FUNC_B);	/* TXD	*/
+	select_peripheral(PB(26), PERIPH_B, 0);	/* RXD	*/
+	select_peripheral(PB(27), PERIPH_B, 0);	/* TXD	*/
 }
 
 static inline void configure_usart3_pins(void)
 {
-	portmux_set_func(PIOB, 18, FUNC_B);	/* RXD	*/
-	portmux_set_func(PIOB, 17, FUNC_B);	/* TXD	*/
+	select_peripheral(PB(18), PERIPH_B, 0);	/* RXD	*/
+	select_peripheral(PB(17), PERIPH_B, 0);	/* TXD	*/
 }
 
 static struct platform_device *at32_usarts[4];
@@ -654,6 +646,15 @@ DEFINE_DEV_DATA(macb, 0);
 DEV_CLK(hclk, macb0, hsb, 8);
 DEV_CLK(pclk, macb0, pbb, 6);
 
+static struct eth_platform_data macb1_data;
+static struct resource macb1_resource[] = {
+	PBMEM(0xfff01c00),
+	IRQ(26),
+};
+DEFINE_DEV_DATA(macb, 1);
+DEV_CLK(hclk, macb1, hsb, 9);
+DEV_CLK(pclk, macb1, pbb, 7);
+
 struct platform_device *__init
 at32_add_device_eth(unsigned int id, struct eth_platform_data *data)
 {
@@ -663,27 +664,54 @@ at32_add_device_eth(unsigned int id, str
 	case 0:
 		pdev = &macb0_device;
 
-		portmux_set_func(PIOC,  3, FUNC_A);	/* TXD0	*/
-		portmux_set_func(PIOC,  4, FUNC_A);	/* TXD1	*/
-		portmux_set_func(PIOC,  7, FUNC_A);	/* TXEN	*/
-		portmux_set_func(PIOC,  8, FUNC_A);	/* TXCK */
-		portmux_set_func(PIOC,  9, FUNC_A);	/* RXD0	*/
-		portmux_set_func(PIOC, 10, FUNC_A);	/* RXD1	*/
-		portmux_set_func(PIOC, 13, FUNC_A);	/* RXER	*/
-		portmux_set_func(PIOC, 15, FUNC_A);	/* RXDV	*/
-		portmux_set_func(PIOC, 16, FUNC_A);	/* MDC	*/
-		portmux_set_func(PIOC, 17, FUNC_A);	/* MDIO	*/
+		select_peripheral(PC(3),  PERIPH_A, 0);	/* TXD0	*/
+		select_peripheral(PC(4),  PERIPH_A, 0);	/* TXD1	*/
+		select_peripheral(PC(7),  PERIPH_A, 0);	/* TXEN	*/
+		select_peripheral(PC(8),  PERIPH_A, 0);	/* TXCK */
+		select_peripheral(PC(9),  PERIPH_A, 0);	/* RXD0	*/
+		select_peripheral(PC(10), PERIPH_A, 0);	/* RXD1	*/
+		select_peripheral(PC(13), PERIPH_A, 0);	/* RXER	*/
+		select_peripheral(PC(15), PERIPH_A, 0);	/* RXDV	*/
+		select_peripheral(PC(16), PERIPH_A, 0);	/* MDC	*/
+		select_peripheral(PC(17), PERIPH_A, 0);	/* MDIO	*/
+
+		if (!data->is_rmii) {
+			select_peripheral(PC(0),  PERIPH_A, 0);	/* COL	*/
+			select_peripheral(PC(1),  PERIPH_A, 0);	/* CRS	*/
+			select_peripheral(PC(2),  PERIPH_A, 0);	/* TXER	*/
+			select_peripheral(PC(5),  PERIPH_A, 0);	/* TXD2	*/
+			select_peripheral(PC(6),  PERIPH_A, 0);	/* TXD3 */
+			select_peripheral(PC(11), PERIPH_A, 0);	/* RXD2	*/
+			select_peripheral(PC(12), PERIPH_A, 0);	/* RXD3	*/
+			select_peripheral(PC(14), PERIPH_A, 0);	/* RXCK	*/
+			select_peripheral(PC(18), PERIPH_A, 0);	/* SPD	*/
+		}
+		break;
+
+	case 1:
+		pdev = &macb1_device;
+
+		select_peripheral(PD(13), PERIPH_B, 0);		/* TXD0	*/
+		select_peripheral(PD(14), PERIPH_B, 0);		/* TXD1	*/
+		select_peripheral(PD(11), PERIPH_B, 0);		/* TXEN	*/
+		select_peripheral(PD(12), PERIPH_B, 0);		/* TXCK */
+		select_peripheral(PD(10), PERIPH_B, 0);		/* RXD0	*/
+		select_peripheral(PD(6),  PERIPH_B, 0);		/* RXD1	*/
+		select_peripheral(PD(5),  PERIPH_B, 0);		/* RXER	*/
+		select_peripheral(PD(4),  PERIPH_B, 0);		/* RXDV	*/
+		select_peripheral(PD(3),  PERIPH_B, 0);		/* MDC	*/
+		select_peripheral(PD(2),  PERIPH_B, 0);		/* MDIO	*/
 
 		if (!data->is_rmii) {
-			portmux_set_func(PIOC,  0, FUNC_A);	/* COL	*/
-			portmux_set_func(PIOC,  1, FUNC_A);	/* CRS	*/
-			portmux_set_func(PIOC,  2, FUNC_A);	/* TXER	*/
-			portmux_set_func(PIOC,  5, FUNC_A);	/* TXD2	*/
-			portmux_set_func(PIOC,  6, FUNC_A);	/* TXD3 */
-			portmux_set_func(PIOC, 11, FUNC_A);	/* RXD2	*/
-			portmux_set_func(PIOC, 12, FUNC_A);	/* RXD3	*/
-			portmux_set_func(PIOC, 14, FUNC_A);	/* RXCK	*/
-			portmux_set_func(PIOC, 18, FUNC_A);	/* SPD	*/
+			select_peripheral(PC(19), PERIPH_B, 0);	/* COL	*/
+			select_peripheral(PC(23), PERIPH_B, 0);	/* CRS	*/
+			select_peripheral(PC(26), PERIPH_B, 0);	/* TXER	*/
+			select_peripheral(PC(27), PERIPH_B, 0);	/* TXD2	*/
+			select_peripheral(PC(28), PERIPH_B, 0);	/* TXD3 */
+			select_peripheral(PC(29), PERIPH_B, 0);	/* RXD2	*/
+			select_peripheral(PC(30), PERIPH_B, 0);	/* RXD3	*/
+			select_peripheral(PC(24), PERIPH_B, 0);	/* RXCK	*/
+			select_peripheral(PD(15), PERIPH_B, 0);	/* SPD	*/
 		}
 		break;
 
@@ -714,12 +742,12 @@ struct platform_device *__init at32_add_
 	switch (id) {
 	case 0:
 		pdev = &spi0_device;
-		portmux_set_func(PIOA,  0, FUNC_A);	/* MISO	 */
-		portmux_set_func(PIOA,  1, FUNC_A);	/* MOSI	 */
-		portmux_set_func(PIOA,  2, FUNC_A);	/* SCK	 */
-		portmux_set_func(PIOA,  3, FUNC_A);	/* NPCS0 */
-		portmux_set_func(PIOA,  4, FUNC_A);	/* NPCS1 */
-		portmux_set_func(PIOA,  5, FUNC_A);	/* NPCS2 */
+		select_peripheral(PA(0),  PERIPH_A, 0);	/* MISO	 */
+		select_peripheral(PA(1),  PERIPH_A, 0);	/* MOSI	 */
+		select_peripheral(PA(2),  PERIPH_A, 0);	/* SCK	 */
+		select_peripheral(PA(3),  PERIPH_A, 0);	/* NPCS0 */
+		select_peripheral(PA(4),  PERIPH_A, 0);	/* NPCS1 */
+		select_peripheral(PA(5),  PERIPH_A, 0);	/* NPCS2 */
 		break;
 
 	default:
@@ -762,37 +790,37 @@ at32_add_device_lcdc(unsigned int id, st
 	switch (id) {
 	case 0:
 		pdev = &lcdc0_device;
-		portmux_set_func(PIOC, 19, FUNC_A);	/* CC	  */
-		portmux_set_func(PIOC, 20, FUNC_A);	/* HSYNC  */
-		portmux_set_func(PIOC, 21, FUNC_A);	/* PCLK	  */
-		portmux_set_func(PIOC, 22, FUNC_A);	/* VSYNC  */
-		portmux_set_func(PIOC, 23, FUNC_A);	/* DVAL	  */
-		portmux_set_func(PIOC, 24, FUNC_A);	/* MODE	  */
-		portmux_set_func(PIOC, 25, FUNC_A);	/* PWR	  */
-		portmux_set_func(PIOC, 26, FUNC_A);	/* DATA0  */
-		portmux_set_func(PIOC, 27, FUNC_A);	/* DATA1  */
-		portmux_set_func(PIOC, 28, FUNC_A);	/* DATA2  */
-		portmux_set_func(PIOC, 29, FUNC_A);	/* DATA3  */
-		portmux_set_func(PIOC, 30, FUNC_A);	/* DATA4  */
-		portmux_set_func(PIOC, 31, FUNC_A);	/* DATA5  */
-		portmux_set_func(PIOD,  0, FUNC_A);	/* DATA6  */
-		portmux_set_func(PIOD,  1, FUNC_A);	/* DATA7  */
-		portmux_set_func(PIOD,  2, FUNC_A);	/* DATA8  */
-		portmux_set_func(PIOD,  3, FUNC_A);	/* DATA9  */
-		portmux_set_func(PIOD,  4, FUNC_A);	/* DATA10 */
-		portmux_set_func(PIOD,  5, FUNC_A);	/* DATA11 */
-		portmux_set_func(PIOD,  6, FUNC_A);	/* DATA12 */
-		portmux_set_func(PIOD,  7, FUNC_A);	/* DATA13 */
-		portmux_set_func(PIOD,  8, FUNC_A);	/* DATA14 */
-		portmux_set_func(PIOD,  9, FUNC_A);	/* DATA15 */
-		portmux_set_func(PIOD, 10, FUNC_A);	/* DATA16 */
-		portmux_set_func(PIOD, 11, FUNC_A);	/* DATA17 */
-		portmux_set_func(PIOD, 12, FUNC_A);	/* DATA18 */
-		portmux_set_func(PIOD, 13, FUNC_A);	/* DATA19 */
-		portmux_set_func(PIOD, 14, FUNC_A);	/* DATA20 */
-		portmux_set_func(PIOD, 15, FUNC_A);	/* DATA21 */
-		portmux_set_func(PIOD, 16, FUNC_A);	/* DATA22 */
-		portmux_set_func(PIOD, 17, FUNC_A);	/* DATA23 */
+		select_peripheral(PC(19), PERIPH_A, 0);	/* CC	  */
+		select_peripheral(PC(20), PERIPH_A, 0);	/* HSYNC  */
+		select_peripheral(PC(21), PERIPH_A, 0);	/* PCLK	  */
+		select_peripheral(PC(22), PERIPH_A, 0);	/* VSYNC  */
+		select_peripheral(PC(23), PERIPH_A, 0);	/* DVAL	  */
+		select_peripheral(PC(24), PERIPH_A, 0);	/* MODE	  */
+		select_peripheral(PC(25), PERIPH_A, 0);	/* PWR	  */
+		select_peripheral(PC(26), PERIPH_A, 0);	/* DATA0  */
+		select_peripheral(PC(27), PERIPH_A, 0);	/* DATA1  */
+		select_peripheral(PC(28), PERIPH_A, 0);	/* DATA2  */
+		select_peripheral(PC(29), PERIPH_A, 0);	/* DATA3  */
+		select_peripheral(PC(30), PERIPH_A, 0);	/* DATA4  */
+		select_peripheral(PC(31), PERIPH_A, 0);	/* DATA5  */
+		select_peripheral(PD(0),  PERIPH_A, 0);	/* DATA6  */
+		select_peripheral(PD(1),  PERIPH_A, 0);	/* DATA7  */
+		select_peripheral(PD(2),  PERIPH_A, 0);	/* DATA8  */
+		select_peripheral(PD(3),  PERIPH_A, 0);	/* DATA9  */
+		select_peripheral(PD(4),  PERIPH_A, 0);	/* DATA10 */
+		select_peripheral(PD(5),  PERIPH_A, 0);	/* DATA11 */
+		select_peripheral(PD(6),  PERIPH_A, 0);	/* DATA12 */
+		select_peripheral(PD(7),  PERIPH_A, 0);	/* DATA13 */
+		select_peripheral(PD(8),  PERIPH_A, 0);	/* DATA14 */
+		select_peripheral(PD(9),  PERIPH_A, 0);	/* DATA15 */
+		select_peripheral(PD(10), PERIPH_A, 0);	/* DATA16 */
+		select_peripheral(PD(11), PERIPH_A, 0);	/* DATA17 */
+		select_peripheral(PD(12), PERIPH_A, 0);	/* DATA18 */
+		select_peripheral(PD(13), PERIPH_A, 0);	/* DATA19 */
+		select_peripheral(PD(14), PERIPH_A, 0);	/* DATA20 */
+		select_peripheral(PD(15), PERIPH_A, 0);	/* DATA21 */
+		select_peripheral(PD(16), PERIPH_A, 0);	/* DATA22 */
+		select_peripheral(PD(17), PERIPH_A, 0);	/* DATA23 */
 
 		clk_set_parent(&lcdc0_pixclk, &pll0);
 		clk_set_rate(&lcdc0_pixclk, clk_get_rate(&pll0));
@@ -838,6 +866,8 @@ struct clk *at32_clock_list[] = {
 	&atmel_usart3_usart,
 	&macb0_hclk,
 	&macb0_pclk,
+	&macb1_hclk,
+	&macb1_pclk,
 	&spi0_mck,
 	&lcdc0_hclk,
 	&lcdc0_pixclk,
diff --git a/arch/avr32/mach-at32ap/extint.c b/arch/avr32/mach-at32ap/extint.c
index 4dff1f9..b59272e 100644
--- a/arch/avr32/mach-at32ap/extint.c
+++ b/arch/avr32/mach-at32ap/extint.c
@@ -49,12 +49,25 @@ static void eim_unmask_irq(unsigned int
 static int eim_set_irq_type(unsigned int irq, unsigned int flow_type)
 {
 	struct at32_sm *sm = get_irq_chip_data(irq);
+	struct irq_desc *desc;
 	unsigned int i = irq - sm->eim_first_irq;
 	u32 mode, edge, level;
 	unsigned long flags;
 	int ret = 0;
 
-	flow_type &= IRQ_TYPE_SENSE_MASK;
+	if (flow_type == IRQ_TYPE_NONE)
+		flow_type = IRQ_TYPE_LEVEL_LOW;
+
+	desc = &irq_desc[irq];
+	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
+	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
+
+	if (flow_type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH)) {
+		desc->status |= IRQ_LEVEL;
+		set_irq_handler(irq, handle_level_irq);
+	} else {
+		set_irq_handler(irq, handle_edge_irq);
+	}
 
 	spin_lock_irqsave(&sm->lock, flags);
 
@@ -148,10 +161,15 @@ static int __init eim_init(void)
 	pattern = sm_readl(sm, EIM_MODE);
 	nr_irqs = fls(pattern);
 
+	/* Trigger on falling edge unless overridden by driver */
+	sm_writel(sm, EIM_MODE, 0UL);
+	sm_writel(sm, EIM_EDGE, 0UL);
+
 	sm->eim_chip = &eim_chip;
 
 	for (i = 0; i < nr_irqs; i++) {
-		set_irq_chip(sm->eim_first_irq + i, &eim_chip);
+		set_irq_chip_and_handler(sm->eim_first_irq + i, &eim_chip,
+					 handle_edge_irq);
 		set_irq_chip_data(sm->eim_first_irq + i, sm);
 	}
 
diff --git a/arch/avr32/mach-at32ap/intc.c b/arch/avr32/mach-at32ap/intc.c
index eb87a18..dd5c009 100644
--- a/arch/avr32/mach-at32ap/intc.c
+++ b/arch/avr32/mach-at32ap/intc.c
@@ -136,3 +136,7 @@ fail:
 	panic("Interrupt controller initialization failed!\n");
 }
 
+unsigned long intc_get_pending(int group)
+{
+	return intc_readl(&intc0, INTREQ0 + 4 * group);
+}
diff --git a/arch/avr32/mach-at32ap/pio.c b/arch/avr32/mach-at32ap/pio.c
index d3aabfc..f1280ed 100644
--- a/arch/avr32/mach-at32ap/pio.c
+++ b/arch/avr32/mach-at32ap/pio.c
@@ -25,27 +25,98 @@ struct pio_device {
 	void __iomem *regs;
 	const struct platform_device *pdev;
 	struct clk *clk;
-	u32 alloc_mask;
+	u32 pinmux_mask;
 	char name[32];
 };
 
 static struct pio_device pio_dev[MAX_NR_PIO_DEVICES];
 
-void portmux_set_func(unsigned int portmux_id, unsigned int pin_id,
-		      unsigned int function_id)
+static struct pio_device *gpio_to_pio(unsigned int gpio)
 {
 	struct pio_device *pio;
-	u32 mask = 1 << pin_id;
+	unsigned int index;
 
-	BUG_ON(portmux_id >= MAX_NR_PIO_DEVICES);
+	index = gpio >> 5;
+	if (index >= MAX_NR_PIO_DEVICES)
+		return NULL;
+	pio = &pio_dev[index];
+	if (!pio->regs)
+		return NULL;
 
-	pio = &pio_dev[portmux_id];
+	return pio;
+}
+
+/* Pin multiplexing API */
+
+void __init at32_select_periph(unsigned int pin, unsigned int periph,
+			       unsigned long flags)
+{
+	struct pio_device *pio;
+	unsigned int pin_index = pin & 0x1f;
+	u32 mask = 1 << pin_index;
+
+	pio = gpio_to_pio(pin);
+	if (unlikely(!pio)) {
+		printk("pio: invalid pin %u\n", pin);
+		goto fail;
+	}
 
-	if (function_id)
+	if (unlikely(test_and_set_bit(pin_index, &pio->pinmux_mask))) {
+		printk("%s: pin %u is busy\n", pio->name, pin_index);
+		goto fail;
+	}
+
+	pio_writel(pio, PUER, mask);
+	if (periph)
 		pio_writel(pio, BSR, mask);
 	else
 		pio_writel(pio, ASR, mask);
+
 	pio_writel(pio, PDR, mask);
+	if (!(flags & AT32_GPIOF_PULLUP))
+		pio_writel(pio, PUDR, mask);
+
+	return;
+
+fail:
+	dump_stack();
+}
+
+void __init at32_select_gpio(unsigned int pin, unsigned long flags)
+{
+	struct pio_device *pio;
+	unsigned int pin_index = pin & 0x1f;
+	u32 mask = 1 << pin_index;
+
+	pio = gpio_to_pio(pin);
+	if (unlikely(!pio)) {
+		printk("pio: invalid pin %u\n", pin);
+		goto fail;
+	}
+
+	if (unlikely(test_and_set_bit(pin_index, &pio->pinmux_mask))) {
+		printk("%s: pin %u is busy\n", pio->name, pin_index);
+		goto fail;
+	}
+
+	pio_writel(pio, PUER, mask);
+	if (flags & AT32_GPIOF_HIGH)
+		pio_writel(pio, SODR, mask);
+	else
+		pio_writel(pio, CODR, mask);
+	if (flags & AT32_GPIOF_OUTPUT)
+		pio_writel(pio, OER, mask);
+	else
+		pio_writel(pio, ODR, mask);
+
+	pio_writel(pio, PER, mask);
+	if (!(flags & AT32_GPIOF_PULLUP))
+		pio_writel(pio, PUDR, mask);
+
+	return;
+
+fail:
+	dump_stack();
 }
 
 static int __init pio_probe(struct platform_device *pdev)
diff --git a/arch/avr32/mach-at32ap/sm.c b/arch/avr32/mach-at32ap/sm.c
deleted file mode 100644
index 03306eb..0000000
--- a/arch/avr32/mach-at32ap/sm.c
+++ /dev/null
@@ -1,289 +0,0 @@
-/*
- * System Manager driver for AT32AP CPUs
- *
- * Copyright (C) 2006 Atmel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/random.h>
-#include <linux/spinlock.h>
-
-#include <asm/intc.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-
-#include <asm/arch/sm.h>
-
-#include "sm.h"
-
-#define SM_EIM_IRQ_RESOURCE	1
-#define SM_PM_IRQ_RESOURCE	2
-#define SM_RTC_IRQ_RESOURCE	3
-
-#define to_eim(irqc) container_of(irqc, struct at32_sm, irqc)
-
-struct at32_sm system_manager;
-
-int __init at32_sm_init(void)
-{
-	struct resource *regs;
-	struct at32_sm *sm = &system_manager;
-	int ret = -ENXIO;
-
-	regs = platform_get_resource(&at32_sm_device, IORESOURCE_MEM, 0);
-	if (!regs)
-		goto fail;
-
-	spin_lock_init(&sm->lock);
-	sm->pdev = &at32_sm_device;
-
-	ret = -ENOMEM;
-	sm->regs = ioremap(regs->start, regs->end - regs->start + 1);
-	if (!sm->regs)
-		goto fail;
-
-	return 0;
-
-fail:
-	printk(KERN_ERR "Failed to initialize System Manager: %d\n", ret);
-	return ret;
-}
-
-/*
- * External Interrupt Module (EIM).
- *
- * EIM gets level- or edge-triggered interrupts of either polarity
- * from the outside and converts it to active-high level-triggered
- * interrupts that the internal interrupt controller can handle. EIM
- * also provides masking/unmasking of interrupts, as well as
- * acknowledging of edge-triggered interrupts.
- */
-
-static irqreturn_t spurious_eim_interrupt(int irq, void *dev_id,
-					  struct pt_regs *regs)
-{
-	printk(KERN_WARNING "Spurious EIM interrupt %d\n", irq);
-	disable_irq(irq);
-	return IRQ_NONE;
-}
-
-static struct irqaction eim_spurious_action = {
-	.handler = spurious_eim_interrupt,
-};
-
-static irqreturn_t eim_handle_irq(int irq, void *dev_id, struct pt_regs *regs)
-{
-	struct irq_controller * irqc = dev_id;
-	struct at32_sm *sm = to_eim(irqc);
-	unsigned long pending;
-
-	/*
-	 * No need to disable interrupts globally.  The interrupt
-	 * level relevant to this group must be masked all the time,
-	 * so we know that this particular EIM instance will not be
-	 * re-entered.
-	 */
-	spin_lock(&sm->lock);
-
-	pending = intc_get_pending(sm->irqc.irq_group);
-	if (unlikely(!pending)) {
-		printk(KERN_ERR "EIM (group %u): No interrupts pending!\n",
-		       sm->irqc.irq_group);
-		goto unlock;
-	}
-
-	do {
-		struct irqaction *action;
-		unsigned int i;
-
-		i = fls(pending) - 1;
-		pending &= ~(1 << i);
-		action = sm->action[i];
-
-		/* Acknowledge the interrupt */
-		sm_writel(sm, EIM_ICR, 1 << i);
-
-		spin_unlock(&sm->lock);
-
-		if (action->flags & SA_INTERRUPT)
-			local_irq_disable();
-		action->handler(sm->irqc.first_irq + i, action->dev_id, regs);
-		local_irq_enable();
-		spin_lock(&sm->lock);
-		if (action->flags & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(sm->irqc.first_irq + i);
-	} while (pending);
-
-unlock:
-	spin_unlock(&sm->lock);
-	return IRQ_HANDLED;
-}
-
-static void eim_mask(struct irq_controller *irqc, unsigned int irq)
-{
-	struct at32_sm *sm = to_eim(irqc);
-	unsigned int i;
-
-	i = irq - sm->irqc.first_irq;
-	sm_writel(sm, EIM_IDR, 1 << i);
-}
-
-static void eim_unmask(struct irq_controller *irqc, unsigned int irq)
-{
-	struct at32_sm *sm = to_eim(irqc);
-	unsigned int i;
-
-	i = irq - sm->irqc.first_irq;
-	sm_writel(sm, EIM_IER, 1 << i);
-}
-
-static int eim_setup(struct irq_controller *irqc, unsigned int irq,
-		struct irqaction *action)
-{
-	struct at32_sm *sm = to_eim(irqc);
-	sm->action[irq - sm->irqc.first_irq] = action;
-	/* Acknowledge earlier interrupts */
-	sm_writel(sm, EIM_ICR, (1<<(irq - sm->irqc.first_irq)));
-	eim_unmask(irqc, irq);
-	return 0;
-}
-
-static void eim_free(struct irq_controller *irqc, unsigned int irq,
-		void *dev)
-{
-	struct at32_sm *sm = to_eim(irqc);
-	eim_mask(irqc, irq);
-	sm->action[irq - sm->irqc.first_irq] = &eim_spurious_action;
-}
-
-static int eim_set_type(struct irq_controller *irqc, unsigned int irq,
-			unsigned int type)
-{
-	struct at32_sm *sm = to_eim(irqc);
-	unsigned long flags;
-	u32 value, pattern;
-
-	spin_lock_irqsave(&sm->lock, flags);
-
-	pattern = 1 << (irq - sm->irqc.first_irq);
-
-	value = sm_readl(sm, EIM_MODE);
-	if (type & IRQ_TYPE_LEVEL)
-		value |= pattern;
-	else
-		value &= ~pattern;
-	sm_writel(sm, EIM_MODE, value);
-	value = sm_readl(sm, EIM_EDGE);
-	if (type & IRQ_EDGE_RISING)
-		value |= pattern;
-	else
-		value &= ~pattern;
-	sm_writel(sm, EIM_EDGE, value);
-	value = sm_readl(sm, EIM_LEVEL);
-	if (type & IRQ_LEVEL_HIGH)
-		value |= pattern;
-	else
-		value &= ~pattern;
-	sm_writel(sm, EIM_LEVEL, value);
-
-	spin_unlock_irqrestore(&sm->lock, flags);
-
-	return 0;
-}
-
-static unsigned int eim_get_type(struct irq_controller *irqc,
-				 unsigned int irq)
-{
-	struct at32_sm *sm = to_eim(irqc);
-	unsigned long flags;
-	unsigned int type = 0;
-	u32 mode, edge, level, pattern;
-
-	pattern = 1 << (irq - sm->irqc.first_irq);
-
-	spin_lock_irqsave(&sm->lock, flags);
-	mode = sm_readl(sm, EIM_MODE);
-	edge = sm_readl(sm, EIM_EDGE);
-	level = sm_readl(sm, EIM_LEVEL);
-	spin_unlock_irqrestore(&sm->lock, flags);
-
-	if (mode & pattern)
-		type |= IRQ_TYPE_LEVEL;
-	if (edge & pattern)
-		type |= IRQ_EDGE_RISING;
-	if (level & pattern)
-		type |= IRQ_LEVEL_HIGH;
-
-	return type;
-}
-
-static struct irq_controller_class eim_irq_class = {
-	.typename	= "EIM",
-	.handle		= eim_handle_irq,
-	.setup		= eim_setup,
-	.free		= eim_free,
-	.mask		= eim_mask,
-	.unmask		= eim_unmask,
-	.set_type	= eim_set_type,
-	.get_type	= eim_get_type,
-};
-
-static int __init eim_init(void)
-{
-	struct at32_sm *sm = &system_manager;
-	unsigned int i;
-	u32 pattern;
-	int ret;
-
-	/*
-	 * The EIM is really the same module as SM, so register
-	 * mapping, etc. has been taken care of already.
-	 */
-
-	/*
-	 * Find out how many interrupt lines that are actually
-	 * implemented in hardware.
-	 */
-	sm_writel(sm, EIM_IDR, ~0UL);
-	sm_writel(sm, EIM_MODE, ~0UL);
-	pattern = sm_readl(sm, EIM_MODE);
-	sm->irqc.nr_irqs = fls(pattern);
-
-	ret = -ENOMEM;
-	sm->action = kmalloc(sizeof(*sm->action) * sm->irqc.nr_irqs,
-			     GFP_KERNEL);
-	if (!sm->action)
-		goto out;
-
-	for (i = 0; i < sm->irqc.nr_irqs; i++)
-		sm->action[i] = &eim_spurious_action;
-
-	spin_lock_init(&sm->lock);
-	sm->irqc.irq_group = sm->pdev->resource[SM_EIM_IRQ_RESOURCE].start;
-	sm->irqc.class = &eim_irq_class;
-
-	ret = intc_register_controller(&sm->irqc);
-	if (ret < 0)
-		goto out_free_actions;
-
-	printk("EIM: External Interrupt Module at 0x%p, IRQ group %u\n",
-	       sm->regs, sm->irqc.irq_group);
-	printk("EIM: Handling %u external IRQs, starting with IRQ%u\n",
-	       sm->irqc.nr_irqs, sm->irqc.first_irq);
-
-	return 0;
-
-out_free_actions:
-	kfree(sm->action);
-out:
-	return ret;
-}
-arch_initcall(eim_init);
diff --git a/include/asm-avr32/arch-at32ap/at32ap7000.h b/include/asm-avr32/arch-at32ap/at32ap7000.h
new file mode 100644
index 0000000..ba85e04
--- /dev/null
+++ b/include/asm-avr32/arch-at32ap/at32ap7000.h
@@ -0,0 +1,33 @@
+/*
+ * Pin definitions for AT32AP7000.
+ *
+ * Copyright (C) 2006 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARCH_AT32AP7000_H__
+#define __ASM_ARCH_AT32AP7000_H__
+
+#define GPIO_PERIPH_A	0
+#define GPIO_PERIPH_B	1
+
+#define NR_GPIO_CONTROLLERS	4
+
+/*
+ * Pin numbers identifying specific GPIO pins on the chip. They can
+ * also be converted to IRQ numbers by passing them through
+ * gpio_to_irq().
+ */
+#define GPIO_PIOA_BASE	(0)
+#define GPIO_PIOB_BASE	(GPIO_PIOA_BASE + 32)
+#define GPIO_PIOC_BASE	(GPIO_PIOB_BASE + 32)
+#define GPIO_PIOD_BASE	(GPIO_PIOC_BASE + 32)
+
+#define GPIO_PIN_PA(N)	(GPIO_PIOA_BASE + (N))
+#define GPIO_PIN_PB(N)	(GPIO_PIOB_BASE + (N))
+#define GPIO_PIN_PC(N)	(GPIO_PIOC_BASE + (N))
+#define GPIO_PIN_PD(N)	(GPIO_PIOD_BASE + (N))
+
+#endif /* __ASM_ARCH_AT32AP7000_H__ */
diff --git a/include/asm-avr32/arch-at32ap/board.h b/include/asm-avr32/arch-at32ap/board.h
index a39b3e9..b120ee0 100644
--- a/include/asm-avr32/arch-at32ap/board.h
+++ b/include/asm-avr32/arch-at32ap/board.h
@@ -21,10 +21,7 @@ void at32_map_usart(unsigned int hw_id,
 struct platform_device *at32_add_device_usart(unsigned int id);
 
 struct eth_platform_data {
-	u8	valid;
-	u8	mii_phy_addr;
 	u8	is_rmii;
-	u8	hw_addr[6];
 };
 struct platform_device *
 at32_add_device_eth(unsigned int id, struct eth_platform_data *data);
diff --git a/include/asm-avr32/arch-at32ap/portmux.h b/include/asm-avr32/arch-at32ap/portmux.h
index 4d50421..83c6905 100644
--- a/include/asm-avr32/arch-at32ap/portmux.h
+++ b/include/asm-avr32/arch-at32ap/portmux.h
@@ -7,10 +7,20 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef __ASM_AVR32_AT32_PORTMUX_H__
-#define __ASM_AVR32_AT32_PORTMUX_H__
+#ifndef __ASM_ARCH_PORTMUX_H__
+#define __ASM_ARCH_PORTMUX_H__
 
-void portmux_set_func(unsigned int portmux_id, unsigned int pin_id,
-		      unsigned int function_id);
+/*
+ * Set up pin multiplexing, called from board init only.
+ *
+ * The following flags determine the initial state of the pin.
+ */
+#define AT32_GPIOF_PULLUP	0x00000001	/* Enable pull-up */
+#define AT32_GPIOF_OUTPUT	0x00000002	/* Enable output driver */
+#define AT32_GPIOF_HIGH		0x00000004	/* Set output high */
+
+void at32_select_periph(unsigned int pin, unsigned int periph,
+			unsigned long flags);
+void at32_select_gpio(unsigned int pin, unsigned long flags);
 
-#endif /* __ASM_AVR32_AT32_PORTMUX_H__ */
+#endif /* __ASM_ARCH_PORTMUX_H__ */
diff --git a/include/asm-avr32/dma-mapping.h b/include/asm-avr32/dma-mapping.h
index 0580b5d..5c01e27 100644
--- a/include/asm-avr32/dma-mapping.h
+++ b/include/asm-avr32/dma-mapping.h
@@ -109,7 +109,7 @@ static inline dma_addr_t
 dma_map_single(struct device *dev, void *cpu_addr, size_t size,
 	       enum dma_data_direction direction)
 {
-	dma_cache_sync(cpu_addr, size, direction);
+	dma_cache_sync(dev, cpu_addr, size, direction);
 	return virt_to_bus(cpu_addr);
 }
 
@@ -211,7 +211,7 @@ dma_map_sg(struct device *dev, struct sc
 
 		sg[i].dma_address = page_to_bus(sg[i].page) + sg[i].offset;
 		virt = page_address(sg[i].page) + sg[i].offset;
-		dma_cache_sync(virt, sg[i].length, direction);
+		dma_cache_sync(dev, virt, sg[i].length, direction);
 	}
 
 	return nents;
@@ -256,14 +256,14 @@ static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 			size_t size, enum dma_data_direction direction)
 {
-	dma_cache_sync(bus_to_virt(dma_handle), size, direction);
+	dma_cache_sync(dev, bus_to_virt(dma_handle), size, direction);
 }
 
 static inline void
 dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
 			   size_t size, enum dma_data_direction direction)
 {
-	dma_cache_sync(bus_to_virt(dma_handle), size, direction);
+	dma_cache_sync(dev, bus_to_virt(dma_handle), size, direction);
 }
 
 /**
@@ -286,7 +286,7 @@ dma_sync_sg_for_cpu(struct device *dev,
 	int i;
 
 	for (i = 0; i < nents; i++) {
-		dma_cache_sync(page_address(sg[i].page) + sg[i].offset,
+		dma_cache_sync(dev, page_address(sg[i].page) + sg[i].offset,
 			       sg[i].length, direction);
 	}
 }
@@ -298,7 +298,7 @@ dma_sync_sg_for_device(struct device *de
 	int i;
 
 	for (i = 0; i < nents; i++) {
-		dma_cache_sync(page_address(sg[i].page) + sg[i].offset,
+		dma_cache_sync(dev, page_address(sg[i].page) + sg[i].offset,
 			       sg[i].length, direction);
 	}
 }
