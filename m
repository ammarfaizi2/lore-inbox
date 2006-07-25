Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWGYB46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWGYB46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWGYB4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:56:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932392AbWGYB4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:56:40 -0400
Date: Mon, 24 Jul 2006 18:56:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Theodore Tso <tytso@mit.edu>
Cc: neilb@suse.de, jack@suse.cz, 20@madingley.org, marcel@holtmann.org,
       linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com
Subject: Re: Bad ext3/nfs DoS bug
Message-Id: <20060724185604.9181714c.akpm@osdl.org>
In-Reply-To: <20060722131759.GC7321@thunk.org>
References: <20060718145614.GA27788@circe.esc.cam.ac.uk>
	<1153236136.10006.5.camel@localhost>
	<20060718152341.GB27788@circe.esc.cam.ac.uk>
	<1153253907.21024.25.camel@localhost>
	<20060719092810.GA4347@circe.esc.cam.ac.uk>
	<20060719155502.GD3270@atrey.karlin.mff.cuni.cz>
	<17599.2754.962927.627515@cse.unsw.edu.au>
	<20060720160639.GF25111@atrey.karlin.mff.cuni.cz>
	<17600.30372.397971.955987@cse.unsw.edu.au>
	<20060721170627.4cbea27d.akpm@osdl.org>
	<20060722131759.GC7321@thunk.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006 09:17:59 -0400
Theodore Tso <tytso@mit.edu> wrote:

> Sorry, OLS and some work-related emergencies have been hitting hard
> this week, so I've been deferred doing a full review of Jan's patch.
> Hopefully after OLS I'll be able to comment more fully.
> 
> On Fri, Jul 21, 2006 at 05:06:27PM -0700, Andrew Morton wrote:
> > There are strange things happening in here.
> > 
> > > +static inline int ext3_valid_inum(struct super_block *sb, unsigned long ino)
> > > +{
> > > +	return ino == EXT3_ROOT_INO ||
> > > +		ino == EXT3_JOURNAL_INO ||
> > > +		ino == EXT3_RESIZE_INO ||
> > > +		(ino > EXT3_FIRST_INO(sb) &&
> > > +		 ino <= le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count));
> > > +}
> > 
> > One would expect the inode validity test to be
> > 
> > 	(ino >= EXT3_FIRST_INO(sb)) && (ino < ...->s_inodes_count))
> >
> > but even this assumes that s_inodes_count is misnamed and really should be
> > called s_last_inode_plus_one.  If it is not misnamed then the validity test
> > should be
> > 
> > 	(ino >= EXT3_FIRST_INO(sb)) &&
> > 		(ino < EXT3_FIRST_INO(sb) + ...->s_inodes_count))
> > 
> > Look through the filesystem for other uses of EXT3_FIRST_INO().  It's all
> > rather fishily inconsistent.
> 
> I don't think there's anything in consistent.  Basically, inodes are 1
> based (inode number 0 in a directory entry means that the file is
> deleted and the directory entry is freed).  Hence valid inode numbers
> are between 1 and s_inodes_count, inclusive.
> 
> Inodes between 1 and EXT3_FIRST_INO-1 (inclusive) are reserved, are
> should always be marked as in use in the inode allocation bitmap.
> EXT3_FIRST_INO (which is 11 on all ext3 filesystems to date) is
> generally the lost+found directory, but that's just because it is the
> first file/directory which is allocated by mke2fs.  So EXT3_FIRST_INO
> representes the first inode which can be allocated by userspace.  (The
> root inode doesn't fall in this category because it can never be
> deleted or reallocated after the filesystem is created, and as a nod
> to Unix filesystem history, it has inode #2).
> 
> The net of all of this is the inode validity test should be:
> 
>  	(ino >= EXT3_FIRST_INO(sb)) && (ino <= ...->s_inodes_count))

I agree; I made that change.

> However, I would suggest that we *not* allow remote NFS users to get
> access to the journal inode or the resize inode, please?  That's only
> going to cause mischief of the DoS attack kind.....  

<looks at Neil>

<then looks at ext2>
