Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVEXA5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVEXA5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVEXAzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:55:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46745 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261285AbVEXAsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:48:31 -0400
Date: Mon, 23 May 2005 19:48:27 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ioc4: PCI bus speed detection
Message-ID: <20050523194603.M75588@chenjesu.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several hardware features of SGI's IOC4 I/O controller chip require
timing-related driver calculations dependent upon the PCI bus speed.
This patch enables the core IOC4 driver code to detect the actual bus
speed and store a value that can later be used by the IOC4 subdrivers
as needed.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>
Acked-by: Pat Gefre <pfg@sgi.com>

 drivers/serial/ioc4_serial.c |   33 ++++++-----
 drivers/sn/Kconfig           |    2
 drivers/sn/ioc4.c            |  128 +++++++++++++++++++++++++++++++++++++++++++ include/linux/ioc4.h         |   37 ++++++++++--
 4 files changed, 178 insertions(+), 22 deletions(-)

Index: linux/drivers/serial/ioc4_serial.c
===================================================================
--- linux.orig/drivers/serial/ioc4_serial.c	2005-05-23 16:02:30.367381957 -0500
+++ linux/drivers/serial/ioc4_serial.c	2005-05-23 16:08:46.636576838 -0500
@@ -299,7 +299,6 @@
 } ioc4_serial;
 
 /* UART clock speed */
-#define IOC4_SER_XIN_CLK        IOC4_SER_XIN_CLK_66
 #define IOC4_SER_XIN_CLK_66     66666667
 #define IOC4_SER_XIN_CLK_33     33333333
 
@@ -1012,21 +1011,20 @@
  * ioc4_attach_local - Device initialization.
  *			Called at *_attach() time for each
  *			IOC4 with serial ports in the system.
- * @control: ioc4_control ptr
- * @pdev: PCI handle for this device
- * @soft: soft struct for this device
- * @ioc4: ioc4 mem space
- */
-static int inline ioc4_attach_local(struct pci_dev *pdev,
-			struct ioc4_control *control,
-			struct ioc4_soft *soft, void __iomem *ioc4_misc,
-			void __iomem *ioc4_serial)
+ * @idd: Master module data for this IOC4
+ */
+static int inline ioc4_attach_local(struct ioc4_driver_data *idd)
 {
 	struct ioc4_port *port;
 	struct ioc4_port *ports[IOC4_NUM_SERIAL_PORTS];
 	int port_number;
 	uint16_t ioc4_revid_min = 62;
 	uint16_t ioc4_revid;
+	struct pci_dev *pdev = idd->idd_pdev;
+	struct ioc4_control* control = idd->idd_serial_data;
+	struct ioc4_soft *soft = control->ic_soft;
+	void __iomem *ioc4_misc = idd->idd_misc_regs;
+	void __iomem *ioc4_serial = soft->is_ioc4_serial_addr;
 
 	/* IOC4 firmware must be at least rev 62 */
 	pci_read_config_word(pdev, PCI_COMMAND_SPECIAL, &ioc4_revid);
@@ -1063,7 +1061,15 @@
 		port->ip_ioc4_soft = soft;
 		port->ip_pdev = pdev;
 		port->ip_ienb = 0;
-		port->ip_pci_bus_speed = IOC4_SER_XIN_CLK;
+		/* Use baud rate calculations based on detected PCI
+		 * bus speed.  Simply test whether the PCI clock is
+		 * running closer to 66MHz or 33MHz.
+		 */
+		if (idd->count_period/IOC4_EXTINT_COUNT_DIVISOR < 20) {
+			port->ip_pci_bus_speed = IOC4_SER_XIN_CLK_66;
+		} else {
+			port->ip_pci_bus_speed = IOC4_SER_XIN_CLK_33;
+		}
 		port->ip_baud = 9600;
 		port->ip_control = control;
 		port->ip_mem = ioc4_misc;
@@ -2733,9 +2739,8 @@
 		    "%s : request_irq fails for IRQ 0x%x\n ",
 			__FUNCTION__, idd->idd_pdev->irq);
 	}
-	if ((ret = ioc4_attach_local(idd->idd_pdev, control, soft,
-				soft->is_ioc4_misc_addr,
-				soft->is_ioc4_serial_addr)))
+	ret = ioc4_attach_local(idd);
+	if (ret)
 		goto out4;
 
 	/* register port with the serial core */
Index: linux/include/linux/ioc4.h
===================================================================
--- linux.orig/include/linux/ioc4.h	2005-05-23 16:02:30.373241266 -0500
+++ linux/include/linux/ioc4.h	2005-05-23 16:08:46.639506492 -0500
@@ -11,6 +11,14 @@
 
 #include <linux/interrupt.h>
 
+/***************
+ * Definitions *
+ ***************/
+
+/* Miscellaneous values inherent to hardware */
+
+#define IOC4_EXTINT_COUNT_DIVISOR 520	/* PCI clocks per COUNT tick */
+
 /***********************************
  * Structures needed by subdrivers *
  ***********************************/
