Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWIGLns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWIGLns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWIGLns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:43:48 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:13549 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1750843AbWIGLnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:43:47 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: [NEW PATCH] VIA IRQ quirk behaviour change
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Stian Jordet <liste@jordet.net>,
       akpm@osdl.org, jeff@garzik.org, greg@kroah.com, cw@f00f.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru
In-Reply-To: <44FF9656.1020309@gentoo.org>
References: <20060906020429.6ECE67B40A0@zog.reactivated.net>
	 <44FE8EBA.4060104@jordet.net>  <44FCE36D.4000708@gentoo.org>
	 <1157557765.5091.1.camel@localhost.localdomain>
	 <44FF5E90.9030808@gentoo.org> <1157594442.4700.9.camel@localhost.portugal>
	 <44FF9656.1020309@gentoo.org>
Content-Type: text/plain; charset=utf-8
Date: Thu, 07 Sep 2006 12:43:56 +0100
Message-Id: <1157629436.2369.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
Sorry for the empty email before 

On Wed, 2006-09-06 at 23:47 -0400, Daniel Drake wrote:
> > http://bugzilla.kernel.org/show_bug.cgi?id=6419#c19
> 
> Where's the patch?

on kernel 2.6.18-rc4 and
« Here is a patch which should fix the "host controller process error"  
problem:
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=115435540308759&w=2

Alan Stern »



> This report seems to be inconclusive. Your USB problem (comment #19)
> was 
> clearly something to do with UHCI itself, whereas Stian's problem is 
> much more generic and outside the control of the USB HCD: nobody cared
> Plus the only issue related to IRQ routing on that bug is triggered
> by 
> the closed nvidia driver...
> 
> > About Linus patch I have to correct me about what I had write,
> > http://lkml.org/lkml/2005/9/27/113
> > «(it used to say "if we have an IO-APIC, don't do this" (my patch),
> now
> > it says "if this irq is bound to an IO-APIC, don't do this")»
> > Or my patch or the Linus patch, not both.
> 
> Sorry, I can't figure out what you are trying to say here. Can you 
> rephrase it?

the statment was write by Linus on http://lkml.org/lkml/2005/9/27/113
my patch don't quirk any device if we are working on IO-APIC,
Linus simply know if a interrupt is > 15 we are working on IO-APIC and
just don't quirk irq > 15 

> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c 
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -546,7 +546,10 @@ static void quirk_via_irq(struct pci_dev
> >  {
> >       u8 irq, new_irq;
> >  
> > -     new_irq = dev->irq & 0xf;
> > +     new_irq = dev->irq;
> > +     if (!new_irq || new_irq >= 15)
> > +             return;
> > +
> >       pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> >       if (new_irq != irq) {
> > 
> > but I look to this Linus patch and I see 2 bugs
> > one should be > not >=
> 
> I think you might be right here. Firstly IRQ 15 is a legacy IRQ, 
> secondly the existing "&15" thing has no effect on IRQ 15 obviously.
> 
> > and new_irq after tests new_irq should be dev->irq & 0xf;
> > like this:
> > -     new_irq = dev->irq & 0xf;
> > +     new_irq = dev->irq;
> > +     if (!new_irq || new_irq > 15)
> > +             return;
> > +     new_irq = dev->irq & 0xf;
> >       pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> >       if (new_irq != irq) {
> 
> No, there is no bug, think about the logic:
> 
> We bail out if dev->irq is higher than 15. Therefore when we get to
> the 
> lines of code in question, dev->irq is 15 or less. Performing a
> logical 
> AND operation with the value 15 (0xf) is going to have no effect at
> all.
> 
ok
Thanks,


