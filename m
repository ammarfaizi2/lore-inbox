Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbVHSV4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVHSV4U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVHSV4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:56:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:38614 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932731AbVHSV4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:56:12 -0400
Date: Fri, 19 Aug 2005 16:56:04 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2] external interrupts: IOC4 driver
Message-ID: <20050819161213.B87000@chenjesu.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a device driver for the external interrupt
capabilities of the SGI IOC4 I/O controller chip.  This driver
depends upon the ioc4 driver and the extint abstraction layer
(provided in the first patch of this series).

In addition to the base capabilities present in the abstracted
external interrupt interface, this driver also provides a character
special device to expose the user-mappable register capability of
the IOC4.  This allows a user application to mmap the device in
order to directly poke at the external interrupt output control
register, thereby reducing read/write system call overhead which is
necessary when going through the abstraction layer class attribute
files.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>

 Documentation/sgi-ioc4.txt      |  177 ++++++++
 arch/ia64/configs/sn2_defconfig |    1 
 arch/ia64/defconfig             |    1 
 drivers/char/Kconfig            |    9 
 drivers/char/Makefile           |    1 
 drivers/char/ioc4_extint.c      |  791 ++++++++++++++++++++++++++++++++++++++++
 include/linux/ioc4.h            |    1 
 7 files changed, 976 insertions(+), 5 deletions(-)

diff --git a/Documentation/sgi-ioc4.txt b/Documentation/sgi-ioc4.txt
--- a/Documentation/sgi-ioc4.txt
+++ b/Documentation/sgi-ioc4.txt
@@ -3,18 +3,19 @@ it are in order.
 
 First, even though the IOC4 performs multiple functions, such as an
 IDE controller, a serial controller, a PS/2 keyboard/mouse controller,
-and an external interrupt mechanism, it's not implemented as a
+and an external interrupt mechanism, it is not implemented as a
 multifunction device.  The consequence of this from a software
 standpoint is that all these functions share a single IRQ, and
 they can't all register to own the same PCI device ID.  To make
 matters a bit worse, some of the register blocks (and even registers
 themselves) present in IOC4 are mixed-purpose between these several
-functions, meaning that there's no clear "owning" device driver.
+functions, meaning that there's no clear "owning" device driver as
+far as PCI resources are concerned.
 
 The solution is to organize the IOC4 driver into several independent
-drivers, "ioc4", "sgiioc4", and "ioc4_serial".  Note that there is no
-PS/2 controller driver as this functionality has never been wired up
-on a shipping IO card.
+drivers, "ioc4", "sgiioc4", "ioc4_serial", and "ioc4_extint".  Note
+that there is no PS/2 controller driver as this functionality has never
+been wired up on a shipping IO card.
 
 ioc4
 ====
@@ -43,3 +44,169 @@ ioc4_serial
 This is the serial driver for IOC4.  There's not much to say about it
 other than it hooks up to the ioc4 driver via the appropriate registration,
 probe, and remove functions.
