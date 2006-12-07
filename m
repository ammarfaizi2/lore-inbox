Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163226AbWLGTgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163226AbWLGTgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163228AbWLGTgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:36:35 -0500
Received: from mga03.intel.com ([143.182.124.21]:18941 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163226AbWLGTge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:36:34 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,510,1157353200"; 
   d="scan'208"; a="155269037:sNHT83511974"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nate Diller'" <nate.diller@gmail.com>
Cc: "Jens Axboe" <jens.axboe@oracle.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] speed up single bio_vec allocation
Date: Thu, 7 Dec 2006 11:36:33 -0800
Message-ID: <000101c71a37$00b12000$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccaNQyaXK/u1QVHTHe4X681RHpsMQAADVHw
In-Reply-To: <5c49b0ed0612071122v4378f853lc6684ed8a7bbbf7f@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller wrote on Thursday, December 07, 2006 11:22 AM
> > > I still can't help but think we can do better than this, and that this
> > > is nothing more than optimizing for a benchmark. For high performance
> > > I/O, you will be doing > 1 page bio's anyway and this patch wont help
> > > you at all. Perhaps we can just kill bio_vec slabs completely, and
> > > create bio slabs instead with differing sizes. So instead of having 1
> > > bio slab and 5 bio_vec slabs, change that to 5 bio slabs that leave room
> > > for the bio_vec list at the end. That would always eliminate the extra
> > > allocation, at the cost of blowing the 256-page case into a order 1 page
> > > allocation (256*16 + sizeof(*bio) > PAGE_SIZE) for the 4kb 64-bit archs,
> > > which is something I've always tried to avoid.
> >
> > I took a quick query of biovec-* slab stats on various production machines,
> > majority of the allocation is on 1 and 4 segments, usages falls off quickly
> > on 16 or more.  256 segment biovec allocation is really rare.  I think it
> > makes sense to heavily bias towards smaller biovec allocation and have
> > separate biovec allocation for really large ones.
> 
> what file system?  have you tested with more than one?  have you
> tested with file systems that build their own bio's instead of using
> get_block() calls?  have you tested with large files or streaming
> workloads?  how about direct I/O?
> 
> i think that a "heavy bias" toward small biovecs is FS and workload
> dependent, and that it's irresponsible to make such unjustified
> changes just to show improvement on your particular benchmark.

It is no doubt that the above data is just a quick estimate on one
usage model. There are tons of other usage in the world.  After all,
any algorithm in the kernel has to be generic and self tune to
specific environment.

On very large I/O, the relative overhead in allocating biovec will
decrease because larger I/O needs more code to do setup, more code
to perform I/O completion, more code in the device driver etc. So
time spent on one mempool alloc will amortize over the size of I/O.
On a smaller I/O size, the overhead is more visible and thus makes
sense to me to cut down that relative overhead.

In fact, the large I/O already have unfair advantage.  If you do 1MB
I/O, only 1 call to mempool to get a 256 segment bio.  However if you
do two 512K I/O, two calls to mempool is made.  So in some sense,
current scheme is unfair to small I/O.

- Ken
