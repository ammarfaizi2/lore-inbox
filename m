Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261706AbSJQDzF>; Wed, 16 Oct 2002 23:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbSJQDzF>; Wed, 16 Oct 2002 23:55:05 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:61848 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261706AbSJQDyr>;
	Wed, 16 Oct 2002 23:54:47 -0400
Message-ID: <3DAE35B9.CB085D1@us.ibm.com>
Date: Wed, 16 Oct 2002 20:59:53 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andrey V. Savochkin" <saw@saw.sw.com.sg>,
       James Keniston <kenistoj@us.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
       Jeff Garzik <jgarzik@pobox.com>, mochel@osdl.org
Subject: Rusty's back...restarting logging interface discussions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Welcome back, Rusty :0)

Sep 23 I posted patches with a new "problem() logging" interface. The 
subject line contained "logging macros".  

In response to the LKML discussion, Alan wrote...
> A lot of it can be tidied up by very very few changes that can be done
> over time and make the job easier. Why not just start with
>
>		 dev_printk(dev, KERN_ERR "Exploded mysteriously");
>
> and a few notification type things people can add eg
>
>		 dev_failed(dev);
>		 dev_offline(dev);
> [SNIP]
>
> dev_printk(dev, ...) is printk that formats up the device info for you.
> Its also easy to use and happens to pass a device pointer into the
> places you want it for more detailed logging
>
> [SNIP]
>
> I don't *care* what you do with it after it gets thrown at you. If I
> have to care what you are doing with the data the interface is wrong.   
>  --Alan

I agree with Alan, but at the same time you don't want to define an 
interface that _limits_ alternative post processing of the data.  

Also, Greg KH and Jeff Garzik pointed out that defining what should be
logged is as important as the interface.  I agree, but that's outside of
the scope of this note.

The patch below defines a new interface that's a marriage between Alan's
proposal and Rusty's macro + event logging. In summary...

* The goal here is to define an interface around printk() that 
  allows an alternative logging facility to be added as needed without
  expecting device driver writers to move to a new interface now, and yet
  another one later.  Another goal is compatibility with the device model
  (Pat Mochel and Greg KH).

* With dev_printk(), etc. you *can* define attribute names in the fmt string,
  but attribute names are _not_ required.  Attribute names appear as part of 
  the message in printk messages, when written as "foo_name=%s".  However,
  if written as   "{foo_name}%s", "{foo_name} is stripped out for the printk 
  message, but used as an attribute name in event logging (if CONFIG_EVLOG=y).

  If an attribute name is not specified using either method, attribute names
  can still be added to the event logging template.
  
* With Rusty's macro, static details (format string, source file name, 
  function name and line number) are stored in a .log section in the .o file.
  
  A userspace utility can then extract data from the .log section to create
  a template for re-combining the formatting details with the event data. 
  This allows for alternative presentation and translations, etc. of kernel
  event data, and queries of events by attribute name by modifying the 
  template, but without having to modify device driver source code. 
 
  A unique reference code ties the event record to its template. 

* The attached patch for 2.5.43 works fine with printk() only, but includes
  Rusty's macro now named "printkat".  The rest of event logging, with
  userspace library and utilities, is located at...

    https://sourceforge.net/project/showfiles.php?group_id=34226 

  Click on "dev_printk" under evlog-2.5_kernel, and follow instructions.
  
----------------------------------------------------------------------
diff -Naur linux.org/Rules.make linux.printkat.patched/Rules.make
--- linux.org/Rules.make	Wed Oct 16 14:44:12 2002
+++ linux.printkat.patched/Rules.make	Wed Oct 16 14:44:12 2002
@@ -238,7 +238,7 @@
 
 quiet_cmd_modules_install = INSTALL $(obj-m)
 cmd_modules_install = mkdir -p $(MODLIB)/kernel/$(obj); \
-		      cp $(obj-m) $(MODLIB)/kernel/$(obj)
+		      (for o in $(obj-m); do objcopy -R .log $$o $(MODLIB)/kernel/$$o; done)
 
 .PHONY: modules_install
 
diff -Naur linux.org/arch/i386/vmlinux.lds.S linux.printkat.patched/arch/i386/vmlinux.lds.S
--- linux.org/arch/i386/vmlinux.lds.S	Wed Oct 16 14:44:12 2002
+++ linux.printkat.patched/arch/i386/vmlinux.lds.S	Wed Oct 16 14:44:12 2002
@@ -92,6 +92,7 @@
 	*(.text.exit)
 	*(.data.exit)
 	*(.exitcall.exit)
