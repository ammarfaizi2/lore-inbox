Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbUKATZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbUKATZX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S291145AbUKATZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:25:10 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:26011 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S273846AbUKATUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:20:48 -0500
Date: Mon, 1 Nov 2004 12:20:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <mporter@kernel.crashing.org>,
       Kumar Gala <kumar.gala@freescale.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org,
       takeharu1219@ybb.ne.jp
Subject: Re: [PATCH][PPC32][2/2] 40x and Book E debug: 4xx platform support
Message-ID: <20041101192040.GK24459@smtp.west.cox.net>
References: <20041029175158.D13435@home.com> <20041029180814.A15758@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029180814.A15758@home.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 06:08:14PM -0700, Matt Porter wrote:

> This patch adds support to the 40x and 44x platform code for
> initializing debug events and using the in-kernel kgdb stub.
> 
> Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

On top of this, I have the following to add these boards, and a few
other BookE boards to registering with the kgdb_8250 driver.  This has
been tested on an IBM 440GP Eval board.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.10-rc1.orig/arch/ppc/platforms/4xx/bubinga.c
+++ linux-2.6.10-rc1/arch/ppc/platforms/4xx/bubinga.c
@@ -4,7 +4,7 @@
  * Author: SAW (IBM), derived from walnut.c.
  *         Maintained by MontaVista Software <source@mvista.com>
  *
- * 2003 (c) MontaVista Softare Inc.  This file is licensed under the
+ * 2003-2004 (c) MontaVista Softare Inc.  This file is licensed under the
  * terms of the GNU General Public License version 2. This program is
  * licensed "as is" without any warranty of any kind, whether express
  * or implied.
@@ -101,17 +101,26 @@ bubinga_early_serial_map(void)
 	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 	port.line = 0;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 0)
 		printk("Early serial init of port 0 failed\n");
-	}
+#endif
+
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &port);
+#endif
 
 	port.membase = (void*)ACTING_UART1_IO_BASE;
 	port.irq = ACTING_UART1_INT;
 	port.line = 1;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 0)
 		printk("Early serial init of port 1 failed\n");
-	}
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &port);
+#endif
 }
 
 void __init
@@ -256,8 +265,4 @@ platform_init(unsigned long r3, unsigned
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
 #endif
-#ifdef CONFIG_KGDB
-	ppc_md.early_serial_map = bubinga_early_serial_map;
-#endif
 }
-
--- linux-2.6.10-rc1.orig/arch/ppc/platforms/4xx/ebony.c
+++ linux-2.6.10-rc1/arch/ppc/platforms/4xx/ebony.c
@@ -36,6 +36,7 @@
 #include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
+#include <linux/kgdb.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -282,30 +283,38 @@ ebony_early_serial_map(void)
 	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 	port.line = 0;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 0)
 		printk("Early serial init of port 0 failed\n");
-	}
-
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#endif
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Configure debug serial access */
 	gen550_init(0, &port);
 #endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &port);
+#endif
+	
 
 	port.membase = ioremap64(PPC440GP_UART1_ADDR, 8);
 	port.irq = 1;
 	port.uartclk = clocks.uart1;
 	port.line = 1;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 0)
 		printk("Early serial init of port 1 failed\n");
-	}
-
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#endif
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Configure debug serial access */
 	gen550_init(1, &port);
 #endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &port);
+#endif
 }
 
+
 static void __init
 ebony_setup_arch(void)
 {
@@ -383,8 +392,4 @@ void __init platform_init(unsigned long 
 
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
-#ifdef CONFIG_KGDB
-	ppc_md.early_serial_map = ebony_early_serial_map;
-#endif
 }
-
--- linux-2.6.10-rc1.orig/arch/ppc/platforms/4xx/ocotea.c
+++ linux-2.6.10-rc1/arch/ppc/platforms/4xx/ocotea.c
@@ -260,28 +260,34 @@ ocotea_early_serial_map(void)
 	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 	port.line = 0;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 0)
 		printk("Early serial init of port 0 failed\n");
-	}
-
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#endif
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Configure debug serial access */
 	gen550_init(0, &port);
 #endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &port);
+#endif
 
 	port.membase = ioremap64(PPC440GX_UART1_ADDR, 8);
 	port.irq = UART1_INT;
 	port.uartclk = clocks.uart1;
 	port.line = 1;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 0)
 		printk("Early serial init of port 1 failed\n");
-	}
-
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#endif
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Configure debug serial access */
 	gen550_init(1, &port);
 #endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &port);
+#endif
 }
 
 static void __init
--- linux-2.6.10-rc1.orig/arch/ppc/platforms/4xx/xilinx_ml300.c
+++ linux-2.6.10-rc1/arch/ppc/platforms/4xx/xilinx_ml300.c
@@ -42,9 +42,6 @@
  *      ppc4xx_map_io				arch/ppc/syslib/ppc4xx_setup.c
  *  start_kernel				init/main.c
  *    setup_arch				arch/ppc/kernel/setup.c
