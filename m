Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVAYQP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVAYQP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVAYQP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:15:28 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:20869 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261995AbVAYQMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:12:35 -0500
Date: Tue, 25 Jan 2005 16:12:31 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Andi Kleen <ak@muc.de>
Cc: "Mukker, Atul" <Atulm@lsil.com>, "'Steve Lord'" <lord@xfs.org>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Linux Memory Management List'" <linux-mm@kvack.org>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Grant Grundler'" <grundler@parisc-linux.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
In-Reply-To: <20050125145602.GB75109@muc.de>
Message-ID: <Pine.LNX.4.58.0501251603360.1203@skynet>
References: <0E3FA95632D6D047BA649F95DAB60E5705A70E61@exa-atlanta>
 <20050125145602.GB75109@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005, Andi Kleen wrote:

> On Tue, Jan 25, 2005 at 09:02:34AM -0500, Mukker, Atul wrote:
> >
> > > e.g. performance on megaraid controllers (very popular
> > > because a big PC vendor ships them) was always quite bad on
> > > Linux. Up to the point that specific IO workloads run half as
> > > fast on a megaraid compared to other controllers. I heard
> > > they do work better on Windows.
> > >
> > <snip>
> > > Ideally the Linux IO patterns would look similar to the
> > > Windows IO patterns, then we could reuse all the
> > > optimizations the controller vendors did for Windows :)
> >
> > LSI would leave no stone unturned to make the performance better for
> > megaraid controllers under Linux. If you have some hard data in relation to
> > comparison of performance for adapters from other vendors, please share with
> > us. We would definitely strive to better it.
>
> Sorry for being vague on this. I don't have much hard data on this,
> just telling an annecdote. The issue we saw was over a year ago
> and on a machine running an IO intensive multi process stress test
> (I believe it was an AIM7 variant with some tweaked workfile). When the test
> was moved to a machine with megaraid controller it ran significantly
> lower, compared to the old setup with a non RAID SCSI controller from
> a different vendor. I unfortunately don't know anymore the exact
> type/firmware revision etc. of the megaraid that showed the problem.
>

Ok, for me here, the bottom line is that decent hardware will not benefit
from help from the allocator. Worse, if the work required to provide
adjacent pages is high, it will even adversly affect throughput. I know as
well that to have physically contiguous pages in userspace would involve a
fair amount of overhead so even if we devise a system for providing them,
it would need to be a configurable option.

I will keep an eye out for a means of granting physically contiguous pages
for userspace in a lightweight manner but I'm going to focus on general
availability of large pages for TLBs, extend the system for a pool of
zero'd pages and how it can be adapted to help out the hotplug folks.

The system I have in mind for contiguous pages for userspace right now is
to extend the allocator API so that prefaulting and readahead will request
blocks of pages for userspace rather than a series of order-0 pages. So,
if we prefault 32 pages ahead, the allocator would have a new API that
would return 32 pages that are physically contiguous. That, in combination
with forced IOMMU may show if Contiguous Pages For IO is worth it or not.

This will take a while as I'll have to develop some mechanism for
measuring it while I'm at it and I only do this 2 days a week so it'll
take a while.

-- 
Mel Gorman
