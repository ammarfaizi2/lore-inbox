Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbTCTVEa>; Thu, 20 Mar 2003 16:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262333AbTCTVEa>; Thu, 20 Mar 2003 16:04:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:54187 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262291AbTCTVEV>;
	Thu, 20 Mar 2003 16:04:21 -0500
Date: Thu, 20 Mar 2003 13:15:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Patch] ext3_journal_stop inode access
Message-Id: <20030320131523.6c56d10f.akpm@digeo.com>
In-Reply-To: <1048185825.2491.386.camel@sisko.scot.redhat.com>
References: <1048185825.2491.386.camel@sisko.scot.redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Mar 2003 21:15:08.0747 (UTC) FILETIME=[C92811B0:01C2EF25]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> Hi Andrew,
> 
> The patch below addresses the problem we were talking about earlier
> where ext3_writepage ends up accessing the inode after the page lock has
> been dropped (and hence at a point where it is possible for the inode to
> have been reclaimed.)  Tested minimally (it builds and boots.)

Burton has confirmed that removing the

	inode->i_sb->s_dirt = 1;

line makes the oopses go away, so this will fix it.

> It makes ext3_journal_stop take an sb, not an inode, as its final
> parameter.

argh.  I wrote and tested a patch too.  That patch puts the superblock
pointer into the new journal->j_private and removes the second arg to
ext3_journal_start altogether.

I went that way just to save a little text.  Because ext3_journal_start/stop
need to be uninlined - that saves 5.5 kbytes of text.

Which do you think is best?  If you're planning on patching 2.4 and if you
want to do that by passing the superblock pointer in, then we should go that
way in 2.5 too, keep things in sync.

> It also sets sb->s_need_sync_fs, not sb->s_dirt, as setting
> s_dirt was only ever a workaround for the lack of a proper sync-fs
> mechanism.
> 
> Btw, we clear s_need_sync_fs in sync_filesystems().  Don't we also need
> to do the same in fsync_super()?

The intent of s_need_sync_fs is to avoid livelock in sync_filesystems().

Imagine that two filesytems are being continually dirtied.  It would be very,
very easy for a sync_filesystems() caller to never terminate.  This is a
repeated problem with lists of dirty objects which need cleaning, in which
only the head-of-list is stable outside the lock.

So sync_filesystems() will tag all the filesystems on the first pass and then
only sync tagged filesytems on the second pass.  No livelock.  (This still
means that new sync() callers will cause older sync() callers to perform a
second round of syncing.  I guess I should slap a mutex around the whole
thing to prevent that).

So s_need_sync_fs is "private to sync_fileystems".  I should have commented
that, sorry.



sync_filesystems() will even call call ->sync_fs against non-s_dirt
filesystems, which seems a little odd.

The reason for this is that ext3_write_super() will clear s_dirt and _not_
wait on the writeout.  So if sync_filesystems() happened to be called against
a filesystem shortly after its ->write_super() had been called,
sync_filesystems() would incorrectly assume that the filesystem was fully
synced.

I shall comment that, too.