- * #if defined(CONFIG_KGDB)
- *      *ppc_md.kgdb_map_scc() == gen550_kgdb_map_scc
- * #endif
  *      *ppc_md.setup_arch == ml300_setup_arch	this file
  *        ppc4xx_setup_arch			arch/ppc/syslib/ppc4xx_setup.c
  *          ppc4xx_find_bridges			arch/ppc/syslib/ppc405_pci.c
@@ -83,7 +80,6 @@ ml300_map_io(void)
 static void __init
 ml300_early_serial_map(void)
 {
-#ifdef CONFIG_SERIAL_8250
 	struct serial_state old_ports[] = { SERIAL_PORT_DFNS };
 	struct uart_port port;
 	int i;
@@ -99,11 +95,14 @@ ml300_early_serial_map(void)
 		port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 		port.line = i;
 
-		if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+		if (early_serial_setup(&port) != 0)
 			printk("Early serial init of port %d failed\n", i);
-		}
+#endif
+#ifdef CONFIG_KGDB_8250
+		kgdb8250_add_port(i, &port)
+#endif
 	}
-#endif /* CONFIG_SERIAL_8250 */
 }
 
 void __init
@@ -156,9 +155,4 @@ platform_init(unsigned long r3, unsigned
 #if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
 	ppc_md.power_off = xilinx_power_off;
 #endif
-
-#ifdef CONFIG_KGDB
-	ppc_md.early_serial_map = ml300_early_serial_map;
-#endif
 }
-
--- linux-2.6.10-rc1.orig/arch/ppc/platforms/85xx/sbc8560.c
+++ linux-2.6.10-rc1/arch/ppc/platforms/85xx/sbc8560.c
@@ -78,8 +78,6 @@ struct ocp_fs_i2c_data mpc85xx_i2c1_def 
 	.flags = FS_I2C_SEPARATE_DFSRR,
 };
 
-
-#ifdef CONFIG_SERIAL_8250
 static void __init
 sbc8560_early_serial_map(void)
 {
@@ -95,27 +93,34 @@ sbc8560_early_serial_map(void)
         uart_req.membase = ioremap(uart_req.mapbase, MPC85xx_UART0_SIZE);
 	uart_req.type = PORT_16650;
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
-        gen550_init(0, &uart_req);
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&serial_req) != 0)
+		printk("Early serial init of port 0 failed\n");
 #endif
- 
-        if (early_serial_setup(&uart_req) != 0)
-                printk("Early serial init of port 0 failed\n");
- 
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	gen550_init(0, &serial_req);
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &port);
+#endif
+
         /* Assume early_serial_setup() doesn't modify uart_req */
 	uart_req.line = 1;
         uart_req.mapbase = UARTB_ADDR;
         uart_req.membase = ioremap(uart_req.mapbase, MPC85xx_UART1_SIZE);
 	uart_req.irq = MPC85xx_IRQ_EXT10;
- 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
-        gen550_init(1, &uart_req);
+
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&serial_req) != 0)
+		printk("Early serial init of port 1 failed\n");
 #endif
- 
-        if (early_serial_setup(&uart_req) != 0)
-                printk("Early serial init of port 1 failed\n");
-}
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	gen550_init(1, &serial_req);
 #endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &port);
+#endif
+}
 
 /* ************************************************************************
  *
@@ -144,9 +149,7 @@ sbc8560_setup_arch(void)
 	/* setup PCI host bridges */
 	mpc85xx_setup_hose();
 #endif
-#ifdef CONFIG_SERIAL_8250
 	sbc8560_early_serial_map();
-#endif
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Invalidate the entry we stole earlier the serial ports
 	 * should be properly mapped */ 
--- linux-2.6.10-rc1.orig/arch/ppc/platforms/mcpn765.c
+++ linux-2.6.10-rc1/arch/ppc/platforms/mcpn765.c
@@ -518,9 +518,4 @@ platform_init(unsigned long r3, unsigned
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
-
-	return;
 }
--- linux-2.6.10-rc1.orig/arch/ppc/platforms/pcore.c
+++ linux-2.6.10-rc1/arch/ppc/platforms/pcore.c
@@ -345,7 +345,4 @@ platform_init(unsigned long r3, unsigned
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
 }
