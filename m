Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWIFWAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWIFWAe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWIFWAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:00:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:28861 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751268AbWIFWAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:00:33 -0400
Subject: Re: JFS - real deadlock and lockdep warning (2.6.18-rc5-mm1)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Mattia Dongili <malattia@linux.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20060905203309.GA3981@inferi.kami.home>
References: <20060905203309.GA3981@inferi.kami.home>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 17:00:28 -0500
Message-Id: <1157580028.8200.72.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I meant to reply to this earlier.  I've had a lot of distractions.

On Tue, 2006-09-05 at 22:33 +0200, Mattia Dongili wrote:
> Hello,
> 
> as the subject says it's some time[0] I'm experiencing deadlocks[1] (I'm
> only tracking -mm, and sporadically using the stable series). I have a
> couple of use cases that seem to reliably trigger the deadlock, namely
> using Eclipse and Firefox.
> 
> [0]: I'd say at least since 2.6.17-rc-something
> [1]: no sysrq, no logs, no nothing, netconsole doesn't log anything
>      more, just screwed FS which grub can't read (Inconsistent
>      filesystem - press any key to continue)
> 
> I decided to try out the LOCKDEP stuff to see if I can provide more
> useful info, and here we go, as soon as my /home (jfs) partition is
> written (at login):
> [   72.420000] 
> [   72.420000] =============================================
> [   72.420000] [ INFO: possible recursive locking detected ]
> [   72.420000] 2.6.18-rc5-mm1-2-lockdep #9
> [   72.420000] ---------------------------------------------
> [   72.420000] zsh/3844 is trying to acquire lock:
> [   72.420000]  (&jfs_ip->commit_mutex){--..}, at: [<c0320948>] mutex_lock+0x8/0x10
> [   72.420000] 
> [   72.420000] but task is already holding lock:
> [   72.420000]  (&jfs_ip->commit_mutex){--..}, at: [<c0320948>] mutex_lock+0x8/0x10
> [   72.420000] 
> [   72.420000] other info that might help us debug this:
> [   72.420000] 2 locks held by zsh/3844:
> [   72.420000]  #0:  (&inode->i_mutex){--..}, at: [<c0320948>] mutex_lock+0x8/0x10
> [   72.420000]  #1:  (&jfs_ip->commit_mutex){--..}, at: [<c0320948>] mutex_lock+0x8/0x10
> [   72.420000] 
> [   72.420000] stack backtrace:
> [   72.420000]  [<c0103b8f>] dump_trace+0x1ef/0x230
> [   72.420000]  [<c0103bf6>] show_trace_log_lvl+0x26/0x40
> [   72.420000]  [<c01043cb>] show_trace+0x1b/0x20
> [   72.420000]  [<c01044b4>] dump_stack+0x24/0x30
> [   72.420000]  [<c0136050>] __lock_acquire+0x8e0/0xd80
> [   72.420000]  [<c0136869>] lock_acquire+0x69/0x90
> [   72.420000]  [<c0320705>] __mutex_lock_slowpath+0x75/0x2b0
> [   72.420000]  [<c0320948>] mutex_lock+0x8/0x10
> [   72.420000]  [<d137950b>] jfs_create+0xbb/0x420 [jfs]
> [   72.420000]  [<c016cb7b>] vfs_create+0xcb/0x120
> [   72.420000]  [<c0170158>] open_namei+0x618/0x6f0
> [   72.420000]  [<c0162368>] do_filp_open+0x38/0x60
> [   72.420000]  [<c01623db>] do_sys_open+0x4b/0xf0
> [   72.420000]  [<c01624d7>] sys_open+0x27/0x30
> [   72.420000]  [<c01032af>] syscall_call+0x7/0xb
> [   72.420000]  [<b7ec8b8d>] 0xb7ec8b8d
> [   72.420000]  =======================
> 
> I suspect JFS is guilty, anyway my HD has these partitions:

I haven't got around to instrumenting jfs properly with
mutex_lock_nested(), so I know jfs doesn't run clean with lockdep
enabled.  What that means is that these warnings don't necessarily point
to a real problem, and on the other hand, lockdep hasn't been run
correctly against jfs to prove that the mutex usage is safe.

That said, I'm not aware of any known problems in jfs resulting in a
deadlock.  Unfortunately, without being able to use sysrq, I don't have
any real good ideas for you off the top of my head to further track down
the problem.

I'm pretty busy this week, but I'll try to get the lockdep stuff right
in jfs as soon as possible.  Who knows?  Maybe it will find a real
locking problem.

> 
> /dev/hda1 on / type reiserfs (rw)
> /dev/hda3 on /usr type reiserfs (rw)
> /dev/hda5 on /home type jfs (rw)
> 
> bootlog: http://oioio.altervista.org/linux/dmesg-2.6.18-rc5-mm1-lockdep
> config: http://oioio.altervista.org/linux/config-2.6.18-rc5-mm1-lockdep
> 
-- 
David Kleikamp
IBM Linux Technology Center

