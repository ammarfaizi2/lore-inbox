Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVA1FKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVA1FKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 00:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVA1FKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 00:10:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:487 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261455AbVA1FKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 00:10:34 -0500
Date: Fri, 28 Jan 2005 16:06:14 +1100
From: Nathan Scott <nathans@sgi.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Advice sought on how to lock multiple pages in ->prepare_write and ->writepage
Message-ID: <20050128050614.GC1799@frodo>
References: <1106822924.30098.27.camel@imp.csi.cam.ac.uk> <20050127165822.291dbd2d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127165822.291dbd2d.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

On Thu, Jan 27, 2005 at 04:58:22PM -0800, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >
> > What would you propose can I do to perform the required zeroing in a
> > deadlock safe manner whilst also ensuring that it cannot happen that a
> > concurrent ->readpage() will cause me to miss a page and thus end up
> > with non-initialized/random data on disk for that page?
> 
> The only thing I can think of is to lock all the pages.  There's no other
> place in the kernel above you which locks multiple pagecache pages, but we
> can certainly adopt the convention that multiple-page-locking must proceed
> in ascending file offset order.
> 
> ...
> 
> Not very pretty though.
> 

Just putting up my hand to say "yeah, us too" - we could also make
use of that functionality, so we can grok existing XFS filesystems
that have blocksizes larger than the page size.

Were you looking at using an i_blkbits value larger than pageshift,
Anton?  There's many places where generic code does 1 << i_blkbits
that'll need careful auditing, I think.  A lock-in-page-index-order
approach seems the simplest way to prevent page deadlocks as Andrew
suggested, and always starting to lock pages at the lowest block-
aligned file offset (rather than taking a page lock, dropping it,
locking earlier pages, reaquiring the later one, etc) - that can't
really be done inside the filesystems though..

So it's probably something that should be handled in generic page
cache code such that the locking is done in common places for all
filesystems using large i_blkbits values, and such that locking is
done before the filesystem-specific read/writepage(s) routines are
called, so that they don't have to be changed to do page locking
any differently.

cheers.

-- 
Nathan