--- linux-2.6.10-rc1.orig/arch/ppc/platforms/pplus.c
+++ linux-2.6.10-rc1/arch/ppc/platforms/pplus.c
@@ -907,9 +907,6 @@ platform_init(unsigned long r3, unsigned
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif				/* CONFIG_SERIAL_TEXT_DEBUG */
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
 #ifdef CONFIG_SMP
 	ppc_md.smp_ops = &pplus_smp_ops;
 #endif				/* CONFIG_SMP */
--- linux-2.6.10-rc1.orig/arch/ppc/platforms/spruce.c
+++ linux-2.6.10-rc1/arch/ppc/platforms/spruce.c
@@ -181,26 +181,32 @@ spruce_early_serial_map(void)
 	serial_req.membase = (u_char *)UART0_IO_BASE;
 	serial_req.regshift = 0;
 
-#if defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG)
-	gen550_init(0, &serial_req);
-#endif
 #ifdef CONFIG_SERIAL_8250
 	if (early_serial_setup(&serial_req) != 0)
 		printk("Early serial init of port 0 failed\n");
 #endif
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	gen550_init(0, &serial_req);
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &port);
+#endif
 
 	/* Assume early_serial_setup() doesn't modify serial_req */
 	serial_req.line = 1;
 	serial_req.irq = UART1_INT;
 	serial_req.membase = (u_char *)UART1_IO_BASE;
 
-#if defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG)
-	gen550_init(1, &serial_req);
-#endif
 #ifdef CONFIG_SERIAL_8250
 	if (early_serial_setup(&serial_req) != 0)
 		printk("Early serial init of port 1 failed\n");
 #endif
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	gen550_init(1, &serial_req);
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &port);
+#endif
 }
 
 TODC_ALLOC();
@@ -319,7 +325,4 @@ platform_init(unsigned long r3, unsigned
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif /* CONFIG_SERIAL_TEXT_DEBUG */
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
 }
--- linux-2.6.10-rc1.orig/arch/ppc/syslib/gen550.h
+++ linux-2.6.10-rc1/arch/ppc/syslib/gen550.h
@@ -13,4 +13,3 @@
 
 extern void gen550_progress(char *, unsigned short);
 extern void gen550_init(int, struct uart_port *);
-extern void gen550_kgdb_map_scc(void);
--- linux-2.6.10-rc1.orig/arch/ppc/syslib/ibm44x_common.c
+++ linux-2.6.10-rc1/arch/ppc/syslib/ibm44x_common.c
@@ -163,9 +163,6 @@ void __init ibm44x_platform_init(void)
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif /* CONFIG_SERIAL_TEXT_DEBUG */
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
 
 	/*
 	 * The Abatron BDI JTAG debugger does not tolerate others
--- linux-2.6.10-rc1.orig/arch/ppc/syslib/ppc85xx_setup.c
+++ linux-2.6.10-rc1/arch/ppc/syslib/ppc85xx_setup.c
@@ -69,7 +69,6 @@ mpc85xx_calibrate_decr(void)
 	mtspr(SPRN_TCR, TCR_DIE);
 }
 
-#ifdef CONFIG_SERIAL_8250
 void __init
 mpc85xx_early_serial_map(void)
 {
@@ -88,12 +87,16 @@ mpc85xx_early_serial_map(void)
 	serial_req.mapbase = duart_paddr;
 	serial_req.regshift = 0;
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
-	gen550_init(0, &serial_req);
-#endif
-
+#ifdef CONFIG_SERIAL_8250
 	if (early_serial_setup(&serial_req) != 0)
 		printk("Early serial init of port 0 failed\n");
+#endif
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	gen550_init(0, &serial_req);
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &port);
+#endif
 
 	/* Assume early_serial_setup() doesn't modify serial_req */
 	duart_paddr = binfo->bi_immr_base + MPC85xx_UART1_OFFSET;
@@ -101,14 +104,17 @@ mpc85xx_early_serial_map(void)
 	serial_req.mapbase = duart_paddr;
 	serial_req.membase = ioremap(duart_paddr, MPC85xx_UART1_SIZE);
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
-	gen550_init(1, &serial_req);
-#endif
-
+#ifdef CONFIG_SERIAL_8250
 	if (early_serial_setup(&serial_req) != 0)
 		printk("Early serial init of port 1 failed\n");
-}
 #endif
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	gen550_init(1, &serial_req);
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &port);
+#endif
+}
 
 void
 mpc85xx_restart(char *cmd)
@@ -345,5 +351,3 @@ mpc85xx_setup_hose(void)
 	return;
 }
 #endif /* CONFIG_PCI */
-
-
--- linux-2.6.10-rc1.orig/include/asm-ppc/machdep.h
+++ linux-2.6.10-rc1/include/asm-ppc/machdep.h
@@ -56,9 +56,7 @@ struct machdep_calls {
 	unsigned long	(*find_end_of_memory)(void);
 	void		(*setup_io_mappings)(void);
 
-	void		(*early_serial_map)(void);
   	void		(*progress)(char *, unsigned short);
-	void		(*kgdb_map_scc)(void);
 
 	unsigned char 	(*nvram_read_val)(int addr);
 	void		(*nvram_write_val)(int addr, unsigned char val);

-- 
Tom Rini
http://gate.crashing.org/~trini/
