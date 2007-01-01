Return-Path: <linux-kernel-owner+w=401wt.eu-S932830AbXAAURT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbXAAURT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 15:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbXAAURT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 15:17:19 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:45160 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932822AbXAAURP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 15:17:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=3zFFXKfn/LwvHqa3915sH1wbKfS4qIR2MOl+pp4On47N0YOaNWLKngJiWHaA2RZGvE3iqR10CVlFJo8ZMWHW8ANsRbmmEie3aRFPoRmZJXmNLw70UHBW4RP8dSuiJGwYMX277pVxvQ0EStJMuLT2etu1Jp+RABhx5YCVthRB/oY=  ;
X-YMail-OSG: ZBSQivgVM1m_.5ZElq3DbWuXHxlt7vTYFk3DmlF4LIx8y3n.ows4xuyiThWZYcKXkCeRUOKDnqQw62hDu2COuYbeVvLd33A4viKsC5P3V3oFpuyU199V.dHfSGXpbELoQPsH1rcHKJvJFaA-
From: David Brownell <david-b@pacbell.net>
To: "Kevin O'Connor" <kevin@koconnor.net>
Subject: Re: [patch 2.6.20-rc1 0/6] arch-neutral GPIO calls
Date: Mon, 1 Jan 2007 12:06:19 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20061231191137.GA5290@double.lan>
In-Reply-To: <20061231191137.GA5290@double.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701011206.20132.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 December 2006 11:11 am, Kevin O'Connor wrote:
> > Based on earlier discussion, I'm sending a refresh of the generic GPIO
> > patch, with several (ARM based) implementations in separate patches:
> 
> Hi Dave,
> 
> I'm very interested in seeing an abstraction for gpios.

Good!  I suspect most folk who've had to work on a few different
embedded Linux boards have noticed lots of needlessly-different
GPIO code.  Not many folk are actually seeing that as more than
just ugliness though.


> Unfortunately, I fear the implementation you propose is not robust
> enough to handle the cases I need to handle. 

The _interface_ allows those additional GPIO controllers though.
Specifically of the type you mentioned ... that's why this version
defined new "cansleep" call variants.


> The concern I have with your current implementation is that I don't
> see a way to flexibly add in support for additional gpio pins on a
> machine by machine basis.  The code does do a good job of abstracting
> gpios based on the primary architecture (eg, PXA vs OMAP), but not on
> a chip basis (eg, PXA vs ASIC3).

You used the key word:  implementation.  The interface allows it,
but such board-specific extensions haven't yet been needed; so
they've not yet been implemented.

See the appended for a patch roughly along the lines of what has
previously been discussed here.  No interface change, just updated
implementation code.  And the additional implementation logic won't
kick on boards that don't need it.

Note that the current implementations are a win even without yet
being able to handle the board-specific external GPIO controllers.
The API is clearer than chip-specific register access, and since
it's arch-neutral it already solves integration problems (like
having one SPI controller driver work on both AT91 and AVR).


> > Other than clarifications, the main change in the doc is defining
> > new calls safe for use with GPIOs on things like pcf8574 I2C gpio
> > expanders; those new calls can sleep, but are otherwise the same as
> > the spinlock-safe versions. The implementations above implement that
> > as a wrapper (the asm-generic header) around the spinlock-safe calls.
> 
> As above, I'm confused how these expanders would work in practice.

One approach:  updating implementations along the lines the patch below.
Other implementations could work too.

Note that I see that kind of update as happening after the first round
of patches go upstream:  accept the interface first, then update boards
to support it ... including later the cansleep calls, on some boards.

I like the idea of first replacing the "old" GPIO accesses with ones
using the new APIs ... and only then starting to convert old I2C (etc)
accesses.


> The expanders would be present on a machine by machine basis but the
> code seems to be implemented on an arch by arch basis.  Perhaps an
> example would help me.

