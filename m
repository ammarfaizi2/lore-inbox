Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRKFAhb>; Mon, 5 Nov 2001 19:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRKFAhW>; Mon, 5 Nov 2001 19:37:22 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:5812 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S276135AbRKFAhM>; Mon, 5 Nov 2001 19:37:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: Ext2 directory index, updated
Date: Tue, 6 Nov 2001 01:38:15 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Christian Laursen <xi@borderworlds.dk>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org> <20011104230046Z17057-18972+12@humbolt.nl.linux.org> <20011105151006.G3957@lynx.no>
In-Reply-To: <20011105151006.G3957@lynx.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011106003705Z17274-18972+251@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 5, 2001 11:10 pm, Andreas Dilger wrote:
> On Nov 05, 2001  00:01 +0100, Daniel Phillips wrote:
> > For using the -o index option on a non-throwaway volume, we should do 
this:
> > 
> >  void ext2_add_compat_feature (struct super_block *sb, unsigned feature)
> >  {
> > +	return;
> >  	if (!EXT2_HAS_COMPAT_FEATURE(sb, feature))
> >  	{
> > 
> > And afterwards you can rm -rf your test directory, though actually normal 
> > ext2 shouldn't see anything unusual about it.  The real reason for rm'ing 
the 
> > test directory is so that I can tweak the index format in upcoming 
prerelease 
> > versions.
> 
> Well, e2fsck _should_ really know about the fact that there are indexed
> directories in the filesystem, which is what the COMPAT flag flag is for.
> The only current issue is that e2fsck doesn't understand this compat flag.
> 
> > I've disabled the add_compat_feature here for now, because until fsck can 
> > handle it, it just causes trouble.  I'll go read Andreas' writeup on the 
> > COMPAT flags again and see if I can come up with a more friendly 
> > interpretation.
> 
> No, COMPAT is the friendliest.  It means old kernels can read/write this
> filesystem without problems, just that e2fsck can't/won't check it.  Even
> though an old fsck _probably_ won't break such a filesystem, there is no
> guarantee of that,

Well, it's hard to see how the fsck could hurt, since all the blocks of the 
directory look like legitimate empty blocks.  When did 

> and it definitely won't validate the indexes, so a
> "successfull" fsck of an indexed directory doesn't mean anything until it
> can understand this COMPAT flag.
> 
> That said, I agree that turning the COMPAT flag off for short term testing
> is probably not fatal, but I thought we were not going to even suggest
> using non-throwaway filesystems until the hash function was finalized?

True.  Right now, I'm interested in finding out exactly how the old fscks are 
going to behave when they run into indexed directories, so I'll leave the 
COMPAT flag off for now and turn it back on when we hit the first 
format-frozen release.  The method of restoring a partition to a fsckable 
state is easy to document:

    # debugfs -w root_fs
    debugfs: feature -dir_index

Anybody who's running the patch will have access to a recent version of 
debugfs that knows about the dir_index flag.

> In
> the end, if an updated e2fsck detects the DIR_INDEX flag (and valid indexes
> therein) it will turn on the COMPAT flag for us, so all will be well.  I
> don't advise that we push for patch inclusion until e2fsck is done, however.

Yes, as long as testers heed my warning and stick to test partitions there's 
no particular danger.  There's a simple recovery procedure for anyone who 
doesn't want to bother re-mkfsing the partition.  We're in pretty good shape. 

My improved show_buckets routine is working code that could be used to get 
started on the new fsck code.  It walks the index in hash bucket order 
dumping out statistics, and, together with the checks in dx_probe, basically 
defines the index format.

--
Daniel
