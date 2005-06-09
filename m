Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVFIWaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVFIWaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVFIWaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:30:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:48562 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262497AbVFIW3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:29:49 -0400
Subject: Re: [PATCH 00/10] IOCHK interface for I/O error handling/detecting
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <20050609171332.GC24611@parcelfarce.linux.theplanet.co.uk>
References: <42A8386F.2060100@jp.fujitsu.com>
	 <20050609171332.GC24611@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 08:26:39 +1000
Message-Id: <1118355999.6850.177.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It makes sense to sandwich other kinds of device accesses.  I don't
> think the previous clear/read_pci_errors() interface was intended *only*
> to sandwich readX().

On many platforms, only read() is guaranteed to reliably report errors
though.

> > - Additionally adds special token - abstract "iocookie" structure
> >   to control/identifies/manage I/Os, by passing it to OS.
> >   Actual type of "iocookie" could be arch-specific. Device drivers
> >   could use the iocookie structure without knowing its detail.
> 
> I'm not sure we need this.  Surely it can be deduced from the pci_dev or
> struct device?

Might be useful to know more though, wether it was PIO or MMIO or other
things. Also, I'd like to carry around the possible error details as can
be returned by the firmware in some platforms.

In fact, Is there any reason this is not ioerr_cookie instead of
iocookie ? :)

> > Expected usage(sample) is:
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > #include <linux/pci.h>
> > #include <asm/io.h>
> > 
> > int sample_read_with_iochk(struct pci_dev *dev, u32 *buf, int words)
> > {
> >     unsigned long ofs = pci_resource_start(dev, 0) + DATA_OFFSET;
> >     int i;
> > 
> >     /* Create magical cookie on the stack */
> >     iocookie cookie;
> > 
> >     /* Critical section start */
> >     iochk_clear(&dev, &cookie);
> >     {
> >         /* Get the whole packet of data */
> >         for (i = 0; i < words; i++)
> >             *buf++ = ioread32(dev, ofs);
> 
> You do know that ioread32() doesn't take a pci_dev, right?  I hope you
> weren't counting on that for the rest of your implementation.
> 
> >     }
> >     /* Critical section end. Did we have any trouble? */
> >     if ( iochk_read(&cookie) ) return -1;
> > 
> >     /* OK, all system go. */
> >     return 0;
> > }
> 

