Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUFRSH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUFRSH2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUFRSH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:07:28 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:53176 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S265900AbUFRSHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:07:24 -0400
Date: Fri, 18 Jun 2004 11:07:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-ID: <20040618110721.B3851@home.com>
References: <20040618175902.778e616a.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040618175902.778e616a.spyro@f2s.com>; from spyro@f2s.com on Fri, Jun 18, 2004 at 05:59:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 05:59:02PM +0100, Ian Molton wrote:
> I have a System On Chip device which, among other functions, contains an
> OHCI controller and 32K of SRAM.
> 
> heres the catch:- The OHCI controller has a different address space than
> the host bus, and worse, can *only* DMA data from its internal SRAM.
> 
> The architecture is not broken, merely unusual.
> 
> This causes the following problems:
> 
> 1) The DMA API provides no methods to set up a mapping between the host
>    memory map and the devices view of the space
>         example:
>            the OHCI controller above would see its 32K of SRAM as
>            mapped from 0x10000 - 0x1ffff and not 0xXXX10000 - 0xXXX1ffff
>            which is the address the CPU sees.
> 2) The DMA API assumes the device can access SDRAM
>         example:
>            the OHCI controller base is mapped at 0x10000000 on my platform.
>            this is NOT is SDRAM, its in IO space.

Can't you just implement an arch-specific allocator for your 32KB
SRAM, then implement the DMA API streaming and dma_alloc/free APIs
on top of that?  Since this architecture is obviously not designed
for performance, it doesn't seem to be a big deal to have the streaming
APIs copy to/from the kmalloced (or whatever) buffer to/from the SRAM
allocated memory and then have those APIs return the proper dma_addr_t
for the embedded OHCI's address space view of the SRAM. Same thing
goes for implementing dma_alloc/free (used by dma_pool*). I don't
have the knowledge of USB subsystem buffer usage to know how quickly
that little 32KB of SRAM is going to run out. But at a DMA API level,
this seems doable, albeit with the greater possibility of negative
retvals from these calls.

-Matt
