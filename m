Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSL1DbC>; Fri, 27 Dec 2002 22:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSL1DbB>; Fri, 27 Dec 2002 22:31:01 -0500
Received: from h-64-105-35-71.SNVACAID.covad.net ([64.105.35.71]:17592 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265414AbSL1DbB>; Fri, 27 Dec 2002 22:31:01 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 27 Dec 2002 19:39:13 -0800
Message-Id: <200212280339.TAA25950@adam.yggdrasil.com>
To: manfred@colorfulllife.com
Subject: Re:  [RFT][PATCH] generic device DMA implementation
Cc: dvaid-b@pacbell.net, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-12-17 Manfred Spraul wrote the following, which I am taking
out of order:

>+Warnings:  Memory coherency operates at a granularity called the cache
>+line width. [...]

	That's a description of "inconsistent" memory.  "Consistent"
memory does not have the cache line problems.  It is uncached.
Architectures that cannot allocate memory with this property cannot
allocate consistent memory, and accomodating what I think motivated
James to take a whack at this.

>The driver must use the normal memory barrier instructions even in 
>coherent memory.

	I know Documentation/DMA-mapping.txt says that, and I
understand that wmb() is necessary with consistent memory, but I
wonder if rmb() really is, at least if you've declared the data
structures in question as volatile to prevent reordering of reads by
the compiler.

>- kmalloc (32,GFP_KERNEL) returns a 32-byte object, even if the cache
>line size is 128 bytes.  The 4 objects in the cache line could be used
>by four different users. - sendfile() with an odd offset.

	+1 Insightful

	I think we could use a GFP_ flag for kmallocs that are
intended for DMA (typically networking and USB packets) that would
cause the memory allocation to be aligned and rounded up to a multiple
of cache line size.  There probably are only a dozen or so such
kmallocs, but I think it's enough so that having a kmalloc flag
would result in a smaller kernel than without it.

	As you've pointed out with your sendfile() example, the
problem you've identified goes beyond kmalloc.  I'm still mulling it
over, but it's worth noting that it is not a new problem introduced by
the generic DMA interface.  Thanks for raising it though.  I hadn't
thought of it before.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
