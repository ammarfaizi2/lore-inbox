Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932271AbWFDVuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWFDVuI (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWFDVuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:50:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:50882 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932270AbWFDVuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:50:04 -0400
Subject: Re: [PATCH] jfs: possible deadlocks - continue
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20060604154409.GA13899@rain.homenetwork>
References: <20060604154409.GA13899@rain.homenetwork>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 16:49:56 -0500
Message-Id: <1149457796.10576.14.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 19:44 +0400, Evgeniy Dushistov wrote:
> For some reasons my post about "possible deadlocks"
> didn't appear in jfs-discussion@lists.sourceforge.net.

Nothings showing up there.  I guess it's a sourceforge problem.

> >====================================
> >[ BUG: possible deadlock detected! ]
> >------------------------------------
> >mount/5587 is trying to acquire lock:
> > (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
> >
> >but task is already holding lock:
> > (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
> >
> >which could potentially lead to deadlocks!
> >
> >other info that might help us debug this:
> >2 locks held by mount/5587:
> > #0:  (&inode->i_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
> > #1:  (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
> >
> >stack backtrace:
> > [<c0103095>] show_trace+0x16/0x19
> > [<c0103562>] dump_stack+0x1a/0x1f
> > [<c012ddd7>] __lockdep_acquire+0x6c6/0x907
> > [<c012e063>] lockdep_acquire+0x4b/0x63
> > [<c02f6f0c>] __mutex_lock_slowpath+0xa4/0x21c
> > [<c02f7096>] mutex_lock+0x12/0x15
> > [<c01b99be>] jfs_create+0x90/0x2b8
> > [<c0161016>] vfs_create+0x91/0xda
> > [<c0163939>] open_namei+0x15a/0x5b0
> > [<c015326c>] do_filp_open+0x22/0x39
> > [<c01541a8>] do_sys_open+0x40/0xbc
> > [<c015424d>] sys_open+0x13/0x15
> > [<c02f875d>] sysenter_past_esp+0x56/0x8d
> 
> I should add that this happened during boot, when root jfs
> file system become from ro->rw
> 
> I look at code, and see that
> 1)locks wasn't release in the opposite order in which
> they were taken

Why does this matter?

> 2)in jfs_rename we lock new_ip, and in "error path" we didn't unlock it

Good catch!  This isn't related to the warning, but it's potentially
worse.

> 3)I see strange expression: "! !"

I hadn't noticed this.  It was introduced when changing from semaphores
to mutexes.

> 
> May be this worth to fix?

2 & 3 for sure.  I don't see the need for fixing 1.

I think the warning needs to be fixed by introducing mutex_lock_nested
in some places.  I'll take a look at it.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

