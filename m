Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWCTXs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWCTXs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWCTXs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:48:57 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:9925 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750727AbWCTXs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:48:56 -0500
Date: Mon, 20 Mar 2006 16:48:29 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Takashi Sato <sho@bsd.tnes.nec.co.jp>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060320234829.GJ6199@schatzie.adilger.int>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, Takashi Sato <sho@bsd.tnes.nec.co.jp>,
	cmm@us.ibm.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp> <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com> <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp> <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org> <20060320063633.GC30801@schatzie.adilger.int> <1142894283.21593.59.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142894283.21593.59.camel@orbit.scot.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 20, 2006  17:38 -0500, Stephen C. Tweedie wrote:
> On Sun, 2006-03-19 at 23:36 -0700, Andreas Dilger wrote:
> > What happens to existing filesystems with large inodes that don't have
> > enough space for the extra timestamps in the first place?
> 
> Sadly, they are basically out of luck, unless we change the way that
> space in the extended inode is used.
> 
> We could have defined things such that you could either use the in-inode
> space, OR the external space, for xattrs, but not both.  But that would
> be a performance compromise at best, for some of the most important
> xattrs (like SELinux labels, which are always there and are always
> needed) really want to be accelerated in the inode.

The fast EA space is the only reason we implemented this at all.  We
also still need the external EA space for the overflow case.

> I would expect that the vast majority of filesystems won't have any
> inodes that have fully-occupied xattr space.

I would agree.  The number of affected files is likely infintesimal,
given that large inodes are not enabled by default (not sure if they
are even documented), Lustre doesn't use more than a single EA on a file
except in the just-release version, and Samba4 doesn't care because it
stores its timestamps in EAs anyways due to lack of usecond timestamps.

> It would be easy enough to define a new flag that indicates that
> there is always X amount of space reserved for inode fields, and to set
> that in fsck if all inodes on the fs obey that restriction.  Then it
> just comes down to picking a number X that is likely to satisfy all the
> short-term demands for new inode fields.

We could change ext3_new_inode() today to reserve, say, 12 or 16 more
bytes for timestamps, even if they are not implemented yet.  Having a
field in the superblock (tunable by the admin, concievably) to reserve
a total of X bytes for i_extra_isize has some appeal though.

At a rough guess I'd want to have timestamps (27 bits for 10s of nanoseconds,
with the high 5 bits left for growing the number of seconds).  If we put the
fields in "priority" order, then on those inodes that don't have much space
left we at least get the more important one(s), primarily mtime I think).

	__u32 i_mtime_extended;
	__u32 i_ctime_extended;
	__u32 i_atime_extended;

Are there any other needs right now?  My thought on the "extra" fields
in the inode is that they would always be on an "as available" basis,
so if e.g. we only had 8 bytes reserved we would get i_mtime_extended,
and i_ctime_extended, and not i_atime_extended.  If there is some added
field that is so important that the kernel/filesystem can't live without
it, it would need its own {RO,IN}COMPAT flag anyways.

I think with the advent of large inodes we can be less worried about
cannibalizing the other "unused" inode fields like i_faddr, i_frag,
i_fsize.  An i_blocks_high field, (even in the face of Takashi's recently
proposed patch we would still want another 16 or 32 bits for larger
files, maybe at the same time as his patch is implemented), a 32-bit
inode checksum, more bits for i_nlinks?

It would also be good to understand what HURD is actually doing with
those other fields (if anything, does it even exist anymore?), since
it is literally holding TB of space unusable on Linux ext3 filesystems
that could better be put to use.  There are i_translator, i_mode_high,
and i_author held hostage by HURD, and I certainly have never seen or
heard of any good description of what they do or if Linux would/could
ever use them, or if HURD could live without them.

> > Also, if files
> > are created while the filesystem is mounted without usecond timestamps
> > they would get no usecond fields anyways.  I agree that there are some
> > unlikely corner conditions that might be hit (large inode filesystem, on
> > older kernel without usec support, fills both the in-inode and external
> > block so much that there isn't 12 bytes left for the usecond timestamps,
> > and that file happens to depend on the exact accuracy of the timestamp).
> > IMHO the inconvenience of the ROCOMPAT outweighs the benefits.
> 
> That's precisely the corner case that concerns me.  The question is, do
> we want the filesystem to behave correctly in all cases, or do we take
> short-cuts?  
> 
> I think we're probably early enough in the adoption of large inodes that
> we don't have to make that compromise, and we can reserve some space for
> guaranteed use by inode fields with a single minimally-invasive compat
> change (say, a flag enabling a field in the superblock which defines how
> many bytes we can always safely use for extended inode fields.)

I'm fully in the "the chance of any real problem is vanishingly small"
camp, even though Lustre is one of the few users of large inodes.  The
presence of the COMPAT field would not really be any different than just
changing ext3_new_inode() to make i_extra_isize 16 by default, except to
cause breakage against the older e2fsprogs.  I don't think it is a bad
idea to implement kernel support for such a flag, but not actually set
it in the superblock unless done so by tune2fs.

Hmm, another "forward looking" change may be to add some masking of bits
in the inode i_flags word.  Ted did this with great success for the
EXT2_INDEX_FL.  Would it be prudent to do the same with, say, the top 4
bits of i_flags?

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

