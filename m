Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163448AbWLGVqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163448AbWLGVqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163459AbWLGVqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:46:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:43379 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163448AbWLGVqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:46:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AksnvkjBr3Fzvb09qlBW117nEQS7zr9XA9I4J1yeEesRvK25HyYoNnJOUFMmXw8EiFd62weV5U2oZZ+RvkMQdme8LQNzw4/8OIeOUixf50Cqy08fO8wPIVyl9aLKCC0Erba7sGplKasMI1SAm4DH8ut5VsUpBftzxWWHBBSPQCk=
Message-ID: <5c49b0ed0612071346g5bccedd5q709e5ba66808c7fc@mail.gmail.com>
Date: Thu, 7 Dec 2006 13:46:04 -0800
From: "Nate Diller" <nate.diller@gmail.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [patch] speed up single bio_vec allocation
Cc: "Jens Axboe" <jens.axboe@oracle.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <000101c71a37$00b12000$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5c49b0ed0612071122v4378f853lc6684ed8a7bbbf7f@mail.gmail.com>
	 <000101c71a37$00b12000$ff0da8c0@amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/06, Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> Nate Diller wrote on Thursday, December 07, 2006 11:22 AM
> > > > I still can't help but think we can do better than this, and that this
> > > > is nothing more than optimizing for a benchmark. For high performance
> > > > I/O, you will be doing > 1 page bio's anyway and this patch wont help
> > > > you at all. Perhaps we can just kill bio_vec slabs completely, and
> > > > create bio slabs instead with differing sizes. So instead of having 1
> > > > bio slab and 5 bio_vec slabs, change that to 5 bio slabs that leave room
> > > > for the bio_vec list at the end. That would always eliminate the extra
> > > > allocation, at the cost of blowing the 256-page case into a order 1 page
> > > > allocation (256*16 + sizeof(*bio) > PAGE_SIZE) for the 4kb 64-bit archs,
> > > > which is something I've always tried to avoid.
> > >
> > > I took a quick query of biovec-* slab stats on various production machines,
> > > majority of the allocation is on 1 and 4 segments, usages falls off quickly
> > > on 16 or more.  256 segment biovec allocation is really rare.  I think it
> > > makes sense to heavily bias towards smaller biovec allocation and have
> > > separate biovec allocation for really large ones.
> >
> > what file system?  have you tested with more than one?  have you
> > tested with file systems that build their own bio's instead of using
> > get_block() calls?  have you tested with large files or streaming
> > workloads?  how about direct I/O?
> >
> > i think that a "heavy bias" toward small biovecs is FS and workload
> > dependent, and that it's irresponsible to make such unjustified
> > changes just to show improvement on your particular benchmark.
>
> It is no doubt that the above data is just a quick estimate on one
> usage model. There are tons of other usage in the world.  After all,
> any algorithm in the kernel has to be generic and self tune to
> specific environment.
>
> On very large I/O, the relative overhead in allocating biovec will
> decrease because larger I/O needs more code to do setup, more code
> to perform I/O completion, more code in the device driver etc. So
> time spent on one mempool alloc will amortize over the size of I/O.
> On a smaller I/O size, the overhead is more visible and thus makes
> sense to me to cut down that relative overhead.
>
> In fact, the large I/O already have unfair advantage.  If you do 1MB
> I/O, only 1 call to mempool to get a 256 segment bio.  However if you
> do two 512K I/O, two calls to mempool is made.  So in some sense,
> current scheme is unfair to small I/O.

so that's a fancy way of saying "no, i didn't do any benchmarks", yes?

the current code is straightforward and obviously correct.  you want
to make the alloc/dealloc paths more complex, by special-casing for an
arbitrary limit of "small" I/O, AFAICT.  of *course* you can expect
less overhead when you're doing one large I/O vs. two small ones,
that's the whole reason we have all this code to try to coalesce
contiguous I/O, do readahead, swap page clustering, etc.  we *want*
more complexity if it will get us bigger I/Os.  I don't see why we
want more complexity to reduce the *inherent* penalty of doing smaller
ones.

btw, i am happy to see that you are working on performance, especially
to the degree you reduce overhead by cleaning things up and removing
cruft and unneeded complexity...

NATE
