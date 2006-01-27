Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWA0Ukt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWA0Ukt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWA0Ukt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:40:49 -0500
Received: from lixom.net ([66.141.50.11]:26319 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1161017AbWA0Uks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:40:48 -0500
Date: Sat, 28 Jan 2006 09:40:22 +1300
To: Mark Haverkamp <markh@osdl.org>
Cc: "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: iommu_alloc failure and panic
Message-ID: <20060127204022.GA26653@pb15.lixom.net>
References: <1138381060.11796.22.camel@markh3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138381060.11796.22.camel@markh3.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 27, 2006 at 08:57:40AM -0800, Mark Haverkamp wrote:
> While running a disk test (bonnie++) I have been seeing iommu_alloc
> failed messages in the syslog leading to a panic.   The machine that I

Hmm. The IOMMU code tries to be clever and not write on a cacheline
that's already in use, to avoid invalidating cached entries on the I/O
bridges.

Since a cache line is 128 bytes (16 entries), this means it advances
that much on each allocation, and tries to allocate a new entry in the
next block of 16. Essentially it is fragmenting the allocation space on
purpose.

So far I haven't seen anyone else have problems with this. I'm
suspecting that the SCSI probe code might map something per disk (or
similar), such that there's alot of small allocations being done, each
using up part of a line. once the end of the allocation space is
reached, the allocator wraps to the beginning and starts walking again.

Since this greatly reduces the chance of allocating anything 16 pages or
more, a part of the table (25%) is set aside and used for the large
allocations. If an allocation in one section of the table (large/small)
doesn't succeed, the other half is also searched.

Each allocation in your report is 10 entries, so that means that at
least 7 must be taken on each line, since the allocation won't go to the
large area by default.

Can you try this, just to confirm that this is what we're seeing?

1. In iommu_setparms_lpar() in arch/powerpc/platforms/pseries/iommu.c,
can you try changing it_blocksize from 16 to 1?


Thanks,

Olof

