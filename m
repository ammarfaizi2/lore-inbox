Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWDEQLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWDEQLa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 12:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWDEQLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 12:11:30 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:5296 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751132AbWDEQL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 12:11:29 -0400
Subject: Re: [PATCH] kexec on ia64
From: Khalid Aziz <khalid_aziz@hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux ia64 <linux-ia64@vger.kernel.org>
In-Reply-To: <20060403212049.480ad388.akpm@osdl.org>
References: <1144102818.8279.6.camel@localhost.localdomain>
	 <20060403212049.480ad388.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 10:11:27 -0600
Message-Id: <1144253487.16025.21.camel@lyra.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 21:20 -0700, Andrew Morton wrote:
> Khalid Aziz <khalid_aziz@hp.com> wrote:
> >
> > Add kexec support on ia64.
> > 
> 
> Neat.  How well does it work?

Works well on my test machines - HP rx2600 and HP cx2600. Hopefully
others can test it on other machines.

> > +/*
> > + * Terminate any outstanding interrupts
> > + */
> > +void terminate_irqs(void)
> > +{
> > +	struct irqaction * action;
> > +	irq_desc_t *idesc;
> > +	int i;
> > +
> > +	for (i=0; i<NR_IRQS; i++) {
> 
> 	for (i = 0; i < NR_IRQS; i++) {
> 
> > +		idesc = irq_descp(i);
> > +		action = idesc->action;
> > +		if (!action)
> > +			continue;
> > +		if (idesc->handler->end)
> > +			idesc->handler->end(i);
> > +	}
> > +}
> 
> Could we have a bit more description of what this function does, and why we
> need it?
> 
> Should other kexec-using architectures be using this?  If not, why does
> ia64 need it?
> 
> Thanks.

This funtion terminates any outstanding interrupts. I found it to be
necessary for devices that use level interrupt. If a device, using level
interrupt, asserted its interrupt as kernel goes into panic, nobody
acknowledges its interrupt. As a result, this interrupt stays asserted
as the new kernel comes up. All drivers in their initialization routine
should clear any pending interrupts, but most do not. As a result, when
driver attempts to use the interrupt, it is unable to since the
interrupt was already asserted and any new interrupts from the device
simply cause interrupt line to continue to be asserted. terminate_irqs()
tries to acknowledge any pending interrupts so the interrupts will be
usable when the new kernel comes up. This is not specific to ia64 and I
would think this problem would show up on other architectures as well. I
happened to find it on ia64 because HP rx2600 uses level interrupts for
SCSI controller.

--
Khalid
 
====================================================================
Khalid Aziz                       Open Source and Linux Organization
(970)898-9214                                        Hewlett-Packard
khalid.aziz@hp.com                                  Fort Collins, CO

"The Linux kernel is subject to relentless development" 
                                - Alessandro Rubini


