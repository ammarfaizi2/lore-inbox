Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWGVNS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWGVNS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 09:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWGVNS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 09:18:29 -0400
Received: from thunk.org ([69.25.196.29]:58033 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751343AbWGVNS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 09:18:29 -0400
Date: Sat, 22 Jul 2006 09:17:59 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, jack@suse.cz, 20@madingley.org,
       marcel@holtmann.org, linux-kernel@vger.kernel.org, sct@redhat.com,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Bad ext3/nfs DoS bug
Message-ID: <20060722131759.GC7321@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@suse.de>,
	jack@suse.cz, 20@madingley.org, marcel@holtmann.org,
	linux-kernel@vger.kernel.org, sct@redhat.com,
	Andreas Dilger <adilger@clusterfs.com>
References: <20060718145614.GA27788@circe.esc.cam.ac.uk> <1153236136.10006.5.camel@localhost> <20060718152341.GB27788@circe.esc.cam.ac.uk> <1153253907.21024.25.camel@localhost> <20060719092810.GA4347@circe.esc.cam.ac.uk> <20060719155502.GD3270@atrey.karlin.mff.cuni.cz> <17599.2754.962927.627515@cse.unsw.edu.au> <20060720160639.GF25111@atrey.karlin.mff.cuni.cz> <17600.30372.397971.955987@cse.unsw.edu.au> <20060721170627.4cbea27d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060721170627.4cbea27d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, OLS and some work-related emergencies have been hitting hard
this week, so I've been deferred doing a full review of Jan's patch.
Hopefully after OLS I'll be able to comment more fully.

On Fri, Jul 21, 2006 at 05:06:27PM -0700, Andrew Morton wrote:
> There are strange things happening in here.
> 
> > +static inline int ext3_valid_inum(struct super_block *sb, unsigned long ino)
> > +{
> > +	return ino == EXT3_ROOT_INO ||
> > +		ino == EXT3_JOURNAL_INO ||
> > +		ino == EXT3_RESIZE_INO ||
> > +		(ino > EXT3_FIRST_INO(sb) &&
> > +		 ino <= le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count));
> > +}
> 
> One would expect the inode validity test to be
> 
> 	(ino >= EXT3_FIRST_INO(sb)) && (ino < ...->s_inodes_count))
>
> but even this assumes that s_inodes_count is misnamed and really should be
> called s_last_inode_plus_one.  If it is not misnamed then the validity test
> should be
> 
> 	(ino >= EXT3_FIRST_INO(sb)) &&
> 		(ino < EXT3_FIRST_INO(sb) + ...->s_inodes_count))
> 
> Look through the filesystem for other uses of EXT3_FIRST_INO().  It's all
> rather fishily inconsistent.

I don't think there's anything in consistent.  Basically, inodes are 1
based (inode number 0 in a directory entry means that the file is
deleted and the directory entry is freed).  Hence valid inode numbers
are between 1 and s_inodes_count, inclusive.

Inodes between 1 and EXT3_FIRST_INO-1 (inclusive) are reserved, are
should always be marked as in use in the inode allocation bitmap.
EXT3_FIRST_INO (which is 11 on all ext3 filesystems to date) is
generally the lost+found directory, but that's just because it is the
first file/directory which is allocated by mke2fs.  So EXT3_FIRST_INO
representes the first inode which can be allocated by userspace.  (The
root inode doesn't fall in this category because it can never be
deleted or reallocated after the filesystem is created, and as a nod
to Unix filesystem history, it has inode #2).

The net of all of this is the inode validity test should be:

 	(ino >= EXT3_FIRST_INO(sb)) && (ino <= ...->s_inodes_count))

However, I would suggest that we *not* allow remote NFS users to get
access to the journal inode or the resize inode, please?  That's only
going to cause mischief of the DoS attack kind.....  

						- Ted

