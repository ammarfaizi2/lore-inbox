Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269199AbUIBVgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269199AbUIBVgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269180AbUIBVee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:34:34 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:37049 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S269199AbUIBV3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:29:34 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] allow i8042 register location override
Date: Thu, 2 Sep 2004 15:29:19 -0600
User-Agent: KMail/1.6.2
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
References: <20040902175647.97709.qmail@web81309.mail.yahoo.com>
In-Reply-To: <20040902175647.97709.qmail@web81309.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021529.19575.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 September 2004 11:56 am, Dmitry Torokhov wrote:
> > +static unsigned long i8042_command_reg = I8042_COMMAND_REG;
> > +static unsigned long i8042_status_reg = I8042_STATUS_REG;
> > +static unsigned long i8042_data_reg = I8042_DATA_REG;

> This will not work as these macros are not constants, see i8042-*io.h
> and i8042_platform_init().

Thanks for pointing this out.  What do you think of the attached?

> What you need to do is add ACPI hooks to 
> i8042_platform_init for i386/ia64/etc.

Yes, that sounds like a better idea as well.  Let me poke on that part
a bit more.  Maybe I can just move the calls I added into the platform
init/exit functions.


Allow the default i8042 register locations to be changed at run-time.
This is a prelude to adding discovery via the ACPI namespace.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff -u -ur 2.6.9-rc1-mm2/drivers/input/serio/i8042-io.h 2.6.9-rc1-mm2-kbd1/drivers/input/serio/i8042-io.h
--- 2.6.9-rc1-mm2/drivers/input/serio/i8042-io.h	2004-09-02 09:49:05.000000000 -0600
+++ 2.6.9-rc1-mm2-kbd1/drivers/input/serio/i8042-io.h	2004-09-02 09:50:26.000000000 -0600
@@ -36,32 +36,36 @@
 #endif
 
 /*
- * Register numbers.
+ * Register numbers (may be overridden)
  */
 
 #define I8042_COMMAND_REG	0x64	
 #define I8042_STATUS_REG	0x64	
 #define I8042_DATA_REG		0x60
 
+extern unsigned long i8042_command_reg;
+extern unsigned long i8042_status_reg;
+extern unsigned long i8042_data_reg;
+
 static inline int i8042_read_data(void)
 {
-	return inb(I8042_DATA_REG);
+	return inb(i8042_data_reg);
 }
 
 static inline int i8042_read_status(void)
 {
-	return inb(I8042_STATUS_REG);
+	return inb(i8042_status_reg);
 }
 
 static inline void i8042_write_data(int val)
 {
-	outb(val, I8042_DATA_REG);
+	outb(val, i8042_data_reg);
 	return;
 }
 
 static inline void i8042_write_command(int val)
 {
-	outb(val, I8042_COMMAND_REG);
+	outb(val, i8042_command_reg);
 	return;
 }
 
diff -u -ur 2.6.9-rc1-mm2/drivers/input/serio/i8042.c 2.6.9-rc1-mm2-kbd1/drivers/input/serio/i8042.c
--- 2.6.9-rc1-mm2/drivers/input/serio/i8042.c	2004-09-02 09:49:05.000000000 -0600
+++ 2.6.9-rc1-mm2-kbd1/drivers/input/serio/i8042.c	2004-09-02 15:18:12.000000000 -0600
@@ -106,6 +106,10 @@
 static struct timer_list i8042_timer;
 static struct platform_device *i8042_platform_device;
 
+static unsigned long i8042_command_reg;
+static unsigned long i8042_status_reg;
+static unsigned long i8042_data_reg;
+
 /*
  * Shared IRQ's require a device pointer, but this driver doesn't support
  * multiple devices
@@ -650,10 +654,7 @@
 	}
 
 	printk(KERN_INFO "serio: i8042 %s port at %#lx,%#lx irq %d\n",
-	       values->name,
-	       (unsigned long) I8042_DATA_REG,
-	       (unsigned long) I8042_COMMAND_REG,
-	       values->irq);
+	       values->name, i8042_data_reg, i8042_command_reg, values->irq);
 
 	serio_register_port(port);
 
@@ -1067,6 +1068,18 @@
 	return serio;
 }
 
+static void __init i8042_init_defaults(void)
+{
+	i8042_command_reg = I8042_COMMAND_REG;
+	i8042_data_reg = I8042_DATA_REG;
+#ifdef I8042_STATUS_REG
+	i8042_status_reg = I8042_STATUS_REG;
+#endif
+
+	i8042_aux_values.irq = I8042_AUX_IRQ;
+	i8042_kbd_values.irq = I8042_KBD_IRQ;
+}
+
 int __init i8042_init(void)
 {
 	int i;
@@ -1077,12 +1090,11 @@
 	init_timer(&i8042_timer);
 	i8042_timer.function = i8042_timer_func;
 
+	i8042_init_defaults();
+
 	if (i8042_platform_init())
 		return -EBUSY;
 
-	i8042_aux_values.irq = I8042_AUX_IRQ;
-	i8042_kbd_values.irq = I8042_KBD_IRQ;
-
 	if (i8042_controller_init())
 		return -ENODEV;
 
