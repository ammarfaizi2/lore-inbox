Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUIMPCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUIMPCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUIMPBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:01:13 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:34702 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S267700AbUIMOvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:51:39 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.8-rc1-mm4: allow-i8042-register-location-override-2.patch
Date: Mon, 13 Sep 2004 08:51:21 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Sean Neakums <sneakums@zork.net>,
       Dmitry Torokhov <dtor@mail.ru>, Andrew Morton <akpm@osdl.org>
References: <6uy8jg4hp9.fsf@zork.zork.net> <200409111727.56934.dtor_core@ameritech.net>
In-Reply-To: <200409111727.56934.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <200409130851.21743.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 September 2004 4:27 pm, Dmitry Torokhov wrote:
> On Saturday 11 September 2004 04:30 pm, Sean Neakums wrote:
> > > Input: Add ACPI-based i8042 keyboard and aux controller enumeration;
> > > can be disabled by passing i8042.noacpi as a boot parameter.
> > 
> > On a whim I decided to turn on ACPI, only to discover that my keyboard
> > no longer worked.  Passing i8042.noacpi=1 makes it work again.
> > Attached please find boot messages with and without the boot
> > parameter.  Inlined below is a diff of the two.
> 
> Bjorn has a patch that would use defaults if ports/IRQ are not specified
> in the DSDT table, which should help in your case I think.

Thanks much for testing this, Sean.  Can you try the attached patch,
please?

--- 2.6.9-rc1-mm4-bh1/drivers/input/serio/i8042-x86ia64io.h.orig	2004-09-07 14:41:42.000000000 -0600
+++ 2.6.9-rc1-mm4-bh1/drivers/input/serio/i8042-x86ia64io.h	2004-09-07 14:51:06.000000000 -0600
@@ -155,9 +155,23 @@
 		acpi_device_name(device), acpi_device_bid(device),
 		kbd_res.port1, kbd_res.port2, kbd_res.irq);
 
-	i8042_data_reg = kbd_res.port1;
-	i8042_command_reg = kbd_res.port2;
-	i8042_kbd_irq = kbd_res.irq;
+	if (kbd_res.port1)
+		i8042_data_reg = kbd_res.port1;
+	else
+		printk(KERN_WARNING "i8042: bogus data port address in %s _CRS, defaulting to 0x%x\n",
+			acpi_device_bid(device), i8042_data_reg);
+
+	if (kbd_res.port2)
+		i8042_command_reg = kbd_res.port2;
+	else
+		printk(KERN_WARNING "i8042: bogus command port address in %s _CRS, defaulting to 0x%x\n",
+			acpi_device_bid(device), i8042_command_reg);
+
+	if (kbd_res.irq)
+		i8042_kbd_irq = kbd_res.irq;
+	else
+		printk(KERN_WARNING "i8042: bogus IRQ in %s _CRS, defaulting to %d\n",
+			acpi_device_bid(device), i8042_kbd_irq);
 
 	return 0;
 }
@@ -176,7 +190,11 @@
 	printk("i8042: ACPI %s [%s] at irq %d\n",
 		acpi_device_name(device), acpi_device_bid(device), aux_res.irq);
 
-	i8042_aux_irq = aux_res.irq;
+	if (aux_res.irq)
+		i8042_aux_irq = aux_res.irq;
+	else
+		printk(KERN_WARNING "i8042: bogus IRQ in %s _CRS, defaulting to %d\n",
+			acpi_device_bid(device), i8042_aux_irq);
 
 	return 0;
 }
@@ -201,7 +219,7 @@
 {
 	int result;
 
-	if (i8042_noacpi) {
+	if (acpi_disabled || i8042_noacpi) {
 		printk("i8042: ACPI detection disabled\n");
 		return 0;
 	}

