Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269341AbUJFT03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269341AbUJFT03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269374AbUJFT0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:26:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:49316 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269341AbUJFTZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:25:18 -0400
Message-ID: <41644301.9EC028B3@sgi.com>
Date: Wed, 06 Oct 2004 14:09:54 -0500
From: Colin Ngam <cngam@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.79C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Grant Grundler <iod00d@hp.com>
CC: Patrick Gefre <pfg@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41641007.5020702@sgi.com> <20041006185739.GA25773@cup.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:

> On Wed, Oct 06, 2004 at 10:32:23AM -0500, Patrick Gefre wrote:
> > o added our own pci_ops (Grant/Matthew's request)
>
> Sorry - my bad.
> I confused the issue by claiming one should replace pci_root_ops.
> It was one possibility but it's not an easy path to take.

Hi Grant,

>
>
> Mathew explained replacing the raw_pci_ops pointer is the Right Thing
> and I suspect it's easier to properly implement.

I believe we did just that.  We did not touch pci_root_ops.

>
>
> Some comments on the implementation:
> o sn_pci_fixup_bus() is a confusing name. "pcibios_fixup_bus" is normally
>   called by generic PCI code after each bus is walked.
>   This code obviously doesn't support that.
>   Maybe, sn_init_pci_controller() or something like that would be clearer.

That is a good idea and can be done.

>
>
> o This bit of code belongs in the pcibios_fixup_bus() call path:
>         +       /*
>         +        * Generic Linux PCI Layer has created the pci_bus and pci_dev
>         +        * structures - time for us to add our SN PLatform specific
>         +        * information.
>         +        */
>         +
>         +       while ((pci_dev =
>         +               pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev)) != NULL) {
>         +               sn_pci_fixup_slot(pci_dev);
>         +       }
>
>   I realize that's not easy to add/maintain in the arch/ia64 port though
>   since pcibios_fixup_bus() is common code for multiple platforms.

Yes, would anybody allow us to make a platform specific callout from within generic
pcibios_fixup_bus()???

>
>
> o sn_pci_fixup_bus() should be called for each PCI root bus controller
>   the firmware advertises. The loop in sn_pci_init() is hard coded
>   to loop from 0 to 256 busses.
>   Is ACPI the only way PCI host controllers are advertised?

That would be my assumption.  And ACPI is our next effort.

>
>   SN2 doesn't use a different method today?

Correct.

>
>
>   It means we are telling PCI subsystem to walk root busses that don't
>   exist in all configurations. I hope there are no nasty side effects
>   from that.

Not at all.  If you look at the loop, sn_pci_fixup_bus(0 gets called for 0 -
PCI_BUSES_TO_SCAN but if the bus does not exist, we do not call pci_scan_bus(),
therefore the PCI subsystem is not called to walk buses that do not exist on SN.

>
>
> o the BUG() in:
>
>         +       controller = sn_alloc_pci_sysdata();
>         +       if (!controller) {
>         +               BUG();
>         +       }
>   is redundant with the BUG in sn_alloc_pci_sysdata().

Thanks.  We can fix this.

One favour.  Would you agree to letting this patch be included by Tony and we will come
up with another patch to fix the 2 obvious items listed above?  It will be great to
avoid spinning this big patch.

Thanks.

colin

>
>
> sorry for the initial bad advice and I hope this helps,
> grant
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

