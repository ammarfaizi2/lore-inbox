Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVFPCVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVFPCVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 22:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVFPCVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 22:21:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29378 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261554AbVFPCUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 22:20:46 -0400
Date: Thu, 16 Jun 2005 12:18:22 +1000
From: Dave Chinner <dgc@sgi.com>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Hans Reiser <reiser@namesys.com>, fs <fs@ercist.iscas.ac.cn>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       viro VFS <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, sct@redhat.com, shaggy@austin.ibm.com,
       linux-xfs@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [RFD] FS behavior (I/O failure) in kernel summit
Message-ID: <20050616121822.E125706@melbourne.sgi.com>
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <42ADFFD5.1090905@suse.com> <42AE1EE4.5090508@namesys.com> <42B067B6.9030009@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42B067B6.9030009@suse.com>; from jeffm@suse.com on Wed, Jun 15, 2005 at 01:39:02PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 01:39:02PM -0400, Jeff Mahoney wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hans Reiser wrote:
> > Jeff, would you be willing to make a proposal for what should be done? 
> > I would be interested in your suggestions.
> > 
> > Jeff Mahoney wrote:
> > 
> >>Hans -
> >>
> >>These tests must have been run on a kernel prior to 2.6.10-rc1. The I/O
> >>error code exhibits behavior similar to ext3, so (1b). There are still
> >>kinks to be worked out, but it's definitely not the "throw up our arms
> >>and give up" that it used to be.
> >>
> >>Implementing behavior 1a for ext3 and reiserfs should be fairly trivial
> >>- it just means that tests to check if the filesystem is in an aborted
> >>state ("shutdown" in xfs terms) need to added to the call path in some
> >>places, and be moved earlier in others.
> 
> Well it seems to me that all the XFS code does is check to see if the FS
> is in a shutdown state really early in the call path.

FYI, the up front checks in XFS are simply to stop new I/O from starting
if we're already in the shutdown state.

However, there's more than that in XFS - there's checks all through
it's I/O paths so that I/Os and transactions in flight at (or
started after) the time of the shutdown can be aborted before doing
further damage to a potentially corrupted filesystem. This part
cannot be done generically as it is intimately tied to the
filesystem.

It is also worth noting that XFS won't shutdown a filesystem on just
any I/O error. Shutdowns due to I/O errors only occur when the
failure has the potential to leave the filesystem in an inconsistent
state.  Hence any given operation can return different errors
depending on where the I/O error occurred in XFS and what effect
that I/O error has on the consistency of the filesystem.....

BTW, the correct list to use to get the attention of the XFS folk
is linux-xfs@oss.sgi.com.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Engineer
SGI Australian Software Group
