Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbSLBRhn>; Mon, 2 Dec 2002 12:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSLBRhn>; Mon, 2 Dec 2002 12:37:43 -0500
Received: from packet.digeo.com ([12.110.80.53]:41359 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264654AbSLBRhm>;
	Mon, 2 Dec 2002 12:37:42 -0500
Message-ID: <3DEB9C20.9008C6E9@digeo.com>
Date: Mon, 02 Dec 2002 09:45:04 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Nick Piggin <piggin@cyberone.com.au>, lkml <linux-kernel@vger.kernel.org>,
       ext3 users list <ext3-users@redhat.com>
Subject: Re: data corrupting bug in 2.4.20 ext3, data=journal
References: <3DEB08EE.CBA49BA@digeo.com> <1038831305.1852.102.camel@sisko.scot.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2002 17:45:04.0702 (UTC) FILETIME=[8BF26DE0:01C29A2A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> ...
> The problem is that ext3 is expecting that truncate_inode_pages() (and
> hence ext3_flushpage) is only called during a truncate.

That's OK, because there shouldn't be any dirty data attached to the
inodes at that time.  But there is, because the commit which write_super()
started hasn't finished yet:

static int do_sync_supers = 0;
...
        target = log_start_commit(EXT3_SB(sb)->s_journal, NULL);

        if (do_sync_supers) {
                unlock_super(sb);
                log_wait_commit(EXT3_SB(sb)->s_journal, target);

We need to do a full sync at unmount.

I assume that in other journalling modes the buffers are dirty
anyway, so sync_buffers() gets them.

And indeed enabling do_sync_supers fixes it up in both 2.4 and 2.5 (2.5
doesn't have sync_buffers(), but sync_inodes_sb() gets everything).

But are we sure that ->write_super() will always be called?

int fsync_super(struct super_block *sb)
{
 	...
        if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
                sb->s_op->write_super(sb);

I suspect that if s_dirt is not set, and we have dirty inodes,
write_super is not called and nothing will force a commit anywhere
in the unmount process.  Which could explain the similar failure
in 2.4.19-rc1 which Nick reports.

We need to be able to distinguish between a periodic flush of the
superblock and a real sync.  The write_super overload has always
been uncomfortable.

Google for "write_super is not for syncing" ;)  I think Chris's
patch is the way to fix all this up.
