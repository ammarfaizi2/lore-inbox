Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264355AbUD2NQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264355AbUD2NQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 09:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUD2NQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 09:16:08 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:34897 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264355AbUD2NQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 09:16:02 -0400
Date: Thu, 29 Apr 2004 08:19:42 -0500 (CDT)
From: Brent Cook <busterbcook@yahoo.com>
X-X-Sender: busterb@ozma.hauschen
Reply-To: busterbcook@yahoo.com
To: Andrew Morton <akpm@osdl.org>
cc: busterbcook@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
In-Reply-To: <20040428214741.7d5b3ae1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404290758300.24731@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
 <20040427230203.1e4693ac.akpm@osdl.org> <Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
 <20040428124809.418e005d.akpm@osdl.org> <Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
 <20040428182443.6747e34b.akpm@osdl.org> <Pine.LNX.4.58.0404282244280.13311@ozma.hauschen>
 <20040428210214.31efe911.akpm@osdl.org> <Pine.LNX.4.58.0404282330390.13783@ozma.hauschen>
 <20040428214741.7d5b3ae1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Andrew Morton wrote:

> Brent Cook <busterbcook@yahoo.com> wrote:
> >
> > On Wed, 28 Apr 2004, Andrew Morton wrote:
> >
> >  > Brent Cook <busterbcook@yahoo.com> wrote:
> >  > >
> >  > > sync_sb_inodes: write inode c55d25bc
> >  > >  __sync_single_inode: writepages in nr_pages:25 nr_to_write:949
> >  > >  pages_skipped:0 en:0
> >  > >  __sync_single_inode: writepages in nr_pages:25 nr_to_write:949
> >  > >  pages_skipped:0 en:0
> >  >
> >  > uh-huh.
> >  >
> >  > Does this fix it?
> >
> >  I'm going to run a compile/load test overnight, but the test that
> >  triggered it every time previously failed to do so with this patch.
>
> OK, thanks.  A better patch would be:

No, thank you! The overnight test was successful. I have been running this
better patch for a little while, and it is no worse. I think you have
solved the bigger problem, which was the runaway process, at least for me.

So, moving it to the tail of the s_dirty list now puts that page in a
higher-priority to be written back next time? That sounds better than just
redirtying it; the poor inode has been through enough as it is without
having to wait even longer.

If you want to think about it a little more, pdflush on 2.6.6-rc3 with
this patch still seems to use more resources than it did on 2.6.5. With
heavy NFS traffic, it still uses about 2-3% CPU on 2.6.6-rc3, but on 2.6.5
it averages about 0.1%. Maybe it just wasn't being used to its full
potential in 2.6.5?

Thanks
 - Brent

>
> diff -puN fs/fs-writeback.c~writeback-livelock-fix-2 fs/fs-writeback.c
> --- 25/fs/fs-writeback.c~writeback-livelock-fix-2	2004-04-28 21:19:32.779061976 -0700
> +++ 25-akpm/fs/fs-writeback.c	2004-04-28 21:20:11.080239312 -0700
> @@ -176,11 +176,12 @@ __sync_single_inode(struct inode *inode,
>  			if (wbc->for_kupdate) {
>  				/*
>  				 * For the kupdate function we leave the inode
> -				 * where it is on sb_dirty so it will get more
> +				 * at the head of sb_dirty so it will get more
>  				 * writeout as soon as the queue becomes
>  				 * uncongested.
>  				 */
>  				inode->i_state |= I_DIRTY_PAGES;
> +				list_move_tail(&inode->i_list, &sb->s_dirty);
>  			} else {
>  				/*
>  				 * Otherwise fully redirty the inode so that
>
> _
>
> >  pdflush is behaving so far, and I'll say you've figured it out for now,
> >  with the final verdict in about 8 hours.
> >
> >  Does this mean that, if there were too many dirty pages and not enough
> >  time to write them all back, that the dirty page list just stopped being
> >  traversed, stuck on a single page?
>
> No..  There's all sorts of livelock avoidance code in there and I keep on
> forgetting that sometimes writepage won't write the dang page at all -
> instead it just redirties the page (and hence the inode).
>
> Now, that redirtying of the inode _should_ have moved the inode off the
> s_io list and onto the s_dirty list.  But for some reason it looks like it
> didn't, so we get stuck in a loop.  I need to think about it a bit more.
