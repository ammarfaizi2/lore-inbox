Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWIEUeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWIEUeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 16:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWIEUeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 16:34:12 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:41165 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1161051AbWIEUeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 16:34:09 -0400
Date: Tue, 5 Sep 2006 22:33:09 +0200
From: Mattia Dongili <malattia@linux.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: shaggy@austin.ibm.com, akpm@osdl.org
Subject: JFS - real deadlock and lockdep warning (2.6.18-rc5-mm1)
Message-ID: <20060905203309.GA3981@inferi.kami.home>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	shaggy@austin.ibm.com, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc5-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

as the subject says it's some time[0] I'm experiencing deadlocks[1] (I'm
only tracking -mm, and sporadically using the stable series). I have a
couple of use cases that seem to reliably trigger the deadlock, namely
using Eclipse and Firefox.

[0]: I'd say at least since 2.6.17-rc-something
[1]: no sysrq, no logs, no nothing, netconsole doesn't log anything
     more, just screwed FS which grub can't read (Inconsistent
     filesystem - press any key to continue)

I decided to try out the LOCKDEP stuff to see if I can provide more
useful info, and here we go, as soon as my /home (jfs) partition is
written (at login):
[   72.420000] 
[   72.420000] =============================================
[   72.420000] [ INFO: possible recursive locking detected ]
[   72.420000] 2.6.18-rc5-mm1-2-lockdep #9
[   72.420000] ---------------------------------------------
[   72.420000] zsh/3844 is trying to acquire lock:
[   72.420000]  (&jfs_ip->commit_mutex){--..}, at: [<c0320948>] mutex_lock+0x8/0x10
[   72.420000] 
[   72.420000] but task is already holding lock:
[   72.420000]  (&jfs_ip->commit_mutex){--..}, at: [<c0320948>] mutex_lock+0x8/0x10
[   72.420000] 
[   72.420000] other info that might help us debug this:
[   72.420000] 2 locks held by zsh/3844:
[   72.420000]  #0:  (&inode->i_mutex){--..}, at: [<c0320948>] mutex_lock+0x8/0x10
[   72.420000]  #1:  (&jfs_ip->commit_mutex){--..}, at: [<c0320948>] mutex_lock+0x8/0x10
[   72.420000] 
[   72.420000] stack backtrace:
[   72.420000]  [<c0103b8f>] dump_trace+0x1ef/0x230
[   72.420000]  [<c0103bf6>] show_trace_log_lvl+0x26/0x40
[   72.420000]  [<c01043cb>] show_trace+0x1b/0x20
[   72.420000]  [<c01044b4>] dump_stack+0x24/0x30
[   72.420000]  [<c0136050>] __lock_acquire+0x8e0/0xd80
[   72.420000]  [<c0136869>] lock_acquire+0x69/0x90
[   72.420000]  [<c0320705>] __mutex_lock_slowpath+0x75/0x2b0
[   72.420000]  [<c0320948>] mutex_lock+0x8/0x10
[   72.420000]  [<d137950b>] jfs_create+0xbb/0x420 [jfs]
[   72.420000]  [<c016cb7b>] vfs_create+0xcb/0x120
[   72.420000]  [<c0170158>] open_namei+0x618/0x6f0
[   72.420000]  [<c0162368>] do_filp_open+0x38/0x60
[   72.420000]  [<c01623db>] do_sys_open+0x4b/0xf0
[   72.420000]  [<c01624d7>] sys_open+0x27/0x30
[   72.420000]  [<c01032af>] syscall_call+0x7/0xb
[   72.420000]  [<b7ec8b8d>] 0xb7ec8b8d
[   72.420000]  =======================

I suspect JFS is guilty, anyway my HD has these partitions:

/dev/hda1 on / type reiserfs (rw)
/dev/hda3 on /usr type reiserfs (rw)
/dev/hda5 on /home type jfs (rw)

bootlog: http://oioio.altervista.org/linux/dmesg-2.6.18-rc5-mm1-lockdep
config: http://oioio.altervista.org/linux/config-2.6.18-rc5-mm1-lockdep

-- 
mattia
:wq!
