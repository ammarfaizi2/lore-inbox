Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVBSTgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVBSTgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 14:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVBSTgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 14:36:13 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:41109 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261561AbVBSTgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 14:36:08 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() && irqs_disabled()
Date: Sat, 19 Feb 2005 11:36:05 -0800
User-Agent: KMail/1.7.1
Cc: scjody@modernduck.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502191136.05584.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Jody - Is the 200K waste for sure or do you want me to verify it by some 
> > means? ( Reason I am asking is firstly, Dave Brownell was quite sure it 
> > wasn't that costly and secondly, I am hoping it isn't.. ;)
> 
> I'm not sure, but I looked through the code and it seems to allocate:
>  - 16 buffers of 2x PAGE_SIZE (= 131072 on i386)
>  - 16 buffers of PAGE_SIZE (= 65536 on i386)
>  - various other smaller structures.
> 
> I'm not sure how to actually _measure_ how much memory this is using.
> slabinfo isn't useful, at least on my system, because the 1394
> allocations get lost in the noise of other activity.

Those allocations could be from _using_ a dma pool ... but they're
not from just creating one!

The cost of creating the dma_pool is the cost of one small kmalloc()
plus (the expensive part) the /sys/devices/.../pools sysfs attribute
is created along with the first pool.  (Use that instead of slabinfo
for those pool allocations.)  That's why the normal spot to create and
destroy dma pools is in driver probe() and remove() methods.

If you want to allocate gobs of other stuff at the same time, that's
your choice ... but it'd be a separate issue.  Cost to create a
dma_pool is significantly less than PAGE_SIZE, and there's no good
reason to allocate or destroy those pools anywhere near an IRQ context.

- Dave
