Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWCHDVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWCHDVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWCHDVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:21:13 -0500
Received: from ozlabs.org ([203.10.76.45]:41380 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932418AbWCHDVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:21:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17422.19865.635112.820824@cargo.ozlabs.ibm.com>
Date: Wed, 8 Mar 2006 14:20:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arch@vger.kernel.org, bcrl@linux.intel.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, mingo@redhat.com,
       linuxppc64-dev@ozlabs.org, jblunck@suse.de
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <Pine.LNX.4.64.0603040914160.22647@g5.osdl.org>
References: <32518.1141401780@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>
	<17417.29375.87604.537434@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0603040914160.22647@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> So the rules from the PC side (and like it or not, they end up being 
> what all the drivers are tested with) are:
> 
>  - regular stores are ordered by write barriers

I thought regular stores were always ordered anyway?

>  - PIO stores are always synchronous

By synchronous, do you mean ordered with respect to all other accesses
(regular memory, MMIO, prefetchable MMIO, PIO)?

In other words, if I store a value in regular memory, then do an
outb() to a device, and the device does a DMA read to the location I
just stored to, is the device guaranteed to see the value I just
stored (assuming no other later store to the location)?

>  - MMIO stores are ordered by IO semantics
> 	- PCI ordering must be honored:
> 	  * write combining is only allowed on PCI memory resources
> 	    that are marked prefetchable. If your host bridge does write 
> 	    combining in general, it's not a "host bridge", it's a "host 
> 	    disaster".

Presumably the host bridge doesn't know what sort of PCI resource is
mapped at a given address, so that information (whether the resource
is prefetchable) must come from the CPU, which would get it from the
TLB entry or an MTRR entry - is that right?

Or is there some gentleman's agreement between the host bridge and the
BIOS that certain address ranges are only used for certain types of
PCI memory resources?

> 	  * for others, writes can always be posted, but they cannot
> 	    be re-ordered wrt either reads or writes to that device
> 	    (ie a read will always be fully synchronizing)
> 	- io_wmb must be honored

What ordering is there between stores to regular memory and stores to
non-prefetchable MMIO?

If a store to regular memory can be performed before a store to MMIO,
does a wmb() suffice to enforce an ordering, or do you have to use
mmiowb()?

Do PCs ever use write-through caching on prefetchable MMIO resources?

Thanks,
Paul.
