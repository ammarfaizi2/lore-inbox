Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUJ3BRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUJ3BRs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263543AbUJ3BOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 21:14:37 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45531 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S263555AbUJ3BIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 21:08:32 -0400
Date: Fri, 29 Oct 2004 18:08:14 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org,
       trini@kernel.crashing.org, takeharu1219@ybb.ne.jp
Subject: [PATCH][PPC32][2/2] 40x and Book E debug: 4xx platform support
Message-ID: <20041029180814.A15758@home.com>
References: <20041029175158.D13435@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041029175158.D13435@home.com>; from mporter@kernel.crashing.org on Fri, Oct 29, 2004 at 05:51:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to the 40x and 44x platform code for
initializing debug events and using the in-kernel kgdb stub.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff -Nru a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig	2004-10-29 17:22:22 -07:00
+++ b/arch/ppc/platforms/4xx/Kconfig	2004-10-29 17:22:22 -07:00
@@ -201,7 +201,7 @@
 
 config PPC_GEN550
 	bool
-	depends on 44x
+	depends on 4xx
 	default y
 
 config PM
diff -Nru a/arch/ppc/platforms/4xx/ebony.c b/arch/ppc/platforms/4xx/ebony.c
--- a/arch/ppc/platforms/4xx/ebony.c	2004-10-29 17:22:22 -07:00
+++ b/arch/ppc/platforms/4xx/ebony.c	2004-10-29 17:22:22 -07:00
@@ -313,14 +313,6 @@
 	struct ocp_def *def;
 	struct ocp_func_emac_data *emacdata;
 
-#if !defined(CONFIG_BDI_SWITCH)
-	/*
-	 * The Abatron BDI JTAG debugger does not tolerate others
-	 * mucking with the debug registers.
-	 */
-        mtspr(SPRN_DBCR0, (DBCR0_TDE | DBCR0_IDM));
-#endif
-
 	/* Set mac_addr for each EMAC */
 	vpd_base = ioremap64(EBONY_VPD_BASE, EBONY_VPD_SIZE);
 	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
diff -Nru a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
--- a/arch/ppc/platforms/4xx/ocotea.c	2004-10-29 17:22:22 -07:00
+++ b/arch/ppc/platforms/4xx/ocotea.c	2004-10-29 17:22:22 -07:00
@@ -291,14 +291,6 @@
 
 	ibm440gx_tah_enable();
 
-#if !defined(CONFIG_BDI_SWITCH)
-	/*
-	 * The Abatron BDI JTAG debugger does not tolerate others
-	 * mucking with the debug registers.
-	 */
-        mtspr(SPRN_DBCR0, (DBCR0_TDE | DBCR0_IDM));
-#endif
-
 	/* Setup TODC access */
 	TODC_INIT(TODC_TYPE_DS1743,
 			0,
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2004-10-29 17:22:22 -07:00
+++ b/arch/ppc/syslib/Makefile	2004-10-29 17:22:22 -07:00
@@ -25,7 +25,6 @@
 obj-$(CONFIG_PPC4xx_DMA)	+= ppc4xx_dma.o
 obj-$(CONFIG_PPC4xx_EDMA)	+= ppc4xx_sgdma.o
 ifeq ($(CONFIG_40x),y)
-obj-$(CONFIG_KGDB)		+= ppc4xx_kgdb.o
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o ppc405_pci.o
 endif
 endif
diff -Nru a/arch/ppc/syslib/ibm44x_common.c b/arch/ppc/syslib/ibm44x_common.c
--- a/arch/ppc/syslib/ibm44x_common.c	2004-10-29 17:22:22 -07:00
+++ b/arch/ppc/syslib/ibm44x_common.c	2004-10-29 17:22:22 -07:00
@@ -166,5 +166,17 @@
 #ifdef CONFIG_KGDB
 	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
 #endif
+
+	/*
+	 * The Abatron BDI JTAG debugger does not tolerate others
+	 * mucking with the debug registers.
+	 */
+#if !defined(CONFIG_BDI_SWITCH)
+	/* Enable internal debug mode */
+        mtspr(SPRN_DBCR0, (DBCR0_IDM));
+
+	/* Clear any residual debug events */
+	mtspr(SPRN_DBSR, 0xffffffff);
+#endif
 }
 
diff -Nru a/arch/ppc/syslib/ppc4xx_setup.c b/arch/ppc/syslib/ppc4xx_setup.c
--- a/arch/ppc/syslib/ppc4xx_setup.c	2004-10-29 17:22:22 -07:00
+++ b/arch/ppc/syslib/ppc4xx_setup.c	2004-10-29 17:22:22 -07:00
@@ -42,6 +42,8 @@
 #include <asm/pci-bridge.h>
 #include <asm/bootinfo.h>
 
+#include <syslib/gen550.h>
+
 /* Function Prototypes */
 extern void abort(void);
 extern void ppc4xx_find_bridges(void);
@@ -56,8 +58,16 @@
 void __init
 ppc4xx_setup_arch(void)
 {
-	/* Setup PCI host bridges */
+#if !defined(CONFIG_BDI_SWITCH)
+	/*
+	 * The Abatron BDI JTAG debugger does not tolerate others
+	 * mucking with the debug registers.
+	 */
+        mtspr(SPRN_DBCR0, (DBCR0_IDM));
+	mtspr(SPRN_DBSR, 0xffffffff);
+#endif
 
+	/* Setup PCI host bridges */
 #ifdef CONFIG_PCI
 	ppc4xx_find_bridges();
 #endif
@@ -189,34 +199,6 @@
 	/* Set the PIT reload value and just let it run. */
 	mtspr(SPRN_PIT, tb_ticks_per_jiffy);
 }
-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-
-/* We assume that the UART has already been initialized by the
-   firmware or the boot loader */
-static void
-serial_putc(u8 * com_port, unsigned char c)
-{
-	while ((readb(com_port + (UART_LSR)) & UART_LSR_THRE) == 0) ;
-	writeb(c, com_port);
-}
-
-static void
-ppc4xx_progress(char *s, unsigned short hex)
-{
-	char c;
-#ifdef SERIAL_DEBUG_IO_BASE
-	u8 *com_port = (u8 *) SERIAL_DEBUG_IO_BASE;
-
-	while ((c = *s++) != '\0') {
-		serial_putc(com_port, c);
-	}
-	serial_putc(com_port, '\r');
-	serial_putc(com_port, '\n');
-#else
-	printk("%s\r\n");
-#endif
-}
-#endif				/* CONFIG_SERIAL_TEXT_DEBUG */
 
 /*
  * IDE stuff.
@@ -319,13 +301,9 @@
 	ppc_md.setup_io_mappings = ppc4xx_map_io;
 
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress = ppc4xx_progress;
+	ppc_md.progress = gen550_progress;
 #endif
 
-/*
-**   m8xx_setup.c, prep_setup.c use
-**     defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-*/
 #if defined(CONFIG_PCI) && defined(CONFIG_IDE)
 	ppc_ide_md.ide_init_hwif = ppc4xx_ide_init_hwif_ports;
 #endif /* defined(CONFIG_PCI) && defined(CONFIG_IDE) */
