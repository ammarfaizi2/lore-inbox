Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269468AbUI3T7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269468AbUI3T7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269471AbUI3T7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:59:40 -0400
Received: from p508B778C.dip.t-dialin.net ([80.139.119.140]:41746 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S269468AbUI3T7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:59:15 -0400
Date: Thu, 30 Sep 2004 21:59:03 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       mentre@tcl.ite.mee.com
Subject: Re: How to handle a specific DMA configuration ?
Message-ID: <20040930195903.GB4368@linux-mips.org>
References: <20040928100831.GI27756@enix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928100831.GI27756@enix.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 12:08:31PM +0200, Thomas Petazzoni wrote:

> My physical memory mapping is a bit special : I have 384 MB of
> memory. The first 256MB are directly connected to the RM9000, while
> the last 128MB are connected to the Marvell controller. _Only_ the
> last 128MB are usable for DMA (especially for network traffic). For
> the moment, Linux only takes care of the first 256MB, but I can change
> it to take care of the complete physical memory space (384 MB).
> 
> My problem is the allocation of skbuff. They are allocated using
> alloc_skb() in net/core/skbuff.c, and uses the "normal" kmalloc()
> allocator. kmalloc() will allocate memory somewhere in the physical
> memory space : even if a I allow Linux to allocate memory between
> 256MB and 384MB, I cannot be sure that it will use memory in this
> space to allocate skbuff. If skbuff are not allocated in this space,
> then I can't use DMA to transfer the buffers.
> 
> As I understand the ZONE_DMA thing, it allows to tell Linux that a
> physical memory region located between 0 and some value (16 MB on PCs
> for old ISA cards compatibility) is the only area usable for DMA. How
> could I declare my 256MB-384MB physical memory reagion to be the only
> area usable for DMA ? How can I tell the skbuff functions to allocate
> _only_ DMA-able memory ?

ZONE_DMA has a system specific meaning.  On a PCI system ISA could always
be exist through a PCI-to-ISA bridge, so you can't just go and give it
a system specific meaning.  It's also needed for PCI devices with a
less than 32-bit DMA limit; those exist in a rich variety.

> Moreover, can I make assumptions on the
> alignement of final data at the bottom of the network stack (my DMA
> controller doesn't like the 2 byte-aligned things).

Well, if you put packets on an aligned address you'll later take a bunch
of missalignment exceptions which are going to severly impact networking
performance ...

> At the moment, I see only three solutions. The two first aren't not
> very satisfying, the third might be a solution, but not perfect
> neither (and not sure it would work).

Change the configuration of the board to put the MV memory at the bottom.
Leave ZONE_DMA what it used to be, < 16MB.  Set the ZONE_NORMAL limit to
128MB.  Anything above that is non-dmable will go into ZONE_HIGHMEM.
See also CONFIG_LIMITED_DMA in 2.6.  It works, it has little compatibility
problems but it's a solution for platform that simply doesn't reflect the
Linux hw architecture very much ...

  Ralf
