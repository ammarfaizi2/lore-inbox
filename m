Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbUKSLoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUKSLoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 06:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUKSLoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 06:44:44 -0500
Received: from dp.samba.org ([66.70.73.150]:41890 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261358AbUKSLof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 06:44:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16797.56428.329257.785330@samba.org>
Date: Fri, 19 Nov 2004 22:43:40 +1100
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <20041119101600.GM1974@schnapps.adilger.int>
References: <1098383538.987.359.camel@new.localdomain>
	<16797.41728.984065.479474@samba.org>
	<20041119101600.GM1974@schnapps.adilger.int>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas,

 > Also, we (CFS) have developed patches for ext3 + e2fsprogs to support
 > "fast" EAs stored in larger inodes on disk, and this can improve
 > performance dramatically in the case where you are accessing a large
 > number of inodes with EAs just.

yep, that could help a lot. I imagine it will provide a similar
benefit to the option to expand the inode size in XFS, which certainly
made a huge difference.

 > This patch also provides the infrastructure on disk for storing e.g.
 > nsecond and create timestamps in the ext3 large inodes, but the actual
 > implementation to save/load these isn't there yet.  If that were
 > available, would you use it instead of explicitly storing the NTTIME in
 > an EA?

certainly! 

For Samba4 we need 4 timestamps (create/change/write/access),
preferably all with 100ns resolution or better. All 4 timestamps need
to be settable (unlike st_ctime in posix).

The strategy I've adopted is this:

 - use st_atime and st_mtime for the access and write time fields,
   with nanosecond resolution if available, otherwise with 1 second
   resolution. It's just too expensive to update an EA on every
   read/write, so I didn't put these in the DosAttrib EA.

 - store create_time and change_time in the user.DosAttrib xattr, as
   64 bit 100ns resolution times (same format as NT uses and Samba
   uses internally). I store change_time there as its definition is a
   little different from the posix ctime field (plus its settable).

If we had a settable create_time field in the inode then I'd certainly
want to use it in Samba4. A non-settable one wouldn't be nearly as
useful. Some win32 applications care about being able to set all the
time fields (such as excel 2003).

This wouldn't allow us to get rid of the user.DosAttrib xattr
completely though, as we stick a bunch of other stuff in there and
will be expanding it soon to help with the case-insensitive speed
problem.

>  I believe the 2.6 stat interface will support nsecond timestamps,

yep, we are already using st.st_atim.tv_nsec when configure detects
it. It's very useful, but the fact that ext3 doesn't store this on
disk leads to potential problems when timestamps regress if inodes are
ejected from the cache under memory pressure. That needs fixing.

 > but I don't think there is any API to get the create time to userspace
 > though we could hook this up to a pseudo EA.  The benefit of storing
 > these common fields in the inode instead of EAs is less overhead.

I think it would make more sense to have a new varient of utime() for
setting all available timestamps, and expose all timestamps in stat. A
separate API for create time seems a bit hackish.

 > I would just configure out the xattr sharing code entirely since it will
 > likely do nothing but increase overhead if any of the EAs on an inode
 > are unique (this is the most common case, except for POSIX-ACL-only setups).

I didn't know it was configurable. I can't see any CONFIG option for
it - is there some trick I've missed?

 > I've attached this patch here.

I'll give it a go and let you know how it changes the NBENCH results.

Cheers, Tridge
