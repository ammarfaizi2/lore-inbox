Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbWI1NcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWI1NcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWI1Nbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:31:43 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:45050 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751892AbWI1Nbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:31:35 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 3/4] AVR32: Allow renumbering of serial devices
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 28 Sep 2006 15:31:41 +0200
Message-Id: <1159450302567-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11594503023619-git-send-email-hskinnemoen@atmel.com>
References: <11594503023218-git-send-email-hskinnemoen@atmel.com> <11594503023213-git-send-email-hskinnemoen@atmel.com> <11594503023619-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the board to remap actual USART peripheral devices to serial
devices by calling at32_map_usart(hw_id, serial_line). This ensures
that even though ATSTK1002 uses USART1 as the first serial port, it
will still have a ttyS0 device.

This also adds a board-specific early setup hook and moves the
at32_setup_serial_console() call there from the platform code.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/boards/atstk1000/atstk1002.c |   16 +++++++++++++---
 arch/avr32/kernel/setup.c               |    1 +
 arch/avr32/mach-at32ap/at32ap.c         |    3 ---
 arch/avr32/mach-at32ap/at32ap7000.c     |   22 ++++++++++------------
 include/asm-avr32/arch-at32ap/board.h   |    1 +
 include/asm-avr32/arch-at32ap/init.h    |    1 +
 6 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/avr32/boards/atstk1000/atstk1002.c b/arch/avr32/boards/atstk1000/atstk1002.c
index 49164e9..cced73c 100644
--- a/arch/avr32/boards/atstk1000/atstk1002.c
+++ b/arch/avr32/boards/atstk1000/atstk1002.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 
 #include <asm/arch/board.h>
+#include <asm/arch/init.h>
 
 struct eth_platform_data __initdata eth0_data = {
 	.valid		= 1,
@@ -20,13 +21,22 @@ struct eth_platform_data __initdata eth0
 
 extern struct lcdc_platform_data atstk1000_fb0_data;
 
+void __init setup_board(void)
+{
+	at32_map_usart(1, 0);	/* /dev/ttyS0 */
+	at32_map_usart(2, 1);	/* /dev/ttyS1 */
+	at32_map_usart(3, 2);	/* /dev/ttyS2 */
+
+	at32_setup_serial_console(0);
+}
+
 static int __init atstk1002_init(void)
 {
 	at32_add_system_devices();
 
-	at32_add_device_usart(1);	/* /dev/ttyS0 */
-	at32_add_device_usart(2);	/* /dev/ttyS1 */
-	at32_add_device_usart(3);	/* /dev/ttyS2 */
+	at32_add_device_usart(0);
+	at32_add_device_usart(1);
+	at32_add_device_usart(2);
 
 	at32_add_device_eth(0, &eth0_data);
 	at32_add_device_spi(0);
diff --git a/arch/avr32/kernel/setup.c b/arch/avr32/kernel/setup.c
index 5d68f3c..ea2d1ff 100644
--- a/arch/avr32/kernel/setup.c
+++ b/arch/avr32/kernel/setup.c
@@ -292,6 +292,7 @@ void __init setup_arch (char **cmdline_p
 
 	setup_processor();
 	setup_platform();
+	setup_board();
 
 	cpu_clk = clk_get(NULL, "cpu");
 	if (IS_ERR(cpu_clk)) {
diff --git a/arch/avr32/mach-at32ap/at32ap.c b/arch/avr32/mach-at32ap/at32ap.c
index f7cedf5..90f207e 100644
--- a/arch/avr32/mach-at32ap/at32ap.c
+++ b/arch/avr32/mach-at32ap/at32ap.c
@@ -48,9 +48,6 @@ void __init setup_platform(void)
 	at32_sm_init();
 	at32_clock_init();
 	at32_portmux_init();
-
-	/* FIXME: This doesn't belong here */
-	at32_setup_serial_console(1);
 }
 
 static int __init pdc_probe(struct platform_device *pdev)
diff --git a/arch/avr32/mach-at32ap/at32ap7000.c b/arch/avr32/mach-at32ap/at32ap7000.c
index 3dd3058..7ff6ad8 100644
--- a/arch/avr32/mach-at32ap/at32ap7000.c
+++ b/arch/avr32/mach-at32ap/at32ap7000.c
@@ -591,11 +591,13 @@ static inline void configure_usart3_pins
 	portmux_set_func(PIOB, 17, FUNC_B);	/* TXD	*/
 }
 
-static struct platform_device *setup_usart(unsigned int id)
+static struct platform_device *at32_usarts[4];
+
+void __init at32_map_usart(unsigned int hw_id, unsigned int line)
 {
 	struct platform_device *pdev;
 
-	switch (id) {
+	switch (hw_id) {
 	case 0:
 		pdev = &atmel_usart0_device;
 		configure_usart0_pins();
@@ -613,7 +615,7 @@ static struct platform_device *setup_usa
 		configure_usart3_pins();
 		break;
 	default:
-		return NULL;
+		return;
 	}
 
 	if (PXSEG(pdev->resource[0].start) == P4SEG) {
@@ -622,25 +624,21 @@ static struct platform_device *setup_usa
 		data->regs = (void __iomem *)pdev->resource[0].start;
 	}
 
-	return pdev;
+	pdev->id = line;
+	at32_usarts[line] = pdev;
 }
 
 struct platform_device *__init at32_add_device_usart(unsigned int id)
 {
-	struct platform_device *pdev;
-
-	pdev = setup_usart(id);
-	if (pdev)
-		platform_device_register(pdev);
-
-	return pdev;
+	platform_device_register(at32_usarts[id]);
+	return at32_usarts[id];
 }
 
 struct platform_device *atmel_default_console_device;
 
 void __init at32_setup_serial_console(unsigned int usart_id)
 {
-	atmel_default_console_device = setup_usart(usart_id);
+	atmel_default_console_device = at32_usarts[usart_id];
 }
 
 /* --------------------------------------------------------------------
diff --git a/include/asm-avr32/arch-at32ap/board.h b/include/asm-avr32/arch-at32ap/board.h
index 4355072..a39b3e9 100644
--- a/include/asm-avr32/arch-at32ap/board.h
+++ b/include/asm-avr32/arch-at32ap/board.h
@@ -17,6 +17,7 @@ struct atmel_uart_data {
 	short		use_dma_rx;	/* use receive DMA? */
 	void __iomem	*regs;		/* virtual base address, if any */
 };
+void at32_map_usart(unsigned int hw_id, unsigned int line);
 struct platform_device *at32_add_device_usart(unsigned int id);
 
 struct eth_platform_data {
diff --git a/include/asm-avr32/arch-at32ap/init.h b/include/asm-avr32/arch-at32ap/init.h
index 4372263..5e75d85 100644
--- a/include/asm-avr32/arch-at32ap/init.h
+++ b/include/asm-avr32/arch-at32ap/init.h
@@ -11,6 +11,7 @@ #ifndef __ASM_AVR32_AT32AP_INIT_H__
 #define __ASM_AVR32_AT32AP_INIT_H__
 
 void setup_platform(void);
+void setup_board(void);
 
 /* Called by setup_platform */
 void at32_clock_init(void);
-- 
1.4.1.1

