Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266656AbUFWUht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266656AbUFWUht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 16:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266660AbUFWUhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 16:37:48 -0400
Received: from bay16-f16.bay16.hotmail.com ([65.54.186.66]:64007 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266656AbUFWUhN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 16:37:13 -0400
X-Originating-IP: [206.20.64.234]
X-Originating-Email: [dinoklein@hotmail.com]
From: "Dino Klein" <dinoklein@hotmail.com>
To: raul@pleyades.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.7] Parallel port detection via ACPI
Date: Wed, 23 Jun 2004 17:36:27 -0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F16CSHwujCHXZ00000f2b@hotmail.com>
X-OriginalArrivalTime: 23 Jun 2004 20:36:27.0806 (UTC) FILETIME=[C23353E0:01C45961]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, here's an adaptation of the same crude patch to 2.4.26; I did not give 
it a try, but it does compile. let me know if it works properly.

--- linux-2.4.26-orig/drivers/parport/parport_pc.c      2003-06-13 
10:51:35.000000000 -0400
+++ linux-2.4.26/drivers/parport/parport_pc.c   2004-06-23 
16:33:03.959674872 -0400
@@ -53,6 +53,9 @@
#include <linux/slab.h>
#include <linux/pci.h>
#include <linux/sysctl.h>
+#include <linux/acpi.h>
+
+#include <acpi/acpi_bus.h>

#include <asm/io.h>
#include <asm/dma.h>
@@ -2916,6 +2919,91 @@
static int __init parport_pc_init_superio(int autoirq, int autodma) {return 
0;}
#endif /* CONFIG_PCI */

+struct parport_pc_resources
+{
+       int     io_lo;
+       int     io_hi;
+       int     irq;
+       int     dma;
+};
+
+
+
+/* Callback to process all the assigned resources to the parallel port 
device */
+static acpi_status acpi_parport_pc_resource(struct acpi_resource *res, void 
*data)
+{
+       struct parport_pc_resources *pcres = (struct parport_pc_resources *) 
data;
+       acpi_status status;
+
+
+       if (res->id == ACPI_RSTYPE_IO)
+       {
+               struct acpi_resource_io *io = (struct acpi_resource_io *) 
&res->data.io;
+               if (pcres->io_lo==0) pcres->io_lo = io->min_base_address;
+               else pcres->io_hi = io->min_base_address;
+       }
+       else if (res->id == ACPI_RSTYPE_IRQ)
+       {
+               struct acpi_resource_irq *irq = (struct acpi_resource_irq *) 
&res->data.irq;
+               pcres->irq = irq->interrupts[0];
+       }
+       else if (res->id == ACPI_RSTYPE_DMA)
+       {
+               struct acpi_resource_dma *dma = (struct acpi_resource_dma *) 
&res->data.dma;
+               pcres->dma = dma->channels[0];
+       }
+
+       return AE_OK;
+}
+
+
+static int acpi_parport_pc_add(struct acpi_device *device)
+{
+       acpi_status status;
+       struct parport_pc_resources pcres;
+       struct parport *pdata;
+
+
+       pcres.io_lo = 0;
+       pcres.io_hi = 0;
+       pcres.irq = PARPORT_IRQ_NONE;
+       pcres.dma = PARPORT_DMA_NONE;
+
+       status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+                                    acpi_parport_pc_resource, &pcres);
+       if (ACPI_FAILURE(status))
+               return -ENODEV;
+
+       printk("ACPI parport device with low IO 0x%X, high IO 0x%X, IRQ %d, 
DMA %d\n", pcres.io_lo, pcres.io_hi, pcres.irq, pcres.dma);
+       if (!(pdata = parport_pc_probe_port (pcres.io_lo, pcres.io_hi, 
pcres.irq, pcres.dma, NULL)))
+       {
+               printk("probe of ACPI parport device failed\n");
+               return -ENODEV;
+       }
+
+       acpi_driver_data(device) = pdata;
+       return 0;
+}
+
+static int acpi_parport_pc_remove(struct acpi_device *device, int type)
+{
+       struct parport *pdata = (struct parport *)acpi_driver_data(device);
+       parport_pc_unregister_port(pdata);
+       return 0;
+}
+
+
+static struct acpi_driver parport_pc_acpi_driver = {
+       .name =         "parport_pc",
+       .class =        "",
+       .ids =          "PNP0400, PNP0401",
+       .ops =  {
+               .add =          acpi_parport_pc_add,
+               .remove =       acpi_parport_pc_remove,
+       },
+};
+
+
/* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */
static int __init __attribute__((unused))
parport_pc_find_isa_ports (int autoirq, int autodma)
@@ -2952,10 +3040,14 @@
#endif

        /* Onboard SuperIO chipsets that show themselves on the PCI bus. */
