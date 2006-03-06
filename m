Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWCFEEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWCFEEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 23:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWCFEEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 23:04:15 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:55824 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S1750751AbWCFEEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 23:04:15 -0500
Message-ID: <440BB474.8000500@snapgear.com>
Date: Mon, 06 Mar 2006 14:03:00 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Ringle <jringle@vertical.com>
CC: Adrian Cox <adrian@humboldt.co.uk>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux running on a PCI Option device?
References: <43EAE4AC.6070807@snapgear.com> <200603030909.28640.jringle@vertical.com> <1141396843.8912.49.camel@localhost.localdomain> <200603031331.16849.jringle@vertical.com>
In-Reply-To: <200603031331.16849.jringle@vertical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Jon Ringle wrote:
> On Friday 03 March 2006 09:40 am, Adrian Cox wrote:
> 
>>Based on only a quick look at the code: if the Windows host is present,
>>don't call pci_common_init() in ixdp425_pci_init().
> 
> 
> Doing this will prevent the code in ixp4xx_pci_preinit() from executing which 
> handles some initialization for both PCI host and option modes. Should I go 
> ahead and explicitly call ixp4xx_pci_preinit() from ixdp425_pci_init() if in 
> PCI option mode?

The older 2.4 kernel code for the IXP425 support pretty much did it
this way (which is what makes it look like it supports the device
in option mode).

Code snippet from ixp425_pci_init() in arch/arm/mach-ixp425/ixp425-pci.c
(from patches for 2.4 kernels to support ixp425):

        ...
        if (ixp425_pci_is_host())
         {
                 local_write_config_word(PCI_COMMAND, PCI_COMMAND_MASTER |
                         PCI_COMMAND_MEMORY);

                 DBG("allocating hose\n");
                 hose = pcibios_alloc_controller();
                 if (!hose)
                 panic("Could not allocate PCI hose");

                 hose->first_busno = 0;
                 hose->last_busno = 0;
                 hose->io_space.start = 0;
                 hose->io_space.end = 0xffffffff;
                 hose->mem_space.start = 0x48000000;
                 hose->mem_space.end = 0x4bffffff;

                 /* autoconfig the bus */ DBG("AUTOCONFIG\n");
                 hose->last_busno = pciauto_bus_scan(hose, 0);

                 /* scan the bus */
                 DBG("SCANNING THE BUS\n");
                 pci_scan_bus(0, &ixp425_ops, sysdata);
          }


Pretty much the rest of the PCI init is the same, it just
doesn't do the bus scan.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a Secure Computing Company      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
