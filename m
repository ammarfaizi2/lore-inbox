Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267399AbTACFuW>; Fri, 3 Jan 2003 00:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbTACFuW>; Fri, 3 Jan 2003 00:50:22 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:39557 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S267399AbTACFuV>; Fri, 3 Jan 2003 00:50:21 -0500
Date: Thu, 02 Jan 2003 20:50:29 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E151695.1080204@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200301022207.OAA00803@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:

 > 	The pci_pool_alloc  in sa1111-buf.c is more interesting.
 > alloc_safe_buffer is used to implement an unusual version of
 > pci_map_single.  It is unclear to me whether this approach is optimal.
 > I'll look into this more.

Darn if I didn't mention SA1111 up front!  Here's where avoiding
mapping APIs is a win, in favor of allocating dma buffers that
will work from the get go.  (That is, dma_addr_t can usefully push
up the call stack, while gfp_flags pushes down.)

USB device drivers like "hid" and "usblp" do that already; later,
more drivers could convert.

Of course, the ohci-sa1111.c codepaths are also relevant here.
They use pci_pools for TD allocation.  The fact that they use
SLAB_ATOMIC (you missed one!), and once didn't, bothers me;
luckily that became an easy fix a few months back.

And the dma_pool_patch I posted would make all this code morph
to using the slab allocator underneath.  The slab code would be
smarter about managing it than pci_pool, so it'd be better at
sharing that 1 MByte of DMA memory with other devices.

- Dave


