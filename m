Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVADTZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVADTZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVADTZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:25:09 -0500
Received: from mail242.megamailservers.com ([216.251.41.62]:52117 "EHLO
	mail242.megamailservers.com") by vger.kernel.org with ESMTP
	id S261821AbVADTDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:03:33 -0500
X-Authenticated-User: jiri.gaisler.com
Message-ID: <41DAE8B4.6060109@gaisler.com>
Date: Tue, 04 Jan 2005 20:04:20 +0100
From: Jiri Gaisler <jiri@gaisler.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: sparclinux@vger.kernel.org
CC: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: [4/7] LEON SPARC V8 processor support for linux-2.6.10
Content-Type: multipart/mixed;
 boundary="------------040207010106040708080102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040207010106040708080102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Leon3 serial+ethermac driver:

[4/7] diff2.6.10_driver_amba.diff         diff for drivers/amba

--------------040207010106040708080102
Content-Type: text/plain;
 name="diff2.6.10_driver_amba.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff2.6.10_driver_amba.diff"

diff -Naur ../linux-2.6.10/drivers/Makefile linux-2.6.10/drivers/Makefile
--- ../linux-2.6.10/drivers/Makefile	2004-12-24 22:36:00.000000000 +0100
+++ linux-2.6.10/drivers/Makefile	2005-01-03 11:36:33.000000000 +0100
@@ -60,3 +60,4 @@
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-y				+= firmware/
+obj-$(CONFIG_LEON_3)            += amba/
diff -Naur ../linux-2.6.10/drivers/amba/Kconfig linux-2.6.10/drivers/amba/Kconfig
--- ../linux-2.6.10/drivers/amba/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/Kconfig	2005-01-03 17:10:41.000000000 +0100
@@ -0,0 +1,12 @@
+
+#------------------------------------------------------------------------------
+# Amba device driver configuration
+#------------------------------------------------------------------------------
+
+menu "Grlib: Amba device driver configuration"
+
+source "drivers/amba/gaisler/Kconfig"
+source "drivers/amba/opencores/Kconfig"
+
+endmenu
+
diff -Naur ../linux-2.6.10/drivers/amba/Makefile linux-2.6.10/drivers/amba/Makefile
--- ../linux-2.6.10/drivers/amba/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/Makefile	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,7 @@
+#
+# Makefile for the PCI bus specific drivers.
+#
+
+obj-y		+= amba.o amba_driver.o
+
+obj-y           += gaisler/ opencores/
diff -Naur ../linux-2.6.10/drivers/amba/amba.c linux-2.6.10/drivers/amba/amba.c
--- ../linux-2.6.10/drivers/amba/amba.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/amba.c	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,181 @@
+#include <linux/config.h>
+#include <linux/ptrace.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <asm/leon.h>
+
+//#define DEBUG_CONFIG
+
+/* Structure containing address to devices found on the Amba Plug&Play bus */
+amba_confarea_type amba_conf;
+
+/* Pointers to Interrupt Controller configuration registers */
+volatile LEON3_IrqCtrl_Regs_Map *LEON3_IrqCtrl_Regs = 0;
+volatile LEON3_GpTimer_Regs_Map *LEON3_GpTimer_Regs = 0;
+unsigned long LEON3_GpTimer_Irq = 0;
+
+static void vendor_dev_string(unsigned long conf, char *vendorbuf,char *devbuf) {
+  int vendor = amba_vendor(conf); int dev = amba_device(conf);
+  char *devstr; char *vendorstr; 
+  sprintf(vendorbuf, "Unknown vendor %2x",vendor);
+  sprintf(devbuf, "Unknown device %2x",dev);
+  vendorstr = vendor_id2str(vendor);
+  if (vendorstr) {
+    sprintf(vendorbuf, "%s",vendorstr);
+  } 
+  devstr = device_id2str(vendor,dev);
+  if (devstr) {
+    sprintf(devbuf, "%s",devstr);
+  }
+}
+
+void amba_prinf_config(void)  
+{
+  char devbuf[128]; char vendorbuf[128]; unsigned int conf;
+  int i = 0; int j = 0; 
+  unsigned int addr; unsigned int m;
+  printk("             Vendors         Slaves\n");
+  printk("Ahb masters:\n");
+  i = 0;
+  while (i < amba_conf.ahbmst.devnr) 
+  {
+    conf = amba_get_confword(amba_conf.ahbmst, i, 0);
+    vendor_dev_string(conf,vendorbuf,devbuf);
+    printk("%2i(%2x:%3x|%2i): %16s %16s \n", i, amba_vendor(conf), amba_device(conf), amba_irq(conf), vendorbuf, devbuf);
+    for (j = 0;j < 4;j++) {
+      m = amba_ahb_get_membar(amba_conf.ahbmst,i,j);
+      if (m) {
+        addr = amba_membar_start(m);
+        printk(" +%i: 0x%x \n", j, addr);
+      }
+    }
+    i++;
+  }
+  printk("Ahb slaves:\n");
+  i = 0;
+  while (i < amba_conf.ahbslv.devnr) 
+  {
+    conf = amba_get_confword(amba_conf.ahbslv, i, 0);
+    vendor_dev_string(conf,vendorbuf,devbuf);
+    printk("%2i(%2x:%3x|%2i): %16s %16s \n", i, amba_vendor(conf), amba_device(conf), amba_irq(conf), vendorbuf, devbuf);
+    for (j = 0;j < 4;j++) {
+      m = amba_ahb_get_membar(amba_conf.ahbslv,i,j);
+      if (m) {
+        addr = amba_membar_start(m);
+	if (amba_membar_type(m) == AMBA_TYPE_AHBIO) {
+	  addr = AMBA_TYPE_AHBIO_ADDR(addr);
+	} else if (amba_membar_type(m) == AMBA_TYPE_APBIO) {
+	  printk("Warning: apbio membar\n");
+	}
+	printk(" +%i: 0x%x (raw:0x%x)\n", j, addr, m);
+      }
+    }
+    i++;
+  }
+  printk("Apb slaves:\n");
+  i = 0;
+  while (i < amba_conf.apbslv.devnr) 
+  {
+    
+    conf = amba_get_confword(amba_conf.apbslv, i, 0);
+    vendor_dev_string(conf,vendorbuf,devbuf);
+    printk("%2i(%2x:%3x|%2i): %16s %16s \n", i, amba_vendor(conf), amba_device(conf), amba_irq(conf), vendorbuf, devbuf);
+    
+    m = amba_apb_get_membar(amba_conf.apbslv, i);
+    addr = amba_iobar_start(amba_conf.apbmst, m);
+    printk(" +%2i: 0x%x (raw:0x%x) \n", 0, addr, m);
+    
+    i++;
+    
+  }
+  
+}
+
+#define amba_insert_device(tab, address) \
+{ \
+  if (LEON3_BYPASS_LOAD_PA(address)) \
+  { \
+    (tab)->addr[(tab)->devnr] = (address); \
+    (tab)->devnr ++; \
+  } \
+} while(0)
+
+/*
+ *  Used to scan system bus. Probes for AHB masters, AHB slaves and 
+ *  APB slaves. Addresses to configuration areas of the AHB masters,
+ *  AHB slaves, APB slaves and APB master are storeds in 
+ *  amba_ahb_masters, amba_ahb_slaves and amba.
+ */
+
+void amba_init(void) 
+{
+  unsigned int *cfg_area;  /* address to configuration area */
+  unsigned int mbar, conf;
+  int i, j;
+  
+#ifdef DEBUG_CONFIG
+  printk("Reading AMBA Plug&Play configuration area\n");
+#endif
+
+  memset(&amba_conf,0,sizeof(amba_conf));
+  //amba_conf.ahbmst.devnr = 0; amba_conf.ahbslv.devnr = 0; amba_conf.apbslv.devnr = 0;
+  
+  cfg_area = (unsigned int *) (LEON3_IO_AREA | LEON3_CONF_AREA);
+
+  for (i = 0; i < LEON3_AHB_MASTERS; i++) 
+  {
+    amba_insert_device(&amba_conf.ahbmst, cfg_area);
+    cfg_area += LEON3_AHB_CONF_WORDS;
+  }
+
+  cfg_area = (unsigned int *) (LEON3_IO_AREA | LEON3_CONF_AREA | LEON3_AHB_SLAVE_CONF_AREA);
+  for (i = 0; i < LEON3_AHB_SLAVES; i++) 
+  {
+    amba_insert_device(&amba_conf.ahbslv, cfg_area);
+    cfg_area += LEON3_AHB_CONF_WORDS;
+  }  
+
+  for (i = 0; i < amba_conf.ahbslv.devnr; i ++) 
+  {
+    conf = amba_get_confword(amba_conf.ahbslv, i, 0);
+    mbar = amba_ahb_get_membar(amba_conf.ahbslv, i, 0);
+    if ((amba_vendor(conf) == VENDOR_GAISLER) && (amba_device(conf) == GAISLER_APBMST))
+    {
+      amba_conf.apbmst = amba_membar_start(mbar);
+      cfg_area = (unsigned int *) (amba_conf.apbmst | LEON3_CONF_AREA);
+      
+      printk("Found apbmst, cfg: 0x%x\n",(unsigned int)cfg_area);
+      
+      for (j = amba_conf.apbslv.devnr; j < LEON3_APB_SLAVES; j++)
+      {
+	amba_insert_device(&amba_conf.apbslv, cfg_area);
+	cfg_area += LEON3_APB_CONF_WORDS;
+      }
+    }
+  }    
+ 
+  /* Find LEON3 Interrupt controler */
+  LEON3_IrqCtrl_Regs = (volatile LEON3_IrqCtrl_Regs_Map *) amba_find_apbslv_addr(VENDOR_GAISLER, GAISLER_IRQMP, 0);
+  LEON3_GpTimer_Regs = (volatile LEON3_GpTimer_Regs_Map *) amba_find_apbslv_addr(VENDOR_GAISLER, GAISLER_GPTIMER, &LEON3_GpTimer_Irq);
+  if (LEON3_IrqCtrl_Regs) {
+    LEON3_BYPASS_STORE_PA(&(LEON3_IrqCtrl_Regs ->mask[0]),0);
+  }
+}
+
+unsigned long amba_find_apbslv_addr(unsigned long vendor, unsigned long device, unsigned long *irq) {
+  unsigned int i,conf,iobar;
+  for (i = 0; i < amba_conf.apbslv.devnr; i++) {
+    conf = amba_get_confword(amba_conf.apbslv, i, 0);
+    if ((amba_vendor(conf) == vendor) && (amba_device(conf) == device))
+    {
+      if (irq) {
+        *irq = amba_irq(conf);
+      }
+      iobar = amba_apb_get_membar(amba_conf.apbslv, i);
+      return amba_iobar_start(amba_conf.apbmst, iobar);
+    }
+  }
+  return 0;
+}
diff -Naur ../linux-2.6.10/drivers/amba/amba_driver.c linux-2.6.10/drivers/amba/amba_driver.c
--- ../linux-2.6.10/drivers/amba/amba_driver.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/amba_driver.c	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,78 @@
+#include <linux/config.h>
+#include <linux/ptrace.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <asm/leon.h>
+
+//#define DEBUG_CONFIG
+
+/* Structure containing address to devices found on the Amba Plug&Play bus */
+extern amba_confarea_type amba_conf;
+ 
+//collect apb slaves
+int amba_get_free_apbslv_devices (int vendor, int device, amba_apb_device *dev,int nr) {
+  unsigned int i,conf,iobar,j = 0;
+#ifdef DEBUG_CONFIG
+    printk("Apbslv: search for apdslv devices\n");
+#endif
+  for (i = 0; i < amba_conf.apbslv.devnr && j < nr; i++) {
+    conf = amba_get_confword(amba_conf.apbslv, i, 0);
+#ifdef DEBUG_CONFIG
+    printk("Apbslv: check(%x:%x)==(%x:%x)\n",vendor,device,amba_vendor(conf),amba_device(conf));
+#endif
+    if ((amba_vendor(conf) == vendor) && (amba_device(conf) == device)) {
+      if (!(amba_conf.apbslv.allocbits[i / 32] & (1 << (i & (32-1))))) {
+#ifdef DEBUG_CONFIG
+        printk("Apbslv: alloc device idx %i (%x:%x)\n",j,vendor,device);
+#endif
+        amba_conf.apbslv.allocbits[i / 32] |= (1 << (i & (32-1)));
+        dev[j].irq = amba_irq(conf);
+        iobar = amba_apb_get_membar(amba_conf.apbslv, i);
+        dev[j].start = amba_iobar_start(amba_conf.apbmst, iobar);
+#ifdef DEBUG_CONFIG
+	printk(" +bar: 0x%x \n", k, dev[j].start);
+#endif
+        j++;
+      }
+    }
+  }
+  return j;
+}
+
+//collect ahb slaves
+int amba_get_free_ahbslv_devices (int vendor, int device, amba_ahb_device *dev,int nr) {
+  unsigned int addr, i,conf,iobar,j = 0,k;
+#ifdef DEBUG_CONFIG
+    printk("Ahbslv: search for ahdslv devices\n");
+#endif
+  for (i = 0; i < amba_conf.ahbslv.devnr && j < nr; i++) {
+    conf = amba_get_confword(amba_conf.ahbslv, i, 0);
+#ifdef DEBUG_CONFIG
+    printk("Ahbslv: check(%x:%x)==(%x:%x)\n",vendor,device,amba_vendor(conf),amba_device(conf));
+#endif
+    if ((amba_vendor(conf) == vendor) && (amba_device(conf) == device)) {
+      if (!(amba_conf.ahbslv.allocbits[i / 32] & (1 << (i & (32-1))))) {
+#ifdef DEBUG_CONFIG
+        printk("Ahbslv: alloc device idx %i (%x:%x)\n",j,vendor,device);
+#endif
+        amba_conf.ahbslv.allocbits[i / 32] |= (1 << (i & (32-1)));
+        dev[j].irq = amba_irq(conf);
+	for (k = 0; k < 4; k ++) {
+	  iobar = amba_ahb_get_membar(amba_conf.ahbslv, i, k);
+	  addr = amba_membar_start(iobar);
+	  if (amba_membar_type(iobar) == AMBA_TYPE_AHBIO) {
+	    addr = AMBA_TYPE_AHBIO_ADDR(addr);
+	  }
+	  dev[j].start[k] = addr;
+#ifdef DEBUG_CONFIG
+	  printk(" +%i: 0x%x \n", k, dev[j].start[k]);
+#endif
+	}
+        j++;
+      }
+    }
+  }
+  return j;
+}
diff -Naur ../linux-2.6.10/drivers/amba/gaisler/Kconfig linux-2.6.10/drivers/amba/gaisler/Kconfig
--- ../linux-2.6.10/drivers/amba/gaisler/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/gaisler/Kconfig	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,12 @@
+
+menu "Vendor Gaisler"
+
+config GRLIB_GAISLER_APBUART
+	bool "Grlib apbuart driver" 
+	default y
+	---help---
+	  Add the driver for the grlib apbuart serial core.
+
+endmenu
+
+
diff -Naur ../linux-2.6.10/drivers/amba/gaisler/Makefile linux-2.6.10/drivers/amba/gaisler/Makefile
--- ../linux-2.6.10/drivers/amba/gaisler/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/gaisler/Makefile	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,3 @@
+
+obj-$(CONFIG_GRLIB_GAISLER_APBUART)		+= apbuart/ 
+
diff -Naur ../linux-2.6.10/drivers/amba/gaisler/apbuart/Makefile linux-2.6.10/drivers/amba/gaisler/apbuart/Makefile
--- ../linux-2.6.10/drivers/amba/gaisler/apbuart/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/gaisler/apbuart/Makefile	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,3 @@
+
+obj-y		+= apbuart.o
+
diff -Naur ../linux-2.6.10/drivers/amba/gaisler/apbuart/apbuart.c linux-2.6.10/drivers/amba/gaisler/apbuart/apbuart.c
--- ../linux-2.6.10/drivers/amba/gaisler/apbuart/apbuart.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/gaisler/apbuart/apbuart.c	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,729 @@
+/*
+ *  linux/drivers/serial/leon.c
+ *
+ *  Driver for Leon serial ports
+ *
+ *  Based on linux/drivers/serial/amba.c , Documentation/serial/driver
+ * 
+ *  Copyright 1999 ARM Limited
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd.
+ * 
+ *  Modified for Leon by Konrad Eisele <eiselekd@web.de>, 2003
+ */
+ 
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/tty.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/serial.h>
+#include <linux/console.h>
+#include <linux/sysrq.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/oplib.h>
+
+#if defined(CONFIG_SERIAL_LEON_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/serial_core.h>
+#include <asm/leon.h>
+
+#define UART_NR		8
+int leon_ports_nr = 0;
+
+#define SERIAL_LEON_MAJOR	TTY_MAJOR
+#define SERIAL_LEON_MINOR	64
+#define SERIAL_LEON_NR		UART_NR
+
+#define AMBA_ISR_PASS_LIMIT	256
+
+#define APBBASE(port) ((LEON3_APBUART_Regs_Map *)((port)->membase))
+
+#define APBBASE_DATA_P(port) (&(APBBASE(port)->data))
+#define APBBASE_STATUS_P(port) (&(APBBASE(port)->status))
+#define APBBASE_CTRL_P(port) (&(APBBASE(port)->ctrl))
+#define APBBASE_SCALAR_P(port) (&(APBBASE(port)->scaler))
+
+#define UART_GET_CHAR(port)	(LEON_BYPASS_LOAD_PA(APBBASE_DATA_P(port)))
+#define UART_PUT_CHAR(port, v)	(LEON_BYPASS_STORE_PA(APBBASE_DATA_P(port),v))
+#define UART_GET_STATUS(port)	(LEON_BYPASS_LOAD_PA(APBBASE_STATUS_P(port)))
+#define UART_PUT_STATUS(port,v)	(LEON_BYPASS_STORE_PA(APBBASE_STATUS_P(port),v))
+#define UART_GET_CTRL(port)   (LEON_BYPASS_LOAD_PA(APBBASE_CTRL_P(port)))
+#define UART_PUT_CTRL(port,v) (LEON_BYPASS_STORE_PA(APBBASE_CTRL_P(port),v))
+#define UART_GET_SCAL(port)   (LEON_BYPASS_LOAD_PA(APBBASE_SCALAR_P(port)))
+#define UART_PUT_SCAL(port,v) (LEON_BYPASS_STORE_PA(APBBASE_SCALAR_P(port),v))
+#define UART_RX_DATA(s)       (((s) & LEON_REG_UART_STATUS_DR) != 0)
+#define UART_TX_READY(s)	(((s) & LEON_REG_UART_STATUS_THE) != 0)
+
+#define UART_DUMMY_RSR_RX	0x8000 /* for ignore all read */
+
+/* We wrap our port structure around the generic uart_port */
+struct uart_leon_port {
+	struct uart_port	port;
+	unsigned int		old_status;
+};
+
+static void leonuart_stop_tx(struct uart_port *port, unsigned int tty_stop)
+{
+	unsigned int cr;
+
+	cr = UART_GET_CTRL(port);
+	cr &= ~LEON_REG_UART_CTRL_TI; 
+	UART_PUT_CTRL(port, cr);
+}
+
+//static 
+void leonuart_tx_chars(struct uart_port *port);
+static void leonuart_start_tx(struct uart_port *port, unsigned int tty_start)
+{
+	unsigned int cr;
+
+	cr = UART_GET_CTRL(port);
+	cr |= LEON_REG_UART_CTRL_TI; 
+	UART_PUT_CTRL(port, cr);
+	
+	if (UART_GET_STATUS(port) & LEON_REG_UART_STATUS_THE) {
+	  leonuart_tx_chars (port);
+	}
+}
+
+static void leonuart_stop_rx(struct uart_port *port)
+{
+	unsigned int cr;
+
+	cr = UART_GET_CTRL(port);
+	cr &= ~(LEON_REG_UART_CTRL_RI);
+	UART_PUT_CTRL(port, cr);
+}
+
+static void leonuart_enable_ms(struct uart_port *port)
+{
+	/* no modem status for leon */
+}
+
+//static 
+void
+#ifdef SUPPORT_SYSRQ
+leonuart_rx_chars(struct uart_port *port, struct pt_regs *regs)
+#else
+leonuart_rx_chars(struct uart_port *port)
+#endif
+{
+	struct tty_struct *tty = port->info->tty;
+	unsigned int status, ch, rsr;
+
+	status = UART_GET_STATUS(port); 
+	if (UART_RX_DATA(status)) {
+      
+            if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
+			tty->flip.work.func((void *)tty);
+			if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
+				printk(KERN_WARNING "TTY_DONT_FLIP set\n");
+				return;
+			}
+		}
+
+		ch = UART_GET_CHAR(port); 
+
+		*tty->flip.char_buf_ptr = ch;
+		*tty->flip.flag_buf_ptr = TTY_NORMAL;
+		port->icount.rx++;
+
+		/*
+		 * Note that the error handling code is
+		 * out of the main execution path
+		 */
+		rsr = UART_GET_STATUS(port) | UART_DUMMY_RSR_RX; 
+		UART_PUT_STATUS(port,0);
+		if (rsr & LEON_REG_UART_STATUS_ERR) { 
+
+		  if (rsr & LEON_REG_UART_STATUS_BR) {
+		    rsr &= ~(LEON_REG_UART_STATUS_FE | LEON_REG_UART_STATUS_PE);
+		    port->icount.brk++;
+		    if (uart_handle_break(port))
+		      goto ignore_char;
+		  } else if (rsr & LEON_REG_UART_STATUS_PE) {
+		    port->icount.parity++;
+		  } else if (rsr & LEON_REG_UART_STATUS_FE) {
+		    port->icount.frame++;
+		  }
+		  if (rsr & LEON_REG_UART_STATUS_OE)
+		    port->icount.overrun++;
+                  
+		  rsr &= port->read_status_mask;
+		  
+		  if (rsr & LEON_REG_UART_STATUS_PE)
+		    *tty->flip.flag_buf_ptr = TTY_PARITY;
+                  else if (rsr & LEON_REG_UART_STATUS_FE)
+		    *tty->flip.flag_buf_ptr = TTY_FRAME;
+		}
+            
+		if (uart_handle_sysrq_char(port, ch, regs))
+		    goto ignore_char;
+		
+		if ((rsr & port->ignore_status_mask) == 0) {
+			tty->flip.flag_buf_ptr++;
+			tty->flip.char_buf_ptr++;
+			tty->flip.count++;
+		}
+		if ((rsr & LEON_REG_UART_STATUS_OE) &&
+		    tty->flip.count < TTY_FLIPBUF_SIZE) {
+			/*
+			 * Overrun is special, since it's reported
+			 * immediately, and doesn't affect the current
+			 * character
+			 */
+			*tty->flip.char_buf_ptr++ = 0;
+			*tty->flip.flag_buf_ptr++ = TTY_OVERRUN;
+			tty->flip.count++;
+		}
+	}
+ignore_char:
+	tty_flip_buffer_push(tty);
+	return;
+}
+
+//static 
+void leonuart_tx_chars(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->info->xmit;
+	int count;
+
+	if (port->x_char) {
+		UART_PUT_CHAR(port, port->x_char);
+		port->icount.tx++;
+		port->x_char = 0;
+		return;
+	}
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		leonuart_stop_tx(port, 0);
+		return;
+	}
+
+	count = port->fifosize >> 1; //amba: fill FIFO
+	do {
+		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+		if (uart_circ_empty(xmit))
+			break;
+	} while (--count > 0);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit))
+		leonuart_stop_tx(port, 0);
+}
+
+//static 
+irqreturn_t leonuart_int(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct uart_port *port = dev_id;
+	unsigned int status;
+
+	spin_lock(port ->lock);
+
+	status = UART_GET_STATUS(port);
+	if (status & LEON_REG_UART_STATUS_DR) {
+#ifdef SUPPORT_SYSRQ
+	  leonuart_rx_chars(port,regs);
+#else
+	  leonuart_rx_chars(port);
+#endif          
+	}
+	if (status & LEON_REG_UART_STATUS_THE) {
+	  leonuart_tx_chars(port);
+	}
+	spin_unlock(port ->lock);
+	return IRQ_HANDLED;
+}
+
+static unsigned int leonuart_tx_empty(struct uart_port *port)
+{
+	return UART_GET_STATUS(port) & LEON_REG_UART_STATUS_THE ? TIOCSER_TEMT : 0;
+}
+
+static unsigned int leonuart_get_mctrl(struct uart_port *port)
+{
+	unsigned int result = 0;
+
+	/*
+	  no modem status for leon
+	*/
+
+	return result;
+}
+
+static void leonuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* no modem status for leon */
+}
+
+static void leonuart_break_ctl(struct uart_port *port, int break_state)
+{
+	/* no break for leon */
+}
+
+static int leonuart_startup(struct uart_port *port)
+{
+	struct uart_leon_port *uap = (struct uart_leon_port *)port;
+	int retval;
+	unsigned int cr;
+
+	/*
+	 * Allocate the IRQ
+	 */
+	retval = request_irq(port->irq, leonuart_int, 0, "leon", port);
+	if (retval)
+		return retval;
+
+	/*
+	 * initialise the old status of the modem signals
+	 */
+	uap->old_status = 0;
+
+	/*
+	 * Finally, enable interrupts
+	 */
+	cr = UART_GET_CTRL(port);
+	UART_PUT_CTRL(port, cr | LEON_REG_UART_CTRL_RE | LEON_REG_UART_CTRL_TE	| LEON_REG_UART_CTRL_RI | LEON_REG_UART_CTRL_TI );	
+      
+	return 0;
+}
+
+static void leonuart_shutdown(struct uart_port *port)
+{
+	unsigned int cr;
+
+	/*
+	 * Free the interrupt
+	 */
+	free_irq(port->irq, port);
+
+	/*
+	 * disable all interrupts, disable the port
+	 */
+	cr = UART_GET_CTRL(port);
+	UART_PUT_CTRL(port, cr & ~( LEON_REG_UART_CTRL_RE | LEON_REG_UART_CTRL_TE	| LEON_REG_UART_CTRL_RI | LEON_REG_UART_CTRL_TI ));	
+      
+}
+
+static void
+leonuart_set_termios(struct uart_port *port, struct termios *termios,
+		     struct termios *old)
+{
+	unsigned int cr;
+	unsigned long flags;
+	unsigned int baud, quot;
+
+	/*
+	 * Ask the core to calculate the divisor for us.
+	 */
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	if (baud == 0) {
+	  panic("invalid baudrate %i\n", port->uartclk/16);
+	}
+	quot = (uart_get_divisor(port, baud)) * 2; //uart_get_divisor calc a *16 uart freq, leon is *8
+	cr = UART_GET_CTRL(port);
+	cr &= ~( LEON_REG_UART_CTRL_PE | LEON_REG_UART_CTRL_PS );
+	  
+	if (termios->c_cflag & PARENB) { 
+		cr |= LEON_REG_UART_CTRL_PE; 
+		if ((termios->c_cflag & PARODD))
+			cr |= LEON_REG_UART_CTRL_PS;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/*
+	 * Update the per-port timeout.
+	 */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	port->read_status_mask = LEON_REG_UART_STATUS_OE;
+	if (termios->c_iflag & INPCK) 
+		port->read_status_mask |= LEON_REG_UART_STATUS_FE | LEON_REG_UART_STATUS_PE ;
+
+	/*
+	 * Characters to ignore
+	 */
+	port->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |= LEON_REG_UART_STATUS_FE | LEON_REG_UART_STATUS_PE;
+
+	/*
+	 * Ignore all characters if CREAD is not set.
+	 */
+	if ((termios->c_cflag & CREAD) == 0)
+		port->ignore_status_mask |= LEON_REG_UART_STATUS_OE | LEON_REG_UART_STATUS_FE | LEON_REG_UART_STATUS_PE;
+
+	/* Set baud rate */
+	quot -= 1;
+	UART_PUT_SCAL(port, quot);
+	UART_PUT_CTRL(port, cr);
+      
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *leonuart_type(struct uart_port *port)
+{
+	return port->type == PORT_LEON ? "Leon" : NULL;
+}
+
+/*
+ * Release the memory region(s) being used by 'port'
+ */
+static void leonuart_release_port(struct uart_port *port)
+{
+}
+
+/*
+ * Request the memory region(s) being used by 'port'
+ */
+static int leonuart_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+/*
+ * Configure/autoconfigure the port.
+ */
+static void leonuart_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE) {
+		port->type = PORT_LEON;
+		leonuart_request_port(port);
+	}
+}
+
+/*
+ * verify the new serial_struct (for TIOCSSERIAL).
+ */
+static int leonuart_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	int ret = 0;
+	if (ser->type != PORT_UNKNOWN && ser->type != PORT_LEON)
+		ret = -EINVAL;
+	if (ser->irq < 0 || ser->irq >= NR_IRQS)
+		ret = -EINVAL;
+	if (ser->baud_base < 9600)
+		ret = -EINVAL;
+	return ret;
+}
+
+static struct uart_ops leon_pops = {
+	.tx_empty	= leonuart_tx_empty,
+	.set_mctrl	= leonuart_set_mctrl,
+	.get_mctrl	= leonuart_get_mctrl,
+	.stop_tx	= leonuart_stop_tx,
+	.start_tx	= leonuart_start_tx,
+	.stop_rx	= leonuart_stop_rx,
+	.enable_ms	= leonuart_enable_ms,
+	.break_ctl	= leonuart_break_ctl,
+	.startup	= leonuart_startup,
+	.shutdown	= leonuart_shutdown,
+	.set_termios	= leonuart_set_termios,
+	.type		= leonuart_type,
+	.release_port	= leonuart_release_port,
+	.request_port	= leonuart_request_port,
+	.config_port	= leonuart_config_port,
+	.verify_port	= leonuart_verify_port,
+};
+
+static struct uart_leon_port leon_ports[UART_NR];
+/* = {
+	{
+		.port	= {
+			.membase	= (void*) (LEON_PREGS+LEON_UART0),
+			.mapbase	= (LEON_PREGS+LEON_UART0),
+			.iotype	= SERIAL_IO_MEM,
+			.irq		= LEON_INTERRUPT_UART_0_RX_TX,
+			.uartclk	= 0,
+			.fifosize	= 1,
+			.ops		= &leon_pops,
+			.flags	= ASYNC_BOOT_AUTOCONF,
+			.line		= 0,
+		},
+	},
+	{
+		.port	= {
+			.membase	= (void*) (LEON_PREGS+LEON_UART1),
+			.mapbase	= (LEON_PREGS+LEON_UART1),
+			.iotype	= SERIAL_IO_MEM,
+			.irq		= LEON_INTERRUPT_UART_1_RX_TX, 
+			.uartclk	= 0,
+			.fifosize	= 1,
+			.ops		= &leon_pops,
+			.flags	= ASYNC_BOOT_AUTOCONF,
+			.line		= 1,
+		},
+	}
+};*/
+
+extern volatile LEON3_GpTimer_Regs_Map *LEON3_GpTimer_Regs;
+
+/* rs_init inits the driver */
+static int _apbuart_init_bases_done = 0;
+static void __init 
+_apbuart_init_bases(void)
+{
+  int  i; 
+  amba_apb_device dev[8];
+  if (!_apbuart_init_bases_done ) {
+    unsigned long clk = ((unsigned long)(((LEON3_BYPASS_LOAD_PA(&LEON3_GpTimer_Regs->scalar_reload)) + 1))); 
+    printk("Attaching grlib apbuart serial drivers (clk:%ihz):\n",(int)clk);
+    leon_ports_nr = amba_get_free_apbslv_devices (VENDOR_GAISLER, GAISLER_APBUART, dev, 8);
+
+    for (i = 0;i < leon_ports_nr;i++) {
+      leon_ports[i].port.membase = (void *)dev[i].start;
+      leon_ports[i].port.mapbase = dev[i].start;
+      leon_ports[i].port.irq = dev[i].irq;
+      leon_ports[i].port.iotype = SERIAL_IO_MEM;
+      leon_ports[i].port.uartclk = clk * 1000 * 1000;
+      leon_ports[i].port.fifosize = 1;
+      leon_ports[i].port.ops	= &leon_pops;
+      leon_ports[i].port.flags = ASYNC_BOOT_AUTOCONF;
+      leon_ports[i].port.line =i;
+    }
+    _apbuart_init_bases_done = 1;
+  }
+}
+
+
+#ifdef CONFIG_SERIAL_LEON_CONSOLE
+
+static void
+leonuart_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct uart_port *port = &leon_ports[co->index].port;
+	unsigned int status, old_cr;
+	int i;
+
+	/*
+	 *	First save the CR then disable the interrupts
+	 */
+	old_cr = UART_GET_CTRL(port);
+	UART_PUT_CTRL(port, (old_cr & ~(LEON_REG_UART_CTRL_RI | LEON_REG_UART_CTRL_TI)) | (LEON_REG_UART_CTRL_RE | LEON_REG_UART_CTRL_TE) ); 
+
+	/*
+	 *	Now, do each character
+	 */
+	for (i = 0; i < count; i++) {
+		do {
+			status = UART_GET_STATUS(port);
+		} while (!UART_TX_READY(status));
+		UART_PUT_CHAR(port, s[i]);
+		if (s[i] == '\n') {
+			do {
+				status = UART_GET_STATUS(port);
+			} while (!UART_TX_READY(status));
+			UART_PUT_CHAR(port, '\r');
+		}
+	}
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore the TCR
+	 */
+	do {
+		status = UART_GET_STATUS(port);
+	} while (!UART_TX_READY(status));
+	UART_PUT_CTRL(port, old_cr);
+}
+
+static void __init
+leonuart_console_get_options(struct uart_port *port, int *baud,
+			     int *parity, int *bits)
+{
+      if (UART_GET_CTRL(port) & (LEON_REG_UART_CTRL_RE | LEON_REG_UART_CTRL_TE)) {
+	
+		unsigned int quot, status;
+		status = UART_GET_STATUS(port);
+
+		*parity = 'n';
+		if (status & LEON_REG_UART_CTRL_PE) {
+			if ((status & LEON_REG_UART_CTRL_PS) == 0 )
+				*parity = 'e';
+			else
+				*parity = 'o';
+		}
+            
+		*bits = 8;
+            quot = UART_GET_SCAL(port) / 8;
+		*baud = port->uartclk / (16 * (quot + 1));
+	}
+}
+
+static int __init leonuart_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	int baud = 38400;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	/*
+	 * Check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index >= leon_ports_nr)
+		co->index = 0;
+	port = &leon_ports[co->index].port;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	else
+		leonuart_console_get_options(port, &baud, &parity, &bits);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+
+static struct uart_driver leon_reg;
+static struct console leon_console = {
+	.name		= "ttyS",
+	.write		= leonuart_console_write,
+	.device		= uart_console_device,
+	.setup		= leonuart_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &leon_reg,
+};
+
+//static int leonuart_init(void);
+static int __init leonuart_console_init(void)
+{
+	_apbuart_init_bases();
+	register_console(&leon_console);
+	return 0;
+}
+console_initcall(leonuart_console_init);
+
+#define LEON_CONSOLE	&leon_console
+#else
+#define LEON_CONSOLE	NULL
+#endif
+
+static struct uart_driver leon_reg = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "serial",
+	.devfs_name	= "tts/",
+	.dev_name	= "ttyS",
+	.major		= SERIAL_LEON_MAJOR,
+	.minor		= SERIAL_LEON_MINOR,
+	.nr		= UART_NR,
+	.cons		= LEON_CONSOLE,
+};
+
+
+static int __init gaisler_apbuart_init(void)
+{
+	int ret;
+	int i;
+	int node;
+	int freq_khz;
+	int baud_rates[UART_NR];
+
+	_apbuart_init_bases();
+	node = prom_getchild(prom_root_node);
+	freq_khz = prom_getint(node, "frequency");
+	
+	printk(KERN_INFO "grlib apbuart: %i serial driver(s) at [",leon_ports_nr);
+	for (i = 0; i < leon_ports_nr; i++) {
+	  baud_rates[i] = prom_getintdefault(node, "uart1_baud", 9600);
+	  if (i != 0) {printk(",");}
+	  printk("0x%x",(unsigned int) leon_ports[i].port.mapbase);
+	  printk("(irq %i)",leon_ports[i].port.irq);
+	}
+	printk("]\n");
+
+	baud_rates[0] = prom_getintdefault(node, "uart1_baud", 9600);
+	baud_rates[1] = prom_getintdefault(node, "uart2_baud", 9600);
+
+	printk(KERN_INFO "grlib apbuart: system frequency: %i khz, baud rates: %i %i\n", freq_khz, baud_rates[0], baud_rates[1]);
+
+	ret = uart_register_driver(&leon_reg);
+	leon_reg.tty_driver->init_termios.c_cflag = 
+		(leon_reg.tty_driver->init_termios.c_cflag & ~CBAUD) | B38400;
+	
+	if (ret) return ret;
+
+	for (i = 0; i < leon_ports_nr; i++) {
+		struct console co;
+		leon_ports[i].port.uartclk = freq_khz * 1000;
+		uart_add_one_port(&leon_reg, &leon_ports[i].port);
+		uart_set_options(&leon_ports[i].port, &co,
+				 baud_rates[i], 'n', 8, 'n');
+	}
+
+	return ret;
+}
+
+static void __exit gaisler_apbuart_exit(void)
+{
+	int i;
+
+	for (i = 0; i < leon_ports_nr; i++)
+		uart_remove_one_port(&leon_reg, &leon_ports[i].port);
+
+	uart_unregister_driver(&leon_reg);
+}
+
+module_init(gaisler_apbuart_init);
+module_exit(gaisler_apbuart_exit);
+
+MODULE_AUTHOR("Konrad Eisele<eiselekd@web.de>, based on AMBA serial");
+MODULE_DESCRIPTION("grlib apbuart serial driver");
+MODULE_LICENSE("GPL");
+
+
+
+
+
+void leon3_rs_put_char_base(LEON3_APBUART_Regs_Map *uart_regs,char ch)
+{
+        int flags, loops;
+
+        save_flags(flags); cli();
+	loops = 0;
+	while (!(LEON3_BYPASS_LOAD_PA(&(uart_regs->status)) & LEON_REG_UART_STATUS_THE) && (loops < 100000))
+        	loops++;
+
+	LEON3_BYPASS_STORE_PA(&(uart_regs->data),ch);
+
+	loops = 0;
+	while (!(LEON3_BYPASS_LOAD_PA(&(uart_regs->status)) & LEON_REG_UART_STATUS_TSE) && (loops < 100000))
+        	loops++;
+        restore_flags(flags);
+}
+
+void leon3_rs_put_char(char ch)
+{
+  LEON3_APBUART_Regs_Map *b = (LEON3_APBUART_Regs_Map *)amba_find_apbslv_addr(VENDOR_GAISLER,GAISLER_APBUART,0);
+  if (b) {
+    leon3_rs_put_char_base(b,ch);
+  }
+}
+
+void console_print_LEON(const char *p)
+{
+	char c;
+
+        LEON3_APBUART_Regs_Map *b = (LEON3_APBUART_Regs_Map *)amba_find_apbslv_addr(VENDOR_GAISLER,GAISLER_APBUART,0);
+        
+	while((c=*(p++)) != 0) {
+          if(c == '\n')
+            leon3_rs_put_char_base(b,'\r');
+          leon3_rs_put_char_base(b,c);
+	}
+
+	/* Comment this if you want to have a strict interrupt-driven output */
+	/* rs_fair_output(); */
+
+	return;
+}
diff -Naur ../linux-2.6.10/drivers/amba/opencores/Kconfig linux-2.6.10/drivers/amba/opencores/Kconfig
--- ../linux-2.6.10/drivers/amba/opencores/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/opencores/Kconfig	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,36 @@
+
+menu "Vendor Opencores"
+
+config GRLIB_OPENCORES_ETHERMAC
+	bool "Grlib's opencores ethermac driver" 
+	default y
+	depends on NETDEVICES
+	---help---
+	  Add the driver for the grlib opencore ethermac.
+
+
+config GRLIB_OPENCORES_ETHERMAC_MACMSB
+	hex "MSB 24 bits of ethern number (hex)" 
+	default 00007A
+	depends on GRLIB_OPENCORES_ETHERMAC
+	---help---
+	  Most significant 24 bits of the default MAC address
+	  that is initialized when driver probes. A good guess 
+	  is 00007A.
+
+config GRLIB_OPENCORES_ETHERMAC_MACLSB
+	hex "LSB 24 bits of ethern number (hex)" 
+	default CC0012
+	depends on GRLIB_OPENCORES_ETHERMAC
+	---help---
+	  Least significant 24 bits of the default MAC address
+	  that is initialized when driver probes. A good guess 
+	  is CC0012.
+
+
+
+
+endmenu
+
+
+
diff -Naur ../linux-2.6.10/drivers/amba/opencores/Makefile linux-2.6.10/drivers/amba/opencores/Makefile
--- ../linux-2.6.10/drivers/amba/opencores/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/opencores/Makefile	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,3 @@
+
+obj-$(CONFIG_GRLIB_OPENCORES_ETHERMAC)		+= ethermac/ 
+
diff -Naur ../linux-2.6.10/drivers/amba/opencores/ethermac/Makefile linux-2.6.10/drivers/amba/opencores/ethermac/Makefile
--- ../linux-2.6.10/drivers/amba/opencores/ethermac/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/opencores/ethermac/Makefile	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,3 @@
+
+obj-y		+= open_eth.o
+
diff -Naur ../linux-2.6.10/drivers/amba/opencores/ethermac/open_eth.c linux-2.6.10/drivers/amba/opencores/ethermac/open_eth.c
--- ../linux-2.6.10/drivers/amba/opencores/ethermac/open_eth.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/opencores/ethermac/open_eth.c	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,1181 @@
+/*
+ * Ethernet driver for Open Ethernet Controller (www.opencores.org).
+ *      Copyright (c) 2002 Simon Srot (simons@opencores.org)
+ *
+ * Based on:
+ *
+ * Ethernet driver for Motorola MPC8xx.
+ *      Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
+ *
+ * mcen302.c: A Linux network driver for Mototrola 68EN302 MCU
+ *
+ *      Copyright (C) 1999 Aplio S.A. Written by Vadim Lebedev
+ *
+ * Right now XXBUFF_PREALLOC must be used, because MAC does not 
+ * handle unaligned buffers yet.  Also the cache inhibit calls
+ * should be used some day.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/inet.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+
+#include <asm/irq.h>
+#include <asm/pgtable.h>
+#include <asm/bitops.h>
+#include <asm/cacheflush.h>
+
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/ethtool.h>
+#include <linux/delay.h>
+#include <linux/rtnetlink.h>
+#include <linux/mii.h>
+#include <linux/crc32.h>
+#include <asm/processor.h>	/* Processor type for cache alignment. */
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+ 
+#ifdef CONFIG_LEON
+#include <asm/leon.h>
+//#define OETH_INTERRUPT LEON_INTERRUPT_OPEN_ETH
+#define DEBUG 1
+#endif
+
+/*
+#define MACADDR1 0
+#define MACADDR2 0
+#define MACADDR3 0
+#define MACADDR4 0
+#define MACADDR5 0
+*/
+ 
+#define MACADDR0 ((CONFIG_GRLIB_OPENCORES_ETHERMAC_MACMSB >> 16) & 0xff)
+#define MACADDR1 ((CONFIG_GRLIB_OPENCORES_ETHERMAC_MACMSB >> 8) & 0xff)
+#define MACADDR2 ((CONFIG_GRLIB_OPENCORES_ETHERMAC_MACMSB >> 0) & 0xff)
+#define MACADDR3 ((CONFIG_GRLIB_OPENCORES_ETHERMAC_MACLSB >> 16) & 0xff)
+#define MACADDR4 ((CONFIG_GRLIB_OPENCORES_ETHERMAC_MACLSB >> 8) & 0xff)
+#define MACADDR5 ((CONFIG_GRLIB_OPENCORES_ETHERMAC_MACLSB >> 0) & 0xff)
+
+#include "open_eth.h"
+
+//#define net_device device
+//#define __pa(x) (x)
+//#define __va(x) (x)
+#define __clear_user(add,len) memset((add),0,(len))
+
+
+#define RXBUFF_PREALLOC	1
+#define TXBUFF_PREALLOC	1
+
+//#define SRAM_BUFF	1
+//#define SRAM_BUFF_BASE	(FBMEM_BASE_ADD + 0x80000)
+
+/* The transmitter timeout
+ */
+#define TX_TIMEOUT	(2*HZ)
+
+/* Buffer number (must be 2^n) 
+ */
+#define OETH_RXBD_NUM		8
+#define OETH_TXBD_NUM		8
+#define OETH_RXBD_NUM_MASK	(OETH_RXBD_NUM-1)
+#define OETH_TXBD_NUM_MASK	(OETH_TXBD_NUM-1)
+
+/* Buffer size 
+ */
+#define OETH_RX_BUFF_SIZE	2048
+#define OETH_TX_BUFF_SIZE	2048
+
+/* How many buffers per page 
+ */
+#define OETH_RX_BUFF_PPGAE	(PAGE_SIZE/OETH_RX_BUFF_SIZE)
+#define OETH_TX_BUFF_PPGAE	(PAGE_SIZE/OETH_TX_BUFF_SIZE)
+
+/* How many pages is needed for buffers 
+ */
+#define OETH_RX_BUFF_PAGE_NUM	(OETH_RXBD_NUM/OETH_RX_BUFF_PPGAE)
+#define OETH_TX_BUFF_PAGE_NUM	(OETH_TXBD_NUM/OETH_TX_BUFF_PPGAE)
+
+/* Buffer size  (if not XXBUF_PREALLOC 
+ */
+#define MAX_FRAME_SIZE		1518
+
+/* The buffer descriptors track the ring buffers.   
+ */
+struct oeth_private {
+	struct	sk_buff* rx_skbuff[OETH_RXBD_NUM];
+	struct	sk_buff* tx_skbuff[OETH_TXBD_NUM];
+
+	ushort	tx_next;			/* Next buffer to be sent */
+	ushort	tx_last;			/* Next buffer to be checked if packet sent */
+	ushort	tx_full;			/* Buffer ring fuul indicator */
+	ushort	rx_cur;				/* Next buffer to be checked if packet received */
+
+	oeth_regs	*regs;			/* Address of controller registers. */
+	oeth_bd		*rx_bd_base;		/* Address of Rx BDs. */
+	oeth_bd		*tx_bd_base;		/* Address of Tx BDs. */
+        ushort          irq;
+
+	struct net_device_stats stats;
+};
+
+static int oeth_open(struct net_device *dev);
+static int oeth_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static void oeth_rx(struct net_device *dev);
+static void oeth_tx(struct net_device *dev);
+static irqreturn_t oeth_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static int oeth_close(struct net_device *dev);
+static struct net_device_stats *oeth_get_stats(struct net_device *dev);
+static void oeth_set_multicast_list(struct net_device *dev);
+static int oeth_set_mac_address(struct net_device *dev,void *p);
+static int calc_crc(char *mac_addr);
+
+#define OETH_REGLOAD(a)	(LEON3_BYPASS_LOAD_PA(&(a)))
+#define OETH_REGSAVE(a,v) (LEON3_BYPASS_STORE_PA(&(a),v))
+#define OETH_REGORIN(a,v) (OETH_REGSAVE(a,(OETH_REGLOAD(a) | (v))))
+#define OETH_REGANDIN(a,v) (OETH_REGSAVE(a,(OETH_REGLOAD(a) & (v))))
+
+
+#if DEBUG
+static void
+oeth_print_packet(unsigned long add, int len)
+{
+  //	int i;
+
+	printk("ipacket: add = %x len = %d\n", (unsigned int)add, len);
+/*
+	for(i = 0; i < len; i++) {
+  		if(!(i % 16))
+    			printk("\n");
+  		printk(" %.2x", *(((unsigned char *)add) + i));
+	}
+*/
+      printk("\n");
+	printk("                             \n");
+}
+#endif
+
+static int
+oeth_open(struct net_device *dev)
+{
+
+	oeth_regs *regs = (oeth_regs *)dev->base_addr;
+	struct oeth_private *cep = (struct oeth_private *)dev->priv;
+	
+#if DEBUG
+	printk("oeth_open\n");
+#endif
+#ifndef RXBUFF_PREALLOC
+	struct  sk_buff *skb;
+	volatile oeth_bd *rx_bd;
+	int i;
+
+	rx_bd = cep->rx_bd_base;
+
+	for(i = 0; i < OETH_RXBD_NUM; i++) {
+
+		skb = dev_alloc_skb(MAX_FRAME_SIZE);
+
+		if (skb == NULL)
+      		        OETH_REGSAVE(rx_bd[i].len_status , (0 << 16) | OETH_RX_BD_IRQ);
+		        //rx_bd[i].len_status = (0 << 16) | OETH_RX_BD_IRQ;
+		else
+		        OETH_REGSAVE(rx_bd[i].len_status , (0 << 16) | OETH_RX_BD_EMPTY | OETH_RX_BD_IRQ);
+		        //rx_bd[i].len_status = (0 << 16) | OETH_RX_BD_EMPTY | OETH_RX_BD_IRQ;
+
+		cep->rx_skbuff[i] = skb;
+
+		OETH_REGSAVE(rx_bd[i].addr,(unsigned long)skb->tail);
+		//rx_bd[i].addr = (unsigned long)skb->tail;
+	}
+        OETH_REGORIN(rx_bd[OETH_RXBD_NUM - 1].len_status , OETH_RX_BD_WRAP);
+	//rx_bd[OETH_RXBD_NUM - 1].len_status |= OETH_RX_BD_WRAP;
+#endif
+
+	/* Install our interrupt handler.
+	 */
+	request_irq(cep->irq, oeth_interrupt, 0, "eth", (void *)dev);
+
+	/* Enable receiver and transmiter 
+	 */
+        OETH_REGORIN(regs->moder , OETH_MODER_RXEN | OETH_MODER_TXEN);
+	//regs->moder |= OETH_MODER_RXEN | OETH_MODER_TXEN;
+
+	return 0;
+}
+
+static int
+oeth_close(struct net_device *dev)
+{
+	struct oeth_private *cep = (struct oeth_private *)dev->priv;
+	oeth_regs *regs = (oeth_regs *)dev->base_addr;
+	volatile oeth_bd *bdp;
+	int i;
+
+#if DEBUG
+	printk("oeth_close\n");
+#endif
+	/* Free interrupt hadler 
+	 */
+	free_irq(cep->irq, (void *)dev);
+
+	/* Disable receiver and transmitesr 
+	 */
+        OETH_REGANDIN(regs->moder , ~(OETH_MODER_RXEN | OETH_MODER_TXEN));
+	//regs->moder &= ~(OETH_MODER_RXEN | OETH_MODER_TXEN);	
+
+	bdp = cep->rx_bd_base;
+	for (i = 0; i < OETH_RXBD_NUM; i++) {
+	        OETH_REGANDIN(bdp->len_status, ~(OETH_TX_BD_STATS | OETH_TX_BD_READY));
+		//bdp->len_status &= ~(OETH_TX_BD_STATS | OETH_TX_BD_READY);
+		bdp++;
+	}
+
+	bdp = cep->tx_bd_base;
+	for (i = 0; i < OETH_TXBD_NUM; i++) {
+	        OETH_REGANDIN(bdp->len_status , ~(OETH_RX_BD_STATS | OETH_RX_BD_EMPTY));
+		//bdp->len_status &= ~(OETH_RX_BD_STATS | OETH_RX_BD_EMPTY);
+		bdp++;
+	}
+
+#ifndef RXBUFF_PREALLOC
+
+	/* Free all alocated rx buffers 
+	 */
+	for (i = 0; i < OETH_RXBD_NUM; i++) {
+	
+		if (cep->rx_skbuff[i] != NULL)
+			dev_kfree_skb(cep->rx_skbuff[i]); //, FREE_READ);
+		
+	}
+#endif
+#ifndef TXBUFF_PREALLOC
+
+	/* Free all alocated tx buffers 
+	 */
+	for (i = 0; i < OETH_TXBD_NUM; i++) {
+	
+		if (cep->tx_skbuff[i] != NULL)
+			dev_kfree_skb(cep->tx_skbuff[i]);//, FREE_WRITE);
+	}
+#endif
+
+	return 0;
+}
+
+static int
+oeth_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct oeth_private *cep = (struct oeth_private *)dev->priv;
+	volatile oeth_bd *bdp;
+	unsigned long flags;
+
+	/* Fill in a Tx ring entry 
+	 */
+	bdp = cep->tx_bd_base + cep->tx_next;
+
+	if (cep->tx_full) {
+
+		/* All transmit buffers are full.  Bail out.
+		 */
+		printk("%s: tx queue full!.\n", dev->name);
+		return 1;
+	}
+
+	/* Clear all of the status flags.
+	 */
+	OETH_REGANDIN(bdp->len_status , ~OETH_TX_BD_STATS);
+	//bdp->len_status &= ~OETH_TX_BD_STATS;
+
+	/* If the frame is short, tell CPM to pad it.
+	 */
+	if (skb->len <= ETH_ZLEN)
+	        OETH_REGORIN(bdp->len_status , OETH_TX_BD_PAD);
+	        //bdp->len_status |= OETH_TX_BD_PAD;
+	else
+	        OETH_REGANDIN(bdp->len_status , ~OETH_TX_BD_PAD);
+	        //bdp->len_status &= ~OETH_TX_BD_PAD;
+
+#if DEBUG
+	printk("TX\n");
+	oeth_print_packet((unsigned long)skb->data, skb->len);
+#endif
+
+#ifdef TXBUFF_PREALLOC
+
+	/* Copy data in preallocated buffer */
+	if (skb->len > OETH_TX_BUFF_SIZE) {
+		printk("%s: tx frame too long!.\n", dev->name);
+		return 1;
+	}
+	else {
+	  
+	  memcpy(__va((unsigned char *)OETH_REGLOAD(bdp->addr)), skb->data, skb->len); 
+            __flush_page_to_ram((unsigned long)__va(OETH_REGLOAD(bdp->addr)));
+	    //memcpy(__va((unsigned char *)bdp->addr), skb->data, skb->len); 
+            //__flush_page_to_ram((unsigned long)__va(bdp->addr));
+      }
+
+	OETH_REGSAVE(bdp->len_status , (OETH_REGLOAD(bdp->len_status) & 0x0000ffff) | (skb->len << 16));
+	//bdp->len_status = (bdp->len_status & 0x0000ffff) | (skb->len << 16);
+
+	dev_kfree_skb(skb); // 	dev_kfree_skb(skb, FREE_WRITE);
+#else
+	/* Set buffer length and buffer pointer.
+	 */
+	OETH_REGSAVE(bdp->len_status , (OETH_REGLOAD(bdp->len_status) & 0x0000ffff) | (skb->len << 16))
+	//bdp->len_status = (bdp->len_status & 0x0000ffff) | (skb->len << 16);
+	OETH_REGSAVE(bdp->addr , (uint)__pa(skb->data));
+	//bdp->addr = (uint)__pa(skb->data);
+
+	/* Save skb pointer.
+	 */
+	cep->tx_skbuff[cep->tx_next] = skb;
+#endif
+
+	cep->tx_next = (cep->tx_next + 1) & OETH_TXBD_NUM_MASK;
+	
+	save_flags(flags); cli();
+
+	if (cep->tx_next == cep->tx_last)
+		cep->tx_full = 1;
+
+	/* Send it on its way.  Tell controller its ready, interrupt when done,
+	 * and to put the CRC on the end.
+	 */
+        OETH_REGORIN(bdp->len_status , (OETH_TX_BD_READY | OETH_TX_BD_IRQ | OETH_TX_BD_CRC));
+	//bdp->len_status |= (OETH_TX_BD_READY | OETH_TX_BD_IRQ | OETH_TX_BD_CRC);
+
+	dev->trans_start = jiffies;
+
+	restore_flags(flags);
+
+	return 0;
+}
+
+/* The interrupt handler.
+ */
+static irqreturn_t
+oeth_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct	net_device *dev = dev_id;
+	volatile struct	oeth_private *cep;
+	uint	int_events;
+      
+#if DEBUG
+      printk ("oeth_interrupt()\n");
+#endif
+
+	cep = (struct oeth_private *)dev->priv;
+
+	/* Get the interrupt events that caused us to be here.
+	 */
+        int_events = OETH_REGLOAD( cep->regs->int_src);
+	//int_events = cep->regs->int_src;
+        OETH_REGSAVE(cep->regs->int_src , int_events);
+	//cep->regs->int_src = int_events;
+
+	/* Handle receive event in its own function.
+	 */
+	if (int_events & (OETH_INT_RXF | OETH_INT_RXE))
+		oeth_rx(dev_id);
+
+	/* Handle transmit event in its own function.
+	 */
+	if (int_events & (OETH_INT_TXB | OETH_INT_TXE)) {
+		oeth_tx(dev_id);
+            netif_wake_queue(dev); //mark_bh(NET_BH);
+	}
+
+	/* Check for receive busy, i.e. packets coming but no place to
+	 * put them. 
+	 */
+	if (int_events & OETH_INT_BUSY) {
+		if (!(int_events & (OETH_INT_RXF | OETH_INT_RXE)))
+			oeth_rx(dev_id);
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+static void
+oeth_tx(struct net_device *dev)
+{
+	struct	oeth_private *cep;
+	volatile oeth_bd *bdp;
+
+#ifndef TXBUFF_PREALLOC
+	struct	sk_buff *skb;
+#endif
+
+#if DEBUG
+      printk ("oeth_tx()\n");
+#endif
+
+	cep = (struct oeth_private *)dev->priv;
+
+	for (;; cep->tx_last = (cep->tx_last + 1) & OETH_TXBD_NUM_MASK) {
+
+		bdp = cep->tx_bd_base + cep->tx_last;
+
+		if ((OETH_REGLOAD(bdp->len_status) & OETH_TX_BD_READY) || 
+		//if ((bdp->len_status & OETH_TX_BD_READY) || 
+			((cep->tx_last == cep->tx_next) && !cep->tx_full))
+			break;
+
+		/* Check status for errors
+		 */
+		if (OETH_REGLOAD(bdp->len_status) & OETH_TX_BD_LATECOL)
+			cep->stats.tx_window_errors++;
+		if (OETH_REGLOAD(bdp->len_status) & OETH_TX_BD_RETLIM)
+			cep->stats.tx_aborted_errors++;
+		if (OETH_REGLOAD(bdp->len_status) & OETH_TX_BD_UNDERRUN)
+			cep->stats.tx_fifo_errors++;
+		if (OETH_REGLOAD(bdp->len_status) & OETH_TX_BD_CARRIER)
+			cep->stats.tx_carrier_errors++;
+		if (OETH_REGLOAD(bdp->len_status) & (OETH_TX_BD_LATECOL | OETH_TX_BD_RETLIM | OETH_TX_BD_UNDERRUN))
+			cep->stats.tx_errors++;
+
+		/* Check status for errors
+		 */
+                /*
+		if (bdp->len_status & OETH_TX_BD_LATECOL)
+			cep->stats.tx_window_errors++;
+		if (bdp->len_status & OETH_TX_BD_RETLIM)
+			cep->stats.tx_aborted_errors++;
+		if (bdp->len_status & OETH_TX_BD_UNDERRUN)
+			cep->stats.tx_fifo_errors++;
+		if (bdp->len_status & OETH_TX_BD_CARRIER)
+			cep->stats.tx_carrier_errors++;
+		if (bdp->len_status & (OETH_TX_BD_LATECOL | OETH_TX_BD_RETLIM | OETH_TX_BD_UNDERRUN))
+			cep->stats.tx_errors++;
+		*/
+
+		cep->stats.tx_packets++;
+		cep->stats.collisions += (OETH_REGLOAD(bdp->len_status) >> 4) & 0x000f;
+		//cep->stats.collisions += (bdp->len_status >> 4) & 0x000f;
+
+#ifndef TXBUFF_PREALLOC
+		skb = cep->tx_skbuff[cep->tx_last];
+
+		/* Free the sk buffer associated with this last transmit.
+		*/
+		dev_kfree_skb(skb);//, FREE_WRITE);
+#endif
+
+		if (cep->tx_full)
+			cep->tx_full = 0;
+	}
+}
+
+static void
+oeth_rx(struct net_device *dev)
+{
+	struct	oeth_private *cep;
+	volatile oeth_bd *bdp;
+	struct	sk_buff *skb;
+	int	pkt_len;
+	int	bad = 0;
+#ifndef RXBUFF_PREALLOC
+	struct	sk_buff *small_skb;
+#endif
+      
+#if DEBUG
+      printk ("oeth_rx()\n");
+#endif
+
+	cep = (struct oeth_private *)dev->priv;
+
+	/* First, grab all of the stats for the incoming packet.
+	 * These get messed up if we get called due to a busy condition.
+	 */
+	for (;;cep->rx_cur = (cep->rx_cur + 1) & OETH_RXBD_NUM_MASK) {
+
+		bdp = cep->rx_bd_base + cep->rx_cur;
+
+#ifndef RXBUFF_PREALLOC
+		skb = cep->rx_skbuff[cep->rx_cur];
+
+		if (skb == NULL) {
+
+			skb = dev_alloc_skb(MAX_FRAME_SIZE);
+
+			if (skb != NULL)
+			{
+				OETH_REGSAVE(bdp->addr , (unsigned long) skb->tail);
+				OETH_REGORIN(bdp->len_status , OETH_RX_BD_EMPTY);
+				//bdp->addr = (unsigned long) skb->tail;
+				//bdp->len_status |= OETH_RX_BD_EMPTY;
+			}
+
+			continue;
+		}
+#endif
+			
+		if (OETH_REGLOAD(bdp->len_status) & OETH_RX_BD_EMPTY)
+		//if (bdp->len_status & OETH_RX_BD_EMPTY)
+			break;
+			
+		/* Check status for errors.
+		 */
+		if (OETH_REGLOAD(bdp->len_status) & (OETH_RX_BD_TOOLONG | OETH_RX_BD_SHORT)) {
+		//if (bdp->len_status & (OETH_RX_BD_TOOLONG | OETH_RX_BD_SHORT)) {
+                  printk ("oeth: length error\n");
+			cep->stats.rx_length_errors++;
+			bad = 1;
+		}
+		if (OETH_REGLOAD(bdp->len_status) & OETH_RX_BD_DRIBBLE) {
+		//if (bdp->len_status & OETH_RX_BD_DRIBBLE) {
+                  printk ("oeth: dribble error\n");
+			cep->stats.rx_frame_errors++;
+			bad = 1;
+		}
+		if (OETH_REGLOAD(bdp->len_status) & OETH_RX_BD_CRCERR) {
+		//if (bdp->len_status & OETH_RX_BD_CRCERR) {
+                  printk ("oeth: crc error\n");
+			cep->stats.rx_crc_errors++;
+			bad = 1;
+		}
+		if (OETH_REGLOAD(bdp->len_status) & OETH_RX_BD_OVERRUN) {
+		//if (bdp->len_status & OETH_RX_BD_OVERRUN) {
+                  printk ("oeth: overrun error\n");
+			cep->stats.rx_crc_errors++;
+			bad = 1;
+		}
+		if (OETH_REGLOAD(bdp->len_status) & OETH_RX_BD_MISS) {
+		//if (bdp->len_status & OETH_RX_BD_MISS) {
+                  printk ("oeth: miss error\n");
+
+		}
+		if (OETH_REGLOAD(bdp->len_status) & OETH_RX_BD_LATECOL) {
+		//if (bdp->len_status & OETH_RX_BD_LATECOL) {
+                  printk ("oeth: latecol error\n");
+			cep->stats.rx_frame_errors++;
+			bad = 1;
+		}
+		
+		
+		if (bad) {
+
+			OETH_REGANDIN(bdp->len_status , ~OETH_RX_BD_STATS);
+			OETH_REGORIN(bdp->len_status , OETH_RX_BD_EMPTY);
+      //bdp->len_status &= ~OETH_RX_BD_STATS;
+      //bdp->len_status |= OETH_RX_BD_EMPTY;
+
+			continue;
+		}
+
+		/* Process the incoming frame.
+		 */
+		pkt_len = OETH_REGLOAD(bdp->len_status) >> 16;
+		//pkt_len = bdp->len_status >> 16;
+        
+#ifdef RXBUFF_PREALLOC
+		//skb = dev_alloc_skb(pkt_len);
+                skb = alloc_skb(pkt_len + 4, GFP_ATOMIC); //added from michael wurm's patches
+
+		if (skb == NULL) {
+			printk("%s: Memory squeeze, dropping packet.\n", dev->name);
+			cep->stats.rx_dropped++;
+		}
+		else {
+			skb_reserve(skb, 2); //added from michael wurm's patches
+			skb->dev = dev;
+
+                  __flush_page_to_ram((unsigned long)__va(OETH_REGLOAD(bdp->addr)));
+                  //__flush_page_to_ram((unsigned long)__va(bdp->addr));
+#if DEBUG
+			printk("RX\n");
+                  oeth_print_packet((unsigned long)(__va(OETH_REGLOAD(bdp->addr))), pkt_len);
+                  //oeth_print_packet((unsigned long)(__va(bdp->addr)), pkt_len);
+#endif
+			memcpy(skb_put(skb, pkt_len), (unsigned char *)__va(OETH_REGLOAD(bdp->addr)), pkt_len);
+			//memcpy(skb_put(skb, pkt_len), (unsigned char *)__va(bdp->addr), pkt_len);
+			skb->protocol = eth_type_trans(skb,dev);
+			netif_rx(skb);
+			cep->stats.rx_packets++;
+		}
+
+		OETH_REGANDIN(bdp->len_status , ~OETH_RX_BD_STATS);
+		OETH_REGORIN(bdp->len_status , OETH_RX_BD_EMPTY);
+		//bdp->len_status &= ~OETH_RX_BD_STATS;
+		//bdp->len_status |= OETH_RX_BD_EMPTY;
+#else //RXBUFF_PREALLOC
+
+		if (pkt_len < 128) {
+
+			small_skb = dev_alloc_skb(pkt_len);
+
+			if (small_skb) {
+				small_skb->dev = dev;
+
+                        __flush_page_to_ram(__va(OETH_REGLOAD(bdp->addr)));
+                        //__flush_page_to_ram(__va(bdp->addr));
+#if DEBUG
+				printk("RX short\n");
+                        oeth_print_packet((unsigned long)(__va(bdp->addr)), OETH_REGLOAD(bdp->len_status) >> 16);
+                        //oeth_print_packet((unsigned long)(__va(bdp->addr)), bdp->len_status >> 16);
+#endif
+                        memcpy(skb_put(small_skb, pkt_len), (unsigned char *)__va(OETH_REGLOAD(bdp->addr)), pkt_len);
+                        //memcpy(skb_put(small_skb, pkt_len), (unsigned char *)__va(bdp->addr), pkt_len);
+
+                        small_skb->protocol = eth_type_trans(small_skb,dev);
+                        netif_rx(small_skb);
+				cep->stats.rx_packets++;
+			}
+			else {
+				printk("%s: Memory squeeze, dropping packet.\n", dev->name);
+	                        cep->stats.rx_dropped++;
+			}
+
+			OETH_REGANDIN(bdp->len_status , ~OETH_RX_BD_STATS);
+			OETH_REGORIN(bdp->len_status , OETH_RX_BD_EMPTY);
+			//bdp->len_status &= ~OETH_RX_BD_STATS;
+			//bdp->len_status |= OETH_RX_BD_EMPTY;
+		}
+		else {
+        		skb->dev = dev;
+			skb_put(skb, OETH_REGLOAD(bdp->len_status) >> 16);
+			//skb_put(skb, bdp->len_status >> 16);
+			skb->protocol = eth_type_trans(skb,dev);
+			netif_rx(skb);
+			cep->stats.rx_packets++;
+#if DEBUG
+			printk("RX long\n");
+                        oeth_print_packet((unsigned long)(__va(OETH_REGLOAD(bdp->addr))), OETH_REGLOAD(bdp->len_status) >> 16);
+                        //oeth_print_packet((unsigned long)(__va(bdp->addr)), bdp->len_status >> 16);
+#endif
+		
+			skb = dev_alloc_skb(MAX_FRAME_SIZE);
+
+			OETH_REGANDIN(bdp->len_status , ~OETH_RX_BD_STATS);
+			//bdp->len_status &= ~OETH_RX_BD_STATS;
+        
+			if (skb) {
+				cep->rx_skbuff[cep->rx_cur] = skb;
+
+				OETH_REGSAVE(bdp->addr , (unsigned long)skb->tail);
+				OETH_REGORIN(bdp->len_status , OETH_RX_BD_EMPTY);
+				//bdp->addr = (unsigned long)skb->tail;
+				//bdp->len_status |= OETH_RX_BD_EMPTY;
+			}
+			else {
+				cep->rx_skbuff[cep->rx_cur] = NULL;	
+			}
+		}
+#endif //!RXBUFF_PREALLOC
+	}
+
+#if DEBUG
+      printk ("oeth_rx sent()\n");
+#endif
+}
+
+static int calc_crc(char *mac_addr)
+{
+	int result = 0;
+	return (result & 0x3f);
+}
+
+static struct net_device_stats *oeth_get_stats(struct net_device *dev)
+{
+        struct oeth_private *cep = (struct oeth_private *)dev->priv;
+ 
+        return &cep->stats;
+}
+
+static void oeth_set_multicast_list(struct net_device *dev)
+{
+	struct	oeth_private *cep;
+	struct	dev_mc_list *dmi;
+	volatile oeth_regs *regs;
+	int	i;
+
+	cep = (struct oeth_private *)dev->priv;
+
+	/* Get pointer of controller registers.
+	 */
+	regs = (oeth_regs *)dev->base_addr;
+
+	if (dev->flags & IFF_PROMISC) {
+	  
+		/* Log any net taps. 
+		 */
+		printk("%s: Promiscuous mode enabled.\n", dev->name);
+		OETH_REGORIN(regs->moder , OETH_MODER_PRO);
+		//regs->moder |= OETH_MODER_PRO;
+	} else {
+
+		OETH_REGANDIN(regs->moder , ~OETH_MODER_PRO);
+		//regs->moder &= ~OETH_MODER_PRO;
+
+		if (dev->flags & IFF_ALLMULTI) {
+
+			/* Catch all multicast addresses, so set the
+			 * filter to all 1's.
+			 */
+			OETH_REGSAVE(regs->hash_addr0 , 0xffffffff);
+			OETH_REGSAVE(regs->hash_addr1 , 0xffffffff);
+			//regs->hash_addr0 = 0xffffffff;
+			//regs->hash_addr1 = 0xffffffff;
+		}
+		else if (dev->mc_count) {
+
+                        OETH_REGORIN(regs->moder , OETH_MODER_IAM);
+                        //regs->moder |= OETH_MODER_IAM;
+                        
+			/* Clear filter and add the addresses in the list.
+			 */
+			OETH_REGSAVE(regs->hash_addr0 , 0x00000000);
+			OETH_REGSAVE(regs->hash_addr0 , 0x00000000);
+			//regs->hash_addr0 = 0x00000000;
+			//regs->hash_addr0 = 0x00000000;
+
+			dmi = dev->mc_list;
+
+			for (i = 0; i < dev->mc_count; i++) {
+				
+				int hash_b;
+
+				/* Only support group multicast for now.
+				 */
+				if (!(dmi->dmi_addr[0] & 1))
+					continue;
+
+				hash_b = calc_crc(dmi->dmi_addr); 
+				if(hash_b >= 32)
+					OETH_REGORIN(regs->hash_addr1 , 1 << (hash_b - 32));
+				        //regs->hash_addr1 |= 1 << (hash_b - 32);
+				else
+					OETH_REGORIN(regs->hash_addr0 , 1 << hash_b);
+				        //regs->hash_addr0 |= 1 << hash_b;
+			}
+		}
+	}
+}
+
+static int oeth_set_mac_address(struct net_device *dev,void *p)
+{
+	struct sockaddr *addr=p;
+	volatile oeth_regs *regs;
+      
+	memcpy(dev->dev_addr, addr->sa_data,dev->addr_len);
+      
+	regs = (oeth_regs *)dev->base_addr;
+      
+    
+	    
+// old version: sa_data is of type char, will be expanded to int when ored
+// so negative values e.g 0xB5 will be expanded to 0xffffffB5 and ored
+/*
+	regs->mac_addr1 = 	addr->sa_data[0] << 8 	|
+            			addr->sa_data[1];
+        regs->mac_addr0 = 	addr->sa_data[2] << 24 	|
+            			addr->sa_data[3] << 16 	|
+            			addr->sa_data[4] << 8 	|
+            			addr->sa_data[5];
+
+*/
+
+// dev_addr is of type unsigned char and will be expanded to unsigned int which is ok
+	OETH_REGSAVE(regs->mac_addr1 , 	dev->dev_addr[0] << 8 	|
+            			dev->dev_addr[1]);
+        OETH_REGSAVE(regs->mac_addr0 , 	dev->dev_addr[2] << 24 	|
+            			dev->dev_addr[3] << 16 	|
+            			dev->dev_addr[4] << 8 	|
+            			dev->dev_addr[5]);
+
+	/*	    
+	regs->mac_addr1 = 	dev->dev_addr[0] << 8 	|
+            			dev->dev_addr[1];
+        regs->mac_addr0 = 	dev->dev_addr[2] << 24 	|
+            			dev->dev_addr[3] << 16 	|
+            			dev->dev_addr[4] << 8 	|
+            			dev->dev_addr[5];
+	*/  
+	    
+	    
+	return 0;
+}
+
+/* Initialize the Open Ethernet MAC.
+ */
+int do_oeth_probe(struct net_device *dev)
+{
+	struct oeth_private *cep;
+	volatile oeth_regs *regs;
+	volatile oeth_bd *tx_bd, *rx_bd;
+	int i, j, k, l;
+#ifdef SRAM_BUFF
+	unsigned long mem_addr = SRAM_BUFF_BASE;
+#else
+	unsigned long mem_addr;
+#endif
+	unsigned long base;
+
+	amba_ahb_device adev[1];
+	l = amba_get_free_ahbslv_devices (VENDOR_GAISLER, GAISLER_ETHAHB, adev, 1);
+	if (l == 0) {
+	  return 1;
+	}
+	
+	base = adev[0].start[0];
+
+	//printk("Probing Open Ethernet Core at 0x%x (irq:%i,n:%s)\n",adev[0].start[0], adev[0].irq, dev ->name);
+
+	cep = (struct oeth_private *)dev->priv;
+
+	/* Allocate a new 'dev' if needed. 
+	 */
+	if (dev == NULL) {
+		/*
+		 * Don't allocate the private data here, it is done later
+		 * This makes it easier to free the memory when this driver
+		 * is used as a module.
+		 */
+//		dev = init_etherdev(0, 0);
+                dev=alloc_etherdev(0);		
+//		dev = alloc_netdev(0, "eth0", setup_ether);
+		if (dev == NULL)
+			return -ENOMEM;
+	}
+
+
+
+
+	/* Initialize the device structure. 
+	 */
+	if (dev->priv == NULL) {
+		cep = (struct oeth_private *)kmalloc(sizeof(*cep), GFP_KERNEL);
+		dev->priv = cep;
+		if (dev->priv == NULL)
+			return -ENOMEM;
+	}
+	
+	__clear_user(cep,sizeof(*cep));
+
+	/* Get pointer ethernet controller configuration registers.
+	 */
+	cep->regs = (oeth_regs *)(OETH_REG_BASE(base));
+	regs = (oeth_regs *)(OETH_REG_BASE(base));
+	cep->irq = adev[0].irq;
+
+	/* Reset the controller.
+	 */
+	OETH_REGSAVE(regs->moder , OETH_MODER_RST);	/* Reset ON */
+	OETH_REGANDIN(regs->moder , ~OETH_MODER_RST);	/* Reset OFF */
+	//regs->moder = OETH_MODER_RST;	/* Reset ON */
+	//regs->moder &= ~OETH_MODER_RST;	/* Reset OFF */
+
+	/* Setting TXBD base to OETH_TXBD_NUM.
+	 */
+	OETH_REGSAVE(regs->tx_bd_num , OETH_TXBD_NUM);
+	//regs->tx_bd_num = OETH_TXBD_NUM;
+	
+	/* Initialize TXBD pointer
+	 */
+	cep->tx_bd_base = (oeth_bd *)OETH_BD_BASE(base);
+	tx_bd = (volatile oeth_bd *)OETH_BD_BASE(base);
+
+	/* Initialize RXBD pointer
+	 */
+	cep->rx_bd_base = ((oeth_bd *)OETH_BD_BASE(base)) + OETH_TXBD_NUM;
+	rx_bd = ((volatile oeth_bd *)OETH_BD_BASE(base)) + OETH_TXBD_NUM;
+
+	/* Initialize transmit pointers.
+	 */
+	cep->rx_cur = 0;
+	cep->tx_next = 0;
+	cep->tx_last = 0;
+	cep->tx_full = 0;
+
+	/* Set min/max packet length 
+	 */
+	OETH_REGSAVE(regs->packet_len , 0x00400600);
+	//regs->packet_len = 0x00400600;
+
+	/* Set IPGT register to recomended value 
+	 */
+	OETH_REGSAVE(regs->ipgt , 0x00000012);
+	//regs->ipgt = 0x00000012;
+
+	/* Set IPGR1 register to recomended value 
+	 */
+	OETH_REGSAVE(regs->ipgr1 , 0x0000000c);
+	//regs->ipgr1 = 0x0000000c;
+
+	/* Set IPGR2 register to recomended value 
+	 */
+	OETH_REGSAVE(regs->ipgr2 , 0x00000012);
+	//regs->ipgr2 = 0x00000012;
+
+	/* Set COLLCONF register to recomended value 
+	 */
+	OETH_REGSAVE(regs->collconf , 0x000f003f);
+	//regs->collconf = 0x000f003f;
+
+	/* Set control module mode 
+	 */
+#if 0
+	OETH_REGSAVE(regs->ctrlmoder , OETH_CTRLMODER_TXFLOW | OETH_CTRLMODER_RXFLOW);
+	//regs->ctrlmoder = OETH_CTRLMODER_TXFLOW | OETH_CTRLMODER_RXFLOW;
+#else
+	OETH_REGSAVE(regs->ctrlmoder , 0);
+	//regs->ctrlmoder = 0;
+#endif
+
+  /* Set PHY to show Tx status, Rx status and Link status */
+  /*regs->miiaddress = 20<<8;
+  regs->miitx_data = 0x1422;
+  regs->miicommand = OETH_MIICOMMAND_WCTRLDATA;*/
+ 
+  // switch to 10 mbit ethernet
+  OETH_REGSAVE(regs->miiaddress , 0);
+  OETH_REGSAVE(regs->miitx_data , 0);
+  OETH_REGSAVE(regs->miicommand , OETH_MIICOMMAND_WCTRLDATA);
+  //regs->miiaddress = 0;
+  //regs->miitx_data = 0;
+  //regs->miicommand = OETH_MIICOMMAND_WCTRLDATA;
+  
+#ifdef TXBUFF_PREALLOC
+
+	/* Initialize TXBDs.
+	 */
+	for(i = 0, k = 0; i < OETH_TX_BUFF_PAGE_NUM; i++) {
+
+#ifndef SRAM_BUFF
+		mem_addr = __get_free_page(GFP_KERNEL);
+#endif
+
+		for(j = 0; j < OETH_TX_BUFF_PPGAE; j++, k++) {
+			OETH_REGSAVE(tx_bd[k].len_status , OETH_TX_BD_PAD | OETH_TX_BD_CRC | OETH_RX_BD_IRQ);
+			OETH_REGSAVE(tx_bd[k].addr , __pa(mem_addr));
+			//tx_bd[k].len_status = OETH_TX_BD_PAD | OETH_TX_BD_CRC | OETH_RX_BD_IRQ;
+			//tx_bd[k].addr = __pa(mem_addr);
+			mem_addr += OETH_TX_BUFF_SIZE;
+		}
+	}
+	OETH_REGORIN(tx_bd[OETH_TXBD_NUM - 1].len_status , OETH_TX_BD_WRAP);
+	//tx_bd[OETH_TXBD_NUM - 1].len_status |= OETH_TX_BD_WRAP;
+#else
+
+ 	/* Initialize TXBDs.
+	 */
+	for(i = 0; i < OETH_TXBD_NUM; i++) {
+
+		cep->tx_skbuff[i] = NULL;
+
+		OETH_REGSAVE(tx_bd[i].len_status , (0 << 16) | OETH_TX_BD_PAD | OETH_TX_BD_CRC | OETH_RX_BD_IRQ);
+		OETH_REGSAVE(tx_bd[i].addr , 0);
+		//tx_bd[i].len_status = (0 << 16) | OETH_TX_BD_PAD | OETH_TX_BD_CRC | OETH_RX_BD_IRQ;
+		//tx_bd[i].addr = 0;
+	}
+	OETH_REGORIN(tx_bd[OETH_TXBD_NUM - 1].len_status , OETH_TX_BD_WRAP);
+	//tx_bd[OETH_TXBD_NUM - 1].len_status |= OETH_TX_BD_WRAP;
+#endif
+
+#ifdef RXBUFF_PREALLOC
+
+	/* Initialize RXBDs.
+	 */
+	for(i = 0, k = 0; i < OETH_RX_BUFF_PAGE_NUM; i++) {
+
+#ifndef SRAM_BUFF
+		mem_addr = __get_free_page(GFP_KERNEL);
+#endif
+
+		for(j = 0; j < OETH_RX_BUFF_PPGAE; j++, k++) {
+			OETH_REGSAVE(rx_bd[k].len_status , OETH_RX_BD_EMPTY | OETH_RX_BD_IRQ);
+			OETH_REGSAVE(rx_bd[k].addr , __pa(mem_addr));
+			//rx_bd[k].len_status = OETH_RX_BD_EMPTY | OETH_RX_BD_IRQ;
+			//rx_bd[k].addr = __pa(mem_addr);
+			mem_addr += OETH_RX_BUFF_SIZE;
+		}
+	}
+	OETH_REGORIN(rx_bd[OETH_RXBD_NUM - 1].len_status , OETH_RX_BD_WRAP);
+	//rx_bd[OETH_RXBD_NUM - 1].len_status |= OETH_RX_BD_WRAP;
+
+#else
+	/* Initialize RXBDs.
+	 */
+	for(i = 0; i < OETH_RXBD_NUM; i++) {
+
+
+		OETH_REGSAVE(rx_bd[i].len_status , (0 << 16) | OETH_RX_BD_IRQ);
+		//rx_bd[i].len_status = (0 << 16) | OETH_RX_BD_IRQ;
+
+		cep->rx_skbuff[i] = NULL;
+
+		OETH_REGSAVE(rx_bd[i].addr , 0);
+		//rx_bd[i].addr = 0;
+	}
+	OETH_REGORIN(rx_bd[OETH_RXBD_NUM - 1].len_status , OETH_RX_BD_WRAP);
+	//rx_bd[OETH_RXBD_NUM - 1].len_status |= OETH_RX_BD_WRAP;
+
+#endif
+	
+	/* Set default ethernet station address.
+	 */
+	dev->dev_addr[0] = MACADDR0;
+	dev->dev_addr[1] = MACADDR1;
+	dev->dev_addr[2] = MACADDR2;
+	dev->dev_addr[3] = MACADDR3;
+	dev->dev_addr[4] = MACADDR4;
+	dev->dev_addr[5] = MACADDR5;
+
+	OETH_REGSAVE(regs->mac_addr1 , MACADDR0 << 8 | MACADDR1);
+	OETH_REGSAVE(regs->mac_addr0 , MACADDR2 << 24 | MACADDR3 << 16 | MACADDR4 << 8 | MACADDR5);
+	//regs->mac_addr1 = MACADDR0 << 8 | MACADDR1;
+	//regs->mac_addr0 = MACADDR2 << 24 | MACADDR3 << 16 | MACADDR4 << 8 | MACADDR5;
+	
+	/* Clear all pending interrupts 
+	 */
+	OETH_REGSAVE(regs->int_src , 0xffffffff);
+	//regs->int_src = 0xffffffff;
+
+	/* Promisc, IFG, CRCEn
+	 */
+	OETH_REGORIN(regs->moder , OETH_MODER_PAD | OETH_MODER_IFG | OETH_MODER_CRCEN);
+	//regs->moder |= OETH_MODER_PAD | OETH_MODER_IFG | OETH_MODER_CRCEN;
+
+	/* Enable interrupt sources.
+	 */
+	OETH_REGSAVE(regs->int_mask , OETH_INT_MASK_TXB 	| 
+			OETH_INT_MASK_TXE 	| 
+			OETH_INT_MASK_RXF 	| 
+			OETH_INT_MASK_RXE 	|
+			OETH_INT_MASK_BUSY 	|
+			OETH_INT_MASK_TXC	|
+			OETH_INT_MASK_RXC);
+	/*	regs->int_mask = OETH_INT_MASK_TXB 	| 
+			OETH_INT_MASK_TXE 	| 
+			OETH_INT_MASK_RXF 	| 
+			OETH_INT_MASK_RXE 	|
+			OETH_INT_MASK_BUSY 	|
+			OETH_INT_MASK_TXC	|
+			OETH_INT_MASK_RXC;
+	*/
+	/* Fill in the fields of the device structure with ethernet values. 
+	 */
+	ether_setup(dev);
+
+	dev->base_addr = (unsigned long)OETH_REG_BASE(base);
+
+	/* The Open Ethernet specific entries in the device structure. 
+	 */
+	dev->open = oeth_open;
+	dev->hard_start_xmit = oeth_start_xmit;
+	dev->stop = oeth_close;
+	dev->get_stats = oeth_get_stats;
+	dev->set_multicast_list = oeth_set_multicast_list;
+	dev->set_mac_address = oeth_set_mac_address;
+
+	if (register_netdev(dev)) {
+	  kfree(dev->priv);
+	  printk(KERN_ERR "open_eth: netdevice registration failed.\n");
+	  return -ENOMEM;
+        }
+
+	printk("%s: Open Ethernet Core Version 1.0 at [0x%x] irq %i\n", dev->name,(unsigned int)(cep->regs),(unsigned int)(cep->irq));
+
+	return 0;
+}
+	
+struct net_device *grlib_oeth_probe(int unit) {
+  
+  struct net_device *dev = alloc_etherdev(0);
+  int err;
+  
+  if (!dev)
+    return ERR_PTR(-ENOMEM);
+  if (unit >= 0)
+    sprintf(dev->name, "eth%d", unit);
+  SET_MODULE_OWNER(dev);
+  err = do_oeth_probe(dev);
+  if (err) {
+    free_netdev(dev);
+    return ERR_PTR(err);
+  }
+  return dev;
+
+  //      printk("Init: Open Ethernet probe\n");
+  //    oeth_dev=alloc_etherdev(sizeof(struct oeth_private));
+  //    return do_oeth_probe(oeth_dev);
+}
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+#ifdef MODULE
+static struct net_device		*oeth_dev;		/* netdevice struct */
+
+int
+init_module(void)
+{
+  oeth_dev = grlib_oeth_probe(-1);
+  if (IS_ERR(oeth_dev)) {
+    printk(KERN_WARNING "Grlib Oeth: No core found\n");
+    return PTR_ERR(oeth_dev);
+  }
+  return 0;
+}
+
+void cleanup_module(void) {
+	
+  printk("Open Ethernet Core cleanup\n");
+  if (oeth_dev) {
+    unregister_netdev(oeth_dev);
+    kfree(oeth_dev);
+  }
+}
+
+//module_init(grlib_oeth_probe);
+//module_exit(oeth_cleanup);
+MODULE_LICENSE("GPL");
+
+#endif
+
diff -Naur ../linux-2.6.10/drivers/amba/opencores/ethermac/open_eth.h linux-2.6.10/drivers/amba/opencores/ethermac/open_eth.h
--- ../linux-2.6.10/drivers/amba/opencores/ethermac/open_eth.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/amba/opencores/ethermac/open_eth.h	2005-01-03 11:36:33.000000000 +0100
@@ -0,0 +1,143 @@
+/* Ethernet configuration registers */
+typedef struct _oeth_regs {
+        uint    moder;          /* Mode Register */
+        uint    int_src;        /* Interrupt Source Register */
+        uint    int_mask;       /* Interrupt Mask Register */
+        uint    ipgt;           /* Back to Bak Inter Packet Gap Register */
+        uint    ipgr1;          /* Non Back to Back Inter Packet Gap Register 1 */
+        uint    ipgr2;          /* Non Back to Back Inter Packet Gap Register 2 */
+        uint    packet_len;     /* Packet Length Register (min. and max.) */
+        uint    collconf;       /* Collision and Retry Configuration Register */
+        uint    tx_bd_num;      /* Transmit Buffer Descriptor Number Register */
+        uint    ctrlmoder;      /* Control Module Mode Register */
+        uint    miimoder;       /* MII Mode Register */
+        uint    miicommand;     /* MII Command Register */
+        uint    miiaddress;     /* MII Address Register */
+        uint    miitx_data;     /* MII Transmit Data Register */
+        uint    miirx_data;     /* MII Receive Data Register */
+        uint    miistatus;      /* MII Status Register */
+        uint    mac_addr0;      /* MAC Individual Address Register 0 */
+        uint    mac_addr1;      /* MAC Individual Address Register 1 */
+        uint    hash_addr0;     /* Hash Register 0 */
+        uint    hash_addr1;     /* Hash Register 1 */                           
+} oeth_regs;
+
+/* Ethernet buffer descriptor */
+typedef struct _oeth_bd {
+#if 0
+        ushort  len;            /* Buffer length */
+        ushort  status;         /* Buffer status */
+#else
+        uint    len_status;
+#endif
+        uint    addr;           /* Buffer address */
+} oeth_bd;
+
+#define OETH_REG_BASE(b)        (b)
+#define OETH_BD_BASE(b)         ((b) + 0x400)
+#define OETH_TOTAL_BD           128
+#define OETH_MAXBUF_LEN         0x600
+                                
+/* Tx BD */                     
+#define OETH_TX_BD_READY        0x8000 /* Tx BD Ready */
+#define OETH_TX_BD_IRQ          0x4000 /* Tx BD IRQ Enable */
+#define OETH_TX_BD_WRAP         0x2000 /* Tx BD Wrap (last BD) */
+#define OETH_TX_BD_PAD          0x1000 /* Tx BD Pad Enable */
+#define OETH_TX_BD_CRC          0x0800 /* Tx BD CRC Enable */
+                                
+#define OETH_TX_BD_UNDERRUN     0x0100 /* Tx BD Underrun Status */
+#define OETH_TX_BD_RETRY        0x00F0 /* Tx BD Retry Status */
+#define OETH_TX_BD_RETLIM       0x0008 /* Tx BD Retransmission Limit Status */
+#define OETH_TX_BD_LATECOL      0x0004 /* Tx BD Late Collision Status */
+#define OETH_TX_BD_DEFER        0x0002 /* Tx BD Defer Status */
+#define OETH_TX_BD_CARRIER      0x0001 /* Tx BD Carrier Sense Lost Status */
+#define OETH_TX_BD_STATS        (OETH_TX_BD_UNDERRUN            | \
+                                OETH_TX_BD_RETRY                | \
+                                OETH_TX_BD_RETLIM               | \
+                                OETH_TX_BD_LATECOL              | \
+                                OETH_TX_BD_DEFER                | \
+                                OETH_TX_BD_CARRIER)
+                                
+/* Rx BD */                     
+#define OETH_RX_BD_EMPTY        0x8000 /* Rx BD Empty */
+#define OETH_RX_BD_IRQ          0x4000 /* Rx BD IRQ Enable */
+#define OETH_RX_BD_WRAP         0x2000 /* Rx BD Wrap (last BD) */
+                                
+#define OETH_RX_BD_MISS         0x0080 /* Rx BD Miss Status */
+#define OETH_RX_BD_OVERRUN      0x0040 /* Rx BD Overrun Status */
+#define OETH_RX_BD_INVSIMB      0x0020 /* Rx BD Invalid Symbol Status */
+#define OETH_RX_BD_DRIBBLE      0x0010 /* Rx BD Dribble Nibble Status */
+#define OETH_RX_BD_TOOLONG      0x0008 /* Rx BD Too Long Status */
+#define OETH_RX_BD_SHORT        0x0004 /* Rx BD Too Short Frame Status */
+#define OETH_RX_BD_CRCERR       0x0002 /* Rx BD CRC Error Status */
+#define OETH_RX_BD_LATECOL      0x0001 /* Rx BD Late Collision Status */
+#define OETH_RX_BD_STATS        (OETH_RX_BD_MISS                | \
+                                OETH_RX_BD_OVERRUN              | \
+                                OETH_RX_BD_INVSIMB              | \
+                                OETH_RX_BD_DRIBBLE              | \
+                                OETH_RX_BD_TOOLONG              | \
+                                OETH_RX_BD_SHORT                | \
+                                OETH_RX_BD_CRCERR               | \
+                                OETH_RX_BD_LATECOL)
+
+/* MODER Register */
+#define OETH_MODER_RXEN         0x00000001 /* Receive Enable  */
+#define OETH_MODER_TXEN         0x00000002 /* Transmit Enable */
+#define OETH_MODER_NOPRE        0x00000004 /* No Preamble  */
+#define OETH_MODER_BRO          0x00000008 /* Reject Broadcast */
+#define OETH_MODER_IAM          0x00000010 /* Use Individual Hash */
+#define OETH_MODER_PRO          0x00000020 /* Promiscuous (receive all) */
+#define OETH_MODER_IFG          0x00000040 /* Min. IFG not required */
+#define OETH_MODER_LOOPBCK      0x00000080 /* Loop Back */
+#define OETH_MODER_NOBCKOF      0x00000100 /* No Backoff */
+#define OETH_MODER_EXDFREN      0x00000200 /* Excess Defer */
+#define OETH_MODER_FULLD        0x00000400 /* Full Duplex */
+#define OETH_MODER_RST          0x00000800 /* Reset MAC */
+#define OETH_MODER_DLYCRCEN     0x00001000 /* Delayed CRC Enable */
+#define OETH_MODER_CRCEN        0x00002000 /* CRC Enable */
+#define OETH_MODER_HUGEN        0x00004000 /* Huge Enable */
+#define OETH_MODER_PAD          0x00008000 /* Pad Enable */
+#define OETH_MODER_RECSMALL     0x00010000 /* Receive Small */
+ 
+/* Interrupt Source Register */
+#define OETH_INT_TXB            0x00000001 /* Transmit Buffer IRQ */
+#define OETH_INT_TXE            0x00000002 /* Transmit Error IRQ */
+#define OETH_INT_RXF            0x00000004 /* Receive Frame IRQ */
+#define OETH_INT_RXE            0x00000008 /* Receive Error IRQ */
+#define OETH_INT_BUSY           0x00000010 /* Busy IRQ */
+#define OETH_INT_TXC            0x00000020 /* Transmit Control Frame IRQ */
+#define OETH_INT_RXC            0x00000040 /* Received Control Frame IRQ */
+
+/* Interrupt Mask Register */
+#define OETH_INT_MASK_TXB       0x00000001 /* Transmit Buffer IRQ Mask */
+#define OETH_INT_MASK_TXE       0x00000002 /* Transmit Error IRQ Mask */
+#define OETH_INT_MASK_RXF       0x00000004 /* Receive Frame IRQ Mask */
+#define OETH_INT_MASK_RXE       0x00000008 /* Receive Error IRQ Mask */
+#define OETH_INT_MASK_BUSY      0x00000010 /* Busy IRQ Mask */
+#define OETH_INT_MASK_TXC       0x00000020 /* Transmit Control Frame IRQ Mask */
+#define OETH_INT_MASK_RXC       0x00000040 /* Received Control Frame IRQ Mask */
+ 
+/* Control Module Mode Register */
+#define OETH_CTRLMODER_PASSALL  0x00000001 /* Pass Control Frames */
+#define OETH_CTRLMODER_RXFLOW   0x00000002 /* Receive Control Flow Enable */
+#define OETH_CTRLMODER_TXFLOW   0x00000004 /* Transmit Control Flow Enable */
+                               
+/* MII Mode Register */        
+#define OETH_MIIMODER_CLKDIV    0x000000FF /* Clock Divider */
+#define OETH_MIIMODER_NOPRE     0x00000100 /* No Preamble */
+#define OETH_MIIMODER_RST       0x00000200 /* MIIM Reset */
+ 
+/* MII Command Register */
+#define OETH_MIICOMMAND_SCANSTAT  0x00000001 /* Scan Status */
+#define OETH_MIICOMMAND_RSTAT     0x00000002 /* Read Status */
+#define OETH_MIICOMMAND_WCTRLDATA 0x00000004 /* Write Control Data */
+ 
+/* MII Address Register */
+#define OETH_MIIADDRESS_FIAD    0x0000001F /* PHY Address */
+#define OETH_MIIADDRESS_RGAD    0x00001F00 /* RGAD Address */
+ 
+/* MII Status Register */
+#define OETH_MIISTATUS_LINKFAIL 0x00000001 /* Link Fail */
+#define OETH_MIISTATUS_BUSY     0x00000002 /* MII Busy */
+#define OETH_MIISTATUS_NVALID   0x00000004 /* Data in MII Status Register is invalid */
+

--------------040207010106040708080102--
