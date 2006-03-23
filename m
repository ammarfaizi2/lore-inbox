Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWCWSiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWCWSiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWCWSh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:37:56 -0500
Received: from cantor.suse.de ([195.135.220.2]:20638 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932546AbWCWShy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:37:54 -0500
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH 2/3] x86-64: Calgary IOMMU - Calgary specific bits
Date: Thu, 23 Mar 2006 19:02:03 +0100
User-Agent: KMail/1.9.1
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
References: <20060320084848.GA21729@granada.merseine.nu> <200603231731.34097.ak@suse.de> <20060323175345.GB2598@granada.merseine.nu>
In-Reply-To: <20060323175345.GB2598@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231902.04043.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 18:53, Muli Ben-Yehuda wrote:

> no we don't, would you prefer we do it there?

Yes

> > > +	/* make sure updates are seen by hardware */
> > > +	mb();
> > 
> > Doesn't make sense on x86-64.
> 
> would you mind explaining why? we need the tce update to be flushed
> out of the cache to main memory, is this implied by something that
> happens earlier, e.g. the spin_unlock?

Barriers don't have anything to do with flushing. See the long thread
I had recently about this with the ipath person.

And on x86-64 the writes are always ordered so mb() normally doesn't
affect writes at all (except for compiler reordering but I can't see
this being a problem here)

If you want a real flush you need CLFLUSH if it's cached and
a read if it's behind a PCI bridge.

> the way the chip works is that incoming addresses from the device that
> land inside these holes will not get translated, so we have to make
> sure not to give them out to devices. AFAIK these are the only holes
> in the IO space as far as the chip is concerned. At least empirically
> it works :-)

The 640K-1MB is in no way different from the PCI hole below 4GB in this regard.

It's still totally unclear why you special case one and not the other.

In general you should probably drive this over e820 and only allow RAM
(or hotplug memory beyond end_pfn). Or not have this special case at all.



> we ran into that; we use the bus's sysdata for NUMA, whereas here we
> use the bus's pci_dev's sysdata, so there isn't any conflict. If you
> prefer that we allocate a new structure and use that for both NUMA and
> Calgary, we can certainly do it.

Ok but needs prominent comments.

> it should, but at the moment swiotlb is tied too intimately to
> gart and doesn't work with anything else. It's on our TODO list.


I don't quite buy this. With the gart ops this really shouldn't 
be a problem anymore.


> > I would like to see a printk and some comments about the full isolation
> > because it's a big change. How does it interact with the X server
> > for once?
> 
> X works :-) 

So it's behind a bridge that doesn't have an IOMMU?
Ok i suppose dual head will not work but you might not care.

Otherwise you would need to add an interface to disable the isolation
from user space for X.

-Andi
