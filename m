Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945976AbWJSBwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945976AbWJSBwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 21:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945977AbWJSBwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 21:52:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23520 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1945976AbWJSBwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 21:52:44 -0400
Date: Thu, 19 Oct 2006 11:52:20 +1000
From: David Chinner <dgc@sgi.com>
To: Christoph Hellwig <hch@lst.de>
Cc: xfs-masters@oss.sgi.com, linux kernel <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: [xfs-masters] [PATCH] fs/xfs: Handcrafted MIN/MAX macro removal
Message-ID: <20061019015220.GV11034@melbourne.sgi.com>
References: <1161160132.20400.115.camel@amol.verismonetworks.com> <20061018094956.GA19048@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018094956.GA19048@lst.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 11:49:56AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 18, 2006 at 01:58:52PM +0530, Amol Lad wrote:
> > --- linux-2.6.19-rc2-orig/fs/xfs/xfs_btree.h	2006-10-18 09:29:18.000000000 +0530
> > +++ linux-2.6.19-rc2/fs/xfs/xfs_btree.h	2006-10-18 11:25:46.000000000 +0530
> > @@ -18,6 +18,8 @@
> >  #ifndef __XFS_BTREE_H__
> >  #define	__XFS_BTREE_H__
> >  
> > +#include <linux/kernel.h>
> > +
> 
> This file is also used in libxfs, so you can't just include this header
> directly.  On the other hand it should always get kernel.h through
> xfs_linux.h anyway so you might aswell just leave the include out.

*nod* - the include is not needed here.

> > +#define	XFS_EXTLEN_MIN(a,b)   (min_t(xfs_extlen_t,a,b))
> > +#define	XFS_EXTLEN_MAX(a,b)	  (max_t(xfs_extlen_t,a,b))
> > +#define	XFS_AGBLOCK_MIN(a,b)  (min_t(xfs_agblock_t,a,b))
> > +#define	XFS_AGBLOCK_MAX(a,b)  (max_t(xfs_agblock_t,a,b))
> > +#define	XFS_FILEOFF_MIN(a,b)  (min_t(xfs_fileoff_t,a,b))
> > +#define	XFS_FILEOFF_MAX(a,b)  (max_t(xfs_fileoff_t,a,b))
> > +#define	XFS_FILBLKS_MIN(a,b)  (min_t(xfs_filblks_t,a,b))
> > +#define	XFS_FILBLKS_MAX(a,b)  (max_t(xfs_filblks_t,a,b))
> 
> At this point we might aswell kill these UGLY SHOUTING macros and
> use min_t/max_t (or just min/max where appropinquate) directly.

No way.

> >  			error = xfs_rtallocate_extent_block(mp, tp, i,
> > -					XFS_RTMAX(minlen, 1 << l),
> > -					XFS_RTMIN(maxlen, (1 << (l + 1)) - 1),
> > +					max(minlen, (xfs_extlen_t)(1 << l)),
> > +					min(maxlen, (xfs_extlen_t)((1 << (l + 1)) - 1)),
> 
> these would be a lot more readable as
> 
> 					max_t(xfs_extlen_t, minlen, (1 << l)),
> 					min_t(xfs_extlen_t, maxlen,
> 					      ((1 << (l + 1)) - 1)),
> 
> wouldn, it?

No. I look at that XFS_RTMAX() macro and I *know* we are doing the
correct compare for that type of object. I look at the max_t version
and think to myself "is that correct, or is it done differently
elsewhere?". That macro says "I'm doing the right thing", and that
is invaluable information when it comes to reading the code and
tracking down bugs.

By removing the macros completely, we no longer know exactly where
in the code we compare distinct types, nor do we have a consistent
manner in which to compare them. When it comes to doing future mods,
we're now completely reliant on the developer finding all the places
we compare the distinct types and/or adding new compares using the
same code. This is a Bad Thing.

So while I'm happy with the original patch that just changes the
macro implementation (minus the include), I really dislike the
followup patch that removes the macros altogether because of these
reasons.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
