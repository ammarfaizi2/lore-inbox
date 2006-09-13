Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWIMShR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWIMShR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWIMSgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:36:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:39581 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751075AbWIMSgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:36:43 -0400
Subject: Re: - r-o-bind-mount-clean-up-ocfs2-nlink-handling.patch removed
	from -mm tree
From: Dave Hansen <haveblue@us.ibm.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
       mm-commits@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060913182716.GI8792@ca-server1.us.oracle.com>
References: <200609130506.k8D56U3m018878@shell0.pdx.osdl.net>
	 <20060913182716.GI8792@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 11:36:36 -0700
Message-Id: <1158172596.9141.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 11:27 -0700, Mark Fasheh wrote:
> On Tue, Sep 12, 2006 at 10:06:30PM -0700, akpm@osdl.org wrote:
> > The patch titled
> > 
> >      r/o bind mounts: clean up OCFS2 nlink handling
> > 
> > has been removed from the -mm tree.  Its filename is
> > 
> >      r-o-bind-mount-clean-up-ocfs2-nlink-handling.patch
> > 
> > This patch was dropped because git-ocfs2 changes broke it. New patch, please.
> Yep, that was very likely due to my dentry vote removal changes.
> 
> Dave, how's this one look? I guess I'll leave the same description message
> below...

I was _just_ fighting with your git tree to see what was conflicting!
You have impeccable timing.

>  static int ocfs2_unlink(struct inode *dir,
>  			struct dentry *dentry)
>  {
>  	int status;
> -	unsigned int saved_nlink = 0;
>  	struct inode *inode = dentry->d_inode;
>  	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
>  	u64 blkno;
> @@ -813,6 +825,7 @@ static int ocfs2_unlink(struct inode *di
>  	struct buffer_head *dirent_bh = NULL;
>  	char orphan_name[OCFS2_ORPHAN_NAMELEN + 1];
>  	struct buffer_head *orphan_entry_bh = NULL;
> +	unsigned int future_nlink;
>  
>  	mlog_entry("(0x%p, 0x%p, '%.*s')\n", dir, dentry,
>  		   dentry->d_name.len, dentry->d_name.name);
> @@ -876,15 +889,10 @@ static int ocfs2_unlink(struct inode *di
>  		}
>  	}
>  
> -	/* There are still a few steps left until we can consider the
> -	 * unlink to have succeeded. Save off nlink here before
> -	 * modification so we can set it back in case we hit an issue
> -	 * before commit. */
> -	saved_nlink = inode->i_nlink;
> -	if (S_ISDIR(inode->i_mode))
> -		inode->i_nlink = 0;
> +	if (S_ISDIR(inode->i_mode) && (inode->i_nlink == 2))
> +		future_nlink = 0;
>  	else
> -		inode->i_nlink--;
> +		future_nlink = inode->i_nlink - 1;

Now that the vote call is gone, I don't think we even use future_nlink.
Can we just kill this entire section?

-- Dave

