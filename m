Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268504AbUIGUTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268504AbUIGUTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268346AbUIGUTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:19:05 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:10429 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S268534AbUIGUEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:04:04 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Paul Fulghum <paulkf@microgate.com>
Subject: Re: [PATCH] ACPI-based i8042 keyboard/aux controller enumeration
Date: Tue, 7 Sep 2004 14:03:58 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <1094585860.2506.15.camel@deimos.microgate.com>
In-Reply-To: <1094585860.2506.15.camel@deimos.microgate.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409071403.58198.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 September 2004 1:37 pm, Paul Fulghum wrote:
> > This can be disabled with "i8042.no_acpi=1".
> > If you need to disable
> > it, please let me know so I can fix it.
> 
> I have an HP Netserver LC3 that requires i8042.noacpi=1
> in order to work with 2.6.9-rc1-mm4

Thanks for the report.  Figures that it would be an HP machine ;-)
Can you apply the following patch on top of 2.6.9-rc1-mm4, boot
with "i8042.lsacpi", and post the resulting dmesg?

There are a zillion PNP IDs for keyboards and mice, but we're
currently only looking for PNP0303 and PNP0F13, which seem to be
fairly generic.  I suspect that the LC3 may be using one of the
more obscure PNP IDs.

--- 2.6.9-rc1-mm4/drivers/input/serio/i8042.c.orig	2004-09-07 13:40:13.000000000 -0600
+++ 2.6.9-rc1-mm4/drivers/input/serio/i8042.c	2004-09-07 13:42:38.000000000 -0600
@@ -62,6 +62,10 @@
 static int i8042_noacpi;
 module_param_named(noacpi, i8042_noacpi, bool, 0);
 MODULE_PARM_DESC(noacpi, "Do not use ACPI to detect controller settings");
+
+static int i8042_lsacpi;
+module_param_named(lsacpi, i8042_lsacpi, bool, 0);
+MODULE_PARM_DESC(lsacpi, "List PNP IDs of all ACPI devices (debug only)");
 #endif
 
 __obsolete_setup("i8042_noaux");
--- 2.6.9-rc1-mm4/drivers/input/serio/i8042-x86ia64io.h.orig	2004-09-07 13:43:19.000000000 -0600
+++ 2.6.9-rc1-mm4/drivers/input/serio/i8042-x86ia64io.h	2004-09-07 13:50:22.000000000 -0600
@@ -112,6 +112,8 @@
 		case ACPI_RSTYPE_IO:
 			io = &res->data.io;
 			if (io->range_length) {
+				if (i8042_lsacpi)
+					printk("  io  0x%x (size 0x%x)\n", io->min_base_address, io->range_length);
 				if (!i8042_res->port1)
 					i8042_res->port1 = io->min_base_address;
 				else
@@ -121,20 +123,26 @@
 
 		case ACPI_RSTYPE_IRQ:
 			irq = &res->data.irq;
-			if (irq->number_of_interrupts > 0)
+			if (irq->number_of_interrupts > 0) {
 				i8042_res->irq =
 					acpi_register_gsi(irq->interrupts[0],
 							  irq->edge_level,
 							  irq->active_high_low);
+				if (i8042_lsacpi)
+					printk("  gsi %d -> irq %d\n", irq->interrupts[0], i8042_res->irq);
+			}
 			break;
 
 		case ACPI_RSTYPE_EXT_IRQ:
 			ext_irq = &res->data.extended_irq;
-			if (ext_irq->number_of_interrupts > 0)
+			if (ext_irq->number_of_interrupts > 0) {
 				i8042_res->irq =
 					acpi_register_gsi(ext_irq->interrupts[0],
 							  ext_irq->edge_level,
 							  ext_irq->active_high_low);
+				if (i8042_lsacpi)
+					printk("  gsi %d -> irq %d\n", ext_irq->interrupts[0], i8042_res->irq);
+			}
 			break;
 	}
 	return AE_OK;
@@ -197,10 +205,46 @@
 	},
 };
 
+static acpi_status acpi_list_device(acpi_handle handle, u32 level, void *context, void **retval)
+{
+	acpi_status status;
+	struct acpi_buffer buffer;
+	struct acpi_device_info *dev_info;
+	struct acpi_compatible_id_list *cid_list;
+	struct i8042_acpi_resources i8042;
+	int i;
+
+	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+	status = acpi_get_object_info(handle, &buffer);
+	if (ACPI_FAILURE(status))
+		return AE_OK;
+
+	dev_info = buffer.pointer;
+	if (!dev_info->hardware_id.value[0])
+		return AE_OK;
+
+	printk("HID %s", dev_info->hardware_id.value);
+	cid_list = &dev_info->compatibility_id;
+	if (cid_list->count) {
+		printk(" CID");
+		for (i = 0; i < cid_list->count; i++)
+			printk(" %s", cid_list->id[i].value);
+	}
+	printk("\n");
+
+	acpi_walk_resources(handle, METHOD_NAME__CRS,
+		i8042_acpi_parse_resource, &i8042);
+
+	return AE_OK;
+}
+
 static int i8042_acpi_init(void)
 {
 	int result;
 
+	if (i8042_lsacpi)
+		acpi_get_devices(NULL, acpi_list_device, NULL, NULL);
+
 	if (i8042_noacpi) {
 		printk("i8042: ACPI detection disabled\n");
 		return 0;
