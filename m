Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030560AbWCTWjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560AbWCTWjV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030562AbWCTWjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:39:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56752 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030560AbWCTWjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:39:20 -0500
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Takashi Sato <sho@bsd.tnes.nec.co.jp>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060320063633.GC30801@schatzie.adilger.int>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp>
	 <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com>
	 <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
	 <20060316183549.GK30801@schatzie.adilger.int>
	 <20060316212632.GA21004@thunk.org>
	 <20060316225913.GV30801@schatzie.adilger.int>
	 <20060318170729.GI21232@thunk.org>
	 <20060320063633.GC30801@schatzie.adilger.int>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 17:38:02 -0500
Message-Id: <1142894283.21593.59.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2006-03-19 at 23:36 -0700, Andreas Dilger wrote:

> What happens to existing filesystems with large inodes that don't have
> enough space for the extra timestamps in the first place?

Sadly, they are basically out of luck, unless we change the way that
space in the extended inode is used.

In retrospect, perhaps we goofed.  We added that space into the inode,
but there is no guarantee that it can be used on demand for anything
other than xattrs --- precisely because xattrs can grow to use all
available space both in the external xattr block *and* in the inode.

We could have defined things such that you could either use the in-inode
space, OR the external space, for xattrs, but not both.  But that would
be a performance compromise at best, for some of the most important
xattrs (like SELinux labels, which are always there and are always
needed) really want to be accelerated in the inode.

We really ought to have reserved *some* space in the extended inode for
non-xattr fields, for compatibility purposes.

But it's probably not too late.  I would expect that the vast majority
of filesystems won't have any inodes that have fully-occupied xattr
space.  It would be easy enough to define a new flag that indicates that
there is always X amount of space reserved for inode fields, and to set
that in fsck if all inodes on the fs obey that restriction.  Then it
just comes down to picking a number X that is likely to satisfy all the
short-term demands for new inode fields.

> Also, if files
> are created while the filesystem is mounted without usecond timestamps
> they would get no usecond fields anyways.  I agree that there are some
> unlikely corner conditions that might be hit (large inode filesystem, on
> older kernel without usec support, fills both the in-inode and external
> block so much that there isn't 12 bytes left for the usecond timestamps,
> and that file happens to depend on the exact accuracy of the timestamp).
> IMHO the inconvenience of the ROCOMPAT outweighs the benefits.

That's precisely the corner case that concerns me.  The question is, do
we want the filesystem to behave correctly in all cases, or do we take
short-cuts?  

I think we're probably early enough in the adoption of large inodes that
we don't have to make that compromise, and we can reserve some space for
guaranteed use by inode fields with a single minimally-invasive compat
change (say, a flag enabling a field in the superblock which defines how
many bytes we can always safely use for extended inode fields.)

--Stephen


