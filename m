Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268089AbUIBQKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbUIBQKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268220AbUIBQKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:10:19 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:8587 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S268089AbUIBQJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:09:41 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] allow i8042 register location override
Date: Thu, 2 Sep 2004 10:09:23 -0600
User-Agent: KMail/1.6.2
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021009.23280.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
+++ 2.6.9-rc1-mm2-kbd1/drivers/input/serio/i8042.c	2004-09-02 09:49:50.000000000 -0600
@@ -106,6 +106,10 @@
 static struct timer_list i8042_timer;
 static struct platform_device *i8042_platform_device;
 
+static unsigned long i8042_command_reg = I8042_COMMAND_REG;
+static unsigned long i8042_status_reg = I8042_STATUS_REG;
+static unsigned long i8042_data_reg = I8042_DATA_REG;
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
 
