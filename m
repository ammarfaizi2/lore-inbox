Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937086AbWLFSqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937086AbWLFSqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937105AbWLFSqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:46:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:18263 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937086AbWLFSqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:46:11 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,505,1157353200"; 
   d="scan'208"; a="23944616:sNHT19251954"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <jens.axboe@oracle.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] speed up single bio_vec allocation
Date: Wed, 6 Dec 2006 10:19:39 -0800
Message-ID: <000001c71963$17d88130$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccZHnIaAavjHH94QdmLo2Oe1qdRtAAQicDw
In-Reply-To: <20061206100847.GP4392@kernel.dk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote on Wednesday, December 06, 2006 2:09 AM
> > > I will try that too.  I'm a bit touchy about sharing a cache line for
> > > different bio.  But given that there are 200,000 I/O per second we are
> > > currently pushing the kernel, the chances of two cpu working on two
> > > bio that sits in the same cache line are pretty small.
> > 
> > Yep I really think so. Besides, it's not like we are repeatedly writing
> > to these objects in the first place.
> 
> This is what I had in mind, in case it wasn't completely clear. Not
> tested, other than it compiles. Basically it eliminates the small
> bio_vec pool, and grows the bio by 16-bytes on 64-bit archs, or by
> 12-bytes on 32-bit archs instead and uses the room at the end for the
> bio_vec structure.

Yeah, I had a very similar patch queued internally for the large benchmark
measurement.  I will post the result as soon as I get it.


> I still can't help but think we can do better than this, and that this
> is nothing more than optimizing for a benchmark. For high performance
> I/O, you will be doing > 1 page bio's anyway and this patch wont help
> you at all. Perhaps we can just kill bio_vec slabs completely, and
> create bio slabs instead with differing sizes. So instead of having 1
> bio slab and 5 bio_vec slabs, change that to 5 bio slabs that leave room
> for the bio_vec list at the end. That would always eliminate the extra
> allocation, at the cost of blowing the 256-page case into a order 1 page
> allocation (256*16 + sizeof(*bio) > PAGE_SIZE) for the 4kb 64-bit archs,
> which is something I've always tried to avoid.

I took a quick query of biovec-* slab stats on various production machines,
majority of the allocation is on 1 and 4 segments, usages falls off quickly
on 16 or more.  256 segment biovec allocation is really rare.  I think it
makes sense to heavily bias towards smaller biovec allocation and have
separate biovec allocation for really large ones.

- Ken
