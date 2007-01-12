Return-Path: <linux-kernel-owner+w=401wt.eu-S1161037AbXALVCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbXALVCS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbXALVCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:02:18 -0500
Received: from fe02.tochka.ru ([62.5.255.22]:56818 "EHLO umail.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161004AbXALVCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:02:17 -0500
From: Alex Tomas <alex@clusterfs.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] [RFC] remove ext3 inode from orphan list when link and unlink race
Organization: CFS
References: <45A7F384.3050303@redhat.com>
X-Comment-To: Eric Sandeen
Date: Sat, 13 Jan 2007 00:02:13 +0300
In-Reply-To: <45A7F384.3050303@redhat.com> (Eric Sandeen's message of "Fri\, 12
	Jan 2007 14\:45\:56 -0600")
Message-ID: <m34pqw0xii.fsf@bzzz.home.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


interesting ..

I thought VFS doesn't allow concurrent operations.
if unlink goes first, then link should wait on the
parent's i_mutex and then found no source name.

thanks, Alex

>>>>> Eric Sandeen (ES) writes:

 ES> )
 ES> I've been looking at a case where many threads are opening, unlinking, and
 ES> hardlinking files on ext3 .  At unmount time I see an oops, because the superblock's
 ES> orphan list points to a freed inode.

 ES> I did some tracing of the inodes, and it looks like this:

 ES>   ext3_unlink():[/src/linux-2.6.18/fs/ext3/namei.c:2123] adding orphan
 ES>       i_state:0x7 cpu:1 i_count:2 i_nlink:0

 ES>   ext3_orphan_add():[/src/linux-2.6.18/fs/ext3/namei.c:1890] ext3_orphan_add
 ES>       i_state:0x7 cpu:1 i_count:2 i_nlink:0

 ES>   iput():[/src/linux-2.6.18/fs/inode.c:1139] iput enter
 ES>       i_state:0x7 cpu:1 i_count:2 i_nlink:0

 ES>   ext3_link():[/src/linux-2.6.18/fs/ext3/namei.c:2202] ext3_link enter
 ES>       i_state:0x7 cpu:3 i_count:1 i_nlink:0

 ES>   ext3_inc_count():[/src/linux-2.6.18/fs/ext3/namei.c:1627] done
 ES>       i_state:0x7 cpu:3 i_count:1 i_nlink:1

 ES> The unlink gets there first, finds i_count > 0 (in use) but nlink goes to 0, so
 ES> it puts it on the orphan inode list.  Then link comes along, and bumps the link
 ES> back up to 1.  So now we are on the orphan inode list, but we are not unlinked.

 ES> Eventually when count goes to 0, and we still have 1 link, again no action is
 ES> taken to remove the inode from the orphan list, because it is still linked (i.e.
 ES> we don't go through ext3_delete())

 ES> When this inode is eventually freed, the sb orphan list gets corrupted, because 
 ES> we have freed it without first removing it from the orphan list.

 ES> I think the simple solution is to remove the inode from the orphan list
 ES> when we bump the link back up from 0 to 1.  I put that test in there because
 ES> there are other potential reasons that we might be on the list (truncates,
 ES> direct IO).

 ES> Comments?

 ES> Thanks,
 ES> -Eric

 ES> p.s. ext3_inc_count and ext3_dec_count seem misnamed, have an unused
 ES> arg, and are very infrequently called.  I'll probably submit a patch
 ES> to just put the single line of code into the caller, too.

 ES> ---

 ES> Remove inode from the orphan list in ext3_link() if we might have
 ES> raced with ext3_unlink(), which potentially put it on the list.
 ES> If we're on the list with nlink > 0, we'll never get cleaned up
 ES> properly and eventually may corrupt the list.

 ES> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

 ES> Index: linux-2.6.19/fs/ext3/namei.c
 ES> ===================================================================
 ES> --- linux-2.6.19.orig/fs/ext3/namei.c
 ES> +++ linux-2.6.19/fs/ext3/namei.c
 ES> @@ -2204,6 +2204,9 @@ retry:
 inode-> i_ctime = CURRENT_TIME_SEC;
 ES>  	ext3_inc_count(handle, inode);
 ES>  	atomic_inc(&inode->i_count);
 ES> +	/* did we race w/ unlink? */
 ES> +	if (inode->i_nlink == 1)
 ES> +		ext3_orphan_del(handle, inode);
 
 ES>  	err = ext3_add_nondir(handle, dentry, inode);
 ES>  	ext3_journal_stop(handle);


 ES> -
 ES> To unsubscribe from this list: send the line "unsubscribe linux-ext4" in
 ES> the body of a message to majordomo@vger.kernel.org
 ES> More majordomo info at  http://vger.kernel.org/majordomo-info.html
