Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754907AbWKKXll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbWKKXll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 18:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754908AbWKKXll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 18:41:41 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:40327 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1754906AbWKKXlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 18:41:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=IaKVVvLMO4mnbhOedwCyDfTJ8fPlfmgZqnbc+iW29LkPr5bSCNfpe3mz0e95pm3NmveQLlIQbMBvbbGz+uzbSbPu71xfw1521zeG9hWZAtJzwroeLVIG7M3iQL6zL3rlZMSh5oPrh79qFdLsMHeCzbtk4dWwtVctFkTN+TqTdIY=  ;
X-YMail-OSG: 9uD__rYVM1nPyN47LqPW3.Y2rsPS4IEsbwkdVomsmn2n5uwcs4ytJe5dS5.5OrCSgVlgbE1UZU_iDJLEM.vh1eq_oiLCoWt8gq8EhtubtPvdI_TJU5zB1LSjWJMXEQgGU75edtLQltdMHpN3EetL5tAb9Wu0XSKSpss-
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Sat, 11 Nov 2006 15:41:32 -0800
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611111541.34699.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know there have been discussions about standardizing GPIOs before,
but nothing quite "took".  One of the more recent ones was

  http://marc.theaimsgroup.com/?l=linux-kernel&m=110873454720555&w=2

Below, find what I think is a useful proposal, trivially implementable on
many ARMs (at91, omap, pxa, ep93xx, ixp2000, pnx4008, davinci, more) as well
as the new AVR32.

Compared to the proposal above, key differences include:

  - Only intended for use with "real" GPIOs that work from IRQ context;
    e.g. pins on a SOC that are controlled by chip register access.

  - Doesn't handle I2C or SPI based GPIOs.  I think we actually need
    a different API for those "message based" GPIOs, where synchronous
    get/set requires sleeping (and is thus unusable from IRQ context).
    That API could be used for "real" GPIOs; the converse is not true.

  - No IORESOURCE_GPIO resource type (could be added though).

  - Can be trivially implemented today, on many systems (see partial
    list above) ... no "provider" or gpiochip API necessary.

  - Provided in the form of a working patch, with sample implementation;
    known to be viable on multiple architectures and platforms.

  - Includes Documentation/gpio.txt

Comments?

- Dave


============================	CUT HERE
This defines a simple and minimalist convention for GPIO APIs, and an
implementation of it on one ARM platform (OMAP):

  - Documentation/gpio.txt ... describes things (read it)

  - include/asm-arm/gpio.h ... defines the ARM hook, which just punts
    to <asm/arch/gpio.h> for any implementation

  - include/asm-arm/arch-omap/gpio.h ... representative implementation
    as a wrapper around existing OMAP-specific GPIO calls

