Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275086AbRJFIKH>; Sat, 6 Oct 2001 04:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275087AbRJFIJ5>; Sat, 6 Oct 2001 04:09:57 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:7696 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S275086AbRJFIJm>;
	Sat, 6 Oct 2001 04:09:42 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15294.47999.501719.858693@cargo.ozlabs.ibm.com>
Date: Sat, 6 Oct 2001 18:06:23 +1000 (EST)
To: Jes Sorensen <jes@sunsite.dk>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linux Bigot <linuxopinion@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
In-Reply-To: <d3n136tc48.fsf@lxplus014.cern.ch>
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain>
	<d3n136tc48.fsf@lxplus014.cern.ch>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen writes:

> Because as DaveM pointed out, some hardware can't do it, and as I said
> earlier, it's a lot cheaper and easier for driver writers to just
> store the extra pointer in their data structures than it is to
> implement a database to maintain it.

For some devices yes, for others storing the extra pointer doesn't
help all that much.  Devices which can complete requests out of order
and which tell you the DMA addresses of the requests they have
completed would be in the second class, and that includes the OHCI USB
controller, and some intelligent SCSI controllers I believe.

So you end up having to map the DMA address back to the pointer to the
data structure for the request.  At the moment the drivers that need
this each have their own implementation, using a hash table or
whatever.

The argument for supplying this functionality in the PCI DMA code
would be that if it was done there it could be done once, and in a
sophisticated and efficient (and SMP-safe :) fashion, rather than
ad-hoc in each driver.

It may also be possible for the PCI DMA code to take advantage of its
knowledge of a particular platform, for example if the platform only
has a small range of possible DMA addresses then it could use a simple
and fast lookup table.  Or it may be possible to read the IOMMU tables
on some platforms and do the reverse mapping quickly that way - this
would certainly be the case for the IBM RS/6000 machines since the
IOMMU tables are in system RAM.

> Remember you often need this address in the hot path (say TX interrupt
> handler) so you don't want to introduce any unnecessary function calls.

The drivers that need this would already be doing internal function
calls to do the reverse mapping anyway.  Of course we would not want
this functionality to add extra overhead at the point where we set up
the mapping (at least in the cases where we won't need the reverse
mapping).

There is a question though as to whether a reverse mapping from DMA
address to virtual address is sufficient for these drivers, or whether
they would need a mapping from DMA address to something else such as a
pointer to a request structure.  The usb-ohci driver looks like it
would be sufficient to get back to the virtual address.

Regards,
Paul.
