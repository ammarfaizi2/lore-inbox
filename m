Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269479AbUJFUbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269479AbUJFUbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbUJFU3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:29:23 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:26576 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269394AbUJFUJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:09:17 -0400
Message-ID: <41644D61.9A75D7E7@sgi.com>
Date: Wed, 06 Oct 2004 14:54:09 -0500
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
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41641007.5020702@sgi.com> <20041006185739.GA25773@cup.hp.com> <41644301.9EC028B3@sgi.com> <20041006195424.GF25773@cup.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:

> Colin,
> thanks for ACKing the feedback.
> I think there is still some confusion...
>
> On Wed, Oct 06, 2004 at 02:09:54PM -0500, Colin Ngam wrote:
> ...
> > > Mathew explained replacing the raw_pci_ops pointer is the Right Thing
> > > and I suspect it's easier to properly implement.
> >
> > I believe we did just that.  We did not touch pci_root_ops.
>
> Correct. The patch ignores/overides pci_root_ops with sn_pci_root_ops
> (which is what I originally suggested).
>
> Mathew's point was only raw_pci_ops needs to point at a different
> set of struct pci_raw_ops (see include/linux/pci.h).

Hi Grant,

Well, I am confused then.

Originally, we needed to use pci_root_ops in io_init.c to pass it to
pci_scan_bus().  But pci_root_ops is defined as a static in pci/pci.c.  We took
out the static so that we can use this in io_init.c.  However, it sounded like
you guys do not want to externalize pci_root_ops.  Okay, we created
sn_pci_root_ops.

We do not want pci_raw_ops to point at anything different.  It is exactly what we
needed now that we have implemented in our Prom all the pci config read/write SAL
calls.

>
>
> > >   I realize that's not easy to add/maintain in the arch/ia64 port though
> > >   since pcibios_fixup_bus() is common code for multiple platforms.
> >
> > Yes, would anybody allow us to make a platform specific callout
> > from within generic pcibios_fixup_bus()???
>
> If it can be avoided, preferably not. But that's up to Jesse/Tony I think.
>
> ...
> > >   It means we are telling PCI subsystem to walk root busses that don't
> > >   exist in all configurations. I hope there are no nasty side effects
> > >   from that.
> >
> > Not at all.  If you look at the loop, sn_pci_fixup_bus(0 gets called for 0 -
> > PCI_BUSES_TO_SCAN but if the bus does not exist,
>
> Can you quote the bit of the patch which implements "if the bus does not
> exist" check?
> I can't find it.

In the routine sn_pci_fixup_bus()

+static void sn_pci_fixup_bus(int segment, int busnum)
+{
+       int status = 0;
+       int nasid, cnode;
+       struct pci_bus *bus;
+       struct pci_controller *controller;
+       struct pcibus_bussoft *prom_bussoft_ptr;
+       struct hubdev_info *hubdev_info;
+       void *provider_soft;
+
+       status =
+           sal_get_pcibus_info((u64) segment, (u64) busnum,
+                               (u64) ia64_tpa(&prom_bussoft_ptr));
+       if (status > 0) {
+               return;         /* bus # does not exist */
+       }
+
+       prom_bussoft_ptr = __va(prom_bussoft_ptr);
+       controller = sn_alloc_pci_sysdata();
+       if (!controller) {
+               BUG();
+       }
+
+       bus = pci_scan_bus(busnum, &sn_pci_root_ops, controller);
+       if (bus == NULL) {
+               return;         /* error, or bus already scanned */
+       }

We bail if sal_get_pcibus_info() is not successful.  Am I missing something?

>
>
> > One favour.  Would you agree to letting this patch be included by Tony
> > and we will come up with another patch to fix the 2 obvious items listed
> > above?  It will be great to avoid spinning this big patch.
>
> I think that's up to Jesse/Tony.
> I don't "own" any of the code in question.
> Just trying to undo the confusion I caused.

Thanks.

colin

>
>
> grant

