Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWCPW7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWCPW7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWCPW7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:59:45 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:19118 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964863AbWCPW7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:59:45 -0500
Date: Thu, 16 Mar 2006 15:59:13 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Takashi Sato <sho@bsd.tnes.nec.co.jp>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060316225913.GV30801@schatzie.adilger.int>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp> <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com> <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp> <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316212632.GA21004@thunk.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 16, 2006  16:26 -0500, Theodore Ts'o wrote:
> On Thu, Mar 16, 2006 at 11:35:49AM -0700, Andreas Dilger wrote:
> > Beyond that, we need a format change and may as well have something
> > like extents, but even extents still need to allow a larger i_blocks,
> 
> As a side note, one of the things that we've been talking about doing
> is bundling a number of small changes together into a single INCOMPAT
> flag.  Changing i_blocks so its units are in blocks rather than
> 512-byte sectors was one such change.

> Another was guaranteeing that for large inodes (> 128 bytes) that at
> least some number of bytes (probably on the order of 32 bytes or so)
> would be reserved for things like the high resolution portion of
> ctime/mtime/atime, high watermark, and other inode extensions.  (One
> of the problems with doing high res timestamps right is how to handle
> the case where you can't make room for the high res timestamps, due to
> too much space being taken up by extended attributes.  The make(1)
> program gets really confused unless all files are either using or not
> using high res timestamps.)
> 
> The idea was to do a quick easy strike of all of the ideas which could
> be implemented quickly, and perhaps try to get them done before RHEL 5
> snapshots.  Even if RHEL5 doesn't enable use of these features by
> default, having it supported by RHEL5 would be extremely convenient.

While I agree with that in theory, in practise we never end up doing
this and it just ends up delaying the acceptance of the trivial patches.
It may also be a burden later on when some of the features that could
be e.g. ROCOMPAT are bundled with an INCOMPAT change and we then
make the filesystem gratuitously INCOMPAT.

In the end, I don't think having a couple of separate flags is any more
effort than having a single one.  As yet we only have about 6 of each 32
feature bits used, and if we get close to running out we can make an
EXT3_FEATURE_{,RO,IN}COMPAT_NEXT_WORD flag to continue it on.

Note that I'm not against this in practise, but I wouldn't hold up any
feature for this reason.  How long has large i_blocks been pending,
and usecond timestamps?  Many years already, even though they are trivial
to implement, so I'm hesitant to tie them together and delay further.

I think i_blocks can be considered an ROCOMPAT feature, and the large
inode reservation for usecond timestamps could be COMPAT I think (since
an unsupporting kernel would still update all the timestamps consistently
even if the useconds on disk would be some constant instead of 0.

> > so that patch would be useful in any case...  though it needs some
> > cleanup to remove all users of i_frag and i_faddr (which have never
> > ever been used).
> 
> One of the things which we need to consider is whether we think we
> will never support tail packing or other forms of fragments, which is
> related to whether we think we will ever support large blocks (i.e.,
> 32k, 64k, and up).  If we do, we might want to keep those fields
> around.

I thought the long-term plan for small files was to just store them
in an EA?  That way, we can efficiently pack them inside the inode
or up to blocksize (space willing) without any usage of inode fields
(maybe with a flag to indicate that there is such a fragment to avoid
gratuitous EA searching).  This would be a net win on performance since
it avoids an IO for the in-inode case at least.

I think testing with reiserfs showed that tail packing was a net loss in
most cases, since basically every benchmark I've ever seen with reiserfs
disables tail packing or suffers.  For space constrained systems (if
there ever exists such a thing again ;-) it would probably be better to
go to compressed files.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

