Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932728AbVHSV4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbVHSV4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbVHSV4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:56:12 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:38102 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932728AbVHSV4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:56:09 -0400
Date: Fri, 19 Aug 2005 16:55:58 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] external interrupts: abstraction layer
Message-ID: <20050819161054.I87000@chenjesu.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements an abstraction layer for external interrupt devices.
It creates a new sysfs class "extint" which provides a number of read-write
and a few read-only attributes which can be used to control a lower-level
hardware-specific external interrupt device driver.

The abstraction layer provides a mechanism to insulate applications from
the details of the capabilities and mechanisms of a particular external
interrupt device.  It also greatly simplifies low-level drivers.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>

 Documentation/extint.txt        |  431 +++++++++++++++++++++++++
 arch/ia64/configs/sn2_defconfig |    1 
 arch/ia64/defconfig             |    1 
 drivers/char/Kconfig            |    7 
 drivers/char/Makefile           |    1 
 drivers/char/extint.c           |  673 ++++++++++++++++++++++++++++++++++++++++
 include/linux/extint.h          |  115 ++++++
 7 files changed, 1229 insertions(+)

diff --git a/Documentation/extint.txt b/Documentation/extint.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/extint.txt
@@ -0,0 +1,431 @@
+		  External Interrupt Abstraction Layer Driver
+		       Brent Casavant <bcasavan@sgi.com>
+
+Things you might ask yourself right away
+========================================
+
+What is an external interrupt?
+------------------------------
+
+Some types of applications, particuarly realtime process-control or
+simulations, need the ability to react to some simple external event.
+One way of doing this is special hardware that generates an interrupt
+whenever some external signal is applied to it.  A good example is
+the IO9 and IO10 cards on SGI Altix machines, which have an 1/8"
+stereo-style jack where a 0-5V signal can be fed into it.  Some
+outside piece of hardware can wiggle this line to cause the IOC4
+chip on these cards to generate an interrupt.
+
+Anything else to it?
+--------------------
+
+Besides being able to receive these interrupts, sometimes you'd like to
+generate similar signals for use by the outside world.  The abstraction
+layer also provides a signal output control mechanism.
+
+Why an abstraction layer?
+-------------------------
+
+Different chips might implement the external interrupt feature in
+very different ways, but in the end you just want to know when an
+interrupt occurs, perhaps have an ongoing count of these interrupts,
+and select the source of those interrupts.  An abstraction layer
+gives us this capability without needing to depend on specifics
+of the device being used.
+
+What an application or user cares about
+=======================================
+
+The external interrupt abstraction layer provides a character device,
+and several sysfs attributes to control operation.  Assuming the
+usual /sys mount-point for sysfs, these files are:
+
+	/sys/class/extint/extint#/dev
+				  mode
+				  modelist
+				  period
+				  provider
+				  quantum
+				  source
+				  sourcelist
+
+The "extint#" component of this path is determined by the extint driver
+itself, with the "#" replaced by a number (possibly multi-digit), one
+per external interrupt device beginning at zero.  There will be one of
+these dirctories per external interrupt device.
+
+The "dev" attribute contains the major and minor number of the abstracted
+external interrupt device.  If Linux's sysfs, hotplug, and udev are
+configured appropriately, udev will automatically create a /dev/extint#
+character special device file with this major and minor number.  If
+you prefer, you may manually invoke mknod(1) to create the character
+special device file.
+
+Once created, this device file provides a counter that can be used by
+applications in a variety of ways.  It can be memory mapped read-only
+as a single page, in which case the first unsigned long word of the
+page contains a counter that is incremented each time an interrupt
+occurs.  You can use poll(2) and select(2) for reading on a read-only
+file descriptor opened on the device, in which case the poll will
+indicate whether an interrupt has occurred since the last read(2)
+or open(2) of the file, and select will return when the next interrupt
+is received.  The file can also be the subject of read(2), in which
+case it returns an string representation of the value of the counter.
+
+The "source" attribute can be written to set the hardware source of
+interrupts (e.g. SGI's IOC4 chip can trigger either from the external
+pin, or an internal loopback from its interrupt output section).  It
+can be read to determine the current setting of the source.
+
+The "sourcelist" attribute can be read to determine the list of available
+interrupt sources, one per line.  These strings are the legal values
+which can be written to the "source" attribute.
+
+The "mode" attribute can be written to set the shape of the output
+signal for interrupt generation.  For example, SGI's IOC4 chip can
+set the output to a logic low, a logic high, strobe from low to high
+to low one time, set up a repeating strobe, or repeatedly toggle between
+high and low.  It can be read to determine the current setting of the
+mode.
+
+The "modelist" attribute can be read to determine the list of available
+output modes, one per line.  These strings are the legal values which
+can be written to the "mode" attribute.  (Note that at least in the
+case of the SGI IOC4 chip, there are other values which may be read
+from the "mode" attribute which don't appear in "modelist"; these
+represent invalid hardware states.  Only the modes present from
+the modelist are valid settings to be written to the mode attribute.)
+
+The "period" attribute can be written to set the repetition interval
+for periodic output signals (e.g. repeated strobes, automatic toggling).
+This period should be specified in nanoseconds, and should be written
+as a string.  It can be read to determine the current period setting.
+
+The "quantum" attribute can be read to determine the interval to which
+any writes of the "period" attribute will be rounded.  External
+interrupt output hardware may not support nanosecond granularity
+for output periods -- this attribute allows you to determine the
+supported granularity.  The behavior of the interrupt output when
+a value which is not a multiple of the quantum is written to the
+"period" attribute is determined by the specific low-level external
+interrupt driver, however generally the low-level driver should round
+to the nearest available quantum multiple.
+
+The "provider" attribute can be read to obtain an indication of which
+low-level hardware driver and device instance is attached to the
+external interrupt interface.  This string is free-form and determined
+by the low-level driver.  For example, the SGI IOC4 low-level driver
+will return a string of the form "ioc4_intout#".
+
+What a low-level external interrupt driver writer cares about
+=============================================================
+
+The interface to the abstraction layer driver is provided through
+the extint_properties and extint_device structures as defined in
+<linux/extint.h>, and the function prototypes contained therein.
+
+Driver registration
+-------------------
+To register the low-level driver with the abstraction layer, a
+call is made to:
+
+	struct extint_device*
+	extint_device_register(struct extint_properties *ep,
+			       void *devdata);
+
+The "ep" argument is a pointer to an extint_properties structure, which
+specifies the particular low-level driver functions the abstraction layer
+should call when reading/writing the attributes described in the previous
+section.  This is described below.
+
+The "devdata" argument is an opaque pointer which is stored by the
+extint code.  This value can be retrieved or modified via
+
+	void* extint_get_devdata(const struct extint_device *ed);
+	void extint_set_devdata(struct extint_device *ed, void* devdata);
+
+respectively.  This value can be used by the low-level driver to
+determine which of multiple devices it is operating upon, or whatever
+purpose may be desired.  This is described below.
+
+The return value is either a pointer to a struct extint_device (which
+should be saved for later interrupt notification and driver deregistration),
+or a negative error value in case of registration failure.  The driver
+should be prepared to deal with such failures.
+
+Implementation functions
+------------------------
+
+The struct extint_properties is as follows:
+
+struct extint_properties {
+	struct module *owner;
+	ssize_t (*get_mode)(struct extint_device *ed, char *buf);
+	ssize_t (*set_mode)(struct extint_device *ed, const char *buf,
+			    size_t count);
+	ssize_t (*get_modelist)(struct extint_device *ed, char *buf);
+	unsigned long (*get_period)(struct extint_device *ed);
+	ssize_t (*set_period)(struct extint_device *ed, unsigned long period);
+	ssize_t (*get_provider)(struct extint_device *ed, char *buf);
+	unsigned long (*get_quantum)(struct extint_device *ed);
+	ssize_t (*get_source)(struct extint_device *ed, char *buf);
+	ssize_t (*set_source)(struct extint_device *ed, const char *buf,
+			      size_t count);
+	ssize_t (*get_sourcelist)(struct extint_device *ed, char *buf);
+};
+
+(Note: Additional fields not of interest to the low-level external interrupt
+driver may be present -- drivers are encouraged to include linux/extint.h
+to acquire this structure definition.)
+
+"owner" should be set to the module which contains the functions
+pointed to by the remaining structure members.
+
+The remaining functions implement low-level aspects of the abstraction
+layer attributes.  They all take a pointer to the struct extint_device
+as was returned from the registration function.  In all of these functions,
+the value passed as the "devdata" argument to the registration function
+can be retrieved via:
+
+	extint_get_devdata(ed);
+
+And can be updated via:
+
+	extint_set_devdata(ed, newvalue);
+
+Typically this value is a pointer to driver-specific data for the
+individual device being operated upon.  It may, for example, contain
+pointers to mapped PCI regions where control registers reside.
+
+"get_mode" and "set_mode" implement the "mode" attribute of the abstraction
+layer.  "get_mode" should write the current mode into the single-page sized
+buffer passed as the second argument, and return the length of the written
+string.  "set_mode" should read the mode specified in the buffer passed as
+the second argument, and as sized by the third, and return the number of
+characters consumed (or a negative error number in event of failure).
+It should of course also cause the output mode to be set as requested.
+
+"get_modelist" implements the "modelist" attribute of the abstraction
+layer.  "get_modelist" should write strings representing the available
+interrupt output generation modes into the single-page sized buffer
+passed as the second argument, one mode per line.  It should return
+the number of bytes written into this buffer.
+
+"get_period" and "set_period" implement the "period" attribute of the
+abstraction layer.  "get_period" should return an unsigned long which
+represents the current repetition period in nanoseconds.  "set_period"
+should accept an unsigned long as the new value for the repetition
+period, specified in nanoseconds, and returning either 0 or a negative
+error number indicating a failure.  If the requested repetition period
+is not a value which can be exactly set into the underlying hardware,
+the driver is free to adjust the value as it sees fit, though tyipically
+it should round the value to the nearest available value.
+
+"get_provider" implements the "provider" attribute of the abstraction
+layer.  "get_provider" should write a human-readable string which
+identifies the low-level driver and a particular instance of a the
+driven hardware device.  For example, if the low-level driver provides
+its own additional device files for extra functionality not present
+in the abstraction layer, this routine might emit the name of the
+driver module and the names (or device numbers) of the low-level
+driver's own character special device files.
+
+"get_quantum" implements the "quantum" attribute of the abstraction
+layer.  "get_quantum" should return an unsigned long which represents
+the granularity to which the interrupt output repetition period can
+be set, in nanoseconds.
+
+"get_source" and "set_source" implement the "source" attribute of the
+abstraction layer.  "get_source" should write the current interrupt
+input source into the single-page sized buffer passed as the second
+argument, and return the length of the written string.  "set_source"
+should read the source specified in the buffer passed as the second
+argument, and as sized by the third, and return the number of characters
+consumed (or a negative error number in event of failure).   It should
+of course also cause the input source to be selected as requested.
+
+"get_sourcelist" implements the "sourcelist" attribute of the abstraction
+layer.  "get_sourcelist" should write strings representing the available
+interrupt input sources into the single-page sized buffer passed as the
+second argument, one source per line.  It should return the number of
+bytes written into this buffer.
+
+When an interrupt occurs
+------------------------
+
+When an external interrupt signal triggers an interrupt that is
+handled by the low-level driver, the driver should call:
+
+	void
+	extint_interrupt(struct extint_device *ed);
+
+This allows the abstraction layer to perform any appropriate
+abstracted actions (i.e. update the interrupt count, trigger
+poll/select actions, etc).  The sole argument is the struct
+extint_device which was returned from the registration call.
+
+Driver deregistration
+---------------------
+
+When the driver desires to unregister a particular device previously
+registered with the abstraction layer, it should call:
+
+	void
+	extint_device_unregister(struct extint_device *ed);
+
+The sole argument is the struct extint_device which was returned
+from the registration call.  There is no error return from this
+call, however if invalid data is passed to it the likelihood of
+a kernel panic is very high indeed.
+
+What a kernel-level external interrupt user cares about
+=======================================================
+
+In addition to the user-visible aspects of the external interrupt
+abstraction layer, there is a kernel-only interface available for
+interrupt notification.  This interface provides the ability for
+other kernel modules to register a callout to be invoked whenever
+an external interrupt is ingested for a particular device.
+
+Callout registration
+--------------------
+
+To register a callout to be invoked upon interrupt ingest, a
+struct extint_callout should be allocated, filled in, and
+passed to:
+
+	int
+	extint_callout_register(struct extint_device *ed,
+				struct extint_callout *ec);
+
+The first argument is the struct extint_device corresponding to
+the particular abstracted external interrupt hardware device of
+interest.  How exactly this structure is found is up to the
+caller, however the "file_to_extint_device" function will convert
+a struct file pointer to a struct extint_device pointer.  This
+function will return -EINVAL if an inappropriate file descriptor
+is passed to it.
+
+The second argument is one of the following structures:
+
+struct extint_callout {
+	struct module* owner;
+	void (*function)(void *);
+	void *data;
+};
+
+(Note: Additional fields not of interest to the external interrupt user
+may be present -- drivers are encouraged to include linux/extint.h
+to acquire this structure definition.)
+
+The "owner" field should be set to the module containing the function
+and data pointed to by the remaining fields.
+
+The "function" pointer is a callout function which is to be invoked
+whenever an interrupt is ingested by the abstraction layer for the
+device of interest.  It will be passed as its sole argument the
+"data" field, which is used opaquely and is provided solely for use
+by the caller.  That is, the abstraction layer will invoke:
+
+	ec->function(data);
+
+upon each interrupt of the specified device.
+
+Multiple callouts can be registered for the same abstracted external
+interrupt device.  They will be invoked in no guaranteed order, but
+will be invoked one at a time.
+
+The interrupt counter will be incremented before the callouts are
+invoked, but before any signal/poll notifications occur.
+
+The module specified by the "owner" field in the callout structure,
+as well as the module corresponding to the low-level external interrupt
+device driver, will have their reference counts increased by one until
+the callout is deregistered.
+
+Callout deregistration
+----------------------
+
+To remove a callout, simply call:
+
+	extern void
+	extint_callout_unregister(struct extint_device *ed,
+				  struct extint_callout *ec);
+
+With the same arguments as provided during callout registration.
+Both active and orphaned callouts can be removed in this manner
+with no distinction between the two.
+
+The callout function must continue to be able to be invoked
+until the call to extint_callout_unregister completes.
+
+Things you might ask yourself at the end
+========================================
+
+What if my hardware device supports a capability not in the abstraction?
+------------------------------------------------------------------------
+
+There are two possibilities.  The first would be to add a new attribute
+to the abstraction, modify struct extint_properties to add appropriate
+interface routines, and update any existing drivers as necessary.
+
+The second, and generally preferable method, is for the the
+low-level driver to create its own device class and corresponding
+attributes and/or character special devices.  This is definitely
+the correct route to take if the capability is dependent on the
+hardware in a method that cannot be abstracted.
+
+A good example is the SGI IOC4's ability to map the interrupt output
+control register directly into a user application to avoid the kernel
+overhead of reading/writing the abstracted attribute files.  Using
+this capability means that the application must have intimate knowledge
+of the format of the control register -- something which both cannot
+be abstracted away by the kernel, and which is very specific to this
+particular IO controller chip.  This capability is provided by the
+ioc4_extint driver supplying its own character special device along
+with an ioc4_intout device class.
+
+Is there an example low-level driver to pattern mine after?
+-----------------------------------------------------------
+
+Sure.  linux/drivers/char/ioc4_extint.c
+
+Note that this low-level driver in addition to providing the
+abstraction interface, creates an IOC4-specific character
+special device and an IOC4-specific device class, as mentioned
+in the answer to the previous question.
+
+Why the callout mechanism?
+--------------------------
+
+For systems (not just applications, we're taking a higher-level view
+here) which are critically interested in responding as quickly as
+possible to an externally triggered event, waiting for a poll/select
+operation, or even busy-waiting on the value of the interrupt counter
+to change may not provide appropriate response times or have other
+deleterious effects (i.e. tieing up a CPU spinning on a value).  This
+gives the system architecht a tool to gain minimal-latency notification
+of events, and react accordingly, by writing their own kernel module.
+
+It also provides an extension capability that might be of interest
+in certain scenarios.  For example, there could be an application
+that wants a interrupt counter page much as maintained by the
+abstraction layer, but which starts counting at zero when the
+device special file is opened.  Or, there could be an application
+which wants a signal to be generated and delivered to the process
+when an interrupt is ingested.  These examples are more esoteric
+than the simple counter page, and are best provided by a seperate
+module rather than cluttering the main external interrupt abstraction
+code.
+
+Why wasn't this made compatible with IRIX's ei(7) driver from an
+application perspective?
+----------------------------------------------------------------
+
+IRIX's driver uses ioctl(2) calls to interact with user space.  This
+is frowned upon in Linux, and generally doesn't perform very well on
+Linux due to kernel locking issues.
+
+One advantage gained by this mechanism is control methods which are
+easily utilized from the command-line, rather than requiring specially
+written and compiled applications to function the device.
diff --git a/arch/ia64/configs/sn2_defconfig b/arch/ia64/configs/sn2_defconfig
--- a/arch/ia64/configs/sn2_defconfig
+++ b/arch/ia64/configs/sn2_defconfig
@@ -667,6 +667,7 @@ CONFIG_MMTIMER=y
 #
 # Misc devices
 #
