Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTE2R7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTE2R7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:59:15 -0400
Received: from fmr02.intel.com ([192.55.52.25]:32225 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262465AbTE2R7N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:59:13 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
Date: Thu, 29 May 2003 11:12:18 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502413624E@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC Proposal to enable MSI support in Linux kernel
Thread-Index: AcMlbfBELuwWxvgpSsiyShQt6/BKIgAnrXtw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>, "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 May 2003 18:12:19.0177 (UTC) FILETIME=[D7B30590:01C3260D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on an updated patch to 2.5.70 to incorporate the comments from you and Jeff Garzik. Regarding the variable renaming of irq, I am open to any suggestions. Please make a recommendation and I will incorporate it into the next update.  Regarding platform_legacy_irq, I have not seen an edge-triggered interrupt failure caused by platform_legacy_irq.

           CPU0       CPU1       
  0:     380044          0    IO-APIC-edge  timer
  1:        590          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
 12:        715          0    IO-APIC-edge  i8042
 14:       7902          0    IO-APIC-edge  ide0
 15:          2          0    IO-APIC-edge  ide1
169:          0          0   IO-APIC-level  uhci-hcd
185:          0          0   IO-APIC-level  uhci-hcd
193:         84          0   IO-APIC-level  aic79xx
201:         30          0   IO-APIC-level  aic79xx
225:         16          0   IO-APIC-level  aic7xxx
233:         16          0   IO-APIC-level  aic7xxx
NMI:          0          0 
LOC:     379962     380218 
ERR:          0
MIS:          0

Thanks,
Tom

-----Original Message-----
From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
Sent: Wednesday, May 28, 2003 4:06 PM
To: Jeff Garzik
Cc: Nguyen, Tom L; Nakajima, Jun; linux-kernel@vger.kernel.org; Saxena,
Sunil; Mallick, Asit K; Carbonari, Steven
Subject: Re: RFC Proposal to enable MSI support in Linux kernel


On Wed, 28 May 2003, Jeff Garzik wrote:

> > +#ifdef CONFIG_PCI_USE_VECTOR
> > +	for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
> > +#else
> >  	for (i = 0; i < NR_IRQS; i++) {
> > +#endif
> 
> This ifdef isn't necessary.  ifdef in a header somewhere.  For example, 
> make NR_IRQS (or some other constant, if changing NR_IRQS definition 
> isn't ok) condition on the CONFIG_xxx options.

Actually we can simply use;

for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
	vector = ...
	if (i >= NR_IRQS)
		break;
	...
	set_intr_gate(vector, interrupt[i]);
}

> split into two functions, maybe?  (due to the ifdef)  Your call, it's 
> mainly a programmer preference.

I agree.

> A bigger question though:  if platform_legacy_irq() returns zero, will 
> the handler _ever_ be edge-triggered?

Good question, i wouldn't think so, that would collapse that section into 
two lines.

> As I see more and more of these ifdefs, I wonder if they couldn't be 
> hidden inside wrappers?

Yes some of them are a bit easy to botch up later on.. like the following 
excerpt.

> > +#ifdef CONFIG_PCI_USE_VECTOR
> > +			if (!platform_legacy_irq(irq))
> > +				entry->irq = IO_APIC_VECTOR(irq);
> > +			else
> > +#endif
> >  			entry->irq = irq;
> >  			continue;

Thanks,
	Zwane
-- 
function.linuxpower.ca
