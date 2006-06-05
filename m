Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932410AbWFEE4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWFEE4G (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 00:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWFEE4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 00:56:06 -0400
Received: from mx1.mail.ru ([194.67.23.121]:64894 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S932407AbWFEE4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 00:56:05 -0400
Date: Mon, 5 Jun 2006 09:00:22 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Dave Kleikamp <shaggy@austin.ibm.com>, Ingo Molnar <mingo@elte.hu>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] jfs: possible deadlocks - continue
Message-ID: <20060605050022.GA15176@rain.homenetwork>
Mail-Followup-To: Dave Kleikamp <shaggy@austin.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060604154409.GA13899@rain.homenetwork> <1149457796.10576.14.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149457796.10576.14.camel@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 04:49:56PM -0500, Dave Kleikamp wrote:
> On Sun, 2006-06-04 at 19:44 +0400, Evgeniy Dushistov wrote:
> > I should add that this happened during boot, when root jfs
> > file system become from ro->rw
> > 
> > I look at code, and see that
> > 1)locks wasn't release in the opposite order in which
> > they were taken
> 
> Why does this matter?
> 
Like "3" it make code more understandable,
reader of code don't have to think why
code looks like:
lock A, lock B unlock A, unlock B
while a normal practice in kernel:
lock A, lock B unlock B unlock A
the goal of change just simplicity and clearness,
and nothing more.


> I think the warning needs to be fixed by introducing mutex_lock_nested
> in some places.  I'll take a look at it.
> 
To avoid incomprehension, previous patch just make code more
understandable and unlock mutex on "error path", it doesn't fix
this warning and I have no idea why it happend:

====================================
[ BUG: possible deadlock detected! ]
------------------------------------
mount/5587 is trying to acquire lock:
 (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15

but task is already holding lock:
 (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15

which could potentially lead to deadlocks!

other info that might help us debug this:
2 locks held by mount/5587:
 #0:  (&inode->i_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
 #1:  (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15

stack backtrace:
 [<c0103095>] show_trace+0x16/0x19
 [<c0103562>] dump_stack+0x1a/0x1f
 [<c012ddd7>] __lockdep_acquire+0x6c6/0x907
 [<c012e063>] lockdep_acquire+0x4b/0x63
 [<c02f6f0c>] __mutex_lock_slowpath+0xa4/0x21c
 [<c02f7096>] mutex_lock+0x12/0x15
 [<c01b99be>] jfs_create+0x90/0x2b8
 [<c0161016>] vfs_create+0x91/0xda
 [<c0163939>] open_namei+0x15a/0x5b0
 [<c015326c>] do_filp_open+0x22/0x39
 [<c01541a8>] do_sys_open+0x40/0xbc
 [<c015424d>] sys_open+0x13/0x15
 [<c02f875d>] sysenter_past_esp+0x56/0x8d

-- 
/Evgeniy

