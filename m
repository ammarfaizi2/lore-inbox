Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268420AbUIQFT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268420AbUIQFT3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 01:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUIQFT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 01:19:28 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:20229 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S268420AbUIQFTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 01:19:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.9-rc2-mm1
Date: Fri, 17 Sep 2004 00:18:59 -0500
Message-ID: <452548B29F0CCE48B8ABB094307EBA1C0651E9A9@USRV-EXCH2.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.9-rc2-mm1
Thread-Index: AcScE/5r7uMJWweJRki51lnh9LGdZwAArS1g
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Jesse Barnes" <jbarnes@engr.sgi.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <len.brown@intel.com>
X-OriginalArrivalTime: 17 Sep 2004 05:19:00.0890 (UTC) FILETIME=[D73507A0:01C49C75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thursday 16 September 2004 11:14 am, Jesse Barnes wrote:
> > On Thursday, September 16, 2004 2:40 am, Andrew Morton wrote:
> >  bk-acpi.patch
> >
> > Looks like some changes in this patch break sn2.  In particular,
this 
> > hunk in
> > acpi_pci_irq_enable():
> >
> > -               if (dev->irq && (dev->irq <= 0xF)) {
> > +               if (dev->irq >= 0 && (dev->irq <= 0xF)) {
> >                        printk(" - using IRQ %d\n", dev->irq);
> >                        return_VALUE(dev->irq);
> >                }
> >                else {
> >                        printk("\n");
> > -                       return_VALUE(0);
> > +                       return_VALUE(-EINVAL);
> >                }
> > 
> > Now instead of returning 0, we'll get -EINVAL when a driver calls 
> > pci_enable_device.  This is arguably correct since there's no _PRT 
> > entry (and in fact no ACPI namespace on sn2), but shouldn't the code

> > above be looking at the 'pin' value instead of dev->irq?  The sn2 
> > specific PCI code sets up each
> > dev->irq long before this with the correct values...
>
> I think the change above is actually from
>    incorrect-pci-interrupt-assignment-on-es7000-for-pin-zero.patch

> of which I am officially ignorant :-)

I realize now that this is very involved piece of code and a lot was
built around the assumption that IRQ0 is a timer interrupt (pin 0 is for
PCI on ES7000), and assumption that everyone honors this assumption :)
However, it seems wrong that we are not able to read literally what ACPI
says, such as irq 0 for INTA. Maybe, it would be better if the code
above was returing an error code, not an irq, which is returned in dev
anyway. It should be some creative way to resolve this issue... I think
the idea in the comment above by Jesse Barnes has good potential.  

Thanks,
--Natalie

