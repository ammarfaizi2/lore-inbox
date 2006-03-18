Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWCRRHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWCRRHe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 12:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWCRRHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 12:07:34 -0500
Received: from thunk.org ([69.25.196.29]:8884 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750703AbWCRRHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 12:07:34 -0500
Date: Sat, 18 Mar 2006 12:07:29 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060318170729.GI21232@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp> <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com> <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp> <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316225913.GV30801@schatzie.adilger.int>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 03:59:13PM -0700, Andreas Dilger wrote:
> While I agree with that in theory, in practise we never end up doing
> this and it just ends up delaying the acceptance of the trivial patches.
> It may also be a burden later on when some of the features that could
> be e.g. ROCOMPAT are bundled with an INCOMPAT change and we then
> make the filesystem gratuitously INCOMPAT.
> 
> In the end, I don't think having a couple of separate flags is any more
> effort than having a single one.  As yet we only have about 6 of each 32
> feature bits used, and if we get close to running out we can make an
> EXT3_FEATURE_{,RO,IN}COMPAT_NEXT_WORD flag to continue it on.

The overhead is not running out of feature bit flags.  After all, it's
easy to add more if we need to; we just define the MSB as meaning
"check the auxiliary features compat/rocompat/incompat mask", and then
define a new 32-bit extension bitmask in the superblock.

What I'm trying to simplify is the overhead of users trying to
understand a tangled mess of features, some compat, some incompat,
etc.

> Note that I'm not against this in practise, but I wouldn't hold up any
> feature for this reason.  How long has large i_blocks been pending,
> and usecond timestamps?  Many years already, even though they are trivial
> to implement, so I'm hesitant to tie them together and delay further.

i_blocks has been pending because the people who could push it haven't
had the time, and usec timestamps because the trivial way (without an
at least an ROCOMPAT flag).

> I think i_blocks can be considered an ROCOMPAT feature, and the large
> inode reservation for usecond timestamps could be COMPAT I think (since
> an unsupporting kernel would still update all the timestamps consistently
> even if the useconds on disk would be some constant instead of 0.

i_blocks can ROCOMPAT only if it is acceptable for stat(2) to return
erroneous i_blocks return values.  I'm not entirely convinced that's a
good thing, and at the very least it would be extremely confusing, but
maybe.

usecond timestamps must be at least ROCOMPAT, because of the
requirement that all newly created inodes must reserve extra space and
guarantee that i_extra_isize must be at least n bytes (where n is the
size of the guaranteed extra inode fields).  If you don't do that,
then when the filesystem is mounted one again on a kernel that does
understand usec timestamps, some inodes will have room for the usec
time fields, and other inodes won't (because they have too much of the
space used for EA's), and that will cause serious problems for make(1).

> I think testing with reiserfs showed that tail packing was a net loss in
> most cases, since basically every benchmark I've ever seen with reiserfs
> disables tail packing or suffers.  For space constrained systems (if
> there ever exists such a thing again ;-) it would probably be better to
> go to compressed files.

I have to wonder if that's because of the way reiserfs implemented
tail-packing more than anything else.  I don't belive fragments hurt
performance on UFS systems quite as much as it does on reiserfs
systems.  I'm not worried about this as much for space constrained
systems, but for cases where we find that increasing the blocksize to
8k or even larger (32k?  64k) really helps, but we don't want to pay
the internal fragmentation penalty for small files.  There are other
ways to solve the problem, yes, such as by assuming that we can use a
different filesystem for database or video streams separate from the
/, /usr, and/or /var filesystems, for example.  

If we are ready to forever forswear wanting to use large block sizes,
then maybe we don't need to worry about fragmentations support (or
maybe the 1.8" pedabyte disk drives will show up and be cheap enough
that we just won't care about wasting space on small files).  But
that's I think a decision which we need to formally make.

					- Ted
