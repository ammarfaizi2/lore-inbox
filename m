Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVG0QyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVG0QyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 12:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVG0Qw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 12:52:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64417 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261302AbVG0Quo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 12:50:44 -0400
Date: Wed, 27 Jul 2005 12:48:33 -0400
From: Dave Jones <davej@redhat.com>
To: Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Aleksey Gorelov <Aleksey_Gorelov@phoenix.com>
Subject: Re: [PATCH] Fix incorrect Asus k7m irq router detection
Message-ID: <20050727164833.GB20938@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>,
	Greg KH <greg@kroah.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org,
	Aleksey Gorelov <Aleksey_Gorelov@phoenix.com>
References: <200507271016.30447.giancarlo.formicuccia@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507271016.30447.giancarlo.formicuccia@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 10:16:30AM +0200, Giancarlo Formicuccia wrote:

 > this patch:
 > http://marc.theaimsgroup.com/?l=bk-commits-head&m=111955644929114&w=2
 > uncovered a k7m bios bug, where the VT82C686A router is reported as
 > being "586-compatible". The two chips have different pirq mapping, so
 > this leads to "irq routing conflict" on many pci devices.
 > 
 > The suggested fix was discussed with Aleksey Gorelov, who helped me
 > to identify the problem as a probable bios bug.
 > 
 > Patch for 2.6.13-git4.
 > 
 > Signed-off-by: Giancarlo Formicuccia <giancarlo.formicuccia@gmail.com>
 > 
 > --- linux-2.6.13-rc3-git4/arch/i386/pci/irq.c.org	2005-07-27 08:58:05.000000000 +0200
 > +++ linux-2.6.13-rc3-git4/arch/i386/pci/irq.c	2005-07-27 08:59:29.000000000 +0200
 > @@ -550,6 +550,13 @@
 >  static __init int via_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 >  {
 >  	/* FIXME: We should move some of the quirk fixup stuff here */
 > +
 > +	if (router->device == PCI_DEVICE_ID_VIA_82C686 &&
 > +			device == PCI_DEVICE_ID_VIA_82C586_0) {
 > +		/* Asus k7m bios wrongly reports 82C686A as 586-compatible */
 > +		device = PCI_DEVICE_ID_VIA_82C686;
 > +	}
 > +
 >  	switch(device)
 >  	{
 >  		case PCI_DEVICE_ID_VIA_82C586_0:

If this really is a problem with that board, it should have a DMI entry
for that board alone, not for every VIA chipset that uses the 586/686 combo,
as I'm fairly certain there are some that legitimately use this combination,
and the patch above will force them all to be reported as 82C686's.

		Dave
