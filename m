Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268035AbUIUTxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268035AbUIUTxJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUIUTxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:53:08 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:44990 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S268031AbUIUTwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:52:33 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: [PATCH 2.6.9-rc2-mm1] i8042 ACPI enumeration update
Date: Tue, 21 Sep 2004 13:52:22 -0600
User-Agent: KMail/1.7
Cc: Hans-Frieder Vogt <hfvogt@gmx.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409211352.22318.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a few updates:

 - Fix build on ia64 (I8042_MAP_IRQ() isn't defined at compile-time)
 - Add FixedIO support from Hans-Frieder Vogt
 - Add ACPI device name (e.g., "PS/2 Keyboard Controller")
 - Fall back to default ports/IRQ if ACPI _CRS doesn't supply them
 - Fall back to previous blind probing if ACPI is disabled

I'd appreciate any comments or feedback.  If it looks reasonable,
please include this in the next -mm patchset.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff -u -ur 2.6.9-rc2-mm1/drivers/input/serio/i8042-x86ia64io.h kbd4/drivers/input/serio/i8042-x86ia64io.h
--- 2.6.9-rc2-mm1/drivers/input/serio/i8042-x86ia64io.h 2004-09-21 12:51:48.000000000 -0600
+++ kbd4/drivers/input/serio/i8042-x86ia64io.h 2004-09-21 13:06:33.000000000 -0600
@@ -28,8 +28,8 @@
 #define I8042_KBD_IRQ i8042_kbd_irq
 #define I8042_AUX_IRQ i8042_aux_irq
 
-static int i8042_kbd_irq = I8042_MAP_IRQ(1);
-static int i8042_aux_irq = I8042_MAP_IRQ(12);
+static int i8042_kbd_irq;
+static int i8042_aux_irq;
 
 /*
  * Register numbers.
@@ -105,6 +105,7 @@
 {
  struct i8042_acpi_resources *i8042_res = data;
  struct acpi_resource_io *io;
+ struct acpi_resource_fixed_io *fixed_io;
  struct acpi_resource_irq *irq;
  struct acpi_resource_ext_irq *ext_irq;
 
@@ -119,6 +120,16 @@
    }
    break;
 
+  case ACPI_RSTYPE_FIXED_IO:
+   fixed_io = &res->data.fixed_io;
+   if (fixed_io->range_length) {
+    if (!i8042_res->port1)
+     i8042_res->port1 = fixed_io->base_address;
+    else
+     i8042_res->port2 = fixed_io->base_address;
+   }
+   break;
+
   case ACPI_RSTYPE_IRQ:
    irq = &res->data.irq;
    if (irq->number_of_interrupts > 0)
@@ -151,13 +162,29 @@
  if (ACPI_FAILURE(status))
   return -ENODEV;
 
- printk("i8042: ACPI %s [%s] at I/O 0x%x, 0x%x, irq %d\n",
+ if (kbd_res.port1)
+  i8042_data_reg = kbd_res.port1;
+ else
+  printk(KERN_WARNING "ACPI: [%s] has no data port; default is 0x%x\n",
+   acpi_device_bid(device), i8042_data_reg);
+
+ if (kbd_res.port2)
+  i8042_command_reg = kbd_res.port2;
+ else
+  printk(KERN_WARNING "ACPI: [%s] has no command port; default is 0x%x\n",
+   acpi_device_bid(device), i8042_command_reg);
+
+ if (kbd_res.irq)
+  i8042_kbd_irq = kbd_res.irq;
+ else
+  printk(KERN_WARNING "ACPI: [%s] has no IRQ; default is %d\n",
+   acpi_device_bid(device), i8042_kbd_irq);
+
+ strncpy(acpi_device_name(device), "PS/2 Keyboard Controller",
+  sizeof(acpi_device_name(device)));
+ printk("ACPI: %s [%s] at I/O 0x%x, 0x%x, irq %d\n",
   acpi_device_name(device), acpi_device_bid(device),
-  kbd_res.port1, kbd_res.port2, kbd_res.irq);
-
- i8042_data_reg = kbd_res.port1;
- i8042_command_reg = kbd_res.port2;
- i8042_kbd_irq = kbd_res.irq;
+  i8042_data_reg, i8042_command_reg, i8042_kbd_irq);
 
  return 0;
 }
@@ -173,10 +200,16 @@
  if (ACPI_FAILURE(status))
   return -ENODEV;
 
- printk("i8042: ACPI %s [%s] at irq %d\n",
-  acpi_device_name(device), acpi_device_bid(device), aux_res.irq);
-
- i8042_aux_irq = aux_res.irq;
+ if (aux_res.irq)
+  i8042_aux_irq = aux_res.irq;
+ else
+  printk(KERN_WARNING "ACPI: [%s] has no IRQ; default is %d\n",
+   acpi_device_bid(device), i8042_aux_irq);
+
+ strncpy(acpi_device_name(device), "PS/2 Mouse Controller",
+  sizeof(acpi_device_name(device)));
+ printk("ACPI: %s [%s] at irq %d\n",
+  acpi_device_name(device), acpi_device_bid(device), i8042_aux_irq);
 
  return 0;
 }
@@ -201,7 +234,7 @@
 {
  int result;
 
- if (i8042_noacpi) {
+ if (acpi_disabled || i8042_noacpi) {
   printk("i8042: ACPI detection disabled\n");
   return 0;
  }
@@ -245,6 +278,9 @@
  *  return -1;
  */
 
+ i8042_kbd_irq = I8042_MAP_IRQ(1);
+ i8042_aux_irq = I8042_MAP_IRQ(12);
+
 #ifdef CONFIG_ACPI
  if (i8042_acpi_init())
   return -1;
