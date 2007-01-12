Return-Path: <linux-kernel-owner+w=401wt.eu-S964970AbXALVYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbXALVYo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbXALVYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:24:44 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:53764 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964813AbXALVYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:24:42 -0500
Subject: Re: [PATCH] [RFC] remove ext3 inode from orphan list when link and
	unlink race
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
In-Reply-To: <m34pqw0xii.fsf@bzzz.home.net>
References: <45A7F384.3050303@redhat.com>  <m34pqw0xii.fsf@bzzz.home.net>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 15:24:39 -0600
Message-Id: <1168637079.10036.2.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-13 at 00:02 +0300, Alex Tomas wrote:
> interesting ..
> 
> I thought VFS doesn't allow concurrent operations.
> if unlink goes first, then link should wait on the
> parent's i_mutex and then found no source name.

I don't think the VFS ever takes the source's parent's i_mutex.  Unless
the source and destination's parent is the same, in which case the
i_mutex is taken after the source has already been looked up.

> thanks, Alex
> 
> >>>>> Eric Sandeen (ES) writes:
> 
>  ES> )
>  ES> I've been looking at a case where many threads are opening, unlinking, and
>  ES> hardlinking files on ext3 .  At unmount time I see an oops, because the superblock's
>  ES> orphan list points to a freed inode.
> 
>  ES> I did some tracing of the inodes, and it looks like this:
> 
>  ES>   ext3_unlink():[/src/linux-2.6.18/fs/ext3/namei.c:2123] adding orphan
>  ES>       i_state:0x7 cpu:1 i_count:2 i_nlink:0
> 
>  ES>   ext3_orphan_add():[/src/linux-2.6.18/fs/ext3/namei.c:1890] ext3_orphan_add
>  ES>       i_state:0x7 cpu:1 i_count:2 i_nlink:0
> 
>  ES>   iput():[/src/linux-2.6.18/fs/inode.c:1139] iput enter
>  ES>       i_state:0x7 cpu:1 i_count:2 i_nlink:0
> 
>  ES>   ext3_link():[/src/linux-2.6.18/fs/ext3/namei.c:2202] ext3_link enter
>  ES>       i_state:0x7 cpu:3 i_count:1 i_nlink:0
> 
>  ES>   ext3_inc_count():[/src/linux-2.6.18/fs/ext3/namei.c:1627] done
>  ES>       i_state:0x7 cpu:3 i_count:1 i_nlink:1
> 
>  ES> The unlink gets there first, finds i_count > 0 (in use) but nlink goes to 0, so
>  ES> it puts it on the orphan inode list.  Then link comes along, and bumps the link
>  ES> back up to 1.  So now we are on the orphan inode list, but we are not unlinked.
> 
>  ES> Eventually when count goes to 0, and we still have 1 link, again no action is
>  ES> taken to remove the inode from the orphan list, because it is still linked (i.e.
>  ES> we don't go through ext3_delete())
> 
>  ES> When this inode is eventually freed, the sb orphan list gets corrupted, because 
>  ES> we have freed it without first removing it from the orphan list.
> 
>  ES> I think the simple solution is to remove the inode from the orphan list
>  ES> when we bump the link back up from 0 to 1.  I put that test in there because
>  ES> there are other potential reasons that we might be on the list (truncates,
>  ES> direct IO).
> 
>  ES> Comments?
> 
>  ES> Thanks,
>  ES> -Eric
> 
>  ES> p.s. ext3_inc_count and ext3_dec_count seem misnamed, have an unused
>  ES> arg, and are very infrequently called.  I'll probably submit a patch
>  ES> to just put the single line of code into the caller, too.
> 
>  ES> ---
> 
>  ES> Remove inode from the orphan list in ext3_link() if we might have
>  ES> raced with ext3_unlink(), which potentially put it on the list.
>  ES> If we're on the list with nlink > 0, we'll never get cleaned up
>  ES> properly and eventually may corrupt the list.
> 
>  ES> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
>  ES> Index: linux-2.6.19/fs/ext3/namei.c
>  ES> ===================================================================
>  ES> --- linux-2.6.19.orig/fs/ext3/namei.c
>  ES> +++ linux-2.6.19/fs/ext3/namei.c
>  ES> @@ -2204,6 +2204,9 @@ retry:
>  inode-> i_ctime = CURRENT_TIME_SEC;
>  ES>  	ext3_inc_count(handle, inode);
>  ES>  	atomic_inc(&inode->i_count);
>  ES> +	/* did we race w/ unlink? */
>  ES> +	if (inode->i_nlink == 1)
>  ES> +		ext3_orphan_del(handle, inode);
>  
>  ES>  	err = ext3_add_nondir(handle, dentry, inode);
>  ES>  	ext3_journal_stop(handle);

-- 
David Kleikamp
IBM Linux Technology Center