@@ -119,19 +127,34 @@
 	} gppr[8];		/* Generic PIO pins */
 };
 
-/* One of these per IOC4
- *
- * The idd_serial_data field is present here, even though it's used
- * solely by the serial subdriver, because the main IOC4 module
- * properly owns pci_{get,set}_drvdata functionality.  This field
- * allows that subdriver to stash its own drvdata somewhere.
- */
+/* Masks for GPCR DIR pins */
+#define IOC4_GPCR_DIR_0 0x01	/* External interrupt output */
+#define IOC4_GPCR_DIR_1 0x02	/* External interrupt input */
+#define IOC4_GPCR_DIR_2 0x04
+#define IOC4_GPCR_DIR_3 0x08	/* Keyboard/mouse presence */
+#define IOC4_GPCR_DIR_4 0x10	/* Ser. port 0 xcvr select (0=232, 1=422) */
+#define IOC4_GPCR_DIR_5 0x20	/* Ser. port 1 xcvr select (0=232, 1=422) */
+#define IOC4_GPCR_DIR_6 0x40	/* Ser. port 2 xcvr select (0=232, 1=422) */
+#define IOC4_GPCR_DIR_7 0x80	/* Ser. port 3 xcvr select (0=232, 1=422) */
+
+/* Masks for GPCR EDGE pins */
+#define IOC4_GPCR_EDGE_0 0x01
+#define IOC4_GPCR_EDGE_1 0x02	/* External interrupt input */
+#define IOC4_GPCR_EDGE_2 0x04
+#define IOC4_GPCR_EDGE_3 0x08
+#define IOC4_GPCR_EDGE_4 0x10
+#define IOC4_GPCR_EDGE_5 0x20
+#define IOC4_GPCR_EDGE_6 0x40
+#define IOC4_GPCR_EDGE_7 0x80
+
+/* One of these per IOC4 */
 struct ioc4_driver_data {
 	struct list_head idd_list;
 	unsigned long idd_bar0;
 	struct pci_dev *idd_pdev;
 	const struct pci_device_id *idd_pci_id;
 	struct __iomem ioc4_misc_regs *idd_misc_regs;
+	unsigned long count_period;
 	void *idd_serial_data;
 };
 
Index: linux/drivers/sn/ioc4.c
===================================================================
--- linux.orig/drivers/sn/ioc4.c	2005-05-23 16:02:30.373241266 -0500
+++ linux/drivers/sn/ioc4.c	2005-05-23 16:21:12.165341514 -0500
@@ -29,7 +29,26 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/ioc4.h>
+#include <linux/mmtimer.h>
+#include <linux/rtc.h>
 #include <linux/rwsem.h>
+#include <asm/sn/addrs.h>
+#include <asm/sn/clksupport.h>
+#include <asm/sn/shub_mmr.h>
+
+/***************
+ * Definitions *
+ ***************/
+
+/* Tweakable values */
+
+/* PCI bus speed detection/calibration */
+#define IOC4_CALIBRATE_COUNT 63	/* Calibration cycle period */
+#define IOC4_CALIBRATE_CYCLES 256	/* Average over this many cycles */
+#define IOC4_CALIBRATE_DISCARD 2	/* Discard first few cycles */
+#define IOC4_CALIBRATE_LOW_MHZ 25	/* Lower bound on bus speed sanity */
+#define IOC4_CALIBRATE_HIGH_MHZ 75	/* Upper bound on bus speed sanity */
+#define IOC4_CALIBRATE_DEFAULT_MHZ 66	/* Assumed if sanity check fails */
 
 /************************
  * Submodule management *
@@ -101,6 +120,112 @@
  * Device management *
  *********************/
 
