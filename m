Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTIVQAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTIVQAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:00:55 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:15066 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S263201AbTIVP7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:59:47 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] 2.6 ACPI serial discovery
Date: Mon, 22 Sep 2003 09:54:02 -0600
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200309220954.02713.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tweaks the 8250 ACPI namespace discovery to
	1) add support for UARTs in IO port space
	2) add support for non-extended IRQs
        3) use acpi_walk_resources() to simplify processing the
           _CRS data, and
        4) add error checking (ioremap failure, lack of MMIO
           address in _CRS).

This patch is against the current 2.6.0-test5 BK and has been
tested on ia64 and x86.

This is one step towards eliminating blind probing for devices
on ia64.  ACPI is supposed to tell us where legacy devices are;
why not use that information?

Bjorn

P.S.  The MAINTAINERS file in both 2.4 and 2.5 says
Ted Ts'o is the 8250/16?50 serial maintainer, but most
of the recent changes have your name on them.  Is the
file out of date?


===== drivers/serial/8250_acpi.c 1.2 vs edited =====
--- 1.2/drivers/serial/8250_acpi.c	Thu Sep  4 00:40:10 2003
+++ edited/drivers/serial/8250_acpi.c	Thu Sep 18 19:28:04 2003
@@ -18,19 +18,33 @@
 #include <asm/io.h>
 #include <asm/serial.h>
 
-static void acpi_serial_address(struct serial_struct *req,
-				struct acpi_resource_address32 *addr32)
+static acpi_status acpi_serial_mmio(struct serial_struct *req,
+				    struct acpi_resource_address64 *addr)
 {
 	unsigned long size;
 
-	size = addr32->max_address_range - addr32->min_address_range + 1;
-	req->iomap_base = addr32->min_address_range;
+	size = addr->max_address_range - addr->min_address_range + 1;
+	req->iomap_base = addr->min_address_range;
 	req->iomem_base = ioremap(req->iomap_base, size);
+	if (!req->iomem_base) {
+		printk("%s: couldn't ioremap 0x%lx-0x%lx\n", __FUNCTION__,
+			addr->min_address_range, addr->max_address_range);
+		return AE_ERROR;
+	}
 	req->io_type = SERIAL_IO_MEM;
+	return AE_OK;
+}
+
+static acpi_status acpi_serial_port(struct serial_struct *req,
+				    struct acpi_resource_io *io)
+{
+	req->port = io->min_base_address;
+	req->io_type = SERIAL_IO_PORT;
+	return AE_OK;
 }
 
-static void acpi_serial_irq(struct serial_struct *req,
-			    struct acpi_resource_ext_irq *ext_irq)
+static acpi_status acpi_serial_ext_irq(struct serial_struct *req,
+				       struct acpi_resource_ext_irq *ext_irq)
 {
 	if (ext_irq->number_of_interrupts > 0) {
 #ifdef CONFIG_IA64
@@ -40,45 +54,68 @@
 		req->irq = ext_irq->interrupts[0];
 #endif
 	}
+	return AE_OK;
+}
+
+static acpi_status acpi_serial_irq(struct serial_struct *req,
+				   struct acpi_resource_irq *irq)
+{
+	if (irq->number_of_interrupts > 0) {
+#ifdef CONFIG_IA64
+		req->irq = acpi_register_irq(irq->interrupts[0],
+	                  irq->active_high_low, irq->edge_level);
+#else
+		req->irq = irq->interrupts[0];
+#endif
+	}
+	return AE_OK;
+}
+
+static acpi_status acpi_serial_resource(struct acpi_resource *res, void *data)
+{
+	struct serial_struct *serial_req = (struct serial_struct *) data;
+	struct acpi_resource_address64 addr;
+	acpi_status status;
+
+	status = acpi_resource_to_address64(res, &addr);
+	if (ACPI_SUCCESS(status))
+		return acpi_serial_mmio(serial_req, &addr);
+	else if (res->id == ACPI_RSTYPE_IO)
+		return acpi_serial_port(serial_req, &res->data.io);
+	else if (res->id == ACPI_RSTYPE_EXT_IRQ)
+		return acpi_serial_ext_irq(serial_req, &res->data.extended_irq);
+	else if (res->id == ACPI_RSTYPE_IRQ)
+		return acpi_serial_irq(serial_req, &res->data.irq);
+	return AE_OK;
 }
 
 static int acpi_serial_add(struct acpi_device *device)
 {
-	acpi_status result;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status status;
 	struct serial_struct serial_req;
-	int line, offset = 0;
+	int line;
 
 	memset(&serial_req, 0, sizeof(serial_req));
-	result = acpi_get_current_resources(device->handle, &buffer);
-	if (ACPI_FAILURE(result)) {
-		result = -ENODEV;
-		goto out;
-	}
 
-	while (offset <= buffer.length) {
-		struct acpi_resource *res = buffer.pointer + offset;
-		if (res->length == 0)
-			break;
-		offset += res->length;
-		if (res->id == ACPI_RSTYPE_ADDRESS32) {
-			acpi_serial_address(&serial_req, &res->data.address32);
-		} else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
-			acpi_serial_irq(&serial_req, &res->data.extended_irq);
-		}
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+				     acpi_serial_resource, &serial_req);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	if (!serial_req.iomem_base && !serial_req.port) {
+		printk("%s: no iomem or port address in %s _CRS\n", __FUNCTION__,
+			device->pnp.bus_id);
+		return -ENODEV;
 	}
 
 	serial_req.baud_base = BASE_BAUD;
 	serial_req.flags = ASYNC_SKIP_TEST|ASYNC_BOOT_AUTOCONF|ASYNC_AUTO_IRQ;
 
-	result = 0;
 	line = register_serial(&serial_req);
 	if (line < 0)
-		result = -ENODEV;
+		return -ENODEV;
 
- out:
-	acpi_os_free(buffer.pointer);
-	return result;
+	return 0;
 }
 
 static int acpi_serial_remove(struct acpi_device *device, int type)