The immediate need for such a cross-architecture API convention is to support
drivers that work the same on AT91 ARM and AVR32 AP7000 chips, which embed many
of the same controllers but have different CPUs.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: osk/Documentation/gpio.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ osk/Documentation/gpio.txt	2006-11-11 15:20:58.000000000 -0800
@@ -0,0 +1,233 @@
+GPIO Interfaces
+
+This provides an overview of GPIO access API conventions on Linux.
+
+
+What is a GPIO?
+===============
+A "General Purpose Input/Output" (GPIO) is a flexible software-controlled
+digital signal.  They are provided from many kinds of chip, and are familiar
+to Linux developers working with embedded and custom hardware.  Each GPIO
+represents a bit connected to a particular pin, or "ball" on Ball Grid Array
+(BGA) packages.  Board schematics show which external hardware connects to
+which GPIOs.  Drivers can be written generically, so that board setup code
+passes such pin configuration data to drivers.
+
+System-on-Chip (SOC) processors heavily rely on GPIOs.  In many cases, every
+non-dedicated pin can be configured as a GPIO; and most chips have at least
+several dozen of them.  Programmable logic devices (like FPGAs) can easily
+provide GPIOs, and I2C-connected chips like power managers, audio codecs,
+and "GPIO Expanders" often have a few such pins to help with pin scarcity on
+SOCs.  Most PC southbridges have a few dozen GPIO-capable pins.
+
+The exact capabilities of GPIOs vary between systems.  Common options:
+
+  - Output values are writable (high=1, low=0).  Some chips also have
+    options about how that value is driven, so that for example only one
+    value might be driven ... supporting "wire-OR" and similar schemes
+    for the other value.
+
+  - Input values are likewise readable (1, 0).  Some chips support readback
+    of pins configured as "output", which is very useful in such "wire-OR"
+    cases (to support bidirectional signaling).  GPIO controllers may have
+    input de-glitch logic, sometimes with software controls.
+
+  - Inputs can often be used as IRQ signals, often edge triggered but
+    sometimes level triggered.  Such IRQs may be configurable as system
+    wakeup events, to wake the system from a low power state.
+
+  - Usually a GPIO will be configurable as either input or output, as needed
+    by different product boards; single direction ones exist too.
+
+On a given board each GPIO is used for one specific purpose like monitoring
+MMC/SD card insertion/removal, detecting card writeprotect status, driving
+a LED, configuring a transceiver, and so on.
+
+
+What are the Linux GPIO API conventions?
+========================================
+Note that this is called a "convention" because you don't need to do it this
+way, and it's no crime if you don't.  There **are** cases where portability
+is not the main issue; GPIOs are often used for the kind of board-specific
+glue logic that may even change between board revisions, and can't ever be
+used on a board that's wired differently.  Also, see the notes later on what
+these conventions omit.
+
+That said, if the convention is supported on their platform, drivers should
+probably use it when possible:
+
+	#include <asm/gpio.h>
+	
+If you stick to this convention then it'll be easier for other developers to
+see what your code is doing, and maintain it.
+
+
+Identifying GPIOs
+-----------------
+GPIOs are identified by unsigned integers in the range 0..MAX_INT.  That
+reserves "negative" numbers for other purposes like marking signals as
+"not available on this board", or indicating faults.
+
+A given platform defines how it uses those integers.  So for example one
+might not use "GPIO 0", instead using numbers 32-159.  Another platform
+could use numbers 0..63 with one set of GPIO controllers, 64-79 with a
+different type of GPIO controller, and 80-95 with an FPGA used with one
+particular board family.  GPIO numbers are not the same as IRQ numbers;
+see below for calls mapping between the two namespaces.
+
+A given platform may want to define symbols corresponding to GPIO lines,
+primarily for use in board-specific setup code. Most drivers should use
+GPIO numbers passed to them from that setup code, using platform_data to
+hold board-specific pin configuration data (along with other board
+specific data they need).
+
+
+Using GPIOs
+-----------
+One of the first things to do with a GPIO, often in board setup code when
+setting up a platform_device using the GPIO, is mark its direction:
+
+	/* set as input or output, returning 0 or negative errno */
+	int gpio_direction_input(unsigned gpio);
+	int gpio_direction_output(unsigned gpio);
+
+The return value is zero for success, else a negative errno; it must be
+checked, since the main calls don't have error returns.
+
+Setting the direction can fail if the GPIO number is invalid, or when
+that particular GPIO can't be used in that mode.  It's generally a bad
+idea to rely on boot firmware to have set the direction correctly, since
+it probably wasn't validated to do more than boot Linux.  (Similarly,
+that board setup code probably needs to multiplex that pin as a GPIO,
+and arrange pullups/pulldowns appropriately.)
+
+Driver code will then use this either as an input, or an output.  These
+calls can safely be issued from inside IRQ handlers; they don't sleep.
+
+	/* GPIO INPUT:  return zero or nonzero */
+	int gpio_get_value(unsigned gpio);
+
+	/* GPIO OUTPUT */
+	void gpio_set_value(unsigned gpio, int value);
+
+The get/set calls have no error returns because "invalid GPIO" would have
+been reported earlier in gpio_set_direction().  The values are boolean,
+zero for low, nonzero for high.  When reading the value of an output pin,
+the value returned should be what's seen on the pin ... that won't always
+match the specified output value, because of issues including wire-OR and
+output latencies.
+
+Platform-specific implementations are encouraged to optimise the two
+calls to access the GPIO value in cases where the GPIO number (and for
+output, value) are constant.  It's normal for them to need only a couple
+of instructions in such cases (reading or writing a hardware register),
+and not to need spinlocks.  Such optimized calls can make bitbanging
+applications a lot more efficient (in both space and time) than spending
+dozens of instructions on subroutine calls.
+
+
+Claiming and Releasing GPIOs (OPTIONAL)
+---------------------------------------
+To help catch system configuration errors, two calls are defined.
+However, many platforms don't currently support this mechanism.
+
+	/* request GPIO, returning 0 or negative errno.
+	 * non-null labels may be useful for diagnostics.
+	 */
+	int gpio_request(unsigned gpio, const char *label);
+
+	/* release previously-claimed GPIO */
+	void gpio_free(unsigned gpio);
+
+Passing invalid GPIO numbers to gpio_request() will fail, as will requesting
+GPIOs that have already been claimed with that call.  The return value of
+gpio_request() must be checked.
+
+These APIs serve two basic purposes.  One is marking the signals which
+are actually in use as GPIOs, for better diagnostics; systems may have
+several hundred potential GPIOs, but often only a dozen are used on any
+given board.  Another is to catch confusion between drivers, reporting
+errors when drivers wrongly think they have exclusive use of that signal.
+
+These two calls are optional because not not all current Linux platforms
+offer such functionality in their GPIO support; a valid implementation
+could return success for all gpio_request() calls.  Unlike the other calls,
+the state they represent doesn't normally match anything from a hardware
+register; it's just a software bitmap which clearly is not necessary for
+correct operation of hardware or (bug free) drivers.
+
+Note that requesting a GPIO does NOT cause it to be configured in any
+way; it just marks that GPIO as in use.  Separate code must handle any
+pin setup (e.g. controlling which pin the GPIO uses, pullup/pulldown).
+
+
+Identifying GPIO IRQs
+---------------------
+GPIO numbers are unsigned integers; so are IRQ numbers.  These make up
+two logically distinct namespaces (GPIO 0 need not use IRQ 0).  You can
+map between them using calls like:
+
+	/* map GPIO numbers to IRQ numbers */
+	int gpio_to_irq(unsigned gpio);
+
+	/* map IRQ numbers to GPIO numbers */
+	int irq_to_gpio(unsigned irq);
+
+Those return either the corresponding number in the other namespace, or
+else a negative errno code if the mapping can't be done.  (For example,
+some GPIOs can't used as IRQs.)  It is an unchecked error to use a GPIO
+number that hasn't been marked as an input using gpio_set_direction(), or
+to use an IRQ number that didn't originally come from gpio_to_irq().
+
+These two mapping calls are expected to cost on the order of a single
+addition or subtraction.
+
+Non-error values returned from gpio_to_irq() can be passed to request_irq()
+or free_irq().  They will often be stored into IRQ resources for platform
+devices, by the board-specific initialization code.  Note that IRQ trigger
+options are part of the IRQ API, e.g. IRQF_TRIGGER_FALLING, as are system
+wakeup capabilities.
+
+Non-error values returned from irq_to_gpio() would most commonly be used
+with gpio_get_value().
+
+
+
+What do these conventions omit?
+===============================
+These conventions address least-common-denominator functionality, and
+nonportable features are left as platform-specific (but also accessible
+through <asm/gpio.h> inclusion).  Some of these may also be configuration
+dependent; the hardware may support reading or writing GPIOs in gangs,
+but only for GPIOs sharing the same bank.  (GPIOs are commonly grouped
+in banks of 16 or 32, with a given SOC having several such banks.)
+
+One of the biggest things these conventions omit is pin multiplexing, since
+this is highly chip-specific and nonportable.  One platform might not need
+explicit multiplexing; another might have just two options for use of any
+given pin; another might have eight options per pin; another might be able
+to switch a given GPIO to any of several pins.  (Yes, those examples all
+come from systems that run Linux today.)
+
+Related to multiplexing is configuration and enabling of the pullups or
+pulldowns integrated on some platforms.  Not all platforms support them,
+or support them in the same way; and any given board may use external
+pullups (or pulldowns) so that the on-chip ones should not be used.
+
+There are other system-specific mechanisms that are not specified here,
+like the aforementioned options for input de-glitching and wire-OR output,
+or ganged I/O.  Code relying on them will by definition be nonportable.
+
+GPIOs accessed through serial bus chips, like I2C GPIO expanders, are not
+supported here.  The main issue with these calls is that reading or writing
+such GPIO values can't be done from IRQ handlers.  Reading from an I2C chip
+involves sleeping to get to the head of a message queue (other chips on the
+bus may be using the controller already) and then get the response data;
+writing similarly involves sleeping.  A secondary issue is how to address
+GPIOs on those chips; globally assigned unsigned integers are not good
+choices, better ones would look like "GPIO 7 on that chip".  Managing the
+IRQs issued by such GPIOs is similarly troublesome.
+
+This API is purely for kernel space, but a userspace API could be built on
+top of it.
+
Index: osk/include/asm-arm/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ osk/include/asm-arm/gpio.h	2006-11-11 14:52:18.000000000 -0800
@@ -0,0 +1,7 @@
+#ifndef _ARCH_ARM_GPIO_H
+#define _ARCH_ARM_GPIO_H
+
+/* not all ARM platforms necessarily support this API ... */
+#include <asm/arch/gpio.h>
+
+#endif /* _ARCH_ARM_GPIO_H */
Index: osk/include/asm-arm/arch-omap/gpio.h
===================================================================
--- osk.orig/include/asm-arm/arch-omap/gpio.h	2006-11-11 14:52:16.000000000 -0800
+++ osk/include/asm-arm/arch-omap/gpio.h	2006-11-11 14:52:18.000000000 -0800
@@ -76,4 +76,58 @@ extern void omap_set_gpio_direction(int 
 extern void omap_set_gpio_dataout(int gpio, int enable);
 extern int omap_get_gpio_datain(int gpio);
 
+/*-------------------------------------------------------------------------*/
+
+/* wrappers for "new style" GPIO calls. the old OMAP-specfic ones should
+ * eventually be removed (along with this errno.h inclusion), and maybe
+ * gpios should put MPUIOs last too.
+ */
+
+#include <asm/errno.h>
+
+static inline int __must_check gpio_request(unsigned gpio, const char *label)
+	{ return omap_request_gpio(gpio); }
+
+static inline void gpio_free(unsigned gpio)
+	{ omap_free_gpio(gpio); }
+
+
+static inline int __must_check
+__gpio_set_direction(unsigned gpio, int is_input)
+{
+	if (cpu_class_is_omap2()) {
+		if (gpio > OMAP_MAX_GPIO_LINES)
+			return -EINVAL;
+	} else {
+		if (gpio > (OMAP_MAX_GPIO_LINES + 16 /* MPUIO */))
+			return -EINVAL;
+	}
+	omap_set_gpio_direction(gpio, is_input);
+	return 0;
+}
+
+static inline int gpio_direction_input(unsigned gpio)
+	{ return __gpio_set_direction(gpio, 1); }
+
+static inline int gpio_direction_output(unsigned gpio)
+	{ return __gpio_set_direction(gpio, 0); }
+
+
+static inline int gpio_get_value(unsigned gpio)
+	{ return omap_get_gpio_datain(gpio); }
+
+static inline void gpio_set_value(unsigned gpio, int value)
+	{ omap_set_gpio_dataout(gpio, value); }
+
+
+static inline int gpio_to_irq(unsigned gpio)
+	{ return OMAP_GPIO_IRQ(gpio); }
+
+static inline int irq_to_gpio(unsigned irq)
+{
+	if (cpu_class_is_omap1() && (irq < (IH_MPUIO_BASE + 16)))
+		return (irq - IH_MPUIO_BASE) + OMAP_MAX_GPIO_LINES;
+	return irq - IH_GPIO_BASE;
+}
+
 #endif
