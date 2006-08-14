Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWHNBvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWHNBvL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWHNBvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:51:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55937 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751176AbWHNBvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:51:09 -0400
Date: Sun, 13 Aug 2006 18:51:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, sfrench@samba.org,
       Anton Altaparmakov <aia21@cantab.net>
Subject: Re: CIFS & Lockdep warnings
Message-Id: <20060813185102.e01898b9.akpm@osdl.org>
In-Reply-To: <20060814010503.2932.qmail@web52605.mail.yahoo.com>
References: <20060814010503.2932.qmail@web52605.mail.yahoo.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 11:05:03 +1000 (EST)
Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au> wrote:

> This is observed on 2.6.18-rc4 on SUSE 10.1 x86 on
> P-IV. The volume is question was mounted from a
> Windows 2003 server.
> 
> =======================================================
> [ INFO: possible circular locking dependency detected
> ]
> -------------------------------------------------------
> cp/11790 is trying to acquire lock:
>  (iprune_mutex){--..}, at: [<c029e364>]
> mutex_lock+0x19/0x20
> 
> but task is already holding lock:
>  (&inode->i_mutex){--..}, at: [<c029e364>]
> mutex_lock+0x19/0x20
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&inode->i_mutex){--..}:
>        [<c012a1c0>] lock_acquire+0x56/0x73
>        [<c029e205>] __mutex_lock_slowpath+0xa6/0x1ec
>        [<c029e364>] mutex_lock+0x19/0x20
>        [<e3cd2b7a>] ntfs_put_inode+0x3e/0x79 [ntfs]
>        [<c0169ac1>] iput+0x33/0x70
>        [<c017738e>] inotify_unmount_inodes+0x12e/0x15f
>        [<c016a55c>] invalidate_inodes+0x38/0xd1
>        [<c01599b3>] generic_shutdown_super+0x5a/0x108
>        [<c0159a81>] kill_block_super+0x20/0x36
>        [<c0159b56>] deactivate_super+0x61/0x78
>        [<c016c561>] mntput_no_expire+0x44/0x78
>        [<c015f536>] path_release_on_umount+0x16/0x1d
>        [<c016d692>] sys_umount+0x1d2/0x208
>        [<c016d6d5>] sys_oldumount+0xd/0xf
>        [<c0102cfb>] syscall_call+0x7/0xb

NTFS takes i_mutex inside iprune_mutex.  NTFS _should_ be deadlocking
because of this (iprune_mutex nests inside i_mutex on the write() path) but
somehow it gets away with it.

> -> #0 (iprune_mutex){--..}:
>        [<c012a1c0>] lock_acquire+0x56/0x73
>        [<c029e205>] __mutex_lock_slowpath+0xa6/0x1ec
>        [<c029e364>] mutex_lock+0x19/0x20
>        [<c016a3a2>] shrink_icache_memory+0x33/0x1b5
>        [<c0142b56>] shrink_slab+0xce/0x125
>        [<c0143385>] try_to_free_pages+0x125/0x1cc
>        [<c013f8a8>] __alloc_pages+0x184/0x26d
>        [<c013ca52>]
> generic_file_buffered_write+0x15a/0x53d
>        [<c013d175>]
> __generic_file_aio_write_nolock+0x340/0x38d
>        [<c013d223>] generic_file_aio_write+0x61/0xb3
>        [<e3d8a326>] cifs_file_aio_write+0x23/0x43
> [cifs]
>        [<c0153bb3>] do_sync_write+0x9d/0xce
>        [<c0154437>] vfs_write+0xaa/0x14e
>        [<c015496e>] sys_write+0x3a/0x61
>        [<c0102cfb>] syscall_call+0x7/0xb

CIFS takes i_prune_mutex inside i_mutex.

There's no deadlock here.  Arguably lockdep should be treating i_mutex in
filesystem A as being a different class from i_mutex from filesystem B.


