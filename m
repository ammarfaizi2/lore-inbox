Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUJSGSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUJSGSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268025AbUJSGSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:18:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:4753 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268024AbUJSGRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 02:17:23 -0400
Subject: [PATCH] 2/2 : 8250 serial: dynamic port table from arch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1098166305.15029.41.camel@gaston>
References: <1098166305.15029.41.camel@gaston>
Content-Type: text/plain
Message-Id: <1098166348.11449.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 16:12:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds a ppc64 implementation of the routine providing
the list of default 8250 serial ports. It provides a empty list
by default unless the platform code fills it, and it provides
a generic function for user by Open Firmware based machines which
fills the list based on serial ports found in the OF device-tree.

It depends on the previous patch adding the generic support for
this to the 8250 driver.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-maple/arch/ppc64/kernel/setup.c
===================================================================
--- linux-maple.orig/arch/ppc64/kernel/setup.c	2004-10-19 13:37:37.000000000 +1000
+++ linux-maple/arch/ppc64/kernel/setup.c	2004-10-19 16:13:04.264555048 +1000
@@ -30,6 +30,8 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/unistd.h>
+#include <linux/serial.h>
+#include <linux/8250.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
@@ -51,6 +53,7 @@
 #include <asm/system.h>
 #include <asm/rtas.h>
 #include <asm/iommu.h>
+#include <asm/serial.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -1106,6 +1109,177 @@
 __setup("decr_overclock_proc0=", set_decr_overclock_proc0 );
 __setup("decr_overclock=", set_decr_overclock );
 
