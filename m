Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267238AbSLEGgm>; Thu, 5 Dec 2002 01:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267239AbSLEGgm>; Thu, 5 Dec 2002 01:36:42 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:35764 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267238AbSLEGgl>; Thu, 5 Dec 2002 01:36:41 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
References: <20021205004744.GB2741@zax.zax>
	<200212050144.gB51iH105366@localhost.localdomain>
	<20021205023847.GA1500@zax.zax>
	<buohedtrw64.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20021205060606.GG1500@zax.zax>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 05 Dec 2002 15:43:58 +0900
In-Reply-To: <20021205060606.GG1500@zax.zax>
Message-ID: <buovg29klsh.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> writes:
> > As I mentioned in my previous message, one of my platforms is like that
> > memory, which is only 2 megabytes in size.
> 
> Ok, that starts to make sense then (what platform is it,
> incidentally).  Is using consistent memory actually faster than doing
> the cache flushes expliticly?  Much?

It's an embedded evaluation board (Midas `RTE-MOTHER-A' and
`RTE-V850E-MA1-CB').

The thing is there _is_ no cache on this machine (it's very slow), so
cache-consistency is actually not an issue (and the cache-flushing
macros won't help me at all).

PCI devices are several busses removed from the CPU, and they only have
this one 2MB area in common.  So on this machine, PCI devices can _only_
use consistent memory.

When a driver uses the non-consistent interfaces, then:

  * pci_map_single allocates a `shadow area' of consistent memory and
    pci_unmap_single deallocates it

  * pci_dma_sync_... just does a memcpy to/from the `shadow' consistent
    memory from/to the drivers kalloc'd block (in principle I think this
    is incorrect, because it uses the `dir' parameter to determine the
    direction to copy, but it works in practice)

So you can see that for this platform, it would be better if drivers
could _always_ use alloc_consistent, but many don't.

Yes this is a wierd and frustrating design, but I think it does credit
to the linux PCI layer that I could get it work at all, without
modifying any drivers!  I guess my main goal in this discussion is to
ensure that remains the case...

-Miles
-- 
.Numeric stability is probably not all that important when you're guessing.
