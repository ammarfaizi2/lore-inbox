Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129225AbRBNVMh>; Wed, 14 Feb 2001 16:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129211AbRBNVM1>; Wed, 14 Feb 2001 16:12:27 -0500
Received: from front4.grolier.fr ([194.158.96.54]:16030 "EHLO
	front4.grolier.fr") by vger.kernel.org with ESMTP
	id <S129510AbRBNVMT> convert rfc822-to-8bit; Wed, 14 Feb 2001 16:12:19 -0500
Date: Wed, 14 Feb 2001 21:10:51 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Donald Becker <becker@scyld.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Jes Sorensen <jes@linuxcare.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <200102140205.f1E25Je02309@moisil.dev.hydraweb.com>
Message-ID: <Pine.LNX.4.10.10102142045340.1320-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Feb 2001, Ion Badulescu wrote:

> On Tue, 13 Feb 2001 12:29:16 -0800, Ion Badulescu <ionut@moisil.cs.columbia.edu> wrote:
> > On Tue, 13 Feb 2001 07:06:44 -0600 (CST), Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com> wrote:
> > 
> >> On 12 Feb 2001, Jes Sorensen wrote:
> >>> In fact one has to look out for this and disable the feature in some
> >>> cases. On the acenic not disabling Memory Write and Invalidate costs
> >>> ~20% on performance on some systems.
> >> 
> >> And in another message, On Mon, 12 Feb 2001, David S. Miller wrote:
> >>> 3) The acenic/gbit performance anomalies have been cured
> >>>    by reverting the PCI mem_inval tweaks.
> >> 
> >> Just to be clear, acenic should or should not use MWI?
> 
> With the zerocopy patch, acenic always disables MWI by default.
> 
> >> And can a general rule be applied here?  Newer Tulip hardware also
> >> has the ability to enable/disable MWI usage, IIRC.
> > 
> > And so do eepro100 and starfire. On the eepro100 we're enabling MWI 
> > unconditionally, and on the starfire we disable it unconditionally...
> > 
> > I should probably take a look at acenic's use of PCI_COMMAND_INVALIDATE
> > to see when it gets activated. Some benchmarking would probably help,
> > too -- maybe later today.
> 
> I did some testing with starfire, and the results are inconclusive --
> at least on my P-III is makes absolutely no difference. Does it make
> a difference on other architectures? sparc64, ia64 maybe? 
> 
> I should probably rephrase this: MWI makes no difference on i386, but
> it is claimed that using MWI *reduces* performance on some systems.
> Are there any systems on which MWI *increases* performance?

I have read several data sheets about Intel PCI-HOST bridges and they all
were said to alias PCI MWI to normal PCI MEMORY WRITE transactions.
This matches your observations just fine.
Even when MWI is handled as MW, the PCI master is required to transfer 
entire cache lines and this cannot be bad for performances. But this 
should probably not make significant difference with normal MW.

Btw, your rephrasing looks improper to me. The processor is not involved
in the handling of MWI., especially when the MWI targets the memory. It is
the PCI-HOST bridge that must be considered here. What about ServerWorks
chipset ? Hmmm... I would be glad to have docs about these ones. :(

The MWI is intended to allow optimizations based on cache lines
invalidations rather than snooping. The target (or bridge) can perfectly
elect to handle the MWI as a normal MW and so, performance should not be
significantly lowered using MWI. But nothing is perfect, as we know.

The MWI is interesting for PCI throughput optimization but the MEMORY READ
LINE and MEMORY READ MULTIPLE transactions are a lot more interesting, in
my opinion. WRITEs can be posted (buffered), but in order to stream data
from memory (prefetchable) the bridge can do a better work when it knows
the intention of the PCI MASTER. All bridges should take in considerations
hints associated with MRL and MRM. IIRC, Intel bridges do.

> I've added some code to the starfire driver that allows changing the
> use of MWI at module load time, just in case. By default, it activates
> it.

You should also play with MRL and MRM, in my opinion.

  Gérard.

