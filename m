Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbTCTVZr>; Thu, 20 Mar 2003 16:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbTCTVZr>; Thu, 20 Mar 2003 16:25:47 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34754 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262569AbTCTVZn>; Thu, 20 Mar 2003 16:25:43 -0500
Subject: Re: [Patch] ext3_journal_stop inode access
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: ext3 users list <ext3-users@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030320131523.6c56d10f.akpm@digeo.com>
References: <1048185825.2491.386.camel@sisko.scot.redhat.com>
	 <20030320131523.6c56d10f.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048196202.2491.603.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 20 Mar 2003 21:36:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2003-03-20 at 21:15, Andrew Morton wrote:

> Burton has confirmed that removing the
> 
> 	inode->i_sb->s_dirt = 1;
> 
> line makes the oopses go away, so this will fix it.

Good.

> > It makes ext3_journal_stop take an sb, not an inode, as its final
> > parameter.
> 
> argh.  I wrote and tested a patch too.  That patch puts the superblock
> pointer into the new journal->j_private and removes the second arg to
> ext3_journal_start altogether.

Well, there's still the

	if (err)
		__ext3_std_error(inode->i_sb, where, err);

case in ext3_journal_stop() to worry about, so we still need it; and I'd
much rather not hack this via j_private, when what we're doing at this
point is most definitely a fs-specific, not journal-related, operation.

> I went that way just to save a little text.  Because ext3_journal_start/stop
> need to be uninlined - that saves 5.5 kbytes of text.

Agreed.

> Which do you think is best?  If you're planning on patching 2.4 and if you
> want to do that by passing the superblock pointer in, then we should go that
> way in 2.5 too, keep things in sync.

I was wondering why we've never seen this on 2.4, even with slab
poisoning enabled.  But I think the vulnerability exists on 2.4 too, so
yes, we ought to keep the two in sync.

> > It also sets sb->s_need_sync_fs, not sb->s_dirt, as setting
> > s_dirt was only ever a workaround for the lack of a proper sync-fs
> > mechanism.
> > 
> > Btw, we clear s_need_sync_fs in sync_filesystems().  Don't we also need
> > to do the same in fsync_super()?
> 
> The intent of s_need_sync_fs is to avoid livelock in sync_filesystems().
...

Well, the intent of the s_dirt was to force a call to ext3_write_super
when the fs was dirty, back before the days when we had a sync_fs()
method at all.  Now that we have the latter, it sounds like we should
actually just drop the line which sets s_dirt in ext3_journal_stop
entirely, because sync will always call the new sync_fs which will do
the commit that we need.

We still have the error handling path in ext3_journal_stop so we can't
avoid having to find the sb, so _some_ rejigging is still needed.

Cheers,
 Stephen

