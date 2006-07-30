Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWG3NIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWG3NIR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 09:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWG3NIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 09:08:17 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:35210 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S932314AbWG3NIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 09:08:16 -0400
Date: Sun, 30 Jul 2006 15:08:11 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Chris Boot <bootc@bootc.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
Message-ID: <20060730130811.GI10495@pengutronix.de>
References: <44CA7738.4050102@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <44CA7738.4050102@bootc.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

On Fri, Jul 28, 2006 at 09:44:40PM +0100, Chris Boot wrote:
> I propose to develop a common way of registering and accessing GPIO pins on 
> various devices.

I've attached the gpio framework we have developed a while ago; it is
not ready for upstream, only tested on pxa and has probably several
other drawbacks, but may be a start for your activities. One of the
problems we've recently seen is that for example on PowerPCs you don't
have such a clear "this is gpio pin x" nomenclature, so the question
would be how to do the mapping here.

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

Subject: gpio: GPIO framework
From: Robert Schwebel <r.schwebel@pengutronix.de>

This patch adds a generic GPIO framework. It is not ready for upstream
yet, only tested on ARM/PXA.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Index: arch/arm/mach-pxa/Makefile
===================================================================
--- arch/arm/mach-pxa/Makefile.orig
+++ arch/arm/mach-pxa/Makefile
@@ -35,3 +35,5 @@ obj-$(CONFIG_PXA_SSP) += ssp.o
 ifeq ($(CONFIG_PXA27x),y)
 obj-$(CONFIG_PM) += standby.o
 endif
+
+obj-$(CONFIG_GPIO)	+=	pxa27x_gpio.o
Index: arch/arm/mach-pxa/Kconfig
===================================================================
--- arch/arm/mach-pxa/Kconfig.orig
+++ arch/arm/mach-pxa/Kconfig
@@ -74,6 +74,64 @@ endchoice
 
 endif
 
+config GPIO
+	bool "GPIO pin support for PXA27x"
+	default y if ARM || PPC
+	default n
+	help
+	  Enabling this option adds support for PXA GPIO pins. Most
+	  System-on-Chip processors have this kind of pins mostly shared
+	  with some kind of internal hardware. Remaining pins may be used
+	  for any purposes (input/output/interrupt etc). To do so, enable
+	  this feature and provide some kernel parameters to define what
+	  pins are available. To define one or more GPIO pin give a:
+	  gpio.mapping=<pin#>:(in|(out:(hi|lo)))[.<pin#>:(in|(out:(hi|lo)))]
+	  Where <pin#> is any GPIO pin number your SoC supports, out or in
+	  is the data direction and hi or lo is one of the possible
+	  levels an output pin can have.
+	  For example. You have three GPIO: pin 8, 63 and 113. Pin 8 is a
+	  simple key input, pin 63 an output to control a motor. It needs
+	  a high level first to stop the motor while booting. Pin 113 is
+	  also an output pin, but needs low level while booting. To do so,
+	  give this kernel parameter:
+	   gpio.mapping=8:in.63:out:hi.113:out:lo
+	  With "cat /proc/gpio" you will get:
+	    GPIO   POLICY       DIRECTION    OWNER
+	      8:  user space      input      kernel
+	     63:  user space      output     kernel
+	    113:  user space      output     kernel
+	  To set pin 63 to low (to start the motor) do a:
+	   $ echo 0 > /sys/class/gpio/gpio63/level
+	  Or to stop the motor again:
+	   $ echo 1 > /sys/class/gpio/gpio63/level
+	  To get the level of the key (pin 8) do:
+	   $ cat /sys/class/gpio/gpio8/level
+	  The result will be 1 or 0.
+
+	  To add new GPIO pins at runtime (lets say pin 88 should be an input)
+	  you can do a:
+	   $ echo 88:in > /sys/class/gpio/map_gpio
+	  The same with a new GPIO pin 95, it should be an output and at high level:
+	   $ echo 95:out:hi > /sys/class/gpio/map_gpio
+
+	  After that "cat /proc/gpio" will show you:
+	    GPIO   POLICY       DIRECTION    OWNER
+	      8:  user space      input      kernel
+	     63:  user space      output     kernel
+	    113:  user space      output     kernel
+	     88:  user space      input      kernel
+	     95:  user space      output     kernel
+
+	  Note: You can add more than one new GPIO pin in one step. The period is the
+	  delimiter between each pin definition. To add the pins 88 and 95 in the
+	  example above in one step do a:
+	   $ echo 88:in.95:out:hi > /sys/class/gpio/map_gpio
+
+	  To remove any of these GPIOs use (in this example GPIO pin 95):
+	   $ echo 95 > /sys/class/gpio/unmap_gpio
+
+	  If unsure, say N.
+
 endmenu
 
 config MACH_POODLE
