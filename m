Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbUBXWiB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbUBXWhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:37:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:12729 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262511AbUBXWeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:34:36 -0500
Date: Tue, 24 Feb 2004 14:36:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: cw@f00f.org, piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
Message-Id: <20040224143618.368dfdca.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0402241553550.21522-100000@chimarrao.boston.redhat.com>
References: <20040224012222.453e7db7.akpm@osdl.org>
	<Pine.LNX.4.44.0402241553550.21522-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> On Tue, 24 Feb 2004, Andrew Morton wrote:
> > Chris Wedgwood <cw@f00f.org> wrote:
> > > On Tue, Feb 24, 2004 at 03:11:40PM +1100, Nick Piggin wrote:
> > > 
> > > > Out of interest, what is the worst you can make it do with
> > > > contrived cases?
> > > 
> > > 700MB slab used.
> > 
> > Sigh.  There is absolutely nothing wrong with having a large slab cache. 
> > And there is nothing necessarily right about having a small one.
> 
> Could it be that the lower zone protection stuff simply means
> that Chris's system only ever allocates page cache and anonymous
> memory from his 600 MB highmem, leaving the 900 MB lowmem for
> the slab cache to roam freely ?

The lower-zone protection code will only preserve an extra megabyte or so
of the normal zone in response to __GFP_HIGHMEM allocations, so it won't be
coming into play here.

I'd prefer to replace the lower-zone/incremental-min code with 2.4's
watermark code.  It's pretty much equivalent, but makes the calculations
once-only and it is easier to observe and understand its effects.  But
there's too much work going on in there to make this change at present.


> I guess highmem allocations really should put some pressure on
> lowmem, even when there is enough lowmem free, because otherwise
> you end up effectively not using half of the memory on 1.5-2 GB
> systems for paging ...

Yup.  With the current -mm patches the reclaim rate from lowmem and highmem
is nicely proportional to each zone's size for pagecache-heavy workloads. 
For lowmem-intensive workloads the reclaim rate from lowmem is higher, as
one would expect.  It seems to be working OK now.

