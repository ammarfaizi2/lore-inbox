Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUD1UEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUD1UEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUD1UDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:03:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41862 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261179AbUD1TUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:20:49 -0400
Date: Wed, 28 Apr 2004 12:19:40 -0700
From: "David S. Miller" <davem@redhat.com>
To: Meelis Roos <mroos@linux.ee>
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: video-buf warning
Message-Id: <20040428121940.06a90c02.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.44.0404281150410.24906-100000@math.ut.ee>
References: <Pine.GSO.4.44.0404281150410.24906-100000@math.ut.ee>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004 11:57:38 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

>   CC [M]  drivers/media/video/video-buf.o
> drivers/media/video/video-buf.c: In function `videobuf_iolock':
> drivers/media/video/video-buf.c:327: warning: cast from pointer to integer of different size
 ...
> The specific code is
> /* FIXME: need sanity checks for vb->boff */
> bus   = (dma_addr_t)fbuf->base + vb->boff;
> 
> bus is dma_addr_t (==u32 on sparc64), base is void*
> 
> So if buf->base is really an arbitrary pointer, it might not fit into
> u32. What is it actually?

It is the physical address of a frame buffer, this code is allowing
user programs to point the video capturing to go directly onto a
frame buffer at a specific location.

Using dma_addr_t here is a poor choice, since that data type is to
be used to PCI DMA API interfaces for doing transfers to/from real
memory, not frame buffers and the like :-)

Unfortunately, there is no portable interface available for what
this code wants to do, which is device<-->device DMA transfers.
We would need to create an interface that took two device structures,
and some base+offset values, in order to provide a portable way to
do this, then a reworked version of this user interface would be needed
as well.

In short, it's long term to fix this up, don't worry about it for
now.