+
+ioc4_extint
+===========
+Since external interrupts may not be obvious in purpose from their
+name, here's a brief rundown.
+
+Sometimes it's useful to be able to react to an physical event totally
+outside the system, or generate such an event for another system or device
+to notice.  In particular, this is useful for realtime (both soft and hard)
+systems.  IOC4-based IO controller cards provide an electrical interface
+to the outside world which can be used to ingest and generate a simple
+signal for these purposes.
+
+On the output side, one of the jacks can provide a small selection
+of output modes (low, high, a single strobe, as well as toggling or
+pulses at a specified interval) that create a 0-5V electrical output.
+On the input side, one of the jacks will cause the IOC4 to generate
+a PCI interrupt on the transition edge of an electrical signal.
+
+For the most part this driver simply registers with the "extint"
+abstracted external interrupt driver, and lets it take care of
+the user-facing details.  You are directed the Documentation/extint.txt
+file for a description thereof.  However, there are some exceptions.
+The details of the driver interface follow.
+
+external interrupt output
+-------------------------
+The output section provides several modes of output.  Modes "low" and
+"high" sets the output to either logic low or logic high.  "strobe"
+sets the output to logic high for 3 ticks (see below), then returns
+to logic low.  "toggle" alternates the output between logic low and
+logic high as configured by the period setting (see below).  "pulse"
+sets the output to logic high for 3 ticks then returns to logic low
+for an interval configured by the period setting, then repeats.
+The mode should be configurable by the abstraction layer device's
+"mode" attribute, and available modes can be found from the abstraction
+layer device's "modelist" attribute.
+
+The period can be set to a range of values determined by the PCI
+clock speed of the IOC4 device.  For the "toggle" and "pulse"
+output modes, this period determines how often the toggle or
+pulse occurs.  The IOC4 hardware is designed to divide the PCI clock
+signal by 520, and use this as the "tick" length for external
+interrupt output.  The output period can be set only to a multiple
+of this length (rounding will occur automatically in the driver).
+The "pulse" and "strobe" output modes have an logic high pulsewidth
+equal to three ticks.  The period should be configurable by the
+abstraction layer device's "period" attribute, and the tick length
+can be found from the abstraction layer device's "quantum" attribute.
+
+For reference, on a 66MHz PCI bus, the tick length is 7.8 microseconds.
+On a 33MHz PCI bus, the tick length is 15.6 microseconds.  However,
+the IOC4 driver calibrates itself to a more precise value than these
+somewhat coarse numbers, depending on actual bus speed which may vary
+slightly from bus to bus or even reboot to reboot.  Note however, that
+IOC4 is only officially supported when running at 66MHz.
+
+One device file is provided, which can be memory mapped.  The first
+32-bit quantity in the mapped area is aliased to the hardware register
+which controls output.  Direct manipulation of the register, both for
+reading and writing, may be performed in order to avoid the kernel
+overhead which would be necessary if using the abstracted interfaces.
+Assuming the typical sysfs mount point, the device number files for
+these devices can be found at:
+
+	/sys/class/ioc4_intout/intout*/dev
+
+This capability is not abstracted into the external interrupt abstraction
+layer as it is critical for an application to know that this is an IOC4
+device in order to know the format of the mapped register.  The format
+of the register is:
+
+	Bits	Field	Reset	RW	Comment
+	-----	-----	-----	--	------------------------------------
+	15:0	COUNT	X	RW	This value is reloaded into the
+					counter each time it reaches 0x0.
+					The count period is actually
+					(COUNT+1).
+	18:16	MODE	000	RW	Sets the mode for INT_OUT control:
+					000: Load a '0' to INT_OUT
+					100: Load a '1' to INT_OUT
+					101: Pulse INT_OUT high for 3 ticks
+					110: Pulse INT_OUT for 3 ticks every
+					     COUNT
+					111: Toggle INTOUT for 3 ticks every
+					     COUNT
+					001, 010, 011: NOOP
+	29:19	reserved	RO	Read as '0', writes are ignored
+	30	DIAG	0	RW	Bypass clock base divider.
+	31	INT_OUT	0x0	RO	Current state of INT_OUT signal.
+
+Note that this register should always be read and written as a 32-bit word.
+Subword accesses will read the wrong end of the register.
+
+Physical interface
+..................
+All IOC4-based external interrupt implementations utilize female 1/8 inch
+audio jacks (i.e. identical to the jacks portable stereo headphones would
+plug into).  The wiring for the output jack is:
+
+	Tip: +5V output
+	Ring: Interrupt output, open collector (active low)
+	Sleeve: Chassis ground/cable shield
+
+A two conductor shielded cable should be used to connect external
+interrupt output and input, with the two cable conductors wired to the
++5V and interrupt conductors, and the sleeves connected to the cable
+shield at both ends to maintain EMI integrity.
+
+The internal driver circuit for the the output connector is as follows:
+
+	+5 ---/\/\/\-------- 	(output +5V connector)
+
+		+-----------	(output interrupt connector)
+		|	     	open collector driver
+		|
+	      |/
+	   ---|
+	      |\
+		v
+		|
+		=		(ground)
+
+external interrupt ingest
+-------------------------
+The ingest section provides one control, the source of interrupt
+signals.  The "external" source is a circuit connected to the external
+jack provided on IOC4-based IO controller cards.  The "loopback" source
+is the output of the IOC4's interrupt output section.  The source should
+be configurable by the abstraction layer device's "source" attribute,
+and available sources can be found from the abstraction layer device's
+"sourcelist" attribute.
+
+Physical interface
+..................
+All IOC4-based external interrupt implementations utilize female 1/8 inch
+audio jacks (i.e. identical to the jacks portable stereo headphones would
+plug into).  The wiring for the input jack is:
+
+	Tip: +5V input
+	Ring: Interrupt input (active low, optoisolated)
+	Sleeve: Chassis ground/cable shield
+
+The input signal passes through an opto-isolator that has a damping effect.
+The input signal must be of sufficient duration to drive the output of the
+opto-isolator low in order for the interrupt to be recognized by the
+receiving machine.  Current experimentation shows that the threshold is
+about 2.5 microseconds.  To be safe, the driver sets its default outgoing
+pulse width to 10 microseconds.  Any hardware not from Silicon Graphics that
+is driving this line should do the same.
+
+The internal receiver circuit for the input connector is as follows:
+
+		(input +5V connector)	--------+
+						|
+					       ---
+			optoisolator LED       \ /
+					       ---
+						|
+	  (input interrupt connector)	--------+
+
+An output connector can be wired directly to an input connector, taking
+care to connect the +5V output to the +5V input and the interrupt output
+to the interrupt input.  If some other device is used to drive the input,
+it must be a +5V source current limited with a 420 ohm resistor in series,
+to avoid damaging the optoisolator.
diff --git a/arch/ia64/configs/sn2_defconfig b/arch/ia64/configs/sn2_defconfig
--- a/arch/ia64/configs/sn2_defconfig
+++ b/arch/ia64/configs/sn2_defconfig
@@ -668,6 +668,7 @@ CONFIG_MMTIMER=y
 # Misc devices
 #
 CONFIG_EXTINT=m
+CONFIG_EXTINT_SGI_IOC4=m
 
 #
 # Multimedia devices
diff --git a/arch/ia64/defconfig b/arch/ia64/defconfig
--- a/arch/ia64/defconfig
+++ b/arch/ia64/defconfig
@@ -718,6 +718,7 @@ CONFIG_MMTIMER=y
 # Misc devices
 #
 CONFIG_EXTINT=m
+CONFIG_EXTINT_SGI_IOC4=m
 
 #
 # Multimedia devices
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -420,6 +420,15 @@ config EXTINT
 	  interrupt devices (such as SGI IOC3 and IOC4 IO controllers).
 	  If you have such a device, say Y. Otherwise, say N.
 