+CONFIG_EXTINT=m
 
 #
 # Multimedia devices
diff --git a/arch/ia64/defconfig b/arch/ia64/defconfig
--- a/arch/ia64/defconfig
+++ b/arch/ia64/defconfig
@@ -717,6 +717,7 @@ CONFIG_MMTIMER=y
 #
 # Misc devices
 #
+CONFIG_EXTINT=m
 
 #
 # Multimedia devices
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -413,6 +413,13 @@ config SGI_MBCS
          If you have an SGI Altix with an attached SABrick
          say Y or M here, otherwise say N.
 
+config EXTINT
+	tristate "Abstraction layer for external interrupt devices"
+	help
+	  This option provides an abstraction layer for external
+	  interrupt devices (such as SGI IOC3 and IOC4 IO controllers).
+	  If you have such a device, say Y. Otherwise, say N.
+
 source "drivers/serial/Kconfig"
 
 config UNIX98_PTYS
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_NWFLASH) += nwflash.o
 obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
 obj-$(CONFIG_GPIO_VR41XX) += vr41xx_giu.o
 obj-$(CONFIG_TANBAC_TB0219) += tb0219.o
+obj-$(CONFIG_EXTINT) += extint.o
 
 obj-$(CONFIG_WATCHDOG)	+= watchdog/
 obj-$(CONFIG_MWAVE) += mwave/
