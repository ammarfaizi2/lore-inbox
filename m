Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUFRTot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUFRTot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUFRTot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:44:49 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:401 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266741AbUFRTlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:41:13 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       greg@kroah.com, tony@atomide.com, david-b@pacbell.net,
       joshua@joshuawise.com
In-Reply-To: <40D340FB.3080309@hp.com>
References: <1087582845.1752.107.camel@mulgrave>
		<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>  <40D340FB.3080309@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 14:41:04 -0500
Message-Id: <1087587669.1752.147.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 14:22, Jamey Hicks wrote:
> It's really not a question of laziness.  The ASICs we are interested in 
> implement OHCI, so I think the core OHCI driver should work unmodified.  
> OHCI driver allocates dma_pools for managing endpoint descriptors (ED) 
> and transaction descriptors (TD).  I expect that the driver wrapper that 
> initializes the OHCI controller driver will create dma_pools drawing 
> from the ASIC's private SRAM.  The OHCI driver uses 
> dma_{alloc,free}_coherent to manage the space used for the top level 
> control structure shared between the driver and the controller 
> hardware.  This also needs to be allocated in the SRAM.  Finally, in 
> drivers/usb/core/usb.c, the USB drivers call dma_map_single and 
> dma_unmap_single given pointers to transfer buffers allocated by the USB 
> device drivers.  If the USB device is a network device (as it is on the 
> iPAQ), the transfer buffers are allocated via dev_alloc_skb. 

Well, I thought it was something like that.  So the problem could be
solved simply by rejigging ohci to export td_alloc and td_free as
overrideable methods?

Your map and unmap single could also be handled this way: with usb
specific overrides that default to dma_map_single.  None of this would
cause much perturbation in usb, and it would give you everthing you
need.

I assume your implementation of dma_map_single is simply to copy the
memory into the on chip area?

> I really think this is a DMA API implementation issue.  The problem 
> touches more than the USB drivers.  I say implementation because the DMA 
> API already takes struct device, so the public interface would not have 
> to change or would not have to change much.  However, we would like to 
> be able to provide device-specific implementations of the dma 
> operations.  One way to implement this would be a pointer to 
> dma_operations from struct device.

The DMA API is highly platform specific.  It basically embodies a
contract between the platform and its attached busses.  It wasn't
designed to embody a contract between two busses (or in this case, a bus
and its implementing driver).

James


