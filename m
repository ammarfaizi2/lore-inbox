Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272108AbRHVUT3>; Wed, 22 Aug 2001 16:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272110AbRHVUTT>; Wed, 22 Aug 2001 16:19:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37805 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272108AbRHVUTL>;
	Wed, 22 Aug 2001 16:19:11 -0400
Date: Wed, 22 Aug 2001 13:19:16 -0700 (PDT)
Message-Id: <20010822.131916.83606270.davem@redhat.com>
To: gibbs@scsiguy.com
Cc: axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200108221941.f7MJfGY14365@aslan.scsiguy.com>
In-Reply-To: <20010822.114620.77339267.davem@redhat.com>
	<200108221941.f7MJfGY14365@aslan.scsiguy.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
   Date: Wed, 22 Aug 2001 13:41:16 -0600

   >
   >Drivers for SAC only PCI devices shall not be bloated by 64-bit type,
   >not in any case whatsoever.
   
   Where's the bloat?  The driver's S/G list is in the driver's native format.

All the world is not a scsi driver.  Consider networking
and other types of drivers that need not make use of
scatter lists.

   >Either your device is 64-bit capable or not, what is so complicated?
   
   The complication arrises when there is a performance impact associated
   with 64bit support.  You may want to completely compile out 64bit support.
   If I can use the exact same API if the user decides to configure my
   device to not enable large address support, then my complaint is only
   that it seems supurfluous to have two different APIs and types.

You can indeed use the same API.  There are two situations.

1) The performance impact is "platform specific", so let the
   platform decide for you:

	Use pci64_foo() and set the DMA mask to what you can support.
	Ie. a normal DAC supporting driver.

2) The performance impact is "device specific", so only use
   the 32-bit API.   

   >What is the virtual address of physical address 0x100000000
   >on a 32-bit cpu system if the page is not currently kmap()'d?
   
   Why does the driver care?  The driver asked to have some virtual address
   mapped into a bus address.  Are you saying the system can't understand
   figure out what physical page this is and from that the necessary
   IOMMU magic to make it visible to the device?
   
It is the object that the block and networking systems work with
that is the issue.

Do you know how physical memory is mapped under Linux?  Everything
non-HIGHMEM is directly mapped.  Everything else must be temporarily
"kmap()'d" so that the kernel and perform loads and stores to that
page.

The only object representation that works for all kinds of pages,
HIGHMEM or not, is the "struct page *page; unsigned long offset;"
tuple.

If this wasn't a problem, Jens's would not be doing any of the
work he is doing right now :-)

   It seems to me that you are complaining that the "backend" implementation
   for IA64 sucked.  Okay.  Fine.  But the drivers were never exposed to
   that suckage.

No, I have in fact no problem with IA64's backend, I don't care how
any platform implements anything.  It is the front end that sucked
balls, and this part I care about because it is the APIs drivers have
to deal with.  Specifically, my gripes are:

1) It took virtual addresses.  Result: does not work on 32-bit
   platforms.

2) It did not take into consideration at all the issues surrounding
   DAC usage on some platforms, such as:

	a) transfers using DAC cycles might run slower than
	   those using SAC cycles
	b) DAC cycles may be preferred even in the presence of
	   slower transfers because the device is "DMA mapping
	   hungry" ala. compute cluster cards.

Let me ask you again: Have you tried to write a driver to the new
APIs at all?  I have for 6 totally different devices, on drivers
written by totally different people (including those I wrote myself)
and they all worked out beautifully.

Later,
David S. Miller
davem@redhat.com
