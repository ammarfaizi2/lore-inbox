Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUFVPZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUFVPZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbUFVPQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:16:18 -0400
Received: from bay16-f27.bay16.hotmail.com ([65.54.186.77]:35090 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264271AbUFVPFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:05:20 -0400
X-Originating-IP: [206.20.64.234]
X-Originating-Email: [dinoklein@hotmail.com]
From: "Dino Klein" <dinoklein@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.7] Parallel port detection via ACPI
Date: Tue, 22 Jun 2004 12:05:13 -0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F27S7RPMekG5000008ba9@hotmail.com>
X-OriginalArrivalTime: 22 Jun 2004 15:05:14.0116 (UTC) FILETIME=[52252440:01C4586A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
I posted the following message on linux-parport at infradead.org; however 
the list seems to be inactive. Here it is again, for anyone interested.


----------Original Message Below---------

From: "Dino Klein" <dinoklein@hotmail.com>
To: linux-parport@lists.infradead.org
Subject: [Linux-parport] [PATCH 2.6.7] Parallel port detection via ACPI
Date: Fri, 18 Jun 2004 16:46:21 -0300

Hi,
I've modified the parport_pc.c file to detect parallel ports via
ACPI; it is partially a cut & paste from the serial port (8250) acpi
code. It's kinda crude, but it works. It utilizes the ACPI subsystem
to get the resources assigned to the port, and then passes them on
to the detection routine. I've verified that it is working on my
machine by cycling between the modes in the BIOS (spp, epp,
ecp+epp), and observing proper detection in the logs.
I commented out the pnp & non-pci detection calls, since ACPI
replaces them. I also disabled the SuperIO detection, since it was
grabbing the parallel port before the ACPI detection kicked in on my
motherboard with a via686 southbridge.
Again, this is is kinda of crude, but I would really like to see
some parallel port detection via ACPI, so I won't have to manually
specify irq & dma. Perhaps there should be an option to choose
between PnP and ACPI, since there shouldn't be a reason to use both.

--- linux-2.6.7-orig/drivers/parport/parport_pc.c	2004-06-18
14:20:00.000000000 -0400
+++ linux-2.6.7/drivers/parport/parport_pc.c	2004-06-18
13:05:01.000000000 -0400
@@ -55,6 +55,9 @@
#include <linux/pci.h>
#include <linux/pnp.h>
#include <linux/sysctl.h>
+#include <linux/acpi.h>
+
+#include <acpi/acpi_bus.h>

#include <asm/io.h>
#include <asm/dma.h>
@@ -101,6 +104,7 @@
#endif
static int pci_registered_parport;
static int pnp_registered_parport;
+static int acpi_registered_parport;

/* frob_control, but for ECR */
static void frob_econtrol (struct parport *pb, unsigned char m,
@@ -2917,6 +2921,92 @@
};


+/* A stuct to help with resource allocation enumeration */
+struct parport_pc_resources
+{
+	int	io_lo;
+	int	io_hi;
+	int	irq;
+	int	dma;
+};
+
+
+
+/* Callback to process all the assigned resources to the parallel
port device */
+static acpi_status acpi_parport_pc_resource(struct acpi_resource
*res, void *data)
+{
+	struct parport_pc_resources *pcres = (struct parport_pc_resources
*) data;
+	acpi_status status;
+
+
+	if (res->id == ACPI_RSTYPE_IO)
+	{
+		struct acpi_resource_io *io = (struct acpi_resource_io *)
&res->data.io;
+		if (pcres->io_lo==0) pcres->io_lo = io->min_base_address;
+		else pcres->io_hi = io->min_base_address;
+	}
+	else if (res->id == ACPI_RSTYPE_IRQ)
+	{
+		struct acpi_resource_irq *irq = (struct acpi_resource_irq *)
&res->data.irq;
+		pcres->irq = irq->interrupts[0];
+	}
+	else if (res->id == ACPI_RSTYPE_DMA)
+	{
+		struct acpi_resource_dma *dma = (struct acpi_resource_dma *)
&res->data.dma;
+		pcres->dma = dma->channels[0];
+	}
+
+	return AE_OK;
+}
+
+
+static int acpi_parport_pc_add(struct acpi_device *device)
+{
+	acpi_status status;
+	struct parport_pc_resources pcres;
+	struct parport *pdata;
+
+
+	pcres.io_lo = 0;
+	pcres.io_hi = 0;
+	pcres.irq = PARPORT_IRQ_NONE;
+	pcres.dma = PARPORT_DMA_NONE;
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+				     acpi_parport_pc_resource, &pcres);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	printk("ACPI parport device with low IO 0x%X, high IO 0x%X, IRQ
%d, DMA %d\n", pcres.io_lo, pcres.io_hi, pcres.irq, pcres.dma);
+	if (!(pdata = parport_pc_probe_port (pcres.io_lo, pcres.io_hi,
pcres.irq, pcres.dma, NULL)))
+	{
+		printk("probe of ACPI parport device failed\n");
+		return -ENODEV;
+	}
+
+	acpi_driver_data(device) = pdata;
+	return 0;
+}
+
+static int acpi_parport_pc_remove(struct acpi_device *device, int
type)
+{
+	struct parport *pdata = (struct parport
*)acpi_driver_data(device);
+	parport_pc_unregister_port(pdata);
+	return 0;
+}
+
+
+static struct acpi_driver parport_pc_acpi_driver = {
+	.name =		"parport_pc",
+	.class =	"",
+	.ids =		"PNP0400, PNP0401",
+	.ops =	{
+		.add =		acpi_parport_pc_add,
+		.remove =	acpi_parport_pc_remove,
+	},
+};
+
+
/* This is called by parport_pc_find_nonpci_ports (in asm/parport.h)
*/
static int __init __attribute__((unused))
parport_pc_find_isa_ports (int autoirq, int autodma)
@@ -2953,9 +3043,12 @@
#endif

	/* Onboard SuperIO chipsets that show themselves on the PCI bus. */
+	/*
	count += parport_pc_init_superio (autoirq, autodma);
+	*/

	/* PnP ports, skip detection if SuperIO already found them */
+	/*
	if (!count) {
		r = pnp_register_driver (&parport_pc_pnp_driver);
		if (r >= 0) {
@@ -2963,9 +3056,12 @@
			count += r;
		}
	}
+	*/

	/* ISA ports and whatever (see asm/parport.h). */
+	/*
	count += parport_pc_find_nonpci_ports (autoirq, autodma);
+	*/

	r = pci_register_driver (&parport_pc_pci_driver);
	if (r >= 0) {
@@ -2973,6 +3069,13 @@
		count += r;
	}

+	r = acpi_bus_register_driver (&parport_pc_acpi_driver);
+	if (ACPI_SUCCESS(r))
+	{
+		acpi_registered_parport = 1;
+		/* should we increase count? */
+	}
+
	return count;
}

@@ -3190,6 +3293,8 @@
		pci_unregister_driver (&parport_pc_pci_driver);
	if (pnp_registered_parport)
		pnp_unregister_driver (&parport_pc_pnp_driver);
+	if (acpi_registered_parport)
+		acpi_bus_unregister_driver(&parport_pc_acpi_driver);

	spin_lock(&ports_lock);
	while (!list_empty(&ports_list)) {

_________________________________________________________________
MSN Messenger: instale grátis e converse com seus amigos. 
http://messenger.msn.com.br

