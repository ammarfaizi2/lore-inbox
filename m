Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966975AbWLDUhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966975AbWLDUhN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966980AbWLDUhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:37:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:26892 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966975AbWLDUhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:37:11 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,494,1157353200"; 
   d="scan'208"; a="170081931:sNHT3482351509"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <jens.axboe@oracle.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] speed up single bio_vec allocation
Date: Mon, 4 Dec 2006 12:36:56 -0800
Message-ID: <000601c717e3$f098a8a0$2589030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccX36pXZLGai6tdTpCUApdBEeUGQgAAq4og
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20061204200645.GN4392@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote on Monday, December 04, 2006 12:07 PM
> On Mon, Dec 04 2006, Chen, Kenneth W wrote:
> > On 64-bit arch like x86_64, struct bio is 104 byte.  Since bio slab is
> > created with SLAB_HWCACHE_ALIGN flag, there are usually spare memory
> > available at the end of bio.  I think we can utilize that memory for
> > bio_vec allocation.  The purpose is not so much on saving memory consumption
> > for bio_vec, instead, I'm attempting to optimize away a call to bvec_alloc_bs.
> > 
> > So here is a patch to do just that for 1 segment bio_vec (we currently only
> > have space for 1 on 2.6.19).  And the detection whether there are spare space
> > available is dynamically calculated at compile time.  If there are no space
> > available, there will be no run time cost at all because gcc simply optimize
> > away all the code added in this patch.  If there are space available, the only
> > run time check is to see what the size of iovec is and we do appropriate
> > assignment to bio->bi_io_Vec etc.  The cost is minimal and we gain a whole
> > lot back from not calling bvec_alloc_bs() function.
> > 
> > I tried to use cache_line_size() to find out the alignment of struct bio, but
> > stumbled on that it is a runtime function for x86_64. So instead I made bio
> > to hint to the slab allocator to align on 32 byte (slab will use the larger
> > value of hw cache line and caller hints of "align").  I think it is a sane
> > number for majority of the CPUs out in the world.
> 
> Any benchmarks for this one?

About 0.2% on database transaction processing benchmark.  It was done a while
back on top of a major Linux vendor kernel. I will retest it again for 2.6.19.


> [...]
> 
> Another idea would be to kill SLAB_HWCACHE_ALIGN (it's pretty pointless,
> I bet), and always alloc sizeof(*bio) + sizeof(*bvl) in one go when a
> bio is allocated. It doesn't add a lot of overhead even for the case
> where we do > 1 page bios, and it gets rid of the dual allocation for
> the 1 page bio.

I will try that too.  I'm a bit touchy about sharing a cache line for different
bio.  But given that there are 200,000 I/O per second we are currently pushing
the kernel, the chances of two cpu working on two bio that sits in the same
cache line are pretty small.

- Ken
