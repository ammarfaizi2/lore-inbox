Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270295AbTHGPWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270328AbTHGPWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:22:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:25551 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270295AbTHGPWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:22:47 -0400
Date: Thu, 7 Aug 2003 08:24:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Drokin <green@namesys.com>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] reiserfs: fix locking in reiserfs_remount
Message-Id: <20030807082440.09b81626.akpm@osdl.org>
In-Reply-To: <20030807133358.GC20639@namesys.com>
References: <20030806093858.GF14457@namesys.com>
	<20030806172813.GB21290@matchmail.com>
	<20030806173114.GB15024@namesys.com>
	<3F32531B.7080000@namesys.com>
	<20030807133358.GC20639@namesys.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> wrote:
>
> Hello!
> 
> On Thu, Aug 07, 2003 at 05:24:43PM +0400, Hans Reiser wrote:
> 
> > >Reiserfs needs BKL for it's journal operations. This is not "more",
> > >for some time BKL was taken in the VFS, then whoever removed that,
> > >forgot to propagate BKL down to actual fs methods that need the BKL.
> > Is it known who removed it?
> 
> I think it was Andrew. At least this new emergency remount path without
> BKL was introduced by his patch without any extra attribution.

Is that the only path?  It appears that way to me.

The Locking document says that ->remoutn_fs is called under lock_kernel(),
so this should be fixed at the VFS level.

 fs/super.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -puN fs/super.c~remount_fs-lock_kernel fs/super.c
--- 25/fs/super.c~remount_fs-lock_kernel	2003-08-07 08:17:38.000000000 -0700
+++ 25-akpm/fs/super.c	2003-08-07 08:23:42.000000000 -0700
@@ -507,8 +507,16 @@ static void do_emergency_remount(unsigne
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 		down_read(&sb->s_umount);
-		if (sb->s_root && sb->s_bdev && !(sb->s_flags & MS_RDONLY))
+		if (sb->s_root && sb->s_bdev && !(sb->s_flags & MS_RDONLY)) {
+			/*
+			 * ->remount_fs needs lock_kernel().
+			 *
+			 * What lock protects sb->s_flags??
+			 */
+			lock_kernel();
 			do_remount_sb(sb, MS_RDONLY, NULL, 1);
+			unlock_kernel();
+		}
 		drop_super(sb);
 		spin_lock(&sb_lock);
 	}

_

