Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUIUAiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUIUAiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 20:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUIUAiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 20:38:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:17110 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267415AbUIUAio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 20:38:44 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Matthew Wilcox <willy@debian.org>
Subject: Re: Documentation/io_ordering.txt is wrong
Date: Mon, 20 Sep 2004 17:38:16 -0700
User-Agent: KMail/1.7
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, pj@sgi.com,
       linux-scsi@vger.kernel.org, mdr@cthulhu.engr.sgi.com,
       jeremy@cthulhu.engr.sgi.com, djh@cthulhu.engr.sgi.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040917183029.GW642@parcelfarce.linux.theplanet.co.uk> <20040918061001.GC21456@colo.lackof.org> <20040918175714.GD642@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040918175714.GD642@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4f3TBvD61hDqgvE"
Message-Id: <200409201738.16746.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_4f3TBvD61hDqgvE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday, September 18, 2004 10:57 am, Matthew Wilcox wrote:
> On Sat, Sep 18, 2004 at 12:10:01AM -0600, Grant Grundler wrote:
> > Jesse Barnes wrote:
> > ...
> >
> > > Btw Andrew (Vasquez), there's a small doc I put together that should
> > > describe when you have to worry about PCI posting.  It's in the tree:
> > > Documentation/io_ordering.txt.  If it's incomplete or confusing, just
> > > let me know and I'll update it.
> >
> > Jesse,
> > Both. incomplete and confusing.
> > "concrete example of a hypothetical driver" wasn't my first warning
> > this document needed work. :^)
>
> Not just incomplete and confusing, but actively wrong.  spin_lock/
> spin_unlock should imply ordering of readb().  What you're describing
> there is __readb().  See Documentation/DocBook/deviceiobook.tmpl.  Also,
> rmb() should ensure ordering of io reads; there should be no need to
> touch the device.

Is this any better?  I just sent it off to Grant too.

Thanks,
Jesse

--Boundary-00=_4f3TBvD61hDqgvE
Content-Type: text/plain;
  charset="iso-8859-1";
  name="io_ordering.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="io_ordering.txt"

Dealing with posted writes
--------------------------

On some platforms platforms, driver writers are responsible for
ensuring that I/O writes to memory-mapped addresses on their device
arrive in the order intended.  This is typically done by reading a
'safe' device or bridge register, causing the I/O chipset to flush
pending writes to the device before any reads are posted.  A driver
would usually use this technique immediately prior to the exit of a
critical section of code protected by spinlocks.  This would ensure
that subsequent writes to I/O space arrived only after all prior
writes (much like a memory barrier op, mb(), only with respect to
I/O).

Some pseudocode to illustrate the problem:

        ...
CPU A:  spin_lock_irqsave(&dev_lock, flags)
CPU A:  ...
CPU A:  writel(newval, ring_ptr);
CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
        ...
CPU B:  spin_lock_irqsave(&dev_lock, flags)
CPU B:  ...
CPU B:  writel(newval2, ring_ptr);
CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
        ...

In the case above, the device may receive newval2 before it receives newval,
which could cause problems.  Fixing it is easy enough though:

        ...
CPU A:  spin_lock_irqsave(&dev_lock, flags)
CPU A:  ...
CPU A:  writel(newval, ring_ptr);
CPU A:  (void)readl(safe_register); /* maybe a config register? */
CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
        ...
CPU B:  spin_lock_irqsave(&dev_lock, flags)
CPU B:  ...
CPU B:  writel(newval2, ring_ptr);
CPU B:  (void)readl(safe_register); /* or read_relaxed() */
CPU B:  spin_unlock_irqrestore(&dev_lock, flags)

Here, the reads from safe_register will cause the I/O chipset to flush any
pending writes before actually posting the read to the chipset, preventing
possible data corruption.

This sort of synchronization is only necessary for read/write calls,
not in/out calls, since they're by definition strongly ordered.

We should probably add a writeflush call or something to deal with the
above in an easier to read way.  Some platforms could even implement
such a routine more efficiently than a regular read.

--Boundary-00=_4f3TBvD61hDqgvE--
