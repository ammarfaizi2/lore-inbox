Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268512AbUHLAhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268512AbUHLAhq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268501AbUHLAdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:33:51 -0400
Received: from web14927.mail.yahoo.com ([216.136.225.85]:45949 "HELO
	web14927.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268481AbUHLAWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:22:45 -0400
Message-ID: <20040812002245.88080.qmail@web14927.mail.yahoo.com>
Date: Wed, 11 Aug 2004 17:22:45 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: RE: [PATCH] add PCI ROMs to sysfs
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600296D33C@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the quirk in fixup.c from FINAL to HEADER fixes the problem.
Only the length was coming from the wrong place, the ROM contents came
from the shadow memory.

Any ideas on how to solve this problem...

Originally I had this in the enable ROM routine
/* assign the ROM an address if it doesn't have one */
if (r->parent == NULL)
   pci_assign_resource(dev->pdev, PCI_ROM_RESOURCE);
                                                                       
                                 
I removed the call to pci_assign_resource(). The sysfs attribute code
builds the attributes before the pci subsystem is fully initialized.
specifically before arch pcibios_init() has been called. If
pci_assign_resource() is called for the ROM before pcibios_init() the
kernel's resource maps have not been built yet. This will result in the
ROM being located on top of the framebuffer; as soon as it is enabled
the system will lock. Right now the code relies on the BIOS getting the
ROM address set up right. If we can figure out how to initialize the
sysfs attributes after pcibios_init() then I can put the assign call
back.

--- "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:

> 
> One issue with x86 quirk in this patch.
> The actual sysfs entries are created during the PCI bus scan.
> But, pci_fixup_video() gets called later during device_initcalls.
> So, PCI_ROM_SHADOW is kind of ineffective now. 
> 
> Thanks,
> Venki

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
