Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUD2Edg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUD2Edg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbUD2Edg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 00:33:36 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:25496 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263340AbUD2Edb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 00:33:31 -0400
Date: Wed, 28 Apr 2004 23:37:03 -0500 (CDT)
From: Brent Cook <busterbcook@yahoo.com>
X-X-Sender: busterb@ozma.hauschen
Reply-To: busterbcook@yahoo.com
To: Andrew Morton <akpm@osdl.org>
cc: busterbcook@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
In-Reply-To: <20040428210214.31efe911.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404282330390.13783@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
 <20040427230203.1e4693ac.akpm@osdl.org> <Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
 <20040428124809.418e005d.akpm@osdl.org> <Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
 <20040428182443.6747e34b.akpm@osdl.org> <Pine.LNX.4.58.0404282244280.13311@ozma.hauschen>
 <20040428210214.31efe911.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Andrew Morton wrote:

> Brent Cook <busterbcook@yahoo.com> wrote:
> >
> > sync_sb_inodes: write inode c55d25bc
> >  __sync_single_inode: writepages in nr_pages:25 nr_to_write:949
> >  pages_skipped:0 en:0
> >  __sync_single_inode: writepages in nr_pages:25 nr_to_write:949
> >  pages_skipped:0 en:0
>
> uh-huh.
>
> Does this fix it?

I'm going to run a compile/load test overnight, but the test that
triggered it every time previously failed to do so with this patch.

pdflush is behaving so far, and I'll say you've figured it out for now,
with the final verdict in about 8 hours.

Does this mean that, if there were too many dirty pages and not enough
time to write them all back, that the dirty page list just stopped being
traversed, stuck on a single page? That would make explain why this was
easier to trigger on NFS than a local FS, due to the extra latency, etc.

Maybe I should look into tuning my NFS server while we're at it, as yours
must be much faster ;)

 - Brent

>  25-akpm/fs/fs-writeback.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> diff -puN fs/fs-writeback.c~a fs/fs-writeback.c
> --- 25/fs/fs-writeback.c~a	2004-04-28 21:01:37.012603336 -0700
> +++ 25-akpm/fs/fs-writeback.c	2004-04-28 21:02:00.701002152 -0700
> @@ -191,8 +191,8 @@ __sync_single_inode(struct inode *inode,
>  				 */
>  				inode->i_state |= I_DIRTY_PAGES;
>  				inode->dirtied_when = jiffies;
> -				list_move(&inode->i_list, &sb->s_dirty);
>  			}
> +			list_move(&inode->i_list, &sb->s_dirty);
>  		} else if (inode->i_state & I_DIRTY) {
>  			/*
>  			 * Someone redirtied the inode while were writing back
>
> _
>
