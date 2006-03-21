Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWCUU16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWCUU16 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWCUU16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:27:58 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:24969 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932444AbWCUU15
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:27:57 -0500
Date: Tue, 21 Mar 2006 13:26:58 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Takashi Sato <sho@bsd.tnes.nec.co.jp>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060321202658.GT6199@schatzie.adilger.int>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, Takashi Sato <sho@bsd.tnes.nec.co.jp>,
	cmm@us.ibm.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>
References: <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com> <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp> <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org> <20060320063633.GC30801@schatzie.adilger.int> <1142894283.21593.59.camel@orbit.scot.redhat.com> <20060320234829.GJ6199@schatzie.adilger.int> <1142960722.3443.24.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142960722.3443.24.camel@orbit.scot.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 21, 2006  12:05 -0500, Stephen C. Tweedie wrote:
> If we want to go 64-bits, then the extent maps can
> take care of indirect blocks, but we would still need:
> 
> 	__le32	i_blocks;	/* Blocks count */

This has partially been addressed by Takashi's patch for fs-blocksize
i_blocks, and there was also a patch to use either i_frag|i_fsize or
i_faddr as the high bits of this value.  If we think that 2^48 * blocksize
is enough for a file (2^60 bytes for 4kB blocks, 2^64 bytes for 64kB blocks)
then it would be prudent to use (i_frag|i_fsize) as i_blocks_high.  AFAIK,
those fields have never, ever been used, and adding such a change along
with Takashi's patch makes a lot of sense.

> 	__le32	i_file_acl;	/* File ACL */

This needs another 32 bits for sure.  We might concievably also fix up the
EA code to improve the external-block EA format (e.g. allow pointing at an
extent index block or another inode to allow storing larger EAs).

> 	__le32	i_dir_acl;	/* Directory ACL */

This is i_size_high for regular files, and I propose that it also become
i_size_high for directories as well, because CFS at least is hitting
limits of 2GB directories already (that's around 25M files).  It also
doesn't take into account that we need to increase the dirent size to
accomodate larger inode numbers and possibly some other attribute data,
which I propose we flag with the high 5 bits of the d_type field.

> to get an extra 32 bits.  And there's the old favourite,
> 
> 	__le16	i_links_count;	/* Links count */
> 
> which is a completely unnecessary limit on subdirs, which would be great
> to eliminate at the same time.

CFS has a patch that has been working for ages that changes the i_links_count
handling to be the same as reiserfs - namely, if we overflow 65000 links
the directory i_nlinks becomes 1 (disables "find" heuristic to only recurse
into i_nlinks subdirectories), and ext3_dir_empty() is trusted to tell us
when the directory is empty (which it does already, i_nlinks only used
to print out a warning in any case).  Even an unpatched e2fsck and kernel
handle this gracefully.

> We're not talking about a huge amount of space, here; I'd hate to
> reserve too little space for the next year or so and force people to go
> through a full forced fsck more than once to flag just a few more bytes
> as available.

At the same time, if we reserve too much space, it hurts EAs fitting
into the large inode space (which is at least CFS's and Samba's primary
requirement for large inodes).

> The problem is that by the time we find we can't grow the inode fields,
> it may be too late.  That's especially true with timestamps: ENOSPC is a
> bad return code for sys_utimes()!

I'd rather return success and truncate the timestamp.

> It's perhaps a little more reasonable
> to expect to have to deal with ENOSPC when we do a mkdir() or write().
> But a per-sb reserved-inode-growth field that fsck can always set, and
> that the overwhelming majority of filesystems will be able to satisfy,
> simply gets rid of *all* the edge cases by guaranteeing enough space.

In the end, I don't think we can ever have "enough" space reserved for
all needs, so the code will have to have a graceful fallback strategy
in any case.

> > I'm fully in the "the chance of any real problem is vanishingly small"
> > camp, even though Lustre is one of the few users of large inodes.  The
> > presence of the COMPAT field would not really be any different than just
> > changing ext3_new_inode() to make i_extra_isize 16 by default, except to
> > cause breakage against the older e2fsprogs.
> 
> Setting i_extra_isize will break older e2fsprogs anyway, won't it?
> e2fsck needs to have full knowledge of all fs fields in order to
> maintain consistency; if it doesn't know about some of the fields whose
> presence is implied by i_extra_isize, then doesn't it have to abort?

Like Ted said, and I had said when the large inode patch was first proposed,
if there is something added in the large inode space that is absolutely
mandatory, then it can be covered by an appropriate *COMPAT flag.  I don't
think that the inode timestamps even warrant that protection.

> So for future-proofing, we do need some distinction between the fields
> actually *used* in i_extra_isize, and those simply reserved there.  And
> that has to be per-inode, if we want to allow easy dynamic migration to
> newer fields.

The concept of "reserving" space in i_extra_isize wasn't considered.  Instead
the design was that i_extra_isize would be large enough to cover the valid
fields, and if more space is needed, i_extra_isize would be grown to cover
this space, as applicable.

As Ted says, we could just initialize unused fields to zero and depend on
that.  It works for the timestamps and e.g. checksum at least, and new
code can be made to live with this also.

> So a per-superblock field guaranteeing that there's at least $N bytes of
> usable *potential* i_extra_isize in each inode, and a per-inode
> i_extra_isize which shows which fields are *actively* used, gives us
> both pieces of information that we need.

I thought of this also, though plain "reservation" fails in two regards:
- if the older kernel doesn't understand "s_extra_isize_min", it may still
  consume that space if the filesystem is mounted there
- if all fields in i_extra_isize are not used (e.g. i_checksum is disabled,
  but a later i_dac is enabled), we still need a way to know if the field
  is in use

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

