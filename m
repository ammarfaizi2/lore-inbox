Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSLPVUQ>; Mon, 16 Dec 2002 16:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbSLPVUQ>; Mon, 16 Dec 2002 16:20:16 -0500
Received: from 216-42-72-142.ppp.netsville.net ([216.42.72.142]:62347 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S261376AbSLPVUP>;
	Mon, 16 Dec 2002 16:20:15 -0500
Subject: Re: ext3 updates for 2.4.20
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <3DFCE5E7.A8BE82B4@digeo.com>
References: <3DFCE5E7.A8BE82B4@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Dec 2002 16:28:12 -0500
Message-Id: <1040074092.17448.80.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm, this took me a while to find the first time around in the
commit_super code, and I almost forgot about it.

Looking at the loop in sync_supers()

       while (sb != sb_entry(&super_blocks))
                if (sb->s_dirt) {
                        sb->s_count++;
                        spin_unlock(&sb_lock);

Right here, we can race against kill_super, which means an unmount can
make the FS go away completely.  The only thing that saves the
write_super() call is a check for s->s_root != NULL.  Since we don't
check that before calling sync_fs, it should race against an unmount.

                        down_read(&sb->s_umount);
                        write_super(sb);
                        if (wait && sb->s_op && sb->s_op->sync_fs)
                                sb->s_op->sync_fs(sb);
                        drop_super(sb);
                        goto restart;
                } else

Any reason ext3 can't have a check for s_root in there?

-chris


