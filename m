Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbUKBRrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbUKBRrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUKBRpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:45:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5032 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261295AbUKBRlZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 12:41:25 -0500
Date: Tue, 2 Nov 2004 12:44:29 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: __GFP flags and kmalloc failures
Message-ID: <20041102144429.GG32054@logos.cnet>
References: <4187AC80.6050409@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4187AC80.6050409@drzeus.cx>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 04:49:20PM +0100, Pierre Ossman wrote:
> I'm trying to allocate a buffer to be used for ISA DMA and I'm 
> experiencing some difficulties.
> 
> I'm allocating a 64kB buffer (max size for low ISA DMA) using:
> 
> kmalloc(65536, GFP_KERNEL | GFP_DMA);
> 
> The choice of flags are from another driver that does ISA DMA so I 
> didn't put too much thought into them at first.
> 
> The problem is now that this allocation doesn't always succeed. When it 
> fails I get:
> 
> insmod: page allocation failure. order:4, mode:0x11

This is a big allocation and the kernel is having problem finding such a 
big page, due to memory fragmentation (as you mention below).

What kernel version are you using?

-mm contains a series of patches from Nick which should make the situation 
better, have you tried it? Currently kswapd doenst honour high order 
page shortage.

> and a nice little stack dump.
> 
> Digging around in gfp.h to see if I have the proper flags I find that I 
> currently have the following:
> 
> * __GFP_WAIT : This seems to indicate that the process should be put to 
> sleep until the allocation can succeed. Doesn't seem to work that way 
> though.
> 
> * __GFP_IO : What is meant with physical IO? PCI DMA? This buffer needs 
> only be read by the ISA DMA controller and the driver in kernel space. 
> Any useful data is copied to other buffers.
> 
> * __GFP_FS : Since the data is copied before use this probably isn't needed.
> 
> * __GFP_DMA : From what I've been told, this flags causes the allocator 
> to do the magic required for the buffer to end up i memory accessible 
> from the ISA DMA controller. So this seems to be the only flag that 
> actually does anything useful.
> 
> My question is now, why does the allocation fail (sometimes) and what 
> should I do about it?
> 
> Memory fragmentation and overusage seems like reasons to why but why 
> doesn't the kernel throw out cache pages and reorganise user pages so 
> that the allocation can succeed?

We're working on that.

> As for solutions I've tried using __GFP_REPEAT which seems to do the 
> trick. But the double underscore indicates (at least to me) that these 
> are internal defines that shouldn't be used except for very special 
> cases. What is the policy about these?

Its OK to use these flags externally. They might change in future major kernel
versions though, or even future v2.6 release.  ie its not a stable API.
