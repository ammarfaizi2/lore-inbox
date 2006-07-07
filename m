Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWGGBGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWGGBGG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 21:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWGGBGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 21:06:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:10353 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751123AbWGGBGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 21:06:03 -0400
X-IronPort-AV: i="4.06,215,1149490800"; 
   d="scan'208"; a="61644285:sNHT799542163"
Subject: Re: ACPIPNP and too large IO resources
From: Shaohua Li <shaohua.li@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, drzeus-list@drzeus.cx,
       "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       ambx1@neo.rr.com, castet.matthieu@free.fr, linux-acpi@vger.kernel.org,
       uwe.bugla@gmx.de
In-Reply-To: <200607060929.04787.bjorn.helgaas@hp.com>
References: <44AB608F.1060903@drzeus.cx>
	 <200607051536.30771.bjorn.helgaas@hp.com>
	 <20060705151803.5841e91d.akpm@osdl.org>
	 <200607060929.04787.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 09:03:09 +0800
Message-Id: <1152234189.21189.139.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 23:29 +0800, Bjorn Helgaas wrote:
> On Wednesday 05 July 2006 16:18, Andrew Morton wrote: 
> > Bjorn Helgaas <bjorn.helgaas@hp.com> wrote: 
> > > You recently proposed pushing it: 
> > >
> http://marc.theaimsgroup.com/?l=linux-acpi&m=115119275408021&w=2 
> > > Len initially nacked it, but I think the outcome of the
> discussion 
> > > is that Shaohua doesn't object to this patch.  He probably would 
> > > still like to blacklist PNP0A03, but that's an additional step we 
> > > don't have to take at the same time. 
> >  
> > OK, well let's please push this up the priority list and work out
> what want 
> > to do.  If Len's now OK with merging it then I think all lights are
> green?
> 
> My opinion is that we don't need to blacklist PNP0A03 unless 
> we discover a problem.  
> 
> Len, Shaohua, can you ack this?
Sure. Please merge the patch Bjorn pointed out.

Thanks,
Shaohua

> 
> > pnpacpi-reject-acpi_producer-resources.patch: 
> >  
> > From: matthieu castet <castet.matthieu@free.fr> 
> >  
> > A patch in -mm kernel correct the parsing of "address resources" of
> pnpacpi.  
> > Before we assumed it was memory only, but it could be also IO. 
> >  
> > But this change show an hidden bug : some resources could be
> producer type 
> > that are not handled by pnp layer.  So we should ignore the
> producer 
> > resources. 
> >  
> > This patch fixes bug 6292
> (http://bugzilla.kernel.org/show_bug.cgi?id=6292). 
> > Some devices like PNP0A03 have 0xd00-0xffff and 0x0-0xcf7 as IO
> producer  
> > resources. 
> >  
> > Before correcting "address resources" parsing, it was seen as memory
> and was 
> > harmless, because nobody tried to reserve this memory range as it
> should be 
> > IO. 
> >  
> > With the correction it become IO resources, and make failed all
> others device 
> > that want to register IO in this range and use pnp layer (like a ISA
> sound 
> > card). 
> >  
> > The solution is to ignore producer resources 
> >  
> > Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr> 
> > Signed-off-by: Uwe Bugla <uwe.bugla@gmx.de> 
> > Cc: Bjorn Helgaas <bjorn.helgaas@hp.com> 
> > Cc: Adam Belay <ambx1@neo.rr.com> 
> > Cc: "Brown, Len" <len.brown@intel.com> 
> >  
> > akpm: previously nacked, as per comment #26.  But am hanging onto it
> until the 
> > thing gets fixed for real. 
> >  
> > Signed-off-by: Andrew Morton <akpm@osdl.org> 
> > --- 
> >  
> >  drivers/pnp/pnpacpi/rsparser.c |    8 ++++++++ 
> >  1 file changed, 8 insertions(+) 
> >  
> > diff -puN
> drivers/pnp/pnpacpi/rsparser.c~pnpacpi-reject-acpi_producer-resources
> drivers/pnp/pnpacpi/rsparser.c 
> > ---
> a/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-reject-acpi_producer-resources 
> > +++ a/drivers/pnp/pnpacpi/rsparser.c 
> > @@ -173,6 +173,9 @@ pnpacpi_parse_allocated_address_space(st 
> >               return; 
> >       } 
> >   
> > +     if (p->producer_consumer == ACPI_PRODUCER) 
> > +             return; 
> > + 
> >       if (p->resource_type == ACPI_MEMORY_RANGE) 
> >               pnpacpi_parse_allocated_memresource(res_table, 
> >                               p->minimum, p->address_length); 
> > @@ -252,9 +255,14 @@ static acpi_status pnpacpi_allocated_res 
> >               break; 
> >   
> >       case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64: 
> > +             if (res->data.ext_address64.producer_consumer ==
> ACPI_PRODUCER) 
> > +                     return AE_OK; 
> >               break; 
> >   
> >       case ACPI_RESOURCE_TYPE_EXTENDED_IRQ: 
> > +             if (res->data.extended_irq.producer_consumer ==
> ACPI_PRODUCER) 
> > +                     return AE_OK; 
> > + 
> >               for (i = 0; i <
> res->data.extended_irq.interrupt_count; i++) { 
> >
> pnpacpi_parse_allocated_irqresource(res_table, 
> >                               res->data.extended_irq.interrupts[i], 
> > _ 
> >  
> > - 
> > To unsubscribe from this list: send the line "unsubscribe
> linux-acpi" in 
> > the body of a message to majordomo@vger.kernel.org 
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html 
> > 
> 