Index: arch/arm/mach-pxa/pxa27x_gpio.c
===================================================================
--- /dev/null
+++ arch/arm/mach-pxa/pxa27x_gpio.c
@@ -0,0 +1,605 @@
+/*
+ * linux/kernel/gpio.c
+ *
+ * (C) 2004 Robert Schwebel, Pengutronix
+ *
+ * modified by Benedikt Spranger, Pengutronix
+ * modified by Marc Kleine-Budde <mkl@pengutronix.de>, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/sysdev.h>
+#include <linux/timer.h>
+#include <linux/proc_fs.h>
+#include <linux/gpio.h>
+#include <linux/parser.h>
+
+#define DRIVER_NAME "gpio"
+
+static char __initdata mapping[255] = "";
+
+MODULE_AUTHOR("John Lenz, Robert Schwebel");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Generic GPIO Infrastructure");
+module_param_string(mapping, mapping, sizeof(mapping), 0);
+MODULE_PARM_DESC(mapping,
+"period delimited options string to map GPIO pins to userland:\n"
+"\n"
+"	<pin>:[out|in][hi|lo]\n"
+"\n"
+"	example: gpio.mapping=5:out:hi.8:in\n"
+);
+
+static ssize_t gpio_show_level(struct class_device *dev, char *buf);
+static ssize_t gpio_store_level(struct class_device *dev, const char *buf, size_t size);
+static ssize_t gpio_show_policy(struct class_device *dev, char *buf);
+
+struct gpio_properties {
+	unsigned int       pin_nr;
+	unsigned char      policy;	/* GPIO_xxx */
+	char               pin_level;	/* -1=tristate, 0, 1 */
+	char               owner[20];
+	struct gpio_device *gpio_dev;
+};
+
+struct gpio_device {
+	spinlock_t lock; 		/* protects the props field */
+	struct gpio_properties props;
+	struct class_device class_dev;
+	struct list_head list;
+};
+#define to_gpio_device(d) container_of(d, struct gpio_device, class_dev)
+
+static LIST_HEAD(gpio_list);
+static rwlock_t gpio_list_lock = RW_LOCK_UNLOCKED;
+
+/* gpio_device is static, so we don't have to free it here */
+static void gpio_class_release(struct class_device *dev)
+{
+	return;
+}
+
+static struct class gpio_class = {
+	.name		= "gpio",
+	.release	= gpio_class_release,
+};
+
+
+/*
+ * Attribute: /sys/class/gpio/gpioX/level
+ */
+static struct class_device_attribute attr_gpio_level = {
+	.attr = { .name = "level", .mode = 0644, .owner = THIS_MODULE },
+	.show = gpio_show_level,
+	.store = gpio_store_level,
+};
+
+/**
+ * gpio_show_level - shows the current level of an input GPIO pin
+ *                   or the current setting of an output pin
+ * @dev:
+ * @buf:
+ *
+ * Called when a read from /sys/class/gpio/gpioX/level occures
+ * FIXME: size of @buf?
+ */
+static ssize_t gpio_show_level(struct class_device *dev, char *buf)
+{
+	struct gpio_device *gpio_dev = to_gpio_device(dev);
+	ssize_t ret_size = 0;
+
+	spin_lock(&gpio_dev->lock);
+	if (!(gpio_dev->props.policy & GPIO_OUTPUT))
+		gpio_dev->props.pin_level = gpio_get_pin(gpio_dev->props.pin_nr);
+
+	ret_size += sprintf(buf, "%i\n", gpio_dev->props.pin_level);
+	spin_unlock(&gpio_dev->lock);
+
+	return ret_size;
+}
+
+/**
+ * gpio_store_level - sets a new level for an output GPIO pin
+ * @dev:
+ * @buf:
+ * @size:
+ *
+ * Called when a write to /sys/class/gpio/gpioX/level occures
+ */
+static ssize_t gpio_store_level(struct class_device *dev, const char *buf, size_t size)
+{
+	struct gpio_device *gpio_dev = to_gpio_device(dev);
+	long value;
+
+	spin_lock(&gpio_dev->lock);
+	if (!(gpio_dev->props.policy & GPIO_OUTPUT)) {
+		spin_unlock(&gpio_dev->lock);
+		return -EINVAL;
+	}
+
+	value = simple_strtol(buf, NULL, 10);
+
+	if (value)
+		value = 1;
+	gpio_dev->props.pin_level = value;
+
+	/* set real hardware */
+	switch (value) {
+		case 0:  gpio_clear_pin(gpio_dev->props.pin_nr);
+			 gpio_dir_output(gpio_dev->props.pin_nr);
+			 break;
+		case 1:  gpio_set_pin(gpio_dev->props.pin_nr);
+			 gpio_dir_output(gpio_dev->props.pin_nr);
+			 break;
+		default: break;
+	}
+	spin_unlock(&gpio_dev->lock);
+	return size;
+}
+
+/*
+ * Attribute: /sys/class/gpio/gpioX/policy
+ */
+static struct class_device_attribute attr_gpio_policy = {
+	.attr = { .name = "policy", .mode = 0444, .owner = THIS_MODULE },
+	.show = gpio_show_policy,
+	.store = NULL,
+};
+
+/**
+ * gpio_show_policy - shows the current policy
+ * @dev:
+ * @buf: to write the answer in
+ *
+ * Called when a read from /sys/class/gpio/gpioX/policy occures
+ * FIXME: size of @buf?
+ */
+static ssize_t gpio_show_policy(struct class_device *dev, char *buf)
+{
+	struct gpio_device *gpio_dev = to_gpio_device(dev);
+	ssize_t ret_size = 0;
+
+	spin_lock(&gpio_dev->lock);
+	if (gpio_dev->props.policy & GPIO_USER)
+		ret_size += sprintf(buf,"userspace\n");
+	else
+		ret_size += sprintf(buf,"kernel\n");
+	spin_unlock(&gpio_dev->lock);
+
+	return ret_size;
+}
+
+/**
+ * gpio_read_proc - gets called when you read from /proc/gpio ;-)
+ * @page:
+ * @start:
+ * @off:
+ * @count:
+ * @eof:
+ * @data:
+ */
+static int gpio_read_proc(char *page, char **start, off_t off,
+			  int count, int *eof, void *data)
+{
+	char *p = page;
+	int size = 0;
+	struct gpio_device *gpio_dev;
+	struct list_head *lact, *ltmp;
+
+	if (off != 0)
+		goto end;
+
+	p += sprintf(p, "GPIO   POLICY       DIRECTION    OWNER\n");
+	read_lock(&gpio_list_lock);
+	list_for_each_safe(lact, ltmp, &gpio_list) {
+		gpio_dev = list_entry(lact, struct gpio_device, list);
+		spin_lock(&gpio_dev->lock);
+		p += sprintf(p, "%3i:   ", gpio_dev->props.pin_nr);
+
+		if (gpio_dev->props.policy & GPIO_USER)
+			p += sprintf(p, "user space   ");
+		else
+			p += sprintf(p, "kernel       ");
+
+		if (gpio_dev->props.policy & GPIO_OUTPUT)
+			p += sprintf(p, "output       ");
+		else
+			p += sprintf(p, "input        ");
+
+		p += sprintf(p, "%s\n", gpio_dev->props.owner);
+		spin_unlock(&gpio_dev->lock);
+	}
+	read_unlock(&gpio_list_lock);
+end:
+	size = (p - page);
+	if (size <= off + count)
+		*eof = 1;
+	*start = page + off;
+	size -= off;
+	if (size > count)
+		size = count;
+	if (size < 0)
+		size = 0;
+
+	return size;
+}
+
+/**
+ * request_gpio - register a new object of gpio_device class.
+ *
+ * @pin_nr:     GPIO pin which is registered
+ * @owner:      name of the driver that owns this pin
+ * @policy:     set policy for this pin, which is one of these:
+ * 		- GPIO_USER or GPIO_KERNEL
+ * 		- GPIO_INPUT or GPIO_OUTPUT
+ * 		For user space registered pins a sysfs entry is added.
+ * @init_level: initially configured pin level
+ */
+int request_gpio(unsigned int pin_nr, const char *owner,
+		 unsigned char policy, unsigned char init_level)
+{
+	int rc;
+	struct gpio_device *gpio_dev;
+	struct list_head *lact, *ltmp;
+
+	write_lock(&gpio_list_lock);
+	list_for_each_safe(lact, ltmp, &gpio_list) {
+		gpio_dev = list_entry(lact, struct gpio_device, list);
+		if (pin_nr == gpio_dev->props.pin_nr) {
+			printk(KERN_ERR "gpio pin %i is already used by %s\n",
+				pin_nr, gpio_dev->props.owner);
+			write_unlock(&gpio_list_lock);
+			return -EBUSY;
+		}
+	}
+
+	gpio_dev = kmalloc(sizeof(struct gpio_device), GFP_KERNEL);
+
+	if (unlikely(!gpio_dev)) {
+		printk(KERN_ERR "%s: couldn't allocate memory\n", DRIVER_NAME);
+		write_unlock(&gpio_list_lock);
+		return -ENOMEM;
+	}
+
+	gpio_dev->props.pin_nr = pin_nr;
+	INIT_LIST_HEAD(&gpio_dev->list);
+	list_add_tail(&gpio_dev->list, &gpio_list);
+	write_unlock(&gpio_list_lock);
+
+	spin_lock_init(&gpio_dev->lock);
+	gpio_dev->props.policy = policy;
+	gpio_dev->props.pin_level = init_level;
+	gpio_dev->props.gpio_dev = gpio_dev;
+
+	strncpy(gpio_dev->props.owner, owner, 20);
+
+	memset(&gpio_dev->class_dev, 0, sizeof(gpio_dev->class_dev));
+	gpio_dev->class_dev.class = &gpio_class;
+	snprintf(gpio_dev->class_dev.class_id, BUS_ID_SIZE, "gpio%i", pin_nr);
+
+	rc = class_device_register(&gpio_dev->class_dev);
+	if (unlikely(rc)) {
+		printk(KERN_ERR "%s: class registering failed\n", DRIVER_NAME);
+		kfree(gpio_dev);
+		return rc;
+	}
+
+	/* register the attributes */
+	if (policy & GPIO_USER)
+		class_device_create_file(&gpio_dev->class_dev,&attr_gpio_level);
+
+	class_device_create_file(&gpio_dev->class_dev, &attr_gpio_policy);
+
+	/* set real hardware */
+	spin_lock(&gpio_dev->lock);
+	pxa_gpio_mode(pin_nr);
+	if (policy & GPIO_OUTPUT) {
+		switch (init_level) {
+			case 0: gpio_clear_pin(pin_nr); break;
+			case 1: gpio_set_pin(pin_nr); break;
+			default: break;
+		}
+		gpio_dir_output(pin_nr);
+	}
+	spin_unlock(&gpio_dev->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(request_gpio);
+
+
+/**
+ * free_gpio - unregisters an object of gpio_properties class.
+ *
+ * @pin_nr: pin number to free.
+ *
+ * Unregisters a previously registered via request_gpio object.
+ */
+void free_gpio(unsigned int pin_nr)
+{
+	struct gpio_device *gpio_dev;
+	struct list_head *lact, *ltmp;
+
+	write_lock(&gpio_list_lock);
+	list_for_each_safe(lact, ltmp, &gpio_list) {
+		gpio_dev = list_entry(lact, struct gpio_device, list);
+		if (pin_nr == gpio_dev->props.pin_nr) {
+			printk(KERN_INFO "unregistering gpio pin %i\n", pin_nr);
+			/* unregister attributes */
+			if (gpio_dev->props.policy & GPIO_USER)
+				class_device_remove_file(&gpio_dev->class_dev,&attr_gpio_level);
+			list_del(&gpio_dev->list);
+			write_unlock(&gpio_list_lock);
+			class_device_unregister(&gpio_dev->class_dev);
+			kfree(gpio_dev);
+			return;
+		}
+	}
+	write_unlock(&gpio_list_lock);
+	return;
+}
+EXPORT_SYMBOL(free_gpio);
+
+
+static struct sysdev_class gpio_sysclass = {
+	set_kset_name("gpio"),
+};
+
+static struct sys_device gpio_sys_device = {
+	.id		= 0,
+	.cls		= &gpio_sysclass,
+};
+
+
+enum {
+	Opt_in,
+	Opt_out_high,
+	Opt_out_low,
+	Opt_err,
+};
+
+
+static match_table_t tokens =
+{
+	{Opt_in, "%u:in"},
+	{Opt_out_high,"%u:out:hi"},
+	{Opt_out_low,"%u:out:lo"},
+	{Opt_err, NULL}
+};
+
+
+/**
+ * gpio_setup - parses string and registers GPIOs
+ * @s: string to parse
+ *
+ * Parses a string with the form
+ * <number>:(in|(out:(hi|lo)))[.<number>:(in|(out:(hi|lo)))]
+ * So it works with:
+ * - "86:in"
+ * - "86:in.119:in"
+ * - "86:in.119:in.121:out:hi"
+ *
+ * Returns 0 on success, -EINVAL if it cant parse the string or
+ * -EIO if the pin can't be registered
+ */
+static int gpio_setup(char *s)
+{
+	char *pin_nr_str;
+	int pin_nr;
+	unsigned char policy;
+	unsigned char init_level;
+	substring_t args[MAX_OPT_ARGS];
+	int token;
+	char *next_string;
+
+	next_string=s;
+
+	while (1) {
+		/*
+		 * find one part in this string
+		 */
+		while((*next_string != '\0') && (*next_string != '.'))
+			next_string++;
+
+		if (*next_string == '.') {	/* end or one more? */
+			*next_string = '\0';
+			next_string++;	/* ... one more */
+		}
+		policy = GPIO_USER;	/* reset */
+		init_level = 0;
+		/*
+		 * test this part
+		 */
+		token = match_token(s, tokens, args);
+		switch(token) {
+		/*
+		* global fallthrough
+		*/
+		case Opt_out_high:
+			init_level = 1;
+		case Opt_out_low:
+			policy |= GPIO_OUTPUT;
+		case Opt_in:
+			pin_nr_str = args[0].from;
+			pin_nr = simple_strtoull(pin_nr_str, &pin_nr_str, 0);
+			break;
+		default:
+			printk(KERN_ERR "%s: Unrecognized option \"%s\"\n", DRIVER_NAME, s);
+			return -EINVAL;
+		}
+		/*
+		 * register this part
+		 */
+		if (request_gpio(pin_nr, "kernel", policy, init_level) != 0) {
+			printk(KERN_ERR "%s: could not register GPIO pins!\n",DRIVER_NAME);
+			return -EIO;
+		}
+
+		if (*next_string == '\0')	/* end or one more? */
+			break;
+		else
+			s=next_string;	/* ... one more */
+	}
+
+	return(0);
+}
+
+
+/**
+ * gpio_map_store - map a GPIO pin to userspace
+ * @class:
+ * @buf: recieved string
+ * @count: size of string
+ *
+ * called by sysfs framework on behalf of the user, to map gpio pin to userspace
+ * This could be done for pin 3 (an output with high level) with:
+ * $ echo 3:out:hi > /sys/class/gpio/map_gpio
+ *
+ */
+static ssize_t gpio_map_store(struct class *class, const char *buf, size_t count)
+{
+	int ret;
+	char *tmp;
+
+	/* fist '\n' at the end of the buffer? */
+	if (((char *)memchr(buf, '\n', count) - buf + 1) != count)
+		return -EINVAL;
+
+	tmp = (char *)kmalloc(count, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	/* override the '\n' with end-of-string '\0' */
+	strncpy(tmp, buf, count);
+	*(tmp + count - 1) = '\0';
+
+	ret = gpio_setup(tmp);
+
+	kfree(tmp);
+
+	return ret ? ret : count;
+}
+
+
+/**
+ * gpio_unmap_store - unmap a GPIO pin
+ * @class:
+ * @buf: recieved string
+ * @count: size of string
+ *
+ * called by sysfs framework on behalf of the user, to unmap gpio pin from userspace
+ */
+static ssize_t gpio_unmap_store(struct class *class, const char *buf, size_t count)
+{
+	struct gpio_device *gpio_dev;
+	struct list_head *lact, *ltmp;
+	char *end;
+	int pin_nr;
+
+	pin_nr = (int)simple_strtol(buf, &end, 10);
+
+	/* stuff after pin-number */
+	if ((end - buf + 1) != count)
+		return -EINVAL;
+
+	write_lock(&gpio_list_lock);
+	list_for_each_safe(lact, ltmp, &gpio_list) {
+		gpio_dev = list_entry(lact, struct gpio_device, list);
+		if (pin_nr == gpio_dev->props.pin_nr) {
+			printk(KERN_INFO "unregistering gpio pin %i\n", pin_nr);
+			/* unregister attributes */
+			if (! (gpio_dev->props.policy & GPIO_USER))
+				return -EACCES;
+			class_device_remove_file(&gpio_dev->class_dev,&attr_gpio_level);
+			list_del(&gpio_dev->list);
+			write_unlock(&gpio_list_lock);
+			class_device_unregister(&gpio_dev->class_dev);
+			kfree(gpio_dev);
+			return count;
+		}
+	}
+	write_unlock(&gpio_list_lock);
+
+	printk(KERN_ERR "could not unregister gpio pin %i\n", pin_nr);
+	return -ENXIO;
+}
+
+static CLASS_ATTR(map_gpio,     0200,   NULL,   gpio_map_store);
+static CLASS_ATTR(unmap_gpio,   0200,   NULL,   gpio_unmap_store);
+
+
+static int __init gpio_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "Initialising gpio device class.\n");
+
+	ret = class_register(&gpio_class);
+	if (ret) {
+		printk(KERN_ERR "%s: couldn't register class, exiting\n", DRIVER_NAME);
+		goto out_class;
+	}
+
+	ret = sysdev_class_register(&gpio_sysclass);
+	if (ret) {
+		printk(KERN_ERR "%s: couldn't register sysdev class, exiting\n", DRIVER_NAME);
+		goto out_sysdev_class;
+	}
+
+	ret = sysdev_register(&gpio_sys_device);
+	if (ret) {
+		printk(KERN_ERR "%s: couldn't register sysdev, exiting\n", DRIVER_NAME);
+		goto out_sysdev_register;
+	}
+
+	ret = class_create_file(&gpio_class, &class_attr_map_gpio);
+	if (ret) {
+		printk(KERN_ERR "%s: couldn't register class attribute, exiting\n", DRIVER_NAME);
+		goto out_class_create_file_map_gpio;
+	}
+
+	ret = class_create_file(&gpio_class, &class_attr_unmap_gpio);
+	if (ret) {
+		printk(KERN_ERR "%s: couldn't register class attribute, exiting\n", DRIVER_NAME);
+		goto out_class_create_file_unmap_gpio;
+	}
+
+	if (!create_proc_read_entry ("gpio", 0, NULL, gpio_read_proc, NULL)) {
+		printk(KERN_ERR "%s: couldn't register proc entry, exiting\n", DRIVER_NAME);
+		ret = -1;
+		goto out_proc;
+	}
+	/*
+	 * If the user has given some kernel params,
+	 * parse them and setup the GPIOs
+	 */
+	ret=gpio_setup(mapping);
+
+	return ret;
+
+out_proc:
+	class_remove_file(&gpio_class, &class_attr_unmap_gpio);
+out_class_create_file_unmap_gpio:
+	class_remove_file(&gpio_class, &class_attr_map_gpio);
+out_class_create_file_map_gpio:
+	sysdev_unregister(&gpio_sys_device);
+out_sysdev_register:
+	sysdev_class_unregister(&gpio_sysclass);
+out_sysdev_class:
+	class_unregister(&gpio_class);
+out_class:
+	return ret;
+}
+
+module_init(gpio_init);
Index: include/linux/gpio.h
===================================================================
--- /dev/null
+++ include/linux/gpio.h
@@ -0,0 +1,25 @@
+/*
+ * include/linux/gpio.h
+ *
+ * Copyright (C) 2004 Robert Schwebel, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __GPIO_H
+#define __GPIO_H
+
+#include "asm/arch/gpio.h"
+
+/* Values for policy */
+#define GPIO_USER       (1<<0)
+#define GPIO_OUTPUT     (1<<1)
+
+int request_gpio(unsigned int pin_nr, const char *owner,
+		 unsigned char policy, unsigned char init_level);
+
+void free_gpio(unsigned int pin_nr);
+
+#endif
Index: include/asm-arm/arch-pxa/gpio.h
===================================================================
--- /dev/null
+++ include/asm-arm/arch-pxa/gpio.h
@@ -0,0 +1,47 @@
+/*
+ * linux/include/asm-arm/arch-pxa/gpio.h
+ *
+ * Copyright (C) 2004 Robert Schwebel, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARM_PXA_GPIO_H
+#define __ARM_PXA_GPIO_H
+
+#include <linux/kernel.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/pxa-regs.h>
+
+static inline void gpio_set_pin(int gpio_nr)
+{
+	GPSR(gpio_nr) |= GPIO_bit(gpio_nr);
+	return;
+}
+
+static inline void gpio_clear_pin(int gpio_nr)
+{
+	GPCR(gpio_nr) |= GPIO_bit(gpio_nr);
+	return;
+}
+
+static inline void gpio_dir_input(int gpio_nr)
+{
+	GPDR(gpio_nr) &= ~GPIO_bit(gpio_nr);
+	return;
+}
+
+static inline void gpio_dir_output(int gpio_nr)
+{
+	GPDR(gpio_nr) |= GPIO_bit(gpio_nr);
+	return;
+}
+
+static inline int gpio_get_pin(int gpio_nr)
+{
+	return GPLR(gpio_nr) & GPIO_bit(gpio_nr) ? 1:0;
+}
+
+#endif
