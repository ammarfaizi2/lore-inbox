Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWC3NRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWC3NRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWC3NRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:17:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:973 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932169AbWC3NRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:17:08 -0500
Date: Thu, 30 Mar 2006 15:16:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Richard Purdie <rpurdie@rpsys.net>, lenz@cs.wisc.edu
Cc: patches@arm.linux.org.uk
Subject: Re: 2.6.16-git18: collie_defconfig broken
Message-ID: <20060330131620.GU8485@elf.ucw.cz>
References: <20060330122544.GA30314@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330122544.GA30314@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The kautobuild found the following error while trying to build 2.6.16-git18
> using collie_defconfig:
> 
> arch/arm/mach-sa1100/collie.c:92: error: 'collie_uart_set_mctrl' undeclared here (not in a function)
> arch/arm/mach-sa1100/collie.c:93: error: 'collie_uart_get_mctrl' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-sa1100/collie.o] Error 1
> make: *** [arch/arm/mach-sa1100] Error 2
> make: Leaving directory `/var/tmp/kernel-orig'
> 
> See
> 
> http://armlinux.simtec.co.uk/kautobuild/2.6.16-git18/collie_defconfig/zimage.log
> 
> for the full build log.

This fixes above compile error by adding missing pieces of uart
support, and fixes compilation.

Signed-off-by: Pavel Machek <pavel@suse.cz>
PATCH FOLLOWS
KernelVersion: 2.6.16-git

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 1024540..10ebb84 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -11,7 +11,8 @@
  * published by the Free Software Foundation.
  *
  * ChangeLog:
- *  03-06-2004 John Lenz <jelenz@wisc.edu>
+ *  2006 Pavel Machek <pavel@suse.cz>
+ *  03-06-2004 John Lenz <lenz@cs.wisc.edu>
  *  06-04-2002 Chris Larson <kergoth@digitalnemesis.net>
  *  04-16-2001 Lineo Japan,Inc. ...
  */
@@ -87,12 +88,75 @@ static struct mcp_plat_data collie_mcp_d
 	.sclk_rate      = 11981000,
 };
 
+#ifdef CONFIG_SHARP_LOCOMO
+/*
+ * low-level UART features.
+ */
+static struct locomo_dev *uart_dev = NULL;
+
+static void collie_uart_set_mctrl(struct uart_port *port, u_int mctrl)
+{
+ 	if (!uart_dev) return;
+	
+ 	if (mctrl & TIOCM_RTS)
+		locomo_gpio_write(uart_dev, LOCOMO_GPIO_RTS, 0);
+ 	else
+		locomo_gpio_write(uart_dev, LOCOMO_GPIO_RTS, 1);
+	
+ 	if (mctrl & TIOCM_DTR)
+		locomo_gpio_write(uart_dev, LOCOMO_GPIO_DTR, 0);
+ 	else
+		locomo_gpio_write(uart_dev, LOCOMO_GPIO_DTR, 1);
+}
+ 
+static u_int collie_uart_get_mctrl(struct uart_port *port)
+{
+	int ret = TIOCM_CD;
+	unsigned int r;
+	if (!uart_dev) return ret;
+
+	r = locomo_gpio_read_output(uart_dev, LOCOMO_GPIO_CTS & LOCOMO_GPIO_DSR);
+	if (r & LOCOMO_GPIO_CTS)
+		ret |= TIOCM_CTS;
+	if (r & LOCOMO_GPIO_DSR)
+		ret |= TIOCM_DSR;
+
+	return ret;
+}
 
 static struct sa1100_port_fns collie_port_fns __initdata = {
 	.set_mctrl	= collie_uart_set_mctrl,
 	.get_mctrl	= collie_uart_get_mctrl,
 };
 
+static int collie_uart_probe(struct locomo_dev *dev)
+{
+	uart_dev = dev;
+	return 0;
+}
+
+static int collie_uart_remove(struct locomo_dev *dev)
+{
+	uart_dev = NULL;
+	return 0;
+}
+
+static struct locomo_driver collie_uart_driver = {
+	.drv = {
+		.name = "collie_uart",
+	},
+	.devid	= LOCOMO_DEVID_UART,
+	.probe	= collie_uart_probe,
+	.remove	= collie_uart_remove,
+}; 
+
+static int __init collie_uart_init(void) {
+	return locomo_driver_register(&collie_uart_driver);
+}
+device_initcall(collie_uart_init);
+
+#endif
+
 
 static struct resource locomo_resources[] = {
 	[0] = {
@@ -218,6 +327,12 @@ static void __init collie_map_io(void)
 {
 	sa1100_map_io();
 	iotable_init(collie_io_desc, ARRAY_SIZE(collie_io_desc));
+
+#ifdef CONFIG_SHARP_LOCOMO
+	sa1100_register_uart_fns(&collie_port_fns);
+#endif
+	sa1100_register_uart(0, 3);
+	sa1100_register_uart(1, 1);
 }
 
 MACHINE_START(COLLIE, "Sharp-Collie")


-- 
Picture of sleeping (Linux) penguin wanted...