+config EXTINT_SGI_IOC4
+	tristate "Device driver for SGI IOC4 external interrupts"
+	depends on (IA64_GENERIC || IA64_SGI_SN2) && EXTINT && BLK_DEV_SGIIOC4
+	help
+	  This option enables support for the external interrupt ingest
+	  and generation capabilities of SGI IOC4 IO controllers.  If
+	  you have an SGI Altix with an IOC4 based IO card, say Y.
+	  Otherwise, say N.
+
 source "drivers/serial/Kconfig"
 
 config UNIX98_PTYS
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_SCx200_GPIO) += scx200_gpio
 obj-$(CONFIG_GPIO_VR41XX) += vr41xx_giu.o
 obj-$(CONFIG_TANBAC_TB0219) += tb0219.o
 obj-$(CONFIG_EXTINT) += extint.o
+obj-$(CONFIG_EXTINT_SGI_IOC4) += ioc4_extint.o
 
 obj-$(CONFIG_WATCHDOG)	+= watchdog/
 obj-$(CONFIG_MWAVE) += mwave/
diff --git a/drivers/char/ioc4_extint.c b/drivers/char/ioc4_extint.c
new file mode 100644
--- /dev/null
+++ b/drivers/char/ioc4_extint.c
@@ -0,0 +1,791 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005 Silicon Graphics, Inc.  All Rights Reserved.
+ */
+
+/* This file contains the SGI IOC4 subdriver module for external interrupts.
+ *
+ * External interrupt output is used to notify an outside agent (typically
+ * another system's external interrupt input) of an event.  It provides
+ * periodic, one-shot, or level-based notification by pulling a voltage
+ * level on an 1/8" stereo-style jack on the rear of the card.
+ *
+ * External interrupt input is used to signal an event of interest to
+ * the system from an external agent (typically another system's external
+ * interrupt output).  A level or edge-sensitive (configurable) interrupt
+ * is generated when a voltage is pulled on an 1/8" stereo-style jack on
+ * the rear of the card.
+ *
+ * IOC4 has the additional capability for the output to be directly
+ * controlled by a user process memory-mapping the INT_OUT register
+ * via a register alias page.  This provides lower latency operation
+ * for applications.  This ability is provided by a device file which
+ * can be mmap'd (and not much else).  Since the format of the register
+ * aliased in this page is not something which can be abstracted away,
+ * it is provided directly by this ioc4_extint driver.
+ *
+ * 2005.07.19	Brent Casavant <bcasavan@sgi.com> Initial code
+ */
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/err.h>
+#include <linux/extint.h>
+#include <linux/ioc4.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+
+/**********************
+ * Module global data *
+ **********************/
+
+/* A 16K page can be mapped from IOC4 into a user process for direct
+ * manipulation of the INT_OUT register, avoiding syscall overhead.
+ */
+#define IOC4_A_INT_OUT_OFFSET	0x4000	/* From PCI bar0 */
+#define IOC4_A_INT_OUT_LENGTH	0x4000	/* 16KB */
+
+/* Values for INT_OUT MODE field */
+#define IOC4_INT_OUT_MODE_LOW 0x0
+#define IOC4_INT_OUT_MODE_NOOP1 0x1
+#define IOC4_INT_OUT_MODE_NOOP2 0x2
+#define IOC4_INT_OUT_MODE_NOOP3 0x3
+#define IOC4_INT_OUT_MODE_HIGH 0x4
+#define IOC4_INT_OUT_MODE_STROBE 0x5
+#define IOC4_INT_OUT_MODE_PULSE 0x6
+#define IOC4_INT_OUT_MODE_TOGGLE 0x7
+
+/* OTHER_IR field values of interest */
+#define IOC4_OTHER_IR_GEN_INT_1	0x2	/* Generic pin bit for extint input */
+
+/* Module-level globals */
+
+static char* ioc4_extint_modenames[] = {
+	[IOC4_INT_OUT_MODE_LOW]	= "low",
+	[IOC4_INT_OUT_MODE_NOOP1] = "noop",
+	[IOC4_INT_OUT_MODE_NOOP2] = "noop",
+	[IOC4_INT_OUT_MODE_NOOP3] = "noop",
+	[IOC4_INT_OUT_MODE_HIGH] = "high",
+	[IOC4_INT_OUT_MODE_STROBE] = "strobe",
+	[IOC4_INT_OUT_MODE_PULSE] = "pulse",
+	[IOC4_INT_OUT_MODE_TOGGLE] = "toggle",
+};
+
+static dev_t firstdev;		/* First dynamically allocated char dev */
+static dev_t nextdev;		/* Next device number to assign */
+static DEFINE_SPINLOCK(nextdev_lock);
+
+struct ioc4_extint_device {
+	struct ioc4_driver_data *idd;	/* IOC4 of interest */
+	struct	cdev out_cdev;		/* Mappable device for alias page */
+	dev_t	devt;		/* Corresponding device number */
+	struct class_device class_dev;	/* intout device class */
+	uint32_t *a_int_out;		/* INT_OUT register alias page */
+};
+
+/**************************************
+ * extint driver abstraction routines *
+ **************************************/
+
+static ssize_t ioc4_extint_get_mode(struct extint_device *ed, char *buf)
+{
+	union ioc4_int_out io;
+	struct ioc4_extint_device *ied = extint_get_devdata(ed);
+
+	io.raw = readl(&ied->idd->idd_misc_regs->int_out.raw);
+
+	return sprintf(buf, "%s\n", ioc4_extint_modenames[io.fields.mode]);
+}
+
+static ssize_t ioc4_extint_set_mode(struct extint_device *ed, const char *buf,
+				    size_t count)
+{
+	union ioc4_int_out io;
+	int mode;
+	struct ioc4_extint_device *ied = extint_get_devdata(ed);
+
+	/* Search modename array in reverse because most
+	 * of the interesting values are near the end.
+	 */
+	for (mode = IOC4_INT_OUT_MODE_TOGGLE; mode >= 0; mode--)
+		if (0 == strncmp(buf, ioc4_extint_modenames[mode],
+				 strlen(ioc4_extint_modenames[mode])))
+			break;
+	if (mode < 0 ||
+	    mode == IOC4_INT_OUT_MODE_NOOP1 ||
+	    mode == IOC4_INT_OUT_MODE_NOOP2 ||
+	    mode == IOC4_INT_OUT_MODE_NOOP3)
+		return -EINVAL;
+
+	io.raw = readl(&ied->idd->idd_misc_regs->int_out.raw);
+	io.fields.mode = mode;
+	writel(io.raw, &ied->idd->idd_misc_regs->int_out.raw);
+	mmiowb();
+	return count;
+}
+
+/* IOC4 supports five external interrupt generation modes (waveforms).
+ *
+ * The "high" and "low" modes set the output logically high or low,
+ * respectively.  Note that the physical output signal is active-low.
+ *
+ * The "pulse" mode sets the output to logic high for three ticks,
+ * returns to logic low, and repeats when the INT_OUT COUNT field
+ * expires.
+ *
+ * The "strobe" mode sets the output to logic high for three ticks
+ * then returns to logic low.
+ *
+ * The "toggle" mode toggles the output logic state when the INT_OUT
+ * COUNT field expires.
+ */
+static ssize_t ioc4_extint_get_modelist(struct extint_device *ed, char *buf) {
+	return sprintf(buf, "high\nlow\npulse\nstrobe\ntoggle\n");
+}
+
+/* Periodic IOC4 external interrupt generation modes trigger every
+ * COUNT+1 ticks.  The IOC4 COUNT tick length is hard-wired into the
+ * hardware as either IOC4_EXTINT_COUNT_DIVISOR PCI clock ticks (in
+ * normal operation) or 1 PCI clock tick (when the INT_OUT DIAG field
+ * is set to 1).
+ */
+static unsigned long ioc4_extint_get_period(struct extint_device *ed)
+{
+	union ioc4_int_out io;
+	unsigned long period;
+	struct ioc4_extint_device *ied = extint_get_devdata(ed);
+
+	io.raw = readl(&ied->idd->idd_misc_regs->int_out.raw);
+	period = (io.fields.count + 1) * ied->idd->count_period /
+		 (io.fields.diag ? IOC4_EXTINT_COUNT_DIVISOR : 1);
+	return period;
+}
+
+/* Periodic IOC4 external interrupt generation modes trigger every
+ * COUNT+1 ticks.  The IOC4 COUNT tick length is hard-wired into the
+ * hardware as either IOC4_EXTINT_COUNT_DIVISOR PCI clock ticks (in
+ * normal operation) or 1 PCI clock tick (when the INT_OUT DIAG field
+ * is set to 1).  We will round the requested period to the nearest
+ * quantum.
+ */
+static ssize_t ioc4_extint_set_period(struct extint_device *ed,
+				      unsigned long period)
+{
+	union ioc4_int_out io;
+	unsigned long count;
+	struct ioc4_extint_device *ied = extint_get_devdata(ed);
+
+	count = ((period + ied->idd->count_period / 2)
+		 / ied->idd->count_period) - 1;
+
+	/* Requested period must fit inside 16-bit INT_OUT COUNT field */
+	if (unlikely(count > 65535))
+		return -EINVAL;
+
+	io.raw = readl(&ied->idd->idd_misc_regs->int_out.raw);
+	io.fields.diag = 0;	/* Ensure normal mode for COUNT divisor */
+	io.fields.count = count;
+	writel(io.raw, &ied->idd->idd_misc_regs->int_out.raw);
+	return 0;
+}
+
+/* Emit enough information so that an extint user can find the corresponding
+ * ioc4_intout device.
+ */
+static ssize_t ioc4_extint_get_provider(struct extint_device *ed, char *buf)
+{
+	struct ioc4_extint_device *ied = extint_get_devdata(ed);
+
+	return sprintf(buf, "ioc4_intout%d\n", MINOR(ied->devt));
+}
+
+/* The core IOC4 driver determines the duration of each INT_OUT COUNT
+ * tick at device probe time and holds onto that value.  The granularity
+ * of any INT_OUT timing setting is one tick, thus that is our quantum.
+ */
+static unsigned long ioc4_extint_get_quantum(struct extint_device *ed)
+{
+	struct ioc4_extint_device *ied = extint_get_devdata(ed);
+	return ied->idd->count_period;
+}
+
+/* IOC4 supports two external interrupt ingest sources.
+ *
+ * The "external" source comes from the voltage detected on the input
+ * jack provided on IO9 and IO10 cards.
+ *
+ * The "loopback" source comes from the INT_OUT section of the IOC4,
+ * regardless of whether the output jack is being driven.
+ */
+static ssize_t ioc4_extint_get_source(struct extint_device *ed, char *buf)
+{
+	union ioc4_other_int other_ie;
+	struct ioc4_extint_device *ied = extint_get_devdata(ed);
+
+	other_ie.raw = readl(&ied->idd->idd_misc_regs->other_ies.raw);
+	return sprintf(buf, "%s\n",
+		       other_ie.fields.rt_int ? "loopback" : "external");
+}
+
+static ssize_t ioc4_extint_set_source(struct extint_device *ed, const char *buf,
+				      size_t count)
+{
+	union ioc4_other_int other_iec, other_ies, other_ir;
+	struct ioc4_extint_device *ied = extint_get_devdata(ed);
+
+	if (0 == strncmp(buf, "loopback", 8)) {
+		other_ies.fields.rt_int = 1;
+		other_iec.fields.gen_int = IOC4_OTHER_IR_GEN_INT_1;
+	} else if (0 == strncmp(buf, "external", 8)) {
+		other_iec.fields.rt_int = 1;
+		other_ies.fields.gen_int = IOC4_OTHER_IR_GEN_INT_1;
+	} else
+		return -EINVAL;
+
+	/* Pending interrupts to clear */
+	other_ir.raw = 0;
+	other_ir.fields.rt_int = 1;
+	other_ir.fields.gen_int = IOC4_OTHER_IR_GEN_INT_1;
+
+	/* Turn off old input source */
+	writel(other_iec.raw, &ied->idd->idd_misc_regs->other_iec.raw);
+	/* Clear pending interrupts */
+	mmiowb();
+	writel(other_ir.raw, &ied->idd->idd_misc_regs->other_ir.raw);
+	mmiowb();
+	/* Turn on new input source */
+	writel(other_ies.raw, &ied->idd->idd_misc_regs->other_ies.raw);
+
+	return count;
+}
+
+static ssize_t ioc4_extint_get_sourcelist(struct extint_device *ed, char *buf)
+{
+	return sprintf(buf, "external\nloopback\n");
+}
+
+static struct extint_properties ioc4_extint_properties = {
+	.owner = THIS_MODULE,
+	.get_mode = ioc4_extint_get_mode,
+	.set_mode = ioc4_extint_set_mode,
+	.get_modelist = ioc4_extint_get_modelist,
+	.get_period = ioc4_extint_get_period,
+	.set_period = ioc4_extint_set_period,
+	.get_provider = ioc4_extint_get_provider,
+	.get_quantum = ioc4_extint_get_quantum,
+	.get_source = ioc4_extint_get_source,
+	.set_source = ioc4_extint_set_source,
+	.get_sourcelist = ioc4_extint_get_sourcelist,
+};
+
+/**************************
+ * Misc. class attributes *
+ **************************/
+
+static ssize_t ioc4_extint_show_dev(struct class_device *class_dev, char *buf)
+{
+	struct ioc4_extint_device *ied = class_get_devdata(class_dev);
+
+	return print_dev_t(buf, ied->devt);
+}
+
+#define DECLARE_ATTR(_name,_mode,_show,_store)	\
+{					 	\
+	.attr	= { .name = __stringify(_name),	\
+		    .mode = _mode,		\
+		    .owner = THIS_MODULE },	\
+	.show	= _show,			\
+	.store	= _store,			\
+}
+
+static struct class_device_attribute ioc4_extint_class_device_attributes[] = {
+	DECLARE_ATTR(dev, 0444, ioc4_extint_show_dev, NULL),
+};
+
+/*************************
+ * IOC4-specific devices *
+ *************************/
+
+static int ioc4_extint_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct ioc4_extint_device *ied;
+	unsigned long a_int_out;
+
+	/* Can only map a single 16K page at the beginning of the file */
+	if ((IOC4_A_INT_OUT_LENGTH != vma->vm_end - vma->vm_start) ||
+	    (0 != vma->vm_pgoff))
+		return -EINVAL;
+
+	ied = container_of(filp->f_dentry->d_inode->i_cdev,
+			   struct ioc4_extint_device, out_cdev);
+
+	/* INT_OUT register alias page wasn't set up.  Either the system
+	 * page size is too large, or there was a failure during device setup.
+	 */
+	a_int_out = (unsigned long) ied->a_int_out;
+	if (!a_int_out)
+		return -ENXIO;
+
+	vma->vm_flags |= VM_IO | VM_RESERVED;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return io_remap_pfn_range(vma, vma->vm_start, a_int_out >> PAGE_SHIFT,
+				  IOC4_A_INT_OUT_LENGTH, vma->vm_page_prot);
+}
+
+static struct file_operations ioc4_extint_fops = {
+	.owner = THIS_MODULE,
+	.mmap = ioc4_extint_mmap,
+};
+
+/* Class doesn't really do anything */
+static struct class ioc4_intout_class = {
+	.name = "ioc4_intout",
+};
+
+static int ioc4_extint_device_create(struct ioc4_extint_device *ied)
+{
+	int i;
+	int ret;
+
+	/* Get next minor device number */
+	spin_lock(&nextdev_lock);
+	ied->devt = nextdev++;
+	spin_unlock(&nextdev_lock);
+
+	/* Add the character device */
+	cdev_init(&ied->out_cdev, &ioc4_extint_fops);
+	ied->out_cdev.owner = THIS_MODULE;
+	kobject_set_name(&ied->out_cdev.kobj, "ioc4_intout%d",
+			 MINOR(ied->devt));
+	ret = cdev_add(&ied->out_cdev, ied->devt, 1);
+	if (ret) {
+		printk(KERN_WARNING
+		       "%s: failed to add cdev for IOC4 device ioc4_intout%d "
+		       "for pci_dev 0x%p.\n",
+		       __FUNCTION__, MINOR(ied->devt), ied->idd->idd_pdev);
+		goto out_cdev;
+	}
+
+	/* Register as an IOC4-specific device */
+	ied->class_dev.class = &ioc4_intout_class;
+	snprintf(ied->class_dev.class_id, BUS_ID_SIZE, "intout%d",
+		 MINOR(ied->devt));
+	class_set_devdata(&ied->class_dev, ied);
+	ret = class_device_register(&ied->class_dev);
+	if (ret) {
+		printk(KERN_WARNING
+		       "%s: failed to add class device for IOC4 device "
+		       "intout%d "
+		       "for pci_dev 0x%p.\n",
+		       __FUNCTION__, MINOR(ied->devt), ied->idd->idd_pdev);
+		goto out_class;
+	}
+
+	/* Create attributes */
+	for (i = 0; i < ARRAY_SIZE(ioc4_extint_class_device_attributes); i++) {
+		ret = class_device_create_file(&ied->class_dev,
+					       &ioc4_extint_class_device_attributes[i]);
+		if (ret)
+			goto out_attr;
+	}
+
+	return 0;
+
+out_cdev:
+	kobject_put(&ied->out_cdev.kobj);
+	return ret;
+
+out_attr:
+	while (--i >= 0)
+		class_device_remove_file(&ied->class_dev,
+					 &ioc4_extint_class_device_attributes[i]);
+	class_device_unregister(&ied->class_dev);
+
+out_class:
+	cdev_del(&ied->out_cdev);
+	return ret;
+}
+
+static void ioc4_extint_device_destroy(struct ioc4_extint_device *ied)
+{
+	int i;
+
+	/* Remove all abstracted attributes */
+	for (i = 0; i < ARRAY_SIZE(ioc4_extint_class_device_attributes); i++)
+		class_device_remove_file(&ied->class_dev,
+					 &ioc4_extint_class_device_attributes[i]);
+	class_device_unregister(&ied->class_dev);
+	cdev_del(&ied->out_cdev);
+}
+
+/**********************
+ * Interrupt handling *
+ **********************/
+
+static irqreturn_t ioc4_extint_handler(int irq, void *arg, struct pt_regs *regs)
+{
+	struct ioc4_driver_data *idd = arg;
+	union ioc4_other_int other_ir, other_ir_ack;
+
+	/* Check if this is an extint interrupt (vs. serial or IDE) */
+	other_ir.raw = readl(&idd->idd_misc_regs->other_ir.raw);
+	if (!(other_ir.fields.gen_int & IOC4_OTHER_IR_GEN_INT_1) &&
+	    !other_ir.fields.rt_int)
+		return IRQ_NONE;
+
+	/* Notify abstraction layer */
+	extint_interrupt(idd->idd_extint_data);
+
+	/* Acknowledge interrupt */
+	other_ir_ack.raw = 0;
+	other_ir_ack.fields.gen_int |= other_ir.fields.gen_int &
+					IOC4_OTHER_IR_GEN_INT_1;
+	other_ir_ack.fields.rt_int |= other_ir.fields.rt_int;
+	writel(other_ir_ack.raw, &idd->idd_misc_regs->other_ir.raw);
+	mmiowb();
+
+	return IRQ_HANDLED;
+}
+
+/**************************
+ * Device probing/removal *
+ **************************/
+
+static void ioc4_extint_output_setup(struct ioc4_extint_device *ied)
+{
+	unsigned long a_int_out;
+	union ioc4_gpcr gpcr;
+
+	/* Reset to power-on state */
+	writel(0, &ied->idd->idd_misc_regs->int_out.raw);
+
+	/* Enable output */
+	gpcr.raw = 0;
+	gpcr.fields.dir = IOC4_GPCR_DIR_0;
+	gpcr.fields.int_out_en = 1;
+	writel(gpcr.raw, &ied->idd->idd_misc_regs->gpcr_s.raw);
+	mmiowb();
+
+#if PAGE_SIZE <= IOC4_A_INT_OUT_LENGTH
+	/* Only set up INT_OUT register alias page if the system page size
+	 * is equal to or less than the register alias page size.  Otherwise
+	 * the user would have access to registers other than INT_OUT.
+	 */
+	a_int_out = pci_resource_start(ied->idd->idd_pdev, 0) +
+	    IOC4_A_INT_OUT_OFFSET;
+	if (!a_int_out) {
+		printk(KERN_WARNING
+		       "%s: Unable to get IOC4 int_out alias mapping "
+		       "for pci_dev 0x%p.\n", __FUNCTION__, ied->idd->idd_pdev);
+		goto skip_alias;
+	}
+	if (!request_region(a_int_out, IOC4_A_INT_OUT_LENGTH,
+			    "ioc4_a_int_out")) {
+		printk(KERN_WARNING
+		       "%s: Unable to request IOC4 int_out alias region "
+		       "for pci_dev 0x%p.\n", __FUNCTION__, ied->idd->idd_pdev);
+		goto skip_alias;
+	}
+	ied->a_int_out = ioremap_nocache(a_int_out, IOC4_A_INT_OUT_LENGTH);
+	if (!ied->a_int_out) {
+		printk(KERN_WARNING
+		       "%s: unable to remap IOC4 int_out alias page "
+		       "for pci_dev 0x%p.\n", __FUNCTION__, ied->idd->idd_pdev);
+		release_region(a_int_out, IOC4_A_INT_OUT_LENGTH);
+	}
+skip_alias:
+#endif
+	return;
+}
+
+static void ioc4_extint_output_teardown(struct ioc4_extint_device *ied)
+{
+	union ioc4_gpcr gpcr;
+	unsigned long a_int_out;
+
+	/* Disable output */
+	gpcr.raw = 0;
+	gpcr.fields.dir = IOC4_GPCR_DIR_1;
+	gpcr.fields.int_out_en = 1;
+	writel(gpcr.raw, &ied->idd->idd_misc_regs->gpcr_c.raw);
+
+	/* Reset to power-on state */
+	writel(0, &ied->idd->idd_misc_regs->int_out.raw);
+
+	/* Release INT_OUT register alias page */
+	if (!ied->a_int_out)	/* Nothing to do if not set up */
+		return;
+
+	iounmap(ied->a_int_out);
+	a_int_out = pci_resource_start(ied->idd->idd_pdev, 0) +
+			IOC4_A_INT_OUT_OFFSET;
+	if (!a_int_out) {
+		printk(KERN_WARNING
+		       "%s: Unable to get IOC4 extint register alias mapping "
+		       "for pci_dev 0x%p.\n", __FUNCTION__, ied->idd->idd_pdev);
+	}
+	release_region(a_int_out, IOC4_A_INT_OUT_LENGTH);
+}
+
+static void ioc4_extint_input_setup(struct ioc4_extint_device *ied)
+{
+	union ioc4_other_int other_ie;
+	union ioc4_gpcr gpcr;
+
+	/* Disable all interrupt sources */
+	other_ie.raw = 0;
+	other_ie.fields.rt_int = 1;
+	other_ie.fields.gen_int = IOC4_OTHER_IR_GEN_INT_1;
+	writel(other_ie.raw, &ied->idd->idd_misc_regs->other_iec.raw);
+
+	/* Make external pin edge-sensitive */
+	gpcr.raw = 0;
+	gpcr.fields.edge = IOC4_OTHER_IR_GEN_INT_1;
+	writel(gpcr.raw, &ied->idd->idd_misc_regs->gpcr_s.raw);
+
+	/* Make external pin an input */
+	gpcr.raw = 0;
+	gpcr.fields.dir = IOC4_GPCR_EDGE_1;	/* Pin 1 */
+	writel(gpcr.raw, &ied->idd->idd_misc_regs->gpcr_c.raw);
+}
+
+static int ioc4_extint_input_enable(struct ioc4_extint_device *ied)
+{
+	union ioc4_other_int other_ie, other_ir;
+	int ret;
+
+	/* Clear pending interrupts */
+	other_ir.raw = 0;
+	other_ir.fields.rt_int = 1;	/* Clear INT_OUT section output */
+	other_ir.fields.gen_int = IOC4_OTHER_IR_GEN_INT_1; /* Clr pin inputs */
+	mmiowb();
+	writel(other_ir.raw, &ied->idd->idd_misc_regs->other_ir.raw);
+	mmiowb();
+
+	/* Register interrupt handler */
+	ret = request_irq(ied->idd->idd_pdev->irq, ioc4_extint_handler,
+			  SA_SHIRQ, "ioc4_extint", (void *)ied->idd);
+	if (ret) {
+		printk(KERN_WARNING
+		       "%s: Request for IRQ %d failed "
+		       "for pci_dev 0x%p.\n",
+		       __FUNCTION__, ied->idd->idd_pdev->irq,
+		       ied->idd->idd_pdev);
+		goto out;
+	}
+
+	/* Enable external pin and disable loopback (i.e. select
+	 * external pin as default input source)
+	 */
+	other_ie.raw = 0;
+	other_ie.fields.gen_int = IOC4_OTHER_IR_GEN_INT_1;
+	writel(other_ie.raw, &ied->idd->idd_misc_regs->other_ies.raw);
+	other_ie.raw = 0;
+	other_ie.fields.rt_int = 1;
+	writel(other_ie.raw, &ied->idd->idd_misc_regs->other_iec.raw);
+
+out:
+	return ret;
+}
+
+static void ioc4_extint_input_disable(struct ioc4_extint_device *ied)
+{
+	union ioc4_other_int other_ie, other_ir;
+
+	/* Disable interrupt sources (pin and loopback) */
+	other_ie.raw = 0;
+	other_ie.fields.rt_int = 1;
+	other_ie.fields.gen_int = IOC4_OTHER_IR_GEN_INT_1;
+	writel(other_ie.raw, &ied->idd->idd_misc_regs->other_iec.raw);
+	mmiowb();
+
+	/* Clear pending interrupts */
+	other_ir.raw = 0;
+	other_ir.fields.rt_int = 1;
+	other_ir.fields.gen_int = IOC4_OTHER_IR_GEN_INT_1;
+	writel(other_ir.raw, &ied->idd->idd_misc_regs->other_ir.raw);
+	mmiowb();
+
+	/* Remove interrupt handler */
+	free_irq(ied->idd->idd_pdev->irq, (void *)ied->idd);
+}
+
+static void ioc4_extint_input_teardown(struct ioc4_extint_device *ied)
+{
+	union ioc4_gpcr gpcr;
+
+	/* Make external pin level-sensitive */
+	gpcr.raw = 0;
+	gpcr.fields.edge = IOC4_GPCR_EDGE_1;
+	writel(gpcr.raw, &ied->idd->idd_misc_regs->gpcr_c.raw);
+
+	/* Make external pin an output */
+	gpcr.raw = 0;
+	gpcr.fields.dir = IOC4_GPCR_DIR_1;
+	writel(gpcr.raw, &ied->idd->idd_misc_regs->gpcr_s.raw);
+	mmiowb();
+}
+
+static int ioc4_extint_probe(struct ioc4_driver_data *idd)
+{
+	struct ioc4_extint_device *ied;
+	int ret;
+
+	/* Allocate and initialize control structure */
+	ied = kmalloc(sizeof(struct ioc4_extint_device), GFP_KERNEL);
+	if (!ied) {
+		printk(KERN_WARNING
+		       "%s: failed to allocate IOC4 extint device structure "
+		       "for pci_dev 0x%p.\n", __FUNCTION__, idd->idd_pdev);
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(ied, 0, sizeof(struct ioc4_extint_device));
+	ied->idd = idd;
+
+	/* Set everything to known state */
+	ioc4_extint_output_setup(ied);
+	ioc4_extint_input_setup(ied);
+
+	/* Create IOC4-specific external interrupt devices */
+	ret = ioc4_extint_device_create(ied);
+	if (ret)
+		goto out_device;
+
+	/* Register with extint abstraction layer */
+	idd->idd_extint_data =
+		extint_device_register(&ioc4_extint_properties, ied);
+	if (IS_ERR(idd->idd_extint_data)) {
+		ret = PTR_ERR(idd->idd_extint_data);
+		idd->idd_extint_data = NULL;
+		goto out_register;
+	}
+
+	/* Enable interrupt input */
+	ret = ioc4_extint_input_enable(ied);
+	if (ret)
+		goto out_enable;
+
+	return 0;
+
+out_enable:
+	extint_device_unregister(idd->idd_extint_data);
+out_register:
+	ioc4_extint_device_destroy(ied);
+out_device:
+	ioc4_extint_input_teardown(ied);
+	ioc4_extint_output_teardown(ied);
+	kfree(ied);
+out:
+	return ret;
+}
+
+static int ioc4_extint_remove(struct ioc4_driver_data *idd)
+{
+	struct extint_device *ed = idd->idd_extint_data;
+	struct ioc4_extint_device *ied;
+
+	/* If probe failed, avoid trying to remove */
+	if (ed)
+		ied = extint_get_devdata(ed);
+	else
+		return -ENXIO;
+
+	/* Disable interrupt input */
+	ioc4_extint_input_disable(ied);
+
+	/* Unregister with extint abstraction layer */
+	extint_device_unregister(ed);
+
+	/* Destroy IOC4-specific external interupt devices */
+	ioc4_extint_device_destroy(ied);
+
+	/* Set everything to default state */
+	ioc4_extint_input_teardown(ied);
+	ioc4_extint_output_teardown(ied);
+
+	/* Free memory */
+	kfree(ied);
+
+	return 0;
+}
+
+static struct ioc4_submodule ioc4_extint_submodule = {
+	.is_name = "ioc4_extint",
+	.is_owner = THIS_MODULE,
+	.is_probe = ioc4_extint_probe,
+	.is_remove = ioc4_extint_remove,
+};
+
+/*********************
+ * Module management *
+ *********************/
+
+static int __devinit
+ioc4_extint_init(void)
+{
+	int ret;
+
+	/* Reserve a block of device numbers */
+	ret = alloc_chrdev_region(&firstdev, 0, 255, "ioc4_intout");
+	if (ret) {
+		printk(KERN_WARNING
+		       "%s: failed to allocate IOC4 external interrupt output"
+		       "device numbers.\n", __FUNCTION__);
+		goto out;
+	}
+	nextdev = firstdev;
+
+	/* Simple class that allows userland to find the device numbers
+	 * allocated to IOC4-specific devices.
+	 */
+	ret = class_register(&ioc4_intout_class);
+	if (ret) {
+		printk(KERN_WARNING
+			"%s: failed to create IOC4 intout device class.\n",
+			__FUNCTION__);
+		goto out_class;
+	}
+
+	/* Submodule probe function may be called during this next call */
+	ret = ioc4_register_submodule(&ioc4_extint_submodule);
+	if (ret) {
+		printk(KERN_WARNING
+			"%s: failed to register IOC4 extint subdriver.\n",
+			__FUNCTION__);
+		goto out_submodule;
+	}
+
+	return 0;
+
+out_submodule:
+	class_unregister(&ioc4_intout_class);
+out_class:
+	unregister_chrdev_region(firstdev, 255);
+out:
+	return ret;
+}
+
+static void __devexit
+ioc4_extint_exit(void)
+{
+	/* Unhook submodule from main IOC4 module */
+	ioc4_unregister_submodule(&ioc4_extint_submodule);
+
+	/* Unregister IOC4-specific device class */
+	class_unregister(&ioc4_intout_class);
+
+	/* Release reserved device numbers */
+	unregister_chrdev_region(firstdev, 255);
+}
+
+module_init(ioc4_extint_init);
+module_exit(ioc4_extint_exit);
+
+MODULE_AUTHOR("Brent Casavant - Silicon Graphics, Inc. <bcasavan@sgi.com>");
+MODULE_DESCRIPTION("External interrupt driver for SGI IOC4 IO controller");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/ioc4.h b/include/linux/ioc4.h
--- a/include/linux/ioc4.h
+++ b/include/linux/ioc4.h
@@ -156,6 +156,7 @@ struct ioc4_driver_data {
 	struct __iomem ioc4_misc_regs *idd_misc_regs;
 	unsigned long count_period;
 	void *idd_serial_data;
+	void *idd_extint_data;
 };
 
 /* One per submodule */

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
