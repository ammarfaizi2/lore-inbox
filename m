Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWGEQrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWGEQrq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWGEQrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:47:46 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:970 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S964875AbWGEQrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:47:46 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: ACPIPNP and too large IO resources
Date: Wed, 5 Jul 2006 10:47:40 -0600
User-Agent: KMail/1.8.3
Cc: Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
References: <44AB608F.1060903@drzeus.cx>
In-Reply-To: <44AB608F.1060903@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607051047.40734.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 July 2006 00:47, Pierre Ossman wrote:
> Commit 1acfb7f2b0d460ee86bdb25ad0679070ec8a5f0d by Bjorn is causing me
> some grief. Although the patch seems correct, it is triggering another
> misfeature of the system and I am hoping you have a solution.
> 
> Before your patch, the PCI bridge didn't allocate many io ports as they
> were mislabeled as iomem. But now it puts its dirty paws all over the
> entire ISA io port address space, effectively disabling PNP.
> 
> On my machine it steals the ranges 0x0-0xcf7, 0xcf8-0xcff and
> 0xd00-0xffff. IOW, the entire range of 0x0-0xffff gets blocked and none
> of the ISA PNP devices can use ports outside this range.

Thanks for the report!

It sounds like this might be the same problem as
    http://bugzilla.kernel.org/show_bug.cgi?id=6292

In short, you probably have a bridge device that consumes the
entire 0x0-0xffff I/O port range and produces some or all of that
range for downstream PNP devices.  PNP doesn't know what to do
with these windows that are both consumed by the bridge and made
available to downstream devices, so it just marks them as being
already reserved.

Matthieu Castet wrote a nice patch (attached) that makes PNP just
ignore those windows.  Can you try it and see whether it fixes
the problem you're seeing?  This patch is already in -mm, but not
yet in mainline.  We might need to consider this patch as
2.6.18 material if it resolves your problem.  I suspect many
people will see the same problem.

If it doesn't fix the problem, could I trouble you to open a
report at http://bugzilla.kernel.org and assign it to me?  If
you could attach the dmesg log and the output of "for i in
/sys/bus/pnp/devices/*; do echo $i; cat $i/id; cat $i/resources;
cat $i/options; done", that would be useful.

Thanks,
  Bjorn


Index: linux-2.6.16/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- linux-2.6.16.orig/drivers/pnp/pnpacpi/rsparser.c	2006-06-10 23:00:34.000000000 +0200
+++ linux-2.6.16/drivers/pnp/pnpacpi/rsparser.c	2006-06-10 23:08:52.114104816 +0200
@@ -170,6 +170,9 @@
 		return;
 	}
 
+    if (p->producer_consumer == ACPI_PRODUCER)
+        return;
+
 	if (p->resource_type == ACPI_MEMORY_RANGE)
 		pnpacpi_parse_allocated_memresource(res_table,
 				p->minimum, p->address_length);
@@ -248,9 +251,14 @@
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+        if (res->data.ext_address64.producer_consumer == ACPI_PRODUCER)
+            return AE_OK;
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+        if (res->data.extended_irq.producer_consumer == ACPI_PRODUCER)
+            return AE_OK;
+
 		for (i = 0; i < res->data.extended_irq.interrupt_count; i++) {
 			pnpacpi_parse_allocated_irqresource(res_table,
 				res->data.extended_irq.interrupts[i],
