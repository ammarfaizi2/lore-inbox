Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268677AbUIGVYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbUIGVYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268665AbUIGVXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:23:41 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:16785 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S268261AbUIGVHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:07:50 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Nathan Bryant <nbryant@optonline.net>
Subject: Re: 2.6.9-rc1-mm4
Date: Tue, 7 Sep 2004 15:07:41 -0600
User-Agent: KMail/1.6.2
Cc: Lorenzo Allegrucci <l_allegrucci@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
References: <20040907020831.62390588.akpm@osdl.org> <200409072201.55025.l_allegrucci@yahoo.it> <413E18CB.7020305@optonline.net>
In-Reply-To: <413E18CB.7020305@optonline.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409071507.41870.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 September 2004 2:23 pm, Nathan Bryant wrote:
> Lorenzo Allegrucci wrote:
> > On Tuesday 07 September 2004 11:08, Andrew Morton wrote:
> > 
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6
> >>.9-rc1-mm4/
> > 
> > 
> > My PS/2 keyboard doesn't work, I tried "pci=routeirq" but it didn't help.
> > 
> > Sep  7 21:39:00 odyssey kernel: i8042: ACPI  [PS2K] at I/O 0x0, 0x0, irq 1
> > Sep  7 21:39:00 odyssey kernel: i8042: ACPI  [PS2M] at irq 12
> > Sep  7 21:39:00 odyssey kernel: i8042.c: Can't read CTR while initializing 
> > i8042.
> > 
> 
> Try i8042.noacpi on the kernel command line
> 
> Seems Bjorn's patch needs to be reworked to ignore obviously broken BIOS 
> return values

Yup, how about this for a starter?  We may have to iterate on this as we
discover all the ways ACPI can be screwed up ;-)

This also falls back to the original scheme if ACPI is disabled on the
command line ("acpi=off").

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
