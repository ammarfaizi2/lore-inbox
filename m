Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269311AbUICHe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269311AbUICHe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUICHe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:34:58 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:11466 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S269311AbUICHbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:31:05 -0400
Date: Fri, 3 Sep 2004 15:31:52 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Robert Schwebel <robert@schwebel.de>
Cc: John Lenz <lenz@cs.wisc.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Message-ID: <20040903133152.GH1369@pengutronix.de>
References: <1094157190l.4235l.2l@hydra> <20040903131715.GG1369@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040903131715.GG1369@pengutronix.de>
User-Agent: Mutt/1.4i
X-Scan-Signature: 7b888034cad6ab7fad7e146cfd05f4a7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 03, 2004 at 03:17:15PM +0200, Robert Schwebel wrote:
> I'll pull the gpio patch out of my working tree and post it here for
> discussion. 

Attached. Parts of it have been taken from your LEDs patch anyway, so it
should be not too difficult to reunify them. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4

--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="gpio.diff"

Index: kernel/gpio.c
===================================================================
--- a/kernel/gpio.c	(revision 0)
+++ b/kernel/gpio.c	(revision 205)
@@ -0,0 +1,459 @@
+/*
+ * linux/kernel/gpio.c
+ *
+ * (C) 2004 Robert Schwebel, Pengutronix
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
+
+#define DRIVER_NAME "gpio"
+
+static char mapping[255] = "";
+
+MODULE_AUTHOR("John Lenz, Robert Schwebel");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Generic GPIO Infrastructure");
+module_param_string(mapping, mapping, sizeof(mapping), 0);
+MODULE_PARM_DESC(mapping,
+"period delimited options string to map GPIO pins to userland:\n"
+"\n"
+"	<pin>:[out|in][hi|lo]\n"
+"\n"
+"	example: mapping=5:out:hi.8:in\n"	
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
+static ssize_t gpio_show_level(struct class_device *dev, char *buf)
+{
+	struct gpio_device *gpio_dev = to_gpio_device(dev);
+	ssize_t ret_size = 0;
+
+	if (gpio_dev->props.policy & GPIO_INPUT)
+		gpio_dev->props.pin_level = gpio_get_pin(gpio_dev->props.pin_nr);
+	
+	spin_lock(&gpio_dev->lock);
+	ret_size += sprintf(buf, "%i\n", gpio_dev->props.pin_level);
+	spin_unlock(&gpio_dev->lock);
+
+	return ret_size;
+}
+
+static ssize_t gpio_store_level(struct class_device *dev, const char *buf, size_t size)
+{
+	struct gpio_device *gpio_dev = to_gpio_device(dev);
+	long value;
+
+	if (gpio_dev->props.policy & GPIO_INPUT) 
+		return -EINVAL;
+	
+	value = simple_strtol(buf, NULL, 10);
+	if ((value != 0) && (value != 1)) 
+		return -EINVAL;
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
+static ssize_t gpio_show_policy(struct class_device *dev, char *buf)
+{
+	struct gpio_device *gpio_dev = to_gpio_device(dev);
+	ssize_t ret_size = 0;
+	
+	spin_lock(&gpio_dev->lock);
+	if (gpio_dev->props.policy & GPIO_USER)
+		ret_size += sprintf(buf,"userspace\n");
+	if (gpio_dev->props.policy & GPIO_KERNEL)
+		ret_size += sprintf(buf,"kernel\n");
+	spin_unlock(&gpio_dev->lock);
+
+	return ret_size;
+}
+
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
+	list_for_each_safe(lact, ltmp, &gpio_list) {
+		gpio_dev = list_entry(lact, struct gpio_device, list);
+		p += sprintf(p, "%3i:   ", gpio_dev->props.pin_nr);
+		if (gpio_dev->props.policy & GPIO_KERNEL)
+			p += sprintf(p, "kernel       ");
+		if (gpio_dev->props.policy & GPIO_USER)
+			p += sprintf(p, "user space   ");
+		if (gpio_dev->props.policy & GPIO_INPUT)
+			p += sprintf(p, "input        ");
+		if (gpio_dev->props.policy & GPIO_OUTPUT)
+			p += sprintf(p, "output       ");
+		p += sprintf(p, "%s\n", gpio_dev->props.owner);
+	}
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
+	list_for_each_safe(lact, ltmp, &gpio_list) {
+		gpio_dev = list_entry(lact, struct gpio_device, list);
+		if (pin_nr == gpio_dev->props.pin_nr) {
+			printk(KERN_ERR "gpio pin %i is already used by %s\n",
+			       pin_nr, gpio_dev->props.owner);
+			return -EBUSY;
+		}
+	}
+
+	/* value checks - FIXME: is there a logical xor in C? */
+	if ( ( (policy & GPIO_USER) &&  (policy & GPIO_KERNEL)) ||
+	     (!(policy & GPIO_USER) && !(policy & GPIO_KERNEL))) {
+		printk(KERN_ERR "%s: policy has to be one of GPIO_KERNEL, GPIO_USER\n", DRIVER_NAME); 
+		return -EINVAL;
+	}
+	if ( ( (policy & GPIO_INPUT) &&  (policy & GPIO_OUTPUT)) ||
+	     (!(policy & GPIO_INPUT) && !(policy & GPIO_OUTPUT))) {
+		printk(KERN_ERR "%s: policy has to be one of GPIO_INPUT, GPIO_OUTPUT\n", DRIVER_NAME); 
+		return -EINVAL;
+	}
+
+	gpio_dev = kmalloc(sizeof(struct gpio_device), GFP_KERNEL);
+	
+	if (unlikely(!gpio_dev)) {
+		printk(KERN_ERR "%s: couldn't allocate memory\n", DRIVER_NAME);
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&gpio_dev->lock);
+	gpio_dev->props.pin_nr = pin_nr;
+	gpio_dev->props.policy = policy;
+	gpio_dev->props.pin_level = init_level;
+	gpio_dev->props.gpio_dev = gpio_dev;
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
+	INIT_LIST_HEAD(&gpio_dev->list);
+
+	/* register the attributes */
+	if (policy & GPIO_USER)
+		class_device_create_file(&gpio_dev->class_dev, &attr_gpio_level);
+	
+	class_device_create_file(&gpio_dev->class_dev, &attr_gpio_policy);
+
+	/* set real hardware */
+	if (policy & GPIO_OUTPUT) {
+		switch (init_level) {
+			case 0: gpio_clear_pin(pin_nr); break;
+			case 1: gpio_set_pin(pin_nr); break;
+			default: break; 
+		}
+		gpio_dir_output(pin_nr); 
+	}
+
+	write_lock(&gpio_list_lock);
+	list_add_tail(&gpio_dev->list, &gpio_list);
+	write_unlock(&gpio_list_lock);
+	
+	printk(KERN_INFO "registered gpio%i\n", pin_nr);
+
+	return 0;
+}
+EXPORT_SYMBOL(request_gpio);
+
+/**
+ * free_gpio - unregisters a object of gpio_properties class.
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
+	list_for_each_safe(lact, ltmp, &gpio_list) {
+		gpio_dev = list_entry(lact, struct gpio_device, list);
+		if (pin_nr == gpio_dev->props.pin_nr) {
+
+			printk(KERN_INFO "unregistering gpio pin %i\n", pin_nr);
+
+			/* unregister attributes */
+			if (gpio_dev->props.policy & GPIO_USER)
+				class_device_remove_file(&gpio_dev->class_dev,
+							 &attr_gpio_level);
+
+			class_device_remove_file(&gpio_dev->class_dev, &attr_gpio_level);
+
+			class_device_unregister(&gpio_dev->class_dev);
+			write_lock(&gpio_list_lock);
+			list_del(&gpio_dev->list);
+			write_unlock(&gpio_list_lock);
+			kfree(gpio_dev);
+			return;
+		}
+	}
+}
+EXPORT_SYMBOL(free_gpio);
+
+void free_all_gpios(void)
+{
+	struct gpio_device *gpio_dev;
+	struct list_head *lact, *ltmp;
+
+	list_for_each_safe(lact, ltmp, &gpio_list) {
+		gpio_dev = list_entry(lact, struct gpio_device, list);
+
+		printk(KERN_INFO "unregistering gpio pin %i\n", gpio_dev->props.pin_nr);
+
+		/* unregister attributes */
+		if (gpio_dev->props.policy & GPIO_USER)
+			class_device_remove_file(&gpio_dev->class_dev,
+						 &attr_gpio_level);
+
+		class_device_remove_file(&gpio_dev->class_dev, &attr_gpio_level);
+
+		class_device_unregister(&gpio_dev->class_dev);
+		write_lock(&gpio_list_lock);
+		list_del(&gpio_dev->list);
+		write_unlock(&gpio_list_lock);
+		kfree(gpio_dev);
+		return;
+	}
+}
+EXPORT_SYMBOL(free_all_gpios);
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
+static int gpio_setup(char *s)
+{
+	char *p, *q = NULL;
+	int pin_nr;
+	unsigned char policy;
+	unsigned char init_level = 0;
+
+	while ((p = strsep(&s, ".,")) != NULL) {
+
+		/* end of command reached? -> next command */
+		if (*p == '\0')
+			continue;
+
+		/* process one command */
+		pin_nr = -1;
+		policy = 0;
+		q = strsep(&p, ":");
+		if (*q == '\0') {
+			printk("%s: invalid token (scanning pin_nr): %s\n", DRIVER_NAME, p); 
+			continue;
+		}
+		pin_nr = simple_strtoul(q, NULL, 0);	/* FIXME: this doesn't detect if no number is given! */
+		q = strsep(&p, ":");
+		if (*q == '\0') {
+			printk("%s: invalid token (scanning direction): %s\n", DRIVER_NAME, p); 
+			continue;
+		}
+		policy |= strncmp(q, "in", strlen(q)) == 0 ? GPIO_INPUT : 0;
+		policy |= strncmp(q, "out", strlen(q)) == 0 ? GPIO_OUTPUT : 0;
+		if (policy == 0) {
+			printk("%s: invalid token (scanning policy): %s\n", DRIVER_NAME, p); 
+			continue;
+		}
+		if (policy & GPIO_OUTPUT) {
+			q = strsep(&p, ":");
+			if (*q == '\0') {
+				printk("%s: invalid token (scanning init_level): %s\n", DRIVER_NAME, p); 
+				continue;
+			}
+			init_level = 2;
+			if (strncmp(q, "hi", strlen(q)) == 0)
+				init_level = 1;
+			if (strncmp(q, "lo", strlen(q)) == 0)
+				init_level = 0;
+			if (init_level == 2) {
+				printk("%s: invalid token (scanning level_value): %s\n", DRIVER_NAME, p); 
+				continue;
+			}
+		}
+		policy |= GPIO_USER;
+		if (request_gpio(pin_nr, "kernel", policy, init_level) != 0) {
+			printk(KERN_ERR
+			       "%s: could not register GPIO pins from commandline!\n",
+			       DRIVER_NAME);
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int __init gpio_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "Initialising gpio device class.\n");
+
+	class_register(&gpio_class);
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
+        if (!create_proc_read_entry ("gpio", 0, 0, gpio_read_proc, NULL)) {
+		printk(KERN_ERR "%s: couldn't register proc entry, exiting\n", DRIVER_NAME);
+		goto out_proc;
+	}
+
+	/* parse command line parameters */
+	printk(KERN_INFO "%s: mapping=", DRIVER_NAME);
+	if (strcmp(mapping,"")) {
+		printk("%s\n", mapping);
+		if (gpio_setup(mapping) != 0) {
+			printk(KERN_ERR "%s: could not register ('mapping=...'), exiting\n", DRIVER_NAME);
+		}
+	} else {
+		printk("EMPTY\n"); 
+	};
+
+	return ret;
+
+out_proc:
+	sysdev_unregister(&gpio_sys_device);
+out_sysdev_register:
+	sysdev_class_unregister(&gpio_sysclass);
+out_sysdev_class:
+	class_unregister(&gpio_class);
+	return ret;
+}
+
+module_init(gpio_init);
Index: kernel/Makefile
===================================================================
--- a/kernel/Makefile	(.../vanilla/linux-2.6.8-rc2)	(revision 205)
+++ b/kernel/Makefile	(.../linux-pxa/trunks/linux-2.6.8-rc2-trunk)	(revision 205)
@@ -23,6 +23,7 @@
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+obj-$(CONFIG_GPIO) += gpio.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: include/asm-arm/arch-pxa/gpio.h
===================================================================
--- a/include/asm-arm/arch-pxa/gpio.h	(revision 0)
+++ b/include/asm-arm/arch-pxa/gpio.h	(revision 205)
@@ -0,0 +1,49 @@
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
+
+#define DEBUG 1
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
+
+#endif
Index: include/linux/gpio.h
===================================================================
--- a/include/linux/gpio.h	(revision 0)
+++ b/include/linux/gpio.h	(revision 205)
@@ -0,0 +1,27 @@
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
+#define GPIO_KERNEL     (1<<0)
+#define GPIO_USER       (1<<1)
+#define GPIO_INPUT      (1<<2)
+#define GPIO_OUTPUT     (1<<3)
+
+int request_gpio(unsigned int pin_nr, const char *owner,
+		 unsigned char policy, unsigned char init_level);
+
+void free_gpio(unsigned int pin_nr);
+
+#endif
Index: init/Kconfig
===================================================================
--- a/init/Kconfig	(.../vanilla/linux-2.6.8-rc2)	(revision 205)
+++ b/init/Kconfig	(.../linux-pxa/trunks/linux-2.6.8-rc2-trunk)	(revision 205)
@@ -294,6 +294,18 @@
 
 	  If unsure, say N.
 
+config GPIO
+	bool "GPIO pin support"
+	default y if ARM || PPC
+	default n
+	help
+	  Enabling this option adds support for generic GPIO pins. Most
+	  System-on-Chip processors have this kind of pins.
+
+	  FIXME: write more documentation. 
+
+	  If unsure, say N. 
+
 endmenu		# General setup
 
 

--nVMJ2NtxeReIH9PS--
