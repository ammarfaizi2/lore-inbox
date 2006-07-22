Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWGVAHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWGVAHJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWGVAHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 20:07:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24986 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750875AbWGVAHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 20:07:07 -0400
Date: Fri, 21 Jul 2006 17:06:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: jack@suse.cz, 20@madingley.org, marcel@holtmann.org,
       linux-kernel@vger.kernel.org, sct@redhat.com,
       "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Bad ext3/nfs DoS bug
Message-Id: <20060721170627.4cbea27d.akpm@osdl.org>
In-Reply-To: <17600.30372.397971.955987@cse.unsw.edu.au>
References: <20060717130128.GA12832@circe.esc.cam.ac.uk>
	<1153209318.26690.1.camel@localhost>
	<20060718145614.GA27788@circe.esc.cam.ac.uk>
	<1153236136.10006.5.camel@localhost>
	<20060718152341.GB27788@circe.esc.cam.ac.uk>
	<1153253907.21024.25.camel@localhost>
	<20060719092810.GA4347@circe.esc.cam.ac.uk>
	<20060719155502.GD3270@atrey.karlin.mff.cuni.cz>
	<17599.2754.962927.627515@cse.unsw.edu.au>
	<20060720160639.GF25111@atrey.karlin.mff.cuni.cz>
	<17600.30372.397971.955987@cse.unsw.edu.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2006 16:39:32 +1000
Neil Brown <neilb@suse.de> wrote:

> Avoid triggering ext3_error on bad NFS file handle
> 
> The inode number out of an NFS file handle gets passed 
> eventually to ext3_get_inode_block without any checking.
> If ext3_get_inode_block allows it to trigger a error,
> then bad filehandles can have unpleasant effect.
> 
> So remove the call to ext3_error there and put a matching
> check in ext3/namei.c where inode numbers are read of storage.
> 

There are strange things happening in here.

> +static inline int ext3_valid_inum(struct super_block *sb, unsigned long ino)
> +{
> +	return ino == EXT3_ROOT_INO ||
> +		ino == EXT3_JOURNAL_INO ||
> +		ino == EXT3_RESIZE_INO ||
> +		(ino > EXT3_FIRST_INO(sb) &&
> +		 ino <= le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count));
> +}

One would expect the inode validity test to be

	(ino >= EXT3_FIRST_INO(sb)) && (ino < ...->s_inodes_count))

but even this assumes that s_inodes_count is misnamed and really should be
called s_last_inode_plus_one.  If it is not misnamed then the validity test
should be

	(ino >= EXT3_FIRST_INO(sb)) &&
		(ino < EXT3_FIRST_INO(sb) + ...->s_inodes_count))

Look through the filesystem for other uses of EXT3_FIRST_INO().  It's all
rather fishily inconsistent.

Ted, Andreas: do you think we could come up with statements describing
exactly what the values in EXT3_FIRST_INO() and in ->s_inodes_count
represent?  Thanks.


Also Neil, I wonder whether this patch of yours still permits NFS clients
to access the journal and resize inodes in undesirable ways?