An example showing one way to implement that interface ... appended.
The expanders would be board-specific, not arch/.../mach-* specific.
(I try to avoid using the word "machine" there; it's too ambiguous.)

The code below just show how boards could plug in; it doesn't actually
convert any boards to use that infrastructure.  It should be obvious
how to do that, if you've got a board needing it which works with the
kernel.org GIT tree...

- Dave

=================	CUT HERE
Preliminary version of support for board-specific declaring GPIO controllers,
primarily for use with things like I2C access to GPIOs.

  * GPIOs numbered 0..ARCH_GPIO_MAX always use internal arch/SOC specific
    controller access, and are spinlock-safe.

  * All other GPIO numbers are allocated semi-dynamically, as part of
    declaring a GPIO controller, and are assumed spinlock-unsafe.

  * Such external GPIO controllers provide a simple ops vector for
    setting direction, and accessing GPIO values.

Board-specific init code can declare the controllers, then hand out the
GPIOs to code that needs them.

Index: pxa/include/asm-generic/gpio.h
===================================================================
--- pxa.orig/include/asm-generic/gpio.h	2007-01-01 11:20:14.000000000 -0800
+++ pxa/include/asm-generic/gpio.h	2007-01-01 11:34:42.000000000 -0800
@@ -1,7 +1,51 @@
 #ifndef _ASM_GENERIC_GPIO_H
 #define _ASM_GENERIC_GPIO_H
 
-/* platforms that don't directly support access to GPIOs through I2C, SPI,
+#ifdef	CONFIG_GPIOLIB
+
+/* Boards with GPIOs accessed through I2C etc can access them through some
+ * gpio expander library code:
+ *
+ *  - Define ARCH_GPIO_MAX.  All GPIO ids accessed through such expanders
+ *    will be above this number.  Most other GPIOs are SOC-integrated, and
+ *    could be accessed by inlined direct register reads/writes.
+ *
+ *  - Board-specific setup code declares each controller and how many GPIOs
+ *    it handles.  The return value is the first GPIO associated with that
+ *    controller; other GPIOs immediately follow.  These GPIO numbers are
+ *    then handed out to the drivers which need them.
+ *
+ *  - Have the gpio management code (request, free, set direction) delegate
+ *    to gpiolib for GPIOs above ARCH_MAX; and fail gpio_to_irq() for them.
+ */
+struct gpio_ops {
+	int	(*direction_input)(void *, unsigned offset);
+	int	(*direction_output)(void *, unsigned offset);
+	int	(*get_value)(void *, unsigned offset);
+	int	(*set_value)(void *, unsigned offset, int value);
+};
+
+extern int __init gpiolib_define_controller(struct gpio_ops *, void *, int n);
+
+extern int gpiolib_request(unsigned gpio, const char *name);
+extern void gpiolib_free(unsigned gpio);
+extern int gpiolib_direction_input(unsigned gpio);
+extern int gpiolib_direction_output(unsigned gpio);
+
+
+/* for now, assume only arch/soc gpios are spinlock-safe */
+static inline int gpio_cansleep(unsigned gpio)
+{
+	return gpio <= ARCH_GPIO_MAX;
+}
+
+/* these standard gpio calls handle both kinds of GPIO */
+extern int gpio_get_value_cansleep(unsigned gpio);
+extern void gpio_set_value_cansleep(unsigned gpio, int value);
+
+#else
+
+/* boards that don't directly support access to GPIOs through I2C, SPI,
  * or other blocking infrastructure can use these wrappers.
  */
 
@@ -22,4 +66,29 @@ static inline void gpio_set_value_cansle
 	gpio_set_value(gpio, value);
 }
 
+/* having these gpiolib_*() inlines makes it easy to just kick in
+ * the library code for boards that need it
+ */
+
+static inline int gpiolib_request(unsigned gpio, const char *name)
+{
+	return -EINVAL;
+}
+
+static inline void gpiolib_free(unsigned gpio)
+{
+}
+
+static inline int gpiolib_direction_input(unsigned gpio)
+{
+	return -EINVAL;
+}
+
+static inline int gpiolib_direction_output(unsigned gpio)
+{
+	return -EINVAL;
+}
+
+#endif
+
 #endif /* _ASM_GENERIC_GPIO_H */
