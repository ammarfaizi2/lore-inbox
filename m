Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265783AbSKBAki>; Fri, 1 Nov 2002 19:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbSKBAki>; Fri, 1 Nov 2002 19:40:38 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:49412 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S265783AbSKBAkg>; Fri, 1 Nov 2002 19:40:36 -0500
Message-ID: <3DC3207A.450402B3@zip.com.au>
Date: Fri, 01 Nov 2002 16:46:50 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [announce] swap mini-howto
References: <Pine.LNX.4.33L2.0211011540140.28320-100000@dragon.pdx.osdl.net> <20021102000907.GA9229@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> Might be nice to mention that using multiple swap partitions
> on different disks will 'stripe' requests across disks a-la-raid0
> 

Yup.

Something I'd like to point out here:  in 2.4 and earlier, swapfiles
are less robust than swap devices - the need to go and read metadata
from the filesystem made them prone to oom deadlocks allocating pages
and buffer_heads with which to perform the swapout.

That has changed in 2.5.  Swapping onto a regular file has no
disadvantage wrt swapping onto a block device.  The kernel does
not need to allocate any memory at all to get a swapcache page
onto disk.

Which is interesting.  Because swapfiles are much easier to administer,
and much easier to stripe.  Adding, removing and resizing is simplified.
Distributors of 2.6-based kernels could consider doing away with
swapdevs altogether.


If you have two disks then it is very sensible to create a swapfile on
each one and to perform an equal-priority stripe between them.  This
will give the best raw swap IO bandwidth.  But it could cause additional
seeking between swap and regular file data.

Dedicating an entire disk to swap will obviously reduce the seeking
problem.

But really, if your application is dependent on swap performance, you
need more RAM.  Swap should be viewed as a lightweight background
optimisation to make unused pages available for other work, rather
than as a cure for an underprovisioned machine.