+	*(.log)
 	}
 
   /* Stabs debugging sections.  */
diff -Naur linux.org/drivers/misc/Makefile linux.printkat.patched/drivers/misc/Makefile
--- linux.org/drivers/misc/Makefile	Wed Oct 16 14:44:12 2002
+++ linux.printkat.patched/drivers/misc/Makefile	Wed Oct 16 14:44:12 2002
@@ -2,4 +2,6 @@
 # Makefile for misc devices that really don't fit anywhere else.
 #
 
+obj-m	+= dev_dummy.o
+
 include $(TOPDIR)/Rules.make
diff -Naur linux.org/drivers/misc/dev_dummy.c linux.printkat.patched/drivers/misc/dev_dummy.c
--- linux.org/drivers/misc/dev_dummy.c	Wed Dec 31 16:00:00 1969
+++ linux.printkat.patched/drivers/misc/dev_dummy.c	Wed Oct 16 14:44:12 2002
@@ -0,0 +1,77 @@
+#define EVL_FACILITY_NAME dev_dummy
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+
+struct dummy_dev {
+	struct device	dev;
+	char		name[20];
+	int		iq;
+	int		nthings;
+};
+struct dummy_dev dummy, dope;
+
+struct bus_type dummy_bus = {
+	.name		= "dummy_bus"
+};
+
+struct device_class dummy_class = {
+	.name		= "dummy_class"
+};
+
+struct device_driver dummy_driver = {
+	.name		= "dummy_driver",
+	.bus		= &dummy_bus,
+	.devclass	= &dummy_class
+};
+
+static void init_dummy_dev(struct dummy_dev *dd, const char *name,
+	const char *bus_id, int iq, int nthings)
+{
+	(void) strcpy(&dd->name[0], name);
+	snprintf(&dd->dev.name[0], DEVICE_NAME_SIZE,
+		"dummy dev %s with %d IQ and %d things",
+		name, iq, nthings);
+	(void) strcpy(&dd->dev.bus_id[0], bus_id);
+	dd->iq = iq;
+	dd->nthings = nthings;
+	dd->dev.driver = &dummy_driver;
+	dev_online(dd->dev);
+}
+
+static int __init dev_dummy_init_module(void)
+{
+	printkat(KERN_NOTICE
+"dev_dummy module is starting up, and my mood = %s.\n",
+		"excited");
+	init_dummy_dev(&dummy, "dummy", "01:02.3", 50, 5);
+	init_dummy_dev(&dope, "dope", "02:04.6", 40, 4);
+
+	dev_info(dummy.dev,
+"Did I mention that device {ddname}%s has iq=%d and nthings=%d?\n",
+		dummy.name, dummy.iq, dummy.nthings);
+	dev_err(dope.dev,
+"Device {ddname}%s has tipped over.  It now has nthings=%d things.\n",
+		dope.name, 0);
+	dev_offline(dope.dev);
+	dev_printk(KERN_ALERT, dummy.dev,
+"Device {ddname}%s may soon explode!  Its {nthings}%d things may be in danger!\n",
+		dummy.name, dummy.nthings);
+	dev_failed(dummy.dev);
+	return 0;
+}
+
+static void __exit dev_dummy_exit_module(void)
+{
+	printkat(KERN_NOTICE
+"dev_dummy module is exiting, and my mood = %s.\n",
+		"sad");
+	dev_offline(dummy.dev);
+}
+
+module_init(dev_dummy_init_module);
+module_exit(dev_dummy_exit_module);
+MODULE_LICENSE("GPL");
diff -Naur linux.org/include/linux/device.h linux.printkat.patched/include/linux/device.h
--- linux.org/include/linux/device.h	Wed Oct 16 14:44:12 2002
+++ linux.printkat.patched/include/linux/device.h	Wed Oct 16 14:44:12 2002
@@ -29,6 +29,7 @@
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/driverfs_fs.h>
+#include <linux/printkat.h>
 
 #define DEVICE_NAME_SIZE	80
 #define DEVICE_ID_SIZE		32
@@ -426,22 +427,27 @@
 extern void device_shutdown(void);
 
 /* debugging and troubleshooting/diagnostic helpers. */
