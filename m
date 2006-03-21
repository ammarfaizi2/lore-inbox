Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWCURGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWCURGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWCURGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:06:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4056 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932330AbWCURGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:06:21 -0500
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Takashi Sato <sho@bsd.tnes.nec.co.jp>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060320234829.GJ6199@schatzie.adilger.int>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp>
	 <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com>
	 <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
	 <20060316183549.GK30801@schatzie.adilger.int>
	 <20060316212632.GA21004@thunk.org>
	 <20060316225913.GV30801@schatzie.adilger.int>
	 <20060318170729.GI21232@thunk.org>
	 <20060320063633.GC30801@schatzie.adilger.int>
	 <1142894283.21593.59.camel@orbit.scot.redhat.com>
	 <20060320234829.GJ6199@schatzie.adilger.int>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 12:05:22 -0500
Message-Id: <1142960722.3443.24.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-03-20 at 16:48 -0700, Andreas Dilger wrote:

> > It would be easy enough to define a new flag that indicates that
> > there is always X amount of space reserved for inode fields, and to set
> > that in fsck if all inodes on the fs obey that restriction.  Then it
> > just comes down to picking a number X that is likely to satisfy all the
> > short-term demands for new inode fields.
> 
> We could change ext3_new_inode() today to reserve, say, 12 or 16 more
> bytes for timestamps, even if they are not implemented yet.  Having a
> field in the superblock (tunable by the admin, concievably) to reserve
> a total of X bytes for i_extra_isize has some appeal though.

Exactly, because it's more than just the timestamps that we'd like to
grow.

> 	__u32 i_(m|c|a)time_extended;

> Are there any other needs right now?

Potentially, yes.  If we want to go 64-bits, then the extent maps can
take care of indirect blocks, but we would still need:

	__le32	i_blocks;	/* Blocks count */
	__le32	i_file_acl;	/* File ACL */
	__le32	i_dir_acl;	/* Directory ACL */

to get an extra 32 bits.  And there's the old favourite,

	__le16	i_links_count;	/* Links count */

which is a completely unnecessary limit on subdirs, which would be great
to eliminate at the same time.

We're not talking about a huge amount of space, here; I'd hate to
reserve too little space for the next year or so and force people to go
through a full forced fsck more than once to flag just a few more bytes
as available.

>   My thought on the "extra" fields
> in the inode is that they would always be on an "as available" basis,
> so if e.g. we only had 8 bytes reserved we would get i_mtime_extended,
> and i_ctime_extended, and not i_atime_extended.  

Yes, that's basically what we're already set up for with i_extra_size.

The problem is that by the time we find we can't grow the inode fields,
it may be too late.  That's especially true with timestamps: ENOSPC is a
bad return code for sys_utimes()!  It's perhaps a little more reasonable
to expect to have to deal with ENOSPC when we do a mkdir() or write().
But a per-sb reserved-inode-growth field that fsck can always set, and
that the overwhelming majority of filesystems will be able to satisfy,
simply gets rid of *all* the edge cases by guaranteeing enough space.

> ...a 32-bit
> inode checksum...?

Not something that anyone is using right now, but it's exactly the sort
of thing that a superblock field would be ideal for.

> It would also be good to understand what HURD is actually doing with
> those other fields (if anything, does it even exist anymore?), since
> it is literally holding TB of space unusable on Linux ext3 filesystems
> that could better be put to use.  There are i_translator, i_mode_high,
> and i_author held hostage by HURD, and I certainly have never seen or
> heard of any good description of what they do or if Linux would/could
> ever use them, or if HURD could live without them.

If they really are 100% necessary for hurd, it might be that we could
relegate them to an xattr.  There's the slight problem of testing,
though; does anyone on ext2-devel actually run hurd, ever?

> I'm fully in the "the chance of any real problem is vanishingly small"
> camp, even though Lustre is one of the few users of large inodes.  The
> presence of the COMPAT field would not really be any different than just
> changing ext3_new_inode() to make i_extra_isize 16 by default, except to
> cause breakage against the older e2fsprogs.

Setting i_extra_isize will break older e2fsprogs anyway, won't it?
e2fsck needs to have full knowledge of all fs fields in order to
maintain consistency; if it doesn't know about some of the fields whose
presence is implied by i_extra_isize, then doesn't it have to abort?

So for future-proofing, we do need some distinction between the fields
actually *used* in i_extra_isize, and those simply reserved there.  And
that has to be per-inode, if we want to allow easy dynamic migration to
newer fields.

So a per-superblock field guaranteeing that there's at least $N bytes of
usable *potential* i_extra_isize in each inode, and a per-inode
i_extra_isize which shows which fields are *actively* used, gives us
both pieces of information that we need.

--Stephen