diff --git a/drivers/char/extint.c b/drivers/char/extint.c
new file mode 100644
--- /dev/null
+++ b/drivers/char/extint.c
@@ -0,0 +1,673 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005 Silicon Graphics, Inc.  All Rights Reserved.
+ */
+
+/* This file provides an abstraction for lowlevel external interrupt
+ * operation.
+ *
+ * External interrupts are hardware mechanisms to generate or ingest
+ * a simple interrupt signal.
+ *
+ * Generation typically involves driving an output circuit voltage
+ * level, with a variety of single or recurring waveforms (e.g.
+ * a one-shot pulse, a square wave, etc.)  The repetition period
+ * for recurring waveforms can be set within hardware restrictions.
+ *
+ * Ingest typically involves responding to an input circuit voltage
+ * level or transition.  Multiple input sources may be available.
+ *
+ * 2005.07.27	Brent Casavant <bcasavan@sgi.com> Initial code
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/ctype.h>
+#include <linux/err.h>
+#include <linux/extint.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/kallsyms.h>
+#include <linux/device.h>
+#include <linux/poll.h>
+
+/**********************
+ * Module global data *
+ **********************/
+
+/* Device numbers */
+#define EXTINT_NUMDEVS	255	/* Number of minor devices to reserve */
+static dev_t firstdev;		/* Start of dynamic range */
+static dev_t nextdev;		/* Next number to assign */
+static DEFINE_SPINLOCK(nextdev_lock);
+
+/* Device status.  Controls whether new callouts can be registered. */
+enum extint_state {
+	EXTINT_COMING,
+	EXTINT_ALIVE,
+	EXTINT_GOING,
+	EXTINT_DEAD
+};
+
+/**********************
+ * Abstracted devices *
+ **********************/
+
+static struct page *extint_counter_vma_nopage(struct vm_area_struct *vma,
+					      unsigned long address, int *type)
+{
+	struct extint_device *ed = vma->vm_private_data;
+	struct page *page;
+
+	/* Only a single page is ever mapped */
+	if (address >= vma->vm_start + PAGE_SIZE)
+		return NOPAGE_SIGBUS;
+
+	/* virt_to_page can be expensive, but this is executed
+	 * only once each time the counter page is mapped.
+	 */
+	page = virt_to_page(ed->counter_page);
+	get_page(page);
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+
+	return page;
+}
+
+static struct vm_operations_struct extint_counter_vm_ops = {
+	.nopage = extint_counter_vma_nopage,
+};
+
+static int extint_counter_open(struct inode *inode, struct file *filp)
+{
+	struct extint_device *ed = file_to_extint_device(filp);
+
+	/* Counter is always read-only */
+	if (filp->f_mode & FMODE_WRITE)
+		return -EPERM;
+
+	/* Prevent low-level module from unloading while
+	 * corresponding abstracted device is open
+	 */
+	if (!try_module_get(ed->props->owner))
+		return -ENXIO;
+
+	/* Snapshot initial value, for later use by poll */
+	filp->private_data = (void *)*ed->counter_page;
+
+	return 0;
+}
+
+static int extint_counter_release(struct inode *inode, struct file *filp)
+{
+	struct extint_device *ed = file_to_extint_device(filp);
+
+	/* Allow low-level module to unload now that the
+	 * corresponding abstracted device is really closed.
+	 */
+	module_put(ed->props->owner);
+
+	return 0;
+}
+
+static ssize_t
+extint_counter_read(struct file *filp, char *buff, size_t count, loff_t * offp)
+{
+	struct extint_device *ed = file_to_extint_device(filp);
+	char outbuff[21];	/* 20 chars for value of 2^64, plus \0 */
+
+	/* Snapshot last value read, for later use by poll */
+	memset(outbuff, 0, 21);
+	filp->private_data = (void *)*ed->counter_page;
+	snprintf(outbuff, 21, "%ld", (unsigned long)filp->private_data);
+	outbuff[20] = '\0';
+
+	return simple_read_from_buffer(buff, count, offp, outbuff,
+				       strlen(outbuff));
+}
+
+static int extint_counter_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct extint_device *ed = file_to_extint_device(filp);
+
+	if ((PAGE_SIZE != vma->vm_end - vma->vm_start) || (0 != vma->vm_pgoff))
+		return -EINVAL;
+
+	vma->vm_ops = &extint_counter_vm_ops;
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_flags &= ~(VM_WRITE | VM_MAYWRITE);	/* Read-only */
+	vma->vm_private_data = ed;
+	return 0;
+}
+
+static unsigned int
+extint_counter_poll(struct file *filp, struct poll_table_struct *wait)
+{
+	struct extint_device *ed = file_to_extint_device(filp);
+
+	poll_wait(filp, &ed->counter_queue, wait);
+
+	/* Check counter against last value read from it */
+	if (*ed->counter_page != (unsigned long)filp->private_data)
+		return (POLLIN | POLLRDNORM);
+
+	return 0;
+}
+
+static struct file_operations extint_fops = {
+	.owner = THIS_MODULE,
+	.open = extint_counter_open,
+	.release = extint_counter_release,
+	.read = extint_counter_read,
+	.mmap = extint_counter_mmap,
+	.poll = extint_counter_poll,
+};
+
+static int extint_device_create(struct extint_device *ed)
+{
+	int ret;
+
+	/* Allocate counter page */
+	ed->counter_page = (unsigned long *)get_zeroed_page(GFP_KERNEL);
+	if (!ed->counter_page) {
+		printk(KERN_WARNING
+		       "%s: failed to allocate extint counter page.\n",
+		       __FUNCTION__);
+		ret = -ENOMEM;
+		goto out_page;
+	}
+
+	/* Set up device */
+	init_waitqueue_head(&ed->counter_queue);
+	cdev_init(&ed->counter_cdev, &extint_fops);
+	ed->counter_cdev.owner = THIS_MODULE;
+	kobject_set_name(&ed->counter_cdev.kobj, "extint_counter%d",
+			 MINOR(ed->devt));
+	ret = cdev_add(&ed->counter_cdev, ed->devt, 1);
+	if (ret) {
+		printk(KERN_WARNING
+		       "%s: failed to add cdev for extint_counter%d.\n",
+		       __FUNCTION__, MINOR(ed->devt));
+		goto out_cdev;
+	}
+
+	return 0;
+
+out_cdev:
+	kobject_put(&ed->counter_cdev.kobj);
+	free_page((unsigned long)ed->counter_page);
+out_page:
+	return ret;
+}
+
+static void extint_device_destroy(struct extint_device *ed)
+{
+	BUG_ON(waitqueue_active(&ed->counter_queue));
+	cdev_del(&ed->counter_cdev);
+}
+
+/**************************
+ * Misc. class attributes *
+ **************************/
+
+static ssize_t extint_show_dev(struct class_device *cdev, char *buf)
+{
+	struct extint_device *ed = class_get_devdata(cdev);
+
+	return print_dev_t(buf, ed->devt);
+}
+
+/********************************
+ * Abstracted device attributes *
+ ********************************/
+
+#define classdev_to_extint_device(obj)	\
+	container_of(obj, struct extint_device, class_dev)
+
+/* Gets current mode (shape) of interrupt generation */
+static ssize_t extint_show_mode(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct extint_device *ed = classdev_to_extint_device(cdev);
+
+	down(&ed->sem);
+	if (likely(ed->props && ed->props->get_mode))
+		rc = ed->props->get_mode(ed, buf);
+	else
+		rc = -ENXIO;
+	up(&ed->sem);
+
+	return rc;
+}
+
+/* Sets the mode (shape) of interrupt generation */
+static ssize_t extint_store_mode(struct class_device *cdev, const char *buf,
+				 size_t count)
+{
+	int rc;
+	struct extint_device *ed = classdev_to_extint_device(cdev);
+
+	down(&ed->sem);
+	if (likely(ed->props && ed->props->set_mode))
+		rc = ed->props->set_mode(ed, buf, count);
+	else
+		rc = -ENXIO;
+	up(&ed->sem);
+
+	return rc;
+}
+
+/* Gets available modes of interrupt generation */
+static ssize_t extint_show_modelist(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct extint_device *ed = classdev_to_extint_device(cdev);
+
+	down(&ed->sem);
+	if (likely(ed->props && ed->props->get_modelist))
+		rc = ed->props->get_modelist(ed, buf);
+	else
+		rc = -ENXIO;
+	up(&ed->sem);
+
+	return rc;
+}
+
+/* Gets period (nanoseconds) of periodic modes of interrupt generation */
+static ssize_t extint_show_period(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct extint_device *ed = classdev_to_extint_device(cdev);
+
+	down(&ed->sem);
+	if (likely(ed->props && ed->props->get_period))
+		rc = sprintf(buf, "%ld\n", ed->props->get_period(ed));
+	else
+		rc = -ENXIO;
+	up(&ed->sem);
+
+	return rc;
+}
+
+static ssize_t extint_show_provider(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct extint_device *ed = classdev_to_extint_device(cdev);
+
+	down(&ed->sem);
+	if (likely(ed->props && ed->props->get_provider))
+		rc = ed->props->get_provider(ed, buf);
+	else
+		rc = -ENXIO;
+	up(&ed->sem);
+
+	return rc;
+}
+
+/* Sets period (nanoseconds) of periodic modes of interrupt generation */
+static ssize_t extint_store_period(struct class_device *cdev, const char *buf,
+				   size_t count)
+{
+	int rc;
+	char *endp;
+	unsigned long period;
+	struct extint_device *ed = classdev_to_extint_device(cdev);
+
+	period = simple_strtoul(buf, &endp, 0);
+	if (*endp && !isspace(*endp))
+		return -EINVAL;
+
+	down(&ed->sem);
+	if (likely(ed->props && ed->props->set_period)) {
+		rc = ed->props->set_period(ed, period);
+		if (!rc)
+			rc = count;	/* Swallow entire input */
+	} else
+		rc = -ENXIO;
+	up(&ed->sem);
+
+	return rc;
+}
+
+/* Gets rounding increment for interrupt generation periodic modes */
+static ssize_t extint_show_quantum(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct extint_device *ed = classdev_to_extint_device(cdev);
+
+	down(&ed->sem);
+	if (likely(ed->props))
+		rc = sprintf(buf, "%ld\n", ed->props->get_quantum(ed));
+	else
+		rc = -ENXIO;
+	up(&ed->sem);
+
+	return rc;
+}
+
+/* Gets current source of interrupt ingest */
+static ssize_t extint_show_source(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct extint_device *ed = classdev_to_extint_device(cdev);
+
+	down(&ed->sem);
+	if (likely(ed->props && ed->props->get_source))
+		rc = ed->props->get_source(ed, buf);
+	else
+		rc = -ENXIO;
+	up(&ed->sem);
+
+	return rc;
+}
+
+/* Sets source of interrupt ingest */
+static ssize_t extint_store_source(struct class_device *cdev, const char *buf,
+				   size_t count)
+{
+	int rc;
+	struct extint_device *ed = classdev_to_extint_device(cdev);
+
+	down(&ed->sem);
+	if (likely(ed->props && ed->props->set_source))
+		rc = ed->props->set_source(ed, buf, count);
+	else
+		rc = -ENXIO;
+	up(&ed->sem);
+
+	return rc;
+}
+
+/* Gets list of available sources of interrupt ingest */
+static ssize_t extint_show_sourcelist(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct extint_device *ed = classdev_to_extint_device(cdev);
+
+	down(&ed->sem);
+	if (likely(ed->props && ed->props->get_sourcelist))
+		rc = ed->props->get_sourcelist(ed, buf);
+	else
+		rc = -ENXIO;
+	up(&ed->sem);
+
+	return rc;
+}
+
+/* Release allocated memory when last reference to a device goes away */
+static void extint_class_release(struct class_device *cdev)
+{
+	struct extint_device *ed = classdev_to_extint_device(cdev);
+
+	BUG_ON(ed->state != EXTINT_DEAD);
+	BUG_ON(!list_empty(&ed->callouts));
+	kfree(ed);
+}
+
+static struct class extint_class = {
+	.name = "extint",
+	.release = extint_class_release,
+};
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
+static struct class_device_attribute extint_class_device_attributes[] = {
+	DECLARE_ATTR(dev, 0444, extint_show_dev, NULL),
+	DECLARE_ATTR(mode, 0644, extint_show_mode, extint_store_mode),
+	DECLARE_ATTR(modelist, 0444, extint_show_modelist, NULL),
+	DECLARE_ATTR(period, 0644, extint_show_period, extint_store_period),
+	DECLARE_ATTR(provider, 0444, extint_show_provider, NULL),
+	DECLARE_ATTR(quantum, 0444, extint_show_quantum, NULL),
+	DECLARE_ATTR(source, 0644, extint_show_source, extint_store_source),
+	DECLARE_ATTR(sourcelist, 0444, extint_show_sourcelist, NULL),
+};
+
+/*************
+ * Interface *
+ *************/
+
+/* Register a low-level driver with the abstraction layer */
+struct extint_device *extint_device_register(struct extint_properties *ep,
+					     void *devdata)
+{
+	struct extint_device *ed;
+	int rc;
+	int i;
+
+	/* Create new control structure and initialize */
+	ed = kmalloc(sizeof(struct extint_device), GFP_KERNEL);
+	if (unlikely(!ed))
+		return ERR_PTR(-ENOMEM);
+	memset(ed, 0, sizeof(struct extint_device));
+
+	ed->state = EXTINT_COMING;
+	init_MUTEX(&ed->sem);
+	ed->props = ep;
+	INIT_LIST_HEAD(&ed->callouts);
+	spin_lock_init(&ed->callouts_lock);
+	extint_set_devdata(ed, devdata);
+
+	/* Allocate device number */
+	spin_lock(&nextdev_lock);
+	ed->devt = nextdev++;
+	spin_unlock(&nextdev_lock);
+	if (ed->devt > (firstdev + EXTINT_NUMDEVS)) {
+		rc = -ENOSPC;
+		goto out_devnum;
+	}
+
+	/* Add this device to the class */
+	ed->class_dev.class = &extint_class;
+	snprintf(ed->class_dev.class_id, BUS_ID_SIZE, "extint%d",
+		 MINOR(ed->devt));
+	class_set_devdata(&ed->class_dev, ed);
+	rc = class_device_register(&ed->class_dev);
+	if (rc)
+		goto out_class;
+
+	/* Create character device */
+	rc = extint_device_create(ed);
+	if (rc)
+		goto out_device;
+
+	/* Create attributes */
+	for (i = 0; i < ARRAY_SIZE(extint_class_device_attributes); i++) {
+		rc = class_device_create_file(&ed->class_dev,
+					      &extint_class_device_attributes
+					      [i]);
+		if (rc)
+			goto out_attr;
+	}
+
+	ed->state = EXTINT_ALIVE;
+	return ed;
+
+out_class:
+out_devnum:
+	ed->state = EXTINT_DEAD;
+	kfree(ed);
+	return ERR_PTR(rc);
+
+out_attr:
+	while (--i >= 0)
+		class_device_remove_file(&ed->class_dev,
+					 &extint_class_device_attributes[i]);
+out_device:
+	ed->state = EXTINT_DEAD;
+	class_device_unregister(&ed->class_dev);
+	/* extint_class_release frees ed for us */
+	return ERR_PTR(rc);
+}
+
+EXPORT_SYMBOL(extint_device_register);
+
+/* Unregister a previously registered low-level driver */
+void extint_device_unregister(struct extint_device *ed)
+{
+	int i;
+
+	if (!ed)
+		return;
+
+	/* Remove counter device */
+	ed->state = EXTINT_GOING;
+	BUG_ON(!list_empty(&ed->callouts));
+	extint_device_destroy(ed);
+
+	/* Remove all abstracted attributes */
+	for (i = 0; i < ARRAY_SIZE(extint_class_device_attributes); i++)
+		class_device_remove_file(&ed->class_dev,
+					 &extint_class_device_attributes[i]);
+
+	/* Make sure device-specific functions are never invoked again */
+	down(&ed->sem);
+	ed->props = NULL;
+	up(&ed->sem);
+	ed->state = EXTINT_DEAD;
+
+	/* Remove this device from the class */
+	class_device_unregister(&ed->class_dev);
+}
+
+EXPORT_SYMBOL(extint_device_unregister);
+
+/* Obtain extint_device structure from an open file */
+struct extint_device *file_to_extint_device(const struct file *filp)
+{
+	/* Validate that this really is an extint device file */
+	if (filp->f_dentry->d_inode->i_cdev->dev < firstdev ||
+	    filp->f_dentry->d_inode->i_cdev->dev > (firstdev + EXTINT_NUMDEVS))
+		return ERR_PTR(-EINVAL);
+
+	return container_of(filp->f_dentry->d_inode->i_cdev,
+			    struct extint_device, counter_cdev);
+}
+
+EXPORT_SYMBOL(file_to_extint_device);
+
+/* Register a callout function to invoke when an interrupt is ingested */
+int extint_callout_register(struct extint_device *ed, struct extint_callout *ec)
+{
+	int ret;
+	unsigned long flags;
+
+	/* Disallow unload of callout owner */
+	if (!try_module_get(ec->owner))
+		return -ENXIO;
+
+	/* Disallow unload of low-level driver */
+	if (!try_module_get(ed->props->owner)) {
+		module_put(ec->owner);
+		return -ENXIO;
+	}
+
+	spin_lock_irqsave(&ed->callouts_lock, flags);
+	switch (ed->state) {
+	case EXTINT_COMING:
+		ret = -EAGAIN;
+		module_put(ed->props->owner);
+		module_put(ec->owner);
+		break;
+	case EXTINT_ALIVE:
+		list_add(&ec->list, &ed->callouts);
+		ret = 0;
+		break;
+	default:
+		ret = -EBUSY;
+		module_put(ed->props->owner);
+		module_put(ec->owner);
+		break;
+	}
+	spin_unlock_irqrestore(&ed->callouts_lock, flags);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(extint_callout_register);
+
+/* Unregister a previously registered callout function */
+void extint_callout_unregister(struct extint_device *ed,
+			       struct extint_callout *ec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ed->callouts_lock, flags);
+	list_del(&ec->list);
+	spin_unlock_irqrestore(&ed->callouts_lock, flags);
+
+	/* Allow callout owner to unload */
+	module_put(ec->owner);
+	/* Allow low-level driver to unload */
+	module_put(ed->props->owner);
+}
+
+EXPORT_SYMBOL(extint_callout_unregister);
+
+/* Allows a low-level driver to notify the
+ * abstraction layer of an ingested interrupt.
+ */
+void extint_interrupt(struct extint_device *ed)
+{
+	struct extint_callout *ec;
+
+	/* Bump global counter */
+	(*ed->counter_page)++;
+
+	/* Invoke all registered callouts */
+	spin_lock(&ed->callouts_lock);
+	list_for_each_entry(ec, &ed->callouts, list)
+		ec->function(ec->data);
+	spin_unlock(&ed->callouts_lock);
+
+	/* Wake up poll/select waiters */
+	wake_up_all(&ed->counter_queue);
+}
+
+EXPORT_SYMBOL(extint_interrupt);
+
+/*********************
+ * Module management *
+ *********************/
+
+static int __devinit extint_init(void)
+{
+	int ret;
+
+	/* Reserve a block of device numbers */
+	ret = alloc_chrdev_region(&firstdev, 0, EXTINT_NUMDEVS, "extint");
+	if (ret) {
+		printk(KERN_WARNING
+		       "%s: failed to allocate external interrupt "
+		       "device numbers.\n", __FUNCTION__);
+		return ret;
+	}
+	nextdev = firstdev;
+
+	return class_register(&extint_class);
+}
+
+static void __devexit extint_exit(void)
+{
+	class_unregister(&extint_class);
+
+	unregister_chrdev_region(firstdev, EXTINT_NUMDEVS);
+}
+
+module_init(extint_init);
+module_exit(extint_exit);
+
+MODULE_AUTHOR("Brent Casavant - Silicon Graphics, Inc. <bcasavan@sgi.com>");
+MODULE_DESCRIPTION("External interrupt abstraction class module");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/extint.h b/include/linux/extint.h
new file mode 100644
--- /dev/null
+++ b/include/linux/extint.h
@@ -0,0 +1,115 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2005 Silicon Graphics, Inc.  All Rights Reserved.
+ */
+
+/* External interrupt control abstraction */
+
+#ifndef _LINUX_EXTINT_H
+#define _LINUX_EXTINT_H
+
+#include <linux/device.h>
+
+struct extint_device;
+
+struct extint_properties {
+	/* Owner module */
+	struct module *owner;
+
+	/* Get/set generation mode */
+	ssize_t (*get_mode)(struct extint_device * ed, char *buf);
+	ssize_t (*set_mode)(struct extint_device * ed, const char *buf,
+			     size_t count);
+
+	/* Get generation mode list */
+	ssize_t (*get_modelist)(struct extint_device * ed, char *buf);
+
+	/* Get/set generation period */
+	unsigned long (*get_period)(struct extint_device * ed);
+	ssize_t (*set_period)(struct extint_device * ed, unsigned long period);
+
+	/* Get low-level provider name */
+	ssize_t (*get_provider)(struct extint_device *ed, char *buf);
+
+	/* Generation period quantum */
+	unsigned long (*get_quantum)(struct extint_device * ed);
+
+	/* Get/set ingest source */
+	ssize_t (*get_source)(struct extint_device * ed, char *buf);
+	ssize_t (*set_source)(struct extint_device * ed, const char *buf,
+			      size_t count);
+
+	/* Get ingest source list */
+	ssize_t (*get_sourcelist)(struct extint_device * ed, char *buf);
+};
+
+struct extint_device {
+	/* Current status of device */
+	int state;
+
+	/* Semaphore protects 'props' field.  If 'props' is NULL, the
+	 * driver that registered this device has been unloaded, and
+	 * if class_get_devdata() points to something in the body of
+	 * that driver, it is also invalid.
+	 */
+	struct semaphore sem;
+	struct extint_properties *props;	/* Downcalls */
+
+	/* A list of callouts to invoke whenever this device ingests
+	 * an interrupt.
+	 */
+	struct list_head callouts;
+	spinlock_t callouts_lock;
+
+	/* Mappable counter page support */
+	struct cdev counter_cdev;		/* Character dev */
+	unsigned long *counter_page;		/* Mappable page */
+	wait_queue_head_t counter_queue;	/* Poll/select queue */
+
+	/* The class device structure */
+	struct class_device class_dev;
+
+	/* Device number of abstracted counter */
+	dev_t devt;
+
+	/* Private device data for device-specific drivers */
+	void* devdata;
+};
+
+static inline void* extint_get_devdata(const struct extint_device *ed) {
+	return ed->devdata;
+}
+
+static inline void extint_set_devdata(struct extint_device *ed, void* devdata) {
+	ed->devdata = devdata;
+}
+
+struct extint_callout {
+	struct list_head list;
+	struct module *owner;		/* Callout function and data owner */
+	void (*function) (void *);	/* Callout to invoke */
+	void *data;			/* Passed to callout */
+};
+
+extern struct extint_device *extint_device_register(struct extint_properties
+						    *ep, void *devdata);
+extern void extint_device_unregister(struct extint_device *ed);
+
+/* Used by other kernel modules to request a function be invoked each
+ * time an interrupt is ingested
+ */
+extern struct extint_device *file_to_extint_device(const struct file *filp);
+extern int extint_callout_register(struct extint_device *ed,
+				   struct extint_callout *ec);
+extern void extint_callout_unregister(struct extint_device *ed,
+				      struct extint_callout *ec);
+
+/* Used by external interrupt low-level drivers to trigger invocation
+ * of per-interrupt actions.
+ */
+extern void extint_interrupt(struct extint_device *ed);
+
+#endif

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
