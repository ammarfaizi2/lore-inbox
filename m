Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTFFUAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 16:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTFFUAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 16:00:12 -0400
Received: from palrel12.hp.com ([156.153.255.237]:16546 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262261AbTFFUAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 16:00:06 -0400
Date: Fri, 6 Jun 2003 13:13:38 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200306062013.h56KDcLe026713@napali.hpl.hp.com>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, manfred@colorfullife.com,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
In-Reply-To: <20030606.003230.15263591.davem@redhat.com>
References: <16096.14281.621282.67906@napali.hpl.hp.com>
	<20030605.235249.35666087.davem@redhat.com>
	<16096.16492.286361.509747@napali.hpl.hp.com>
	<20030606.003230.15263591.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 06 Jun 2003 00:32:30 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  David>    From: David Mosberger <davidm@napali.hpl.hp.com> Date:
  David> Fri, 6 Jun 2003 00:19:08 -0700

  David>    PCI_DMA_BUS_IS_PHYS (and it's description) is quite
  David> misleading: it claims that it has something to do with there
  David> being an equivalence between PCI bus and physical addresses.
  David> That's actually the case for (small) ia64 platforms so that's
  David> why we ended up setting it to 1.

  David> It does have to do with such an equivalence.  If your port
  David> couldn't work if drivers use the deprecated
  David> virt_to_bus/bus_to_virt, you must set PCI_DMA_BUS_IS_PHYS to
  David> zero.

Yes, but the comment certainly is confusing.  How about something like
this:

/*
 * PCI_DMA_BUS_IS_PHYS should be set to 1 if there is necessarily a
 * direct corespondence between device bus addresses and CPU physical
 * addresses.  Platforms with a hardware I/O MMU _must_ turn this off
 * to suppress the bounce buffer handling code in the block and
 * network device layers.  Platforms with separate bus address spaces
 * _must_ turn this off and provide a device DMA mapping
 * implementation that takes care of the necessary address
 * translation.
 */
#define PCI_DMA_BUS_IS_PHYS	pci_dma_bus_is_phys

  David> The whole block layer makes all kinds of assumptions about
  David> what physically contiguous addresses mean about how they'll
  David> be contiguous in the bus addresses the device will actually
  David> use to perform the DMA transfer.

This sounds all very dramatic, but try as I might, all I find is three
places where PCI_DMA_BUS_IS_PHYS is used:

	- ide-lib.c: used to disable bounce buffering
	- scsi_lib.c: used to disable bounce buffering
	- tg3.c: what the heck??

The tg3 code looks ugly in the extreme (sorry).  If I understand it
right, it's trying to work around a bug which shows up when a packet
covers a certain address?  With an I/O MMU, you then remap the
offending buffer again before freeing the old mapping which will
ensure a different address of the packet, whereas in the non-I/O MMU
case, you copy the entire socket buffer (since just remapping it won't
change the address and since there is no interface to copy just a
portion of a socket buffer) and then do the remapping.

Did I get this right (or at least close enough)?

It seems really bad to me to rely on implementation-specifics of the
DMA API.  I suspect the code would break on a platform which has
separate bus address spaces but no (hardware) I/O TLB?  (Yeah,
probably not a supported scenarious, but with a proper fix, this
wouldn't be a problem.)

Does this bug happen often enough that it's performance critical?
Otherwise, you could just always use the copy-the-entire-buffer
workaround.  If its performance-critical, would it make sense
to extend the socket buffer API to allow copying a portion of
a buffer?

I really dislike PCI_DMA_BUS_IS_PHYS, because it introduces a
discontinuity.  I don't think it should be necessary.

If it wasn't for tg3.c, couldn't PCI_DMA_BUS_IS_PHYS be gotten rid of
much more cleanly with a dma_max_phys_addr(dev) function, which would
return the maximum physical address that device DEV can address
(either directly, or via an I/O TLB)?

  David> We could convert the few compile time checks of
  David> PCI_DMA_BUS_IS_PHYS so that you can set this based upon the
  David> configuration of the machine if for some configurations it is
  David> true.  drivers/net/tg3.c is the only offender, my bad :-)

Yes.  Would you mind fixing that?

	--david
