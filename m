Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269472AbUJFUlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269472AbUJFUlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269491AbUJFUky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:40:54 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:38892 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269472AbUJFUgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:36:43 -0400
Message-ID: <416453CE.2516D2BC@sgi.com>
Date: Wed, 06 Oct 2004 15:21:37 -0500
From: Colin Ngam <cngam@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.79C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>, Grant Grundler <iod00d@hp.com>
CC: Patrick Gefre <pfg@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41644301.9EC028B3@sgi.com> <20041006195424.GF25773@cup.hp.com> <200410061327.28572.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:

Hi Jesse/Grant,

May be my response to Grant got lost .. anyway, here it is again.

> On Wednesday, October 6, 2004 12:54 pm, Grant Grundler wrote:
> > Colin,
> > thanks for ACKing the feedback.
> > I think there is still some confusion...
> >
> > On Wed, Oct 06, 2004 at 02:09:54PM -0500, Colin Ngam wrote:
> > ...
> >
> > > > Mathew explained replacing the raw_pci_ops pointer is the Right Thing
> > > > and I suspect it's easier to properly implement.
> > >
> > > I believe we did just that.  We did not touch pci_root_ops.
> >
> > Correct. The patch ignores/overides pci_root_ops with sn_pci_root_ops
> > (which is what I originally suggested).
> >
> > Mathew's point was only raw_pci_ops needs to point at a different
> > set of struct pci_raw_ops (see include/linux/pci.h).
>
> Though now what's there seems awfully redundant, wouldn't you say?  Just
> allowing direct access to pci_root_ops is a much simpler approach and gets
> rid of a bunch of extra, unneeded code (i.e. closer to Pat's original
> version).

The original mod, we took out the static from pci_root_ops() so that we can use
it in io_init.c.  We thought that would be the cleanest.

We do not want to change pci_raw_ops().  It is doing exactly what we need, now
that sn platform has the support for SAL pci reads and writes support.

>
>
> > > Yes, would anybody allow us to make a platform specific callout
> > > from within generic pcibios_fixup_bus()???
> >
> > If it can be avoided, preferably not. But that's up to Jesse/Tony I think.
>
> If it was made a machine vector that's a no-op on everything but sn2, I think
> it would be fine.  Doing it for the general sn_pci_init routine would let us
> get rid of the check for ia64_platform_is("sn2") in one of the routines, I
> think (which is nice if only for the consistency).
>
> > Can you quote the bit of the patch which implements "if the bus does not
> > exist" check?
> > I can't find it.
>
> In the current code it's:
>
>  for (i = 0; i < PCI_BUSES_TO_SCAN; i++)
>   if (pci_bus_to_vertex(i))
>    pci_scan_bus(i, &sn_pci_ops, controller);
>
> which causes the next loop to only fixup existing busses. But I don't see it
> in the new code.

Probably not clear to all:

+/*
+ * sn_pci_fixup_bus() - This routine sets up a bus's resources
+ * consistent with the Linux PCI abstraction layer.
+ */
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

The sal_get_pcibus_info() will fail if we do not find that bus number.  If it
fails, we do not call pci_scan_bus()


Thanks.

colin

>
>
> > > One favour.  Would you agree to letting this patch be included by Tony
> > > and we will come up with another patch to fix the 2 obvious items listed
> > > above?  It will be great to avoid spinning this big patch.
>
> The patch is ok with me, I think it's a big improvement over what's there in
> terms of readability.
>
> I just checked out sn_set_affinity_irq() and it's a bit hard to see what's
> going on.  Why does a new interrupt have to be allocated?  Also, it looks
> like the kfree() is one line too high, if sn_intr_alloc fails, we'll leak
> new_sn_irq_info.
>
> Jesse