+#define IOC4_CALIBRATE_LOW_LIMIT \
+	(1000*IOC4_EXTINT_COUNT_DIVISOR/IOC4_CALIBRATE_LOW_MHZ)
+#define IOC4_CALIBRATE_HIGH_LIMIT \
+	(1000*IOC4_EXTINT_COUNT_DIVISOR/IOC4_CALIBRATE_HIGH_MHZ)
+#define IOC4_CALIBRATE_DEFAULT \
+	(1000*IOC4_EXTINT_COUNT_DIVISOR/IOC4_CALIBRATE_DEFAULT_MHZ)
+
+#define IOC4_CALIBRATE_END \
+	(IOC4_CALIBRATE_CYCLES + IOC4_CALIBRATE_DISCARD)
+
+#define IOC4_INT_OUT_MODE_TOGGLE 0x7	/* Toggle INT_OUT every COUNT+1 ticks */
+
+/* Determines external interrupt output clock period of the PCI bus an
+ * IOC4 is attached to.  This value can be used to determine the PCI
+ * bus speed.
+ *
+ * IOC4 has a design feature that various internal timers are derived from
+ * the PCI bus clock.  This causes IOC4 device drivers to need to take the
+ * bus speed into account when setting various register values (e.g. INT_OUT
+ * register COUNT field, UART divisors, etc).  Since this information is
+ * needed by several subdrivers, it is determined by the main IOC4 driver,
+ * even though the following code utilizes external interrupt registers
+ * to perform the speed calculation.
+ */
+static void
+ioc4_clock_calibrate(struct ioc4_driver_data *idd)
+{
+	extern unsigned long sn_rtc_cycles_per_second;
+	union ioc4_int_out int_out;
+	union ioc4_gpcr gpcr;
+	unsigned int state, last_state = 1;
+	uint64_t start = 0, end, period;
+	unsigned int count = 0;
+
+	/* Enable output */
+	gpcr.raw = 0;
+	gpcr.fields.dir = IOC4_GPCR_DIR_0;
+	gpcr.fields.int_out_en = 1;
+	writel(gpcr.raw, &idd->idd_misc_regs->gpcr_s.raw);
+
+	/* Reset to power-on state */
+	writel(0, &idd->idd_misc_regs->int_out.raw);
+	mmiowb();
+
+	printk(KERN_INFO
+	       "%s: Calibrating PCI bus speed "
+	       "for pci_dev %s ... ", __FUNCTION__, pci_name(idd->idd_pdev));
+	/* Set up square wave */
+	int_out.raw = 0;
+	int_out.fields.count = IOC4_CALIBRATE_COUNT;
+	int_out.fields.mode = IOC4_INT_OUT_MODE_TOGGLE;
+	int_out.fields.diag = 0;
+	writel(int_out.raw, &idd->idd_misc_regs->int_out.raw);
+	mmiowb();
+
+	/* Check square wave period averaged over some number of cycles */
+	do {
+		int_out.raw = readl(&idd->idd_misc_regs->int_out.raw);
+		state = int_out.fields.int_out;
+		if (!last_state && state) {
+			count++;
+			if (count == IOC4_CALIBRATE_END) {
+				end = rtc_time();
+				break;
+			} else if (count == IOC4_CALIBRATE_DISCARD)
+				start = rtc_time();
+		}
+		last_state = state;
+	} while (1);
+
+	/* Calculation rearranged to preserve intermediate precision.
+	 * Logically:
+	 * 1. "end - start" gives us number of RTC cycles over all the
+	 *    square wave cycles measured.
+	 * 2. Divide by number of square wave cycles to get number of
+	 *    RTC cycles per square wave cycle.
+	 * 3. Divide by 2*(int_out.fields.count+1), which is the formula
+	 *    by which the IOC4 generates the square wave, to get the
+	 *    number of RTC cycles per IOC4 INT_OUT count.
+	 * 4. Divide by sn_rtc_cycles_per_second to get seconds per
+	 *    count.
+	 * 5. Multiply by 1E9 to get nanoseconds per count.
+	 */
+	period = ((end - start) * 1000000000) /
+	    (IOC4_CALIBRATE_CYCLES * 2 * (IOC4_CALIBRATE_COUNT + 1)
+	     * sn_rtc_cycles_per_second);
+
+	/* Bounds check the result. */
+	if (period > IOC4_CALIBRATE_LOW_LIMIT ||
+	    period < IOC4_CALIBRATE_HIGH_LIMIT) {
+		printk("failed. Assuming PCI clock ticks are %d ns.\n",
+		       IOC4_CALIBRATE_DEFAULT / IOC4_EXTINT_COUNT_DIVISOR);
+		period = IOC4_CALIBRATE_DEFAULT;
+	} else {
+		printk("succeeded. PCI clock ticks are %ld ns.\n",
+		       period / IOC4_EXTINT_COUNT_DIVISOR);
+	}
+
+	/* Remember results.  We store the extint clock period rather
+	 * than the PCI clock period so that greater precision is
+	 * retained.  Divide by IOC4_EXTINT_COUNT_DIVISOR to get
+	 * PCI clock period.
+	 */
+	idd->count_period = period;
+}
+
 /* Adds a new instance of an IOC4 card */
 static int
 ioc4_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
@@ -170,6 +295,9 @@
 	pci_write_config_dword(idd->idd_pdev, PCI_COMMAND,
 			       pcmd | PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
 
+	/* Determine PCI clock */
+	ioc4_clock_calibrate(idd);
+
 	/* Disable/clear all interrupts.  Need to do this here lest
 	 * one submodule request the shared IOC4 IRQ, but interrupt
 	 * is generated by a different subdevice.
Index: linux/drivers/sn/Kconfig
===================================================================
--- linux.orig/drivers/sn/Kconfig	2005-05-23 16:03:49.698517875 -0500
+++ linux/drivers/sn/Kconfig	2005-05-23 16:08:46.643412698 -0500
@@ -6,7 +6,7 @@
 
 config SGI_IOC4
 	tristate "SGI IOC4 Base IO support"
-	depends on IA64_GENERIC || IA64_SGI_SN2
+	depends on (IA64_GENERIC || IA64_SGI_SN2) && MMTIMER
 	default m
 	---help---
 	This option enables basic support for the SGI IOC4-based Base IO

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
