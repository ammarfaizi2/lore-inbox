Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVJaKaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVJaKaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVJaKaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:30:23 -0500
Received: from ns1.suse.de ([195.135.220.2]:7874 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932437AbVJaKaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:30:22 -0500
From: Neil Brown <neilb@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Date: Mon, 31 Oct 2005 21:30:15 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17253.62007.4907.124195@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH against 2.6.14] truncate() or ftruncate shouldn't
	change mtime if size doesn't change.
In-Reply-To: message from Anton Altaparmakov on Monday October 31
References: <20051031173358.9566.patches@notabene>
	<1051031063444.9586@suse.de>
	<20051030234837.36c7a249.akpm@osdl.org>
	<1130752124.7504.13.camel@imp.csi.cam.ac.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 31, aia21@cam.ac.uk wrote:
> > 
> > This partially obsoletes the similar optimisation in inode_setattr().  I
> > guess the optimisation there retains some usefulness for O_TRUNC opens of
> > zero-length files, but for symettry and micro-efficiency, perhaps we should
> > remvoe the inode_setattr() test and check for i_size==0 in may_open()?
> 
> Sounds like a good idea.  That does simplify inode_setattr() nicely...
> 
> Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
> 
> --- linux-2.6/fs/attr.c.old	2005-10-31 09:29:38.000000000 +0000
> +++ linux-2.6/fs/attr.c	2005-10-31 09:30:39.000000000 +0000
> @@ -70,19 +70,10 @@ int inode_setattr(struct inode * inode, 
>  	int error = 0;
>  
>  	if (ia_valid & ATTR_SIZE) {
> -		if (attr->ia_size != i_size_read(inode)) {
> -			error = vmtruncate(inode, attr->ia_size);
> -			if (error || (ia_valid == ATTR_SIZE))
> -				goto out;
> -		} else {
> -			/*
> -			 * We skipped the truncate but must still update
> -			 * timestamps
> -			 */
> -			ia_valid |= ATTR_MTIME|ATTR_CTIME;
> -		}
> +		error = vmtruncate(inode, attr->ia_size);
> +		if (error || (ia_valid == ATTR_SIZE))
> +			goto out;
>  	}
> -
>  	if (ia_valid & ATTR_UID)
>  		inode->i_uid = attr->ia_uid;
>  	if (ia_valid & ATTR_GID)
> 
> btw. Is it actually correct that we "goto out;" when "ia_valid ==
> ATTR_SIZE"?  That way we skip the mark_inode_dirty() call just before
> the "out" label...
> 
> For ntfs at least that is fine because ntfs does an
> "inode_update_time(inode, 1)" unconditionally in ntfs_truncate() even
> when the size has not changed which calls mark_inode_dirty_sync() and
> when the size changes it also does a "__mark_inode_dirty(inode,
> I_DIRTY_SYNC | I_DIRTY_DATASYNC);" but I am not sure all filesystems are
> fine in that respect?
> 

I think the 'goto' is fine as presumably an error from vmtruncate
means that nothing was changed, and as there are no other attr bits,
there is no need to mark_inode_dirty.

However, there always will be other ATTR bits as whenever we set
ATTR_SIZE (do_truncate and nfsd_setattr) we also set ATTR_CTIME,
so this "optimisation" is just a waste of space.
Best make it:

>  	if (ia_valid & ATTR_SIZE)
> 		error = vmtruncate(inode, attr->ia_size);

and assume that the filesystem's ->truncate or ->setattr will still
set mtime if the size doesn't change (->truncate would have a hard
time knowing if it has changed or not, so it has to set mtime
unconditionally if it exists .. ->setattr... probably does the right
thing)

NeilBrown
