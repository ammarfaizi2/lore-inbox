Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVDSRtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVDSRtP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 13:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVDSRtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 13:49:14 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:14791 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261475AbVDSRtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 13:49:03 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: [Bug] invalid mac address after rebooting (2.6.12-rc2-mm2)
Date: Tue, 19 Apr 2005 19:47:38 +0200
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, Jeff Garzik <jgarzik@pobox.com>
References: <20050323122423.GA24316@faui00u.informatik.uni-erlangen.de> <200504172226.44173.daniel.ritz@gmx.ch> <20050418221951.GA18641@faui00o.informatik.uni-erlangen.de>
In-Reply-To: <20050418221951.GA18641@faui00o.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504191947.38500.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 April 2005 00:19, Peter Baumann wrote:
> On Sun, Apr 17, 2005 at 10:26:43PM +0200, Daniel Ritz wrote:
> > from your dmesg:
> > PCI: 0000:00:0b.0 pmc: 7601, current_state, pmcsr: 000000040, new: 0000
> > ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
> > 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> > 0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xac00. Vers LK1.1.19
> > PCI: 0000:00:0b.0 pmc: 7601, current_state, pmcsr: 000000000000, new: 0003
> > 
> > so the device is sent to D3 right after it is up. nice.
> > 
> > and second boot:
> > PCI: 0000:00:0b.0 pmc: 7601, current_state, pmcsr: 000000040, new: 0000
> > PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
> > ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
> > 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> > 0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
> > PCI: Setting latency timer of device 0000:00:0b.0 to 64
> > *** EEPROM MAC address is invalid.
> > 3c59x: vortex_probe1 fails.  Returns -22
> > 3c59x: probe of 0000:00:0b.0 failed with error -22
> > 
> > to me it looks like during the second boot the device is in D3 and has
> > troubles coming out of it. unfortunatley that is not made visible by the
> > debugging patch. a hexdump of the device in a second boot without
> > loading the 3c59x driver would tell us...
> > 
> > the diff in the hexdumps of the config space proves that the device
> > is programmed wrong:
> > --- hexdump-2.6.12-rc2-mm3-withdebugpatch_1.txt 2005-04-17 21:27:28.000000000 +0200
> > +++ hexdump-2.6.12-rc2-mm3-withdebugpatch_2.txt 2005-04-17 21:27:32.000000000 +0200
> > @@ -1,7 +1,7 @@
> > -0000000 10b7 9055 0007 0210 0024 0200 2008 0000
> > -0000010 ac01 0000 2000 e800 0000 0000 0000 0000
> > +0000000 10b7 9055 0003 0210 0024 0200 4000 0000
> > +0000010 0001 0000 0000 0000 0000 0000 0000 0000
> > 
> > so the I/O ports and the iomem are not set!
> > 
> >  0000020 0000 0000 0000 0000 0000 0000 10b7 9055
> > -0000030 0000 0000 00dc 0000 0000 0000 010a 0a0a
> > +0000030 0000 0000 00dc 0000 0000 0000 0100 0a0a
> >  0000040 0000 0000 0000 0000 0000 0000 0000 0000
> >  0000050 0000 0000 0040 0000 0000 0000 0000 0000
> >  0000060 0000 0000 0000 0000 0000 0000 0000 0000
> > 
> > but to make it short: i think it's a driver bug. the device doesn't seem to be
> > correctly reprogrammed when it is in D3 initially. and then it shouldn't be
> > put into D3 during the first boot. so please try with the attached patch.
> > 
> > rgds
> > -daniel
> > 
> > PS: does somebody have a datasheet of a 3com chip around? i could need one.
> > 
> > -----
> > 
> > [PATCH] 3c59x: only put the device into D3 when we're actually using WOL
> > 
> > Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
> > 
> > --- 1.77/drivers/net/3c59x.c	2005-03-03 06:00:42 +01:00
> > +++ edited/drivers/net/3c59x.c	2005-04-17 22:17:19 +02:00
> > @@ -1581,7 +1581,8 @@
> >  
> >  	if (VORTEX_PCI(vp)) {
> >  		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
> > -		pci_restore_state(VORTEX_PCI(vp));
> > +		if (vp->pm_state_valid)
> > +			pci_restore_state(VORTEX_PCI(vp));
> >  		pci_enable_device(VORTEX_PCI(vp));
> >  	}
> >  
> > @@ -2741,6 +2742,7 @@
> >  		outl(0, ioaddr + DownListPtr);
> >  
> >  	if (final_down && VORTEX_PCI(vp)) {
> > +		vp->pm_state_valid = 1;
> >  		pci_save_state(VORTEX_PCI(vp));
> >  		acpi_set_WOL(dev);
> >  	}
> > @@ -3243,9 +3245,10 @@
> >  		outw(RxEnable, ioaddr + EL3_CMD);
> >  
> >  		pci_enable_wake(VORTEX_PCI(vp), 0, 1);
> > +
> > +		/* Change the power state to D3; RxEnable doesn't take effect. */
> > +		pci_set_power_state(VORTEX_PCI(vp), PCI_D3hot);
> >  	}
> > -	/* Change the power state to D3; RxEnable doesn't take effect. */
> > -	pci_set_power_state(VORTEX_PCI(vp), PCI_D3hot);
> >  }
> >  
> 
> The patch solved it. Thank you for your help.

ok, nice to see it working. 
andrew, could you add it to -mm please?
[ adding jeff to cc: because it's a network driver :) ]

thanks, rgds
-daniel

 

