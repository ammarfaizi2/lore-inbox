Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269412AbUJFWLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269412AbUJFWLl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269433AbUJFWHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:07:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1207 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269412AbUJFU1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:27:51 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Grant Grundler <iod00d@hp.com>
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Date: Wed, 6 Oct 2004 13:27:28 -0700
User-Agent: KMail/1.7
Cc: Colin Ngam <cngam@sgi.com>, Patrick Gefre <pfg@sgi.com>,
       "Luck, Tony" <tony.luck@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41644301.9EC028B3@sgi.com> <20041006195424.GF25773@cup.hp.com>
In-Reply-To: <20041006195424.GF25773@cup.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410061327.28572.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 6, 2004 12:54 pm, Grant Grundler wrote:
> Colin,
> thanks for ACKing the feedback.
> I think there is still some confusion...
>
> On Wed, Oct 06, 2004 at 02:09:54PM -0500, Colin Ngam wrote:
> ...
>
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

Though now what's there seems awfully redundant, wouldn't you say?  Just 
allowing direct access to pci_root_ops is a much simpler approach and gets 
rid of a bunch of extra, unneeded code (i.e. closer to Pat's original 
version).

> > Yes, would anybody allow us to make a platform specific callout
> > from within generic pcibios_fixup_bus()???
>
> If it can be avoided, preferably not. But that's up to Jesse/Tony I think.

If it was made a machine vector that's a no-op on everything but sn2, I think 
it would be fine.  Doing it for the general sn_pci_init routine would let us 
get rid of the check for ia64_platform_is("sn2") in one of the routines, I 
think (which is nice if only for the consistency).

> Can you quote the bit of the patch which implements "if the bus does not
> exist" check?
> I can't find it.

In the current code it's:

 for (i = 0; i < PCI_BUSES_TO_SCAN; i++)
  if (pci_bus_to_vertex(i))
   pci_scan_bus(i, &sn_pci_ops, controller);

which causes the next loop to only fixup existing busses. But I don't see it 
in the new code.

> > One favour.  Would you agree to letting this patch be included by Tony
> > and we will come up with another patch to fix the 2 obvious items listed
> > above?  It will be great to avoid spinning this big patch.

The patch is ok with me, I think it's a big improvement over what's there in 
terms of readability.

I just checked out sn_set_affinity_irq() and it's a bit hard to see what's 
going on.  Why does a new interrupt have to be allocated?  Also, it looks 
like the kfree() is one line too high, if sn_intr_alloc fails, we'll leak 
new_sn_irq_info.

Jesse
