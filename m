Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWFHHcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWFHHcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWFHHcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:32:41 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:44470 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932545AbWFHHck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:32:40 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock
	detected!
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 08 Jun 2006 08:32:33 +0100
Message-Id: <1149751953.10056.10.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the report.

On Wed, 2006-06-07 at 21:27 -0700, Miles Lane wrote:
> =====================================================
> [ BUG: possible circular locking deadlock detected! ]
> -----------------------------------------------------
> mount/1219 is trying to acquire lock:
>  (&ni->mrec_lock){--..}, at: [<c031e4b8>] mutex_lock+0x21/0x24
> 
> but task is already holding lock:
>  (&rl->lock){----}, at: [<f8a98e4d>] ntfs_map_runlist+0x2a/0xb5 [ntfs]
> 
> which lock already depends on the new lock,
> which could lead to circular deadlocks!

That's rubbish.  The lock analyser is not intelligent enough for
ntfs...  )-:

FWIW it appears to be picking up that locks depend on each other even
when they relate to different inodes which means that they do not depend
on each other.  It perhaps is getting confused by the special case for
the table of inodes ($MFT) which has the lock dependency reverse to all
other inodes but it is special because it can never take the lock
recursively (and hence deadlock) because we always keep the whole
runlist for $MFT in memory and should a bug or memory corruption cause
this not to be the case then ntfs will detect this and go BUG() so it
still will not deadlock...

The people responsible for the lock analyser will need to fix this in
their code or by adding some magic to ntfs to make the errors go away...

Best regards,

	Anton

> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&rl->lock){----}:
>        [<c012ec64>] lock_acquire+0x58/0x74
>        [<f8a97619>] ntfs_readpage+0x362/0x8fd [ntfs]
>        [<c01415b0>] read_cache_page+0x8c/0x137
>        [<f8a9eeb8>] map_mft_record+0xd7/0x1d2 [ntfs]
>        [<f8a9d661>] ntfs_read_locked_inode+0x74/0xea9 [ntfs]
>        [<f8a9eabb>] ntfs_read_inode_mount+0x625/0x846 [ntfs]
>        [<f8aa2ff8>] ntfs_fill_super+0x8ca/0xd14 [ntfs]
>        [<c01647c4>] get_sb_bdev+0xed/0x14e
>        [<f8aa15ef>] ntfs_get_sb+0x10/0x12 [ntfs]
>        [<c0163c11>] vfs_kern_mount+0x76/0x143
>        [<c0163d17>] do_kern_mount+0x29/0x3d
>        [<c0177f9f>] do_mount+0x78a/0x7e4
>        [<c0178058>] sys_mount+0x5f/0x91
>        [<c031fb5d>] sysenter_past_esp+0x56/0x8d
> 
> -> #0 (&ni->mrec_lock){--..}:
>        [<c012ec64>] lock_acquire+0x58/0x74
>        [<c031e321>] __mutex_lock_slowpath+0xa7/0x21d
>        [<c031e4b8>] mutex_lock+0x21/0x24
>        [<f8a9edfa>] map_mft_record+0x19/0x1d2 [ntfs]
>        [<f8a98630>] ntfs_map_runlist_nolock+0x48/0x437 [ntfs]
>        [<f8a98eaa>] ntfs_map_runlist+0x87/0xb5 [ntfs]
>        [<f8a97739>] ntfs_readpage+0x482/0x8fd [ntfs]
>        [<c01415b0>] read_cache_page+0x8c/0x137
>        [<f8aa20bc>] load_system_files+0x155/0x7c7 [ntfs]
>        [<f8aa30a7>] ntfs_fill_super+0x979/0xd14 [ntfs]
>        [<c01647c4>] get_sb_bdev+0xed/0x14e
>        [<f8aa15ef>] ntfs_get_sb+0x10/0x12 [ntfs]
>        [<c0163c11>] vfs_kern_mount+0x76/0x143
>        [<c0163d17>] do_kern_mount+0x29/0x3d
>        [<c0177f9f>] do_mount+0x78a/0x7e4
>        [<c0178058>] sys_mount+0x5f/0x91
>        [<c031fb5d>] sysenter_past_esp+0x56/0x8d
> 
> other info that might help us debug this:
> 
> 2 locks held by mount/1219:
>  #0:  (&s->s_umount#18){--..}, at: [<c0164443>] sget+0x223/0x3a1
>  #1:  (&rl->lock){----}, at: [<f8a98e4d>] ntfs_map_runlist+0x2a/0xb5 [ntfs]
> 
> stack backtrace:
>  [<c0103924>] show_trace_log_lvl+0x54/0xfd
>  [<c01049a9>] show_trace+0xd/0x10
>  [<c01049c3>] dump_stack+0x17/0x1c
>  [<c012cefb>] print_circular_bug_tail+0x59/0x64
>  [<c012e766>] __lock_acquire+0x7c2/0x97a
>  [<c012ec64>] lock_acquire+0x58/0x74
>  [<c031e321>] __mutex_lock_slowpath+0xa7/0x21d
>  [<c031e4b8>] mutex_lock+0x21/0x24
>  [<f8a9edfa>] map_mft_record+0x19/0x1d2 [ntfs]
>  [<f8a98630>] ntfs_map_runlist_nolock+0x48/0x437 [ntfs]
>  [<f8a98eaa>] ntfs_map_runlist+0x87/0xb5 [ntfs]
>  [<f8a97739>] ntfs_readpage+0x482/0x8fd [ntfs]
>  [<c01415b0>] read_cache_page+0x8c/0x137
>  [<f8aa20bc>] load_system_files+0x155/0x7c7 [ntfs]
>  [<f8aa30a7>] ntfs_fill_super+0x979/0xd14 [ntfs]
>  [<c01647c4>] get_sb_bdev+0xed/0x14e
>  [<f8aa15ef>] ntfs_get_sb+0x10/0x12 [ntfs]
>  [<c0163c11>] vfs_kern_mount+0x76/0x143
>  [<c0163d17>] do_kern_mount+0x29/0x3d
>  [<c0177f9f>] do_mount+0x78a/0x7e4
>  [<c0178058>] sys_mount+0x5f/0x91
>  [<c031fb5d>] sysenter_past_esp+0x56/0x8d
> NTFS volume version 3.1.

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