+       /*
        count += parport_pc_init_superio (autoirq, autodma);
+       */

        /* ISA ports and whatever (see asm/parport.h). */
+       /*
        count += parport_pc_find_nonpci_ports (autoirq, autodma);
+       */

        r = pci_register_driver (&parport_pc_pci_driver);
        if (r >= 0) {
@@ -2963,6 +3055,13 @@
                count += r;
        }

+       r = acpi_bus_register_driver (&parport_pc_acpi_driver);
+       if (ACPI_SUCCESS(r))
+       {
+               registered_parport = 1;
+               /* should we increase count? */
+       }
+
        return count;
}

@@ -3060,10 +3159,15 @@
        }

        ret = !parport_pc_init (io, io_hi, irqval, dmaval);
+       /*
        if (ret && registered_parport)
                pci_unregister_driver (&parport_pc_pci_driver);

        return ret;
+       */
+
+       /* Do not fail if no port is found (perhaps one might be available 
through a docking station?) */
+       return 0;
}

void cleanup_module(void)
@@ -3072,7 +3176,10 @@
        struct parport *p = parport_enumerate(), *tmp;

        if (!user_specified)
+       {
                pci_unregister_driver (&parport_pc_pci_driver);
+               acpi_bus_unregister_driver(&parport_pc_acpi_driver);
+       }

        while (p) {
                tmp = p->next;





>From: DervishD <raul@pleyades.net>
>To: Dino Klein <dinoklein@hotmail.com>
>Subject: Re: [PATCH 2.6.7] Parallel port detection via ACPI
>Date: Tue, 22 Jun 2004 17:53:23 +0200
>
>     Hi Dino :)
>
>  * Dino Klein <dinoklein@hotmail.com> dixit:
> > I posted the following message on linux-parport at infradead.org; 
>however
> > the list seems to be inactive. Here it is again, for anyone interested.
>
>     I'm interested, and as soon as one of my linux machines is boot
>again I can test your patch (if the sysadmin allows me...).
>
>     I'm interested because I have a long standing problem with the
>parallel port, and it happens in all machines I have at hand. The
>problem is that, no matter how is configured the parallel port in the
>BIOS, Linux always says it is in SPP mode. No matter the motherboard,
>no matter the BIOS vendor, no matter anything. This is the dmesg
>output from one machine, the others are more or less the same:
>
>kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
>kernel: parport0: Printer, Lexmark International Lexmark Optra E312
>kernel: lp0: using parport0 (interrupt-driven).
>kernel: Trying to free free DMA3
>
>     Other times I have this other message:
>
>kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
>kernel: parport_pc: Via 686A parallel port: io=0x378
>kernel: lp0: using parport0 (polling).
>
>     Most of the machines have Lexmark printers attached, but I've
>tested with different printer brands and that doesn't make a
>difference.
>
>     All parallel ports are ECP & EPP capable. I contacted a time ago
>with the maintainers of the parport code, but I had only an answer,
>saying that I should put the ports in the BIOS as ECP or EPP, not as
>'ECP+EPP'. No problem, I did it and it didn't make a difference.
>
> > It utilizes the ACPI subsystem
> > to get the resources assigned to the port, and then passes them on
> > to the detection routine. I've verified that it is working on my
> > machine by cycling between the modes in the BIOS (spp, epp,
> > ecp+epp), and observing proper detection in the logs.
>
>     That's exactly what I want! My problem now is that I cannot use
>the parports in any mode different from SPP, and that is very slow,
>and if the printer hangs, breaks, turns off or whatever, the software
>doesn't notice and waits forever!
>
>     Abusing of you: is any way of, using the current code in 2.4.x,
>to make my parallel port work in ECP or EPP mode?
>
>     Thanks a lot in advance, and thanks for the patch :)
>
>     Raúl Núñez de Arenas Coronado
>
>--
>Linux Registered User 88736
>http://www.pleyades.net & http://raul.pleyades.net/

_________________________________________________________________
MSN Messenger: instale grátis e converse com seus amigos. 
http://messenger.msn.com.br

