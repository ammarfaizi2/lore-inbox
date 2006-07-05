Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbWGEWOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWGEWOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 18:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWGEWOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 18:14:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9388 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965024AbWGEWOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 18:14:39 -0400
Date: Wed, 5 Jul 2006 15:18:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: drzeus-list@drzeus.cx, len.brown@intel.com, linux-kernel@vger.kernel.org,
       ambx1@neo.rr.com, shaohua.li@intel.com, castet.matthieu@free.fr,
       linux-acpi@vger.kernel.org, uwe.bugla@gmx.de
Subject: Re: ACPIPNP and too large IO resources
Message-Id: <20060705151803.5841e91d.akpm@osdl.org>
In-Reply-To: <200607051536.30771.bjorn.helgaas@hp.com>
References: <44AB608F.1060903@drzeus.cx>
	<200607051047.40734.bjorn.helgaas@hp.com>
	<44AC26DA.1010901@drzeus.cx>
	<200607051536.30771.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>
> On Wednesday 05 July 2006 14:53, Pierre Ossman wrote:
> > Bjorn Helgaas wrote:
> > > It sounds like this might be the same problem as
> > >     http://bugzilla.kernel.org/show_bug.cgi?id=6292
> > >
> > > In short, you probably have a bridge device that consumes the
> > > entire 0x0-0xffff I/O port range and produces some or all of that
> > > range for downstream PNP devices.  PNP doesn't know what to do
> > > with these windows that are both consumed by the bridge and made
> > > available to downstream devices, so it just marks them as being
> > > already reserved.
> > 
> > Ah, that explains things.
> > 
> > > Matthieu Castet wrote a nice patch (attached) that makes PNP just
> > > ignore those windows.  Can you try it and see whether it fixes
> > > the problem you're seeing?  This patch is already in -mm, but not
> > > yet in mainline.  We might need to consider this patch as
> > > 2.6.18 material if it resolves your problem.  I suspect many
> > > people will see the same problem.
> > 
> > The patch works nicely and removes all memory and io regions for the PCI
> > bridge but for the range 0xcf8-0xcff.
> 
> Andrew, I think we should try again to push
> pnpacpi-reject-acpi_producer-resources.patch to the mainline.
> 
> Pierre's report (starts here: http://lkml.org/lkml/2006/7/5/20)
> is another instance of http://bugzilla.kernel.org/show_bug.cgi?id=6292.
> 
> I suspect that many PNP devices are broken in 2.6.17 because of
> this problem.  Probably the only reason we haven't seen more
> reports is that PNPACPI isn't turned on by default.  (Maybe
> we should do that in -mm?)
> 
> You recently proposed pushing it:
>     http://marc.theaimsgroup.com/?l=linux-acpi&m=115119275408021&w=2
> Len initially nacked it, but I think the outcome of the discussion
> is that Shaohua doesn't object to this patch.  He probably would
> still like to blacklist PNP0A03, but that's an additional step we
> don't have to take at the same time.
> 

OK, well let's please push this up the priority list and work out what want
to do.  If Len's now OK with merging it then I think all lights are green?

pnpacpi-reject-acpi_producer-resources.patch:

From: matthieu castet <castet.matthieu@free.fr>

A patch in -mm kernel correct the parsing of "address resources" of pnpacpi. 
Before we assumed it was memory only, but it could be also IO.

But this change show an hidden bug : some resources could be producer type
that are not handled by pnp layer.  So we should ignore the producer
resources.

This patch fixes bug 6292 (http://bugzilla.kernel.org/show_bug.cgi?id=6292).
Some devices like PNP0A03 have 0xd00-0xffff and 0x0-0xcf7 as IO producer 
resources.

Before correcting "address resources" parsing, it was seen as memory and was
harmless, because nobody tried to reserve this memory range as it should be
IO.

With the correction it become IO resources, and make failed all others device
that want to register IO in this range and use pnp layer (like a ISA sound
card).

The solution is to ignore producer resources

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
Signed-off-by: Uwe Bugla <uwe.bugla@gmx.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Adam Belay <ambx1@neo.rr.com>
Cc: "Brown, Len" <len.brown@intel.com>

akpm: previously nacked, as per comment #26.  But am hanging onto it until the
thing gets fixed for real.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pnp/pnpacpi/rsparser.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN drivers/pnp/pnpacpi/rsparser.c~pnpacpi-reject-acpi_producer-resources drivers/pnp/pnpacpi/rsparser.c
--- a/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-reject-acpi_producer-resources
+++ a/drivers/pnp/pnpacpi/rsparser.c
@@ -173,6 +173,9 @@ pnpacpi_parse_allocated_address_space(st
 		return;
 	}
 
+	if (p->producer_consumer == ACPI_PRODUCER)
+		return;
+
 	if (p->resource_type == ACPI_MEMORY_RANGE)
 		pnpacpi_parse_allocated_memresource(res_table,
 				p->minimum, p->address_length);
@@ -252,9 +255,14 @@ static acpi_status pnpacpi_allocated_res
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+		if (res->data.ext_address64.producer_consumer == ACPI_PRODUCER)
+			return AE_OK;
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		if (res->data.extended_irq.producer_consumer == ACPI_PRODUCER)
+			return AE_OK;
+
 		for (i = 0; i < res->data.extended_irq.interrupt_count; i++) {
 			pnpacpi_parse_allocated_irqresource(res_table,
 				res->data.extended_irq.interrupts[i],
_

