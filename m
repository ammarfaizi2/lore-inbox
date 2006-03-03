Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWCCLK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWCCLK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWCCLK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:10:27 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:10951 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751372AbWCCLK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:10:26 -0500
Message-ID: <44082344.6040901@metro.cx>
Date: Fri, 03 Mar 2006 12:06:44 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 11/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Start of s3c2412 platform support.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/arch/arm/mach-s3c2410/s3c2412.c    1970-01-01 
01:00:00.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/s3c2412.c    2006-02-28 
12:17:21.000000000 +0100
@@ -0,0 +1,276 @@
+/* linux/arch/arm/mach-s3c2410/s3c2440.c
+ *
+ * Copyright (c) 2004-2005 Simtec Electronics
+ *   Ben Dooks <ben@simtec.co.uk>
+ *
+ * Samsung S3C2412 Mobile CPU support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Modifications:
+ *    24-Aug-2004 BJD  Start of s3c2440 support
+ *    12-Oct-2004 BJD     Moved clock info out to clock.c
+ *    01-Nov-2004 BJD  Fixed clock build code
+ *    09-Nov-2004 BJD  Added sysdev for power management
+ *    04-Nov-2004 BJD  New serial registration
+ *    15-Nov-2004 BJD  Rename the i2c device for the s3c2440
+ *    14-Jan-2005 BJD  Moved clock init code into seperate function
+ *    14-Jan-2005 BJD  Removed un-used clock bits
+ *      27-Feb-2006 KM   Start of s3c2412 support
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/sysdev.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <asm/hardware.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/hardware/clock.h>
+
+#include <asm/arch/regs-clock.h>
+#include <asm/arch/regs-serial.h>
+#include <asm/arch/regs-gpio.h>
+#include <asm/arch/regs-gpioj.h>
+#include <asm/arch/regs-dsc.h>
+
+#include "s3c2412.h"
+#include "clock.h"
+#include "devs.h"
+#include "cpu.h"
+#include "pm.h"
+
+
+static struct map_desc s3c2412_iodesc[] __initdata = {
+    IODESC_ENT(USBHOST),
+    IODESC_ENT(CLKPWR),
+    IODESC_ENT(LCD),
+    IODESC_ENT(TIMER),
+    IODESC_ENT(ADC),
+    IODESC_ENT(WATCHDOG),
+};
+
+static struct resource s3c_uart0_resource[] = {
+    [0] = {
+        .start = S3C2410_PA_UART0,
+        .end   = S3C2410_PA_UART0 + 0x3fff,
+        .flags = IORESOURCE_MEM,
+    },
+    [1] = {
+        .start = IRQ_S3CUART_RX0,
+        .end   = IRQ_S3CUART_ERR0,
+        .flags = IORESOURCE_IRQ,
+    }
+
+};
+
+static struct resource s3c_uart1_resource[] = {
+    [0] = {
+        .start = S3C2410_PA_UART1,
+        .end   = S3C2410_PA_UART1 + 0x3fff,
+        .flags = IORESOURCE_MEM,
+    },
+    [1] = {
+        .start = IRQ_S3CUART_RX1,
+        .end   = IRQ_S3CUART_ERR1,
+        .flags = IORESOURCE_IRQ,
+    }
+};
+
+static struct resource s3c_uart2_resource[] = {
+    [0] = {
+        .start = S3C2410_PA_UART2,
+        .end   = S3C2410_PA_UART2 + 0x3fff,
+        .flags = IORESOURCE_MEM,
+    },
+    [1] = {
+        .start = IRQ_S3CUART_RX2,
+        .end   = IRQ_S3CUART_ERR2,
+        .flags = IORESOURCE_IRQ,
+    }
+};
+
+/* our uart devices */
+
+static struct platform_device s3c_uart0 = {
+    .name          = "s3c2412-uart",
+    .id          = 0,
+    .num_resources      = ARRAY_SIZE(s3c_uart0_resource),
+    .resource      = s3c_uart0_resource,
+};
+
+static struct platform_device s3c_uart1 = {
+    .name          = "s3c2412-uart",
+    .id          = 1,
+    .num_resources      = ARRAY_SIZE(s3c_uart1_resource),
+    .resource      = s3c_uart1_resource,
+};
+
+static struct platform_device s3c_uart2 = {
+    .name          = "s3c2412-uart",
+    .id          = 2,
+    .num_resources      = ARRAY_SIZE(s3c_uart2_resource),
+    .resource      = s3c_uart2_resource,
+};
+
+static struct platform_device *uart_devices[] __initdata = {
+    &s3c_uart0,
+    &s3c_uart1,
+    &s3c_uart2
+};
+
+/* uart initialisation */
+
+static int __initdata s3c2412_uart_count;
+
+void __init s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+    struct platform_device *platdev;
+    int uart;
+
+    for (uart = 0; uart < no; uart++, cfg++) {
+        platdev = uart_devices[cfg->hwport];
+
+        s3c24xx_uart_devs[uart] = platdev;
+        platdev->dev.platform_data = cfg;
+    }
+
+    s3c2412_uart_count = uart;
+}
+
+
+#ifdef CONFIG_PM
+
+struct sleep_save s3c2412_sleep[] = {
+    SAVE_ITEM(S3C2412_DSC0),
+    SAVE_ITEM(S3C2412_DSC1)
+};
+
+static int s3c2412_suspend(struct sys_device *dev, pm_message_t state)
+{
+    s3c2410_pm_do_save(s3c2412_sleep, ARRAY_SIZE(s3c2412_sleep));
+    return 0;
+}
+
+static int s3c2412_resume(struct sys_device *dev)
+{
+    s3c2410_pm_do_restore(s3c2412_sleep, ARRAY_SIZE(s3c2412_sleep));
+    return 0;
+}
+
+#else
+#define s3c2412_suspend NULL
+#define s3c2412_resume  NULL
+#endif
+
+struct sysdev_class s3c2412_sysclass = {
+    set_kset_name("s3c2412-core"),
+    .suspend    = s3c2412_suspend,
+    .resume        = s3c2412_resume
+};
+
+static struct sys_device s3c2412_sysdev = {
+    .cls        = &s3c2412_sysclass,
+};
+
+void __init s3c2412_map_io(struct map_desc *mach_desc, int size)
+{
+    /* register our io-tables */
+
+    iotable_init(s3c2412_iodesc, ARRAY_SIZE(s3c2412_iodesc));
+    iotable_init(mach_desc, size);
+
+    /* rename any peripherals used differing from the s3c2410 */
+
+    s3c_device_i2c.name  = "s3c2412-i2s";
+}
+
+void __init s3c2412_init_clocks(int xtal)
+{
+    unsigned long clkdiv;
+    unsigned long hclk, fclk, pclk;
+    int hdiv = 1;
+        int shift;
+
+    /* now we've got our machine bits initialised, work out what
+     * clocks we've got */
+
+    fclk = s3c2412_get_pll(__raw_readl(S3C2410_MPLLCON), xtal) * 2;
+
+    clkdiv = __raw_readl(S3C2410_CLKDIVN);
+
+    /* work out clock scalings */
+
+    shift=(clkdiv & S3C2412_CLKDIVN_ARMDIV)?1:0;
+
+    switch (clkdiv & S3C2412_CLKDIVN_HCLKDIV_MASK) {
+    case S3C2412_CLKDIVN_HCLKDIV_1_2:
+        hdiv = 1 << shift;
+        break;
+
+    case S3C2412_CLKDIVN_HCLKDIV_2_4:
+        hdiv = 2 << shift;
+        break;
+
+    case S3C2412_CLKDIVN_HCLKDIV_3_6:
+        hdiv = 3 << shift;
+        break;
+
+    case S3C2412_CLKDIVN_HCLKDIV_4_8:
+        hdiv = 4 << shift;
+        break;
+    }
+
+    hclk = fclk / hdiv;
+    pclk = hclk / ((clkdiv & S3C2412_CLKDIVN_PCLKDIV)? 2:1);
+
+    /* print brief summary of clocks, etc */
+
+    printk("S3C2412: core %ld.%03ld MHz, memory %ld.%03ld MHz, 
peripheral %ld.%03ld MHz\n",
+           print_mhz(fclk), print_mhz(hclk), print_mhz(pclk));
+
+    /* initialise the clocks here, to allow other things like the
+     * console to use them, and to add new ones after the initialisation
+     */
+
+    s3c24xx_setup_clocks(xtal, fclk, hclk, pclk);
+}
+
+/* need to register class before we actually register the device, and
+ * we also need to ensure that it has been initialised before any of the
+ * drivers even try to use it (even if not on an s3c2412 based system)
+ * as a driver which may support both 2410 and 2412 may try and use it.
+*/
+
+int __init s3c2412_core_init(void)
+{
+    return sysdev_class_register(&s3c2412_sysclass);
+}
+
+core_initcall(s3c2412_core_init);
+
+int __init s3c2412_init(void)
+{
+    int ret;
+
+    printk("S3C2412: Initialising architecture\n");
+
+    ret = sysdev_register(&s3c2412_sysdev);
+    if (ret != 0)
+        printk(KERN_ERR "failed to register sysdev for s3c2412\n");
+    else
+        ret = platform_add_devices(s3c24xx_uart_devs, s3c2412_uart_count);
+
+    return ret;
+}

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/