+#define dev_printk(sev, dev, format, arg...) \
+	printkat(sev "{driver}%s {bus_id}%s: " format,	\
+		(dev).driver->name, (dev).bus_id, ## arg)
+
 #ifdef DEBUG
 #define dev_dbg(dev, format, arg...)		\
-	printk (KERN_DEBUG "%s %s: " format ,	\
-		dev.driver->name , dev.bus_id , ## arg)
+	dev_printk(KERN_DEBUG, (dev), format, ## arg)
 #else
 #define dev_dbg(dev, format, arg...) do {} while (0)
 #endif
 
 #define dev_err(dev, format, arg...)		\
-	printk (KERN_ERR "%s %s: " format ,	\
-		dev.driver->name , dev.bus_id , ## arg)
+	dev_printk(KERN_ERR, (dev), format, ## arg)
 #define dev_info(dev, format, arg...)		\
-	printk (KERN_INFO "%s %s: " format ,	\
-		dev.driver->name , dev.bus_id , ## arg)
+	dev_printk(KERN_INFO, (dev), format, ## arg)
 #define dev_warn(dev, format, arg...)		\
-	printk (KERN_WARN "%s %s: " format ,	\
-		dev.driver->name , dev.bus_id , ## arg)
+	dev_printk(KERN_WARNING, (dev), format, ## arg)
+
+#define dev_failed(dev) dev_err((dev), "Device {status}%s\n", "failed")
+#define dev_offline(dev) dev_info((dev), "Device {status}%s\n", "offline")
+#define dev_online(dev)	\
+	dev_info((dev), "Device {status}%s: {name}%s\n", "online", (dev).name)
 
 #endif /* _DEVICE_H_ */
diff -Naur linux.org/include/linux/printkat.h linux.printkat.patched/include/linux/printkat.h
--- linux.org/include/linux/printkat.h	Wed Dec 31 16:00:00 1969
+++ linux.printkat.patched/include/linux/printkat.h	Wed Oct 16 14:44:12 2002
@@ -0,0 +1,96 @@
+/*
+ * Linux Event Logging for the Enterprise
+ * Copyright (c) International Business Machines Corp., 2002
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Please send e-mail to lkessler@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ *
+ */
+
+#ifndef _LINUX_PRINTKAT_H
+#define _LINUX_PRINTKAT_H
+
+extern int __printkat(const char *facname, int event_type, const char *fmt,
+	...);
+
+#ifndef CONFIG_EVLOG
+
+/* Just strip {id} constructs and call printk. */
+#define printkat(fmt, ...) __printkat((const char*)0, 0, fmt, ##__VA_ARGS__)
+
+#else	/* CONFIG_EVLOG */
+
+#include <linux/stringify.h>
+#include <linux/kernel.h>
+#include <linux/evl_log.h>
+
+/*
+ * Facility name defaults to the name of the module, as set in the kernel
+ * build, or to kern (the kernel default) if the module name is not set.
+ * Define EVL_FACILITY_NAME before including this header if that's
+ * unsatisfactory.
+ */
+#ifndef EVL_FACILITY_NAME
+#ifdef KBUILD_MODNAME
+#define EVL_FACILITY_NAME KBUILD_MODNAME
+#else
+#define EVL_FACILITY_NAME kern
+#endif
+#endif
+
+extern int evl_gen_event_type(const char *s1, const char *s2, const char *s3);
+
+/*
+ * Bloat doesn't matter: this doesn't end up in vmlinux.
+ * function and file are required for computation of event type.
+ * All three are good to know.
+ */
+struct log_position {
+   int line;
+   char function[64 - sizeof(int)];
+   char file[128];
+};
+
+#define _LOG_POS { __LINE__, __FUNCTION__, __FILE__ }
+
+/*
+ * Information about a printkat() message.
+ * Again, bloat doesn't matter: this doesn't end up in vmlinux.
+ * Note that, because of default alignment in the .log section,
+ * sizeof(struct log_info) should be a multiple of 32.
+ */
+struct log_info {
+   char format[128+64];
+   char facility[64];
+   struct log_position pos;
+};
+
+#define printkat(fmt, ...) \
+({ \
+   static struct log_info __attribute__((section(".log"),unused)) ___ \
+      = { fmt, __stringify(EVL_FACILITY_NAME), _LOG_POS }; \
+   __printkat(__stringify(EVL_FACILITY_NAME), \
+      evl_gen_event_type(__FILE__, __FUNCTION__, fmt), \
+      fmt, ##__VA_ARGS__); \
+})
+
+#endif /* CONFIG_EVLOG */
+
+#endif /*_LINUX_PRINTKAT_H*/
diff -Naur linux.org/kernel/printk.c linux.printkat.patched/kernel/printk.c
--- linux.org/kernel/printk.c	Wed Oct 16 14:44:12 2002
+++ linux.printkat.patched/kernel/printk.c	Wed Oct 16 14:44:12 2002
@@ -27,9 +27,19 @@
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
 
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_EVLOG
+#include <linux/evl_log.h>
+extern int evl_printkat(const char *facname, int evtype, char *recbuf,
+	va_list args);
+#else
+#define POSIX_LOG_ENTRY_MAXLEN (8*1024)
+#endif
+
 #if defined(CONFIG_X86_NUMAQ) || defined(CONFIG_IA64)
 #define LOG_BUF_LEN	(65536)
 #elif defined(CONFIG_ARCH_S390)
@@ -434,9 +444,20 @@
  * then changes console_loglevel may break. This is because console_loglevel
  * is inspected when the actual printing occurs.
  */
+int vprintk(const char *fmt, va_list args);
+
 asmlinkage int printk(const char *fmt, ...)
 {
+	int status;
 	va_list args;
+	va_start(args, fmt);
+	status = vprintk(fmt, args);
+	va_end(args);
+	return status;
+}
+
+int vprintk(const char *fmt, va_list args)
+{
 	unsigned long flags;
 	int printed_len;
 	char *p;
@@ -454,9 +475,7 @@
 	spin_lock_irqsave(&logbuf_lock, flags);
 
 	/* Emit the output into the temporary buffer */
-	va_start(args, fmt);
 	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
-	va_end(args);
 
 	/*
 	 * Copy the output into log_buf.  If the caller didn't provide
@@ -722,3 +741,85 @@
 		tty->driver.write(tty, 0, msg, strlen(msg));
 	return;
 }
+
+static char printkat_buf[POSIX_LOG_ENTRY_MAXLEN];
+static spinlock_t printkat_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * Copy src to dest, replacing strings of the form "{id}%" with "%".
+ * dest is a buffer of size bufsz.  Make sure we don't overflow it.
+ */
+static void unbrace(char *dest, const char *src, int bufsz)
+{
+	const char *copy_this = src, *scan_this = src;
+	const char *c, *lcb, *rcb;
+	int copy_len, dlen = 0;
+
+	dest[0] = '\0';
+	for (;;) {
+		lcb = strchr(scan_this, '{');
+		if (!lcb) {
+			goto done;
+		}
+		rcb = strstr(lcb+2, "}%");
+		if (!rcb) {
+			goto done;
+		}
+		/* Is it a valid identifier between the { and } ? */
+		c = lcb+1;
+		if (*c != '_' && !isalpha(*c)) {
+			goto scan_again;
+		}
+		for (c++; c < rcb; c++) {
+			if (*c != '_' && !isalnum(*c)) {
+				goto scan_again;
+			}
+		}
+		copy_len = min(lcb - copy_this, bufsz-(dlen+1));
+		strncat(dest + dlen, copy_this, copy_len);
+		dlen += copy_len;
+		copy_this = rcb+1;
+scan_again:
+		scan_this = rcb+2;
+	}
+done:
+	copy_len = bufsz-(dlen+1);
+	strncat(dest + dlen, copy_this, copy_len);
+	return;
+}
+
+/*
+ * fmt and subsequent args are as with printk.  Log the message to printk
+ * (via vprintk), and (if EVLOG is configured) also to evlog as a
+ * POSIX_LOG_PRINTF-format record.  Strip {id}s from the message.
+ */
+/*ARGSUSED*/
+int __printkat(const char *facname, int evtype, const char *fmt, ...)
+{
+	int status;
+	unsigned long flags;
+	va_list args;
+
+	va_start(args, fmt);
+#ifdef CONFIG_EVLOG
+	spin_lock_irqsave(&printkat_lock, flags);
+	unbrace(printkat_buf, fmt, POSIX_LOG_ENTRY_MAXLEN);
+	(void) vprintk(printkat_buf, args);
+	status = evl_printkat(facname, evtype, printkat_buf, args);
+	spin_unlock_irqrestore(&printkat_lock, flags);
+#else
+	/* EVLOG disabled.  Just call printk, stripping {id}s as needed. */
+	if (strstr(fmt, "}%")) {
+		spin_lock_irqsave(&printkat_lock, flags);
+		unbrace(printkat_buf, fmt, POSIX_LOG_ENTRY_MAXLEN);
+		status = vprintk(printkat_buf, args);
+		spin_unlock_irqrestore(&printkat_lock, flags);
+	} else {
+		status = vprintk(fmt, args);
+	}
+#endif
+	va_end(args);
+
+	return status;
+}
+EXPORT_SYMBOL(__printkat);
