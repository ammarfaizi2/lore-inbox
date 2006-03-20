Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWCTGhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWCTGhc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWCTGhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:37:32 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:49565 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751593AbWCTGhb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:37:31 -0500
Date: Sun, 19 Mar 2006 23:36:34 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Takashi Sato <sho@bsd.tnes.nec.co.jp>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060320063633.GC30801@schatzie.adilger.int>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp> <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com> <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp> <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318170729.GI21232@thunk.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 18, 2006  12:07 -0500, Theodore Ts'o wrote:
> What I'm trying to simplify is the overhead of users trying to
> understand a tangled mess of features, some compat, some incompat,
> etc.

I think the real goal is that 99% of users never really see this
in the first place.  Add in support for these features now with the
most permissive COMPAT flag possible, and chances are that most
normal users won't use these features for a few years.  Most of
them are for the 1% of systems that are pushing the current filesystem
limits, and the majority of these users are also more sophisticated.
You won't have Joe Average dual-booting their Linux system with a
16TB filesystem.

> > I think i_blocks can be considered an ROCOMPAT feature, and the large
> > inode reservation for usecond timestamps could be COMPAT I think (since
> > an unsupporting kernel would still update all the timestamps consistently
> > even if the useconds on disk would be some constant instead of 0.

NB - my reference for i_blocks was the use of i_frag|i_fsize for use
     by files > 2TB, not the recent proposal for i_blocks in fs blocksize.

> i_blocks can ROCOMPAT only if it is acceptable for stat(2) to return
> erroneous i_blocks return values.  I'm not entirely convinced that's a
> good thing, and at the very least it would be extremely confusing, but
> maybe.

I think most cases where someone is ro-mounting their filesystem is
when they need emergency access to the filesystem with an older kernel.
Allowing that access IMHO is more important than exact correctness.
I'm also not aware of any tools that depend on i_blocks being correct,
though I suspect e.g. "cp --sparse" will use a discrepency in
i_size vs (i_blocks >> 9) to determine sparseness.

> usecond timestamps must be at least ROCOMPAT, because of the
> requirement that all newly created inodes must reserve extra space and
> guarantee that i_extra_isize must be at least n bytes (where n is the
> size of the guaranteed extra inode fields).  If you don't do that,
> then when the filesystem is mounted one again on a kernel that does
> understand usec timestamps, some inodes will have room for the usec
> time fields, and other inodes won't (because they have too much of the
> space used for EA's), and that will cause serious problems for make(1).

What happens to existing filesystems with large inodes that don't have
enough space for the extra timestamps in the first place?  Also, if files
are created while the filesystem is mounted without usecond timestamps
they would get no usecond fields anyways.  I agree that there are some
unlikely corner conditions that might be hit (large inode filesystem, on
older kernel without usec support, fills both the in-inode and external
block so much that there isn't 12 bytes left for the usecond timestamps,
and that file happens to depend on the exact accuracy of the timestamp).
IMHO the inconvenience of the ROCOMPAT outweighs the benefits.

We have previously restricted ROCOMPAT and INCOMPAT flags for changes
that would cause corruption or crashes on older kernels.  In the end,
I'm not dead-set against making it ROCOMPAT, just trying to maintain
the maximal compatibility possible.

> for cases where we find that increasing the blocksize to
> 8k or even larger (32k?  64k) really helps, but we don't want to pay
> the internal fragmentation penalty for small files.  There are other
> ways to solve the problem, yes, such as by assuming that we can use a
> different filesystem for database or video streams separate from the
> /, /usr, and/or /var filesystems, for example.  
> 
> If we are ready to forever forswear wanting to use large block sizes,
> then maybe we don't need to worry about fragmentations support (or
> maybe the 1.8" pedabyte disk drives will show up and be cheap enough
> that we just won't care about wasting space on small files).  But
> that's I think a decision which we need to formally make.

I'm not against large block support (in fact I was hoping this would be
standard by now), or fragment support.  Rather, I think that nobody
cares enough about it to actually implement it, and given the growth
of disks the demand will never materialize, just like ext2 filesystem
compression missed the window when the benefits outweighed the costs.

If and when large-page/block support makes it into a commodity CPU
(sadly, x86_64 missed the mark) or kernel we can re-evaluate it then.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

