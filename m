Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269415AbUJSOWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269415AbUJSOWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 10:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269419AbUJSOWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 10:22:16 -0400
Received: from holomorphy.com ([207.189.100.168]:39080 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269415AbUJSOWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 10:22:13 -0400
Date: Tue, 19 Oct 2004 07:22:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA memory allocation --how to  more than 1 MB
Message-ID: <20041019142209.GL5607@holomorphy.com>
References: <4EE0CBA31942E547B99B3D4BFAB34811175F32@mail.esn.co.in> <20041019135214.GA29435@core.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019135214.GA29435@core.home>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 11:18:13AM +0530, Srinivas G. wrote:
>> I have a doubt about allocating the DMA memory using kmalloc OR
>> __get_dma_pages OR pci_alloc_consistent. I was unable to allocate the
>> memory greater than 1 MB using any one of the above memory functions. 
>> Is there any other method which will allocate the DMA memory greater
>> than 1 MB?

On Tue, Oct 19, 2004 at 03:52:14PM +0200, Christian Leber wrote:
> You should be able to get at least order 9, therefore 2 MB.
> With kernel 2.6 you should also be able to get order 10, therefore 4 MB.
> If you need more you have to puzzle the areas together.
> The way wli suggested is better.
> But if this is no possible just make it a requierement to load the
> module while booting, then there are enough free areas.

Please understand that the possibility of requesting higher orders at
runtime is not the same as a guarantee. While it is allowed to request
such large physically contiguous areas, there is no assurance of success,
so any requester of such large areas doing so at runtime must
understand alternative methods of carrying out its task when such large
physically contiguous areas are unavailable, as they typically are after
even small amounts of runtime because of external memory fragmentation.

Consider, for example, i386 hugetlb. Hugetlb can't function at all
without large physically contiguous areas of order 9 or 10 on i386 as
the hardware it programs has such contiguity as an absolute requirement.
Toward the ends I described, when a request is made for it to increase
the size of its memory pool, it does not rely on the success of the
allocations, but instead only increases the size of its pool by the
amount of memory that was successfully allocated. Also, for the purpose
of reliably obtaining the memory, a kernel command-line option was
implemented carrying out these allocations at boot-time.

Constraints analogous to hugetlb's are truly rarely encountered in the
context of I/O devices. Those typically support scatter/gather, and in
general should use that feature to operate on physically discontiguous
memory as opposed to relying upon large contiguous allocations. Please
ignore the numerous examples in the kernel contradicting me, as they
are generally not thought well of.


-- wli
