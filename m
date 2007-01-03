Return-Path: <linux-kernel-owner+w=401wt.eu-S1751072AbXACTGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbXACTGT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbXACTGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:06:19 -0500
Received: from mail.pxnet.com ([195.227.45.3]:46294 "EHLO lx1.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbXACTGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:06:19 -0500
Date: Wed, 3 Jan 2007 20:06:12 +0100
Message-Id: <200701031906.l03J6Csc005559@lx1.pxnet.com>
From: Tilman Schmidt <tilman@imap.cc>
Subject: [2.6.20-rc3] INFO: possible recursive locking detected (was: Happy New Year (and v2.6.20-rc3 released))
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2006 17:19:44 -0800 (PST), Linus Torvalds wrote:
> In order to not get in trouble with MADR ("Mothers Against Drunk 
> Releases") I decided to cut the 2.6.20-rc3 release early rather than wait 
[...]
> At which point the first thing on any self-respecting geek's mind should 
> obviously be: "is there a new kernel release for me to try?"

2.6.20-rc3 produces the following lockdep warning when hald is
started during system startup:

=============================================
[ INFO: possible recursive locking detected ]
2.6.20-rc3-noinitrd #0
---------------------------------------------
hald-subfs-moun/4608 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c035bb02>] mutex_lock+0x1c/0x1f

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c035bb02>] mutex_lock+0x1c/0x1f

other info that might help us debug this:
3 locks held by hald-subfs-moun/4608:
 #0:  (&inode->i_mutex){--..}, at: [<c035bb02>] mutex_lock+0x1c/0x1f
 #1:  (&REISERFS_I(inode)->xattr_sem){----}, at: [<c01c0098>] reiserfs_setxattr+0x51/0xe9
 #2:  (&REISERFS_SB(s)->xattr_dir_sem){----}, at: [<c01c00be>] reiserfs_setxattr+0x77/0xe9

stack backtrace:
 [<c0103c72>] show_trace_log_lvl+0x19/0x2e
 [<c0103d6b>] show_trace+0x12/0x14
 [<c0103d81>] dump_stack+0x14/0x16
 [<c01303b3>] __lock_acquire+0x116/0xa5c
 [<c0130fe6>] lock_acquire+0x56/0x70
 [<c035b95c>] __mutex_lock_slowpath+0xdc/0x266
 [<c035bb02>] mutex_lock+0x1c/0x1f
 [<c01c07d0>] reiserfs_xattr_set+0xe4/0x2c0
 [<c01c0c21>] trusted_set+0x74/0x80
 [<c01c00e9>] reiserfs_setxattr+0xa2/0xe9
 [<c0177b45>] vfs_setxattr+0xa6/0x1ff
 [<c0177d57>] setxattr+0xb9/0xd1
 [<c0177e14>] sys_lsetxattr+0x3e/0x50
 [<c0102d9a>] sysenter_past_esp+0x5f/0x99
 =======================

I guess it's really the same ReiserFS issue I already reported for
the previous releases, just triggered at an earlier point in the
system's life.

Other than that, everything seems fine and dandy on this plain old P3.

HTH, and Happy New Year everyone
Tilman