+/*
+ * This function can be used by platforms to "find" legacy serial ports.
+ * It works for "serial" nodes under an "isa" node, and will try to
+ * respect the "ibm,aix-loc" property if any. It works with up to 8
+ * ports.
+ */
+
+#define MAX_LEGACY_SERIAL_PORTS	8
+static struct old_serial_port	old_serial_ports[MAX_LEGACY_SERIAL_PORTS];
+static unsigned int		old_serial_count;
+
+void __init generic_find_legacy_serial_ports(unsigned int *default_speed)
+{
+	struct device_node *np;
+	u32 *sizeprop;
+
+	struct isa_reg_property {
+		u32 space;
+		u32 address;
+		u32 size;
+	};
+	struct pci_reg_property {
+		struct pci_address addr;
+		u32 size_hi;
+		u32 size_lo;
+	};                                                                        
+
+	DBG(" -> generic_find_legacy_serial_port()\n");
+
+	naca->serialPortAddr = 0;
+	if (default_speed)
+		*default_speed = 0;
+
+	np = of_find_node_by_path("/");
+	if (!np)
+		return;
+
+	/* First fill our array */
+	for (np = NULL; (np = of_find_node_by_type(np, "serial"));) {
+		struct device_node *isa, *pci;
+		struct isa_reg_property *reg;
+		unsigned long phys_size, addr_size, io_base;
+		u32 *rangesp;
+		u32 *interrupts, *clk, *spd;
+		char *typep;
+		int index, rlen, rentsize;
+
+		/* Ok, first check if it's under an "isa" parent */
+		isa = of_get_parent(np);
+		if (!isa || strcmp(isa->name, "isa")) {
+			DBG("%s: no isa parent found\n", np->full_name);
+			continue;
+		}
+		
+		/* Now look for an "ibm,aix-loc" property that gives us ordering
+		 * if any...
+		 */
+	 	typep = (char *)get_property(np, "ibm,aix-loc", NULL);
+
+		/* Get the ISA port number */
+		reg = (struct isa_reg_property *)get_property(np, "reg", NULL);	
+		if (reg == NULL)
+			goto next_port;
+		/* We assume the interrupt number isn't translated ... */
+		interrupts = (u32 *)get_property(np, "interrupts", NULL);
+		/* get clock freq. if present */
+		clk = (u32 *)get_property(np, "clock-frequency", NULL);
+		/* get default speed if present */
+		spd = (u32 *)get_property(np, "current-speed", NULL);
+		/* Default to locate at end of array */
+		index = old_serial_count; /* end of the array by default */
+
+		/* If we have a location index, then use it */
+		if (typep && *typep == 'S') {
+			index = simple_strtol(typep+1, NULL, 0) - 1;
+			/* if index is out of range, use end of array instead */
+			if (index >= MAX_LEGACY_SERIAL_PORTS)
+				index = old_serial_count;
+			/* if our index is still out of range, that mean that
+			 * array is full, we could scan for a free slot but that
+			 * make little sense to bother, just skip the port
+			 */
+			if (index >= MAX_LEGACY_SERIAL_PORTS)
+				goto next_port;
+			if (index >= old_serial_count)
+				old_serial_count = index + 1;
+			/* Check if there is a port who already claimed our slot */
+			if (old_serial_ports[index].port != 0) {
+				/* if we still have some room, move it, else override */
+				if (old_serial_count < MAX_LEGACY_SERIAL_PORTS) {
+					DBG("Moved legacy port %d -> %d\n", index,
+					    old_serial_count);
+					old_serial_ports[old_serial_count++] =
+						old_serial_ports[index];
+				} else {
+					DBG("Replacing legacy port %d\n", index);
+				}
+			}
+		}
+		if (index >= MAX_LEGACY_SERIAL_PORTS)
+			goto next_port;
+		if (index >= old_serial_count)
+			old_serial_count = index + 1;
+
+		/* Now fill the entry */
+		memset(&old_serial_ports[index], 0, sizeof(struct old_serial_port));
+		old_serial_ports[index].uart = 0;
+		old_serial_ports[index].baud_base = clk ? (*clk / 16) : BASE_BAUD;
+		old_serial_ports[index].port = reg->address;
+		old_serial_ports[index].irq = interrupts ? interrupts[0] : 0;
+		old_serial_ports[index].flags = ASYNC_BOOT_AUTOCONF;
+
+		DBG("Added legacy port, index: %d, port: %x, irq: %d, clk: %d\n",
+		    index,
+		    old_serial_ports[index].port,
+		    old_serial_ports[index].irq,
+		    old_serial_ports[index].baud_base * 16);
+
+		/* Get phys address of IO reg for port 1 */
+		if (index != 0)
+			goto next_port;
+
+		pci = of_get_parent(isa);
+		if (!pci) {
+			DBG("%s: no pci parent found\n", np->full_name);
+			goto next_port;
+		}
+
+		rangesp = (u32 *)get_property(pci, "ranges", &rlen);
+		if (rangesp == NULL) {
+			of_node_put(pci);
+			goto next_port;
+		}
+		rlen /= 4;
+
+		/* we need the #size-cells of the PCI bridge node itself */
+		phys_size = 1;
+		sizeprop = (u32 *)get_property(pci, "#size-cells", NULL);
+		if (sizeprop != NULL)
+			phys_size = *sizeprop;
+		/* we need the parent #addr-cells */
+		addr_size = prom_n_addr_cells(pci);
+		rentsize = 3 + addr_size + phys_size;
+		io_base = 0;
+		for (;rlen >= rentsize; rlen -= rentsize,rangesp += rentsize) {
+			if (((rangesp[0] >> 24) & 0x3) != 1)
+				continue; /* not IO space */
+			io_base = rangesp[3];
+			if (addr_size == 2)
+				io_base = (io_base << 32) | rangesp[4];
+		}
+		if (io_base != 0) {
+			naca->serialPortAddr = io_base + reg->address;
+			if (default_speed && spd)
+				*default_speed = *spd;
+		}
+		of_node_put(pci);
+	next_port:
+		of_node_put(isa);
+	}
+
+	DBG(" <- generic_find_legacy_serial_port()\n");
+}
+
+struct old_serial_port *get_legacy_serial_ports(unsigned int *count)
+{
+	*count = old_serial_count;
+	return old_serial_ports;
+}
+EXPORT_SYMBOL(get_legacy_serial_ports);
+
 #ifdef CONFIG_XMON
 static int __init early_xmon(char *p)
 {
Index: linux-maple/arch/ppc64/kernel/udbg.c
===================================================================
--- linux-maple.orig/arch/ppc64/kernel/udbg.c	2004-10-19 13:37:19.000000000 +1000
+++ linux-maple/arch/ppc64/kernel/udbg.c	2004-10-19 16:13:04.274553528 +1000
@@ -49,15 +49,28 @@
 
 static volatile struct NS16550 *udbg_comport;
 
-void udbg_init_uart(void *comport)
+void udbg_init_uart(void *comport, unsigned int speed)
 {
+	u8 dll = 12;
+
+	switch(speed) {
+	case 115200:
+		dll = 1;
+		break;
+	case 57600:
+		dll = 2;
+		break;
+	case 38400:
+		dll = 3;
+		break;
+	}
 	if (comport) {
 		udbg_comport = (struct NS16550 *)comport;
 		udbg_comport->lcr = 0x00; eieio();
 		udbg_comport->ier = 0xFF; eieio();
 		udbg_comport->ier = 0x00; eieio();
 		udbg_comport->lcr = 0x80; eieio();	/* Access baud rate */
-		udbg_comport->dll = 12;   eieio();	/* 1 = 115200,  2 = 57600, 3 = 38400, 12 = 9600 baud */
+		udbg_comport->dll = dll;   eieio();	/* 1 = 115200,  2 = 57600, 3 = 38400, 12 = 9600 baud */
 		udbg_comport->dlm = 0;    eieio();	/* dll >> 8 which should be zero for fast rates; */
 		udbg_comport->lcr = 0x03; eieio();	/* 8 data, 1 stop, no parity */
 		udbg_comport->mcr = 0x03; eieio();	/* RTS/DTR */
Index: linux-maple/include/asm-ppc64/serial.h
===================================================================
--- linux-maple.orig/include/asm-ppc64/serial.h	2004-10-19 13:37:55.000000000 +1000
+++ linux-maple/include/asm-ppc64/serial.h	2004-10-19 16:13:04.283552160 +1000
@@ -18,113 +18,13 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-#define BASE_BAUD ( 1843200 / 16 )
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define RS_TABLE_SIZE  64
-#else
-#define RS_TABLE_SIZE  4
-#endif
-
-/* Standard COM flags (except for COM4, because of the 8514 problem) */
-#ifdef CONFIG_SERIAL_DETECT_IRQ
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
-#else
-#define STD_COM_FLAGS ASYNC_BOOT_AUTOCONF
-#endif
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#define HUB6_FLAGS 0
-#endif
-	
-/*
- * The following define the access methods for the HUB6 card. All
- * access is through two ports for all 24 possible chips. The card is
- * selected through the high 2 bits, the port on that card with the
- * "middle" 3 bits, and the register on that port with the bottom
- * 3 bits.
- *
- * While the access port and interrupt is configurable, the default
- * port locations are 0x302 for the port control register, and 0x303
- * for the data read/write register. Normally, the interrupt is at irq3
- * but can be anything from 3 to 7 inclusive. Note that using 3 will
- * require disabling com2.
- */
-
-#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
 
-#define STD_SERIAL_PORT_DEFNS			\
-	/* UART CLK   PORT IRQ     FLAGS        */			\
-	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
-	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
-	{ 0, BASE_BAUD, 0x890, 0xf, STD_COM_FLAGS },	/* ttyS2 */	\
-	{ 0, BASE_BAUD, 0x898, 0xe, STD_COM_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-/* You can have up to four HUB6's in the system, but I've only
- * included two cards here for a total of twelve ports.
- */
-#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
-#define HUB6_SERIAL_PORT_DFNS		\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
-#else
-#define HUB6_SERIAL_PORT_DFNS
-#endif
-
-#define MCA_SERIAL_PORT_DFNS
+/* Default baud base if not found in device-tree */
+#define BASE_BAUD ( 1843200 / 16 )
 
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS		\
-	HUB6_SERIAL_PORT_DFNS		\
-	MCA_SERIAL_PORT_DFNS
+#define ARCH_HAS_GET_LEGACY_SERIAL_PORTS
+struct old_serial_port;
+extern struct old_serial_port *get_legacy_serial_ports(unsigned int *count);
+#define UART_NR	(8 + CONFIG_SERIAL_8250_NR_UARTS)
 
 #endif /* _PPC64_SERIAL_H */
Index: linux-maple/arch/ppc64/kernel/pSeries_setup.c
===================================================================
--- linux-maple.orig/arch/ppc64/kernel/pSeries_setup.c	2004-10-19 13:37:21.000000000 +1000
+++ linux-maple/arch/ppc64/kernel/pSeries_setup.c	2004-10-19 16:13:04.304548968 +1000
@@ -82,6 +82,8 @@
 extern int  pSeries_set_rtc_time(struct rtc_time *rtc_time);
 extern void find_udbg_vterm(void);
 extern void SystemReset_FWNMI(void), MachineCheck_FWNMI(void);	/* from head.S */
+extern void generic_find_legacy_serial_ports(unsigned int *default_speed);
+
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
 unsigned long  virtPython0Facilities = 0;  // python0 facility area (memory mapped io) (64-bit format) VIRTUAL address.
@@ -189,75 +191,6 @@
 arch_initcall(pSeries_init_panel);
 
 
-
-void __init pSeries_find_serial_port(void)
-{
-	struct device_node *np;
-	unsigned long encode_phys_size = 32;
-	u32 *sizeprop;
-
-	struct isa_reg_property {
-		u32 space;
-		u32 address;
-		u32 size;
-	};
-	struct pci_reg_property {
-		struct pci_address addr;
-		u32 size_hi;
-		u32 size_lo;
-	};                                                                        
-
-	DBG(" -> pSeries_find_serial_port()\n");
-
-	naca->serialPortAddr = 0;
-
-	np = of_find_node_by_path("/");
-	if (!np)
-		return;
-	sizeprop = (u32 *)get_property(np, "#size-cells", NULL);
-	if (sizeprop != NULL)
-		encode_phys_size = (*sizeprop) << 5;
-	
-	for (np = NULL; (np = of_find_node_by_type(np, "serial"));) {
-		struct device_node *isa, *pci;
-		struct isa_reg_property *reg;
-		union pci_range *rangesp;
-		char *typep;
-
-	 	typep = (char *)get_property(np, "ibm,aix-loc", NULL);
-		if ((typep == NULL) || (typep && strcmp(typep, "S1")))
-			continue;
-
-		reg = (struct isa_reg_property *)get_property(np, "reg", NULL);	
-
-		isa = of_get_parent(np);
-		if (!isa) {
-			DBG("no isa parent found\n");
-			break;
-		}
-		pci = of_get_parent(isa);
-		if (!pci) {
-			DBG("no pci parent found\n");
-			break;
-		}
-
-		rangesp = (union pci_range *)get_property(pci, "ranges", NULL);
-
-		if ( encode_phys_size == 32 )
-			naca->serialPortAddr = rangesp->pci32.phys+reg->address;
-		else {
-			naca->serialPortAddr =
-				((((unsigned long)rangesp->pci64.phys_hi) << 32)
-				|
-			(rangesp->pci64.phys_lo)) + reg->address;
-		}
-		break;
-	}
-
-	DBG(" <- pSeries_find_serial_port()\n");
-}
-
-
 /* Build up the firmware_features bitmask field
  * using contents of device-tree/ibm,hypertas-functions.
  * Ultimately this functionality may be moved into prom.c prom_init().
@@ -337,6 +270,7 @@
 {
 	void *comport;
 	int iommu_off = 0;
+	unsigned int default_speed;
 
 	DBG(" -> pSeries_init_early()\n");
 
@@ -350,14 +284,14 @@
 			     get_property(of_chosen, "linux,iommu-off", NULL));
 	}
 
-	pSeries_find_serial_port();
+	generic_find_legacy_serial_ports(&default_speed);
 
 	if (systemcfg->platform & PLATFORM_LPAR)
 		find_udbg_vterm();
 	else if (naca->serialPortAddr) {
 		/* Map the uart for udbg. */
 		comport = (void *)__ioremap(naca->serialPortAddr, 16, _PAGE_NO_CACHE);
-		udbg_init_uart(comport);
+		udbg_init_uart(comport, default_speed);
 
 		ppc_md.udbg_putc = udbg_putc;
 		ppc_md.udbg_getc = udbg_getc;
Index: linux-maple/include/asm-ppc64/udbg.h
===================================================================
--- linux-maple.orig/include/asm-ppc64/udbg.h	2004-10-19 13:37:22.000000000 +1000
+++ linux-maple/include/asm-ppc64/udbg.h	2004-10-19 16:13:04.305548816 +1000
@@ -10,7 +10,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-void udbg_init_uart(void *comport);
+void udbg_init_uart(void *comport, unsigned int speed);
 void udbg_putc(unsigned char c);
 unsigned char udbg_getc(void);
 int udbg_getc_poll(void);