Index: pxa/lib/Kconfig
===================================================================
--- pxa.orig/lib/Kconfig	2007-01-01 11:20:14.000000000 -0800
+++ pxa/lib/Kconfig	2007-01-01 11:34:42.000000000 -0800
@@ -106,4 +106,10 @@ config IOMAP_COPY
 	depends on !UML
 	default y
 
+#
+# gpiolib support is selected on boards that need it
+#
+config GPIOLIB
+	boolean
+
 endmenu
Index: pxa/lib/Makefile
===================================================================
--- pxa.orig/lib/Makefile	2007-01-01 11:20:14.000000000 -0800
+++ pxa/lib/Makefile	2007-01-01 11:34:42.000000000 -0800
@@ -57,6 +57,7 @@ obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
+obj-$(CONFIG_GPIOLIB) += gpiolib.o
 
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
Index: pxa/lib/gpiolib.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ pxa/lib/gpiolib.c	2007-01-01 11:34:42.000000000 -0800
@@ -0,0 +1,192 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/bitops.h>
+#include <linux/spinlock.h>
+#include <linux/idr.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+
+#include <asm/gpio.h>
+
+
+/* This is a simple library to support GPIO controllers not integrated into
+ * system-on-chip level arch support.  These are reasonably common on embedded
+ * boards, where their hotpluggability is a non-issue.  They are often accessed
+ * through busses like I2C or SPI; getting or setting values for such GPIOs
+ * normally sleeps.  (Not always; ucb1x00 GPIOs are a counterexample.)
+ */
+
+struct gpio {
+	struct gpio_ops	*ops;
+	void		*controller;
+	int		base;
+	unsigned	n;
+	unsigned long	requested[1];
+};
+
+static DEFINE_MUTEX(gpio_lock);
+static struct idr gpio_idr;
+
+static struct gpio *gpionum2gpio(unsigned gpionum)
+{
+	struct gpio	*g;
+
+	mutex_lock(&gpio_lock);
+	g = idr_find(&gpio_idr, gpionum);
+	mutex_unlock(&gpio_lock);
+	return g;
+}
+
+/*-------------------------------------------------------------------------*/
+
+/* some controllers (e.g. simple FPGA logic) have fixed directions */
+
+int gpiolib_direction_input(unsigned gpionum)
+{
+	struct gpio	*g = gpionum2gpio(gpionum);
+
+	if (!g || !g->ops->direction_input)
+		return -EINVAL;
+	return g->ops->direction_input(g->controller, gpionum - g->base);
+}
+EXPORT_SYMBOL_GPL(gpiolib_direction_input);
+
+int gpiolib_direction_output(unsigned gpionum)
+{
+	struct gpio	*g = gpionum2gpio(gpionum);
+
+	if (!g || !g->ops->direction_output)
+		return -EINVAL;
+	return g->ops->direction_output(g->controller, gpionum - g->base);
+}
+EXPORT_SYMBOL_GPL(gpiolib_direction_output);
+
+
+/* Might as well have real implementations of request/free.  Debug versions
+ * might remember name and direction, and dump state in debugfs...
+ */
+
+int gpiolib_request(unsigned gpionum, const char *name)
+{
+	struct gpio	*g = gpionum2gpio(gpionum);
+	unsigned	offset;
+	int		value;
+
+	if (!g)
+		return -EINVAL;
+	offset = gpionum - g->base;
+
+	mutex_lock(&gpio_lock);
+	value = test_and_set_bit(offset, g->requested);
+	mutex_unlock(&gpio_lock);
+	return value ? -EBUSY : 0;
+}
+EXPORT_SYMBOL_GPL(gpiolib_request);
+
+void gpiolib_free(unsigned gpionum)
+{
+	struct gpio	*g = gpionum2gpio(gpionum);
+	unsigned	offset;
+
+	if (!g)
+		return;
+	offset = gpionum - g->base;
+
+	mutex_lock(&gpio_lock);
+	clear_bit(offset, g->requested);
+	mutex_unlock(&gpio_lock);
+}
+EXPORT_SYMBOL_GPL(gpiolib_free);
+
+/*-------------------------------------------------------------------------*/
+
+int gpio_get_value_cansleep(unsigned gpionum)
+{
+	struct gpio	*g;
+
+	might_sleep();
+	if (!gpio_cansleep(gpionum))
+		return gpio_get_value(gpionum);
+	g = gpionum2gpio(gpionum);
+	if (!g || !g->ops->get_value)
+		return 0;
+	return g->ops->get_value(g->controller, gpionum - g->base);
+}
+EXPORT_SYMBOL_GPL(gpio_get_value_cansleep);
+
+void gpio_set_value_cansleep(unsigned gpionum, int value)
+{
+	struct gpio	*g;
+
+	might_sleep();
+	if (!gpio_cansleep(gpionum)) {
+		gpio_set_value(gpionum, value);
+		return;
+	}
+	g = gpionum2gpio(gpionum);
+	if (!g || !g->ops->set_value)
+		return;
+	g->ops->set_value(g->controller, gpionum - g->base, value);
+}
+EXPORT_SYMBOL_GPL(gpio_set_value_cansleep);
+
+/*-------------------------------------------------------------------------*/
+
+/* board-specific arch_initcall() code usually defines external GPIO
+ * controllers available, along with the other board-specific devices.
+ */
+
+int __init
+gpiolib_define_controller(struct gpio_ops *ops, void *controller, int n)
+{
+	struct gpio	*g;
+	int		value;
+	int		gpionum;
+
+	if (n <= 0 || n > BITS_PER_LONG)
+		return -EINVAL;
+
+	idr_pre_get(&gpio_idr, GFP_KERNEL);
+
+	g = kzalloc(sizeof *g, GFP_KERNEL);
+	if (!g)
+		return -ENOMEM;
+
+	g->ops = ops;
+	g->controller = controller;
+	g->n = n;
+
+	mutex_lock(&gpio_lock);
+
+	value = idr_get_new_above(&gpio_idr, g, ARCH_GPIO_MAX + 1, &g->base);
+	if (value < 0)
+		goto fail0;
+	gpionum = g->base;
+	while (n--) {
+		int	gpio;
+
+		gpionum++;
+		value = idr_get_new_above(&gpio_idr, g, gpionum, &gpio);
+		if (value < 0 || gpio != gpionum)
+			goto fail;
+	}
+
+	mutex_unlock(&gpio_lock);
+	return g->base;
+
+fail:
+	n = g->n;
+	while (n--)
+		idr_replace(&gpio_idr, NULL, g->base + n);
+fail0:
+	mutex_unlock(&gpio_lock);
+	kfree(g);
+	return value;
+}
+
+static int __init gpio_cansleep_init(void)
+{
+	idr_init(&gpio_idr);
+	return 0;
+}
+postcore_initcall(gpio_cansleep_init);

Index: pxa/include/asm-arm/arch-pxa/gpio.h
===================================================================
--- pxa.orig/include/asm-arm/arch-pxa/gpio.h	2007-01-01 11:34:30.000000000 -0800
+++ pxa/include/asm-arm/arch-pxa/gpio.h	2007-01-01 11:35:13.000000000 -0800
@@ -30,6 +30,8 @@
 
 #include <asm/arch/pxa-regs.h>
 
+#define	ARCH_GPIO_MAX	PXA_LAST_GPIO
+
 static inline int gpio_get_value(unsigned gpio);
 static inline void gpio_set_value(unsigned gpio, int value);
 
@@ -47,11 +49,15 @@ static inline void gpio_free(unsigned gp
 
 static inline int gpio_direction_input(unsigned gpio)
 {
+	if (gpio_cansleep(gpio))
+		return gpiolib_direction_input(gpio);
 	return pxa_gpio_mode(gpio | GPIO_IN);
 }
 
 static inline int gpio_direction_output(unsigned gpio)
 {
+	if (gpio_cansleep(gpio))
+		return gpiolib_direction_output(gpio);
 	return pxa_gpio_mode(gpio | GPIO_OUT);
 }
 
